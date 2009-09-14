From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCHv2] ACPI fan: fix memleak on acpi_fan_add_fs() failure
Date: Mon, 14 Sep 2009 08:50:08 +0100
Message-ID: <4AADF5B0.1040400@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54873 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbZINHuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 03:50:07 -0400
Received: by fxm17 with SMTP id 17so647099fxm.37
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2009 00:50:10 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
v2: Only remove sysfs links when the function fails.

 drivers/acpi/fan.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 947556e..6b110c7 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -249,8 +249,8 @@ static int acpi_fan_add(struct acpi_device *device)
 
 	result = acpi_bus_get_power(device->handle, &state);
 	if (result) {
-		printk(KERN_ERR PREFIX "Reading power state\n");
-		goto end;
+		printk(KERN_ERR PREFIX "Error reading power state\n");
+		return result;
 	}
 
 	device->flags.force_power_state = 1;
@@ -259,10 +259,8 @@ static int acpi_fan_add(struct acpi_device *device)
 
 	cdev = thermal_cooling_device_register("Fan", device,
 						&fan_cooling_ops);
-	if (IS_ERR(cdev)) {
-		result = PTR_ERR(cdev);
-		goto end;
-	}
+	if (IS_ERR(cdev))
+		return PTR_ERR(cdev);
 
 	dev_info(&device->dev, "registered as cooling_device%d\n", cdev->id);
 
@@ -283,13 +281,19 @@ static int acpi_fan_add(struct acpi_device *device)
 
 	result = acpi_fan_add_fs(device);
 	if (result)
-		goto end;
+		goto err_unregister;
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
-      end:
+	return 0;
+
+err_unregister:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+	sysfs_remove_link(&cdev->device.kobj, "device");
+	thermal_cooling_device_unregister(cdev);
+
 	return result;
 }
 
-- 
1.6.3.2



