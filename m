From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch 1/4]  ACPI : EC transaction is explictly divided into
	several phases
Date: Mon, 03 Nov 2008 16:56:28 +0800
Message-ID: <1225702588.26020.52.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28874 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594AbYKCItg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:49:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Subject: ACPI: EC transaction is explictly divided into several phases
From: Zhao Yakui <yakui.zhao@intel.com>

   Now the EC transaction will be executed in EC GPE interrupt context on
most laptops. But for the some laptops it can't be done in EC GPE interrupt
context.So it falls back to the EC polling mode.
   Sometimes -ETIME is returned by the function of ec_poll, which
brings the following message:
    >AE_TIME, Returned by Handler for [EmbeddedControl] [20080926]
    The reason about AE_TIME is not caused by that EC controller can't update
its status in time. Instead it is caused by that host has no opportunity to issue
the sequence operation in the current flowchart. 

So the better solution is that EC transaction is still explicitly divided into
several phases and EC access is realized in process context.
	For example: EC write transaction
	a. issue EC write command
	b. wait until the input is empty and then write the internal address
	c. wait until the input is empty and write the data
	d. wait until the input is empty. If it is empty, it indicates
	that EC transaction is finished.

At the same time EC driver will be started in EC GEP mode. And when there is
no EC GPE confirmation for some EC transaction on some broken laptops,the EC
driver will be switched to polling mode. It means that it will work in polling
mode when EC internal register is accessed. But EC GPE is still enabled.

http://bugzilla.kernel.org/show_bug.cgi?id=11896
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |  271 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 171 insertions(+), 100 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -65,6 +65,11 @@ enum ec_command {
 	ACPI_EC_BURST_DISABLE = 0x83,
 	ACPI_EC_COMMAND_QUERY = 0x84,
 };
+/* EC events */
+enum ec_event {
+	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
+	ACPI_EC_EVENT_IBF_0,		/* Input buffer empty */
+};
 
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
@@ -74,6 +79,8 @@ enum ec_command {
 					   per one transaction */
 
 enum {
+	EC_FLAGS_WAIT_GPE,		/* Don't check EC status
+					 * until GPE arrives*/
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent
 					 * for status change */
@@ -210,18 +217,61 @@ unlock:
 	spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec)
+static inline int acpi_ec_check_status(struct acpi_ec *ec,
+			enum ec_event event)
 {
-	if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
-			       msecs_to_jiffies(ACPI_EC_DELAY)))
+	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
 		return 0;
-	/* missing GPEs, switch back to poll mode */
-	if (printk_ratelimit())
-		pr_info(PREFIX "missing confirmations, "
-				"switch off interrupt mode.\n");
-	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-	return 1;
+	if (event == ACPI_EC_EVENT_OBF_1) {
+		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
+			return 1;
+	} else if (event == ACPI_EC_EVENT_IBF_0) {
+		if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
+{
+	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
+	    likely(!force_poll)) {
+		if (wait_event_timeout(ec->wait,
+					acpi_ec_check_status(ec, event),
+					msecs_to_jiffies(ACPI_EC_DELAY)))
+			return 0;
+
+		/* Check whether the bogus timeout happens */
+		if (!test_bit(EC_FLAGS_WAIT_GPE, &ec->flags) &&
+			acpi_ec_check_status(ec, event))
+			return 0;
+
+		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		if (acpi_ec_check_status(ec, event)) {
+			/*
+			 * Clear GPE mode flags. When EC internal register is
+			 * accessed, EC driver will work in polling mode.
+			 * But GPE is still enabled.
+			 */
+			clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
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
+		if (acpi_ec_check_status(ec, event))
+			return 0;
+	}
+	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
+		acpi_ec_read_status(ec),
+		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
+	return -ETIME;
 }
 
 static void acpi_ec_gpe_query(void *ec_cxt);
@@ -248,48 +298,51 @@ static int ec_poll(struct acpi_ec *ec)
 	}
 	return -ETIME;
 }
