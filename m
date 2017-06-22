From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] acpi: thermal: honor "mode" sysfs file setting
Date: Thu, 22 Jun 2017 14:45:42 +0200
Message-ID: <20170622124542.12063-1-enric.balletbo@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46334 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdFVMpx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2017 08:45:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>

From: Sameer Nanda <snanda@chromium.org>

Under each thermal zone there is a file called "mode". Writing enabled
or disabled to this file allows a given thermal zone to be enabled or
disabled. Honor writes to this file by enabling or disabling the
polling timers.

With this change, in the acpi_thermal_add path, acpi_thermal_get_info
gets called before acpi_thermal_register_thermal_zone. Since tz_enabled
was getting set to 1 only in acpi_thermal_register_thermal_zone,
acpi_thermal_get_info ended up disabling thermal polling so moved the
setting of tz_enabled to 1 into acpi_thermal_add itself.

After this patch echoing enabled|disabled to "mode" sysfs will start/stop
the polling of the temperature.

Signed-off-by: Sameer Nanda <snanda@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/acpi/thermal.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 1d0417b..68ad9fe 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -223,6 +223,17 @@ static int acpi_thermal_get_polling_frequency(struct acpi_thermal *tz)
 	if (!tz)
 		return -EINVAL;
 
+	if (tz->tz_enabled == THERMAL_DEVICE_DISABLED) {
+		tz->polling_frequency = 0;
+		return 0;
+	}
+
+	/* Get default polling frequency [_TZP] (optional) */
+	if (tzp) {
+		tz->polling_frequency = tzp;
+		return 0;
+	}
+
 	status = acpi_evaluate_integer(tz->device->handle, "_TZP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -582,6 +593,14 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			"%s kernel ACPI thermal control\n",
 			tz->tz_enabled ? "Enable" : "Disable"));
+
+		acpi_thermal_get_polling_frequency(tz);
+
+		mutex_lock(&tz->thermal_zone->lock);
+		tz->thermal_zone->polling_delay = tz->polling_frequency * 100;
+		tz->thermal_zone->passive_delay = tz->polling_frequency * 100;
+		mutex_unlock(&tz->thermal_zone->lock);
+
 		acpi_thermal_check(tz);
 	}
 	return 0;
@@ -930,8 +949,6 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->tz_enabled = 1;
-
 	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
 		 tz->thermal_zone->id);
 	return 0;
@@ -1039,11 +1056,7 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	if (!result)
 		tz->flags.cooling_mode = 1;
 
-	/* Get default polling frequency [_TZP] (optional) */
-	if (tzp)
-		tz->polling_frequency = tzp;
-	else
-		acpi_thermal_get_polling_frequency(tz);
+	acpi_thermal_get_polling_frequency(tz);
 
 	return 0;
 }
@@ -1088,6 +1101,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
+	tz->tz_enabled = 1;
 	strcpy(tz->name, device->pnp.bus_id);
 	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
-- 
2.9.3

