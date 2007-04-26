From: Shaohua Li <shaohua.li@intel.com>
Subject: [cpuidle 2/3] add cpuidle_fore_redetect_devices API
Date: Thu, 26 Apr 2007 10:40:13 +0800
Message-ID: <1177555213.11629.14.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37429 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754681AbXDZCnm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 22:43:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

add cpuidle_force_redetect_devices API, which force all CPU redetect idle states. Next patch will use it.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/processor_idle.c |    3 +-
 drivers/cpuidle/driver.c      |   56 +++++++++++++++++++++++++++++++++++++++---
 include/linux/cpuidle.h       |    7 +++--
 3 files changed, 59 insertions(+), 7 deletions(-)

Index: 21-rc6-mm1/drivers/cpuidle/driver.c
===================================================================
--- 21-rc6-mm1.orig/drivers/cpuidle/driver.c	2007-04-26 09:56:53.000000000 +0800
+++ 21-rc6-mm1/drivers/cpuidle/driver.c	2007-04-26 10:06:26.000000000 +0800
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
Index: 21-rc6-mm1/include/linux/cpuidle.h
===================================================================
--- 21-rc6-mm1.orig/include/linux/cpuidle.h	2007-04-26 10:05:55.000000000 +0800
+++ 21-rc6-mm1/include/linux/cpuidle.h	2007-04-26 10:06:26.000000000 +0800
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
Index: 21-rc6-mm1/drivers/acpi/processor_idle.c
===================================================================
--- 21-rc6-mm1.orig/drivers/acpi/processor_idle.c	2007-04-26 10:05:55.000000000 +0800
+++ 21-rc6-mm1/drivers/acpi/processor_idle.c	2007-04-26 10:06:41.000000000 +0800
@@ -624,7 +624,8 @@ int acpi_processor_cst_has_changed(struc
 		return -ENODEV;
 
 	acpi_processor_get_power_info(pr);
-	return cpuidle_force_redetect(per_cpu(cpuidle_devices, pr->id));
+	return cpuidle_force_redetect(per_cpu(cpuidle_devices, pr->id),
+		&acpi_idle_driver);
 }
 
 /* proc interface */
