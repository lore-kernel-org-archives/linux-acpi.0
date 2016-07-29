From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPI / EC: Add PM operations to block event handling
Date: Fri, 29 Jul 2016 18:05:53 +0800
Message-ID: <cec866c5ca5143145e48e420e706656cb4b3552a.1469785918.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1469785918.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1469785918.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Originally, EC driver stops handling both events and transactions in
acpi_ec_block_transactions(), and restarts to handle transactions in
acpi_ec_unblock_transactions_early(), restarts to handle both events and
transactions in acpi_ec_unblock_transactions().

Thus, the event handling is actually stopped after the IRQ is disabled, but
the EC driver is not capable of handling SCI_EVT in noirq stage, thus it is
likely the event is not detected by the EC driver.

This patch tries to restore the old behavior for the EC driver. However,
do we actually need to handle EC events during suspend/resume stage? EC
events are mostly useless for the suspend/resume period (key strokes and
battery/thermal updates, etc.,), and the useful ones (lid close,
power/sleep button press) should have already been delivered to OS to
trigger the power saving operations. Thus EC driver should stop handling
events during this period, just like what the EC driver does during the
boot stage. And tests show this behavior is working and can make suspend
even faster when many events is triggered during this stage (for example,
during this stage, frequently trigger wifi switches).

OTOH, delivering EC events too early may confuse drivers because when the
drivers see the events, the drivers themselves may not have been resumed.

Thus this patch implements PM hooks, stops to handle event in .suspend()
hook and restarts to handle event in .resume() hook. This is different
from the original implementation, enlarging the event handling blocking
period longer:
                        Original        Current
suspend before EC       Y               Y
suspend after EC        Y               N
suspend_late            Y               N
suspend_noirq           Y (actually N)  N
resume_noirq            Y (actually N)  N
resume_late             Y               N
resume before EC        Y               N
resume after EC         Y               Y
Since this is experimental, a boot parameter is prepared to not to
disable event handling during suspend/resume period.

By implementing .resume() hook to re-enable the event handling, the
following 2 APIs serve for the same purpose (restart transactions) and can
be combined:
acpi_ec_unblock_transactions_early()/acpi_ec_unblock_transactions().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c       |  146 ++++++++++++++++++++++++++++++++---------------
 drivers/acpi/internal.h |    1 -
 drivers/acpi/sleep.c    |    4 +-
 3 files changed, 103 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7cdcdf6..8c3034c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -104,6 +104,7 @@ enum ec_command {
 #define ACPI_EC_MAX_QUERIES	16	/* Maximum number of parallel queries */
 
 enum {
+	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
 	EC_FLAGS_GPE_HANDLER_INSTALLED,	/* GPE handler installed */
@@ -145,6 +146,10 @@ static unsigned int ec_storm_threshold  __read_mostly = 8;
 module_param(ec_storm_threshold, uint, 0644);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
 
+static bool ec_freeze_events __read_mostly = true;
+module_param(ec_freeze_events, bool, 0644);
+MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -427,13 +432,19 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
 	return true;
 }
 
+static void __acpi_ec_submit_query(struct acpi_ec *ec)
+{
+	ec_dbg_evt("Command(%s) submitted/blocked",
+		   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
+	ec->nr_pending_queries++;
+	schedule_work(&ec->work);
+}
+
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-		ec_dbg_evt("Command(%s) submitted/blocked",
-			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-		ec->nr_pending_queries++;
-		schedule_work(&ec->work);
+		if (test_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
+			__acpi_ec_submit_query(ec);
 	}
 }
 
@@ -446,6 +457,70 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 	}
 }
 
