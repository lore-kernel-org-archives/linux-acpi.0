From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: the errors about two EC patches
Date: Wed, 10 Sep 2008 16:37:40 +0400
Message-ID: <48C7BF94.6010204@gmail.com>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090704040907080506040102"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:33790 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYIJMhq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Sep 2008 08:37:46 -0400
Received: by gxk9 with SMTP id 9so13423028gxk.13
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2008 05:37:44 -0700 (PDT)
In-Reply-To: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com

This is a multi-part message in MIME format.
--------------090704040907080506040102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zhao Yakui wrote:
>
>     >ACPI: EC: do transaction from interrupt context
>
>    In the above patch there exist the following problems:
>    a. In the following code the GPE_STORM bit will always be set regardless 
> of whether there exists the EC GPE storm.
>     >if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
>     >            /* check if we received SCI during transaction */
>     >           ec_check_sci(ec, acpi_ec_read_status(ec));
>     >           /* it is safe to enable GPE outside of transaction */
>     >            acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
>     >    } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
>     >               atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD)
>     >           pr_debug(PREFIX "GPE storm detected\n");
>     >           set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
>   
This problem is fixed two days ago, it is not completely fair to mention 
it here.
>     b. When EC GPE storm is detected, the EC GPE will be disabled and 
> EC will work in polling mode while doing EC transaction. In such case 
> maybe EC transaction is not finished. But when timeout happens, it 
> will still be regarded as finishing the EC transaction.
>   
Ok. Fixed, now -ETIME is returned in this case.
>        This error is related with the following source code:
>            > {
>            >    delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY); 
>  //Maybe the preemptible schedule happens here.If the current jiffies
>  is greater than the predefined jiffies after the process is returned 
> from preempt_schedule, OS will have no opportunity to do the EC transaction.
>  It means that EC transaction is not finished. But it is still regarded as 
> finishing EC transaction. It is incorrect.
>            >     while (time_before(jiffies, delay)) {
>             >            gpe_transaction(ec, acpi_ec_read_status(ec));
>             >            msleep(1);
> //as msleep is realized by using the function of schedule_timeout, 
> maybe the current jiffies is already greater than the predefined jiffies 
> before finishing EC transaction. In such case the EC transaction is
> not finished. But it is also regarded as finishing. It is incorrect.
>             >            if (ec_transaction_done(ec))
>             >                    goto end;
>             >    }
>   
ec_transaction_done() returns true only if there is finished transaction 
stored in
acpi_ec. It does not matter if it is late to check for this result from 
timeout point of view.
the same ideology was put into driver before this patch:
"ACPI: Avoid bogus EC timeout when EC is in Polling mode"
>      c. There is no detailed change log although a lot is changed.(
> Including the EC work mode, the detect mechanism of EC GPE storm). 
> It is not easy to understand.     
>
>      At the same time this commit can't handle the EC notification
> event in the following case:
>          EC GPE Interrupt storm is detected and EC GPE will be disabled
> when doing EC transaction. If EC notification event happens while doing
> EC transaction(EC GPE is disabled), the SCI_EVT bit of EC status
> register is cleared before OS issuing query command. In such case the EC
> notification event will be lost.
>   
As I said already, there is no way EC will clear SCI bit before driver 
issues
the Query command to it (thus reading the event).
Even more, this same behavior was in the driver for ages and it did
not broke once.
>   Based on the above analysis ,IMO the two patches are not appropriate.
>
>   
This is the best analysis I've seen so far :) Thanks, it is really 
entertaining.
Please use latest version next time, it is attached for your convenience.

Regards,
Alex.


--------------090704040907080506040102
Content-Type: text/x-diff;
 name="fast_transaction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fast_transaction.patch"

ACPI: EC: do transaction from interrupt context

From: Alexey Starikovskiy <astarikovskiy@suse.de>

