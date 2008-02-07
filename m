From: Len Brown <lenb@kernel.org>
Subject: [PATCH 054/112] ACPI: register ACPI thermal zone as generic thermal zone devices
Date: Thu,  7 Feb 2008 04:34:16 -0500
Message-ID: <3f655ef8c439e0775ffb7d1ead5d1d4f060e1f8b.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758012AbYBGJg1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:27 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Register ACPI thermal zone as thermal zone device.

the new sys I/F for ACPI thermal zone will be like this:

/sys/class/thermal:
|thermal_zone1:
	|-----type:			"ACPI thermal zone". RO
	|-----temp:			the current temperature. RO
	|-----mode:			the current working mode. RW.
					the default value is "kernel"  which means  thermal
					management is done by ACPI thermal driver.
					"echo user > mode" prevents all the ACPI thermal driver
					actions upon any trip points.
	|-----trip_point_0_temp:	the threshold of trip point 0. RO.
	|-----trip_point_0_type:	"critical". RO.
					the type of trip point 0
					This may be one of critical/hot/passive/active[x]
					for an ACPI thermal zone.
	...
	|-----trip_point_3_temp:
	|-----trip_point_3_type:	"active[1]"

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig   |    1 +
 drivers/acpi/thermal.c |  301 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 292 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccf6ea9..5583729 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -186,6 +186,7 @@ config ACPI_HOTPLUG_CPU
 config ACPI_THERMAL
 	tristate "Thermal Zone"
 	depends on ACPI_PROCESSOR
+	select THERMAL
 	default y
 	help
 	  This driver adds support for ACPI thermal zones.  Most mobile and
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5f79b44..c6cfce4 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -43,7 +43,7 @@
 #include <linux/seq_file.h>
 #include <linux/reboot.h>
 #include <asm/uaccess.h>
-
+#include <linux/thermal.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -195,6 +195,8 @@ struct acpi_thermal {
 	struct acpi_thermal_trips trips;
 	struct acpi_handle_list devices;
 	struct timer_list timer;
+	struct thermal_zone_device *thermal_zone;
+	int tz_enabled;
 	struct mutex lock;
 };
 
@@ -732,6 +734,9 @@ static void acpi_thermal_check(void *data)
 	if (result)
 		goto unlock;
 