+static bool acpi_ec_query_flushed(struct acpi_ec *ec)
+{
+	bool flushed;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	flushed = !ec->nr_pending_queries;
+	spin_unlock_irqrestore(&ec->lock, flags);
+
+	return flushed;
+}
+
+/*
+ * Process _Q events that might have accumulated in the EC.
+ * Run with locked ec mutex.
+ */
+static void acpi_ec_clear(struct acpi_ec *ec)
+{
+	int i, status;
+	u8 value = 0;
+
+	for (i = 0; i < ACPI_EC_CLEAR_MAX; i++) {
+		status = acpi_ec_query(ec, &value);
+		if (status || !value)
+			break;
+	}
+	if (unlikely(i == ACPI_EC_CLEAR_MAX))
+		pr_warn("Warning: Maximum of %d stale EC events cleared\n", i);
+	else
+		pr_info("%d stale EC events cleared\n", i);
+}
+
+static void acpi_ec_disable_event(struct acpi_ec *ec, bool flushing)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	clear_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags);
+	ec_log_drv("event blocked");
+	spin_unlock_irqrestore(&ec->lock, flags);
+	if (flushing && ec_query_wq) {
+		wait_event(ec->wait, acpi_ec_query_flushed(ec));
+		flush_workqueue(ec_query_wq);
+	}
+}
+
+static void acpi_ec_enable_event(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	if (!test_and_set_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
+		ec_log_drv("event unblocked");
+	if (test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+		__acpi_ec_submit_query(ec);
+	else
+		advance_transaction(ec);
+	spin_unlock_irqrestore(&ec->lock, flags);
+
+	/* Drain additional events if hardware requires that */
+	if (EC_FLAGS_CLEAR_ON_RESUME)
+		acpi_ec_clear(ec);
+}
+
 static bool acpi_ec_guard_event(struct acpi_ec *ec)
 {
 	bool guarded = true;
@@ -832,27 +907,6 @@ acpi_handle ec_get_handle(void)
 }
 EXPORT_SYMBOL(ec_get_handle);
 
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
-
-	if (unlikely(i == ACPI_EC_CLEAR_MAX))
-		pr_warn("Warning: Maximum of %d stale EC events cleared\n", i);
-	else
-		pr_info("%d stale EC events cleared\n", i);
-}
-
 static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 {
 	unsigned long flags;
@@ -919,20 +973,6 @@ void acpi_ec_block_transactions(void)
 
 void acpi_ec_unblock_transactions(void)
 {
-	struct acpi_ec *ec = first_ec;
-
-	if (!ec)
-		return;
-
-	/* Allow transactions to be carried out again */
-	acpi_ec_start(ec, true);
-
-	if (EC_FLAGS_CLEAR_ON_RESUME)
-		acpi_ec_clear(ec);
-}
-
-void acpi_ec_unblock_transactions_early(void)
-{
 	/*
 	 * Allow transactions to happen again (this function is called from
 	 * atomic context during wakeup, so we don't need to acquire the mutex).
@@ -1234,13 +1274,13 @@ static struct acpi_ec *make_acpi_ec(void)
 
 	if (!ec)
 		return NULL;
-	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
 	mutex_init(&ec->mutex);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->lock);
 	INIT_WORK(&ec->work, acpi_ec_event_handler);
 	ec->timestamp = jiffies;
+	acpi_ec_disable_event(ec, false);
 	return ec;
 }
 
@@ -1421,11 +1461,7 @@ static int acpi_ec_add(struct acpi_device *device)
 	acpi_walk_dep_device_list(ec->handle);
 
 	/* EC is fully operational, allow queries */
-	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-
-	/* Clear stale _Q events if hardware might require that */
-	if (EC_FLAGS_CLEAR_ON_RESUME)
-		acpi_ec_clear(ec);
+	acpi_ec_enable_event(ec);
 	return ret;
 }
 
@@ -1665,10 +1701,30 @@ static int acpi_ec_resume_noirq(struct device *dev)
 	acpi_ec_leave_noirq(ec);
 	return 0;
 }
+
+static int acpi_ec_suspend(struct device *dev)
+{
+	struct acpi_ec *ec =
+		acpi_driver_data(to_acpi_device(dev));
+
+	if (ec_freeze_events)
+		acpi_ec_disable_event(ec, true);
+	return 0;
+}
+
+static int acpi_ec_resume(struct device *dev)
+{
+	struct acpi_ec *ec =
+		acpi_driver_data(to_acpi_device(dev));
+
+	acpi_ec_enable_event(ec);
+	return 0;
+}
 #endif
 
 static const struct dev_pm_ops acpi_ec_pm = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq, acpi_ec_resume_noirq)
+	SET_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend, acpi_ec_resume)
 };
 
 static int param_set_event_clearing(const char *val, struct kernel_param *kp)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 6996121..29f2063 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -189,7 +189,6 @@ int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
-void acpi_ec_unblock_transactions_early(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 9788663..deb0ff7 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -586,7 +586,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	 */
 	acpi_disable_all_gpes();
 	/* Allow EC transactions to happen. */
-	acpi_ec_unblock_transactions_early();
+	acpi_ec_unblock_transactions();
 
 	suspend_nvs_restore();
 
@@ -784,7 +784,7 @@ static void acpi_hibernation_leave(void)
 	/* Restore the NVS memory area */
 	suspend_nvs_restore();
 	/* Allow EC transactions to happen. */
-	acpi_ec_unblock_transactions_early();
+	acpi_ec_unblock_transactions();
 }
 
 static void acpi_pm_thaw(void)
-- 
1.7.10
