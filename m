From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/6] Revert "thermal: fix generic thermal I/F for hwmon"
Date: Tue, 18 Mar 2008 02:02:09 -0400
Message-ID: <91f57fa1215952af579f304821a15cc6c656042c.1205819948.git.len.brown@intel.com>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:55500 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752018AbYCRGGb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:06:31 -0400
In-Reply-To: <1205820132-21689-1-git-send-email-lenb@kernel.org>
In-Reply-To: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
References: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 3152fb9f11cdd2fd8688c2c5cb805e5c09b53dd9.

This broke libsensors.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   22 +++---
 drivers/thermal/Kconfig             |    1 -
 drivers/thermal/thermal.c           |  169 ++++++-----------------------------
 3 files changed, 37 insertions(+), 155 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index d9f28be..ba9c2da 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -143,10 +143,10 @@ type				Strings which represent the thermal zone type.
 				This is given by thermal zone driver as part of registration.
 				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
 				RO
-				Required
+				Optional
 
 temp				Current temperature as reported by thermal zone (sensor)
-				Unit: millidegree Celsius
+				Unit: degree Celsius
 				RO
 				Required
 
@@ -163,7 +163,7 @@ mode				One of the predefined values in [kernel, user]
 					  charge of the thermal management.
 
 trip_point_[0-*]_temp		The temperature above which trip point will be fired
-				Unit: millidegree Celsius
+				Unit: degree Celsius
 				RO
 				Optional
 
@@ -193,7 +193,7 @@ type				String which represents the type of device
 				eg. For memory controller device on intel_menlow platform:
 				this should be "Memory controller"
 				RO
-				Required
+				Optional
 
 max_state			The maximum permissible cooling state of this cooling device.
 				RO
@@ -219,16 +219,16 @@ the sys I/F structure will be built like this:
 
 |thermal_zone1:
 	|-----type:			ACPI thermal zone
-	|-----temp:			37000
+	|-----temp:			37
 	|-----mode:			kernel
-	|-----trip_point_0_temp:	100000
+	|-----trip_point_0_temp:	100
 	|-----trip_point_0_type:	critical
-	|-----trip_point_1_temp:	80000
+	|-----trip_point_1_temp:	80
 	|-----trip_point_1_type:	passive
-	|-----trip_point_2_temp:	70000
-	|-----trip_point_2_type:	active0
-	|-----trip_point_3_temp:	60000
-	|-----trip_point_3_type:	active1
+	|-----trip_point_2_temp:	70
+	|-----trip_point_2_type:	active[0]
+	|-----trip_point_3_temp:	60
+	|-----trip_point_3_type:	active[1]
 	|-----cdev0:			--->/sys/class/thermal/cooling_device0
 	|-----cdev0_trip_point:		1	/* cdev0 can be used for passive */
 	|-----cdev1:			--->/sys/class/thermal/cooling_device3
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3ab313e..69f19f2 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -4,7 +4,6 @@
 
 menuconfig THERMAL
 	bool "Generic Thermal sysfs driver"
-	select HWMON
 	default y
 	help
 	  Generic Thermal Sysfs driver offers a generic mechanism for
diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index 41bd4c8..8b86e53 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -30,10 +30,8 @@
 #include <linux/idr.h>
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
-#include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 
-MODULE_AUTHOR("Zhang Rui");
+MODULE_AUTHOR("Zhang Rui")
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
@@ -58,9 +56,6 @@ static LIST_HEAD(thermal_tz_list);
 static LIST_HEAD(thermal_cdev_list);
 static DEFINE_MUTEX(thermal_list_lock);
 
-static struct device *thermal_hwmon;
-#define MAX_THERMAL_ZONES	10
-
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int err;
@@ -92,67 +87,7 @@ static void release_idr(struct idr *idr, struct mutex *lock, int id)
 		mutex_unlock(lock);
 }
 
