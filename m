From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 03/13] Thermal: Add get trend, get instance API's to thermal_sys
Date: Thu,  9 Aug 2012 18:15:55 +0530
Message-ID: <1344516365-7230-4-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467Ab2HIMqU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:20 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds the following API's to thermal_sys.c, that
can be used by other Thermal drivers.
 * get_tz_trend: obtain the trend of the given thermal zone
 * get_cdev_by_name: obtain cdev pointer given its name
 * get_thermal_instance: obtain the instance corresponding
   to the given tz, cdev and the trip point.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h       |    5 ++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index a0e20f9..998c16e 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -80,6 +80,65 @@ static void release_idr(struct idr *idr, struct mutex *lock, int id)
 		mutex_unlock(lock);
 }
 
+int get_tz_trend(struct thermal_zone_device *tz, int trip)
+{
+	enum thermal_trend trend;
+
+	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend)) {
+		if (tz->temperature > tz->last_temperature)
+			trend = THERMAL_TREND_RAISING;
+		else if (tz->temperature < tz->last_temperature)
+			trend = THERMAL_TREND_DROPPING;
+		else
+			trend = THERMAL_TREND_STABLE;
+	}
+
+	return trend;
+}
+EXPORT_SYMBOL(get_tz_trend);
+
+struct thermal_cooling_device *get_cdev_by_name(const char *name)
+{
+	struct thermal_cooling_device *pos;
+	struct thermal_cooling_device *target_cdev = NULL;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(pos, &thermal_cdev_list, node) {
+		if (!strcmp(pos->type, name)) {
+			target_cdev = pos;
+			break;
+		}
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return target_cdev;
+}
+EXPORT_SYMBOL(get_cdev_by_name);
+
+struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev, int trip)
+{
+	struct thermal_instance *pos = NULL;
+	struct thermal_instance *target_instance = NULL;
+
+	mutex_lock(&tz->lock);
+	mutex_lock(&cdev->lock);
+
+	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
+		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+			target_instance = pos;
+			break;
+		}
+	}
+
+	mutex_unlock(&cdev->lock);
+	mutex_unlock(&tz->lock);
+
+	return target_instance;
+}
+EXPORT_SYMBOL(get_thermal_instance);
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f25df23..757a007 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -208,6 +208,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 
+int get_tz_trend(struct thermal_zone_device *, int);
+struct thermal_cooling_device *get_cdev_by_name(const char *);
+struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
+		struct thermal_cooling_device *, int);
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.9.5

