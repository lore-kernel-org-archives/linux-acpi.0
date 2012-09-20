From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2][RFC] cpudidle : use a per cpu cpuidle driver
Date: Thu, 20 Sep 2012 15:14:40 +0200
Message-ID: <1348146880-17320-2-git-send-email-daniel.lezcano@linaro.org>
References: <1348146880-17320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64557 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab2ITNOt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2012 09:14:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id w11so208338bku.19
        for <linux-acpi@vger.kernel.org>; Thu, 20 Sep 2012 06:14:48 -0700 (PDT)
In-Reply-To: <1348146880-17320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

The discussion about having different cpus on the system with
different latencies bring us to a first attemp by adding a
pointer in the cpuidle_device to the states array.

But as Rafael suggested, it would make more sense to create a
driver per cpu [1].

This patch add support for multiple cpuidle drivers and as Rafael
expected, it had less impact than the first approach and is much
more clean.

It creates a per cpu cpuidle driver pointer.
In order to not break the different drivers, the function cpuidle_register_driver
assign for each cpu, the driver.

If this patch is accepted, I will add a cpuidle_register_cpu_driver and modify
the cpuidle drivers to make use of it and then remove the cpuidle_register_driver.

Note the output of sysfs for "/sys/devices/system/cpu/cpuidle/current_driver" has
been changed and instead of showing a single driver name, it shows the cpu and the
associated driver name.

[1] http://www.spinics.net/lists/linux-acpi/msg37921.html

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |   62 +++++++++++++++++++++++++++++++---------------
 drivers/cpuidle/sysfs.c  |   28 ++++++++++++++++----
 include/linux/cpuidle.h  |    1 +
 3 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 676febd..b2f8823 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -11,10 +11,11 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/cpuidle.h>
+#include <linux/smp.h>
 
 #include "cpuidle.h"
 
-static struct cpuidle_driver *cpuidle_curr_driver;
+DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
 DEFINE_SPINLOCK(cpuidle_driver_lock);
 
 static void set_power_states(struct cpuidle_driver *drv)
@@ -45,6 +46,8 @@ static void set_power_states(struct cpuidle_driver *drv)
  */
 int cpuidle_register_driver(struct cpuidle_driver *drv)
 {
+	int cpu, ret, i;
+
 	if (!drv || !drv->state_count)
 		return -EINVAL;
 
@@ -52,28 +55,44 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 		return -ENODEV;
 
 	spin_lock(&cpuidle_driver_lock);
-	if (cpuidle_curr_driver) {
-		spin_unlock(&cpuidle_driver_lock);
-		return -EBUSY;
-	}
-
-	if (!drv->power_specified)
-		set_power_states(drv);
+	ret = -EBUSY;
+	for_each_present_cpu(cpu) {
+		if (per_cpu(cpuidle_drivers, cpu))
+			goto unregister;
 
-	cpuidle_curr_driver = drv;
+		if (!drv->power_specified)
+			set_power_states(drv);
 
+		per_cpu(cpuidle_drivers, cpu) = drv;
+	}
+	ret = 0;
+out:
 	spin_unlock(&cpuidle_driver_lock);
+	return ret;
 
-	return 0;
+unregister:
+	for (i = cpu; i >= 0; i--)
+		per_cpu(cpuidle_drivers, i) = NULL;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
 /**
+ * cpuidle_get_cpu_driver - return the driver tied with the cpu
+ * @cpu : the cpu number
+ */
+struct cpuidle_driver *cpuidle_get_cpu_driver(int cpu)
+{
+	return per_cpu(cpuidle_drivers, cpu);
+}
+EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
+
+/**
  * cpuidle_get_driver - return the current driver
  */
 struct cpuidle_driver *cpuidle_get_driver(void)
 {
-	return cpuidle_curr_driver;
+	return cpuidle_get_cpu_driver(smp_processor_id());
 }
 EXPORT_SYMBOL_GPL(cpuidle_get_driver);
 
@@ -83,17 +102,20 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
-	if (drv != cpuidle_curr_driver) {
-		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
-			drv->name);
-		return;
-	}
+	int cpu;
+	struct cpuidle_driver *d;
 
 	spin_lock(&cpuidle_driver_lock);
+	for_each_present_cpu(cpu) {
+
+		d = per_cpu(cpuidle_drivers, cpu);
+		if (drv != d)
+			continue;
 
-	if (!WARN_ON(drv->refcnt > 0))
-		cpuidle_curr_driver = NULL;
+		if (!WARN_ON(drv->refcnt > 0))
+			per_cpu(cpuidle_drivers, cpu) = NULL;
 
+	}
 	spin_unlock(&cpuidle_driver_lock);
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
@@ -104,7 +126,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 	spin_lock(&cpuidle_driver_lock);
 
-	drv = cpuidle_curr_driver;
+	drv = cpuidle_get_driver();
 	drv->refcnt++;
 
 	spin_unlock(&cpuidle_driver_lock);
@@ -113,7 +135,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 void cpuidle_driver_unref(void)
 {
-	struct cpuidle_driver *drv = cpuidle_curr_driver;
+	struct cpuidle_driver *drv = cpuidle_get_driver();
 
 	spin_lock(&cpuidle_driver_lock);
 
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 5f809e3..05abebe 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -47,14 +47,30 @@ static ssize_t show_current_driver(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	ssize_t ret;
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+	int cpu;
+	ssize_t ret, count = 0;
+	struct cpuidle_driver *drv;
 
 	spin_lock(&cpuidle_driver_lock);
-	if (cpuidle_driver)
-		ret = sprintf(buf, "%s\n", cpuidle_driver->name);
-	else
-		ret = sprintf(buf, "none\n");
+	for_each_online_cpu(cpu) {
+
+		drv = cpuidle_get_cpu_driver(cpu);
+
+		ret = -EOVERFLOW;
+		if ((drv && (strlen(drv->name) + count) >= PAGE_SIZE) ||
+		    (!drv && (strlen("none") + count) >= PAGE_SIZE))
+			goto out;
+
+		ret = sprintf(buf + count, "cpu%d: %s\n",
+			      cpu, drv ? drv->name : "none" );
+
+		if (ret < 0)
+			goto out;
+
+		count += ret;
+	}
+	ret = count;
+out:
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a4ff9f8..ab6a3ed 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -146,6 +146,7 @@ extern void disable_cpuidle(void);
 extern int cpuidle_idle_call(void);
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 extern struct cpuidle_driver *cpuidle_get_driver(void);
+extern struct cpuidle_driver *cpuidle_get_cpu_driver(int cpu);
 extern struct cpuidle_driver *cpuidle_driver_ref(void);
 extern void cpuidle_driver_unref(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
-- 
1.7.5.4

