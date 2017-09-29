From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v6 2/3] ACPI / EC: Add event detection support for noirq stages
Date: Fri, 29 Sep 2017 10:50:22 +0800
Message-ID: <78859881be29535e4a6bd60531902ff36f796ce9.1506653046.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1506653046.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506653046.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds a timer to poll EC events:
1. between acpi_ec_suspend() and acpi_ec_block_transactions(),
2. between acpi_ec_unblock_transactions() and acpi_ec_resume().
During these periods, if an EC event occurred, we have not mean to detect
it. Thus the events occurred in late S3-entry could be dropped, and the
events occurred in early S3-exit could be deferred to acpi_ec_resume().

This patch solves event losses in S3-entry and resume order in S3-exit by
timely polling EC events during these periods.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129 [#1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c       | 93 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/internal.h |  1 +
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f1f320b..389c499 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/timer.h>
 #include <asm/io.h>
 
 #include "internal.h"
@@ -102,6 +103,7 @@ enum ec_command {
 #define ACPI_EC_CLEAR_MAX	100	/* Maximum number of events to query
 					 * when trying to clear the EC */
 #define ACPI_EC_MAX_QUERIES	16	/* Maximum number of parallel queries */
+#define ACPI_EC_EVENT_INTERVAL	500	/* Detecting event every 500ms */
 
 enum {
 	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
@@ -113,6 +115,7 @@ enum {
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
 	EC_FLAGS_GPE_MASKED,		/* GPE masked */
+	EC_FLAGS_GPE_POLLING,		/* GPE polling is enabled */
 };
 
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -154,6 +157,15 @@ static bool ec_no_wakeup __read_mostly;
 module_param(ec_no_wakeup, bool, 0644);
 MODULE_PARM_DESC(ec_no_wakeup, "Do not wake up from suspend-to-idle");
 
+static bool ec_detect_noirq_events __read_mostly;
+module_param(ec_detect_noirq_events, bool, 0644);
+MODULE_PARM_DESC(ec_detect_noirq_events, "Enabling event detection during noirq stage");
+
+static unsigned int
+ec_detect_noirq_interval __read_mostly = ACPI_EC_EVENT_INTERVAL;
+module_param(ec_detect_noirq_interval, uint, 0644);
+MODULE_PARM_DESC(ec_detect_noirq_interval, "Event detection interval(ms) during noirq stage");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -358,6 +370,48 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
 	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
 }
 
+static void acpi_ec_gpe_tick(struct acpi_ec *ec)
+{
+	mod_timer(&ec->timer,
+		  jiffies + msecs_to_jiffies(ec_detect_noirq_interval));
+}
+
+static void ec_start_gpe_poller(struct acpi_ec *ec)
+{
+	unsigned long flags;
+	bool start_tick = false;
+
+	if (!acpi_ec_no_sleep_events() || !ec_detect_noirq_events)
+		return;
+	spin_lock_irqsave(&ec->lock, flags);
+	if (!test_and_set_bit(EC_FLAGS_GPE_POLLING, &ec->flags)) {
+		ec_log_drv("GPE poller started");
+		start_tick = true;
+		/* kick off GPE polling without delay */
+		advance_transaction(ec);
+	}
+	spin_unlock_irqrestore(&ec->lock, flags);
+	if (start_tick)
+		acpi_ec_gpe_tick(ec);
+}
+
+static void ec_stop_gpe_poller(struct acpi_ec *ec)
+{
+	unsigned long flags;
+	bool stop_tick = false;
+
+	if (!acpi_ec_no_sleep_events() || !ec_detect_noirq_events)
+		return;
+	spin_lock_irqsave(&ec->lock, flags);
+	if (test_and_clear_bit(EC_FLAGS_GPE_POLLING, &ec->flags))
+		stop_tick = true;
+	spin_unlock_irqrestore(&ec->lock, flags);
+	if (stop_tick) {
+		del_timer_sync(&ec->timer);
+		ec_log_drv("GPE poller stopped");
+	}
+}
+
 static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
 {
 	if (open)
@@ -1017,6 +1071,12 @@ static void acpi_ec_leave_noirq(struct acpi_ec *ec)
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
+/*
+ * Note: this API is prepared for tuning the order of the ACPI
+ * suspend/resume steps as the last entry of EC during suspend, thus it
+ * must be invoked after acpi_ec_suspend() or everything should be done in
+ * acpi_ec_suspend().
+ */
 void acpi_ec_block_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
@@ -1028,16 +1088,28 @@ void acpi_ec_block_transactions(void)
 	/* Prevent transactions from being carried out */
 	acpi_ec_stop(ec, true);
 	mutex_unlock(&ec->mutex);
+	ec_stop_gpe_poller(ec);
 }
 
+/*
+ * Note: this API is prepared for tuning the order of the ACPI
+ * suspend/resume steps as the first entry of EC during resume, thus it
+ * must be invoked before acpi_ec_resume() or everything should be done in
+ * acpi_ec_resume().
+ */
 void acpi_ec_unblock_transactions(void)
 {
+	struct acpi_ec *ec = first_ec;
+
+	if (!ec)
+		return;
+
+	ec_start_gpe_poller(ec);
 	/*
 	 * Allow transactions to happen again (this function is called from
 	 * atomic context during wakeup, so we don't need to acquire the mutex).
 	 */
-	if (first_ec)
-		acpi_ec_start(first_ec, true);
+	acpi_ec_start(ec, true);
 }
 
 /* --------------------------------------------------------------------------
@@ -1278,6 +1350,19 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 	return ACPI_INTERRUPT_HANDLED;
 }
 
+static void acpi_ec_gpe_poller(ulong arg)
+{
+	struct acpi_ec *ec = (struct acpi_ec *)arg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	ec_dbg_drv("GPE polling begin");
+	advance_transaction(ec);
+	ec_dbg_drv("GPE polling end");
+	spin_unlock_irqrestore(&ec->lock, flags);
+	acpi_ec_gpe_tick(ec);
+}
+
 /* --------------------------------------------------------------------------
  *                           Address Space Management
  * -------------------------------------------------------------------------- */
@@ -1347,6 +1432,8 @@ static struct acpi_ec *acpi_ec_alloc(void)
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->lock);
 	INIT_WORK(&ec->work, acpi_ec_event_handler);
+	init_timer(&ec->timer);
+	setup_timer(&ec->timer, acpi_ec_gpe_poller, (ulong)ec);
 	ec->timestamp = jiffies;
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
@@ -1918,6 +2005,7 @@ static int acpi_ec_suspend(struct device *dev)
 
 	if (acpi_ec_no_sleep_events())
 		acpi_ec_disable_event(ec);
+	ec_start_gpe_poller(ec);
 	return 0;
 }
 
@@ -1952,6 +2040,7 @@ static int acpi_ec_resume(struct device *dev)
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
+	ec_stop_gpe_poller(ec);
 	if (acpi_ec_no_sleep_events())
 		acpi_ec_enable_event(ec);
 	else {
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ede83d3..708b379 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -171,6 +171,7 @@ struct acpi_ec {
 	struct transaction *curr;
 	spinlock_t lock;
 	struct work_struct work;
+	struct timer_list timer;
 	unsigned long timestamp;
 	unsigned long nr_pending_queries;
 	bool busy_polling;
-- 
2.7.4
