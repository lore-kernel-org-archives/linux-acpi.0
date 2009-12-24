From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/34] tc1100-wmi - add error handling for device registration
Date: Thu, 24 Dec 2009 01:23:33 -0500
Message-ID: <9634a627b330fcc7cdca25df4d7853ca9c7745de.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:58976 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbZLXGYX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:23 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV50089N8G9DVP7@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:10 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Any of the platform API functions can fail; driver should be prepared
to handle such failures. Also:

 - changed to platform_driver_probe() since the device is created
   right there with the driver;
 - added __devexit annotation to remove method;
 - fixed memory leak on module unload - named platform_device_del() is not
   enough to free platform device, need platform_device_unregister().

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/tc1100-wmi.c |   58 +++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/tc1100-wmi.c
index 0d53d51..fa2995b 100644
--- a/drivers/platform/x86/tc1100-wmi.c
+++ b/drivers/platform/x86/tc1100-wmi.c
@@ -47,22 +47,6 @@ MODULE_DESCRIPTION("HP Compaq TC1100 Tablet WMI Extras");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("wmi:C364AC71-36DB-495A-8494-B439D472A505");
 
-static int tc1100_probe(struct platform_device *device);
-static int tc1100_remove(struct platform_device *device);
-static int tc1100_suspend(struct platform_device *device, pm_message_t state);
-static int tc1100_resume(struct platform_device *device);
-
-static struct platform_driver tc1100_driver = {
-	.driver = {
-		.name = "tc1100-wmi",
-		.owner = THIS_MODULE,
-	},
-	.probe = tc1100_probe,
-	.remove = tc1100_remove,
-	.suspend = tc1100_suspend,
-	.resume = tc1100_resume,
-};
-
 static struct platform_device *tc1100_device;
 
 struct tc1100_data {
@@ -197,13 +181,13 @@ static struct attribute_group tc1100_attribute_group = {
 				Driver Model
    -------------------------------------------------------------------------- */
 
-static int tc1100_probe(struct platform_device *device)
+static int __init tc1100_probe(struct platform_device *device)
 {
 	return sysfs_create_group(&device->dev.kobj, &tc1100_attribute_group);
 }
 
 
-static int tc1100_remove(struct platform_device *device)
+static int __devexit tc1100_remove(struct platform_device *device)
 {
 	sysfs_remove_group(&device->dev.kobj, &tc1100_attribute_group);
 
@@ -240,31 +224,49 @@ static int tc1100_resume(struct platform_device *dev)
 	return ret;
 }
 
+static struct platform_driver tc1100_driver = {
+	.driver = {
+		.name = "tc1100-wmi",
+		.owner = THIS_MODULE,
+	},
+	.remove = __devexit_p(tc1100_remove),
+	.suspend = tc1100_suspend,
+	.resume = tc1100_resume,
+};
+
 static int __init tc1100_init(void)
 {
-	int result = 0;
+	int error;
 
 	if (!wmi_has_guid(GUID))
 		return -ENODEV;
 
-	result = platform_driver_register(&tc1100_driver);
-	if (result)
-		return result;
-
 	tc1100_device = platform_device_alloc("tc1100-wmi", -1);
-	platform_device_add(tc1100_device);
+	if (!tc1100_device)
+		return -ENOMEM;
+
+	error = platform_device_add(tc1100_device);
+	if (error)
+		goto err_device_put;
+
+	error = platform_driver_probe(&tc1100_driver, tc1100_probe);
+	if (error)
+		goto err_device_del;
 
 	printk(TC1100_INFO "HP Compaq TC1100 Tablet WMI Extras loaded\n");
+	return 0;
 
-	return result;
+ err_device_del:
+	platform_device_del(tc1100_device);
+ err_device_put:
+	platform_device_put(tc1100_device);
+	return error;
 }
 
 static void __exit tc1100_exit(void)
 {
-	platform_device_del(tc1100_device);
+	platform_device_unregister(tc1100_device);
 	platform_driver_unregister(&tc1100_driver);
-
-	printk(TC1100_INFO "HP Compaq TC1100 Tablet WMI Extras unloaded\n");
 }
 
 module_init(tc1100_init);
-- 
1.6.0.6