-/* hwmon sys I/F*/
-static ssize_t
-name_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "thermal_sys_class\n");
-}
-
-static ssize_t
-temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct thermal_zone_device *tz;
-	struct sensor_device_attribute *sensor_attr
-						= to_sensor_dev_attr(attr);
-
-	list_for_each_entry(tz, &thermal_tz_list, node)
-		if (tz->id == sensor_attr->index)
-			return tz->ops->get_temp(tz, buf);
-
-	return -ENODEV;
-}
-
-static ssize_t
-temp_crit_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct thermal_zone_device *tz;
-	struct sensor_device_attribute *sensor_attr
-						= to_sensor_dev_attr(attr);
-
-	list_for_each_entry(tz, &thermal_tz_list, node)
-		if (tz->id == sensor_attr->index)
-			return tz->ops->get_trip_temp(tz, 0, buf);
-
-	return -ENODEV;
-}
-
-static DEVICE_ATTR(name, 0444, name_show, NULL);
-static struct sensor_device_attribute sensor_attrs[] = {
-	SENSOR_ATTR(temp1_input, 0444, temp_input_show, NULL, 0),
-	SENSOR_ATTR(temp1_crit, 0444, temp_crit_show, NULL, 0),
-	SENSOR_ATTR(temp2_input, 0444, temp_input_show, NULL, 1),
-	SENSOR_ATTR(temp2_crit, 0444, temp_crit_show, NULL, 1),
-	SENSOR_ATTR(temp3_input, 0444, temp_input_show, NULL, 2),
-	SENSOR_ATTR(temp3_crit, 0444, temp_crit_show, NULL, 2),
-	SENSOR_ATTR(temp4_input, 0444, temp_input_show, NULL, 3),
-	SENSOR_ATTR(temp4_crit, 0444, temp_crit_show, NULL, 3),
-	SENSOR_ATTR(temp5_input, 0444, temp_input_show, NULL, 4),
-	SENSOR_ATTR(temp5_crit, 0444, temp_crit_show, NULL, 4),
-	SENSOR_ATTR(temp6_input, 0444, temp_input_show, NULL, 5),
-	SENSOR_ATTR(temp6_crit, 0444, temp_crit_show, NULL, 5),
-	SENSOR_ATTR(temp7_input, 0444, temp_input_show, NULL, 6),
-	SENSOR_ATTR(temp7_crit, 0444, temp_crit_show, NULL, 6),
-	SENSOR_ATTR(temp8_input, 0444, temp_input_show, NULL, 7),
-	SENSOR_ATTR(temp8_crit, 0444, temp_crit_show, NULL, 7),
-	SENSOR_ATTR(temp9_input, 0444, temp_input_show, NULL, 8),
-	SENSOR_ATTR(temp9_crit, 0444, temp_crit_show, NULL, 8),
-	SENSOR_ATTR(temp10_input, 0444, temp_input_show, NULL, 9),
-	SENSOR_ATTR(temp10_crit, 0444, temp_crit_show, NULL, 9),
-};
-
-/* thermal zone sys I/F */
+/* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
 	container_of(_dev, struct thermal_zone_device, device)
@@ -279,7 +214,7 @@ do {	\
 	device_remove_file(_dev, &trip_point_attrs[_index * 2 + 1]);	\
 } while (0)
 
-/* cooling device sys I/F */
+/* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
 
@@ -512,9 +447,6 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 	struct thermal_zone_device *pos;
 	int result;
 
-	if (!type)
-		return ERR_PTR(-EINVAL);
-
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
 
@@ -545,9 +477,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 	}
 
 	/* sys I/F */
-	result = device_create_file(&cdev->device, &dev_attr_cdev_type);
-	if (result)
-		goto unregister;
+	if (type) {
+		result = device_create_file(&cdev->device, &dev_attr_cdev_type);
+		if (result)
+			goto unregister;
+	}
 
 	result = device_create_file(&cdev->device, &dev_attr_max_state);
 	if (result)
@@ -613,8 +547,8 @@ void thermal_cooling_device_unregister(struct
 		tz->ops->unbind(tz, cdev);
 	}
 	mutex_unlock(&thermal_list_lock);
-
-	device_remove_file(&cdev->device, &dev_attr_cdev_type);
+	if (cdev->type[0])
+		device_remove_file(&cdev->device, &dev_attr_cdev_type);
 	device_remove_file(&cdev->device, &dev_attr_max_state);
 	device_remove_file(&cdev->device, &dev_attr_cur_state);
 
