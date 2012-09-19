From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/3] cpuidle : remove unused ref count function
Date: Wed, 19 Sep 2012 19:22:47 +0200
Message-ID: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58631 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab2ISRWx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Sep 2012 13:22:53 -0400
Received: by wibhr14 with SMTP id hr14so1415928wib.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Sep 2012 10:22:52 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

These two functions are never used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |   29 +----------------------------
 include/linux/cpuidle.h  |    4 ----
 2 files changed, 1 insertions(+), 32 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 58bf3b1..40cd3f3 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -16,7 +16,6 @@
 
 static struct cpuidle_driver *cpuidle_curr_driver;
 DEFINE_SPINLOCK(cpuidle_driver_lock);
-int cpuidle_driver_refcount;
 
 static void __cpuidle_register_driver(struct cpuidle_driver *drv)
 {
@@ -90,34 +89,8 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 	}
 
 	spin_lock(&cpuidle_driver_lock);
-
-	if (!WARN_ON(cpuidle_driver_refcount > 0))
-		cpuidle_curr_driver = NULL;
-
+	cpuidle_curr_driver = NULL;
 	spin_unlock(&cpuidle_driver_lock);
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-
-struct cpuidle_driver *cpuidle_driver_ref(void)
-{
-	struct cpuidle_driver *drv;
-
-	spin_lock(&cpuidle_driver_lock);
-
-	drv = cpuidle_curr_driver;
-	cpuidle_driver_refcount++;
-
-	spin_unlock(&cpuidle_driver_lock);
-	return drv;
-}
-
-void cpuidle_driver_unref(void)
-{
-	spin_lock(&cpuidle_driver_lock);
-
-	if (!WARN_ON(cpuidle_driver_refcount <= 0))
-		cpuidle_driver_refcount--;
-
-	spin_unlock(&cpuidle_driver_lock);
-}
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 279b1ea..5abf62b 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -145,8 +145,6 @@ extern void disable_cpuidle(void);
 extern int cpuidle_idle_call(void);
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 extern struct cpuidle_driver *cpuidle_get_driver(void);
-extern struct cpuidle_driver *cpuidle_driver_ref(void);
-extern void cpuidle_driver_unref(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_register_device(struct cpuidle_device *dev);
 extern void cpuidle_unregister_device(struct cpuidle_device *dev);
@@ -169,8 +167,6 @@ static inline int cpuidle_idle_call(void) { return -ENODEV; }
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
-static inline struct cpuidle_driver *cpuidle_driver_ref(void) {return NULL; }
-static inline void cpuidle_driver_unref(void) {}
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
 {return -ENODEV; }
-- 
1.7.5.4

