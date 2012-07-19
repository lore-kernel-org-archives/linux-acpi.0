From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 15/16] Thermal: Unify the code for both active and passive cooling
Date: Thu, 19 Jul 2012 14:31:19 +0800
Message-ID: <1342679480-5336-16-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256Ab2GSGcI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:32:08 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

Remove thermal_zone_device_passive(). And use
thermal_zone_trip_update() and thermal_zone_do_update()
for both active and passive cooling.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   97 ++++++++++-------------------------------
 include/linux/thermal.h       |    2 +-
 2 files changed, 24 insertions(+), 75 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 803ce94..a40dda1 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -725,73 +725,6 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 				      msecs_to_jiffies(delay));
 }
 
-static void thermal_zone_device_passive(struct thermal_zone_device *tz,
-					int temp, int trip_temp, int trip)
-{
-	int trend = 0;
-	struct thermal_instance *instance;
-	struct thermal_cooling_device *cdev;
-	long state, max_state;
-
-	/*
-	 * Above Trip?
-	 * -----------
-	 * Calculate the thermal trend (using the passive cooling equation)
-	 * and modify the performance limit for all passive cooling devices
-	 * accordingly.  Note that we assume symmetry.
-	 */
-	if (temp >= trip_temp) {
-		tz->passive = true;
-
-		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
-
-		/* Heating up? */
-		if (trend > 0) {
-			list_for_each_entry(instance, &tz->instances,
-					    tz_node) {
-				if (instance->trip != trip)
-					continue;
-				cdev = instance->cdev;
-				cdev->ops->get_cur_state(cdev, &state);
-				cdev->ops->get_max_state(cdev, &max_state);
-				if (state++ < max_state)
-					cdev->ops->set_cur_state(cdev, state);
-			}
-		} else if (trend < 0) { /* Cooling off? */
-			list_for_each_entry(instance, &tz->instances,
-					    tz_node) {
-				if (instance->trip != trip)
-					continue;
-				cdev = instance->cdev;
-				cdev->ops->get_cur_state(cdev, &state);
-				cdev->ops->get_max_state(cdev, &max_state);
-				if (state > 0)
-					cdev->ops->set_cur_state(cdev, --state);
-			}
-		}
-		return;
-	}
-
-	/*
-	 * Below Trip?
-	 * -----------
-	 * Implement passive cooling hysteresis to slowly increase performance
-	 * and avoid thrashing around the passive trip point.  Note that we
-	 * assume symmetry.
-	 */
-	list_for_each_entry(instance, &tz->instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-		cdev = instance->cdev;
-		cdev->ops->get_cur_state(cdev, &state);
-		cdev->ops->get_max_state(cdev, &max_state);
-		if (state > 0)
-			cdev->ops->set_cur_state(cdev, --state);
-		if (state == 0)
-			tz->passive = false;
-	}
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -1111,7 +1044,7 @@ static void thermal_zone_do_update(struct thermal_zone_device *tz)
 }
 
 /*
- * Cooling algorithm for active trip points
+ * Cooling algorithm for both active and passive cooling
  *
  * 1. if the temperature is higher than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
@@ -1133,9 +1066,16 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 	struct thermal_cooling_device *cdev = NULL;
 	unsigned long cur_state, max_state;
 	long trip_temp;
+	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	if (trip == THERMAL_TRIPS_NONE) {
+		trip_temp = tz->forced_passive;
+		trip_type = THERMAL_TRIPS_NONE;
+	} else {
+		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+	}
 
 	if (temp >= trip_temp) {
 		thermal_get_trend(tz, trip, &trend);
@@ -1156,6 +1096,12 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 				cur_state = cur_state > instance->lower ?
 				    (cur_state - 1) : instance->lower;
 			}
+
+			/* activate a passive thermal instance */
+			if (trip_type == THERMAL_TRIP_PASSIVE &&
+			    instance->target == -1)
+				tz->passive++;
+
 			instance->target = cur_state;
 			cdev->updated = 0; /* cooling device needs update */
 		}
@@ -1172,6 +1118,11 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 
 			cur_state = cur_state > instance->lower ?
 				    (cur_state - 1) : -1;
+
+			/* deactivate a passive thermal instance */
+			if (trip_type == THERMAL_TRIP_PASSIVE &&
+			    cur_state == -1)
+				tz->passive--;
 			instance->target = cur_state;
 			cdev->updated = 0; /* cooling device needs update */
 		}
@@ -1228,16 +1179,14 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 			break;
 		case THERMAL_TRIP_PASSIVE:
 			if (temp >= trip_temp || tz->passive)
-				thermal_zone_device_passive(tz, temp,
-							    trip_temp, count);
+				thermal_zone_trip_update(tz, count, temp);
 			break;
 		}
 	}
 
-	thermal_zone_do_update(tz);
 	if (tz->forced_passive)
-		thermal_zone_device_passive(tz, temp, tz->forced_passive,
-					    THERMAL_TRIPS_NONE);
+		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE, temp);
+	thermal_zone_do_update(tz);
 
 leave:
 	if (tz->passive)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 604c0f0..f725eb9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -119,7 +119,7 @@ struct thermal_zone_device {
 	int polling_delay;
 	int temperature;
 	int last_temperature;
-	bool passive;
+	int passive;
 	unsigned int forced_passive;
 	const struct thermal_zone_device_ops *ops;
 	struct list_head instances;
-- 
1.7.9.5

