From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI / EC: Cleanup logging/debugging splitter support.
Date: Fri, 27 Feb 2015 14:48:15 +0800
Message-ID: <79307c846d7ca93d0423829b84cb0354e276fb73.1425019470.git.lv.zheng@intel.com>
References: <alpine.LNX.2.11.1502151932250.630@localhost> <cover.1425019470.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1425019470.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch refines logging/debugging splitter support so that when DEBUG is
disabled, splitters won't be visible in the kernel logs while they are
still available for developers when DEBUG is enabled.

This patch also refines the splitters to mark the following handling
process boundaries:
  +++++: boundary of driver starting/stopping
         boundary of IRQ storming
  =====: boundary of transaction advancement
  *****: boundary of EC command
         boundary of EC query
  #####: boundary of EC _Qxx evaluation

The following 2 log entries are originally logged using pr_info() in order
to be used as the boot/suspend/resume log entries for the EC device, this
patch also restores them to pr_info() logging level:
 ACPI : EC: EC started
 ACPI : EC: EC stopped

In this patch, one log entry around "Polling quirk" is converted into
ec_dbg_raw() which doesn't contain the boundary marker.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |  108 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a8dd2f7..07426c8 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -137,6 +137,48 @@ static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
 
 /* --------------------------------------------------------------------------
+ *                           Logging/Debugging
+ * -------------------------------------------------------------------------- */
+
+/*
+ * Splitters used by the developers to track the boundary of the EC
+ * handling processes.
+ */
+#ifdef DEBUG
+#define EC_DBG_SEP	" "
+#define EC_DBG_DRV	"+++++"
+#define EC_DBG_STM	"====="
+#define EC_DBG_REQ	"*****"
+#define EC_DBG_EVT	"#####"
+#else
+#define EC_DBG_SEP	""
+#define EC_DBG_DRV
+#define EC_DBG_STM
+#define EC_DBG_REQ
+#define EC_DBG_EVT
+#endif
+
+#define ec_log_raw(fmt, ...) \
+	pr_info(fmt "\n", ##__VA_ARGS__)
+#define ec_dbg_raw(fmt, ...) \
+	pr_debug(fmt "\n", ##__VA_ARGS__)
+#define ec_log(filter, fmt, ...) \
+	ec_log_raw(filter EC_DBG_SEP fmt EC_DBG_SEP filter, ##__VA_ARGS__)
+#define ec_dbg(filter, fmt, ...) \
+	ec_dbg_raw(filter EC_DBG_SEP fmt EC_DBG_SEP filter, ##__VA_ARGS__)
+
+#define ec_log_drv(fmt, ...) \
+	ec_log(EC_DBG_DRV, fmt, ##__VA_ARGS__)
+#define ec_dbg_drv(fmt, ...) \
+	ec_dbg(EC_DBG_DRV, fmt, ##__VA_ARGS__)
+#define ec_dbg_stm(fmt, ...) \
+	ec_dbg(EC_DBG_STM, fmt, ##__VA_ARGS__)
+#define ec_dbg_req(fmt, ...) \
+	ec_dbg(EC_DBG_REQ, fmt, ##__VA_ARGS__)
+#define ec_dbg_evt(fmt, ...) \
+	ec_dbg(EC_DBG_EVT, fmt, ##__VA_ARGS__)
+
+/* --------------------------------------------------------------------------
  *                           Device Flags
  * -------------------------------------------------------------------------- */
 
@@ -159,14 +201,14 @@ static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
 {
 	u8 x = inb(ec->command_addr);
 
-	pr_debug("EC_SC(R) = 0x%2.2x "
-		 "SCI_EVT=%d BURST=%d CMD=%d IBF=%d OBF=%d\n",
-		 x,
-		 !!(x & ACPI_EC_FLAG_SCI),
-		 !!(x & ACPI_EC_FLAG_BURST),
-		 !!(x & ACPI_EC_FLAG_CMD),
-		 !!(x & ACPI_EC_FLAG_IBF),
-		 !!(x & ACPI_EC_FLAG_OBF));
+	ec_dbg_raw("EC_SC(R) = 0x%2.2x "
+		   "SCI_EVT=%d BURST=%d CMD=%d IBF=%d OBF=%d",
+		   x,
+		   !!(x & ACPI_EC_FLAG_SCI),
+		   !!(x & ACPI_EC_FLAG_BURST),
+		   !!(x & ACPI_EC_FLAG_CMD),
+		   !!(x & ACPI_EC_FLAG_IBF),
+		   !!(x & ACPI_EC_FLAG_OBF));
 	return x;
 }
 
@@ -175,20 +217,20 @@ static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 	u8 x = inb(ec->data_addr);
 
 	ec->curr->timestamp = jiffies;
-	pr_debug("EC_DATA(R) = 0x%2.2x\n", x);
+	ec_dbg_raw("EC_DATA(R) = 0x%2.2x", x);
 	return x;
 }
 
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
-	pr_debug("EC_SC(W) = 0x%2.2x\n", command);
+	ec_dbg_raw("EC_SC(W) = 0x%2.2x", command);
 	outb(command, ec->command_addr);
 	ec->curr->timestamp = jiffies;
 }
 
 static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 {
-	pr_debug("EC_DATA(W) = 0x%2.2x\n", data);
+	ec_dbg_raw("EC_DATA(W) = 0x%2.2x", data);
 	outb(data, ec->data_addr);
 	ec->curr->timestamp = jiffies;
 }
@@ -240,7 +282,7 @@ static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
 		 * software need to manually trigger a pseudo GPE event on
 		 * EN=1 writes.
 		 */
-		pr_debug("***** Polling quirk *****\n");
+		ec_dbg_raw("Polling quirk");
 		advance_transaction(ec);
 	}
 }
@@ -299,7 +341,7 @@ static void acpi_ec_set_storm(struct acpi_ec *ec, u8 flag)
 {
 	if (!test_bit(flag, &ec->flags)) {
 		acpi_ec_disable_gpe(ec, false);
-		pr_debug("+++++ Polling enabled +++++\n");
+		ec_dbg_drv("Polling enabled");
 		set_bit(flag, &ec->flags);
 	}
 }
@@ -309,7 +351,7 @@ static void acpi_ec_clear_storm(struct acpi_ec *ec, u8 flag)
 	if (test_bit(flag, &ec->flags)) {
 		clear_bit(flag, &ec->flags);
 		acpi_ec_enable_gpe(ec, false);
-		pr_debug("+++++ Polling disabled +++++\n");
+		ec_dbg_drv("Polling disabled");
 	}
 }
 
@@ -335,7 +377,7 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-		pr_debug("***** Event started *****\n");
+		ec_dbg_req("Event started");
 		schedule_work(&ec->work);
 	}
 }
@@ -344,7 +386,7 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 {
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-		pr_debug("***** Event stopped *****\n");
+		ec_dbg_req("Event stopped");
 	}
 }
 
@@ -366,8 +408,8 @@ static void advance_transaction(struct acpi_ec *ec)
 	u8 status;
 	bool wakeup = false;
 
-	pr_debug("===== %s (%d) =====\n",
-		 in_interrupt() ? "IRQ" : "TASK", smp_processor_id());
+	ec_dbg_stm("%s (%d)", in_interrupt() ? "IRQ" : "TASK",
+		   smp_processor_id());
 	/*
 	 * By always clearing STS before handling all indications, we can
 	 * ensure a hardware STS 0->1 change after this clearing can always
@@ -390,8 +432,8 @@ static void advance_transaction(struct acpi_ec *ec)
 				if (t->rlen == t->ri) {
 					t->flags |= ACPI_EC_COMMAND_COMPLETE;
 					if (t->command == ACPI_EC_COMMAND_QUERY)
-						pr_debug("***** Command(%s) hardware completion *****\n",
-							 acpi_ec_cmd_string(t->command));
+						ec_dbg_req("Command(%s) hardware completion",
+							   acpi_ec_cmd_string(t->command));
 					wakeup = true;
 				}
 			} else
@@ -410,8 +452,8 @@ static void advance_transaction(struct acpi_ec *ec)
 			acpi_ec_complete_query(ec);
 			t->rdata[t->ri++] = 0x00;
 			t->flags |= ACPI_EC_COMMAND_COMPLETE;
-			pr_debug("***** Command(%s) software completion *****\n",
-				 acpi_ec_cmd_string(t->command));
+			ec_dbg_req("Command(%s) software completion",
+				   acpi_ec_cmd_string(t->command));
 			wakeup = true;
 		} else if ((status & ACPI_EC_FLAG_IBF) == 0) {
 			acpi_ec_write_cmd(ec, t->command);
@@ -504,16 +546,14 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	}
 	/* following two actions should be kept atomic */
 	ec->curr = t;
-	pr_debug("***** Command(%s) started *****\n",
-		 acpi_ec_cmd_string(t->command));
+	ec_dbg_req("Command(%s) started", acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
 	if (t->irq_count == ec_storm_threshold)
 		acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
-	pr_debug("***** Command(%s) stopped *****\n",
-		 acpi_ec_cmd_string(t->command));
+	ec_dbg_req("Command(%s) stopped", acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
 	/* Disable GPE for command processing (IBF=0/OBF=1) */
 	acpi_ec_complete_request(ec);
@@ -676,11 +716,11 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 
 	spin_lock_irqsave(&ec->lock, flags);
 	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
-		pr_debug("+++++ Starting EC +++++\n");
+		ec_dbg_drv("Starting EC");
 		/* Enable GPE for event processing (SCI_EVT=1) */
 		if (!resuming)
 			acpi_ec_submit_request(ec);
-		pr_debug("EC started\n");
+		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
@@ -702,7 +742,7 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 
 	spin_lock_irqsave(&ec->lock, flags);
 	if (acpi_ec_started(ec)) {
-		pr_debug("+++++ Stopping EC +++++\n");
+		ec_dbg_drv("Stopping EC");
 		set_bit(EC_FLAGS_STOPPED, &ec->flags);
 		spin_unlock_irqrestore(&ec->lock, flags);
 		wait_event(ec->wait, acpi_ec_stopped(ec));
@@ -712,7 +752,7 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 			acpi_ec_complete_request(ec);
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
-		pr_debug("EC stopped\n");
+		ec_log_drv("EC stopped");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
@@ -824,12 +864,12 @@ static void acpi_ec_run(void *cxt)
 
 	if (!handler)
 		return;
-	pr_debug("##### Query(0x%02x) started #####\n", handler->query_bit);
+	ec_dbg_evt("Query(0x%02x) started", handler->query_bit);
 	if (handler->func)
 		handler->func(handler->data);
 	else if (handler->handle)
 		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
-	pr_debug("##### Query(0x%02x) stopped #####\n", handler->query_bit);
+	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
 	acpi_ec_put_query_handler(handler);
 }
 
@@ -861,8 +901,8 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 		if (value == handler->query_bit) {
 			/* have custom handler for this bit */
 			handler = acpi_ec_get_query_handler(handler);
-			pr_debug("##### Query(0x%02x) scheduled #####\n",
-				 handler->query_bit);
+			ec_dbg_evt("Query(0x%02x) scheduled",
+				   handler->query_bit);
 			status = acpi_os_execute((handler->func) ?
 				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
 				acpi_ec_run, handler);
-- 
1.7.10
