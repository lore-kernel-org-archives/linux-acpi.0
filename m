From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 5/9] eeepc-laptop: right parent device
Date: Fri, 19 Jun 2009 14:52:07 +0200
Message-ID: <1245415931-26466-5-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-2-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-3-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-4-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23077 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbZFSMym (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:42 -0400
In-Reply-To: <1245415931-26466-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index b2e8a71..aad5d16 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1110,18 +1110,6 @@ static int __init eeepc_laptop_init(void)
 		acpi_bus_unregister_driver(&eeepc_hotk_driver);
 		return -ENODEV;
 	}
-	dev = acpi_get_physical_device(ehotk->device->handle);
-
-	if (!acpi_video_backlight_support()) {
-		result = eeepc_backlight_init(dev);
-		if (result)
-			goto fail_backlight;
-	} else
-		pr_info("Backlight controlled by ACPI video driver\n");
-
-	result = eeepc_hwmon_init(dev);
-	if (result)
-		goto fail_hwmon;
 
 	eeepc_enable_camera();
 
@@ -1142,12 +1130,30 @@ static int __init eeepc_laptop_init(void)
 	if (result)
 		goto fail_sysfs;
 
+	dev = &platform_device->dev;
+
+	if (!acpi_video_backlight_support()) {
+		result = eeepc_backlight_init(dev);
+		if (result)
+			goto fail_backlight;
+	} else
+		pr_info("Backlight controlled by ACPI video "
+			"driver\n");
+
+	result = eeepc_hwmon_init(dev);
+	if (result)
+		goto fail_hwmon;
+
 	result = eeepc_rfkill_init(dev);
 	if (result)
 		goto fail_rfkill;
 
 	return 0;
 fail_rfkill:
+	eeepc_hwmon_exit();
+fail_hwmon:
+	eeepc_backlight_exit();
+fail_backlight:
 	sysfs_remove_group(&platform_device->dev.kobj,
 			   &platform_attribute_group);
 fail_sysfs:
@@ -1157,10 +1163,6 @@ fail_platform_device2:
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
-	eeepc_hwmon_exit();
-fail_hwmon:
-	eeepc_backlight_exit();
-fail_backlight:
 	eeepc_input_exit();
 	return result;
 }
-- 
1.6.3.1


