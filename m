From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] PM: ACPI and APM must not be enabled at the same time
Date: Fri, 11 Jan 2008 15:11:34 -0500
Message-ID: <9f9adecd2d0e4f88fa0e8cb06c6ec207748df70a.1200082105.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:42745 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761500AbYAKUkf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:35 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

From: Len Brown <len.brown@intel.com>

ACPI and APM used "pm_active" to guarantee that
they would not be simultaneously active.

But pm_active was recently moved under CONFIG_PM_LEGACY,
so that without CONFIG_PM_LEGACY, pm_active became a NOP --
allowing ACPI and APM to both be simultaneously enabled.
This caused unpredictable results, including boot hangs.

Further, the code under CONFIG_PM_LEGACY is scheduled
for removal.

So replace pm_active with pm_flags.
pm_flags depends only on CONFIG_PM,
which is present for both CONFIG_APM and CONFIG_ACPI.

http://bugzilla.kernel.org/show_bug.cgi?id=9194

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/apm_32.c  |   10 +++-------
 drivers/acpi/bus.c        |    7 ++-----
 include/linux/pm.h        |    9 +++++++++
 include/linux/pm_legacy.h |    6 ------
 kernel/power/main.c       |    3 +++
 kernel/power/pm.c         |    4 ----
 6 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 17089a0..af045ca 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -2256,14 +2256,12 @@ static int __init apm_init(void)
 		apm_info.disabled = 1;
 		return -ENODEV;
 	}
-	if (PM_IS_ACTIVE()) {
+	if (pm_flags & PM_ACPI) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
 		apm_info.disabled = 1;
 		return -ENODEV;
 	}
-#ifdef CONFIG_PM_LEGACY
-	pm_active = 1;
-#endif
+	pm_flags |= PM_APM;
 
 	/*
 	 * Set up a segment that references the real mode segment 0x40
@@ -2366,9 +2364,7 @@ static void __exit apm_exit(void)
 		kthread_stop(kapmd_task);
 		kapmd_task = NULL;
 	}
-#ifdef CONFIG_PM_LEGACY
-	pm_active = 0;
-#endif
+	pm_flags &= ~PM_APM;
 }
 
 module_init(apm_init);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 49d432d..d7a115c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -29,7 +29,6 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
-#include <linux/pm_legacy.h>
 #include <linux/device.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_X86
@@ -764,16 +763,14 @@ static int __init acpi_init(void)
 	result = acpi_bus_init();
 
 	if (!result) {
-#ifdef CONFIG_PM_LEGACY
-		if (!PM_IS_ACTIVE())
-			pm_active = 1;
+		if (!(pm_flags & PM_APM))
+			pm_flags |= PM_ACPI;
 		else {
 			printk(KERN_INFO PREFIX
 			       "APM is already active, exiting\n");
 			disable_acpi();
 			result = -ENODEV;
 		}
-#endif
 	} else
 		disable_acpi();
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 09a309b..b78e029 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -246,6 +246,15 @@ static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
 		device_set_wakeup_enable(dev,val); \
 	} while(0)
 
+/*
+ * Global Power Management flags
+ * Used to keep APM and ACPI from both being active
+ */
+extern unsigned int	pm_flags;
+
+#define PM_APM	1
+#define PM_ACPI	2
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */
diff --git a/include/linux/pm_legacy.h b/include/linux/pm_legacy.h
index 514729a..446f4f4 100644
--- a/include/linux/pm_legacy.h
+++ b/include/linux/pm_legacy.h
@@ -4,10 +4,6 @@
 
 #ifdef CONFIG_PM_LEGACY
 
-extern int pm_active;
-
-#define PM_IS_ACTIVE() (pm_active != 0)
-
 /*
  * Register a device with power management
  */
@@ -21,8 +17,6 @@ int __deprecated pm_send_all(pm_request_t rqst, void *data);
 
 #else /* CONFIG_PM_LEGACY */
 
-#define PM_IS_ACTIVE() 0
-
 static inline struct pm_dev *pm_register(pm_dev_t type,
 					 unsigned long id,
 					 pm_callback callback)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3cdf95b..f71c950 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -28,6 +28,9 @@ BLOCKING_NOTIFIER_HEAD(pm_chain_head);
 
 DEFINE_MUTEX(pm_mutex);
 
+unsigned int pm_flags;
+EXPORT_SYMBOL(pm_flags);
+
 #ifdef CONFIG_SUSPEND
 
 /* This is just an arbitrary number */
diff --git a/kernel/power/pm.c b/kernel/power/pm.c
index c50d152..60c73fa 100644
--- a/kernel/power/pm.c
+++ b/kernel/power/pm.c
@@ -27,8 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 
-int pm_active;
-
 /*
  *	Locking notes:
  *		pm_devs_lock can be a semaphore providing pm ops are not called
@@ -204,6 +202,4 @@ int pm_send_all(pm_request_t rqst, void *data)
 
 EXPORT_SYMBOL(pm_register);
 EXPORT_SYMBOL(pm_send_all);
-EXPORT_SYMBOL(pm_active);
-
 
-- 
1.5.4.rc2.84.gf85fd

