From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/4] ACPI: add battery hotplug support
Date: Thu, 17 Jan 2008 09:19:48 +0800
Message-ID: <1200532788.2935.69.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17314 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbYAQBO1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:14:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

From:Zhang Rui <rui.zhang@intel.com>
Subject: add battery hotplug support

Battery device hotplug support in generic code.
Check the notify value and hot-insert/hot-remove the device
in acpi global system notify handler.

We only support battery device for now.
http://bugzilla.kernel.org/show_bug.cgi?id=2884

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/bus.c      |   58 +++++++++++++++++++++-
 drivers/acpi/scan.c     |  123 +++++++++++++++++++++++++++++++++++++++++++-----
 include/acpi/acpi_bus.h |    2 
 3 files changed, 168 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -86,22 +86,53 @@ acpi_device_modalias_show(struct device 
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
 
-static int acpi_eject_operation(acpi_handle handle, int lockable)
+static acpi_status
+acpi_bus_insert_device(acpi_handle handle)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+	status = acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Locking device failed\n"));
+
+	/* power on device */
+	status = acpi_evaluate_object(handle, "_PS0", NULL, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Power-on device failed\n"));
+
+	return AE_OK;
+}
+
+static acpi_status
+acpi_bus_eject_device(acpi_handle handle, int lockable)
 {
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
 
-	/*
-	 * TBD: evaluate _PS3?
-	 */
+	/* power off device */
+	status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Power-off device failed\n"));
 
 	if (lockable) {
 		arg_list.count = 1;
 		arg_list.pointer = &arg;
 		arg.type = ACPI_TYPE_INTEGER;
 		arg.integer.value = 0;
-		acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
+		status = acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
+		if (ACPI_FAILURE(status))
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+					"Unlocking device failed\n"));
 	}
 
 	arg_list.count = 1;
@@ -112,13 +143,12 @@ static int acpi_eject_operation(acpi_han
 	/*
 	 * TBD: _EJD support.
 	 */
-
 	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
-	if (ACPI_FAILURE(status)) {
-		return (-ENODEV);
-	}
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Ejecting device failed\n"));
 
-	return (0);
+	return 0;
 }
 
 static ssize_t
