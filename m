From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/26] ACPI thermal: extract return values using PTR_ERR
Date: Thu, 21 Feb 2008 04:25:19 -0500
Message-ID: <d76628c67cdeebf84766a19c67c821c2e518baa4.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36609 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755733AbYBUJ3C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:02 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Sujith <sujith.thomas@intel.com>

Need to extract errors using PTR_ERR macro and
process accordingly.thermal_cooling_device_register
returning NULL means that CONFIG_THERMAL=n and in that
case no need to create symbolic links.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 75ccf5d..b020069 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -670,21 +670,26 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 
 	pr->cdev = thermal_cooling_device_register("Processor", device,
 						&processor_cooling_ops);
-	if (pr->cdev)
+	if (IS_ERR(pr->cdev)) {
+		result = PTR_ERR(pr->cdev);
+		goto end;
+	}
+	if (pr->cdev) {
 		printk(KERN_INFO PREFIX
 			"%s is registered as cooling_device%d\n",
 			device->dev.bus_id, pr->cdev->id);
-	else
-		goto end;
 
-	result = sysfs_create_link(&device->dev.kobj, &pr->cdev->device.kobj,
-					"thermal_cooling");
-	if (result)
-		return result;
-	result = sysfs_create_link(&pr->cdev->device.kobj, &device->dev.kobj,
-					"device");
-	if (result)
-		return result;
+		result = sysfs_create_link(&device->dev.kobj,
+					   &pr->cdev->device.kobj,
+					   "thermal_cooling");
+		if (result)
+			return result;
+		result = sysfs_create_link(&pr->cdev->device.kobj,
+					   &device->dev.kobj,
+					   "device");
+		if (result)
+			return result;
+	}
 
 	if (pr->flags.throttling) {
 		printk(KERN_INFO PREFIX "%s [%s] (supports",
@@ -809,10 +814,12 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 
 	acpi_processor_remove_fs(device);
 
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-	sysfs_remove_link(&pr->cdev->device.kobj, "device");
-	thermal_cooling_device_unregister(pr->cdev);
-	pr->cdev = NULL;
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev = NULL;
+	}
 
 	processors[pr->id] = NULL;
 
-- 
1.5.4.2

