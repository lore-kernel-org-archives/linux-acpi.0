From: akpm@linux-foundation.org
Subject: [patch 2/5] revert "ACPI: EC: do transaction from interrupt context"
Date: Mon, 22 Sep 2008 14:37:31 -0700
Message-ID: <200809222137.m8MLbWtp031005@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59748 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753638AbYIVVie (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 17:38:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, astarikovskiy@suse.de, bzolnier@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

Revert

    commit 50c0f43ff1199bbea5f0418d40df32f4d4029b13
    Author: Andi Kleen <ak@linux.intel.com>
    Date:   Thu Sep 4 15:13:29 2008 +0200
    
        ACPI: EC: do transaction from interrupt context
        
        From: Alexey Starikovskiy <astarikovskiy@suse.de>
        
        It is easier and faster to do transaction directly from interrupt context
        rather than waking control thread.
        Also, cleaner GPE storm avoidance is implemented.
        
        AK: Merged with earlier io port patch
        
        Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
        Signed-off-by: Andi Kleen <ak@linux.intel.com>


due to a regression reported by Bart.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/ec.c |  246 ++++++++++++++++++++++++--------------------
 1 file changed, 135 insertions(+), 111 deletions(-)

diff -puN drivers/acpi/ec.c~revert-acpi-ec-do-transaction-from-interrupt-context drivers/acpi/ec.c
--- a/drivers/acpi/ec.c~revert-acpi-ec-do-transaction-from-interrupt-context
+++ a/drivers/acpi/ec.c
@@ -1,7 +1,7 @@
 /*
- *  ec.c - ACPI Embedded Controller Driver (v2.1)
+ *  ec.c - ACPI Embedded Controller Driver (v2.0)
  *
- *  Copyright (C) 2006-2008 Alexey Starikovskiy <astarikovskiy@suse.de>
+ *  Copyright (C) 2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
  *  Copyright (C) 2006 Denis Sadykov <denis.m.sadykov@intel.com>
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
@@ -26,7 +26,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-/* Uncomment next line to get verbose printout */
+/* Uncomment next line to get verbose print outs*/
 /* #define DEBUG */
 
 #include <linux/kernel.h>
@@ -65,18 +65,22 @@ enum ec_command {
 	ACPI_EC_COMMAND_QUERY = 0x84,
 };
 
+/* EC events */
+enum ec_event {
+	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
+	ACPI_EC_EVENT_IBF_0,		/* Input buffer empty */
+};
+
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
 
-#define ACPI_EC_STORM_THRESHOLD 20	/* number of false interrupts
-					   per one transaction */
-
 enum {
+	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
 	EC_FLAGS_NO_GPE,		/* Don't use GPE mode */
-	EC_FLAGS_GPE_STORM		/* GPE storm detected */
+	EC_FLAGS_RESCHEDULE_POLL	/* Re-schedule poll */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -91,14 +95,6 @@ struct acpi_ec_query_handler {
 	u8 query_bit;
 };
 
-struct transaction_data {
-	const u8 *wdata;
-	u8 *rdata;
-	u8 command;
-	u8 wlen;
-	u8 rlen;
-};
-
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long gpe;
@@ -109,7 +105,7 @@ static struct acpi_ec {
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
-	struct transaction_data t;
+	struct delayed_work work;
 	atomic_t irq_count;
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
@@ -169,60 +165,69 @@ static inline void acpi_ec_write_data(st
 	outb(data, ec->data_addr);
 }
 
-static int ec_transaction_done(struct acpi_ec *ec) {
-	if (!ec->t.command)
-		return 1;
-	if (!ec->t.wlen && !ec->t.rlen)
-		return 1;
+static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
+{
+	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
+		return 0;
+	if (event == ACPI_EC_EVENT_OBF_1) {
+		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
+			return 1;
+	} else if (event == ACPI_EC_EVENT_IBF_0) {
+		if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
+			return 1;
+	}
+
 	return 0;
 }
 
-static void gpe_transaction(struct acpi_ec *ec, u8 status)
+static void ec_schedule_ec_poll(struct acpi_ec *ec)
 {
-	if (!ec->t.command)
-		return;
-	if (ec->t.wlen > 0) {
-		if ((status & ACPI_EC_FLAG_IBF) == 0) {
-			acpi_ec_write_data(ec, *(ec->t.wdata++));
-			--ec->t.wlen;
-		} else
-			/* false interrupt, state didn't change */
-			atomic_inc(&ec->irq_count);
-
-	} else if (ec->t.rlen > 0) {
-		if ((status & ACPI_EC_FLAG_OBF) == 1) {
-			*(ec->t.rdata++) = acpi_ec_read_data(ec);
-			--ec->t.rlen;
-		} else
-			/* false interrupt, state didn't change */
-			atomic_inc(&ec->irq_count);
-	}
+	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
+		schedule_delayed_work(&ec->work,
+				      msecs_to_jiffies(ACPI_EC_DELAY));
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec)
+static void ec_switch_to_poll_mode(struct acpi_ec *ec)
 {
-	if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
-			       msecs_to_jiffies(ACPI_EC_DELAY)))
-		return 0;
-	/* missing GPEs, switch back to poll mode */
-	if (printk_ratelimit())
-		pr_info(PREFIX "missing confirmations, "
-				"switch off interrupt mode.\n");
 	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-	return 1;
+	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 }
 
-static void acpi_ec_gpe_query(void *ec_cxt);
-
-static int ec_check_sci(struct acpi_ec *ec, u8 state)
+static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			return acpi_os_execute(OSL_EC_BURST_HANDLER,
-				acpi_ec_gpe_query, ec);
+	atomic_set(&ec->irq_count, 0);
+	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
+	    likely(!force_poll)) {
+		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
+				       msecs_to_jiffies(ACPI_EC_DELAY)))
+			return 0;
+		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		if (acpi_ec_check_status(ec, event)) {
+			/* missing GPEs, switch back to poll mode */
+			if (printk_ratelimit())
+				pr_info(PREFIX "missing confirmations, "
+						"switch off interrupt mode.\n");
+			ec_switch_to_poll_mode(ec);
+			ec_schedule_ec_poll(ec);
+			return 0;
+		}
+	} else {
+		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		while (time_before(jiffies, delay)) {
+			if (acpi_ec_check_status(ec, event))
+				return 0;
+			msleep(1);
+		}
+		if (acpi_ec_check_status(ec,event))
+			return 0;
 	}