It is easier and faster to do transaction directly from interrupt context
rather than waking control thread.
Also, cleaner GPE storm avoidance is implemented.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |  288 ++++++++++++++++++++++++++---------------------------
 1 files changed, 140 insertions(+), 148 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13593f9..504475c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1,7 +1,7 @@
 /*
- *  ec.c - ACPI Embedded Controller Driver (v2.0)
+ *  ec.c - ACPI Embedded Controller Driver (v2.1)
  *
- *  Copyright (C) 2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
+ *  Copyright (C) 2006-2008 Alexey Starikovskiy <astarikovskiy@suse.de>
  *  Copyright (C) 2006 Denis Sadykov <denis.m.sadykov@intel.com>
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
@@ -26,7 +26,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-/* Uncomment next line to get verbose print outs*/
+/* Uncomment next line to get verbose printout */
 /* #define DEBUG */
 
 #include <linux/kernel.h>
@@ -38,6 +38,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -65,22 +66,18 @@ enum ec_command {
 	ACPI_EC_COMMAND_QUERY = 0x84,
 };
 
-/* EC events */
-enum ec_event {
-	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
-	ACPI_EC_EVENT_IBF_0,		/* Input buffer empty */
-};
-
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
 
+#define ACPI_EC_STORM_THRESHOLD 20	/* number of false interrupts
+					   per one transaction */
+
 enum {
-	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
 	EC_FLAGS_NO_GPE,		/* Don't use GPE mode */
-	EC_FLAGS_RESCHEDULE_POLL	/* Re-schedule poll */
+	EC_FLAGS_GPE_STORM		/* GPE storm detected */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -95,6 +92,14 @@ struct acpi_ec_query_handler {
 	u8 query_bit;
 };
 
+struct transaction_data {
+	const u8 *wdata;
+	u8 *rdata;
+	u8 command;
+	u8 wlen;
+	u8 rlen;
+};
+
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long gpe;
@@ -105,7 +110,8 @@ static struct acpi_ec {
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
-	struct delayed_work work;
+	struct transaction_data t;
+	spinlock_t spinlock;
 	atomic_t irq_count;
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
@@ -150,13 +156,26 @@ static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
 	u8 x = inb(ec->data_addr);
 	pr_debug(PREFIX "---> data = 0x%2.2x\n", x);
-	return inb(ec->data_addr);
+	return x;
 }
 
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
+	unsigned long flags;
 	pr_debug(PREFIX "<--- command = 0x%2.2x\n", command);
-	outb(command, ec->command_addr);
+	spin_lock_irqsave(&ec->spinlock, flags);
+	outb((ec->t.command = command), ec->command_addr);
+	spin_unlock_irqrestore(&ec->spinlock, flags);
+}
+
+static inline u8 ec_read_command(struct acpi_ec *ec)
+{
+	unsigned long flags;
+	u8 cmd;
+	spin_lock_irqsave(&ec->spinlock, flags);
+	cmd = ec->t.command;
+	spin_unlock_irqrestore(&ec->spinlock, flags);
+	return cmd;
 }
 
 static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
@@ -165,69 +184,61 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 	outb(data, ec->data_addr);
 }
 
-static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
+static int ec_transaction_done(struct acpi_ec *ec)
 {
-	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
-		return 0;
-	if (event == ACPI_EC_EVENT_OBF_1) {
-		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
-			return 1;
-	} else if (event == ACPI_EC_EVENT_IBF_0) {
-		if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
-			return 1;
-	}
-
+	if (!ec_read_command(ec))
+		return 1;
+	if (!ec->t.wlen && !ec->t.rlen)
+		return 1;
 	return 0;
 }
 
-static void ec_schedule_ec_poll(struct acpi_ec *ec)
+static void gpe_transaction(struct acpi_ec *ec, u8 status)
 {
-	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
-		schedule_delayed_work(&ec->work,
-				      msecs_to_jiffies(ACPI_EC_DELAY));
+	if (!ec_read_command(ec))
+		return;
+	if (ec->t.wlen > 0) {
+		if ((status & ACPI_EC_FLAG_IBF) == 0) {
+			acpi_ec_write_data(ec, *(ec->t.wdata++));
+			--ec->t.wlen;
+		} else
+			/* false interrupt, state didn't change */
+			atomic_inc(&ec->irq_count);
+
+	} else if (ec->t.rlen > 0) {
+		if ((status & ACPI_EC_FLAG_OBF) == 1) {
+			*(ec->t.rdata++) = acpi_ec_read_data(ec);
+			--ec->t.rlen;
+		} else
+			/* false interrupt, state didn't change */
+			atomic_inc(&ec->irq_count);
+	}
 }
 