-
-static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
-					struct transaction *t,
+static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
+					const u8 *wdata, unsigned wdata_len,
+					u8 *rdata, unsigned rdata_len,
 					int force_poll)
 {
-	unsigned long tmp;
-	int ret = 0;
+	int result = 0;
+	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	pr_debug(PREFIX "transaction start\n");
-	/* disable GPE during transaction if storm is detected */
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	}
-	/* start transaction */
-	spin_lock_irqsave(&ec->curr_lock, tmp);
-	/* following two actions should be kept atomic */
-	t->irq_count = 0;
-	ec->curr = t;
-	acpi_ec_write_cmd(ec, ec->curr->command);
-	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
+	acpi_ec_write_cmd(ec, command);
+	for (; wdata_len > 0; --wdata_len) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
+		if (result) {
+			pr_err(PREFIX
+			       "write_cmd timeout, command = %d\n", command);
+			goto end;
+		}
+		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		acpi_ec_write_data(ec, *(wdata++));
+	}
+
+	if (!rdata_len) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
+		if (result) {
+			pr_err(PREFIX
+			       "finish-write timeout, command = %d\n", command);
+			goto end;
+		}
+	} else if (command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	spin_unlock_irqrestore(&ec->curr_lock, tmp);
-	/* if we selected poll mode or failed in GPE-mode do a poll loop */
-	if (force_poll ||
-	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
-	    acpi_ec_wait(ec))
-		ret = ec_poll(ec);
-	pr_debug(PREFIX "transaction end\n");
-	spin_lock_irqsave(&ec->curr_lock, tmp);
-	ec->curr = NULL;
-	spin_unlock_irqrestore(&ec->curr_lock, tmp);
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		/* check if we received SCI during transaction */
-		ec_check_sci(ec, acpi_ec_read_status(ec));
-		/* it is safe to enable GPE outside of transaction */
-		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-		   t->irq_count > ACPI_EC_STORM_THRESHOLD) {
-		pr_debug(PREFIX "GPE storm detected\n");
-		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
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
+
+		*(rdata++) = acpi_ec_read_data(ec);
 	}
-	return ret;
+end:
+	pr_debug(PREFIX "transaction end\n");
+	return result;
 }
 
 static int ec_check_ibf0(struct acpi_ec *ec)
@@ -310,35 +363,47 @@ static int ec_wait_ibf0(struct acpi_ec *
 	return -ETIME;
 }
 
-static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
+static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
+			       const u8 *wdata, unsigned wdata_len,
+			       u8 *rdata, unsigned rdata_len,
 			       int force_poll)
 {
 	int status;
 	u32 glk;
-	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
+
+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
 		return -EINVAL;
-	if (t->rdata)
-		memset(t->rdata, 0, t->rlen);
+
+	if (rdata)
+		memset(rdata, 0, rdata_len);
+
 	mutex_lock(&ec->lock);
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status)) {
-			status = -ENODEV;
-			goto unlock;
+			mutex_unlock(&ec->lock);
+			return -ENODEV;
 		}
 	}
-	if (ec_wait_ibf0(ec)) {
+
+	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
+	if (status) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
-		status = -ETIME;
 		goto end;
 	}
-	status = acpi_ec_transaction_unlocked(ec, t, force_poll);
+
+	status = acpi_ec_transaction_unlocked(ec, command,
+					      wdata, wdata_len,
+					      rdata, rdata_len,
+					      force_poll);
+
 end:
+
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
-unlock:
 	mutex_unlock(&ec->lock);
+
 	return status;
 }
 
@@ -349,32 +414,35 @@ unlock:
 int acpi_ec_burst_enable(struct acpi_ec *ec)
 {
 	u8 d;
-	struct transaction t = {.command = ACPI_EC_BURST_ENABLE,
-				.wdata = NULL, .rdata = &d,
-				.wlen = 0, .rlen = 1};
-
-	return acpi_ec_transaction(ec, &t, 0);
+	/*
+	 * When burst enable command is issused, EC will put the EC burst
+	 * acknowledge byte (0x90) into output buffer.
+	 * Maybe it is worth checking the returned acknowledge bytes.
+	 */
+	return acpi_ec_transaction(ec, ACPI_EC_BURST_ENABLE, NULL, 0, &d, 1, 0);
 }
 
 int acpi_ec_burst_disable(struct acpi_ec *ec)
 {
-	struct transaction t = {.command = ACPI_EC_BURST_DISABLE,
-				.wdata = NULL, .rdata = NULL,
-				.wlen = 0, .rlen = 0};
+	u8 d = acpi_ec_read_status(ec);
+	if (d & ACPI_EC_FLAG_BURST) {
+		/*
+		 * Only when EC is in burst mode, it is necessary to disable.
+		 */
+		return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL,
+						0, NULL, 0, 0);
+	}
+	return 0;
 
