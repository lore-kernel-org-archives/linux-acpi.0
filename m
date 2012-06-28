From: Jiang Liu <jiang.liu@huawei.com>
Subject: [RFC PATCH] ACPI: use IDA to manage instance IDs for acpi devices
Date: Thu, 28 Jun 2012 12:07:15 +0800
Message-ID: <1340856435-2116-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:1505 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab2F1EJM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 00:09:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lin Ming <ming.m.lin@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>, Keping Chen <chenkeping@huawei.com>, linux-acpi@vger.kernel.org, Jiang Liu <liuj97@gmail.com>, Gaohuai Han <hangaohuai@huawei.com>

Currently ACPI device instance ID won't be released when hot-remvoing
an ACPI device. When hot-replacing an ACPI device for several times,
the ACPI device instance ID will keep on increasing, which is a little
inconvenient. So use IDA to manage ACPI device instance IDs.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Gaohuai Han <hangaohuai@huawei.com>
---
 drivers/acpi/scan.c |   90 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c8a1f3b..7ae9675 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -12,6 +12,7 @@
 #include <linux/dmi.h>
 
 #include <acpi/acpi_drivers.h>
+#include <linux/idr.h>
 
 #include "internal.h"
 
@@ -35,7 +36,7 @@ LIST_HEAD(acpi_wakeup_device_list);
 
 struct acpi_device_bus_id{
 	char bus_id[15];
-	unsigned int instance_no;
+	struct ida ida;
 	struct list_head node;
 };
 
@@ -449,11 +450,58 @@ struct bus_type acpi_bus_type = {
 	.uevent		= acpi_device_uevent,
 };
 
+static int acpi_device_get_id_name(struct acpi_device *device)
+{
+	int result = -ENOENT;
+	struct acpi_device_bus_id *bus_id;
+	const char *hid = acpi_device_hid(device);
+
+	list_for_each_entry(bus_id, &acpi_bus_id_list, node)
+		if (!strcmp(bus_id->bus_id, hid)) {
+			result = 0;
+			break;
+		}
+	if (result) {
+		bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
+		if (bus_id) {
+			ida_init(&bus_id->ida);
+			strcpy(bus_id->bus_id, hid);
+			list_add_tail(&bus_id->node, &acpi_bus_id_list);
+		}
+	}
+
+	if (!bus_id)
+		result = -ENOMEM;
+	else
+		do {
+			if (!ida_pre_get(&bus_id->ida, GFP_KERNEL))
+				break;
+			result = ida_get_new(&bus_id->ida, &device->dev.id);
+		} while (result == -EAGAIN);
+
+	if (!result)
+		dev_set_name(&device->dev, "%s:%02x",
+			     bus_id->bus_id, device->dev.id);
+
+	return result;
+}
+
+static void acpi_device_release_id(struct acpi_device *device)
+{
+	struct acpi_device_bus_id *bus_id;
+	const char *hid = acpi_device_hid(device);
+
+	list_for_each_entry(bus_id, &acpi_bus_id_list, node) {
+		if (!strcmp(bus_id->bus_id, hid)) {
+			ida_remove(&bus_id->ida, device->dev.id);
+			break;
+		}
+	}
+}
+
 static int acpi_device_register(struct acpi_device *device)
 {
 	int result;
-	struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
-	int found = 0;
 
 	/*
 	 * Linkage
@@ -464,33 +512,12 @@ static int acpi_device_register(struct acpi_device *device)
 	INIT_LIST_HEAD(&device->node);
 	INIT_LIST_HEAD(&device->wakeup_list);
 
-	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
-	if (!new_bus_id) {
-		printk(KERN_ERR PREFIX "Memory allocation error\n");
-		return -ENOMEM;
-	}
-
 	mutex_lock(&acpi_device_lock);
-	/*
-	 * Find suitable bus_id and instance number in acpi_bus_id_list
-	 * If failed, create one and link it into acpi_bus_id_list
-	 */
-	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
-		if (!strcmp(acpi_device_bus_id->bus_id,
-			    acpi_device_hid(device))) {
-			acpi_device_bus_id->instance_no++;
-			found = 1;
-			kfree(new_bus_id);
-			break;
-		}
-	}
-	if (!found) {
-		acpi_device_bus_id = new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
-		acpi_device_bus_id->instance_no = 0;
-		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
+	result = acpi_device_get_id_name(device);
+	if (result) {
+		dev_err(&device->dev, "fail to allocate instance ID\n");
+		goto out_unlock;
 	}
-	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 
 	if (device->parent)
 		list_add_tail(&device->node, &device->parent->children);
@@ -506,7 +533,7 @@ static int acpi_device_register(struct acpi_device *device)
 	result = device_register(&device->dev);
 	if (result) {
 		dev_err(&device->dev, "Error registering device\n");
-		goto end;
+		goto out_unlink;
 	}
 
 	result = acpi_device_setup_files(device);
@@ -516,11 +543,12 @@ static int acpi_device_register(struct acpi_device *device)
 
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 	return 0;
-end:
+out_unlink:
 	mutex_lock(&acpi_device_lock);
 	if (device->parent)
 		list_del(&device->node);
 	list_del(&device->wakeup_list);
+out_unlock:
 	mutex_unlock(&acpi_device_lock);
 	return result;
 }
@@ -530,8 +558,8 @@ static void acpi_device_unregister(struct acpi_device *device, int type)
 	mutex_lock(&acpi_device_lock);
 	if (device->parent)
 		list_del(&device->node);
-
 	list_del(&device->wakeup_list);
+	acpi_device_release_id(device);
 	mutex_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
-- 
1.7.1


