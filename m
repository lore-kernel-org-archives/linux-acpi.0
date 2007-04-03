From: Shaohua Li <shaohua.li@intel.com>
Subject: RE: [PATCH] acpi cpuidle driver should handle max_cstate
Date: Tue, 03 Apr 2007 11:15:17 +0800
Message-ID: <1175570117.30083.5.camel@sli10-conroe.sh.intel.com>
References: <653FFBB4508B9042B5D43DC9E18836F532B6E1@scsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-g74dZidXRaXXY0/vvvJi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44110 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbXDCDSh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Apr 2007 23:18:37 -0400
In-Reply-To: <653FFBB4508B9042B5D43DC9E18836F532B6E1@scsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Adam Belay <abelay@novell.com>


--=-g74dZidXRaXXY0/vvvJi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-04-03 at 09:49 +0800, Pallipadi, Venkatesh wrote:
>  
> >-----Original Message-----
> >From: Li, Shaohua 
> >Sent: Monday, April 02, 2007 6:34 PM
> >To: Pallipadi, Venkatesh
> >Cc: linux acpi; Brown, Len; Adam Belay
> >Subject: RE: [PATCH] acpi cpuidle driver should handle max_cstate
> >
> >On Tue, 2007-04-03 at 00:44 +0800, Pallipadi, Venkatesh wrote:
> >>  
> >Ok, updated it.
> >
> >Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> >
> >Index: linux/drivers/acpi/processor_idle.c
> >===================================================================
> >--- linux.orig/drivers/acpi/processor_idle.c	2007-04-03 
> >08:47:05.000000000 +0800
> >+++ linux/drivers/acpi/processor_idle.c	2007-04-03 
> >08:50:50.000000000 +0800
> >@@ -75,7 +75,30 @@ ACPI_MODULE_NAME("processor_idle");
> > #define C2_OVERHEAD			1	/* 1us */
> > #define C3_OVERHEAD			1	/* 1us */
> > 
> >-module_param(max_cstate, uint, 0644);
> >+void acpi_max_cstate_changed(void)
> >+{
> >+	int cpu;
> >+	/* Driver will reset devices' max cstate limit */
> >+	lock_cpu_hotplug();
> >+	for_each_online_cpu(cpu)
> >+		cpuidle_force_redetect(&per_cpu(cpuidle_devices, cpu));
> >+	unlock_cpu_hotplug();
> >+}
> 
> No hotplug lock in cpuidle please. Either we have to add a
> force_allcpu_redetect function or we can use the previous patch.
Ok, I added a new routine to redetect all cpus. please see attached
patches.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

--=-g74dZidXRaXXY0/vvvJi
Content-Disposition: attachment; filename=a.patch
Content-Type: text/x-patch; name=a.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: rc4-mm1/drivers/acpi/osl.c
===================================================================
--- rc4-mm1.orig/drivers/acpi/osl.c	2007-04-03 10:41:49.000000000 +0800
+++ rc4-mm1/drivers/acpi/osl.c	2007-04-03 11:05:24.000000000 +0800
@@ -997,6 +997,16 @@ unsigned int max_cstate = ACPI_PROCESSOR
 
 EXPORT_SYMBOL(max_cstate);
 
