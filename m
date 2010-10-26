From: durgadoss.r@intel.com
Subject: [PATCH] Adding_write_support_to_trip_points
Date: Wed, 27 Oct 2010 01:16:50 +0530
Message-ID: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52545 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab0JZIIk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 04:08:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: alan@linux.intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, durgadoss.r@intel.com, ramesh.agarwal@intel.com, len.brown@intel.com

From: R.Durgadoss <durgadoss.r@intel.com>

This patch makes the thermal trip points 'write'able.
Thus, enabling the trip points to be configured at runtime.
Please review and apply.

Signed-off-by: R.Durgadoss <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   60 ++++++++++++++++++++++++++++++++--------
 include/linux/thermal.h       |    2 +
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 13c72c6..63b75dc 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -216,6 +216,30 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_temp_store(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, result;
+	unsigned long temperature;
+
+	if (!tz->ops->set_trip_temp)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "trip_point_%d_type", &trip))
+		return -EINVAL;
+
+	if (strict_strtoul(buf, 10, &temperature))
+		return -EINVAL;
+
+	mutex_lock(&thermal_trip_lock);
+	result = tz->ops->set_trip_temp(tz, trip, temperature);
+	mutex_unlock(&thermal_trip_lock);
+
+	return (result == 0) ? count : -EINVAL;
+}
+
+static ssize_t
 passive_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
@@ -284,29 +308,41 @@ static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
 
 static struct device_attribute trip_point_attrs[] = {
 	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_0_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_0_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_1_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_1_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_1_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_2_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_2_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_2_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_3_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_3_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_3_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_4_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_4_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_4_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_5_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_5_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_5_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_6_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_6_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_6_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_7_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_7_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_7_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_8_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_8_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_8_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_9_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_9_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_9_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_10_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_10_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_10_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 	__ATTR(trip_point_11_type, 0444, trip_point_type_show, NULL),
-	__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_11_temp, S_IRUGO | S_IWUSR, trip_point_temp_show,
+						trip_point_temp_store),
 };
 
 #define TRIP_POINT_ATTR_ADD(_dev, _index, result)     \
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1de8b9e..e5cc53b 100644
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
-- 
1.7.2.3

