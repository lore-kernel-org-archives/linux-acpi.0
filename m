From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] cpuidle - support multiple drivers
Date: Tue, 25 Sep 2012 00:43:54 +0200
Message-ID: <1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58166 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab2IXWoG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 18:44:06 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so5514933wib.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Sep 2012 15:44:05 -0700 (PDT)
In-Reply-To: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, pdeschrijver@nvidia.com, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

With the tegra3 and the big.LITTLE [1] new architectures, several cpus
with different characteristics (latencies and states) can co-exists on the
system.

The cpuidle framework has the limitation of handling only identical cpus.

This patch removes this limitation by introducing the multiple driver support
for cpuidle.

This option is configurable at compile time and should be enabled for the
architectures mentioned above. So there is no impact for the other platforms
if the option is disabled. The option defaults to 'n'. Note the multiple drivers
support is also compatible with the existing drivers, even if just one driver is
needed, all the cpu will be tied to this driver using an extra small chunk of
processor memory.

The multiple driver support use a per-cpu driver pointer instead of a global
variable and the accessor to this variable are done from a cpu context.

In order to keep the compatibility with the existing drivers, the function
'cpuidle_register_driver' and 'cpuidle_unregister_driver' will register
the specified driver for all the cpus.

The sysfs output for the 'current_driver' is changed when this option is
set by giving the drivers per cpu.

eg.
cpu0: acpi_idle
cpu1: acpi_idle

but if the option is disabled, the output will remain the same.

[1] http://lwn.net/Articles/481055/


Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig   |    9 +++
 drivers/cpuidle/cpuidle.c |   24 ++++++--
 drivers/cpuidle/driver.c  |  136 +++++++++++++++++++++++++++++++++++++++++---
 drivers/cpuidle/sysfs.c   |   50 +++++++++++++----
 include/linux/cpuidle.h   |    8 ++-
 5 files changed, 197 insertions(+), 30 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index a76b689..234ae65 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -9,6 +9,15 @@ config CPU_IDLE
 
 	  If you're using an ACPI-enabled platform, you should say Y here.
 
+config CPU_IDLE_MULTIPLE_DRIVERS
+        bool "Support multiple cpuidle drivers"
+        depends on CPU_IDLE
+        default n
+        help
+         Allows the cpuidle framework to use different drivers for each CPU.
+         This is useful if you have a system with different CPU latencies and
+         states. If unsure say N.
+
 config CPU_IDLE_GOV_LADDER
 	bool
 	depends on CPU_IDLE
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index e28f6ea..c581b99 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -68,7 +68,7 @@ static cpuidle_enter_t cpuidle_enter_ops;
 int cpuidle_play_dead(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev->cpu);
 	int i, dead_state = -1;
 	int power_usage = -1;
 
