From: Len Brown <lenb@kernel.org>
Subject: [PATCH 038/103] eeepc-laptop: move platform driver registration out of
 eeepc_hotk_add()
Date: Wed, 16 Dec 2009 03:35:49 -0500
Message-ID: <22072e92a038d2ee5848b3e54499ecab730c722c.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760059AbZLPKGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:07 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:57 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Strictly speaking we should register the platform driver exactly once,
whether there are zero, one, or multiple matching acpi devices.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

