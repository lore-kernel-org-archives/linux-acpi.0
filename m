From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Bug: linux/acpi may execute notify handler that has been
	removed
Date: Thu, 27 Sep 2007 13:03:49 +0800
Message-ID: <1190869429.4129.0.camel@acpi-hp.sh.intel.com>
References: <1190863833.26892.63.camel@acpi-hp.sh.intel.com>
	 <46FB375A.4060403@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-A9A3Qytlv+eOIshMj7eM"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17060 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbXI0E6W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2007 00:58:22 -0400
In-Reply-To: <46FB375A.4060403@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, rebort.moore@intel.com


--=-A9A3Qytlv+eOIshMj7eM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-09-27 at 12:53 +0800, Alexey Starikovskiy wrote:
> Zhang Rui wrote:
> > Attachment is the patch for battery hotplug support.
> There is it?

Oops, the battery hotplug patch is attached.

Thanks,
Rui

--=-A9A3Qytlv+eOIshMj7eM
Content-Disposition: attachment; filename=patch-battery-hotplug-support
Content-Type: message/rfc822; name=patch-battery-hotplug-support

From: Zhang Rui <rui.zhang@intel.com>
Subject: add battery hotplug support
Date: Thu, 27 Sep 2007 13:03:49 +0800
Message-Id: <1190869429.4129.1.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

add battery hotplug support for ACPI battery driver.
http://bugzilla.kernel.org/show_bug.cgi?id=2884

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/bus.c      |   30 ++++++++++-
 drivers/acpi/scan.c     |  121 +++++++++++++++++++++++++++++++++++++++++++-----
 include/acpi/acpi_bus.h |    2 
 3 files changed, 139 insertions(+), 14 deletions(-)

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
@@ -491,6 +521,70 @@ static void acpi_device_unregister(struc
 	device_unregister(&device->dev);
 }
 
+int acpi_bus_hot_insert_device(acpi_handle handle)
+{
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
+				  !sta.present) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Device is not present\n"));
+		return -ENODEV;
+	}
+
+	if (acpi_get_parent(handle, &phandle)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Can't get device's parent\n"));
+		return -ENODEV;
+	}
+
+	if (acpi_bus_get_device(phandle, &pdev)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Device's parrent isn't present\n"));
+		return -ENODEV;
+	}
+
+	acpi_bus_insert_device(handle);
+
+	if (acpi_bus_add(&device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Hot-inserting device failed\n"));
+		return -ENODEV;
+	}
+
+        return 0;
+}
+EXPORT_SYMBOL(acpi_bus_hot_insert_device);
+
+int acpi_bus_hot_remove_device(struct acpi_device *device)
+{
+        int ret;
+        acpi_status status;
+        acpi_handle handle = device->handle;
+        int lockable = device->flags.lockable;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Hot-removing device %s...\n", device->dev.bus_id));
+
+        ret = acpi_bus_trim(device, 1);
+        if (ret) {
+                ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+                                "Removing device failed\n"));
+                return ret;
+        }
+
+        status = acpi_bus_eject_device(handle, lockable);
+
+        return 0;
+}
+EXPORT_SYMBOL(acpi_bus_hot_remove_device);
 /* --------------------------------------------------------------------------
                                  Driver Management
    -------------------------------------------------------------------------- */
@@ -1397,6 +1491,11 @@ int acpi_bus_trim(struct acpi_device *st
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
@@ -338,6 +338,8 @@ int acpi_bus_receive_event(struct acpi_b
 static inline int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
 	{ return 0; }
 #endif
+int acpi_bus_hot_insert_device(acpi_handle);
+int acpi_bus_hot_remove_device(struct acpi_device *);
 int acpi_bus_register_driver(struct acpi_driver *driver);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -444,6 +444,7 @@ static int acpi_bus_check_scope(struct a
 	return 0;
 }
 
+#define ACPI_BATTERY_HID "PNP0C0A"
 /**
  * acpi_bus_notify
  * ---------------
@@ -454,8 +455,8 @@ static void acpi_bus_notify(acpi_handle 
 	int result = 0;
 	struct acpi_device *device = NULL;
 
-
-	if (acpi_bus_get_device(handle, &device))
+	if (acpi_bus_get_device(handle, &device) &&
+		type != ACPI_NOTIFY_DEVICE_CHECK)
 		return;
 
 	switch (type) {
@@ -475,7 +476,26 @@ static void acpi_bus_notify(acpi_handle 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Received DEVICE CHECK notification for device [%s]\n",
 				  device->pnp.bus_id));
-		result = acpi_bus_check_device(device, NULL);
+		if (device)
+			result = acpi_bus_check_device(device, NULL);
+		else {
+			/*
+			 * device hotplug support
+			 * we only support battery hotplug for now
+			 */
+			struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+			struct acpi_device_info *info;
+			acpi_status status;
+
+			status = acpi_get_object_info(handle, &buffer);
+			if (ACPI_FAILURE(status))
+				return;
+
+			info = buffer.pointer;
+			if (info->valid & ACPI_VALID_HID)
+                        	if (!strcmp(info->hardware_id.value, ACPI_BATTERY_HID))
+					result = acpi_bus_hot_insert_device(handle);
+		}
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
@@ -493,6 +513,10 @@ static void acpi_bus_notify(acpi_handle 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Received EJECT REQUEST notification for device [%s]\n",
 				  device->pnp.bus_id));
+		/* hot removing battery device */
+		if (!strcmp(device->pnp.hardware_id, ACPI_BATTERY_HID))
+			result = acpi_bus_hot_remove_device(device);
+
 		/* TBD */
 		break;
 

--=-A9A3Qytlv+eOIshMj7eM--