@@ -154,7 +184,7 @@ acpi_eject_store(struct device *d, struc
 	result = acpi_bus_trim(acpi_device, 1);
 
 	if (!result)
-		result = acpi_eject_operation(handle, islockable);
+		result = acpi_bus_eject_device(handle, islockable);
 
 	if (result) {
 		ret = -EBUSY;
@@ -493,6 +523,72 @@ static void acpi_device_unregister(struc
 	device_unregister(&device->dev);
 }
 
+void acpi_bus_hot_insert_device(void *context)
+{
+	acpi_handle handle = context;
+	acpi_handle		phandle;
+	struct acpi_device	*pdev = NULL;
+	struct acpi_device	*device = NULL;
+	struct acpi_device_status sta;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Hot-inserting device...\n"));
+
+	if (acpi_evaluate_integer(handle, "_STA", NULL,
+				  (unsigned long *)&sta) ||
+				  !sta.present)
+		return;
+
+	if (acpi_get_parent(handle, &phandle)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Can't get device's parent\n"));
+		return;
+	}
+
+	if (acpi_bus_get_device(phandle, &pdev)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Device's parrent isn't present\n"));
+		return;
+	}
+
+	acpi_bus_insert_device(handle);
+
+	if (acpi_bus_add(&device, pdev, handle, ACPI_BUS_TYPE_DEVICE))
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Hot-inserting device failed\n"));
+
+	return;
+}
+EXPORT_SYMBOL(acpi_bus_hot_insert_device);
+
+void acpi_bus_hot_remove_device(void *context)
+{
+	struct acpi_device *device;
+	acpi_handle handle = context;
+	int lockable;
+
+	if (acpi_bus_get_device(handle, &device))
+		return;
+
+	if (!device)
+		return;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Hot-removing device %s...\n", device->dev.bus_id));
+
+	lockable = device->flags.lockable;
+
+	if (acpi_bus_trim(device, 1)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Removing device failed\n"));
+		return;
+	}
+
+	acpi_bus_eject_device(handle, lockable);
+
+	return;
+}
+EXPORT_SYMBOL(acpi_bus_hot_remove_device);
 /* --------------------------------------------------------------------------
                                  Driver Management
    -------------------------------------------------------------------------- */
@@ -1399,6 +1495,11 @@ int acpi_bus_trim(struct acpi_device *st
 		if (ACPI_FAILURE(status)) {
 			continue;
 		}
+
+		if (type != ACPI_TYPE_DEVICE && type != ACPI_TYPE_PROCESSOR
+			&& type != ACPI_TYPE_THERMAL && type != ACPI_TYPE_POWER)
+			continue;
+
 		/*
 		 * If there is a device corresponding to chandle then
 		 * parse it (depth-first).
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -337,6 +337,8 @@ int acpi_bus_receive_event(struct acpi_b
 static inline int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
 	{ return 0; }
 #endif
+void acpi_bus_hot_insert_device(void *);
+void acpi_bus_hot_remove_device(void *);
 int acpi_bus_register_driver(struct acpi_driver *driver);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -47,6 +47,12 @@ struct acpi_device *acpi_root;
 struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
 
+/* list of hotpluggable device hardware ids */
+static const char *acpi_hotplug_device_ids[] = {
+		"PNP0C0A",
+		NULL,
+};
+
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
 /* --------------------------------------------------------------------------
@@ -450,6 +456,17 @@ static int acpi_bus_check_scope(struct a
 	return 0;
 }
 
+static int is_device_hotpluggable(char *hardware_id)
+{
+	int i;
+
+	for (i = 0; acpi_hotplug_device_ids[i]; i++)
+		if (!strcmp(hardware_id, acpi_hotplug_device_ids[i]))
+			return 0;
+
+	return -ENODEV;
+}
+
 /**
  * acpi_bus_notify
  * ---------------
@@ -460,8 +477,8 @@ static void acpi_bus_notify(acpi_handle 
 	int result = 0;
 	struct acpi_device *device = NULL;
 
-
-	if (acpi_bus_get_device(handle, &device))
+	if (acpi_bus_get_device(handle, &device) &&
+		type != ACPI_NOTIFY_DEVICE_CHECK)
 		return;
 
 	switch (type) {
@@ -481,7 +498,30 @@ static void acpi_bus_notify(acpi_handle 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Received DEVICE CHECK notification for device [%s]\n",
 				  device->pnp.bus_id));
-		result = acpi_bus_check_device(device, NULL);
+		if (device)
+			result = acpi_bus_check_device(device, NULL);
+		else {
+			/* hot insert device */
+			struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER,
+							 NULL};
+			struct acpi_device_info *info;
+			acpi_status status;
+
+			status = acpi_get_object_info(handle, &buffer);
+			if (ACPI_FAILURE(status))
+				goto err;
+			info = buffer.pointer;
+			if (info->valid & ACPI_VALID_HID)
+				if (!is_device_hotpluggable(info->hardware_id.value)) {
+					if (acpi_os_execute(OSL_DEVICE_HOTPLUG_HANDLER,
+							    acpi_bus_hot_insert_device,
+							    handle)) {
+						kfree(buffer.pointer);
+						goto err;
+				}
+			}
+			kfree(buffer.pointer);
+		}
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
@@ -499,7 +539,13 @@ static void acpi_bus_notify(acpi_handle 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Received EJECT REQUEST notification for device [%s]\n",
 				  device->pnp.bus_id));
-		/* TBD */
+		/* hot remove device */
+		if (!is_device_hotpluggable(device->pnp.hardware_id)) {
+			if (acpi_os_execute(OSL_DEVICE_HOTPLUG_HANDLER,
+					    acpi_bus_hot_remove_device,
+					    device->handle))
+				goto err;
+		}
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
@@ -538,6 +584,10 @@ static void acpi_bus_notify(acpi_handle 
 	}
 
 	return;
+
+err:
+	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Failed to handle notify!\n"));
+	return;
 }
 
 /* --------------------------------------------------------------------------


