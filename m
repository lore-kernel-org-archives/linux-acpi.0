From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 2/3] ACPI / EC: Add event detection support for noirq stages
Date: Thu, 31 Aug 2017 16:10:32 +0800
Message-ID: <daa549604f60d6042cd2660a3e4178b29b671029.1504166863.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1504166863.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504166863.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

1. Problems: Cannot detect EC event in noirq stages.
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
cannot detect SCI_EVT. And the worst case is if there is no EC transaction
after resume, EC event handling will stuck (FW flags SCI_EVT, but there is
no triggering source for OS to detect it).
Note that in noirq stage if there is an EC transaction pending,
advance_transaction() invoked because of the EC transaction can also help
to detect SCI_EVT and initiate the handling of the EC events. That's why
real reports related to this problem are rare and unreproducible as whether
there is an EC transaction occurred after an undetectable EC events during
noirq stages is random.

2. Old assumption and solution:
In order to solve the above issue, "ec_freeze_events" is implemented to:
stop handling SCI_EVT before suspend noirq stage and restart handling
SCI_EVT after resume noirq stage.
We assumed that detecting SCI_EVT in noirq stage is useless because there
are other conflict issues related to the EC event handling actually making
it not fully functioning during suspend/resume.
This assumption and the solution efficiently solves all issues.
Finally, the EC event handling is namely "frozen" for a specific period
during suspend/resume and "ec_freeze_events" controls the timing of the
"begin/end of the freeze". If freezing event handling earlier could work,
we shouldn't be required to implement event detection in noirq stages.

3. New facts and new problems:
Recently, some bug reports (see Link #1) revealed that we shouldn't
"freeze" EC event handling too early during these system suspend/resume
procedures.
Also enabling EC event handling too late surely changes the event
triggering timing, and may leave driver order issues during resume.
The previous commit in the same series resumes EC event handling earlier in
acpi_ec_unblock_transactions(), but that still leaves another problem to us
that we still cannot detect SCI_EVT occurred after
acpi_ec_unblock_transactions() and before acpi_ec_resume(). In order to
solve the final gap, we need to implement event detection in noirq stages.

4. New solution:
This patch adds a timer to poll EC events timely (0.5s) during system
suspend/resume noirq stages.
This patch has been validated to be able to improve situation related to
the reported bug (see Link #1) which requires to handle EC GPEs longer
during suspend.
With this patch applied, ACPI sleep core may still need to tune the order
of sleep steps by tuning the timing of invoking
acpi_ec_block/unblock_transactions() to fully solve the reported issue.
Actually ec_detect_noirq_events should always be true when ec_freeze_events
is false. But since there could be no noirq stage affection, this patch
introduces a separate runtime configurable option for it so that we can
disable it when there is no affection of the noirq stage.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129 [#1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c       | 93 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/internal.h |  1 +
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3dc4205..9363656 100644
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
@@ -353,6 +365,44 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
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
@@ -1012,6 +1062,12 @@ static void acpi_ec_leave_noirq(struct acpi_ec *ec)
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
@@ -1023,16 +1079,30 @@ void acpi_ec_block_transactions(void)
 	/* Prevent transactions from being carried out */
 	acpi_ec_stop(ec, true);
 	mutex_unlock(&ec->mutex);
+	if (ec_detect_noirq_events)
+		ec_stop_gpe_poller(ec);
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
+	if (ec_detect_noirq_events)
+		ec_start_gpe_poller(ec);
 	/*
 	 * Allow transactions to happen again (this function is called from
 	 * atomic context during wakeup, so we don't need to acquire the mutex).
 	 */
-	if (first_ec)
-		acpi_ec_start(first_ec, true);
+	acpi_ec_start(ec, true);
 }
 
 /* --------------------------------------------------------------------------
@@ -1273,6 +1343,19 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
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
@@ -1342,6 +1425,8 @@ static struct acpi_ec *acpi_ec_alloc(void)
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->lock);
 	INIT_WORK(&ec->work, acpi_ec_event_handler);
+	init_timer(&ec->timer);
+	setup_timer(&ec->timer, acpi_ec_gpe_poller, (ulong)ec);
 	ec->timestamp = jiffies;
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
@@ -1897,6 +1982,8 @@ static int acpi_ec_suspend(struct device *dev)
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
+	if (ec_detect_noirq_events)
+		ec_start_gpe_poller(ec);
 	if (acpi_sleep_no_ec_events() && ec_freeze_events)
 		acpi_ec_disable_event(ec);
 	return 0;
@@ -1945,6 +2032,8 @@ static int acpi_ec_resume(struct device *dev)
 		 */
 		advance_transaction(ec);
 	}
+	if (ec_detect_noirq_events)
+		ec_stop_gpe_poller(ec);
 	return 0;
 }
 #endif
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4361c44..a76e411 100644
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