@@ -646,9 +580,6 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	int result;
 	int count;
 
-	if (!type)
-		return ERR_PTR(-EINVAL);
-
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
 
@@ -670,13 +601,6 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 		kfree(tz);
 		return ERR_PTR(result);
 	}
-	if (tz->id >= MAX_THERMAL_ZONES) {
-		printk(KERN_ERR PREFIX
-			"Too many thermal zones\n");
-		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
-		kfree(tz);
-		return ERR_PTR(-EINVAL);
-	}
 
 	strcpy(tz->type, type);
 	tz->ops = ops;
@@ -691,27 +615,12 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 		return ERR_PTR(result);
 	}
 
-	/* hwmon sys I/F */
-	result = device_create_file(thermal_hwmon,
-					&sensor_attrs[tz->id * 2].dev_attr);
-	if (result)
-		goto unregister;
-
-	if (trips > 0) {
-		char buf[40];
-		result = tz->ops->get_trip_type(tz, 0, buf);
-		if (result > 0 && !strcmp(buf, "critical\n")) {
-			result = device_create_file(thermal_hwmon,
-					&sensor_attrs[tz->id * 2 + 1].dev_attr);
-			if (result)
-				goto unregister;
-		}
-	}
-
 	/* sys I/F */
-	result = device_create_file(&tz->device, &dev_attr_type);
-	if (result)
-		goto unregister;
+	if (type) {
+		result = device_create_file(&tz->device, &dev_attr_type);
+		if (result)
+			goto unregister;
+	}
 
 	result = device_create_file(&tz->device, &dev_attr_temp);
 	if (result)
@@ -778,17 +687,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		    tz->ops->unbind(tz, cdev);
 	mutex_unlock(&thermal_list_lock);
 
-	device_remove_file(thermal_hwmon,
-				&sensor_attrs[tz->id * 2].dev_attr);
-	if (tz->trips > 0) {
-		char buf[40];
-		if (tz->ops->get_trip_type(tz, 0, buf) > 0)
-			if (!strcmp(buf, "critical\n"))
-				device_remove_file(thermal_hwmon,
-				&sensor_attrs[tz->id * 2 + 1].dev_attr);
-	}
-
-	device_remove_file(&tz->device, &dev_attr_type);
+	if (tz->type[0])
+		device_remove_file(&tz->device, &dev_attr_type);
 	device_remove_file(&tz->device, &dev_attr_temp);
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
@@ -805,19 +705,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 EXPORT_SYMBOL(thermal_zone_device_unregister);
 
-static void thermal_exit(void)
-{
-	if (thermal_hwmon) {
-		device_remove_file(thermal_hwmon, &dev_attr_name);
-		hwmon_device_unregister(thermal_hwmon);
-	}
-	class_unregister(&thermal_class);
-	idr_destroy(&thermal_tz_idr);
-	idr_destroy(&thermal_cdev_idr);
-	mutex_destroy(&thermal_idr_lock);
-	mutex_destroy(&thermal_list_lock);
-}
-
 static int __init thermal_init(void)
 {
 	int result = 0;
@@ -829,21 +716,17 @@ static int __init thermal_init(void)
 		mutex_destroy(&thermal_idr_lock);
 		mutex_destroy(&thermal_list_lock);
 	}
-
-	thermal_hwmon = hwmon_device_register(NULL);
-	if (IS_ERR(thermal_hwmon)) {
-		result = PTR_ERR(thermal_hwmon);
-		thermal_hwmon = NULL;
-		printk(KERN_ERR PREFIX
-			"unable to register hwmon device\n");
-		thermal_exit();
-		return result;
-	}
-
-	result = device_create_file(thermal_hwmon, &dev_attr_name);
-
 	return result;
 }
 
+static void __exit thermal_exit(void)
+{
+	class_unregister(&thermal_class);
+	idr_destroy(&thermal_tz_idr);
+	idr_destroy(&thermal_cdev_idr);
+	mutex_destroy(&thermal_idr_lock);
+	mutex_destroy(&thermal_list_lock);
+}
+
 subsys_initcall(thermal_init);
 module_exit(thermal_exit);
-- 
1.5.5.rc0.6.gdeda

