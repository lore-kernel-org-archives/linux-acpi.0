From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / EC: Remove old CLEAR_ON_RESUME quirk
Date: Wed,  4 Jan 2017 11:17:17 +0800
Message-ID: <4b6c094e122529f6e00a320cef0871b42bbc3376.1483430200.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18375 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762672AbdADDR0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Jan 2017 22:17:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

IRQ polling logic has been implemented to drain the post-boot/resume EC
events:
1. Triggered by the following code, invoked from acpi_ec_enable_event():
	if (!test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
		advance_transaction(ec);
2. Drained by the following code, invoked after acpi_ec_complete_query():
	if (status & ACPI_EC_FLAG_SCI)
		acpi_ec_submit_query(ec);
This facility is safer than the old CLEAR_ON_RESUME quirk as the
CLEAR_ON_RESUME quirk sends EC query commands unconditionally. The
behavior is apparently not suitable for firmware that requires
QUERY_HANDSHAKE quirk. Though the QUERY_HANDSHAKE quirk isn't used now
because of the improvement done in the EC transaction state machine
(ec_event_clearing=QUERY), it is the proof that we cannot send EC query
command unconditionally.

So it's time to delete the out-dated CLEAR_ON_RESUME quirk to let the users
to try the newer approach.

More statements can be found at Link #1.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=191211 [#1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 53 -----------------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 48e19d0..6a32cd4 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -188,7 +188,6 @@ EXPORT_SYMBOL(first_ec);
 static bool boot_ec_is_ecdt = false;
 static struct workqueue_struct *ec_query_wq;
 
-static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
 static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
 
@@ -492,26 +491,6 @@ static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
 		ec_log_drv("event blocked");
 }
 
-/*
- * Process _Q events that might have accumulated in the EC.
- * Run with locked ec mutex.
- */
-static void acpi_ec_clear(struct acpi_ec *ec)
-{
-	int i, status;
-	u8 value = 0;
-
-	for (i = 0; i < ACPI_EC_CLEAR_MAX; i++) {
-		status = acpi_ec_query(ec, &value);
-		if (status || !value)
-			break;
-	}
-	if (unlikely(i == ACPI_EC_CLEAR_MAX))
-		pr_warn("Warning: Maximum of %d stale EC events cleared\n", i);
-	else
-		pr_info("%d stale EC events cleared\n", i);
-}
-
 static void acpi_ec_enable_event(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -520,10 +499,6 @@ static void acpi_ec_enable_event(struct acpi_ec *ec)
 	if (acpi_ec_started(ec))
 		__acpi_ec_enable_event(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
-
-	/* Drain additional events if hardware requires that */
-	if (EC_FLAGS_CLEAR_ON_RESUME)
-		acpi_ec_clear(ec);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1741,31 +1716,6 @@ static int ec_flag_query_handshake(const struct dmi_system_id *id)
 #endif
 
 /*
- * On some hardware it is necessary to clear events accumulated by the EC during
- * sleep. These ECs stop reporting GPEs until they are manually polled, if too
- * many events are accumulated. (e.g. Samsung Series 5/9 notebooks)
- *
- * https://bugzilla.kernel.org/show_bug.cgi?id=44161
- *
- * Ideally, the EC should also be instructed NOT to accumulate events during
- * sleep (which Windows seems to do somehow), but the interface to control this
- * behaviour is not known at this time.
- *
- * Models known to be affected are Samsung 530Uxx/535Uxx/540Uxx/550Pxx/900Xxx,
- * however it is very likely that other Samsung models are affected.
- *
- * On systems which don't accumulate _Q events during sleep, this extra check
- * should be harmless.
- */
-static int ec_clear_on_resume(const struct dmi_system_id *id)
-{
-	pr_debug("Detected system needing EC poll on resume.\n");
-	EC_FLAGS_CLEAR_ON_RESUME = 1;
-	ec_event_clearing = ACPI_EC_EVT_TIMING_STATUS;
-	return 0;
-}
-
-/*
  * Some ECDTs contain wrong register addresses.
  * MSI MS-171F
  * https://bugzilla.kernel.org/show_bug.cgi?id=12461
@@ -1782,9 +1732,6 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
 	ec_correct_ecdt, "MSI MS-171F", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),}, NULL},
-	{
-	ec_clear_on_resume, "Samsung hardware", {
-	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
 	{},
 };
 
-- 
2.7.4

