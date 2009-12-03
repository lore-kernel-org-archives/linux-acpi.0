From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 21/33] eeepc-laptop: move platform driver registration out of eeepc_hotk_add()
Date: Thu,  3 Dec 2009 08:45:05 +0100
Message-ID: <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44229 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbZLCHog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:36 -0500
In-Reply-To: <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Strictly speaking we should register the platform driver exactly once,
whether there are zero, one, or multiple matching acpi devices.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index b4eacb6..3f9b286 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1276,13 +1276,10 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 
 	result = eeepc_hotk_init();
 	if (result)
-		goto fail_platform_driver;
+		goto fail_platform_device1;
 	eeepc_enable_camera();
 
 	/* Register platform stuff */
-	result = platform_driver_register(&platform_driver);
-	if (result)
-		goto fail_platform_driver;
 	platform_device = platform_device_alloc(EEEPC_HOTK_FILE, -1);
 	if (!platform_device) {
 		result = -ENOMEM;
@@ -1340,8 +1337,6 @@ fail_sysfs:
 fail_platform_device2:
 	platform_device_put(platform_device);
 fail_platform_device1:
-	platform_driver_unregister(&platform_driver);
-fail_platform_driver:
 	kfree(ehotk);
 
 	return result;
@@ -1357,7 +1352,6 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	sysfs_remove_group(&platform_device->dev.kobj,
 			   &platform_attribute_group);
 	platform_device_unregister(platform_device);
-	platform_driver_unregister(&platform_driver);
 
 	kfree(ehotk);
 	return 0;
@@ -1367,19 +1361,30 @@ static int __init eeepc_laptop_init(void)
 {
 	int result;
 
-	result = acpi_bus_register_driver(&eeepc_hotk_driver);
+	result = platform_driver_register(&platform_driver);
 	if (result < 0)
 		return result;
+
+	result = acpi_bus_register_driver(&eeepc_hotk_driver);
+	if (result < 0)
+		goto fail_acpi_driver;
 	if (!ehotk) {
-		acpi_bus_unregister_driver(&eeepc_hotk_driver);
-		return -ENODEV;
+		result = -ENODEV;
+		goto fail_no_device;
 	}
 	return 0;
+
+fail_no_device:
+	acpi_bus_unregister_driver(&eeepc_hotk_driver);
+fail_acpi_driver:
+	platform_driver_unregister(&platform_driver);
+	return result;
 }
 
 static void __exit eeepc_laptop_exit(void)
 {
 	acpi_bus_unregister_driver(&eeepc_hotk_driver);
+	platform_driver_unregister(&platform_driver);
 }
 
 module_init(eeepc_laptop_init);
-- 
1.6.5.3

