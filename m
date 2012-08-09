From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 11/13] Thermal: Add a notification API
Date: Thu,  9 Aug 2012 18:16:03 +0530
Message-ID: <1344516365-7230-12-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932548Ab2HIMqn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:43 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds a notification API which the sensor drivers'
can use to notify the framework. The framework then takes
care of the throttling according to the configured policy.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
 include/linux/thermal.h       |    1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 193d071..6931d81 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1309,6 +1309,24 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
+/**
+ * notify_thermal_framework - Sensor drivers use this API to notify framework
+ * @tz:		thermal zone device
+ * @trip:	indicates which trip point has been crossed
+ *
+ * This function handles the trip events from sensor drivers. It starts
+ * throttling the cooling devices according to the policy configured.
+ * For CRITICAL and HOT trip points, this notifies the respective drivers,
+ * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
+ * The throttling policy is based on the configured platform data; if no
+ * platform data is provided, this uses the step_wise throttling policy.
+ */
+void notify_thermal_framework(struct thermal_zone_device *tz, int trip)
+{
+	handle_thermal_trip(tz, trip);
+}
+EXPORT_SYMBOL(notify_thermal_framework);
+
 static int create_policy_attr(struct thermal_zone_device *tz)
 {
 	sysfs_attr_init(&tz->policy_attr.attr);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 3bdf5f2..a3a0144 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -246,6 +246,7 @@ int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_cooling_device *get_cdev_by_name(const char *);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
+void notify_thermal_framework(struct thermal_zone_device *, int);
 
 /*
  * The platform layer shall define a 'function' that provides the
-- 
1.7.9.5

