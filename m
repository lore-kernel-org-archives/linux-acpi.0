From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 4/5] ACPI / EC: Add PM operations to improve event handling for suspend process
Date: Wed,  3 Aug 2016 16:01:43 +0800
Message-ID: <ec7aeb5341c9343cb4cceb289acf99cd356913d6.1470205312.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1470205312.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14923 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbcHCI7e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Aug 2016 04:59:34 -0400
In-Reply-To: <cover.1470205312.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

In the original EC driver, though the event handling is not explicitly
stopped, the EC driver is actually not able to handle events during the
noirq stage as the EC driver is not prepared to handle the EC events in the
polling mode. So if there is no advance_transaction() triggered, the EC
driver couldn't notice the EC events.
However, do we actually need to handle EC events during suspend/resume
stage? EC events are mostly useless for the suspend/resume period (key
strokes and battery/thermal updates, etc.,), and the useful ones (lid
close, power/sleep button press) should have already been delivered to the
OSPM to trigger the power saving operations.
Thus this patch implements acpi_ec_disable_event() to be a reverse call of
acpi_ec_enable_event(), with which, the EC driver is able to stop handling
the EC events in a position before entering the noirq stage.

Since there are actually 2 choices for us:
1. implement event handling in polling mode;
2. stop event handling before entering noirq stage.
And this patch only implements the second choice using .suspend() callback.
Thus this is experimental (first choice is better? or different hook
position is better?). This patch finally keeps the old behavior by default
and prepares a boot parameter to enable this feature.

The differences of the event handling availability between the old behavior
(this patch is not applied) and the new behavior (this patch is applied)
are as follows:
                        !FreezeEvents   FreezeEvents
before suspend          Y               Y
suspend before EC       Y               Y
suspend after EC        Y               N
suspend_late            Y               N
suspend_noirq           Y (actually N)  N
resume_noirq            Y (actually N)  N
resume_late             Y (actually N)  N
resume before EC        Y (actually N)  N
resume after EC         Y               Y
after resume            Y               Y
Where "actually N" means if there is no EC transactions, the EC driver
is actually not able to notice the pending events.

We can see that FreezeEvents is the only approach now can actually flush
the EC event handling with both query commands and _Qxx evaluations
flushed, other modes can only flush the EC event handling with only query
commands flushed, _Qxx evaluations occurred after stopping the EC driver
may end up failure due to the failure of the EC transaction carried out in
the _Qxx control methods.

We also can see that this feature should be able to trigger some platform
notifications later than resuming other drivers.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8d5444d..2bec709 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -146,6 +146,10 @@ static unsigned int ec_storm_threshold  __read_mostly = 8;
 module_param(ec_storm_threshold, uint, 0644);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
 
+static bool ec_freeze_events __read_mostly = false;
+module_param(ec_freeze_events, bool, 0644);
+MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -250,10 +254,18 @@ static bool acpi_ec_event_enabled(struct acpi_ec *ec)
 	if (!test_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
 		return false;
 	/*
-	 * The EC event handling is automatically disabled as soon as the
-	 * EC driver is stopped.
+	 * However, disabling the event handling is experimental for late
+	 * stage (suspend), and is controlled by the boot parameter of
+	 * "ec_freeze_events":
+	 * 1. true:  The EC event handling is disabled before entering
+	 *           the noirq stage.
+	 * 2. false: The EC event handling is automatically disabled as
+	 *           soon as the EC driver is stopped.
 	 */
-	return test_bit(EC_FLAGS_STARTED, &ec->flags);
+	if (ec_freeze_events)
+		return acpi_ec_started(ec);
+	else
+		return test_bit(EC_FLAGS_STARTED, &ec->flags);
 }
 
 static bool acpi_ec_flushed(struct acpi_ec *ec)
@@ -512,6 +524,38 @@ static void acpi_ec_enable_event(struct acpi_ec *ec)
 		acpi_ec_clear(ec);
 }
 
+static bool acpi_ec_query_flushed(struct acpi_ec *ec)
+{
+	bool flushed;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	flushed = !ec->nr_pending_queries;
+	spin_unlock_irqrestore(&ec->lock, flags);
+	return flushed;
+}
+
+static void __acpi_ec_flush_event(struct acpi_ec *ec)
+{
+	/*
+	 * When ec_freeze_events is true, we need to flush events in
+	 * the proper position before entering the noirq stage.
+	 */
+	wait_event(ec->wait, acpi_ec_query_flushed(ec));
+	if (ec_query_wq)
+		flush_workqueue(ec_query_wq);
+}
+
+static void acpi_ec_disable_event(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	__acpi_ec_disable_event(ec);
+	spin_unlock_irqrestore(&ec->lock, flags);
+	__acpi_ec_flush_event(ec);
+}
+
 static bool acpi_ec_guard_event(struct acpi_ec *ec)
 {
 	bool guarded = true;
@@ -941,7 +985,7 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		if (!suspending) {
 			acpi_ec_complete_request(ec);
 			ec_dbg_ref(ec, "Decrease driver");
-		} else
+		} else if (!ec_freeze_events)
 			__acpi_ec_disable_event(ec);
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
@@ -1693,6 +1737,16 @@ static int acpi_ec_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int acpi_ec_suspend(struct device *dev)
+{
+	struct acpi_ec *ec =
+		acpi_driver_data(to_acpi_device(dev));
+
+	if (ec_freeze_events)
+		acpi_ec_disable_event(ec);
+	return 0;
+}
+
 static int acpi_ec_resume(struct device *dev)
 {
 	struct acpi_ec *ec =
@@ -1705,7 +1759,7 @@ static int acpi_ec_resume(struct device *dev)
 
 static const struct dev_pm_ops acpi_ec_pm = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq, acpi_ec_resume_noirq)
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, acpi_ec_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend, acpi_ec_resume)
 };
 
 static int param_set_event_clearing(const char *val, struct kernel_param *kp)
-- 
1.7.10

