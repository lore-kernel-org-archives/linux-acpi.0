From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/4] ACPI / EC: Add IRQ polling support for noirq stages
Date: Mon, 31 Jul 2017 13:47:59 +0800
Message-ID: <866a3646718ae95ef525df0e25c3acbbcf0d4e7c.1501479412.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1501479412.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501479412.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

1. Problems:
EC IRQs contain transaction IRQs (OBF/IBF) and event IRQ (SCI_EVT).

Transactions are initiated by hosts. The earliest OSPMs execution of EC
transactions is from acpi_ec_transaction(), where the common EC IRQ
handling procedure - advance_transaction() - is initiated from the task
context.
Events are initiated by targets. The earliest OSPMs execution of EC events
is from acpi_ec_gpe_handler(), where the common EC IRQ handling procedure -
advance_transaction() - is initiated from the IRQ context.

1.1. Problem 1: Cannot detect EC event in noirq stages.
There is a noirq stage during system suspend/resume procedures. We can see
that during this stage, advance_transaction() which monitors SCI_EVT can
only be invoked from ec_poll().  Thus if there is no EC transaction
occurring in this stage, EC driver cannot detect SCI_EVT.

Note that in noirq stage if there is an EC transaction pending,
advance_transaction() invoked because of the EC transaction can also help
to detect SCI_EVT and initiate the handling of the EC events. That's why
real reports related to this problem are rare and unreproducible as whether
there is an EC transaction occurred after an undetectable EC events during
noirq stages is random.

1.2. Problem 2: Handling of EC events may stuck for some GPE chips.
Normally, when STS is set, GPE IRQs can be triggered by GPE chips when EN
bit is set. Thus it is ensured that handling of the EC events triggered in
suspend noirq stage is just deferred to resume stage and there won't be EC
event losts.

But there might be chips do not contain AND logic betwee STS and EN to
trigger GPE. In such worst case, EC events may risk lost, handling of the
lost EC events can only start when there is an EC transaction occurred.
Thus if there is no EC transaction, handling of EC events may "stuck"
after resume in such worst case.

2. Old assumption and solution:
Originally, as EC driver actually has never been fully able to handle EC
events during noirq stages, we assumed that detecting such events in noirq
stage is useless and implemented "ec_freeze_events" to stop handling
SCI_EVT earlier after suspend and re-start handling SCI_EVT after resume.
The EC event handling is namely "frozen" during suspend/resume and
"ec_freeze_events" controls the timing of the "freeze". If this could work,
we shouldn't be required to implement GPE polling in noirq stage.

Note that this solution cannot solve problem 2.

