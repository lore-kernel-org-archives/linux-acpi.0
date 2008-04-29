From: Len Brown <lenb@kernel.org>
Subject: [PATCH 097/171] thermal: update the documentation
Date: Tue, 29 Apr 2008 04:44:17 -0400
Message-ID: <e9ae71078b2c8657c0e8de808b76b76049806906.1209457070.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760554AbYD2IpX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:23 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Update the documentation for the thermal driver hwmon sys I/F.

Change the ACPI thermal zone type to be consistent with hwmon.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   33 +++++++++++++++++++++++++++------
 drivers/acpi/thermal.c              |    2 +-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index d9f28be..70d68ce 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -108,10 +108,12 @@ and throttle appropriate devices.
 RO	read only value
 RW	read/write value
 
-All thermal sysfs attributes will be represented under /sys/class/thermal
+Thermal sysfs attributes will be represented under /sys/class/thermal.
+Hwmon sysfs I/F extension is also available under /sys/class/hwmon
+if hwmon is compiled in or built as a module.
 
 Thermal zone device sys I/F, created once it's registered:
-|thermal_zone[0-*]:
+/sys/class/thermal/thermal_zone[0-*]:
 	|-----type:			Type of the thermal zone
 	|-----temp:			Current temperature
 	|-----mode:			Working mode of the thermal zone
@@ -119,7 +121,7 @@ Thermal zone device sys I/F, created once it's registered:
 	|-----trip_point_[0-*]_type:	Trip point type
 
 Thermal cooling device sys I/F, created once it's registered:
-|cooling_device[0-*]:
+/sys/class/thermal/cooling_device[0-*]:
 	|-----type :			Type of the cooling device(processor/fan/...)
 	|-----max_state:		Maximum cooling state of the cooling device
 	|-----cur_state:		Current cooling state of the cooling device
@@ -130,10 +132,19 @@ They represent the relationship between a thermal zone and its associated coolin
 They are created/removed for each
 thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful execution.
 
-|thermal_zone[0-*]
+/sys/class/thermal/thermal_zone[0-*]
 	|-----cdev[0-*]:		The [0-*]th cooling device in the current thermal zone
 	|-----cdev[0-*]_trip_point:	Trip point that cdev[0-*] is associated with
 
+Besides the thermal zone device sysfs I/F and cooling device sysfs I/F,
+the generic thermal driver also creates a hwmon sysfs I/F for each _type_ of
+thermal zone device. E.g. the generic thermal driver registers one hwmon class device
+and build the associated hwmon sysfs I/F for all the registered ACPI thermal zones.
+/sys/class/hwmon/hwmon[0-*]:
+	|-----name:			The type of the thermal zone devices.
+	|-----temp[1-*]_input:		The current temperature of thermal zone [1-*].
+	|-----temp[1-*]_critical:	The critical trip point of thermal zone [1-*].
+Please read Documentation/hwmon/sysfs-interface for additional information.
 
 ***************************
 * Thermal zone attributes *
@@ -141,7 +152,10 @@ thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful e
 
 type				Strings which represent the thermal zone type.
 				This is given by thermal zone driver as part of registration.
-				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
+				Eg: "acpitz" indicates it's an ACPI thermal device.
+				In order to keep it consistent with hwmon sys attribute,
+				this should be a short, lowercase string,
+				not containing spaces nor dashes.
 				RO
 				Required
 
@@ -218,7 +232,7 @@ the sys I/F structure will be built like this:
 /sys/class/thermal:
 
 |thermal_zone1:
-	|-----type:			ACPI thermal zone
+	|-----type:			acpitz
 	|-----temp:			37000
 	|-----mode:			kernel
 	|-----trip_point_0_temp:	100000
@@ -243,3 +257,10 @@ the sys I/F structure will be built like this:
 	|-----type:			Fan
 	|-----max_state:		2
 	|-----cur_state:		0
+
+/sys/class/hwmon:
+
+|hwmon0:
+	|-----name:			acpitz
+	|-----temp1_input:		37000
+	|-----temp1_crit:		100000
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index ec707ed..5e9641c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1136,7 +1136,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 			tz->trips.active[i].flags.valid; i++, trips++);
-	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
+	tz->thermal_zone = thermal_zone_device_register("acpitz",
 					trips, tz, &acpi_thermal_zone_ops);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
-- 
1.5.5.1.99.gf0ec4