-static void ec_switch_to_poll_mode(struct acpi_ec *ec)
+static int acpi_ec_wait(struct acpi_ec *ec)
 {
+	if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
+			       msecs_to_jiffies(ACPI_EC_DELAY)))
+		return 0;
+	/* missing GPEs, switch back to poll mode */
+	if (printk_ratelimit())
+		pr_info(PREFIX "missing confirmations, "
+				"switch off interrupt mode.\n");
 	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
+	return 1;
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
+static void acpi_ec_gpe_query(void *ec_cxt);
+
+static int ec_check_sci(struct acpi_ec *ec, u8 state)
 {
-	atomic_set(&ec->irq_count, 0);
-	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
-	    likely(!force_poll)) {
-		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
-				       msecs_to_jiffies(ACPI_EC_DELAY)))
-			return 0;
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		if (acpi_ec_check_status(ec, event)) {
-			/* missing GPEs, switch back to poll mode */
-			if (printk_ratelimit())
-				pr_info(PREFIX "missing confirmations, "
-						"switch off interrupt mode.\n");
-			ec_switch_to_poll_mode(ec);
-			ec_schedule_ec_poll(ec);
-			return 0;
-		}
-	} else {
-		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		while (time_before(jiffies, delay)) {
-			if (acpi_ec_check_status(ec, event))
-				return 0;
-			msleep(1);
-		}
-		if (acpi_ec_check_status(ec,event))
-			return 0;
+	if (state & ACPI_EC_FLAG_SCI) {
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+			return acpi_os_execute(OSL_EC_BURST_HANDLER,
+				acpi_ec_gpe_query, ec);
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
-		acpi_ec_read_status(ec),
-		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
-	return -ETIME;
+	return 0;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
@@ -235,45 +246,56 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					u8 * rdata, unsigned rdata_len,
 					int force_poll)
 {
-	int result = 0;
-	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+	unsigned long delay;
+	int ret = 0;
 	pr_debug(PREFIX "transaction start\n");
-	acpi_ec_write_cmd(ec, command);
-	for (; wdata_len > 0; --wdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
-		if (result) {
-			pr_err(PREFIX
-			       "write_cmd timeout, command = %d\n", command);
-			goto end;
-		}
-		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		acpi_ec_write_data(ec, *(wdata++));
+	/* disable GPE during transaction if storm is detected */
+	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		set_bit(EC_FLAGS_NO_GPE, &ec->flags);
+		clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+		acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	}
-
-	if (!rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
-		if (result) {
-			pr_err(PREFIX
-			       "finish-write timeout, command = %d\n", command);
-			goto end;
-		}
-	} else if (command == ACPI_EC_COMMAND_QUERY)
-		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-
-	for (; rdata_len > 0; --rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
-		if (result) {
-			pr_err(PREFIX "read timeout, command = %d\n", command);
-			goto end;
+	atomic_set(&ec->irq_count, 0);
+	/* fill in transaction structure */
+	ec->t.wdata = wdata;
+	ec->t.wlen = wdata_len;
+	ec->t.rdata = rdata;
+	ec->t.rlen = rdata_len;
+	/* start transaction */
+	acpi_ec_write_cmd(ec, command);
+	/* if we selected poll mode or failed in GPE-mode do a poll loop */
+	if (force_poll ||
+	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
+	    acpi_ec_wait(ec)) {
+		delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+		while (time_before(jiffies, delay)) {
+			gpe_transaction(ec, acpi_ec_read_status(ec));
+			msleep(1);
+			if (ec_transaction_done(ec))
+				goto end;
 		}
-		/* Don't expect GPE after last read */
-		if (rdata_len > 1)
-			set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		*(rdata++) = acpi_ec_read_data(ec);
+		ret = -ETIME;
 	}
-      end:
+end:
 	pr_debug(PREFIX "transaction end\n");
-	return result;
+	ec->t.command = 0;
+	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		/* check if we received SCI during transaction */
+		ec_check_sci(ec, acpi_ec_read_status(ec));
+		/* it is safe to enable GPE outside of transaction */
+		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+		   atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD) {
+		pr_debug(PREFIX "GPE storm detected\n");
+		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
+	}
+	return ret;
+}
+
+static int ec_check_ibf0(struct acpi_ec *ec)
+{
+	u8 status = acpi_ec_read_status(ec);
+	return (status & ACPI_EC_FLAG_IBF) == 0;
 }
 
 static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
@@ -283,40 +305,34 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 {
 	int status;
 	u32 glk;
-
 	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
 		return -EINVAL;
-
 	if (rdata)
 		memset(rdata, 0, rdata_len);
-
 	mutex_lock(&ec->lock);
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status)) {
-			mutex_unlock(&ec->lock);
-			return -ENODEV;
+			status = -ENODEV;
+			goto unlock;
 		}
 	}
