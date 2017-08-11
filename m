From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/4] ACPI / EC: Add IRQ polling support for noirq stages
Date: Fri, 11 Aug 2017 14:36:33 +0800
Message-ID: <bf371e3c599814a8cdc39f000d7deeafd9bd14e6.1502432974.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1502432974.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502432974.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

1. Problems:
1.1. Problem 1: Cannot detect EC event in noirq stages.
EC IRQs contain transaction IRQs (OBF/IBF) and event IRQ (SCI_EVT).

Transactions are initiated by hosts. The earliest OSPMs execution of EC
transactions is from acpi_ec_transaction(), where the common EC IRQ
handling procedure - advance_transaction() - is initiated from the task
context.
Events are initiated by targets. The earliest OSPMs execution of EC events
is from acpi_ec_gpe_handler(), where the common EC IRQ handling procedure -
advance_transaction() - is initiated from the IRQ context.

During suspend/resume noirq stage, IRQ is disabled, advance_transaction()
which detects SCI_EVT can only be invoked from task context - ec_poll().
Thus if there is no EC transaction occurring in this stage, EC driver
cannot detect SCI_EVT.

Note that in noirq stage if there is an EC transaction pending,
advance_transaction() invoked because of the EC transaction can also help
to detect SCI_EVT and initiate the handling of the EC events. That's why
real reports related to this problem are rare and unreproducible as whether
there is an EC transaction occurred after an undetectable EC events during
noirq stages is random.

1.2. Problem 2: Handling of EC events may stuck for some GPE chips.
When IRQ already occurred in the underlying hardware and flagged the IRQ
status bit, enabling IRQ by flagging the IRQ enable bit may not be
sufficient to trigger edge-triggered IRQs on some IRQ silicons (let me
call these IRQ silicons as buggy to make description simpler).

Then, when EC GPE events already occurred in resume noirq stage leaving GPE
STS bit set, EC GPE may not be delivered to the CPU when EC driver
re-enables EC GPE by flagging GPE EN bit. And even worse, after this
enabling, if there is no EC transaction occurred, EC events can never be
detected again, and handling of EC events "stucks".

Note that if the upper layer IRQ silicons (APIC and etc.) and GPE IRQ
silicons are not buggy, we needn't worry about this problem. That's why the
real reports related to this problem are rare and always platform specific.

2. Old assumption and solution:
In order to solve the above issues, "ec_freeze_events" is implemented to:
A. Stop handling SCI_EVT before suspend noirq stage:
   As EC driver actually has never been fully able to handle EC events
   during noirq stages, we assumed that detecting such events in noirq
   stage is useless and thus we needn't worry about problem 1.
B. Re-start handling SCI_EVT after resume noirq stage:
   By always setting EN after resume noirq stage, it is ensured that:
   a. whatever upper layer IRQ silicons (APIC and etc.) are buggy or not,
      they won't cause problem 2, and
   b. non buggy GPE IRQ silicons won't cause problem 2, but buggy GPE IRQ
      silicons may still cause problem 2.
By narrowing down the EC event handling period during suspend/resume, we
can see that the occurring ratio of problem 2 can be reduced, only buggy
GPE IRQ silicons can still trigger problem 2.

Finally, the EC event handling is namely "frozen" for a specific period
during suspend/resume and "ec_freeze_events" controls the timing of the
"begin/end of the freeze". If freezing event handling earlier could work,
we shouldn't be required to implement GPE polling in noirq stages.

Note that this solution cannot fully solve problem 2 and solves problem 1
with assumptions.

3. New facts and solution:
Recently, some bug reports (see Link #1) revealed that we shouldn't
"freeze" EC event handling too early during these system suspend/resume
procedures.
Also enabling EC event handling too late surely changes the event
triggering timing, and may leave driver order issues during resume.

Based on these facts, we should detect SCI_EVT during noirq stage, this
left us no other choice than implementing IRQ polling for SCI_EVT in noirq
stages.

This patch adds a timer to poll EC events timely (0.5s) during system
suspend/resume noirq stages. To be regression safer, this patch also
prepares an option to make this behavior configurable.

Note that this solution can perfectly solve problem 1 and problem 2.

This patch has been validated to be able to improve situation related to
the reported bug (see Link #1) which requires to handle EC GPEs longer
during suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129 [#1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c       | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |   1 +
 2 files changed, 131 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d338f40..5be62933 100644
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
@@ -154,6 +183,10 @@ static bool ec_no_wakeup __read_mostly;
 module_param(ec_no_wakeup, bool, 0644);
 MODULE_PARM_DESC(ec_no_wakeup, "Do not wake up from suspend-to-idle");
 
+static unsigned int ec_poll_interval __read_mostly = ACPI_EC_POLL_INTERVAL;
+module_param(ec_poll_interval, uint, 0644);
+MODULE_PARM_DESC(ec_poll_interval, "GPE polling interval(ms)");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -353,6 +386,44 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
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
@@ -949,6 +1020,8 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
+	if (resuming && ec_gpe_polling == ACPI_EC_GPE_POLL_RESUME)
+		ec_start_gpe_poller(ec);
 }
 
 static bool acpi_ec_stopped(struct acpi_ec *ec)
@@ -984,6 +1057,8 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		ec_log_drv("EC stopped");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
+	if (suspending)
+		ec_stop_gpe_poller(ec);
 }
 
 static void acpi_ec_enter_noirq(struct acpi_ec *ec)
@@ -1269,6 +1344,19 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
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
@@ -1338,6 +1426,8 @@ static struct acpi_ec *acpi_ec_alloc(void)
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->lock);
 	INIT_WORK(&ec->work, acpi_ec_event_handler);
+	init_timer(&ec->timer);
+	setup_timer(&ec->timer, acpi_ec_gpe_poller, (ulong)ec);
 	ec->timestamp = jiffies;
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
@@ -1886,6 +1976,8 @@ static int acpi_ec_suspend(struct device *dev)
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
+	if (ec_gpe_polling != ACPI_EC_GPE_POLL_NONE)
+		ec_start_gpe_poller(ec);
 	if (acpi_sleep_no_ec_events() && ec_freeze_events)
 		acpi_ec_disable_event(ec);
 	return 0;
@@ -1923,6 +2015,7 @@ static int acpi_ec_resume(struct device *dev)
 		acpi_driver_data(to_acpi_device(dev));
 
 	acpi_ec_enable_event(ec);
+	ec_stop_gpe_poller(ec);
 	return 0;
 }
 #endif
@@ -1969,6 +2062,43 @@ module_param_call(ec_event_clearing, param_set_event_clearing, param_get_event_c
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
index 58dd7ab..705d103 100644
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
