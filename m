From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/140] ACPI: add acpi_bus_ops in acpi_device
Date: Wed,  7 Feb 2007 13:50:22 -0500
Message-ID: <11708743783727-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:27002 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422666AbXBGSxH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:07 -0500
In-Reply-To: <11708743723353-git-send-email-lenb@kernel.org>
Message-Id: <c4168bff32e218b8400cb48b48adb9b7f7bb31b8.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Li Shaohua <shaohua.li@intel.com>

Add acpi_bus_ops in acpi_device to support acpi hot plug.

NOTE:	Two methods .add and .start in acpi_driver.ops are
	called separately to probe ACPI devices, while only
	.probe method is called in driver model.
	As executing .add and .start separately is critical
	for ACPI device hot plug, we use acpi_bus_ops to
	distinguish different code path.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |   55 ++++++++++++++++++++++++-----------------------
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 97f6bbd..2a82645 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -212,7 +212,8 @@ static int acpi_device_probe(struct device * dev)
 
 	ret = acpi_bus_driver_init(acpi_dev, acpi_drv);
 	if (!ret) {
-		acpi_start_single_object(acpi_dev);
+		if (acpi_dev->bus_ops.acpi_op_start)
+			acpi_start_single_object(acpi_dev);
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			"Found driver [%s] for device [%s]\n",
 			acpi_drv->name, acpi_dev->pnp.bus_id));
@@ -305,7 +306,6 @@ static void acpi_device_unregister(struct acpi_device *device, int type)
 		list_del(&device->g_list);
 
 	list_del(&device->wakeup_list);
-
 	spin_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
@@ -876,7 +876,8 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 
 static int
 acpi_add_single_object(struct acpi_device **child,
-		       struct acpi_device *parent, acpi_handle handle, int type)
+		       struct acpi_device *parent, acpi_handle handle, int type,
+			struct acpi_bus_ops *ops)
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
@@ -894,6 +895,8 @@ acpi_add_single_object(struct acpi_device **child,
 
 	device->handle = handle;
 	device->parent = parent;
+	device->bus_ops = *ops; /* workround for not call .start */
+
 
 	acpi_device_get_busid(device, handle, type);
 
@@ -1079,14 +1082,14 @@ static int acpi_bus_scan(struct acpi_device *start, struct acpi_bus_ops *ops)
 
 		if (ops->acpi_op_add)
 			status = acpi_add_single_object(&child, parent,
-							chandle, type);
+				chandle, type, ops);
 		else
 			status = acpi_bus_get_device(chandle, &child);
 
 		if (ACPI_FAILURE(status))
 			continue;
 
-		if (ops->acpi_op_start) {
+		if (ops->acpi_op_start && !(ops->acpi_op_add)) {
 			status = acpi_start_single_object(child);
 			if (ACPI_FAILURE(status))
 				continue;
@@ -1124,13 +1127,13 @@ acpi_bus_add(struct acpi_device **child,
 	int result;
 	struct acpi_bus_ops ops;
 
+	memset(&ops, 0, sizeof(ops));
+	ops.acpi_op_add = 1;
 
-	result = acpi_add_single_object(child, parent, handle, type);
-	if (!result) {
-		memset(&ops, 0, sizeof(ops));
-		ops.acpi_op_add = 1;
+	result = acpi_add_single_object(child, parent, handle, type, &ops);
+	if (!result)
 		result = acpi_bus_scan(*child, &ops);
-	}
+
 	return result;
 }
 
@@ -1216,28 +1219,30 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
-
+	struct acpi_bus_ops ops;
 
 	if (!root)
 		return -ENODEV;
 
+	memset(&ops, 0, sizeof(ops));
+	ops.acpi_op_add = 1;
+	ops.acpi_op_start = 1;
+
 	/*
 	 * Enumerate all fixed-feature devices.
 	 */
 	if (acpi_fadt.pwr_button == 0) {
 		result = acpi_add_single_object(&device, acpi_root,
 						NULL,
-						ACPI_BUS_TYPE_POWER_BUTTON);
-		if (!result)
-			result = acpi_start_single_object(device);
+						ACPI_BUS_TYPE_POWER_BUTTON,
+						&ops);
 	}
 
 	if (acpi_fadt.sleep_button == 0) {
 		result = acpi_add_single_object(&device, acpi_root,
 						NULL,
-						ACPI_BUS_TYPE_SLEEP_BUTTON);
-		if (!result)
-			result = acpi_start_single_object(device);
+						ACPI_BUS_TYPE_SLEEP_BUTTON,
+						&ops);
 	}
 
 	return result;
@@ -1252,6 +1257,10 @@ static int __init acpi_scan_init(void)
 	if (acpi_disabled)
 		return 0;
 
+	memset(&ops, 0, sizeof(ops));
+	ops.acpi_op_add = 1;
+	ops.acpi_op_start = 1;
+
 	result = bus_register(&acpi_bus_type);
 	if (result) {
 		/* We don't want to quit even if we failed to add suspend/resume */
@@ -1262,11 +1271,7 @@ static int __init acpi_scan_init(void)
 	 * Create the root device in the bus's device tree
 	 */
 	result = acpi_add_single_object(&acpi_root, NULL, ACPI_ROOT_OBJECT,
-					ACPI_BUS_TYPE_SYSTEM);
-	if (result)
-		goto Done;
-
-	result = acpi_start_single_object(acpi_root);
+					ACPI_BUS_TYPE_SYSTEM, &ops);
 	if (result)
 		goto Done;
 
@@ -1274,12 +1279,8 @@ static int __init acpi_scan_init(void)
 	 * Enumerate devices in the ACPI namespace.
 	 */
 	result = acpi_bus_scan_fixed(acpi_root);
-	if (!result) {
-		memset(&ops, 0, sizeof(ops));
-		ops.acpi_op_add = 1;
-		ops.acpi_op_start = 1;
+	if (!result)
 		result = acpi_bus_scan(acpi_root, &ops);
-	}
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 598fab3..8976dbe 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -300,6 +300,7 @@ struct acpi_device {
 	struct acpi_driver *driver;
 	void *driver_data;
 	struct device dev;
+	struct acpi_bus_ops bus_ops;	/* workaround for different code path for hotplug */
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
-- 
1.5.0.rc3.39.gec804
