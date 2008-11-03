From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch 3/4]  ACPI : Add some delay on some broken BIOS to
	workaround EC interrupt storm
Date: Mon, 03 Nov 2008 16:57:52 +0800
Message-ID: <1225702672.26020.55.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44405 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754777AbYKCIvB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:51:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Subject: ACPI: Add some delay on some broken BIOS to workaround EC interrupt storm
From: Zhao Yakui <yakui.zhao@intel.com>

   According to ACPI spec the EC controller uses the pulse interrupt model
to trigger EC GPE interrupt. After EC GPE interrupt is received, OS will
check the EC status and serve the EC GPE handler.
   But if the EC interrupt pulse is too wide on some broken BIOS, several ACPI
interrupts will be triggered although only one EC interrupt pulse is generated.
Maybe on some laptops the issue will be worse.
   If the EC GPE is still enabled while EC GPE storm happens, maybe OS will
check the EC status at very high frequency in EC GPE handler. In such case it
will cause that the keystrobe is lost and the system can't work well.
   For example:
	http://bugzilla.kernel.org/show_bug.cgi?id=9998
   
   Maybe it will be appropriate that some delay is added in the EC GPE handler
on some broken BIOS.
   The delay won't be added for most laptops.Only when more than five
interrupts happen in the same jiffies and EC status are the same, OS will add
some delay in the EC GPE handler. If the same issue still happens after adding
delay,the delay time will be increased.But the max delay time is ten
microseconds.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -75,6 +75,9 @@ enum ec_event {
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
 
+#define EC_IRQ_NUM 		5	/* the EC interrupt storm threshold */
+#define EC_MAX_UDELAY		10	/* the max udelay time */
+
 #define ACPI_EC_STORM_THRESHOLD 20	/* number of false interrupts
 					   per one transaction */
 
@@ -118,11 +121,21 @@ static struct acpi_ec {
 	unsigned long data_addr;
 	unsigned long global_lock;
 	unsigned long flags;
+	unsigned long pre_jiffies;
+	/* record the jiffies when last EC interrupt happens */
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct transaction *curr;
 	spinlock_t curr_lock;
+	u8 pre_state;
+	/* record the EC status when last EC interrrupt happens */
+	atomic_t ec_irq_count;
+	unsigned long udelay;
+	/*
+	 * this is for the input parameter of udelay in EC GPE interrupt.
+	 * the max value is IRQ_MAX_UDELAY.(10)
+	 */
 } *boot_ec, *first_ec;
 
 /* 
@@ -613,6 +626,53 @@ static void acpi_ec_gpe_query(void *ec_c
 	}
 	mutex_unlock(&ec->lock);
 }
+/*******************************************************************************
+*
+* FUNCTION:	acpi_ec_gpe_delay
+*
+* PARAMETERS:	struct acpi_ec *ec, the EC device
+		u8 state  - the EC status when EC GPE interrupt happens
+
+* RETURN:	No
+*
+* DESCRIPTION: detect whether there exists EC GPE interrupt storm. If yes, it
+		will try to add some delay to reduce the number of EC GPE
+		interrupts.
+******************************************************************************/
+static void acpi_ec_gpe_delay(struct acpi_ec *ec, u8 state)
+{
+	static int warn_done;
+	if ((jiffies == ec->pre_jiffies) && (state == ec->pre_state)) {
+		atomic_inc(&ec->ec_irq_count);
+		if (atomic_read(&ec->ec_irq_count) > EC_IRQ_NUM) {
+			/*
+			 * If the ec_irq_count is above EC_IRQ_NUM, it will
+			 * be regarded as EC GPE interrupt storm. We will
+			 * try to add some udelay in acpi_ec_gpe_delay.
+			 */
+			atomic_set(&ec->ec_irq_count, 0);
+			if (ec->udelay > EC_MAX_UDELAY) {
+				if (!warn_done) {
+					printk(KERN_WARNING "EC GPE interrupt"
+					" storm. And it is hardware issue\n");
+					warn_done++;
+				}
+			} else {
+				/*
+				 * the input parameter of udelay will be
+				 * increased.
+				 */
+				ec->udelay = ec->udelay + 1;
+			}
+		}
+	} else {
+		ec->pre_jiffies = jiffies;
+		ec->pre_state = state;
+		atomic_set(&ec->ec_irq_count, 0);
+	}
+	if (ec->udelay)
+		udelay(ec->udelay);
+}
 
 static u32 acpi_ec_gpe_handler(void *data)
 {
@@ -633,6 +693,7 @@ static u32 acpi_ec_gpe_handler(void *dat
 				acpi_ec_gpe_query, ec);
 		}
 	}
+	acpi_ec_gpe_delay(ec, status);
 
 	return ACPI_SUCCESS(ec_status) ?
 			ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
@@ -790,6 +851,8 @@ static struct acpi_ec *make_acpi_ec(void
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->curr_lock);
+	ec->pre_jiffies = jiffies;
+	atomic_set(&ec->ec_irq_count, 0);
 	return ec;
 }
 


