From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ACPI / thermal: convert printk(LEVEL...) to pr_<lvl>
Date: Thu,  3 Oct 2013 11:04:53 +0300
Message-ID: <1380787494-14385-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7975 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab3JCIFP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Oct 2013 04:05:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Convert printks to pr_* format. Additionally re-use PREFIX constant instead of
hardcoded strings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/thermal.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 6a03293..e600b5d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -299,8 +299,8 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "No critical threshold\n"));
 		} else if (tmp <= 2732) {
-			printk(KERN_WARNING FW_BUG "Invalid critical threshold "
-			       "(%llu)\n", tmp);
+			pr_warn(FW_BUG "Invalid critical threshold (%llu)\n",
+				tmp);
 			tz->trips.critical.flags.valid = 0;
 		} else {
 			tz->trips.critical.flags.valid = 1;
@@ -317,8 +317,8 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 				 * Allow override critical threshold
 				 */
 				if (crt_k > tz->trips.critical.temperature)
-					printk(KERN_WARNING PREFIX
-						"Critical threshold %d C\n", crt);
+					pr_warn(PREFIX "Critical threshold %d C\n",
+						crt);
 				tz->trips.critical.temperature = crt_k;
 			}
 		}
@@ -390,8 +390,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
 		if (ACPI_FAILURE(status)) {
-			printk(KERN_WARNING PREFIX
-				"Invalid passive threshold\n");
+			pr_warn(PREFIX "Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
 		}
 		else
@@ -453,8 +452,8 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
-				printk(KERN_WARNING PREFIX
-					"Invalid active%d threshold\n", i);
+				pr_warn(PREFIX "Invalid active%d threshold\n",
+					i);
 				tz->trips.active[i].flags.valid = 0;
 			}
 			else
@@ -505,7 +504,7 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 		valid |= tz->trips.active[i].flags.valid;
 
 	if (!valid) {
-		printk(KERN_WARNING FW_BUG "No valid trip found\n");
+		pr_warn(FW_BUG "No valid trip found\n");
 		return -ENODEV;
 	}
 	return 0;
@@ -923,8 +922,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 				  acpi_bus_private_data_handler,
 				  tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-				"Error attaching device data\n");
+		pr_err(PREFIX "Error attaching device data\n");
 		return -ENODEV;
 	}
 
@@ -1094,9 +1092,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto free_memory;
 
-	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       KELVIN_TO_CELSIUS(tz->temperature));
+	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
+		acpi_device_bid(device), KELVIN_TO_CELSIUS(tz->temperature));
 	goto end;
 
 free_memory:
@@ -1159,24 +1156,24 @@ static int acpi_thermal_resume(struct device *dev)
 static int thermal_act(const struct dmi_system_id *d) {
 
 	if (act == 0) {
-		printk(KERN_NOTICE "ACPI: %s detected: "
-			"disabling all active thermal trip points\n", d->ident);
+		pr_notice(PREFIX "%s detected: "
+			  "disabling all active thermal trip points\n", d->ident);
 		act = -1;
 	}
 	return 0;
 }
 static int thermal_nocrt(const struct dmi_system_id *d) {
 
-	printk(KERN_NOTICE "ACPI: %s detected: "
-		"disabling all critical thermal trip point actions.\n", d->ident);
+	pr_notice(PREFIX "%s detected: "
+		  "disabling all critical thermal trip point actions.\n", d->ident);
 	nocrt = 1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {
 
 	if (tzp == 0) {
-		printk(KERN_NOTICE "ACPI: %s detected: "
-			"enabling thermal zone polling\n", d->ident);
+		pr_notice(PREFIX "%s detected: "
+			  "enabling thermal zone polling\n", d->ident);
 		tzp = 300;	/* 300 dS = 30 Seconds */
 	}
 	return 0;
@@ -1184,8 +1181,8 @@ static int thermal_tzp(const struct dmi_system_id *d) {
 static int thermal_psv(const struct dmi_system_id *d) {
 
 	if (psv == 0) {
-		printk(KERN_NOTICE "ACPI: %s detected: "
-			"disabling all passive thermal trip points\n", d->ident);
+		pr_notice(PREFIX "%s detected: "
+			  "disabling all passive thermal trip points\n", d->ident);
 		psv = -1;
 	}
 	return 0;
@@ -1238,7 +1235,7 @@ static int __init acpi_thermal_init(void)
 	dmi_check_system(thermal_dmi_table);
 
 	if (off) {
-		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
+		pr_notice(PREFIX "thermal control disabled\n");
 		return -ENODEV;
 	}
 
-- 
1.8.4.rc3

