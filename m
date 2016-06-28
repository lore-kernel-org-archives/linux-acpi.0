From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 1/3] PM: Rename prepare_late/wake suspend_ops callbacks to prepare_noirq/finish_noirq
Date: Tue, 28 Jun 2016 16:04:34 +0800
Message-ID: <100422463f71b21990fe4ec901a8c1c309c824d0.1467100803.git.lv.zheng@intel.com>
References: <cover.1467100803.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467100803.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Rename the names of the PM callbacks, making them consistent with their
caller names. Particularly:
  .prepare_late -> .prepare_noirq
  .wake -> .finish_noirq

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/powerpc/platforms/pseries/suspend.c |    6 +++---
 drivers/acpi/sleep.c                     |    8 ++++----
 include/linux/suspend.h                  |   28 ++++++++++++++--------------
 kernel/power/suspend.c                   |    8 ++++----
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index e76aefa..cc52b0f 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -112,12 +112,12 @@ static int pseries_suspend_enter(suspend_state_t state)
 }
 
 /**
- * pseries_prepare_late - Prepare to suspend all other CPUs
+ * pseries_prepare_noirq - Prepare to suspend all other CPUs
  *
  * Return value:
  * 	0 on success / other on failure
  **/
-static int pseries_prepare_late(void)
+static int pseries_prepare_noirq(void)
 {
 	atomic_set(&suspending, 1);
 	atomic_set(&suspend_data.working, 0);
@@ -225,7 +225,7 @@ static struct bus_type suspend_subsys = {
 static const struct platform_suspend_ops pseries_suspend_ops = {
 	.valid		= suspend_valid_only_mem,
 	.begin		= pseries_suspend_begin,
-	.prepare_late	= pseries_prepare_late,
+	.prepare_noirq	= pseries_prepare_noirq,
 	.enter		= pseries_suspend_enter,
 };
 
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7a2e4d4..d30fce7f 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -595,9 +595,9 @@ static int acpi_suspend_state_valid(suspend_state_t pm_state)
 static const struct platform_suspend_ops acpi_suspend_ops = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin,
-	.prepare_late = acpi_pm_prepare,
+	.prepare_noirq = acpi_pm_prepare,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_pm_finish,
+	.finish_noirq = acpi_pm_finish,
 	.end = acpi_pm_end,
 };
 
@@ -623,9 +623,9 @@ static int acpi_suspend_begin_old(suspend_state_t pm_state)
 static const struct platform_suspend_ops acpi_suspend_ops_old = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin_old,
-	.prepare_late = acpi_pm_pre_suspend,
+	.prepare_noirq = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_pm_finish,
+	.finish_noirq = acpi_pm_finish,
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 7693e39..b5261e3 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -121,13 +121,13 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
  *	appropriate .suspend() method has been executed for each device) and
  *	before device drivers' late suspend callbacks are executed.  It returns
  *	0 on success or a negative error code otherwise, in which case the
- *	system cannot enter the desired sleep state (@prepare_late(), @enter(),
- *	and @wake() will not be called in that case).
+ *	system cannot enter the desired sleep state (@prepare_noirq(), @enter(),
+ *	and @finish_noirq() will not be called in that case).
  *
- * @prepare_late: Finish preparing the platform for entering the system sleep
+ * @prepare_noirq: Finish preparing the platform for entering the system sleep
  *	state indicated by @begin().
- *	@prepare_late is called before disabling nonboot CPUs and after
- *	device drivers' late suspend callbacks have been executed.  It returns
+ *	@prepare_noirq is called before disabling nonboot CPUs and after
+ *	device drivers' noirq suspend callbacks have been executed.  It returns
  *	0 on success or a negative error code otherwise, in which case the
  *	system cannot enter the desired sleep state (@enter() will not be
  *	executed).
@@ -138,20 +138,20 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
  *	error code otherwise, in which case the system cannot enter the desired
  *	sleep state.
  *
- * @wake: Called when the system has just left a sleep state, right after
- *	the nonboot CPUs have been enabled and before device drivers' early
- *	resume callbacks are executed.
+ * @finish_noirq: Called when the system has just left a sleep state, right
+ *	after the nonboot CPUs have been enabled and before device drivers'
+ *	noirq resume callbacks are executed.
  *	This callback is optional, but should be implemented by the platforms
- *	that implement @prepare_late().  If implemented, it is always called
- *	after @prepare_late and @enter(), even if one of them fails.
+ *	that implement @prepare_noirq().  If implemented, it is always called
+ *	after @prepare_noirq and @enter(), even if one of them fails.
  *
  * @finish: Finish wake-up of the platform.
  *	@finish is called right prior to calling device drivers' regular suspend
  *	callbacks.
  *	This callback is optional, but should be implemented by the platforms
  *	that implement @prepare().  If implemented, it is always called after
- *	@enter() and @wake(), even if any of them fails.  It is executed after
- *	a failing @prepare.
+ *	@enter() and @finish_noirq(), even if any of them fails.  It is executed
+ *	after a failing @prepare.
  *
  * @suspend_again: Returns whether the system should suspend again (true) or
  *	not (false). If the platform wants to poll sensors or execute some
@@ -177,9 +177,9 @@ struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
 	int (*begin)(suspend_state_t state);
 	int (*prepare)(void);
-	int (*prepare_late)(void);
+	int (*prepare_noirq)(void);
 	int (*enter)(suspend_state_t state);
-	void (*wake)(void);
+	void (*finish_noirq)(void);
 	void (*finish)(void);
 	bool (*suspend_again)(void);
 	void (*end)(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5b70d64..f0a5561 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -185,14 +185,14 @@ static int platform_suspend_prepare_late(suspend_state_t state)
 
 static int platform_suspend_prepare_noirq(suspend_state_t state)
 {
-	return state != PM_SUSPEND_FREEZE && suspend_ops->prepare_late ?
-		suspend_ops->prepare_late() : 0;
+	return state != PM_SUSPEND_FREEZE && suspend_ops->prepare_noirq ?
+		suspend_ops->prepare_noirq() : 0;
 }
 
 static void platform_resume_noirq(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_FREEZE && suspend_ops->wake)
-		suspend_ops->wake();
+	if (state != PM_SUSPEND_FREEZE && suspend_ops->finish_noirq)
+		suspend_ops->finish_noirq();
 }
 
 static void platform_resume_early(suspend_state_t state)
-- 
1.7.10