+	if (!tz->tz_enabled)
+		goto unlock;
+
 	memset(&tz->state, 0, sizeof(tz->state));
 
 	/*
@@ -825,6 +830,273 @@ static void acpi_thermal_check(void *data)
 	mutex_unlock(&tz->lock);
 }
 
+/* sys I/F for generic thermal sysfs support */
+static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+
+	if (!tz)
+		return -EINVAL;
+
+	return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(tz->temperature));
+}
+
+static const char enabled[] = "kernel";
+static const char disabled[] = "user";
+static int thermal_get_mode(struct thermal_zone_device *thermal,
+				char *buf)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+
+	if (!tz)
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", tz->tz_enabled ?
+			enabled : disabled);
+}
+
+static int thermal_set_mode(struct thermal_zone_device *thermal,
+				const char *buf)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+	int enable;
+
+	if (!tz)
+		return -EINVAL;
+
+	/*
+	 * enable/disable thermal management from ACPI thermal driver
+	 */
+	if (!strncmp(buf, enabled, sizeof enabled - 1))
+		enable = 1;
+	else if (!strncmp(buf, disabled, sizeof disabled - 1))
+		enable = 0;
+	else
+		return -EINVAL;
+
+	if (enable != tz->tz_enabled) {
+		tz->tz_enabled = enable;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"%s ACPI thermal control\n",
+			tz->tz_enabled ? enabled : disabled));
+		acpi_thermal_check(tz);
+	}
+	return 0;
+}
+
+static int thermal_get_trip_type(struct thermal_zone_device *thermal,
+				 int trip, char *buf)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+	int i;
+
+	if (!tz || trip < 0)
+		return -EINVAL;
+
+	if (tz->trips.critical.flags.valid) {
+		if (!trip)
+			return sprintf(buf, "critical\n");
+		trip--;
+	}
+
+	if (tz->trips.hot.flags.valid) {
+		if (!trip)
+			return sprintf(buf, "hot\n");
+		trip--;
+	}
+
+	if (tz->trips.passive.flags.valid) {
+		if (!trip)
+			return sprintf(buf, "passive\n");
+		trip--;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
+		tz->trips.active[i].flags.valid; i++) {
+		if (!trip)
+			return sprintf(buf, "active%d\n", i);
+		trip--;
+	}
+
+	return -EINVAL;
+}
+
+static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
+				 int trip, char *buf)
+{
+	struct acpi_thermal *tz = thermal->devdata;
+	int i;
+
+	if (!tz || trip < 0)
+		return -EINVAL;
+
+	if (tz->trips.critical.flags.valid) {
+		if (!trip)
+			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+				tz->trips.critical.temperature));
+		trip--;
+	}
+
+	if (tz->trips.hot.flags.valid) {
+		if (!trip)
+			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+					tz->trips.hot.temperature));
+		trip--;
+	}
+
+	if (tz->trips.passive.flags.valid) {
+		if (!trip)
+			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+					tz->trips.passive.temperature));
+		trip--;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
+		tz->trips.active[i].flags.valid; i++) {
+		if (!trip)
+			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
+					tz->trips.active[i].temperature));
+		trip--;
+	}
+
+	return -EINVAL;
+}
+
+typedef int (*cb)(struct thermal_zone_device *, int,
+		  struct thermal_cooling_device *);
+static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
+					struct thermal_cooling_device *cdev,
+					cb action)
+{
+	struct acpi_device *device = cdev->devdata;
+	struct acpi_thermal *tz = thermal->devdata;
+	acpi_handle handle = device->handle;
+	int i;
+	int j;
+	int trip = -1;
+	int result = 0;
+
+	if (tz->trips.critical.flags.valid)
+		trip++;
+
+	if (tz->trips.hot.flags.valid)
+		trip++;
+
+	if (tz->trips.passive.flags.valid) {
+		trip++;
+		for (i = 0; i < tz->trips.passive.devices.count;
+		    i++) {
+			if (tz->trips.passive.devices.handles[i] !=
+				handle)
+				continue;
+			result = action(thermal, trip, cdev);
+			if (result)
+				goto failed;
+		}
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (!tz->trips.active[i].flags.valid)
+			break;
+		trip++;
+		for (j = 0;
+		    j < tz->trips.active[i].devices.count;
+		    j++) {
+			if (tz->trips.active[i].devices.
+						handles[j] != handle)
+				continue;
+			result = action(thermal, trip, cdev);
+			if (result)
+				goto failed;
+		}
+	}
+
+	for (i = 0; i < tz->devices.count; i++) {
+		if (tz->devices.handles[i] != handle)
+			continue;
+		result = action(thermal, -1, cdev);
+		if (result)
+			goto failed;
+	}
+
+failed:
+	return result;
+}
+
+static int
+acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
+					struct thermal_cooling_device *cdev)
+{
+	return acpi_thermal_cooling_device_cb(thermal, cdev,
+				thermal_zone_bind_cooling_device);
+}
+
+static int
+acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
+					struct thermal_cooling_device *cdev)
+{
+	return acpi_thermal_cooling_device_cb(thermal, cdev,
+				thermal_zone_unbind_cooling_device);
+}
+
+static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
+	.bind = acpi_thermal_bind_cooling_device,
+	.unbind	= acpi_thermal_unbind_cooling_device,
+	.get_temp = thermal_get_temp,
+	.get_mode = thermal_get_mode,
+	.set_mode = thermal_set_mode,
+	.get_trip_type = thermal_get_trip_type,
+	.get_trip_temp = thermal_get_trip_temp,
+};
+
+static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
+{
+	int trips = 0;
+	int result;
+	int i;
+
+	if (tz->trips.critical.flags.valid)
+		trips++;
+
+	if (tz->trips.hot.flags.valid)
+		trips++;
+
+	if (tz->trips.passive.flags.valid)
+		trips++;
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
+			tz->trips.active[i].flags.valid; i++, trips++);
+	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
+					trips, tz, &acpi_thermal_zone_ops);
+	if (!tz->thermal_zone)
+		return -ENODEV;
+
+	result = sysfs_create_link(&tz->device->dev.kobj,
+				   &tz->thermal_zone->device.kobj, "thermal_zone");
+	if (result)
+		return result;
+
+	result = sysfs_create_link(&tz->thermal_zone->device.kobj,
+				   &tz->device->dev.kobj, "device");
+	if (result)
+		return result;
+
+	tz->tz_enabled = 1;
+
+	printk(KERN_INFO PREFIX "%s is registered as thermal_zone%d\n",
+			tz->device->dev.bus_id, tz->thermal_zone->id);
+	return 0;
+}
+
+static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
+{
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
+	thermal_zone_device_unregister(tz->thermal_zone);
+	tz->thermal_zone = NULL;
+}
+
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -1260,13 +1532,19 @@ static int acpi_thermal_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	acpi_driver_data(device) = tz;
 	mutex_init(&tz->lock);
+
+
 	result = acpi_thermal_get_info(tz);
 	if (result)
-		goto end;
+		goto free_memory;
+
+	result = acpi_thermal_register_thermal_zone(tz);
+	if (result)
+		goto free_memory;
 
 	result = acpi_thermal_add_fs(device);
 	if (result)
-		goto end;
+		goto unregister_thermal_zone;
 
 	init_timer(&tz->timer);
 
@@ -1277,19 +1555,21 @@ static int acpi_thermal_add(struct acpi_device *device)
 					     acpi_thermal_notify, tz);
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
-		goto end;
+		goto remove_fs;
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       KELVIN_TO_CELSIUS(tz->temperature));
+	goto end;
 
-      end:
-	if (result) {
-		acpi_thermal_remove_fs(device);
-		kfree(tz);
-	}
-
+remove_fs:
+	acpi_thermal_remove_fs(device);
+unregister_thermal_zone:
+	thermal_zone_device_unregister(tz->thermal_zone);
+free_memory:
+	kfree(tz);
+end:
 	return result;
 }
 
@@ -1329,6 +1609,7 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 	}
 
 	acpi_thermal_remove_fs(device);
+	acpi_thermal_unregister_thermal_zone(tz);
 	mutex_destroy(&tz->lock);
 	kfree(tz);
 	return 0;
-- 
1.5.4.23.gef5b9

