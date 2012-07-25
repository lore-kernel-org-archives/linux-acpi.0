From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 07/16] Thermal: Introduce .get_trend() callback.
Date: Wed, 25 Jul 2012 10:11:04 +0800
Message-ID: <1343182273-32096-8-git-send-email-rui.zhang@intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36673 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab2GYCLj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 22:11:39 -0400
In-Reply-To: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

tc1 and tc2 are used by OSPM to anticipate the temperature trends.
But they are ACPI platform specific concepts.

Introduce .get_trend() as a more general solution.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c        |   33 +++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sys.c |   22 ++++++++++++++++++++--
 include/linux/thermal.h       |    9 +++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0154eac..01c92fd 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -704,6 +704,38 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 		return -EINVAL;
 }
 
+static int thermal_get_trend(struct thermal_zone_device *thermal,
+				int trip, enum thermal_trend *trend)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+	enum thermal_trip_type type;
+	int i;
+
+	if (thermal_get_trip_type(thermal, trip, &type))
+		return -EINVAL;
+
+	/* Only PASSIVE trip points need TREND */
+	if (type != THERMAL_TRIP_PASSIVE)
+		return -EINVAL;
+
+	/*
+	 * tz->temperature has already been updated by generic thermal layer,
+	 * before this callback being invoked
+	 */
+	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature))
+		+ (tz->trips.passive.tc2
+		* (tz->temperature - tz->trips.passive.temperature));
+
+	if (i > 0)
+		*trend = THERMAL_TREND_RAISING;
+	else if (i < 0)
+		*trend = THERMAL_TREND_DROPPING;
+	else
+		*trend = THERMAL_TREND_STABLE;
+	return 0;
+}
+
+
 static int thermal_notify(struct thermal_zone_device *thermal, int trip,
 			   enum thermal_trip_type trip_type)
 {
@@ -836,6 +868,7 @@ static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.get_trip_type = thermal_get_trip_type,
 	.get_trip_temp = thermal_get_trip_temp,
 	.get_crit_temp = thermal_get_crit_temp,
+	.get_trend = thermal_get_trend,
 	.notify = thermal_notify,
 };
 
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 62b4279..d406524 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -699,6 +699,21 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 }
 #endif
 
+static void thermal_get_trend(struct thermal_zone_device *tz,
+		int trip, enum thermal_trend *trend)
+{
+	if (tz->ops->get_trend && !tz->ops->get_trend(tz, trip, trend))
+			return;
+
+	if (tz->temperature > tz->last_temperature)
+		*trend = THERMAL_TREND_RAISING;
+	else if (tz->temperature < tz->last_temperature)
+		*trend = THERMAL_TREND_DROPPING;
+	else
+		*trend = THERMAL_TREND_STABLE;
+	return;
+}
+
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
@@ -733,6 +748,8 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 	if (temp >= trip_temp) {
 		tz->passive = true;
 
+		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
+
 		trend = (tz->tc1 * (temp - tz->last_temperature)) +
 			(tz->tc2 * (temp - trip_temp));
 
@@ -1091,6 +1108,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 		goto leave;
 	}
 
+	tz->last_temperature = tz->temperature;
+	tz->temperature = temp;
+
 	for (count = 0; count < tz->trips; count++) {
 		tz->ops->get_trip_type(tz, count, &trip_type);
 		tz->ops->get_trip_temp(tz, count, &trip_temp);
@@ -1150,8 +1170,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 		thermal_zone_device_passive(tz, temp, tz->forced_passive,
 					    THERMAL_TRIPS_NONE);
 
-	tz->last_temperature = temp;
-
 leave:
 	if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a43b12c..a01e3e6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -44,6 +44,12 @@ enum thermal_trip_type {
 	THERMAL_TRIP_CRITICAL,
 };
 
+enum thermal_trend {
+	THERMAL_TREND_STABLE, /* temperature is stable */
+	THERMAL_TREND_RAISING, /* temperature is raising */
+	THERMAL_TREND_DROPPING, /* temperature is dropping */
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -65,6 +71,8 @@ struct thermal_zone_device_ops {
 	int (*set_trip_hyst) (struct thermal_zone_device *, int,
 			      unsigned long);
 	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*get_trend) (struct thermal_zone_device *, int,
+			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
 };
@@ -111,6 +119,7 @@ struct thermal_zone_device {
 	int tc2;
 	int passive_delay;
 	int polling_delay;
+	int temperature;
 	int last_temperature;
 	bool passive;
 	unsigned int forced_passive;
-- 
1.7.9.5

