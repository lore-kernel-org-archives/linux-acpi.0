From: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/77] ACPI: dock: use dynamically allocated platform device
Date: Sun, 22 Jul 2007 05:13:53 -0400
Message-ID: <11850957102641-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54665 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762049AbXGVJPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:11 -0400
In-Reply-To: <11850957093360-git-send-email-len.brown@intel.com>
Message-Id: <0f6f2804563eee64f0fc7cbcb009b98b6f332af6.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Get rid of no release function warnings by switching to dynamically
allocating the platform_device and using the platform device release
routine in the base driver.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   47 +++++++++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index f66f4f7..b5addd4 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -41,7 +41,7 @@ MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
 static struct atomic_notifier_head dock_notifier_list;
-static struct platform_device dock_device;
+static struct platform_device *dock_device;
 static char dock_device_name[] = "dock";
 
 struct dock_station {
@@ -327,7 +327,7 @@ static void hotplug_dock_devices(struct dock_station *ds, u32 event)
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
-	struct device *dev = &dock_device.dev;
+	struct device *dev = &dock_device->dev;
 	/*
 	 * Indicate that the status of the dock station has
 	 * changed.
@@ -710,37 +710,36 @@ static int dock_add(acpi_handle handle)
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
 	/* initialize platform device stuff */
-	dock_device.name = dock_device_name;
-	ret = platform_device_register(&dock_device);
-	if (ret) {
-		printk(KERN_ERR PREFIX "Error %d registering dock device\n", ret);
+	dock_device =
+		platform_device_register_simple(dock_device_name, 0, NULL, 0);
+	if (IS_ERR(dock_device)) {
 		kfree(dock_station);
 		dock_station = NULL;
-		return ret;
+		return PTR_ERR(dock_device);
 	}
-	ret = device_create_file(&dock_device.dev, &dev_attr_docked);
+	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
-		platform_device_unregister(&dock_device);
+		platform_device_unregister(dock_device);
 		kfree(dock_station);
 		dock_station = NULL;
 		return ret;
 	}
-	ret = device_create_file(&dock_device.dev, &dev_attr_undock);
+	ret = device_create_file(&dock_device->dev, &dev_attr_undock);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device.dev, &dev_attr_docked);
-		platform_device_unregister(&dock_device);
+		device_remove_file(&dock_device->dev, &dev_attr_docked);
+		platform_device_unregister(dock_device);
 		kfree(dock_station);
 		dock_station = NULL;
 		return ret;
 	}
-	ret = device_create_file(&dock_device.dev, &dev_attr_uid);
+	ret = device_create_file(&dock_device->dev, &dev_attr_uid);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device.dev, &dev_attr_docked);
-		device_remove_file(&dock_device.dev, &dev_attr_undock);
-		platform_device_unregister(&dock_device);
+		device_remove_file(&dock_device->dev, &dev_attr_docked);
+		device_remove_file(&dock_device->dev, &dev_attr_undock);
+		platform_device_unregister(dock_device);
 		kfree(dock_station);
 		dock_station = NULL;
 		return ret;
@@ -779,10 +778,10 @@ static int dock_add(acpi_handle handle)
 dock_add_err:
 	kfree(dd);
 dock_add_err_unregister:
-	device_remove_file(&dock_device.dev, &dev_attr_docked);
-	device_remove_file(&dock_device.dev, &dev_attr_undock);
-	device_remove_file(&dock_device.dev, &dev_attr_uid);
-	platform_device_unregister(&dock_device);
+	device_remove_file(&dock_device->dev, &dev_attr_docked);
+	device_remove_file(&dock_device->dev, &dev_attr_undock);
+	device_remove_file(&dock_device->dev, &dev_attr_uid);
+	platform_device_unregister(dock_device);
 	kfree(dock_station);
 	dock_station = NULL;
 	return ret;
@@ -812,10 +811,10 @@ static int dock_remove(void)
 		printk(KERN_ERR "Error removing notify handler\n");
 
 	/* cleanup sysfs */
-	device_remove_file(&dock_device.dev, &dev_attr_docked);
-	device_remove_file(&dock_device.dev, &dev_attr_undock);
-	device_remove_file(&dock_device.dev, &dev_attr_uid);
-	platform_device_unregister(&dock_device);
+	device_remove_file(&dock_device->dev, &dev_attr_docked);
+	device_remove_file(&dock_device->dev, &dev_attr_undock);
+	device_remove_file(&dock_device->dev, &dev_attr_uid);
+	platform_device_unregister(dock_device);
 
 	/* free dock station memory */
 	kfree(dock_station);
-- 
1.5.3.rc2.22.g69a9b
