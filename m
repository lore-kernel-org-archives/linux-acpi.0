From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] eeepc-laptop: right parent device
Date: Fri, 26 Jun 2009 00:20:16 -0400
Message-ID: <7fce720f0618e26c357cab600e3438aa88c6f761.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51659 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZFZEUd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:20:33 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT006B4W28CFLF@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:34 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index e46981a..5b102c2 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1143,18 +1143,6 @@ static int __init eeepc_laptop_init(void)
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
 
@@ -1175,12 +1163,30 @@ static int __init eeepc_laptop_init(void)
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
@@ -1190,10 +1196,6 @@ fail_platform_device2:
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
1.6.0.6

