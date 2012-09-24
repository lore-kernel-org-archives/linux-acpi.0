From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/4] cpuidle - prepare the driver core to be multi drivers aware
Date: Tue, 25 Sep 2012 00:43:53 +0200
Message-ID: <1348526634-19029-4-git-send-email-daniel.lezcano@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41212 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2IXWoE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 18:44:04 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so527447wey.19
        for <linux-acpi@vger.kernel.org>; Mon, 24 Sep 2012 15:44:03 -0700 (PDT)
In-Reply-To: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, pdeschrijver@nvidia.com, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

This patch is a preparation for the multiple drivers support.

As the next patch will introduce the multiple drivers with the Kconfig
option and we want to keep the code clean and understandable, this patch
defines a set of functions for encapsulating some common parts and split
what should be done in a lock context or not.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |   71 +++++++++++++++++++++++++++++-----------------
 1 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 4a0c4ab..391f80f 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -39,11 +39,20 @@ static void set_power_states(struct cpuidle_driver *drv)
 		drv->states[i].power_usage = -1 - i;
 }
 
-/**
- * cpuidle_register_driver - registers a driver
- * @drv: the driver
- */
-int cpuidle_register_driver(struct cpuidle_driver *drv)
+static void __cpuidle_driver_init(struct cpuidle_driver *drv)
+{
+	drv->refcnt = 0;
+
+	if (!drv->power_specified)
+		set_power_states(drv);
+}
+
+static void cpuidle_set_driver(struct cpuidle_driver *drv)
+{
+	cpuidle_curr_driver = drv;
+}
+
+static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 {
 	if (!drv || !drv->state_count)
 		return -EINVAL;
@@ -51,22 +60,41 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	spin_lock(&cpuidle_driver_lock);
-	if (cpuidle_curr_driver) {
-		spin_unlock(&cpuidle_driver_lock);
+	if (cpuidle_get_driver())
 		return -EBUSY;
-	}
 
-	if (!drv->power_specified)
-		set_power_states(drv);
+	__cpuidle_driver_init(drv);
 
-	drv->refcnt = 0;
+	cpuidle_set_driver(drv);
 
-	cpuidle_curr_driver = drv;
+	return 0;
+}
 
+static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
+{
+	if (drv != cpuidle_get_driver()) {
+		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
+			drv->name);
+		return;
+	}
+
+	if (!WARN_ON(drv->refcnt > 0))
+		cpuidle_set_driver(NULL);
+}
+
+/**
+ * cpuidle_register_driver - registers a driver
+ * @drv: the driver
+ */
+int cpuidle_register_driver(struct cpuidle_driver *drv)
+{
+	int ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	ret = __cpuidle_register_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
@@ -86,16 +114,7 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
 	spin_lock(&cpuidle_driver_lock);
-
-	if (drv != cpuidle_curr_driver) {
-		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
-			drv->name);
-		goto out;
-	}
-
-	if (!WARN_ON(drv->refcnt > 0))
-		cpuidle_curr_driver = NULL;
-out:
+	__cpuidle_unregister_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
@@ -106,7 +125,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 	spin_lock(&cpuidle_driver_lock);
 
-	drv = cpuidle_curr_driver;
+	drv = cpuidle_get_driver();
 	drv->refcnt++;
 
 	spin_unlock(&cpuidle_driver_lock);
@@ -115,7 +134,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 void cpuidle_driver_unref(void)
 {
-	struct cpuidle_driver *drv = cpuidle_curr_driver;
+	struct cpuidle_driver *drv = cpuidle_get_driver();
 
 	spin_lock(&cpuidle_driver_lock);
 
-- 
1.7.5.4

