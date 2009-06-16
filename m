From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 10/15] eeepc-laptop: right parent device
Date: Tue, 16 Jun 2009 21:28:51 +0200
Message-ID: <1245180536-28009-11-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-8-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-9-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-10-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60977 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbZFPTb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:26 -0400
In-Reply-To: <1245180536-28009-10-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 7b7c750..7121239 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1061,18 +1061,6 @@ static int __init eeepc_laptop_init(void)
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
 
@@ -1093,12 +1081,30 @@ static int __init eeepc_laptop_init(void)
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
@@ -1108,10 +1114,6 @@ fail_platform_device2:
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

