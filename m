From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 02/16] Thermal: Add Hysteresis attributes
Date: Thu, 19 Jul 2012 14:31:06 +0800
Message-ID: <1342679480-5336-3-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab2GSGbj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:31:39 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <dugardoss.r@intel.com>

The Linux Thermal Framework does not support hysteresis
attributes. Most thermal sensors, today, have a
hysteresis value associated with trip points.

This patch adds hysteresis attributes on a per-trip-point
basis, to the Thermal Framework. These attributes are
optionally writable.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |    6 +++
 drivers/thermal/thermal_sys.c       |   89 ++++++++++++++++++++++++++++++++---
 include/linux/thermal.h             |    5 ++
 3 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 0c7c423..3c8c2f8 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -121,6 +121,7 @@ if hwmon is compiled in or built as a module.
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
index a590d57..95e0d63 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -240,6 +240,52 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
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
+			char *buf)
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
@@ -1092,21 +1138,29 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int flag)
 {
 	int indx;
 	int writeable;
+	int size = sizeof(struct thermal_attr) * tz->trips;
 
-	tz->trip_type_attrs =
-		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
+	tz->trip_type_attrs = kzalloc(size, GFP_KERNEL);
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
-	tz->trip_temp_attrs =
-		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
+	tz->trip_temp_attrs = kzalloc(size, GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
 		return -ENOMEM;
 	}
 
-	for (indx = 0; indx < tz->trips; indx++) {
+	if (tz->ops->get_trip_hyst) {
+		tz->trip_hyst_attrs = kzalloc(size, GFP_KERNEL);
+		if (!tz->trip_hyst_attrs) {
+			kfree(tz->trip_type_attrs);
+			kfree(tz->trip_temp_attrs);
+			return -ENOMEM;
+		}
+	}
+
 
+	for (indx = 0; indx < tz->trips; indx++) {
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_type", indx);
@@ -1138,6 +1192,26 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int flag)
 
 		device_create_file(&tz->device,
 				   &tz->trip_temp_attrs[indx].attr);
+
+		/* create Optional trip hyst attribute */
+		if (!tz->ops->get_trip_hyst)
+			continue;
+		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_hyst", indx);
+
+		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
+		tz->trip_hyst_attrs[indx].attr.attr.name =
+					tz->trip_hyst_attrs[indx].name;
+		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
+		if (tz->ops->set_trip_hyst) {
+			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
+			tz->trip_hyst_attrs[indx].attr.store =
+					trip_point_hyst_store;
+		}
+
+		device_create_file(&tz->device,
+				   &tz->trip_hyst_attrs[indx].attr);
 	}
 	return 0;
 }
@@ -1151,9 +1225,13 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 				   &tz->trip_type_attrs[indx].attr);
 		device_remove_file(&tz->device,
 				   &tz->trip_temp_attrs[indx].attr);
+		if (tz->ops->get_trip_hyst)
+			device_remove_file(&tz->device,
+				  &tz->trip_hyst_attrs[indx].attr);
 	}
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
+	kfree(tz->trip_hyst_attrs);
 }
 
 /**
@@ -1300,7 +1378,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
-	int count;
 
 	if (!tz)
 		return;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6eaf914..cfc8d90 100644
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
@@ -98,6 +102,7 @@ struct thermal_zone_device {
 	struct device device;
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
+	struct thermal_attr *trip_hyst_attrs;
 	void *devdata;
 	int trips;
 	int tc1;
-- 
1.7.9.5

