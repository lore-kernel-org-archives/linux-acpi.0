From: Zhang Rui <rui.zhang@intel.com>
Subject: [08/12] acpi: add acpi_bus_ops in acpi_device
Date: Fri, 22 Sep 2006 17:45:16 +0800
Message-ID: <1158918316.11985.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6419 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751126AbWIVJnl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:43:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Li Shaohua <shaohua.li@intel.com>

Add acpi_bus_ops in acpi_device to support acpi hot plug.

NOTE:	Two methods .add and .start in acpi_driver.ops are 
	called separately to probe ACPI devices, while only 
	.probe method is called in driver model.
	As executing .add and .start separately is critical 
	for ACPI device hot plug, we use acpi_bus_ops to 
	distinguish different code path.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/scan.c     |   55 ++++++++++++++++++++++++------------------------
 include/acpi/acpi_bus.h |    1 
 2 files changed, 29 insertions(+), 27 deletions(-)

Index: linux-2.6.18/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/scan.c	2006-09-21 21:07:35.000000000 +0800
+++ linux-2.6.18/drivers/acpi/scan.c	2006-09-21 21:15:34.000000000 +0800
@@ -212,7 +212,8 @@ static int acpi_device_probe(struct devi
 
 	ret = acpi_bus_driver_init(acpi_dev, acpi_drv);
 	if (!ret) {
-		acpi_start_single_object(acpi_dev);
+		if (acpi_dev->bus_ops.acpi_op_start)
+			acpi_start_single_object(acpi_dev);
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			"Found driver [%s] for device [%s]\n",
 			acpi_drv->name, acpi_dev->pnp.bus_id));
@@ -305,7 +306,6 @@ static void acpi_device_unregister(struc
 		list_del(&device->g_list);
 
 	list_del(&device->wakeup_list);
-
 	spin_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
@@ -876,7 +876,8 @@ static int acpi_bus_remove(struct acpi_d
 
 static int
 acpi_add_single_object(struct acpi_device **child,
-		       struct acpi_device *parent, acpi_handle handle, int type)
+		       struct acpi_device *parent, acpi_handle handle, int type,
+			struct acpi_bus_ops *ops)
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
@@ -894,6 +895,8 @@ acpi_add_single_object(struct acpi_devic
 
 	device->handle = handle;
 	device->parent = parent;
+	device->bus_ops = *ops; /* workround for not call .start */
+
 
 	acpi_device_get_busid(device, handle, type);
 
@@ -1079,14 +1082,14 @@ static int acpi_bus_scan(struct acpi_dev
 
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
 
@@ -1216,28 +1219,30 @@ static int acpi_bus_scan_fixed(struct ac
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
Index: linux-2.6.18/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18.orig/include/acpi/acpi_bus.h	2006-09-21 21:08:35.000000000 +0800
+++ linux-2.6.18/include/acpi/acpi_bus.h	2006-09-21 21:15:34.000000000 +0800
@@ -300,6 +300,7 @@ struct acpi_device {
 	struct acpi_driver *driver;
 	void *driver_data;
 	struct device dev;
+	struct acpi_bus_ops bus_ops;	/* workaround for different code path for hotplug */
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
