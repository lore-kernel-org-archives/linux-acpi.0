From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/27] thermal: make THERMAL_HWMON implementation fully internal
Date: Tue, 02 Aug 2011 16:53:27 -0400
Message-ID: <31f5396ad3bde23c8416e8d23ba425e27f413314.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab1HBVwJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:09 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:09 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Rene Herman <rene.herman@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <khali@linux-fr.org>

THERMAL_HWMON is implemented inside the thermal_sys driver and has no
effect on drivers implementing thermal zones, so they shouldn't see
anything related to it in <linux/thermal.h>.  Making the THERMAL_HWMON
implementation fully internal has two advantages beyond the cleaner
design:

* This avoids rebuilding all thermal drivers if the THERMAL_HWMON
  implementation changes, or if CONFIG_THERMAL_HWMON gets enabled or
  disabled.

* This avoids breaking the thermal kABI in these cases too, which should
  make distributions happy.

The only drawback I can see is slightly higher memory fragmentation, as
the number of kzalloc() calls will increase by one per thermal zone.  But
I doubt it will be a problem in practice, as I've never seen a system with
more than two thermal zones.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rene Herman <rene.herman@gmail.com>
Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |  117 ++++++++++++++++++++++++++++++++---------
 include/linux/thermal.h       |   22 --------
 2 files changed, 92 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index b6353d6..708f8e9 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -420,6 +420,29 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 
 /* hwmon sys I/F */
 #include <linux/hwmon.h>
+
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
+
+/* one temperature input for each thermal zone */
+struct thermal_hwmon_temp {
+	struct list_head hwmon_node;
+	struct thermal_zone_device *tz;
+	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
+	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
+};
+
 static LIST_HEAD(thermal_hwmon_list);
 
 static ssize_t
@@ -437,9 +460,10 @@ temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int ret;
 	struct thermal_hwmon_attr *hwmon_attr
 			= container_of(attr, struct thermal_hwmon_attr, attr);