@@ -128,7 +128,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 int cpuidle_idle_call(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv;
 	int next_state, entered_state;
 
 	if (off)
@@ -141,6 +141,8 @@ int cpuidle_idle_call(void)
 	if (!dev || !dev->enabled)
 		return -EBUSY;
 
+	drv = cpuidle_get_cpu_driver(dev->cpu);
+
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(drv, dev);
 	if (need_resched()) {
@@ -308,15 +310,19 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
 int cpuidle_enable_device(struct cpuidle_device *dev)
 {
 	int ret, i;
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv;
 
 	if (!dev)
 		return -EINVAL;
 
 	if (dev->enabled)
 		return 0;
+
+	drv = cpuidle_get_cpu_driver(dev->cpu);
+
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
+
 	if (!dev->state_count)
 		dev->state_count = drv->state_count;
 
@@ -368,15 +374,18 @@ EXPORT_SYMBOL_GPL(cpuidle_enable_device);
  */
 void cpuidle_disable_device(struct cpuidle_device *dev)
 {
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev->cpu);
+
 	if (!dev->enabled)
 		return;
-	if (!cpuidle_get_driver() || !cpuidle_curr_governor)
+
+	if (!drv || !cpuidle_curr_governor)
 		return;
 
 	dev->enabled = 0;
 
 	if (cpuidle_curr_governor->disable)
-		cpuidle_curr_governor->disable(cpuidle_get_driver(), dev);
+		cpuidle_curr_governor->disable(drv, dev);
 
 	cpuidle_remove_state_sysfs(dev);
 	enabled_devices--;
@@ -395,7 +404,8 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 {
 	int ret;
 	struct device *cpu_dev = get_cpu_device((unsigned long)dev->cpu);
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+	struct cpuidle_driver *cpuidle_driver =
+		cpuidle_get_cpu_driver(dev->cpu);
 
 	if (!try_module_get(cpuidle_driver->owner))
 		return -EINVAL;
@@ -461,7 +471,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
 void cpuidle_unregister_device(struct cpuidle_device *dev)
 {
 	struct device *cpu_dev = get_cpu_device((unsigned long)dev->cpu);
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+	struct cpuidle_driver *cpuidle_driver = cpuidle_get_cpu_driver(dev->cpu);
 
 	if (dev->registered == 0)
 		return;
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 391f80f..6529b91 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -14,7 +14,11 @@
 
 #include "cpuidle.h"
 
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
+#else
 static struct cpuidle_driver *cpuidle_curr_driver;
+#endif
 DEFINE_SPINLOCK(cpuidle_driver_lock);
 
 static void set_power_states(struct cpuidle_driver *drv)
@@ -47,12 +51,25 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 		set_power_states(drv);
 }
 
-static void cpuidle_set_driver(struct cpuidle_driver *drv)
+static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
 {
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+	per_cpu(cpuidle_drivers, cpu) = drv;
+#else
 	cpuidle_curr_driver = drv;
+#endif
 }
 
-static int __cpuidle_register_driver(struct cpuidle_driver *drv)
+static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
+{
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+	return per_cpu(cpuidle_drivers, cpu);
+#else
+	return cpuidle_curr_driver;
+#endif
+}
+
+static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
 {
 	if (!drv || !drv->state_count)
 		return -EINVAL;
@@ -60,26 +77,102 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	if (cpuidle_get_driver())
+	if (__cpuidle_get_cpu_driver(cpu))
 		return -EBUSY;
 
 	__cpuidle_driver_init(drv);
 
-	cpuidle_set_driver(drv);
+	__cpuidle_set_cpu_driver(drv, cpu);
 
 	return 0;
 }
 
-static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
+static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
 {
-	if (drv != cpuidle_get_driver()) {
+	if (drv != __cpuidle_get_cpu_driver(cpu)) {
 		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
 			drv->name);
 		return;
 	}
 
 	if (!WARN_ON(drv->refcnt > 0))
-		cpuidle_set_driver(NULL);
+		__cpuidle_set_cpu_driver(NULL, cpu);
+}
+
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+static void __cpuidle_unregister_all_cpu_driver(struct cpuidle_driver *drv)
+{
+	int cpu;
+	for_each_present_cpu(cpu)
+		__cpuidle_unregister_driver(drv, cpu);
+}
+
+static int __cpuidle_register_all_cpu_driver(struct cpuidle_driver *drv)
+{
+	int ret = 0;
+	int i, cpu;
+
+	for_each_present_cpu(cpu) {
+		ret = __cpuidle_register_driver(drv, cpu);
+		if (!ret)
+			continue;
+		for (i = cpu - 1; i >= 0; i--)
+			__cpuidle_unregister_driver(drv, i);
+		break;
+	}
+
+	return ret;
+}
+
+static int __cpuidle_for_each_driver(int (*cb)(int, struct cpuidle_driver *,
+					       void *), void *data)
+{
+	struct cpuidle_driver *drv;
+	int cpu, ret = 0;
+
+	for_each_present_cpu(cpu) {
+		drv = __cpuidle_get_cpu_driver(cpu);
+		ret = cb(cpu, drv, data);
+		if (ret < 0)
+			break;
+	}
+	return ret;
+}
+
+int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu)
+{
+	int ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	ret = __cpuidle_register_driver(drv, cpu);
+	spin_unlock(&cpuidle_driver_lock);
+
+	return ret;
+}
+
+void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu)
+{
+	spin_lock(&cpuidle_driver_lock);
+	__cpuidle_unregister_driver(drv, cpu);
+	spin_unlock(&cpuidle_driver_lock);
+}
+#endif
+
+int cpuidle_for_each_driver(int (*cb)(int, struct cpuidle_driver *, void *),
+			    void *data)
+{
+	int ret;
+
+	spin_lock(&cpuidle_driver_lock);
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+	ret = __cpuidle_for_each_driver(cb, data);
+#else
+	ret = cb(smp_processor_id(),
+		 __cpuidle_get_cpu_driver(smp_processor_id()), data);
+#endif
+	spin_unlock(&cpuidle_driver_lock);
+
+	return ret;
 }
 
 /**
@@ -91,7 +184,11 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 	int ret;
 
 	spin_lock(&cpuidle_driver_lock);
-	ret = __cpuidle_register_driver(drv);
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+	ret = __cpuidle_register_all_cpu_driver(drv);
+#else
+	ret = __cpuidle_register_driver(drv, smp_processor_id());
+#endif
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
@@ -103,18 +200,37 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
  */
 struct cpuidle_driver *cpuidle_get_driver(void)
 {
-	return cpuidle_curr_driver;
+	return __cpuidle_get_cpu_driver(smp_processor_id());
 }
 EXPORT_SYMBOL_GPL(cpuidle_get_driver);
 
 /**
+ * cpuidle_get_cpu_driver - return the driver tied with a cpu
+ */
+struct cpuidle_driver *cpuidle_get_cpu_driver(int cpu)
+{
+	struct cpuidle_driver *drv;
+
+	spin_lock(&cpuidle_driver_lock);
+	drv = __cpuidle_get_cpu_driver(cpu);
+	spin_unlock(&cpuidle_driver_lock);
+
+	return drv;
+}
+EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
+
+/**
  * cpuidle_unregister_driver - unregisters a driver
  * @drv: the driver
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
 	spin_lock(&cpuidle_driver_lock);
-	__cpuidle_unregister_driver(drv);
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+	__cpuidle_unregister_all_cpu_driver(drv);
+#else
+	__cpuidle_unregister_driver(drv, smp_processor_id());
+#endif
 	spin_unlock(&cpuidle_driver_lock);
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 5f809e3..2596422 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -43,21 +43,46 @@ out:
 	return i;
 }
 
+struct cbarg {
+	char *buf;
+	ssize_t count;
+};
+
+static int each_driver_cb(int cpu, struct cpuidle_driver *drv, void *data)
+{
+	int ret;
+	struct cbarg *cbarg = data;
+
+	if ((drv && (strlen(drv->name) + cbarg->count) >= PAGE_SIZE) ||
+	    (!drv && (strlen("none") + cbarg->count) >= PAGE_SIZE))
+		return -EOVERFLOW;
+
+#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
+	ret = sprintf(cbarg->buf + cbarg->count, "cpu%d: %s\n",
+		      cpu, drv ? drv->name : "none" );
+#else
+	ret = sprintf(cbarg->buf, "%s\n", drv ? drv->name : "none");
+#endif
+	if (ret < 0)
+		return ret;
+
+	cbarg->count += ret;
+
+	return 0;
+}
+
 static ssize_t show_current_driver(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	ssize_t ret;
-	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
+	struct cbarg cbarg = { .buf = buf };
+	int ret;
 
-	spin_lock(&cpuidle_driver_lock);
-	if (cpuidle_driver)
-		ret = sprintf(buf, "%s\n", cpuidle_driver->name);
-	else
-		ret = sprintf(buf, "none\n");
-	spin_unlock(&cpuidle_driver_lock);
+	ret = cpuidle_for_each_driver(each_driver_cb, &cbarg);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return cbarg.count;
 }
 
 static ssize_t show_current_governor(struct device *dev,
@@ -363,10 +388,10 @@ int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 {
 	int i, ret = -ENOMEM;
 	struct cpuidle_state_kobj *kobj;
-	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device->cpu);
 
 	/* state statistics */
-	for (i = 0; i < device->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
 		if (!kobj)
 			goto error_state;
@@ -374,7 +399,8 @@ int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 		kobj->state_usage = &device->states_usage[i];
 		init_completion(&kobj->kobj_unregister);
 
-		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle, &device->kobj,
+		ret = kobject_init_and_add(&kobj->kobj,
+					   &ktype_state_cpuidle, &device->kobj,
 					   "state%d", i);
 		if (ret) {
 			kfree(kobj);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a4ff9f8..0e0b0ad 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -164,6 +164,13 @@ extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index));
 extern int cpuidle_play_dead(void);
 
+extern int cpuidle_for_each_driver(
+	int (*cb)(int, struct cpuidle_driver *, void *), void *data);
+
+extern struct cpuidle_driver *cpuidle_get_cpu_driver(int cpu);
+extern int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu);
+extern void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu);
+
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
@@ -190,7 +197,6 @@ static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index))
 { return -ENODEV; }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
-
 #endif
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-- 
1.7.5.4