-	return 0;
+	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
+		acpi_ec_read_status(ec),
+		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
+	return -ETIME;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
@@ -230,53 +235,45 @@ static int acpi_ec_transaction_unlocked(
 					u8 * rdata, unsigned rdata_len,
 					int force_poll)
 {
-	unsigned long delay;
+	int result = 0;
+	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	pr_debug(PREFIX "transaction start\n");
-	/* disable GPE during transaction if storm is detected */
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-		clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	}
-	atomic_set(&ec->irq_count, 0);
-	/* fill in transaction structure */
-	ec->t.wdata = wdata;
-	ec->t.wlen = wdata_len;
-	ec->t.rdata = rdata;
-	ec->t.rlen = rdata_len;
-	/* start transaction */
 	acpi_ec_write_cmd(ec, command);
-	/* if we selected poll mode or failed in GPE-mode do a poll loop */
-	if (force_poll ||
-	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
-	    acpi_ec_wait(ec)) {
-		delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-		while (time_before(jiffies, delay)) {
-			gpe_transaction(ec, acpi_ec_read_status(ec));
-			msleep(1);
-			if (ec_transaction_done(ec))
-				goto end;
+	for (; wdata_len > 0; --wdata_len) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
+		if (result) {
+			pr_err(PREFIX
+			       "write_cmd timeout, command = %d\n", command);
+			goto end;
 		}
+		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		acpi_ec_write_data(ec, *(wdata++));
 	}
-end:
-	pr_debug(PREFIX "transaction end\n");
-	ec->t.command = 0;
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		/* check if we received SCI during transaction */
-		ec_check_sci(ec, acpi_ec_read_status(ec));
-		/* it is safe to enable GPE outside of transaction */
-		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-		   atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD)
-		pr_debug(PREFIX "GPE storm detected\n");
-		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
-	return 0;
-}
 
