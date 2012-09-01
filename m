From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv3 14/15] Thermal: Add a notification API
Date: Sat,  1 Sep 2012 17:21:35 +0530
Message-ID: <1346500296-25200-15-git-send-email-durgadoss.r@intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45763 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530Ab2IALww (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Sep 2012 07:52:52 -0400
In-Reply-To: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds a notification API which the sensor drivers'
can use to notify the framework. The framework then takes
care of the throttling according to the configured policy.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
 include/linux/thermal.h       |    1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 086c1c9..e006d03 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1372,6 +1372,24 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
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
+/**
  * create_trip_attrs - create attributes for trip points
  * @tz:		the thermal zone device
  * @mask:	Writeable trip point bitmap.
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index aa903dd..c5deba0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -234,6 +234,7 @@ int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
+void notify_thermal_framework(struct thermal_zone_device *, int);
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-- 
1.7.9.5

