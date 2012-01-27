From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH] ACPI-Thermal: Make Thermal trip points writeable
Date: Fri, 27 Jan 2012 21:58:12 +0530
Message-ID: <1327681692-19299-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29006 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab2A0K6u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jan 2012 05:58:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, Durgadoss R <durgadoss.r@intel.com>

Some of the thermal drivers using the Generic Thermal Framework
require (all/some) trip points to be writeable. This patch makes
the trip point temperatures writeable on a per-trip point basis,
and modifies the required function call in thermal.c. This patch
also updates the Documentation to reflect the new change.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
v1
* patch1/2: Code for making trip points writeable
* patch2/2: Change the callee in thermal.c
v2
* Make both the changes in a single patch
* Update Documentation/thermal/sysfs-api.txt
---
 Documentation/thermal/sysfs-api.txt |    4 +-
 drivers/acpi/thermal.c              |    4 +-
 drivers/thermal/thermal_sys.c       |  127 ++++++++++++++++++++++-------------
 include/linux/thermal.h             |   10 ++-
 4 files changed, 91 insertions(+), 54 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index b61e46f..cd1476c 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -32,7 +32,8 @@ temperature) and throttle appropriate devices.
 
 1.1 thermal zone device interface
 1.1.1 struct thermal_zone_device *thermal_zone_device_register(char *name,
-		int trips, void *devdata, struct thermal_zone_device_ops *ops)
+		int trips, int flag, void *devdata,
+		struct thermal_zone_device_ops *ops)
 
     This interface function adds a new thermal zone device (sensor) to
     /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
@@ -40,6 +41,7 @@ temperature) and throttle appropriate devices.
 
     name: the thermal zone name.
     trips: the total number of trip points this thermal zone supports.
+    flag: Bit string: If 'n'th bit is set, then trip point 'n' is writeable.
     devdata: device private data
     ops: thermal zone device call-backs.
 	.bind: bind the thermal zone device with a thermal cooling device.
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 48fbc64..1c3133e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -845,7 +845,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, tz,
+			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     &acpi_thermal_zone_ops,
 						     tz->trips.passive.tc1,
 						     tz->trips.passive.tc2,
@@ -853,7 +853,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, tz,
+			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     &acpi_thermal_zone_ops,
 						     0, 0, 0,
 						     tz->polling_frequency*100);
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index dd9a574..3a4341e 100644
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

