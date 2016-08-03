From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 1/5] ACPI / EC: Add EC_FLAGS_QUERY_ENABLED to reveal a hidden logic
Date: Wed,  3 Aug 2016 16:01:24 +0800
Message-ID: <d93a86d21c6f71ec7d7488128519746777327f8d.1470205312.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1470205312.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470205312.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There is a hidden logic in the EC driver:
1. During boot, EC_FLAGS_QUERY_PENDING is responsible for blocking event
   handling;
2. During suspend, EC_FLAGS_STARTED is responsible for blocking event
   handling.
This patch uses a new EC_FLAGS_QUERY_ENABLED flag to make this hidden
logic explicit and have code cleaned up. No functional change.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c |  103 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 6f6c7d1..4ab34d7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -104,6 +104,7 @@ enum ec_command {
 #define ACPI_EC_MAX_QUERIES	16	/* Maximum number of parallel queries */
 
 enum {
+	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
 	EC_FLAGS_GPE_HANDLER_INSTALLED,	/* GPE handler installed */
@@ -239,6 +240,22 @@ static bool acpi_ec_started(struct acpi_ec *ec)
 	       !test_bit(EC_FLAGS_STOPPED, &ec->flags);
 }
 
+static bool acpi_ec_event_enabled(struct acpi_ec *ec)
+{
+	/*
+	 * There is an OSPM early stage logic. During the early stages
+	 * (boot/resume), OSPMs shouldn't enable the event handling, only
+	 * the EC transactions are allowed to be performed.
+	 */
+	if (!test_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
+		return false;
+	/*
+	 * The EC event handling is automatically disabled as soon as the
+	 * EC driver is stopped.
+	 */
+	return test_bit(EC_FLAGS_STARTED, &ec->flags);
+}
+
 static bool acpi_ec_flushed(struct acpi_ec *ec)
 {
 	return ec->reference_count == 1;
@@ -429,7 +446,8 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
 
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
-	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+	if (acpi_ec_event_enabled(ec) &&
+	    !test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 		ec->nr_pending_queries++;
@@ -446,6 +464,52 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 	}
 }
 
+static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
+{
+	if (!test_and_set_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
+		ec_log_drv("event unblocked");
+}
+
+static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
+{
+	if (test_and_clear_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
+		ec_log_drv("event blocked");
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
+static void acpi_ec_enable_event(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	if (acpi_ec_started(ec))
+		__acpi_ec_enable_event(ec);
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
@@ -832,27 +896,6 @@ acpi_handle ec_get_handle(void)
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
@@ -864,7 +907,8 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		if (!resuming) {
 			acpi_ec_submit_request(ec);
 			ec_dbg_ref(ec, "Increase driver");
-		}
+		} else
+			__acpi_ec_enable_event(ec);
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
@@ -896,7 +940,8 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		if (!suspending) {
 			acpi_ec_complete_request(ec);
 			ec_dbg_ref(ec, "Decrease driver");
-		}
+		} else
+			__acpi_ec_disable_event(ec);
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
 		ec_log_drv("EC stopped");
@@ -927,8 +972,7 @@ void acpi_ec_unblock_transactions(void)
 	/* Allow transactions to be carried out again */
 	acpi_ec_start(ec, true);
 
-	if (EC_FLAGS_CLEAR_ON_RESUME)
-		acpi_ec_clear(ec);
+	acpi_ec_enable_event(ec);
 }
 
 void acpi_ec_unblock_transactions_early(void)
@@ -1234,7 +1278,6 @@ static struct acpi_ec *make_acpi_ec(void)
 
 	if (!ec)
 		return NULL;
-	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
 	mutex_init(&ec->mutex);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
@@ -1421,11 +1464,7 @@ static int acpi_ec_add(struct acpi_device *device)
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
 
-- 
1.7.10
