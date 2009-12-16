From: Len Brown <lenb@kernel.org>
Subject: [PATCH 101/103] ACPI: dock: add struct dock_station * directly to
 platform device data
Date: Wed, 16 Dec 2009 03:36:52 -0500
Message-ID: <fe06fba292af5ed5c1c6ad9af3a9ef68da7a5088.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761972AbZLPLFw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:05:52 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:51 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Instead of adding a (struct dock_station **) to our dock device's
platform data, we can add the (struct dock_station *) directly.

This change saves us some ugly casting and improves readability.

The cost of making this change is an extra 290 bytes of stack usage,
but this is an infrequently called code-path and unlikely to cause
the kernel to blow up.

Signed-off-by: Alex Chiang <achiang@hp.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   40 +++++++++++++---------------------------
 1 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 3bd8982..cfcd8ee 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -843,8 +843,7 @@ static ssize_t show_docked(struct device *dev,
 {
 	struct acpi_device *tmp;
 
-	struct dock_station *dock_station = *((struct dock_station **)
-		dev->platform_data);
+	struct dock_station *dock_station = dev->platform_data;
 
 	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
 		return snprintf(buf, PAGE_SIZE, "1\n");
@@ -858,8 +857,7 @@ static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 static ssize_t show_flags(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	struct dock_station *dock_station = *((struct dock_station **)
-		dev->platform_data);
+	struct dock_station *dock_station = dev->platform_data;
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
 
 }
@@ -872,8 +870,7 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
 	int ret;
-	struct dock_station *dock_station = *((struct dock_station **)
-		dev->platform_data);
+	struct dock_station *dock_station = dev->platform_data;
 
 	if (!count)
 		return -EINVAL;
@@ -891,8 +888,7 @@ static ssize_t show_dock_uid(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	unsigned long long lbuf;
-	struct dock_station *dock_station = *((struct dock_station **)
-		dev->platform_data);
+	struct dock_station *dock_station = dev->platform_data;
 	acpi_status status = acpi_evaluate_integer(dock_station->handle,
 					"_UID", NULL, &lbuf);
 	if (ACPI_FAILURE(status))
@@ -905,8 +901,7 @@ static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 static ssize_t show_dock_type(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct dock_station *dock_station = *((struct dock_station **)
-		dev->platform_data);
+	struct dock_station *dock_station = dev->platform_data;
 	char *type;
 
 	if (dock_station->flags & DOCK_IS_DOCK)
@@ -944,20 +939,18 @@ static struct attribute_group dock_attribute_group = {
  */
 static int dock_add(acpi_handle handle)
 {
-	int ret;
-	struct dock_station *dock_station;
+	int ret, id;
+	struct dock_station ds, *dock_station;
 	struct platform_device *dock_device;
 
+	id = dock_station_count;
 	dock_device =
-		platform_device_register_simple("dock",
-			dock_station_count, NULL, 0);
+		platform_device_register_data(NULL, "dock",
+			id, &ds, sizeof(ds));
 	if (IS_ERR(dock_device))
 		return PTR_ERR(dock_device);
 
-	/* allocate & initialize the dock_station private data */
-	dock_station = kzalloc(sizeof(*dock_station), GFP_KERNEL);
-	if (!dock_station)
-		return -ENOMEM;
+	dock_station = dock_device->dev.platform_data;
 	dock_station->handle = handle;
 	dock_station->dock_device = dock_device;
 	dock_station->last_dock_time = jiffies - HZ;
@@ -968,9 +961,6 @@ static int dock_add(acpi_handle handle)
 	mutex_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
-	platform_device_add_data(dock_device, &dock_station,
-		sizeof(struct dock_station *));
-
 	/* we want the dock device to send uevents */
 	dev_set_uevent_suppress(&dock_device->dev, 0);
 
@@ -1003,9 +993,6 @@ err_rmgroup:
 	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
 err_unregister:
 	platform_device_unregister(dock_device);
-out:
-	kfree(dock_station);
-	dock_station = NULL;
 	printk(KERN_ERR "%s encountered error %d\n", __func__, ret);
 	return ret;
 }
@@ -1026,13 +1013,12 @@ static int dock_remove(struct dock_station *dock_station)
 				 list)
 	    kfree(dd);
 
+	list_del(&dock_station->sibling);
+
 	/* cleanup sysfs */
 	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
 	platform_device_unregister(dock_device);
 
-	/* free dock station memory */
-	kfree(dock_station);
-	dock_station = NULL;
 	return 0;
 }
 
-- 
1.6.0.6