-	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
-				acpi_ec_transaction(ec, &t, 0) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
 {
 	int result;
 	u8 d;
-	struct transaction t = {.command = ACPI_EC_COMMAND_READ,
-				.wdata = &address, .rdata = &d,
-				.wlen = 1, .rlen = 1};
 
-	result = acpi_ec_transaction(ec, &t, 0);
+	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_READ,
+				     &address, 1, &d, 1, 0);
 	*data = d;
 	return result;
 }
@@ -382,11 +450,8 @@ static int acpi_ec_read(struct acpi_ec *
 static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
 	u8 wdata[2] = { address, data };
-	struct transaction t = {.command = ACPI_EC_COMMAND_WRITE,
-				.wdata = wdata, .rdata = NULL,
-				.wlen = 2, .rlen = 0};
-
-	return acpi_ec_transaction(ec, &t, 0);
+	return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE,
+				   wdata, 2, NULL, 0, 0);
 }
 
 /*
@@ -448,13 +513,12 @@ int ec_transaction(u8 command,
 		   u8 * rdata, unsigned rdata_len,
 		   int force_poll)
 {
-	struct transaction t = {.command = command,
-				.wdata = wdata, .rdata = rdata,
-				.wlen = wdata_len, .rlen = rdata_len};
 	if (!first_ec)
 		return -ENODEV;
 
-	return acpi_ec_transaction(first_ec, &t, force_poll);
+	return acpi_ec_transaction(first_ec, command, wdata,
+				   wdata_len, rdata, rdata_len,
+				   force_poll);
 }
 
 EXPORT_SYMBOL(ec_transaction);
@@ -463,9 +527,7 @@ static int acpi_ec_query(struct acpi_ec 
 {
 	int result;
 	u8 d;
-	struct transaction t = {.command = ACPI_EC_COMMAND_QUERY,
-				.wdata = NULL, .rdata = &d,
-				.wlen = 0, .rlen = 1};
+
 	if (!ec || !data)
 		return -EINVAL;
 
@@ -475,7 +537,8 @@ static int acpi_ec_query(struct acpi_ec 
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
 
-	result = acpi_ec_transaction(ec, &t, 0);
+	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY,
+						NULL, 0, &d, 1, 0);
 	if (result)
 		return result;
 
@@ -553,25 +616,25 @@ static void acpi_ec_gpe_query(void *ec_c
 static u32 acpi_ec_gpe_handler(void *data)
 {
 	struct acpi_ec *ec = data;
-	u8 status;
+	u8 status ;
+	acpi_status ec_status = AE_OK;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
 	status = acpi_ec_read_status(ec);
 
-	gpe_transaction(ec, status);
-	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
+	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
 
-	ec_check_sci(ec, status);
-	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-	    !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
-		/* this is non-query, must be confirmation */
-		if (printk_ratelimit())
-			pr_info(PREFIX "non-query interrupt received,"
-				" switching to interrupt mode\n");
-		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+	if (status & ACPI_EC_FLAG_SCI) {
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+			ec_status = acpi_os_execute(OSL_EC_BURST_HANDLER,
+				acpi_ec_gpe_query, ec);
+		}
 	}
-	return ACPI_INTERRUPT_HANDLED;
+
+	return ACPI_SUCCESS(ec_status) ?
+			ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
@@ -712,6 +775,16 @@ static struct acpi_ec *make_acpi_ec(void
 	if (!ec)
 		return NULL;
 	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
+	/*
+	 * Start GPE mode.
+	 * When EC driver is started, it will work in GPE mode.
+	 * It means that the EC GPE interrupt is expected when EC status is
+	 * changed.
+	 * Of course if there is no EC GPE interrupt in some EC transaction,
+	 * it will be cleared and EC will work in polling mode when EC
+	 * internal register is accessed.
+	 */
+	set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
@@ -1004,8 +1077,6 @@ int __init acpi_ec_ecdt_probe(void)
 static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Stop using GPE */
-	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	return 0;
@@ -1014,9 +1085,9 @@ static int acpi_ec_suspend(struct acpi_d
 static int acpi_ec_resume(struct acpi_device *device)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Enable use of GPE back */
-	clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	/* Enable use of GPE back */
+	set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	return 0;
 }
 


