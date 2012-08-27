From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 13/14] Thermal: Add documentation for platform layer data
Date: Mon, 27 Aug 2012 09:58:25 +0530
Message-ID: <1346041706-29642-14-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2H0E3a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:30 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds documentation for thermal_bind_params
and thermal_zone_params structures. Also, adds details
on EXPORT_SYMBOL APIs.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index ca1a1a3..650f41b 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -112,6 +112,30 @@ temperature) and throttle appropriate devices.
     trip: indicates which trip point the cooling devices is associated with
 	  in this thermal zone.
 
+1.4 Thermal Zone Parameters
+1.4.1 struct thermal_bind_params
+    This structure defines the following parameters that are used to bind
+    a zone with a cooling device for a particular trip point.
+    .cdev: The cooling device pointer
+    .weight: The 'influence' of a particular cooling device on this zone.
+             This is on a percentage scale. The sum of all these weights
+             (for a particular zone) cannot exceed 100.
+    .trip_mask:This is a bit mask that gives the binding relation between
+               this thermal zone and cdev, for a particular trip point.
+               If nth bit is set, then the cdev and thermal zone are bound
+               for trip point n.
+1.4.2 struct thermal_zone_params
+    This structure defines the platform level parameters for a thermal zone.
+    This data, for each thermal zone should come from the platform layer.
+    This is an optional feature where some platforms can choose not to
+    provide this data.
+    .throttle_policy: One of the throttling policies from enum
+                      thermal_throttle_policy
+    .zone_name: Name of the thermal zone, for which these parameters
+		are being defined.
+    .num_tbps: Number of thermal_bind_params entries for this zone
+    .tbp: thermal_bind_params entries
+
 2. sysfs attributes structure
 
 RO	read only value
@@ -305,3 +329,30 @@ to a thermal_zone_device when it registers itself with the framework. The
 event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
 THERMAL_DEV_FAULT}. Notification can be sent when the current temperature
 crosses any of the configured thresholds.
+
+5. Export Symbol APIs:
+
+5.1: get_tz_trend:
+This function returns the trend of a thermal zone, i.e the rate of change
+of temperature of the thermal zone. Ideally, the thermal sensor drivers
+are supposed to implement the callback. If they don't, the thermal
+framework calculated the trend by comparing the previous and the current
+temperature values.
+
+5.2:get_thermal_instance:
+This function returns the thermal_instance corresponding to a given
+{thermal_zone, cooling_device, trip_point} combination. Returns NULL
+if such an instance does not exist.
+
+5.3:notify_thermal_framework:
+This function handles the trip events from sensor drivers. It starts
+throttling the cooling devices according to the policy configured.
+For CRITICAL and HOT trip points, this notifies the respective drivers,
+and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
+The throttling policy is based on the configured platform data; if no
+platform data is provided, this uses the step_wise throttling policy.
+
+5.4:thermal_cdev_update:
+This function serves as an arbitrator to set the state of a cooling
+device. It sets the cooling device to the deepest cooling state if
+possible.
-- 
1.7.9.5

