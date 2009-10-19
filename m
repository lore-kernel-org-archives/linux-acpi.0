From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v4 5/6] ACPI: dock: add struct dock_station * directly to
	platform device data
Date: Mon, 19 Oct 2009 15:14:45 -0600
Message-ID: <20091019211445.5412.89413.stgit@bob.kio>
References: <20091019211132.5412.80438.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:28418 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757662AbZJSVOl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 17:14:41 -0400
In-Reply-To: <20091019211132.5412.80438.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =shaohua.li@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of adding a (struct dock_station **) to our dock device's
platform data, we can add the (struct dock_station *) directly.

This change saves us some ugly casting and improves readability.

The cost of making this change is an extra 290 bytes of stack usage,
but this is an infrequently called code-path and unlikely to cause
the kernel to blow up.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/dock.c |   40 +++++++++++++---------------------------
 1 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 9242004..de6ee18 100644
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
 

