From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 2/4] ACPI: Simplify the switch between EC GPE
	interrupt and polling mode
Date: Thu, 25 Sep 2008 11:56:07 +0800
Message-ID: <1222314967.4023.35.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15607 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbYIYDv0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2008 23:51:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Subject: ACPI: Simplify the switch between EC GPE interrupt and polling mode
From: Zhao Yakui <yakui.zhao@intel.com>

In current kernel the EC driver will be started in polling mode. When the EC
GPE interrupt is triggered, it will be switched to EC GPE interrupt mode.
And when there is no EC GPE confirmation for some EC transaction on some broken
laptops,the EC driver will be switched to polling mode and EC GPE will be 
disabled. In such case the EC notification event will be lost.
	For example: Bug 11428/8459

But on the laptops of bug 11428/8459 the EC notification event won't be lost
if EC GPE is still enabled after switching to polling mode.

So it is necessary to simplify the EC switch. 

a.delete the mode switch from polling mode to EC GPE interrupt mode. It means
that the default mode is interrupt-driven while EC driver is started.
b.EC GPE is still enabled after switching to polling mode. Only when there is
no EC GPE interrupt in some EC transactions, the GPE mode flag will be cleared
and it will be switched to polling mode. It means that EC driver will work in
polling mode when EC internal register is accessed.But in such case EC GPE 
is still enabled. It means that the EC notification event won't be lost.

http://bugzilla.kernel.org/show_bug.cgi?id=11428

Signed-off-by:Zhao Yakui <yakui.zhao@intel.com>

---
 drivers/acpi/ec.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -203,14 +203,19 @@ static int acpi_ec_wait(struct acpi_ec *
 		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
 				       msecs_to_jiffies(ACPI_EC_DELAY)))
 			return 0;
+		/* Check whether the bogus timeout happens */
+		if (!test_bit(EC_FLAGS_WAIT_GPE, &ec->flags) &&
+			acpi_ec_check_status(ec, event))
+			return 0;
+
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 		if (acpi_ec_check_status(ec, event)) {
-			/* missing GPEs, switch back to poll mode */
-			if (printk_ratelimit())
-				pr_info(PREFIX "missing confirmations, "
-						"switch off interrupt mode.\n");
-			ec_switch_to_poll_mode(ec);
-			ec_schedule_ec_poll(ec);
+			/*
+			 * Clear GPE mode flags. When EC internal register is
+			 * accessed, EC driver will work in polling mode.
+			 * But GPE is still enabled.
+			 */
+			clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 			return 0;
 		}
 	} else {
@@ -269,6 +274,7 @@ static int acpi_ec_transaction_unlocked(
 		/* Don't expect GPE after last read */
 		if (rdata_len > 1)
 			set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+
 		*(rdata++) = acpi_ec_read_data(ec);
 	}
       end:
@@ -537,6 +543,7 @@ static u32 acpi_ec_gpe_handler(void *dat
 		ec_switch_to_poll_mode(ec);
 		goto end;
 	}
+
 	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
@@ -545,15 +552,6 @@ static u32 acpi_ec_gpe_handler(void *dat
 		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
 				acpi_ec_gpe_query, ec);
-	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
-		   in_interrupt()) {
-		/* this is non-query, must be confirmation */
-		if (printk_ratelimit())
-			pr_info(PREFIX "non-query interrupt received,"
-				" switching to interrupt mode\n");
-		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
 end:
 	ec_schedule_ec_poll(ec);
@@ -706,6 +704,16 @@ static struct acpi_ec *make_acpi_ec(void
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
@@ -749,15 +757,9 @@ ec_parse_device(acpi_handle handle, u32 
 	return AE_CTRL_TERMINATE;
 }
 
-static void ec_poll_stop(struct acpi_ec *ec)
-{
-	clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
-	cancel_delayed_work(&ec->work);
-}
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	ec_poll_stop(ec);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
@@ -900,7 +902,6 @@ static int acpi_ec_start(struct acpi_dev
 
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	ec_schedule_ec_poll(ec);
 	return ret;
 }
 
@@ -996,7 +997,6 @@ static int acpi_ec_suspend(struct acpi_d
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Stop using GPE */
-	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	return 0;
@@ -1006,8 +1006,8 @@ static int acpi_ec_resume(struct acpi_de
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Enable use of GPE back */
-	clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	return 0;
 }
 


