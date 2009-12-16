From: Len Brown <lenb@kernel.org>
Subject: [PATCH 001/103] ACPI: dock: convert sysfs attributes to an
 attribute_group
Date: Wed, 16 Dec 2009 03:35:12 -0500
Message-ID: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:39440 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbZLPIhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:04 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0098YL9N9AUG@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

As suggested by Dmitry Torokhov, convert the individual sysfs
attributes into an attribute group.

This change eliminates quite a bit of copy/paste code in the
error handling paths.

Signed-off-by: Alex Chiang <achiang@hp.com>
Reviewed-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   81 +++++++++++++++------------------------------------
 1 files changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7338b6a..4f2aa98 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -936,6 +936,19 @@ static ssize_t show_dock_type(struct device *dev,
 }
 static DEVICE_ATTR(type, S_IRUGO, show_dock_type, NULL);
 
+static struct attribute *dock_attributes[] = {
+	&dev_attr_docked.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_undock.attr,
+	&dev_attr_uid.attr,
+	&dev_attr_type.attr,
+	NULL
+};
+
+static struct attribute_group dock_attribute_group = {
+	.attrs = dock_attributes
+};
+
 /**
  * dock_add - add a new dock station
  * @handle: the dock station handle
@@ -969,9 +982,8 @@ static int dock_add(acpi_handle handle)
 			dock_station_count, NULL, 0);
 	dock_device = dock_station->dock_device;
 	if (IS_ERR(dock_device)) {
-		kfree(dock_station);
-		dock_station = NULL;
-		return PTR_ERR(dock_device);
+		ret = PTR_ERR(dock_device);
+		goto out;
 	}
 	platform_device_add_data(dock_device, &dock_station,
 		sizeof(struct dock_station *));
@@ -986,47 +998,9 @@ static int dock_add(acpi_handle handle)
 	if (is_battery(handle))
 		dock_station->flags |= DOCK_IS_BAT;
 
-	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
-	ret = device_create_file(&dock_device->dev, &dev_attr_undock);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device->dev, &dev_attr_docked);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
-	ret = device_create_file(&dock_device->dev, &dev_attr_uid);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device->dev, &dev_attr_docked);
-		device_remove_file(&dock_device->dev, &dev_attr_undock);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
-	ret = device_create_file(&dock_device->dev, &dev_attr_flags);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device->dev, &dev_attr_docked);
-		device_remove_file(&dock_device->dev, &dev_attr_undock);
-		device_remove_file(&dock_device->dev, &dev_attr_uid);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
-	ret = device_create_file(&dock_device->dev, &dev_attr_type);
+	ret = sysfs_create_group(&dock_device->dev.kobj, &dock_attribute_group);
 	if (ret)
-		printk(KERN_ERR"Error %d adding sysfs file\n", ret);
+		goto err_unregister;
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -1036,10 +1010,8 @@ static int dock_add(acpi_handle handle)
 	/* add the dock station as a device dependent on itself */
 	dd = alloc_dock_dependent_device(handle);
 	if (!dd) {
-		kfree(dock_station);
-		dock_station = NULL;
 		ret = -ENOMEM;
-		goto dock_add_err_unregister;
+		goto err_rmgroup;
 	}
 	add_dock_dependent_device(dock_station, dd);
 
@@ -1047,15 +1019,14 @@ static int dock_add(acpi_handle handle)
 	list_add(&dock_station->sibling, &dock_stations);
 	return 0;
 
-dock_add_err_unregister:
-	device_remove_file(&dock_device->dev, &dev_attr_type);
-	device_remove_file(&dock_device->dev, &dev_attr_docked);
-	device_remove_file(&dock_device->dev, &dev_attr_undock);
-	device_remove_file(&dock_device->dev, &dev_attr_uid);
-	device_remove_file(&dock_device->dev, &dev_attr_flags);
+err_rmgroup:
+	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
+err_unregister:
 	platform_device_unregister(dock_device);
+out:
 	kfree(dock_station);
 	dock_station = NULL;
+	printk(KERN_ERR "%s encountered error %d\n", __func__, ret);
 	return ret;
 }
 
@@ -1076,11 +1047,7 @@ static int dock_remove(struct dock_station *dock_station)
 	    kfree(dd);
 
 	/* cleanup sysfs */
-	device_remove_file(&dock_device->dev, &dev_attr_type);
-	device_remove_file(&dock_device->dev, &dev_attr_docked);
-	device_remove_file(&dock_device->dev, &dev_attr_undock);
-	device_remove_file(&dock_device->dev, &dev_attr_uid);
-	device_remove_file(&dock_device->dev, &dev_attr_flags);
+	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
 	platform_device_unregister(dock_device);
 
 	/* free dock station memory */
-- 
1.6.0.6

