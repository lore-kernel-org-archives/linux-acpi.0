From: tianyu.lan@intel.com
Subject: [PATCH 1/3] ACPI/Thermal: Remove the unused lock of struct acpi_thermal
Date: Wed, 14 Aug 2013 21:00:37 +0800
Message-ID: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30347 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932282Ab3HNNJS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Aug 2013 09:09:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, rui.zhang@intel.com

From: Lan Tianyu <tianyu.lan@intel.com>

The acpi_thermal->lock now just is initialized when thermal zone device
is added and destroyed when thermal zone is removed. Never being used
any other places. So remove it.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index a3e38a0..850818d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -190,7 +190,6 @@ struct acpi_thermal {
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
 	int kelvin_offset;
-	struct mutex lock;
 };
 
 /* --------------------------------------------------------------------------
@@ -1088,8 +1087,6 @@ static int acpi_thermal_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
-	mutex_init(&tz->lock);
-
 
 	result = acpi_thermal_get_info(tz);
 	if (result)
@@ -1122,7 +1119,6 @@ static int acpi_thermal_remove(struct acpi_device *device)
 	tz = acpi_driver_data(device);
 
 	acpi_thermal_unregister_thermal_zone(tz);
-	mutex_destroy(&tz->lock);
 	kfree(tz);
 	return 0;
 }
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

