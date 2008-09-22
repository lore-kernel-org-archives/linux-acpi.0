From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 15:49:44 +0400
Message-ID: <48D78658.2090209@gmail.com>
References: <48D695B3.5000303@tuffmail.co.uk> <48D69DC9.5060100@suse.de> <48D760A2.3030007@tuffmail.co.uk> <48D77B3C.8070103@tuffmail.co.uk> <48D7833A.9030207@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070508070901000507020507"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:19611 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYIVLvT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 07:51:19 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1291692muf.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2008 04:49:47 -0700 (PDT)
In-Reply-To: <48D7833A.9030207@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070508070901000507020507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alan,

Here are the patches. First is updated version of patch you've tried, 
second is
even more aggressive disabling of GPEs (applies on top).

Please check them.

Thanks,
Alex.

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> Alan Jenkins wrote:
>>> Alexey Starikovskiy wrote:
>>>  
>>>> Hi Alan,
>>>> That patch is old news already...
>>>> There is a new shiny one appended to 9998/10724/11549...
>>>> Please give it a try. It does disable GPE, but for very small 
>>>> duration.
>>>>     
>>> Ok.  I was put off by the noise :-).
>>>
>>> I've just tested 2.6.27-rc6 with
>>> <http://bugzilla.kernel.org/show_bug.cgi?id=9998#c81>.  It still 
>>> "drops"
>>> some events, but now it takes longer to happen.  I have to work much
>>> harder bashing the keys to reproduce it.
>>>
>>>
>>> Like before, missing an event has severe consequences.  The missed 
>>> event
>>> is buffered.  When a new event occurs, only the oldest event is removed
>>> from the buffer.  Therefore the buffer can only grow.  Eventually,
>>> something breaks.  Events stop being delivered altogether; presumably
>>> the buffer overflows.  I confirmed that this does still happen.
>>>
>>> Remember that these are the consequences of a specific EC bug.  On my
>>> EC, querying an event always clears SCI_EVT, even if there are more
>>> events pending.  It is only re-raised when a new event fires.
>>>
>>>
>>> I'll try reading the patch.  I may try capturing an EC debug log to 
>>> show
>>> how the event is dropped, but that will take time.
>>>   
>>
>> Ok, I think I've isolated the problem to a specific change.  It's our
>> good friend EC_FLAGS_QUERY_PENDING again.
>>
>> Your new patch clears the pending flag after the query transaction has
>> finished.  Previously, it was cleared as soon as the query command was
>> initiated.
>>
>> I hacked it back and it works.  Was there a specific reason for the 
>> change?
> Thanks! There was no particular reason to put it after transaction, 
> other than
> original place is gone.
>
> I'll post updated patch.
> Regards,
> Alex.
>>
>> Regards
>> Alan
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 97168d4..2078cff 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -262,6 +262,8 @@ static int acpi_ec_transaction_unlocked(struct 
>> acpi_ec *ec, u8 command,
>>      ec->t.rlen = rdata_len;
>>      /* start transaction */
>>      acpi_ec_write_cmd(ec, command);
>> +    if (command == ACPI_EC_COMMAND_QUERY)
>> +        clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>>      /* if we selected poll mode or failed in GPE-mode do a poll loop */
>>      if (force_poll ||
>>          !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
>> @@ -453,7 +455,6 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * 
>> data)
>>       */
>>  
>>      result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, 
>> &d, 1, 0);
>> -    clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>>      if (result)
>>          return result;
>>  
>>
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------070508070901000507020507
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

 drivers/acpi/ec.c |  305 +++++++++++++++++++++++++----------------------------
 1 files changed, 146 insertions(+), 159 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13593f9..91345b2 100644
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
@@ -65,22 +66,19 @@ enum ec_command {
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
+	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
+	EC_FLAGS_HANDLERS_INSTALLED	/* Handlers for GPE and OpReg are installed */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -95,6 +93,13 @@ struct acpi_ec_query_handler {
 	u8 query_bit;
 };
 
+struct transaction_data {
+	const u8 *wdata;
+	u8 *rdata;
+	u8 wlen;
+	u8 rlen;
+};
+
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long gpe;
@@ -102,12 +107,12 @@ static struct acpi_ec {
 	unsigned long data_addr;
 	unsigned long global_lock;
 	unsigned long flags;
+	unsigned long irq_count;
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
-	struct delayed_work work;
-	atomic_t irq_count;
-	u8 handlers_installed;
+	struct transaction_data *t;
+	spinlock_t spinlock;
 } *boot_ec, *first_ec;
 
 /* 
@@ -150,7 +155,7 @@ static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
 	u8 x = inb(ec->data_addr);
 	pr_debug(PREFIX "---> data = 0x%2.2x\n", x);
-	return inb(ec->data_addr);
+	return x;
 }
 
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
@@ -165,68 +170,78 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
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
-	return 0;
+	unsigned long flags;
+	int ret = 0;
+	spin_lock_irqsave(&ec->spinlock, flags);
+	if (!ec->t || (!ec->t->wlen && !ec->t->rlen))
+		ret = 1;
+	spin_unlock_irqrestore(&ec->spinlock, flags);
+	return ret;
 }
 
-static void ec_schedule_ec_poll(struct acpi_ec *ec)
+static void gpe_transaction(struct acpi_ec *ec, u8 status)
 {
-	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
-		schedule_delayed_work(&ec->work,
-				      msecs_to_jiffies(ACPI_EC_DELAY));
+	unsigned long flags;
+	spin_lock_irqsave(&ec->spinlock, flags);
+	if (!ec->t)
+		goto unlock;
+	if (ec->t->wlen > 0) {
+		if ((status & ACPI_EC_FLAG_IBF) == 0) {
+			acpi_ec_write_data(ec, *(ec->t->wdata++));
+			--ec->t->wlen;
+		} else
+			/* false interrupt, state didn't change */
+			++ec->irq_count;
+
+	} else if (ec->t->rlen > 0) {
+		if ((status & ACPI_EC_FLAG_OBF) == 1) {
+			*(ec->t->rdata++) = acpi_ec_read_data(ec);
+			--ec->t->rlen;
+		} else
+			/* false interrupt, state didn't change */
+			++ec->irq_count;
+	}
+unlock:
+	spin_unlock_irqrestore(&ec->spinlock, flags);
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
+	if (state & ACPI_EC_FLAG_SCI) {
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+			return acpi_os_execute(OSL_EC_BURST_HANDLER,
+				acpi_ec_gpe_query, ec);
+	}
+	return 0;
+}
+
+static int ec_poll(struct acpi_ec *ec)
+{
+	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+	while (time_before(jiffies, delay)) {
+		gpe_transaction(ec, acpi_ec_read_status(ec));
+		udelay(ACPI_EC_UDELAY);
+		if (ec_transaction_done(ec))
 			return 0;
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
-		acpi_ec_read_status(ec),
-		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
 	return -ETIME;
 }
 
@@ -235,45 +250,51 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					u8 * rdata, unsigned rdata_len,
 					int force_poll)
 {
-	int result = 0;
-	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+	unsigned long tmp;
+	struct transaction_data t = {.wdata = wdata, .rdata = rdata,
+				     .wlen = wdata_len, .rlen = rdata_len};
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
+	/* start transaction */
+	spin_lock_irqsave(&ec->spinlock, tmp);
+	ec->irq_count = 0;
+	/* following two actions should be kept atomic */
+	ec->t = &t;
+	acpi_ec_write_cmd(ec, command);
+	if (command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-
-	for (; rdata_len > 0; --rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
-		if (result) {
-			pr_err(PREFIX "read timeout, command = %d\n", command);
-			goto end;
-		}
-		/* Don't expect GPE after last read */
-		if (rdata_len > 1)
-			set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		*(rdata++) = acpi_ec_read_data(ec);
-	}
-      end:
+	spin_unlock_irqrestore(&ec->spinlock, tmp);
+	/* if we selected poll mode or failed in GPE-mode do a poll loop */
+	if (force_poll ||
+	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
+	    acpi_ec_wait(ec))
+		ret = ec_poll(ec);
 	pr_debug(PREFIX "transaction end\n");
-	return result;
+	spin_lock_irqsave(&ec->spinlock, tmp);
+	ec->t = NULL;
+	spin_unlock_irqrestore(&ec->spinlock, tmp);
+	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		/* check if we received SCI during transaction */
+		ec_check_sci(ec, acpi_ec_read_status(ec));
+		/* it is safe to enable GPE outside of transaction */
+		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+		   ec->irq_count > ACPI_EC_STORM_THRESHOLD) {
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
@@ -283,40 +304,34 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
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
 
@@ -332,7 +347,9 @@ int acpi_ec_burst_enable(struct acpi_ec *ec)
 
 int acpi_ec_burst_disable(struct acpi_ec *ec)
 {
-	return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL, 0, NULL, 0, 0);
+	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST)?
+		acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE,
+			NULL, 0, NULL, 0, 0) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
@@ -513,46 +530,26 @@ static void acpi_ec_gpe_query(void *ec_cxt)
 
 static u32 acpi_ec_gpe_handler(void *data)
 {
-	acpi_status status = AE_OK;
 	struct acpi_ec *ec = data;
-	u8 state = acpi_ec_read_status(ec);
+	u8 status;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	atomic_inc(&ec->irq_count);
-	if (atomic_read(&ec->irq_count) > 5) {
-		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
-		ec_switch_to_poll_mode(ec);
-		goto end;
-	}
-	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
+	status = acpi_ec_read_status(ec);
+
+	gpe_transaction(ec, status);
+	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
 		wake_up(&ec->wait);
 
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
-				acpi_ec_gpe_query, ec);
-	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
-		   in_interrupt()) {
+	ec_check_sci(ec, status);
+	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+	    !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
 		/* this is non-query, must be confirmation */
 		if (printk_ratelimit())
 			pr_info(PREFIX "non-query interrupt received,"
 				" switching to interrupt mode\n");
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
-end:
-	ec_schedule_ec_poll(ec);
-	return ACPI_SUCCESS(status) ?
-	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
-}
-
-static void do_ec_poll(struct work_struct *work)
-{
-	struct acpi_ec *ec = container_of(work, struct acpi_ec, work.work);
-	atomic_set(&ec->irq_count, 0);
-	(void)acpi_ec_gpe_handler(ec);
+	return ACPI_INTERRUPT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
@@ -696,8 +693,8 @@ static struct acpi_ec *make_acpi_ec(void)
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
-	atomic_set(&ec->irq_count, 0);
+	ec->irq_count = 0;
+	spin_lock_init(&ec->spinlock);
 	return ec;
 }
 
