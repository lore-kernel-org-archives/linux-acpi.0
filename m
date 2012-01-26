From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 1/2] ACPI-Thermal: Make Thermal trip points writeable
Date: Thu, 26 Jan 2012 22:05:48 +0530
Message-ID: <1327595749-17673-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35376 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2AZLGg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2012 06:06:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, Durgadoss R <durgadoss.r@intel.com>

Some of the thermal drivers using the Generic Thermal Framework
require (all/some) trip points to be writeable. This patch makes
the trip point temperatures writeable on a per-trip point basis.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |  127 +++++++++++++++++++++++++---------------
 include/linux/thermal.h       |   10 ++-
 2 files changed, 86 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index dd9a574..a8f5785 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -220,6 +220,28 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_temp_store(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, ret;
+	unsigned long temperature;
+
+	if (!tz->ops->set_trip_temp)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
+		return -EINVAL;
+
+	if (kstrtoul(buf, 10, &temperature))
+		return -EINVAL;
+
+	ret = tz->ops->set_trip_temp(tz, trip, temperature);
+
+	return ret ? ret : count;
+}
+
+static ssize_t
 passive_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
@@ -286,49 +308,6 @@ static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
 		   passive_store);
 
-static struct device_attribute trip_point_attrs[] = {
-	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_0_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_1_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_1_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_2_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_2_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_3_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_3_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_4_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_4_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_5_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_5_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_6_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_6_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_7_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_7_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_8_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_8_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_9_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_9_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_10_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_10_temp, 0444, trip_point_temp_show, NULL),
-	__ATTR(trip_point_11_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, NULL),
-};
-
-#define TRIP_POINT_ATTR_ADD(_dev, _index, result)     \
-do {    \
-	result = device_create_file(_dev,	\
-				&trip_point_attrs[_index * 2]);	\
-	if (result)	\
-		break;	\
-	result = device_create_file(_dev,	\
-			&trip_point_attrs[_index * 2 + 1]);	\
-} while (0)
-
-#define TRIP_POINT_ATTR_REMOVE(_dev, _index)	\
-do {	\
-	device_remove_file(_dev, &trip_point_attrs[_index * 2]);	\
-	device_remove_file(_dev, &trip_point_attrs[_index * 2 + 1]);	\
-} while (0)
-
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
@@ -1112,9 +1091,54 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 EXPORT_SYMBOL(thermal_zone_device_update);
 
 /**
+ * create_trip_type_attr - creates a trip point type attribute
+ * @tz:		the thermal zone device
+ * @indx:	index into the trip_type_attrs array
+ */
+static int create_trip_type_attr(struct thermal_zone_device *tz, int indx)
+{
+	char attr_name[THERMAL_NAME_LENGTH];
+
+	snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_type", indx);
+
+	sysfs_attr_init(&tz->trip_type_attrs[indx].attr);
+	tz->trip_type_attrs[indx].attr.name = attr_name;
+	tz->trip_type_attrs[indx].attr.mode = S_IRUGO;
+	tz->trip_type_attrs[indx].show = trip_point_type_show;
+
+	return device_create_file(&tz->device, &tz->trip_type_attrs[indx]);
+}
+
+/**
+ * create_trip_temp_attr - creates a trip point temp attribute
+ * @tz:		the thermal zone device
+ * @indx:	index into the trip_type_attrs array
+ * @writeable:	A flag: If 1, 'this' trip point is writeable; otherwise not
+ */
+static int create_trip_temp_attr(struct thermal_zone_device *tz,
+				int indx, int writeable)
+{
+	char attr_name[THERMAL_NAME_LENGTH];
+
+	snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_temp", indx);
+
+	sysfs_attr_init(&tz->trip_temp_attrs[indx].attr);
+	tz->trip_temp_attrs[indx].attr.name = attr_name;
+	tz->trip_temp_attrs[indx].attr.mode = S_IRUGO;
+	tz->trip_temp_attrs[indx].show = trip_point_temp_show;
+	if (writeable) {
+		tz->trip_temp_attrs[indx].attr.mode |= S_IWUSR;
+		tz->trip_temp_attrs[indx].store = trip_point_temp_store;
+	}
+
+	return device_create_file(&tz->device, &tz->trip_temp_attrs[indx]);
+}
+
+/**
  * thermal_zone_device_register - register a new thermal zone device
  * @type:	the thermal zone device type
  * @trips:	the number of trip points the thermal zone support
+ * @flag:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
  * @tc1:	thermal coefficient 1 for passive calculations
@@ -1130,7 +1154,7 @@ EXPORT_SYMBOL(thermal_zone_device_update);
  * section 11.1.5.1 of the ACPI specification 3.0.
  */
 struct thermal_zone_device *thermal_zone_device_register(char *type,
-	int trips, void *devdata,
+	int trips, int flag, void *devdata,
 	const struct thermal_zone_device_ops *ops,
 	int tc1, int tc2, int passive_delay, int polling_delay)
 {
@@ -1199,9 +1223,15 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	}
 
 	for (count = 0; count < trips; count++) {
-		TRIP_POINT_ATTR_ADD(&tz->device, count, result);
+		result = create_trip_type_attr(tz, count);
 		if (result)
 			goto unregister;
+
+		result = create_trip_temp_attr(tz, count,
+						(flag & (1 << count)));
+		if (result)
+			goto unregister;
+
 		tz->ops->get_trip_type(tz, count, &trip_type);
 		if (trip_type == THERMAL_TRIP_PASSIVE)
 			passive = 1;
@@ -1279,9 +1309,10 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
 
-	for (count = 0; count < tz->trips; count++)
-		TRIP_POINT_ATTR_REMOVE(&tz->device, count);
-
+	for (count = 0; count < tz->trips; count++) {
+		device_remove_file(&tz->device, &tz->trip_type_attrs[count]);
+		device_remove_file(&tz->device, &tz->trip_temp_attrs[count]);
+	}
 	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 47b4a27..4aa5a45 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -58,6 +58,8 @@ struct thermal_zone_device_ops {
 		enum thermal_trip_type *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int,
 			      unsigned long *);
+	int (*set_trip_temp) (struct thermal_zone_device *, int,
+			      unsigned long);
 	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
@@ -89,6 +91,8 @@ struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
+	struct device_attribute trip_temp_attrs[THERMAL_MAX_TRIPS];
+	struct device_attribute trip_type_attrs[THERMAL_MAX_TRIPS];
 	void *devdata;
 	int trips;
 	int tc1;
@@ -137,9 +141,9 @@ enum {
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
-struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
-		const struct thermal_zone_device_ops *, int tc1, int tc2,
-		int passive_freq, int polling_freq);
+struct thermal_zone_device *thermal_zone_device_register(char *, int, int,
+		void *, const struct thermal_zone_device_ops *, int tc1,
+		int tc2, int passive_freq, int polling_freq);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-- 
1.7.1