3. New fact and solution:
Recently, some bug reports (see Link #1) revealed that we shouldn't
"freeze" EC event handling too early during these system suspend/resume
procedures. Based on this fact, we should detect SCI_EVT during noirq
stage, this left us no other choice than implementing IRQ polling for
SCI_EVT in this stage.

This patch adds a timer to poll EC events timely (0.5s) during system
suspend/resume noirq stages. As the bug reports may not be root caused,
and most of the platforms may not require this, this patch prepares an
option to make this behavior configurable.

Note that this solution can also solve problem 2.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129 [#1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c       | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |   1 +
 2 files changed, 131 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 54879c7..f1cffd4 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/timer.h>
 #include <asm/io.h>
 
 #include "internal.h"
@@ -87,6 +88,31 @@
 #define ACPI_EC_EVT_TIMING_QUERY	0x01
 #define ACPI_EC_EVT_TIMING_EVENT	0x02
 
+/*
+ * There is a noirq stage during suspend/resume and EC firmware may
+ * require OS to handle EC events (SCI_EVT) during this stage.
+ * If there is no EC transactions during this stage, SCI_EVT cannot be
+ * detected. In order to still detect SCI_EVT, IRQ must be polled by the
+ * EC GPE poller. There are 3 configurable modes implemented for the EC
+ * GPE poller:
+ * NONE:    Do not enable noirq stage GPE poller.
+ * SUSPEND: Enable GPE poller for suspend noirq stage.
+ *          This mode detects SCI_EVT in suspend noirq stage, making sure
+ *          that all pre-suspend firmware events are handled before
+ *          entering a low power state. Some buggy EC firmware may require
+ *          this, otherwise some unknown firmware issues can be seen on
+ *          such platforms:
+ *          Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129
+ * RESUME:  Enable GPE poller for suspend/resume noirq stages.
+ *          This mode detects SCI_EVT in both suspend and resume noirq
+ *          stages, making sure that all post-resume firmware events are
+ *          handled as early as possible. This mode might be able to solve
+ *          some unknown driver timing issues.
+ */
+#define ACPI_EC_GPE_POLL_NONE		0x00
+#define ACPI_EC_GPE_POLL_SUSPEND	0x01
+#define ACPI_EC_GPE_POLL_RESUME		0x02
+
 /* EC commands */
 enum ec_command {
 	ACPI_EC_COMMAND_READ = 0x80,
@@ -102,6 +128,7 @@ enum ec_command {
 #define ACPI_EC_CLEAR_MAX	100	/* Maximum number of events to query
 					 * when trying to clear the EC */
 #define ACPI_EC_MAX_QUERIES	16	/* Maximum number of parallel queries */
+#define ACPI_EC_POLL_INTERVAL	500	/* Polling event every 500ms */
 
 enum {
 	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
@@ -113,6 +140,7 @@ enum {
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
 	EC_FLAGS_GPE_MASKED,		/* GPE masked */
+	EC_FLAGS_GPE_POLLING,		/* GPE polling is enabled */
 };
 
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -136,6 +164,7 @@ module_param(ec_polling_guard, uint, 0644);
 MODULE_PARM_DESC(ec_polling_guard, "Guard time(us) between EC accesses in polling modes");
 
 static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_QUERY;
+static unsigned int ec_gpe_polling __read_mostly = ACPI_EC_GPE_POLL_NONE;
 
 /*
  * If the number of false interrupts per one transaction exceeds
@@ -150,6 +179,10 @@ static bool ec_freeze_events __read_mostly = false;
 module_param(ec_freeze_events, bool, 0644);
 MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
 
+static unsigned int ec_poll_interval __read_mostly = ACPI_EC_POLL_INTERVAL;
+module_param(ec_poll_interval, uint, 0644);
+MODULE_PARM_DESC(ec_poll_interval, "GPE polling interval(ms)");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -349,6 +382,44 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
 	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
 }
 
+static void acpi_ec_gpe_tick(struct acpi_ec *ec)
+{
+	mod_timer(&ec->timer,
+		  jiffies + msecs_to_jiffies(ec_poll_interval));
+}
+
+static void ec_start_gpe_poller(struct acpi_ec *ec)
+{
+	unsigned long flags;
+	bool start_tick = false;
+
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
@@ -937,6 +1008,8 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
+	if (resuming && ec_gpe_polling == ACPI_EC_GPE_POLL_RESUME)
+		ec_start_gpe_poller(ec);
 }
 
 static bool acpi_ec_stopped(struct acpi_ec *ec)
@@ -972,6 +1045,8 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		ec_log_drv("EC stopped");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
+	if (suspending)
+		ec_stop_gpe_poller(ec);
 }
 
 static void acpi_ec_enter_noirq(struct acpi_ec *ec)
@@ -1257,6 +1332,19 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
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
@@ -1326,6 +1414,8 @@ static struct acpi_ec *acpi_ec_alloc(void)
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->lock);
 	INIT_WORK(&ec->work, acpi_ec_event_handler);
+	init_timer(&ec->timer);
+	setup_timer(&ec->timer, acpi_ec_gpe_poller, (ulong)ec);
 	ec->timestamp = jiffies;
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
@@ -1874,6 +1964,8 @@ static int acpi_ec_suspend(struct device *dev)
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
+	if (ec_gpe_polling != ACPI_EC_GPE_POLL_NONE)
+		ec_start_gpe_poller(ec);
 	if (acpi_sleep_no_ec_events() && ec_freeze_events)
 		acpi_ec_disable_event(ec);
 	return 0;
@@ -1885,6 +1977,7 @@ static int acpi_ec_resume(struct device *dev)
 		acpi_driver_data(to_acpi_device(dev));
 
 	acpi_ec_enable_event(ec);
+	ec_stop_gpe_poller(ec);
 	return 0;
 }
 #endif
@@ -1930,6 +2023,43 @@ module_param_call(ec_event_clearing, param_set_event_clearing, param_get_event_c
 		  NULL, 0644);
 MODULE_PARM_DESC(ec_event_clearing, "Assumed SCI_EVT clearing timing");
 
+static int param_set_gpe_polling(const char *val, struct kernel_param *kp)
+{
+	int result = 0;
+
+	if (!strncmp(val, "none", sizeof("none") - 1)) {
+		ec_gpe_polling = ACPI_EC_GPE_POLL_NONE;
+		pr_info("GPE noirq stage polling disabled\n");
+	} else if (!strncmp(val, "suspend", sizeof("suspend") - 1)) {
+		ec_gpe_polling = ACPI_EC_GPE_POLL_SUSPEND;
+		pr_info("GPE noirq suspend polling enabled\n");
+	} else if (!strncmp(val, "resume", sizeof("resume") - 1)) {
+		ec_gpe_polling = ACPI_EC_GPE_POLL_RESUME;
+		pr_info("GPE noirq suspend/resume polling enabled\n");
+	} else
+		result = -EINVAL;
+	return result;
+}
+
+static int param_get_gpe_polling(char *buffer, struct kernel_param *kp)
+{
+	switch (ec_gpe_polling) {
+	case ACPI_EC_GPE_POLL_NONE:
+		return sprintf(buffer, "none");
+	case ACPI_EC_GPE_POLL_SUSPEND:
+		return sprintf(buffer, "suspend");
+	case ACPI_EC_GPE_POLL_RESUME:
+		return sprintf(buffer, "resume");
+	default:
+		return sprintf(buffer, "invalid");
+	}
+	return 0;
+}
+
+module_param_call(ec_gpe_polling, param_set_gpe_polling, param_get_gpe_polling,
+		  NULL, 0644);
+MODULE_PARM_DESC(ec_gpe_polling, "Enabling GPE polling during noirq stages");
+
 static struct acpi_driver acpi_ec_driver = {
 	.name = "ec",
 	.class = ACPI_EC_CLASS,
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9531d32..6bd36b1 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -170,6 +170,7 @@ struct acpi_ec {
 	struct transaction *curr;
 	spinlock_t lock;
 	struct work_struct work;
+	struct timer_list timer;
 	unsigned long timestamp;
 	unsigned long nr_pending_queries;
 	bool busy_polling;
-- 
2.7.4
