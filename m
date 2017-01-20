From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI / EC: Use busy polling mode when GPE is not enabled
Date: Fri, 20 Jan 2017 16:42:48 +0800
Message-ID: <612656ae7bd4e24cadba99401f1b15b2d2e396d0.1484723419.git.lv.zheng@intel.com>
References: <2d2f819f331ffeffcf69c5a9b7ccea5c7eb495ba>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41881 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdATIow (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Jan 2017 03:44:52 -0500
In-Reply-To: <2d2f819f331ffeffcf69c5a9b7ccea5c7eb495ba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

When GPE is not enabled, it is not efficient to use the wait polling mode
as it introduces an unexpected scheduler delay.
So before the GPE handler is installed, this patch uses busy polling mode
for all EC(s) and the logic can be applied to non boot EC(s) during the
suspend/resume process.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=191561
Tested-by: Jakobus Schurz <jakobus.schurz@gmail.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c       | 62 ++++++++++++++++++++++++-------------------------
 drivers/acpi/internal.h |  4 ++--
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 48e19d0..22ca892 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -729,12 +729,12 @@ static void start_transaction(struct acpi_ec *ec)
 
 static int ec_guard(struct acpi_ec *ec)
 {
-	unsigned long guard = usecs_to_jiffies(ec_polling_guard);
+	unsigned long guard = usecs_to_jiffies(ec->polling_guard);
 	unsigned long timeout = ec->timestamp + guard;
 
 	/* Ensure guarding period before polling EC status */
 	do {
-		if (ec_busy_polling) {
+		if (ec->busy_polling) {
 			/* Perform busy polling */
 			if (ec_transaction_completed(ec))
 				return 0;
@@ -998,6 +998,28 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
+static void acpi_ec_enter_noirq(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	ec->busy_polling = true;
+	ec->polling_guard = 0;
+	ec_log_drv("interrupt blocked");
+	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
+static void acpi_ec_leave_noirq(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	ec->busy_polling = ec_busy_polling;
+	ec->polling_guard = ec_polling_guard;
+	ec_log_drv("interrupt unblocked");
+	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
 void acpi_ec_block_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
@@ -1278,7 +1300,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
 
-	if (ec_busy_polling || bits > 8)
+	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
 	for (i = 0; i < bytes; ++i, ++address, ++value)
@@ -1286,7 +1308,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 			acpi_ec_read(ec, address, value) :
 			acpi_ec_write(ec, address, *value);
 
-	if (ec_busy_polling || bits > 8)
+	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
 
 	switch (result) {
@@ -1329,6 +1351,8 @@ static struct acpi_ec *acpi_ec_alloc(void)
 	spin_lock_init(&ec->lock);
 	INIT_WORK(&ec->work, acpi_ec_event_handler);
 	ec->timestamp = jiffies;
+	ec->busy_polling = true;
+	ec->polling_guard = 0;
 	return ec;
 }
 
@@ -1390,6 +1414,7 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
 	acpi_ec_start(ec, false);
 
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
+		acpi_ec_enter_noirq(ec);
 		status = acpi_install_address_space_handler(ec->handle,
 							    ACPI_ADR_SPACE_EC,
 							    &acpi_ec_space_handler,
@@ -1429,6 +1454,7 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
 		/* This is not fatal as we can poll EC events */
 		if (ACPI_SUCCESS(status)) {
 			set_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags);
+			acpi_ec_leave_noirq(ec);
 			if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 			    ec->reference_count >= 1)
 				acpi_ec_enable_gpe(ec, true);
@@ -1839,34 +1865,6 @@ int __init acpi_ec_ecdt_probe(void)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static void acpi_ec_enter_noirq(struct acpi_ec *ec)
-{
-	unsigned long flags;
-
-	if (ec == first_ec) {
-		spin_lock_irqsave(&ec->lock, flags);
-		ec->saved_busy_polling = ec_busy_polling;
-		ec->saved_polling_guard = ec_polling_guard;
-		ec_busy_polling = true;
-		ec_polling_guard = 0;
-		ec_log_drv("interrupt blocked");
-		spin_unlock_irqrestore(&ec->lock, flags);
-	}
-}
-
-static void acpi_ec_leave_noirq(struct acpi_ec *ec)
-{
-	unsigned long flags;
-
-	if (ec == first_ec) {
-		spin_lock_irqsave(&ec->lock, flags);
-		ec_busy_polling = ec->saved_busy_polling;
-		ec_polling_guard = ec->saved_polling_guard;
-		ec_log_drv("interrupt unblocked");
-		spin_unlock_irqrestore(&ec->lock, flags);
-	}
-}
-
 static int acpi_ec_suspend_noirq(struct device *dev)
 {
 	struct acpi_ec *ec =
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 0c45226..219b90b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -172,8 +172,8 @@ struct acpi_ec {
 	struct work_struct work;
 	unsigned long timestamp;
 	unsigned long nr_pending_queries;
-	bool saved_busy_polling;
-	unsigned int saved_polling_guard;
+	bool busy_polling;
+	unsigned int polling_guard;
 };
 
 extern struct acpi_ec *first_ec;
-- 
2.7.4

