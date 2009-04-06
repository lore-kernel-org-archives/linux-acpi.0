From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ACPI: Adjust Kelvin offset to match local implementation
Date: Mon, 6 Apr 2009 16:01:46 +0200
Message-ID: <20090406160146.768f94d9@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:44340 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbZDFOBy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 10:01:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

The exact offset between Kelvin and degree Celsius is 273.15. However
ACPI handles temperature values with a single decimal place. As a
consequence, some implementations use an offset of 273.1 and others
use an offset of 273.2. Try to find out which one is being used, to
present the most accurate and visually appealing number.

Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
Thinkpad T60p (which uses 273.2).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
---
Blame the mess on whoever decided that ACPI temperature would be
expressed in the least adapted unit in the world :(

Without this patch, I have the following sensors output:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +44.9 C  (crit = +89.9 C)

With the patch I instead have:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +45.0 C  (crit = +90.0 C)

Which I think is much easier to read.

 drivers/acpi/thermal.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

--- linux-2.6.30-rc0.orig/drivers/acpi/thermal.c	2009-04-06 11:17:49.000000000 +0200
+++ linux-2.6.30-rc0/drivers/acpi/thermal.c	2009-04-06 13:14:37.000000000 +0200
@@ -192,6 +192,7 @@ struct acpi_thermal {
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
+	int kelvin_offset;
 	struct mutex lock;
 };
 
@@ -581,7 +582,7 @@ static void acpi_thermal_check(void *dat
 }
 
 /* sys I/F for generic thermal sysfs support */
-#define KELVIN_TO_MILLICELSIUS(t) (t * 100 - 273200)
+#define KELVIN_TO_MILLICELSIUS(t, off) (((t) - (off)) * 100)
 
 static int thermal_get_temp(struct thermal_zone_device *thermal,
 			    unsigned long *temp)
@@ -596,7 +597,7 @@ static int thermal_get_temp(struct therm
 	if (result)
 		return result;
 
-	*temp = KELVIN_TO_MILLICELSIUS(tz->temperature);
+	*temp = KELVIN_TO_MILLICELSIUS(tz->temperature, tz->kelvin_offset);
 	return 0;
 }
 
@@ -702,7 +703,8 @@ static int thermal_get_trip_temp(struct
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.critical.temperature);
+				tz->trips.critical.temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -711,7 +713,8 @@ static int thermal_get_trip_temp(struct
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.hot.temperature);
+				tz->trips.hot.temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -720,7 +723,8 @@ static int thermal_get_trip_temp(struct
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.passive.temperature);
+				tz->trips.passive.temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -730,7 +734,8 @@ static int thermal_get_trip_temp(struct
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = KELVIN_TO_MILLICELSIUS(
-				tz->trips.active[i].temperature);
+				tz->trips.active[i].temperature,
+				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -745,7 +750,8 @@ static int thermal_get_crit_temp(struct
 
 	if (tz->trips.critical.flags.valid) {
 		*temperature = KELVIN_TO_MILLICELSIUS(
-				tz->trips.critical.temperature);
+				tz->trips.critical.temperature,
+				tz->kelvin_offset);
 		return 0;
 	} else
 		return -EINVAL;
@@ -1334,6 +1340,25 @@ static int acpi_thermal_get_info(struct
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
@@ -1360,6 +1385,8 @@ static int acpi_thermal_add(struct acpi_
 	if (result)
 		goto free_memory;
 
+	acpi_thermal_guess_offset(tz);
+
 	result = acpi_thermal_register_thermal_zone(tz);
 	if (result)
 		goto free_memory;


-- 
Jean Delvare
