From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 08/16] Thermal: Remove tc1/tc2 in generic thermal layer.
Date: Wed, 25 Jul 2012 10:11:05 +0800
Message-ID: <1343182273-32096-9-git-send-email-rui.zhang@intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36673 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755821Ab2GYCLl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 22:11:41 -0400
In-Reply-To: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c                   |    5 +----
 drivers/platform/x86/acerhdf.c           |    2 +-
 drivers/platform/x86/intel_mid_thermal.c |    2 +-
 drivers/thermal/spear_thermal.c          |    2 +-
 drivers/thermal/thermal_sys.c            |   23 ++++++-----------------
 include/linux/thermal.h                  |    5 +----
 6 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 01c92fd..5417362 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -895,15 +895,12 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     &acpi_thermal_zone_ops,
-						     tz->trips.passive.tc1,
-						     tz->trips.passive.tc2,
 						     tz->trips.passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops,
-						     0, 0, 0,
+						     &acpi_thermal_zone_ops, 0,
 						     tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index a207466..84c5688 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -662,7 +662,7 @@ static int acerhdf_register_thermal(void)
 		return -EINVAL;
 
 	thz_dev = thermal_zone_device_register("acerhdf", 1, 0, NULL,
-					      &acerhdf_dev_ops, 0, 0, 0,
+					      &acerhdf_dev_ops, 0,
 					      (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
diff --git a/drivers/platform/x86/intel_mid_thermal.c b/drivers/platform/x86/intel_mid_thermal.c
index 2b2c212..6e309dd 100644
--- a/drivers/platform/x86/intel_mid_thermal.c
+++ b/drivers/platform/x86/intel_mid_thermal.c
@@ -499,7 +499,7 @@ static int mid_thermal_probe(struct platform_device *pdev)
 			goto err;
 		}
 		pinfo->tzd[i] = thermal_zone_device_register(name[i],
-				0, 0, td_info, &tzd_ops, 0, 0, 0, 0);
+				0, 0, td_info, &tzd_ops, 0, 0);
 		if (IS_ERR(pinfo->tzd[i])) {
 			kfree(td_info);
 			ret = PTR_ERR(pinfo->tzd[i]);
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 69a55d4..b55840a 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -148,7 +148,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
 	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
-				stdev, &ops, 0, 0, 0, 0);
+				stdev, &ops, 0, 0);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index d406524..727aa74 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -335,9 +335,6 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		tz->passive_delay = 0;
 	}
 
-	tz->tc1 = 1;
-	tz->tc2 = 1;
-
 	tz->forced_passive = state;
 
 	thermal_zone_device_update(tz);
@@ -733,7 +730,7 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 					int temp, int trip_temp, int trip)
 {
-	int trend = 0;
+	enum thermal_trend trend;
 	struct thermal_cooling_device_instance *instance;
 	struct thermal_cooling_device *cdev;
 	long state, max_state;
@@ -748,13 +745,10 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 	if (temp >= trip_temp) {
 		tz->passive = true;
 
-		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);
-
-		trend = (tz->tc1 * (temp - tz->last_temperature)) +
-			(tz->tc2 * (temp - trip_temp));
+		thermal_get_trend(tz, trip, &trend);
 
 		/* Heating up? */
-		if (trend > 0) {
+		if (trend == THERMAL_TREND_RAISING) {
 			list_for_each_entry(instance, &tz->cooling_devices,
 					    node) {
 				if (instance->trip != trip)
@@ -765,7 +759,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 				if (state++ < max_state)
 					cdev->ops->set_cur_state(cdev, state);
 			}
-		} else if (trend < 0) { /* Cooling off? */
+		} else if (trend == THERMAL_TREND_DROPPING) { /* Cooling off? */
 			list_for_each_entry(instance, &tz->cooling_devices,
 					    node) {
 				if (instance->trip != trip)
@@ -1291,8 +1285,6 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
- * @tc1:	thermal coefficient 1 for passive calculations
- * @tc2:	thermal coefficient 2 for passive calculations
  * @passive_delay: number of milliseconds to wait between polls when
  *		   performing passive cooling
  * @polling_delay: number of milliseconds to wait between polls when checking
@@ -1300,13 +1292,12 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
  *		   driven systems)
  *
  * thermal_zone_device_unregister() must be called when the device is no
- * longer needed. The passive cooling formula uses tc1 and tc2 as described in
- * section 11.1.5.1 of the ACPI specification 3.0.
+ * longer needed. The passive cooling depends on the .get_trend() return value.
  */
 struct thermal_zone_device *thermal_zone_device_register(char *type,
 	int trips, int mask, void *devdata,
 	const struct thermal_zone_device_ops *ops,
-	int tc1, int tc2, int passive_delay, int polling_delay)
+	int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos;
@@ -1342,8 +1333,6 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
-	tz->tc1 = tc1;
-	tz->tc2 = tc2;
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a01e3e6..d18dcf6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -115,8 +115,6 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	void *devdata;
 	int trips;
-	int tc1;
-	int tc2;
 	int passive_delay;
 	int polling_delay;
 	int temperature;
@@ -163,8 +161,7 @@ enum {
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, int,
-		void *, const struct thermal_zone_device_ops *, int tc1,
-		int tc2, int passive_freq, int polling_freq);
+		void *, const struct thermal_zone_device_ops *, int, int);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-- 
1.7.9.5

