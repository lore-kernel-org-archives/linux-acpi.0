From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv3 05/15] Thermal: Pass zone parameters as argument to tzd_register
Date: Sat,  1 Sep 2012 17:21:26 +0530
Message-ID: <1346500296-25200-6-git-send-email-durgadoss.r@intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45763 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536Ab2IALwd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Sep 2012 07:52:33 -0400
In-Reply-To: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds the thermal zone parameter as an argument to
the tzd_register() function call; and updates other drivers
using this function.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/acpi/thermal.c                             |    6 +++---
 drivers/platform/x86/acerhdf.c                     |    2 +-
 drivers/platform/x86/intel_mid_thermal.c           |    2 +-
 drivers/power/power_supply_core.c                  |    2 +-
 drivers/staging/omap-thermal/omap-thermal-common.c |    2 +-
 drivers/thermal/spear_thermal.c                    |    2 +-
 drivers/thermal/thermal_sys.c                      |    3 +++
 include/linux/thermal.h                            |    3 ++-
 8 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index bd66bd2..d999eda 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -898,14 +898,14 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops,
+						&acpi_thermal_zone_ops, NULL,
 						     tz->trips.passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops, 0,
-						     tz->polling_frequency*100);
+						&acpi_thermal_zone_ops, NULL,
+						0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 84c5688..c2e3e63 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -662,7 +662,7 @@ static int acerhdf_register_thermal(void)
 		return -EINVAL;
 
 	thz_dev = thermal_zone_device_register("acerhdf", 1, 0, NULL,
-					      &acerhdf_dev_ops, 0,
+					      &acerhdf_dev_ops, NULL, 0,
 					      (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
diff --git a/drivers/platform/x86/intel_mid_thermal.c b/drivers/platform/x86/intel_mid_thermal.c
index c809761..93de090 100644
--- a/drivers/platform/x86/intel_mid_thermal.c
+++ b/drivers/platform/x86/intel_mid_thermal.c
@@ -502,7 +502,7 @@ static int mid_thermal_probe(struct platform_device *pdev)
 			goto err;
 		}
 		pinfo->tzd[i] = thermal_zone_device_register(name[i],
-				0, 0, td_info, &tzd_ops, 0, 0);
+				0, 0, td_info, &tzd_ops, NULL, 0, 0);
 		if (IS_ERR(pinfo->tzd[i])) {
 			kfree(td_info);
 			ret = PTR_ERR(pinfo->tzd[i]);
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 2436f13..f77a412 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -201,7 +201,7 @@ static int psy_register_thermal(struct power_supply *psy)
 	for (i = 0; i < psy->num_properties; i++) {
 		if (psy->properties[i] == POWER_SUPPLY_PROP_TEMP) {
 			psy->tzd = thermal_zone_device_register(psy->name, 0, 0,
-					psy, &psy_tzd_ops, 0, 0);
+					psy, &psy_tzd_ops, NULL, 0, 0);
 			if (IS_ERR(psy->tzd))
 				return PTR_ERR(psy->tzd);
 			break;
diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c b/drivers/staging/omap-thermal/omap-thermal-common.c
index 0675a5e..2f115bf 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -246,7 +246,7 @@ int omap_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
 	/* Create thermal zone */
 	data->omap_thermal = thermal_zone_device_register(domain,
 				OMAP_TRIP_NUMBER, 0, data, &omap_thermal_ops,
-				0, FAST_TEMP_MONITORING_RATE, 0, 0);
+				NULL, FAST_TEMP_MONITORING_RATE, 0);
 	if (IS_ERR_OR_NULL(data->omap_thermal)) {
 		dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
 		return PTR_ERR(data->omap_thermal);
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 9bc9692..6b2d8b2 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -147,7 +147,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
 	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
-				stdev, &ops, 0, 0);
+				stdev, &ops, NULL, 0, 0);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5e141b5..a642d1c 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1343,6 +1343,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
+ * @tzp:	thermal zone platform parameters
  * @passive_delay: number of milliseconds to wait between polls when
  *		   performing passive cooling
  * @polling_delay: number of milliseconds to wait between polls when checking
@@ -1355,6 +1356,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int trips, int mask, void *devdata,
 	const struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
@@ -1388,6 +1390,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	strcpy(tz->type, type);
 	tz->ops = ops;
+	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4caa32e..58cb1c0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -200,7 +200,8 @@ struct thermal_genl_event {
 
 /* Function declarations */
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
-		void *, const struct thermal_zone_device_ops *, int, int);
+		void *, const struct thermal_zone_device_ops *,
+		const struct thermal_zone_params *, int, int);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-- 
1.7.9.5

