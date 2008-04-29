From: Len Brown <lenb@kernel.org>
Subject: [PATCH 096/171] thermal: add hwmon sysfs I/F
Date: Tue, 29 Apr 2008 04:44:16 -0400
Message-ID: <e68b16abd91dca91e35ea47537ef8a1b7ad72841.1209457070.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756974AbYD2IpT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:19 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Add hwmon sys I/F for generic thermal driver.

Note: we have one hwmon class device for EACH TYPE of the thermal zone device.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal.c |  163 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h   |   24 +++++++
 2 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index cf56af4..6098787 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -295,6 +295,164 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 
 /* Device management */
 
+#if defined(CONFIG_HWMON) ||	\
+	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
+/* hwmon sys I/F */
+#include <linux/hwmon.h>
+static LIST_HEAD(thermal_hwmon_list);
+
+static ssize_t
+name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thermal_hwmon_device *hwmon = dev->driver_data;
+	return sprintf(buf, "%s\n", hwmon->type);
+}
+static DEVICE_ATTR(name, 0444, name_show, NULL);
+
+static ssize_t
+temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thermal_hwmon_attr *hwmon_attr
+			= container_of(attr, struct thermal_hwmon_attr, attr);
+	struct thermal_zone_device *tz
+			= container_of(hwmon_attr, struct thermal_zone_device,
+				       temp_input);
+
+	return tz->ops->get_temp(tz, buf);
+}
+
+static ssize_t
+temp_crit_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct thermal_hwmon_attr *hwmon_attr
+			= container_of(attr, struct thermal_hwmon_attr, attr);
+	struct thermal_zone_device *tz
+			= container_of(hwmon_attr, struct thermal_zone_device,
+				       temp_crit);
+
+	return tz->ops->get_trip_temp(tz, 0, buf);
+}
+
+
+static int
+thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_hwmon_device *hwmon;
+	int new_hwmon_device = 1;
+	int result;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(hwmon, &thermal_hwmon_list, node)
+		if (!strcmp(hwmon->type, tz->type)) {
+			new_hwmon_device = 0;
+			mutex_unlock(&thermal_list_lock);
+			goto register_sys_interface;
+		}
+	mutex_unlock(&thermal_list_lock);
+
+	hwmon = kzalloc(sizeof(struct thermal_hwmon_device), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&hwmon->tz_list);
+	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
+	hwmon->device = hwmon_device_register(NULL);
+	if (IS_ERR(hwmon->device)) {
+		result = PTR_ERR(hwmon->device);
+		goto free_mem;
+	}
+	hwmon->device->driver_data = hwmon;
+	result = device_create_file(hwmon->device, &dev_attr_name);
+	if (result)
+		goto unregister_hwmon_device;
+
+ register_sys_interface:
+	tz->hwmon = hwmon;
+	hwmon->count++;
+
+	snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
+		 "temp%d_input", hwmon->count);
+	tz->temp_input.attr.attr.name = tz->temp_input.name;
+	tz->temp_input.attr.attr.mode = 0444;
+	tz->temp_input.attr.show = temp_input_show;
+	result = device_create_file(hwmon->device, &tz->temp_input.attr);
+	if (result)
+		goto unregister_hwmon_device;
+
+	if (tz->ops->get_crit_temp) {
+		unsigned long temperature;
+		if (!tz->ops->get_crit_temp(tz, &temperature)) {
+			snprintf(tz->temp_crit.name, THERMAL_NAME_LENGTH,
+				"temp%d_crit", hwmon->count);
+			tz->temp_crit.attr.attr.name = tz->temp_crit.name;
+			tz->temp_crit.attr.attr.mode = 0444;
+			tz->temp_crit.attr.show = temp_crit_show;
+			result = device_create_file(hwmon->device,
+						    &tz->temp_crit.attr);
+			if (result)
+				goto unregister_hwmon_device;
+		}
+	}
+
+	mutex_lock(&thermal_list_lock);
+	if (new_hwmon_device)
+		list_add_tail(&hwmon->node, &thermal_hwmon_list);
+	list_add_tail(&tz->hwmon_node, &hwmon->tz_list);
+	mutex_unlock(&thermal_list_lock);
+
+	return 0;
+
+ unregister_hwmon_device:
+	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+	device_remove_file(hwmon->device, &tz->temp_input.attr);
+	if (new_hwmon_device) {
+		device_remove_file(hwmon->device, &dev_attr_name);
+		hwmon_device_unregister(hwmon->device);
+	}
+ free_mem:
+	if (new_hwmon_device)
+		kfree(hwmon);
+
+	return result;
+}
+
+static void
+thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_hwmon_device *hwmon = tz->hwmon;
+
+	tz->hwmon = NULL;
+	device_remove_file(hwmon->device, &tz->temp_input.attr);
+	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+
+	mutex_lock(&thermal_list_lock);
+	list_del(&tz->hwmon_node);
+	if (!list_empty(&hwmon->tz_list)) {
+		mutex_unlock(&thermal_list_lock);
+		return;
+	}
+	list_del(&hwmon->node);
+	mutex_unlock(&thermal_list_lock);
+
+	device_remove_file(hwmon->device, &dev_attr_name);
+	hwmon_device_unregister(hwmon->device);
+	kfree(hwmon);
+}
+#else
+static int
+thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static void
+thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+}
+#endif
+
+
 /**
  * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
  * @tz:		thermal zone device
@@ -642,6 +800,10 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 			goto unregister;
 	}
 
+	result = thermal_add_hwmon_sysfs(tz);
+	if (result)
+		goto unregister;
+
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	if (ops->bind)
@@ -700,6 +862,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	for (count = 0; count < tz->trips; count++)
 		TRIP_POINT_ATTR_REMOVE(&tz->device, count);
 
+	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
 	mutex_destroy(&tz->lock);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 16e6a8b..06d3e6e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -66,6 +66,23 @@ struct thermal_cooling_device {
 				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
 #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
 
+#if defined(CONFIG_HWMON) ||	\
+	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
+/* thermal zone devices with the same type share one hwmon device */
+struct thermal_hwmon_device {
+	char type[THERMAL_NAME_LENGTH];
+	struct device *device;
+	int count;
+	struct list_head tz_list;
+	struct list_head node;
+};
+
+struct thermal_hwmon_attr {
+	struct device_attribute attr;
+	char name[16];
+};
+#endif
+
 struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
@@ -77,6 +94,13 @@ struct thermal_zone_device {
 	struct idr idr;
 	struct mutex lock;	/* protect cooling devices list */
 	struct list_head node;
+#if defined(CONFIG_HWMON) ||	\
+	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
+	struct list_head hwmon_node;
+	struct thermal_hwmon_device *hwmon;
+	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
+	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
+#endif
 };
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
-- 
1.5.5.1.99.gf0ec4