-static int ec_check_ibf0(struct acpi_ec *ec)
-{
-	u8 status = acpi_ec_read_status(ec);
-	return (status & ACPI_EC_FLAG_IBF) == 0;
+	if (!rdata_len) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
+		if (result) {
+			pr_err(PREFIX
+			       "finish-write timeout, command = %d\n", command);
+			goto end;
+		}
+	} else if (command == ACPI_EC_COMMAND_QUERY)
+		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+
+	for (; rdata_len > 0; --rdata_len) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
+		if (result) {
+			pr_err(PREFIX "read timeout, command = %d\n", command);
+			goto end;
+		}
+		/* Don't expect GPE after last read */
+		if (rdata_len > 1)
+			set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		*(rdata++) = acpi_ec_read_data(ec);
+	}
+      end:
+	pr_debug(PREFIX "transaction end\n");
+	return result;
 }
 
 static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
@@ -302,8 +299,8 @@ static int acpi_ec_transaction(struct ac
 		}
 	}
 
-	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
-				msecs_to_jiffies(ACPI_EC_DELAY))) {
+	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
+	if (status) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
 		goto end;
@@ -440,7 +437,6 @@ static int acpi_ec_query(struct acpi_ec 
 	 */
 
 	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1, 0);
-	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	if (result)
 		return result;
 
@@ -519,17 +515,24 @@ static u32 acpi_ec_gpe_handler(void *dat
 {
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = data;
-	u8 state;
+	u8 state = acpi_ec_read_status(ec);
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	state = acpi_ec_read_status(ec);
-
-	gpe_transaction(ec, state);
-	if ((status & ACPI_EC_FLAG_IBF) == 0)
+	atomic_inc(&ec->irq_count);
+	if (atomic_read(&ec->irq_count) > 5) {
+		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
+		ec_switch_to_poll_mode(ec);
+		goto end;
+	}
+	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
 
-	status = ec_check_sci(ec, state);
-	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+	if (state & ACPI_EC_FLAG_SCI) {
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
+				acpi_ec_gpe_query, ec);
+	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
 		   in_interrupt()) {
 		/* this is non-query, must be confirmation */
@@ -537,11 +540,21 @@ static u32 acpi_ec_gpe_handler(void *dat
 			pr_info(PREFIX "non-query interrupt received,"
 				" switching to interrupt mode\n");
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
+end:
+	ec_schedule_ec_poll(ec);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
+static void do_ec_poll(struct work_struct *work)
+{
+	struct acpi_ec *ec = container_of(work, struct acpi_ec, work.work);
+	atomic_set(&ec->irq_count, 0);
+	(void)acpi_ec_gpe_handler(ec);
+}
+
 /* --------------------------------------------------------------------------
                              Address Space Management
    -------------------------------------------------------------------------- */
@@ -683,6 +696,7 @@ static struct acpi_ec *make_acpi_ec(void
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
+	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
 	atomic_set(&ec->irq_count, 0);
 	return ec;
 }
@@ -722,8 +736,15 @@ ec_parse_device(acpi_handle handle, u32 
 	return AE_CTRL_TERMINATE;
 }
 
+static void ec_poll_stop(struct acpi_ec *ec)
+{
+	clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
+	cancel_delayed_work(&ec->work);
+}
+
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	ec_poll_stop(ec);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
@@ -828,12 +849,14 @@ static int ec_install_handlers(struct ac
 	if (ec->handlers_installed)
 		return 0;
 	status = acpi_install_gpe_handler(NULL, ec->gpe,
-				  ACPI_GPE_EDGE_TRIGGERED,
-				  &acpi_ec_gpe_handler, ec);
+					  ACPI_GPE_EDGE_TRIGGERED,
+					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
+
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -864,6 +887,7 @@ static int acpi_ec_start(struct acpi_dev
 
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	ec_schedule_ec_poll(ec);
 	return ret;
 }
 
_