-
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
-	if (status) {
+	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
+				msecs_to_jiffies(ACPI_EC_DELAY))) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
+		status = -ETIME;
 		goto end;
 	}
-
 	status = acpi_ec_transaction_unlocked(ec, command,
 					      wdata, wdata_len,
 					      rdata, rdata_len,
 					      force_poll);
-
-      end:
-
+end:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
+unlock:
 	mutex_unlock(&ec->lock);
-
 	return status;
 }
 
@@ -332,7 +348,9 @@ int acpi_ec_burst_enable(struct acpi_ec *ec)
 
 int acpi_ec_burst_disable(struct acpi_ec *ec)
 {
-	return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL, 0, NULL, 0, 0);
+	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST)?
+		acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE,
+			NULL, 0, NULL, 0, 0) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
@@ -437,6 +455,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
 	 */
 
 	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1, 0);
+	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	if (result)
 		return result;
 
@@ -515,24 +534,17 @@ static u32 acpi_ec_gpe_handler(void *data)
 {
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = data;
-	u8 state = acpi_ec_read_status(ec);
+	u8 state;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	atomic_inc(&ec->irq_count);
-	if (atomic_read(&ec->irq_count) > 5) {
-		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
-		ec_switch_to_poll_mode(ec);
-		goto end;
-	}
-	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
+	state = acpi_ec_read_status(ec);
+
+	gpe_transaction(ec, state);
+	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
 		wake_up(&ec->wait);
 
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
-				acpi_ec_gpe_query, ec);
-	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+	status = ec_check_sci(ec, state);
+	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
 		   in_interrupt()) {
 		/* this is non-query, must be confirmation */
@@ -540,21 +552,11 @@ static u32 acpi_ec_gpe_handler(void *data)
 			pr_info(PREFIX "non-query interrupt received,"
 				" switching to interrupt mode\n");
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
-end:
-	ec_schedule_ec_poll(ec);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
-static void do_ec_poll(struct work_struct *work)
-{
-	struct acpi_ec *ec = container_of(work, struct acpi_ec, work.work);
-	atomic_set(&ec->irq_count, 0);
-	(void)acpi_ec_gpe_handler(ec);
-}
-
 /* --------------------------------------------------------------------------
                              Address Space Management
    -------------------------------------------------------------------------- */
@@ -696,8 +698,8 @@ static struct acpi_ec *make_acpi_ec(void)
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
 	atomic_set(&ec->irq_count, 0);
+	spin_lock_init(&ec->spinlock);
 	return ec;
 }
 
@@ -736,15 +738,8 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
-static void ec_poll_stop(struct acpi_ec *ec)
-{
-	clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
-	cancel_delayed_work(&ec->work);
-}
-
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	ec_poll_stop(ec);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
@@ -849,14 +844,12 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	if (ec->handlers_installed)
 		return 0;
 	status = acpi_install_gpe_handler(NULL, ec->gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &acpi_ec_gpe_handler, ec);
+				  ACPI_GPE_EDGE_TRIGGERED,
+				  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
-
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -887,7 +880,6 @@ static int acpi_ec_start(struct acpi_device *device)
 
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	ec_schedule_ec_poll(ec);
 	return ret;
 }
 

--------------090704040907080506040102--