-	struct thermal_zone_device *tz
-			= container_of(hwmon_attr, struct thermal_zone_device,
+	struct thermal_hwmon_temp *temp
+			= container_of(hwmon_attr, struct thermal_hwmon_temp,
 				       temp_input);
+	struct thermal_zone_device *tz = temp->tz;
 
 	ret = tz->ops->get_temp(tz, &temperature);
 
@@ -455,9 +479,10 @@ temp_crit_show(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_hwmon_attr *hwmon_attr
 			= container_of(attr, struct thermal_hwmon_attr, attr);
-	struct thermal_zone_device *tz
-			= container_of(hwmon_attr, struct thermal_zone_device,
+	struct thermal_hwmon_temp *temp
+			= container_of(hwmon_attr, struct thermal_hwmon_temp,
 				       temp_crit);
+	struct thermal_zone_device *tz = temp->tz;
 	long temperature;
 	int ret;
 
@@ -485,10 +510,29 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 	return NULL;
 }
 
+/* Find the temperature input matching a given thermal zone */
+static struct thermal_hwmon_temp *
+thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
+			  const struct thermal_zone_device *tz)
+{
+	struct thermal_hwmon_temp *temp;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(temp, &hwmon->tz_list, hwmon_node)
+		if (temp->tz == tz) {
+			mutex_unlock(&thermal_list_lock);
+			return temp;
+		}
+	mutex_unlock(&thermal_list_lock);
+
+	return NULL;
+}
+
 static int
 thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
+	struct thermal_hwmon_temp *temp;
 	int new_hwmon_device = 1;
 	int result;
 
@@ -515,30 +559,36 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 		goto free_mem;
 
  register_sys_interface:
-	tz->hwmon = hwmon;
+	temp = kzalloc(sizeof(struct thermal_hwmon_temp), GFP_KERNEL);
+	if (!temp) {
+		result = -ENOMEM;
+		goto unregister_name;
+	}
+
+	temp->tz = tz;
 	hwmon->count++;
 
-	snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
+	snprintf(temp->temp_input.name, THERMAL_NAME_LENGTH,
 		 "temp%d_input", hwmon->count);
-	tz->temp_input.attr.attr.name = tz->temp_input.name;
-	tz->temp_input.attr.attr.mode = 0444;
-	tz->temp_input.attr.show = temp_input_show;
-	sysfs_attr_init(&tz->temp_input.attr.attr);
-	result = device_create_file(hwmon->device, &tz->temp_input.attr);
+	temp->temp_input.attr.attr.name = temp->temp_input.name;
+	temp->temp_input.attr.attr.mode = 0444;
+	temp->temp_input.attr.show = temp_input_show;
+	sysfs_attr_init(&temp->temp_input.attr.attr);
+	result = device_create_file(hwmon->device, &temp->temp_input.attr);
 	if (result)
-		goto unregister_name;
+		goto free_temp_mem;
 
 	if (tz->ops->get_crit_temp) {
 		unsigned long temperature;
 		if (!tz->ops->get_crit_temp(tz, &temperature)) {
-			snprintf(tz->temp_crit.name, THERMAL_NAME_LENGTH,
+			snprintf(temp->temp_crit.name, THERMAL_NAME_LENGTH,
 				"temp%d_crit", hwmon->count);
-			tz->temp_crit.attr.attr.name = tz->temp_crit.name;
-			tz->temp_crit.attr.attr.mode = 0444;
-			tz->temp_crit.attr.show = temp_crit_show;
-			sysfs_attr_init(&tz->temp_crit.attr.attr);
+			temp->temp_crit.attr.attr.name = temp->temp_crit.name;
+			temp->temp_crit.attr.attr.mode = 0444;
+			temp->temp_crit.attr.show = temp_crit_show;
+			sysfs_attr_init(&temp->temp_crit.attr.attr);
 			result = device_create_file(hwmon->device,
-						    &tz->temp_crit.attr);
+						    &temp->temp_crit.attr);
 			if (result)
 				goto unregister_input;
 		}
@@ -547,13 +597,15 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	mutex_lock(&thermal_list_lock);
 	if (new_hwmon_device)
 		list_add_tail(&hwmon->node, &thermal_hwmon_list);
-	list_add_tail(&tz->hwmon_node, &hwmon->tz_list);
+	list_add_tail(&temp->hwmon_node, &hwmon->tz_list);
 	mutex_unlock(&thermal_list_lock);
 
 	return 0;
 
  unregister_input:
-	device_remove_file(hwmon->device, &tz->temp_input.attr);
+	device_remove_file(hwmon->device, &temp->temp_input.attr);
+ free_temp_mem:
+	kfree(temp);
  unregister_name:
 	if (new_hwmon_device) {
 		device_remove_file(hwmon->device, &dev_attr_name);
@@ -569,15 +621,30 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 static void
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
-	struct thermal_hwmon_device *hwmon = tz->hwmon;
+	struct thermal_hwmon_device *hwmon;
+	struct thermal_hwmon_temp *temp;
+
+	hwmon = thermal_hwmon_lookup_by_type(tz);
+	if (unlikely(!hwmon)) {
+		/* Should never happen... */
+		dev_dbg(&tz->device, "hwmon device lookup failed!\n");
+		return;
+	}
+
+	temp = thermal_hwmon_lookup_temp(hwmon, tz);
+	if (unlikely(!temp)) {
+		/* Should never happen... */
+		dev_dbg(&tz->device, "temperature input lookup failed!\n");
+		return;
+	}
 
-	tz->hwmon = NULL;
-	device_remove_file(hwmon->device, &tz->temp_input.attr);
+	device_remove_file(hwmon->device, &temp->temp_input.attr);
 	if (tz->ops->get_crit_temp)
-		device_remove_file(hwmon->device, &tz->temp_crit.attr);
+		device_remove_file(hwmon->device, &temp->temp_crit.attr);
 
 	mutex_lock(&thermal_list_lock);
-	list_del(&tz->hwmon_node);
+	list_del(&temp->hwmon_node);
+	kfree(temp);
 	if (!list_empty(&hwmon->tz_list)) {
 		mutex_unlock(&thermal_list_lock);
 		return;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d3ec89f..47b4a27 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -85,22 +85,6 @@ struct thermal_cooling_device {
 				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
 #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
 
-#if defined(CONFIG_THERMAL_HWMON)
-/* thermal zone devices with the same type share one hwmon device */
-struct thermal_hwmon_device {
-	char type[THERMAL_NAME_LENGTH];
-	struct device *device;
-	int count;
-	struct list_head tz_list;
-	struct list_head node;
-};
-
-struct thermal_hwmon_attr {
-	struct device_attribute attr;
-	char name[16];
-};
-#endif
-
 struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
@@ -120,12 +104,6 @@ struct thermal_zone_device {
 	struct mutex lock;	/* protect cooling devices list */
 	struct list_head node;
 	struct delayed_work poll_queue;
-#if defined(CONFIG_THERMAL_HWMON)
-	struct list_head hwmon_node;
-	struct thermal_hwmon_device *hwmon;
-	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
-	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
-#endif
 };
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-- 
1.7.6.396.ge0613

