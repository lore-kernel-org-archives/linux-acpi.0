From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 2/3] PM: Add prepare_late/finish_early suspend_ops callbacks
Date: Tue, 28 Jun 2016 16:04:40 +0800
Message-ID: <b6ff2a45a8d289437964112a7a0ce0ec1479adff.1467100803.git.lv.zheng@intel.com>
References: <cover.1467100803.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467100803.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds prepare_late/finish_early callbacks for suspend_ops.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/linux/suspend.h |   34 +++++++++++++++++++++++++++-------
 kernel/power/suspend.c  |   10 ++++++++--
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b5261e3..21e32b8 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -115,14 +115,24 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
  *	This callback is optional.  However, if it is implemented, the argument
  *	passed to @enter() is redundant and should be ignored.
  *
- * @prepare: Prepare the platform for entering the system sleep state indicated
- *	by @begin().
+ * @prepare: Early preparing the platform for entering the system sleep state
+ *	indicated by @begin().
  *	@prepare() is called right after devices have been suspended (ie. the
  *	appropriate .suspend() method has been executed for each device) and
  *	before device drivers' late suspend callbacks are executed.  It returns
  *	0 on success or a negative error code otherwise, in which case the
- *	system cannot enter the desired sleep state (@prepare_noirq(), @enter(),
- *	and @finish_noirq() will not be called in that case).
+ *	system cannot enter the desired sleep state (@prepare_late,
+ *	@prepare_noirq(), @enter(), and @finish_noirq() will not be called in
+ *	that case).
+ *
+ * @prepare_late: Late preparing the platform for entering the system sleep
+ *	state indicated by @begin().
+ *	@prepare_late() is called right after device drivers' late suspend
+ *	callbacks have been executed and before device drivers' noirq suspend
+ *	callbacks are executed.  It returns 0 on success or a negative error
+ *	code otherwise, in which case the system cannot enter the desired sleep
+ *	state (@prepare_noirq(), @enter(), and @finish_noirq() will not be
+ *	called in that case).
  *
  * @prepare_noirq: Finish preparing the platform for entering the system sleep
  *	state indicated by @begin().
@@ -145,13 +155,21 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
  *	that implement @prepare_noirq().  If implemented, it is always called
  *	after @prepare_noirq and @enter(), even if one of them fails.
  *
- * @finish: Finish wake-up of the platform.
+ * @finish_early: Early finishing wake-up of the platform.
+ *	@finish_early is called right prior to calling device drivers' resume
+ *	early callbacks.
+ *	This callback is optional, but should be implemented by the platforms
+ *	that implement @prepare_late().  If implemented, it is always called
+ *	after @enter() and @finish_noirq(), even if any of them fails.  It is
+ *	executed after a failing @prepare_late.
+ *
+ * @finish: Late finishing wake-up of the platform.
  *	@finish is called right prior to calling device drivers' regular suspend
  *	callbacks.
  *	This callback is optional, but should be implemented by the platforms
  *	that implement @prepare().  If implemented, it is always called after
- *	@enter() and @finish_noirq(), even if any of them fails.  It is executed
- *	after a failing @prepare.
+ *	@enter(), @finish_noirq() and @finish_early, even if any of them fails.
+ *	It is executed after a failing @prepare.
  *
  * @suspend_again: Returns whether the system should suspend again (true) or
  *	not (false). If the platform wants to poll sensors or execute some
@@ -177,9 +195,11 @@ struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
 	int (*begin)(suspend_state_t state);
 	int (*prepare)(void);
+	int (*prepare_late)(void);
 	int (*prepare_noirq)(void);
 	int (*enter)(suspend_state_t state);
 	void (*finish_noirq)(void);
+	void (*finish_early)(void);
 	void (*finish)(void);
 	bool (*suspend_again)(void);
 	void (*end)(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f0a5561..3a36107 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -179,8 +179,12 @@ static int platform_suspend_prepare(suspend_state_t state)
 
 static int platform_suspend_prepare_late(suspend_state_t state)
 {
-	return state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->prepare ?
-		freeze_ops->prepare() : 0;
+	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->prepare)
+		return freeze_ops->prepare();
+	else if (suspend_ops->prepare_late)
+		return suspend_ops->prepare_late();
+	else
+		return 0;
 }
 
 static int platform_suspend_prepare_noirq(suspend_state_t state)
@@ -199,6 +203,8 @@ static void platform_resume_early(suspend_state_t state)
 {
 	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->restore)
 		freeze_ops->restore();
+	else if (suspend_ops->finish_early)
+		suspend_ops->finish_early();
 }
 
 static void platform_resume_finish(suspend_state_t state)
-- 
1.7.10