+void (*acpi_do_set_cstate_limit)(void);
+EXPORT_SYMBOL(acpi_do_set_cstate_limit);
+
+void acpi_set_cstate_limit(unsigned int new_limit)
+{
+	max_cstate = new_limit;
+	if (acpi_do_set_cstate_limit)
+		acpi_do_set_cstate_limit();
+}
+
 /*
  * Acquire a spinlock.
  *
Index: rc4-mm1/drivers/acpi/processor_core.c
===================================================================
--- rc4-mm1.orig/drivers/acpi/processor_core.c	2007-04-03 10:41:49.000000000 +0800
+++ rc4-mm1/drivers/acpi/processor_core.c	2007-04-03 11:05:24.000000000 +0800
@@ -1030,11 +1030,13 @@ static int __init acpi_processor_init(vo
 	acpi_processor_ppc_init();
 
 	cpuidle_register_driver(&acpi_idle_driver);
+	acpi_do_set_cstate_limit = acpi_max_cstate_changed;
 	return 0;
 }
 
 static void __exit acpi_processor_exit(void)
 {
+	acpi_do_set_cstate_limit = NULL;
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
 	acpi_processor_ppc_exit();
Index: rc4-mm1/drivers/acpi/processor_idle.c
===================================================================
--- rc4-mm1.orig/drivers/acpi/processor_idle.c	2007-04-03 11:03:20.000000000 +0800
+++ rc4-mm1/drivers/acpi/processor_idle.c	2007-04-03 11:06:46.000000000 +0800
@@ -75,7 +75,26 @@ ACPI_MODULE_NAME("processor_idle");
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
 
-module_param(max_cstate, uint, 0644);
+void acpi_max_cstate_changed(void)
+{
+	/* Driver will reset devices' max cstate limit */
+	cpuidle_force_redetect_devices(&acpi_idle_driver);
+}
+
+static int change_max_cstate(const char *val, struct kernel_param *kp)
+{
+	int max;
+
+	max = simple_strtol(val, NULL, 0);
+	if (!max)
+		return -EINVAL;
+	max_cstate = max;
+	if (acpi_do_set_cstate_limit)
+		acpi_do_set_cstate_limit();
+	return 0;
+}
+
+module_param_call(max_cstate, change_max_cstate, param_get_uint, &max_cstate, 0644);
 
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
@@ -1054,7 +1073,7 @@ static int acpi_idle_init(struct cpuidle
 		return -EINVAL;
 	}
 
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 		state = &dev->states[count];
 
Index: rc4-mm1/include/linux/acpi.h
===================================================================
--- rc4-mm1.orig/include/linux/acpi.h	2007-04-03 10:41:49.000000000 +0800
+++ rc4-mm1/include/linux/acpi.h	2007-04-03 11:05:24.000000000 +0800
@@ -205,11 +205,8 @@ static inline unsigned int acpi_get_csta
 {
 	return max_cstate;
 }
-static inline void acpi_set_cstate_limit(unsigned int new_limit)
-{
-	max_cstate = new_limit;
-	return;
-}
+extern void (*acpi_do_set_cstate_limit)(void);
+extern void acpi_set_cstate_limit(unsigned int new_limit);
 #else
 static inline unsigned int acpi_get_cstate_limit(void) { return 0; }
 static inline void acpi_set_cstate_limit(unsigned int new_limit) { return; }