@@ -736,22 +733,15 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
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
 	if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler)))
 		pr_err(PREFIX "failed to remove gpe handler\n");
-	ec->handlers_installed = 0;
+	clear_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
 }
 
 static int acpi_ec_add(struct acpi_device *device)
@@ -846,17 +836,15 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 static int ec_install_handlers(struct acpi_ec *ec)
 {
 	acpi_status status;
-	if (ec->handlers_installed)
+	if (test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
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
@@ -866,7 +854,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 		return -ENODEV;
 	}
 
-	ec->handlers_installed = 1;
+	set_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags);
 	return 0;
 }
 
@@ -887,7 +875,6 @@ static int acpi_ec_start(struct acpi_device *device)
 
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	ec_schedule_ec_poll(ec);
 	return ret;
 }
 
@@ -906,7 +893,7 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 
 int __init acpi_boot_ec_enable(void)
 {
-	if (!boot_ec || boot_ec->handlers_installed)
+	if (!boot_ec || test_bit(EC_FLAGS_HANDLERS_INSTALLED, &boot_ec->flags))
 		return 0;
 	if (!ec_install_handlers(boot_ec)) {
 		first_ec = boot_ec;

--------------070508070901000507020507
Content-Type: text/x-diff;
 name="more_storm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="more_storm.patch"

ACPI: EC: disable GPE during QUERY handling too.

From: Alexey Starikovskiy <astarikovskiy@suse.de>


---

 drivers/acpi/ec.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 91345b2..a90f70c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -226,9 +226,16 @@ static void acpi_ec_gpe_query(void *ec_cxt);
 static int ec_check_sci(struct acpi_ec *ec, u8 state)
 {
 	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+			/* disable GPE until next transaction */
+			if (in_interrupt() &&
+			    test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+				clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+				acpi_disable_gpe(NULL, ec->gpe, ACPI_ISR);
+			}
 			return acpi_os_execute(OSL_EC_BURST_HANDLER,
 				acpi_ec_gpe_query, ec);
+		}
 	}
 	return 0;
 }
@@ -281,8 +288,9 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
 		/* check if we received SCI during transaction */
 		ec_check_sci(ec, acpi_ec_read_status(ec));
-		/* it is safe to enable GPE outside of transaction */
-		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+		/* we expect query, enable GPE back */
+		if (!test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+			acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   ec->irq_count > ACPI_EC_STORM_THRESHOLD) {
 		pr_debug(PREFIX "GPE storm detected\n");

--------------070508070901000507020507--
