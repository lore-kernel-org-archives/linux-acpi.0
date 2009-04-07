From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/17] ACPI: Adjust Kelvin offset to match local implementation
Date: Tue, 07 Apr 2009 19:04:10 -0400
Message-ID: <13614e37e94da4606a300ee6fe25c8c4a19ee670.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:63884 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbZDGXEc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:32 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR00LI06RIL66I@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:31 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <khali@linux-fr.org>

The exact offset between Kelvin and degree Celsius is 273.15. However
ACPI handles temperature values with a single decimal place. As a
consequence, some implementations use an offset of 273.1 and others
use an offset of 273.2. Try to find out which one is being used, to
present the most accurate and visually appealing number.

Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
Thinkpad T60p (which uses 273.2).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e8c143c..ddbb7c8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -192,6 +192,7 @@ struct acpi_thermal {
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
+	int kelvin_offset;
 	struct mutex lock;
 };
 
@@ -581,7 +582,7 @@ static void acpi_thermal_check(void *data)
 }
 
 /* sys I/F for generic thermal sysfs support */
-#define KELVIN_TO_MILLICELSIUS(t) (t * 100 - 273200)
+#define KELVIN_TO_MILLICELSIUS(t, off) (((t) - (off)) * 100)
 
 static int thermal_get_temp(struct thermal_zone_device *thermal,
 			    unsigned long *temp)
@@ -596,7 +597,7 @@ static int thermal_get_temp(struct thermal_zone_device *thermal,
 	if (result)
 		return result;
 
-	*temp = KELVIN_TO_MILLICELSIUS(tz->temperature);
+	*temp = KELVIN_TO_MILLICELSIUS(tz->temperature, tz->kelvin_offset);
 	return 0;
 }
 
@@ -702,7 +703,8 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.critical.temperature);
+				tz->trips.critical.temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -711,7 +713,8 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.hot.temperature);
+				tz->trips.hot.temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -720,7 +723,8 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.passive.temperature);
+				tz->trips.passive.temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -730,7 +734,8 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.active[i].temperature);
+				tz->trips.active[i].temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -745,7 +750,8 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.critical.flags.valid) {
 		*temperature = KELVIN_TO_MILLICELSIUS(
-				tz->trips.critical.temperature);
+				tz->trips.critical.temperature,
+				tz->kelvin_offset);
 		return 0;
 	} else
 		return -EINVAL;
@@ -1334,6 +1340,25 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	return 0;
 }
 
+/*
+ * The exact offset between Kelvin and degree Celsius is 273.15. However ACPI
+ * handles temperature values with a single decimal place. As a consequence,
+ * some implementations use an offset of 273.1 and others use an offset of
+ * 273.2. Try to find out which one is being used, to present the most
+ * accurate and visually appealing number.
+ *
+ * The heuristic below should work for all ACPI thermal zones which have a
+ * critical trip point with a value being a multiple of 0.5 degree Celsius.
+ */
+static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
+{
+	if (tz->trips.critical.flags.valid &&
+	    (tz->trips.critical.temperature % 5) == 1)
+		tz->kelvin_offset = 2731;
+	else
+		tz->kelvin_offset = 2732;
+}
+
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -1360,6 +1385,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto free_memory;
 
+	acpi_thermal_guess_offset(tz);
+
 	result = acpi_thermal_register_thermal_zone(tz);
 	if (result)
 		goto free_memory;
-- 
1.6.0.6

