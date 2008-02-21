From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/26] ACPI fan: extract return values using PTR_ERR
Date: Thu, 21 Feb 2008 04:25:17 -0500
Message-ID: <19b36780ee7ddeb5080e3f1f858a83c4824f1fdc.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36609 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756510AbYBUJ3H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:07 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Sujith <sujith.thomas@intel.com>

Need to extract errors using PTR_ERR macro and
process accordingly.  thermal_cooling_device_register
returning NULL means that CONFIG_THERMAL=n and in that
case no need to create symbolic links.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 48cb705..c8e3cba 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -256,22 +256,28 @@ static int acpi_fan_add(struct acpi_device *device)
 
 	cdev = thermal_cooling_device_register("Fan", device,
 						&fan_cooling_ops);
-	if (cdev)
+	if (IS_ERR(cdev)) {
+		result = PTR_ERR(cdev);
+		goto end;
+	}
+	if (cdev) {
 		printk(KERN_INFO PREFIX
 			"%s is registered as cooling_device%d\n",
 			device->dev.bus_id, cdev->id);
-	else
-		goto end;
-	acpi_driver_data(device) = cdev;
-	result = sysfs_create_link(&device->dev.kobj, &cdev->device.kobj,
-					"thermal_cooling");
-	if (result)
-		return result;
 
-	result = sysfs_create_link(&cdev->device.kobj, &device->dev.kobj,
-                                       "device");
-        if (result)
-                return result;
+		acpi_driver_data(device) = cdev;
+		result = sysfs_create_link(&device->dev.kobj,
+					   &cdev->device.kobj,
+					   "thermal_cooling");
+		if (result)
+			return result;
+
+		result = sysfs_create_link(&cdev->device.kobj,
+					   &device->dev.kobj,
+					   "device");
+		if (result)
+			return result;
+	}
 
 	result = acpi_fan_add_fs(device);
 	if (result)
-- 
1.5.4.2