--=-g74dZidXRaXXY0/vvvJi
Content-Disposition: attachment; filename=cpuidle_force_redetect.patch
Content-Type: text/x-patch; name=cpuidle_force_redetect.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: rc4-mm1/drivers/cpuidle/driver.c
===================================================================
--- rc4-mm1.orig/drivers/cpuidle/driver.c	2007-03-23 08:58:51.000000000 +0800
+++ rc4-mm1/drivers/cpuidle/driver.c	2007-04-03 11:04:13.000000000 +0800
@@ -160,20 +160,34 @@ void cpuidle_unregister_driver(struct cp
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
 
+static void __cpuidle_force_redetect(struct cpuidle_device *dev)
+{
+	cpuidle_remove_driver_sysfs(dev);
+	cpuidle_curr_driver->redetect(dev);
+	cpuidle_add_driver_sysfs(dev);
+}
+
 /**
  * cpuidle_force_redetect - redetects the idle states of a CPU
  *
  * @dev: the CPU to redetect
+ * @drv: the target driver
  *
  * Generally, the driver will call this when the supported states set has
  * changed. (e.g. as the result of an ACPI transition to battery power)
  */
-int cpuidle_force_redetect(struct cpuidle_device *dev)
+int cpuidle_force_redetect(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv)
 {
 	int uninstalled = 0;
 
 	mutex_lock(&cpuidle_lock);
 
+	if (drv != cpuidle_curr_driver) {
+		mutex_unlock(&cpuidle_lock);
+		return 0;
+	}
+
 	if (!(dev->status & CPUIDLE_STATUS_DRIVER_ATTACHED) ||
 	    !cpuidle_curr_driver->redetect) {
 		mutex_unlock(&cpuidle_lock);
@@ -185,9 +199,7 @@ int cpuidle_force_redetect(struct cpuidl
 		cpuidle_uninstall_idle_handler();
 	}
 
-	cpuidle_remove_driver_sysfs(dev);
-	cpuidle_curr_driver->redetect(dev);
-	cpuidle_add_driver_sysfs(dev);
+	__cpuidle_force_redetect(dev);
 
 	if (cpuidle_device_can_idle(dev)) {
 		cpuidle_rescan_device(dev);
@@ -206,6 +218,42 @@ int cpuidle_force_redetect(struct cpuidl
 EXPORT_SYMBOL_GPL(cpuidle_force_redetect);
 
 /**
+ * cpuidle_force_redetect_devices - redetects the idle states of all CPUs
+ *
+ * @drv: the target driver
+ *
+ * Generally, the driver will call this when the supported states set has
+ * changed. (e.g. as the result of an ACPI transition to battery power)
+ */
+int cpuidle_force_redetect_devices(struct cpuidle_driver *drv)
+{
+	struct cpuidle_device *dev;
+	int ret = 0;
+
+	mutex_lock(&cpuidle_lock);
+
+	if (drv != cpuidle_curr_driver)
+		goto out;
+
+	if (!cpuidle_curr_driver->redetect) {
+		ret = -EIO;
+		goto out;
+	}
+
+	cpuidle_uninstall_idle_handler();
+
+	list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+		__cpuidle_force_redetect(dev);
+
+	cpuidle_install_idle_handler();
+out:
+	mutex_unlock(&cpuidle_lock);
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_force_redetect_devices);
+
+/**
  * cpuidle_get_bm_activity - determines if BM activity has occured
  */
 int cpuidle_get_bm_activity(void)
Index: rc4-mm1/include/linux/cpuidle.h
===================================================================
--- rc4-mm1.orig/include/linux/cpuidle.h	2007-04-03 10:42:45.000000000 +0800
+++ rc4-mm1/include/linux/cpuidle.h	2007-04-03 11:04:56.000000000 +0800
@@ -137,14 +137,17 @@ struct cpuidle_driver {
 
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
-extern int cpuidle_force_redetect(struct cpuidle_device *dev);
+extern int cpuidle_force_redetect(struct cpuidle_device *dev, struct cpuidle_driver *drv);
+extern int cpuidle_force_redetect_devices(struct cpuidle_driver *drv);
 
 #else
 
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return 0;}
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
-static inline int cpuidle_force_redetect(struct cpuidle_device *dev)
+static inline int cpuidle_force_redetect(struct cpuidle_device *dev, struct cpuidle_driver *drv)
+{return 0;}
+static inline int cpuidle_force_redetect_devices(struct cpuidle_driver *drv)
 {return 0;}
 
 #endif
Index: rc4-mm1/drivers/acpi/processor_idle.c
===================================================================
--- rc4-mm1.orig/drivers/acpi/processor_idle.c	2007-04-03 10:42:45.000000000 +0800
+++ rc4-mm1/drivers/acpi/processor_idle.c	2007-04-03 11:03:20.000000000 +0800
@@ -623,7 +623,8 @@ int acpi_processor_cst_has_changed(struc
 		return -ENODEV;
 
 	acpi_processor_get_power_info(pr);
-	return cpuidle_force_redetect(per_cpu(cpuidle_devices, pr->id));
+	return cpuidle_force_redetect(per_cpu(cpuidle_devices, pr->id),
+		&acpi_idle_driver);
 }
 
 /* proc interface */

--=-g74dZidXRaXXY0/vvvJi--
