From: Len Brown <lenb@kernel.org>
Subject: [PATCH 062/112] ACPI: thermal fixup
Date: Thu,  7 Feb 2008 04:34:24 -0500
Message-ID: <653a00c9662304ef72a3eb4e681c91720960e0b4.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754895AbYBGJgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:19 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

The alias name may be used in _PSL, _ALx and _TZD,
so we bind the cooling device only if the acpi_device node matches.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index aee371f..73f276b 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1015,7 +1015,9 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_thermal *tz = thermal->devdata;
-	acpi_handle handle = device->handle;
+	struct acpi_device *dev;
+	acpi_status status;
+	acpi_handle handle;
 	int i;
 	int j;
 	int trip = -1;
@@ -1031,12 +1033,13 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		trip++;
 		for (i = 0; i < tz->trips.passive.devices.count;
 		    i++) {
-			if (tz->trips.passive.devices.handles[i] !=
-				handle)
-				continue;
-			result = action(thermal, trip, cdev);
-			if (result)
-				goto failed;
+			handle = tz->trips.passive.devices.handles[i];
+			status = acpi_bus_get_device(handle, &dev);
+			if (ACPI_SUCCESS(status) && (dev == device)) {
+				result = action(thermal, trip, cdev);
+				if (result)
+					goto failed;
+			}
 		}
 	}
 
@@ -1047,21 +1050,24 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		for (j = 0;
 		    j < tz->trips.active[i].devices.count;
 		    j++) {
-			if (tz->trips.active[i].devices.
-						handles[j] != handle)
-				continue;
-			result = action(thermal, trip, cdev);
-			if (result)
-				goto failed;
+			handle = tz->trips.active[i].devices.handles[j];
+			status = acpi_bus_get_device(handle, &dev);
+			if (ACPI_SUCCESS(status) && (dev == device)) {
+				result = action(thermal, trip, cdev);
+				if (result)
+					goto failed;
+			}
 		}
 	}
 
 	for (i = 0; i < tz->devices.count; i++) {
-		if (tz->devices.handles[i] != handle)
-			continue;
-		result = action(thermal, -1, cdev);
-		if (result)
-			goto failed;
+		handle = tz->devices.handles[i];
+		status = acpi_bus_get_device(handle, &dev);
+		if (ACPI_SUCCESS(status) && (dev == device)) {
+			result = action(thermal, -1, cdev);
+			if (result)
+				goto failed;
+		}
 	}
 
 failed:
-- 
1.5.4.23.gef5b9

