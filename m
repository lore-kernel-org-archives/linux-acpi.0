From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2] ACPI-Thermal: Add Hysteresis attributes
Date: Fri, 29 Jun 2012 02:55:53 +0530
Message-ID: <1340918753-19476-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15453 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab2F2JDo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jun 2012 05:03:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

The Linux Thermal Framework does not support hysteresis
attributes. Most thermal sensors, today, have a
hysteresis value associated with trip points.

This patch adds hysteresis attributes on a per-trip-point
basis, to the Thermal Framework. These attributes are
optionally writable.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
* This patch depends on v6 of 'writable trip points' patch.
* Fixed an invalid memory reference in create_trip_hyst_attr function.
---
 Documentation/thermal/sysfs-api.txt |    6 +++
 drivers/thermal/thermal_sys.c       |   80 +++++++++++++++++++++++++++++++++++
 include/linux/thermal.h             |    5 ++
 3 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 0c7c423..3c8c2f8 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -121,6 +121,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---mode:			Working mode of the thermal zone
     |---trip_point_[0-*]_temp:	Trip point temperature
     |---trip_point_[0-*]_type:	Trip point type
+    |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
 
 Thermal cooling device sys I/F, created once it's registered:
 /sys/class/thermal/cooling_device[0-*]:
@@ -190,6 +191,11 @@ trip_point_[0-*]_type
 	thermal zone.
 	RO, Optional
 
+trip_point_[0-*]_hyst
+	The hysteresis value for a trip point, represented as an integer
+	Unit: Celsius
+	RW, Optional
+
 cdev[0-*]
 	Sysfs link to the thermal cooling device node where the sys I/F
 	for cooling device throttling control represents.
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 9dfa940..ddfc93e 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -240,6 +240,52 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, ret;
+	unsigned long temperature;
+
+	if (!tz->ops->set_trip_hyst)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+		return -EINVAL;
+
+	if (kstrtoul(buf, 10, &temperature))
+		return -EINVAL;
+
+	/*
+	 * We are not doing any check on the 'temperature' value
+	 * here. The driver implementing 'set_trip_hyst' has to
+	 * take care of this.
+	 */
+	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+
+	return ret ? ret : count;
+}
+
+static ssize_t
+trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, ret;
+	unsigned long temperature;
+
+	if (!tz->ops->get_trip_hyst)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+
+	return ret ? ret : sprintf(buf, "%ld\n", temperature);
+}
+
+static ssize_t
 passive_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
@@ -1132,6 +1178,31 @@ static int create_trip_temp_attr(struct thermal_zone_device *tz,
 }
 
 /**
+ * create_trip_hyst_attr - creates hysteresis attribute for a trip point
+ * @tz:		the thermal zone device
+ * @indx:	index into the trip_hyst_attrs array
+ */
+static int create_trip_hyst_attr(struct thermal_zone_device *tz, int indx)
+{
+	char *attr_name = kzalloc(THERMAL_NAME_LENGTH, GFP_KERNEL);
+	if (!attr_name)
+		return -ENOMEM;
+
+	snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_hyst", indx);
+
+	sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr);
+	tz->trip_hyst_attrs[indx].attr.name = attr_name;
+	tz->trip_hyst_attrs[indx].attr.mode = S_IRUGO;
+	tz->trip_hyst_attrs[indx].show = trip_point_hyst_show;
+	if (tz->ops->set_trip_hyst) {
+		tz->trip_hyst_attrs[indx].attr.mode |= S_IWUSR;
+		tz->trip_hyst_attrs[indx].store = trip_point_hyst_store;
+	}
+
+	return device_create_file(&tz->device, &tz->trip_hyst_attrs[indx]);
+}
+
+/**
  * thermal_zone_device_register - register a new thermal zone device
  * @type:	the thermal zone device type
  * @trips:	the number of trip points the thermal zone support
@@ -1231,6 +1302,12 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 		if (result)
 			goto unregister;
 
+		if (tz->ops->get_trip_hyst) {
+			result = create_trip_hyst_attr(tz, count);
+			if (result)
+				goto unregister;
+		}
+
 		tz->ops->get_trip_type(tz, count, &trip_type);
 		if (trip_type == THERMAL_TRIP_PASSIVE)
 			passive = 1;
@@ -1310,6 +1387,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	for (count = 0; count < tz->trips; count++) {
 		device_remove_file(&tz->device, &tz->trip_type_attrs[count]);
 		device_remove_file(&tz->device, &tz->trip_temp_attrs[count]);
+		if (tz->ops->get_trip_hyst)
+			device_remove_file(&tz->device,
+						&tz->trip_hyst_attrs[count]);
 	}
 	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 825d4b0..c1e1883 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -60,6 +60,10 @@ struct thermal_zone_device_ops {
 			      unsigned long *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int,
 			      unsigned long);
+	int (*get_trip_hyst) (struct thermal_zone_device *, int,
+			      unsigned long *);
+	int (*set_trip_hyst) (struct thermal_zone_device *, int,
+			      unsigned long);
 	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
@@ -93,6 +97,7 @@ struct thermal_zone_device {
 	struct device device;
 	struct device_attribute trip_temp_attrs[THERMAL_MAX_TRIPS];
 	struct device_attribute trip_type_attrs[THERMAL_MAX_TRIPS];
+	struct device_attribute trip_hyst_attrs[THERMAL_MAX_TRIPS];
 	void *devdata;
 	int trips;
 	int tc1;
-- 
1.7.0.4

