From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Thu, 19 Jul 2012 14:31:13 +0800
Message-ID: <1342679480-5336-10-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab2GSGby (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:31:54 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

This function is used to update the cooling state of
all the cooling devices that are binded to an active trip point.

This will be used for passive cooling as well, in the future patches.
as both active and passive cooling can share the same algorithm,
which is

1. if the temperature is higher than a trip point,
   a. if the trend is THERMAL_TREND_RAISING, use higher cooling
      state for this trip point
   b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
      state for this trip point

2. if the temperature is lower than a trip point, use lower
   cooling state for this trip point.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c        |    7 +++-
 drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 73e335f..14c4879 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -715,7 +715,12 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	if (thermal_get_trip_type(thermal, trip, &type))
 		return -EINVAL;
 
-	/* Only PASSIVE trip points need TREND */
+	if (type == THERMAL_TRIP_ACTIVE) {
+		/* aggressive active cooling */
+		*trend = THERMAL_TREND_RAISING;
+		return 0;
+	}
+
 	if (type != THERMAL_TRIP_PASSIVE)
 		return -EINVAL;
 
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 59af3b8..011faba 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1076,6 +1076,70 @@ void thermal_cooling_device_unregister(struct
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
+/*
+ * Cooling algorithm for active trip points
+ *
+ * 1. if the temperature is higher than a trip point,
+ *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
+ *       state for this trip point
+ *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
+ *       state for this trip point
+ *
+ * 2. if the temperature is lower than a trip point, use lower
+ *    cooling state for this trip point
+ *
+ * Note that this behaves the same as the previous passive cooling
+ * algorithm.
+ */
+
+static void thermal_zone_trip_update(struct thermal_zone_device *tz,
+				     int trip, long temp)
+{
+	struct thermal_cooling_device_instance *instance;
+	struct thermal_cooling_device *cdev = NULL;
+	unsigned long cur_state, max_state;
+	long trip_temp;
+	enum thermal_trend trend;
+
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+
+	if (temp >= trip_temp) {
+		thermal_get_trend(tz, trip, &trend);
+
+		list_for_each_entry(instance, &tz->cooling_devices, node) {
+			if (instance->trip != trip)
+				continue;
+
+			cdev = instance->cdev;
+
+			cdev->ops->get_cur_state(cdev, &cur_state);
+			cdev->ops->get_max_state(cdev, &max_state);
+
+			if (trend == THERMAL_TREND_RAISING) {
+				cur_state = cur_state < instance->upper ?
+					    (cur_state + 1) : instance->upper;
+			} else if (trend == THERMAL_TREND_DROPPING) {
+				cur_state = cur_state > instance->lower ?
+				    (cur_state - 1) : instance->lower;
+			}
+			cdev->ops->set_cur_state(cdev, cur_state);
+		}
+	} else {	/* below trip */
+		list_for_each_entry(instance, &tz->cooling_devices, node) {
+			if (instance->trip != trip)
+				continue;
+
+			cdev = instance->cdev;
+			cdev->ops->get_cur_state(cdev, &cur_state);
+
+			cur_state = cur_state > instance->lower ?
+				    (cur_state - 1) : instance->lower;
+			cdev->ops->set_cur_state(cdev, cur_state);
+		}
+	}
+
+	return;
+}
 /**
  * thermal_zone_device_update - force an update of a thermal zone's state
  * @ttz:	the thermal zone to update
@@ -1086,9 +1150,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 	int count, ret = 0;
 	long temp, trip_temp;
 	enum thermal_trip_type trip_type;
-	struct thermal_cooling_device_instance *instance;
-	struct thermal_cooling_device *cdev;
-	unsigned long cur_state, max_state;
 
 	mutex_lock(&tz->lock);
 
@@ -1124,29 +1185,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 					tz->ops->notify(tz, count, trip_type);
 			break;
 		case THERMAL_TRIP_ACTIVE:
-			list_for_each_entry(instance, &tz->cooling_devices,
-					    node) {
-				if (instance->trip != count)
-					continue;
-
-				cdev = instance->cdev;
-
-				cdev->ops->get_cur_state(cdev, &cur_state);
-				cdev->ops->get_max_state(cdev, &max_state);
-
-				if (temp >= trip_temp)
-					cur_state =
-						cur_state < instance->upper ?
-						(cur_state + 1) :
-						instance->upper;
-				else
-					cur_state =
-						cur_state > instance->lower ?
-						(cur_state - 1) :
-						instance->lower;
-
-				cdev->ops->set_cur_state(cdev, cur_state);
-			}
+			thermal_zone_trip_update(tz, count, temp);
 			break;
 		case THERMAL_TRIP_PASSIVE:
 			if (temp >= trip_temp || tz->passive)
-- 
1.7.9.5

