From: Zhang Rui <rui.zhang@intel.com>
Subject: [01/12] acpi: clean up scan.c
Date: Fri, 22 Sep 2006 17:18:01 +0800
Message-ID: <1158916681.11985.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25232 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751101AbWIVJQ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:16:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

Adjust the code and make code doing similar things together.
No logic changes.

Signed-off-by : Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/scan.c |  815 +++++++++++++++++++++++++---------------------------
 1 files changed, 401 insertions(+), 414 deletions(-)

Index: linux-2.6.18-rc7/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/scan.c	2006-09-14 15:32:35.000000000 +0800
+++ linux-2.6.18-rc7/drivers/acpi/scan.c	2006-09-14 16:12:39.000000000 +0800
@@ -111,233 +111,6 @@ static struct kset acpi_namespace_kset =
 	.uevent_ops = &namespace_uevent_ops,
 };
 
-static void acpi_device_register(struct acpi_device *device,
-				 struct acpi_device *parent)
-{
-	int err;
-
-	/*
-	 * Linkage
-	 * -------
-	 * Link this device to its parent and siblings.
-	 */
-	INIT_LIST_HEAD(&device->children);
-	INIT_LIST_HEAD(&device->node);
-	INIT_LIST_HEAD(&device->g_list);
-	INIT_LIST_HEAD(&device->wakeup_list);
-
-	spin_lock(&acpi_device_lock);
-	if (device->parent) {
-		list_add_tail(&device->node, &device->parent->children);
-		list_add_tail(&device->g_list, &device->parent->g_list);
-	} else
-		list_add_tail(&device->g_list, &acpi_device_list);
-	if (device->wakeup.flags.valid)
-		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
-	spin_unlock(&acpi_device_lock);
-
-	strlcpy(device->kobj.name, device->pnp.bus_id, KOBJ_NAME_LEN);
-	if (parent)
-		device->kobj.parent = &parent->kobj;
-	device->kobj.ktype = &ktype_acpi_ns;
-	device->kobj.kset = &acpi_namespace_kset;
-	err = kobject_register(&device->kobj);
-	if (err < 0)
-		printk(KERN_WARNING "%s: kobject_register error: %d\n",
-			__FUNCTION__, err);
-	create_sysfs_device_files(device);
-}
-
-static void acpi_device_unregister(struct acpi_device *device, int type)
-{
-	spin_lock(&acpi_device_lock);
-	if (device->parent) {
-		list_del(&device->node);
-		list_del(&device->g_list);
-	} else
-		list_del(&device->g_list);
-
-	list_del(&device->wakeup_list);
-
-	spin_unlock(&acpi_device_lock);
-
-	acpi_detach_data(device->handle, acpi_bus_data_handler);
-	remove_sysfs_device_files(device);
-	kobject_unregister(&device->kobj);
-}
-
-void acpi_bus_data_handler(acpi_handle handle, u32 function, void *context)
-{
-
-	/* TBD */
-
-	return;
-}
-
-static int acpi_bus_get_power_flags(struct acpi_device *device)
-{
-	acpi_status status = 0;
-	acpi_handle handle = NULL;
-	u32 i = 0;
-
-
-	/*
-	 * Power Management Flags
-	 */
-	status = acpi_get_handle(device->handle, "_PSC", &handle);
-	if (ACPI_SUCCESS(status))
-		device->power.flags.explicit_get = 1;
-	status = acpi_get_handle(device->handle, "_IRC", &handle);
-	if (ACPI_SUCCESS(status))
-		device->power.flags.inrush_current = 1;
-
-	/*
-	 * Enumerate supported power management states
-	 */
-	for (i = ACPI_STATE_D0; i <= ACPI_STATE_D3; i++) {
-		struct acpi_device_power_state *ps = &device->power.states[i];
-		char object_name[5] = { '_', 'P', 'R', '0' + i, '\0' };
-
-		/* Evaluate "_PRx" to se if power resources are referenced */
-		acpi_evaluate_reference(device->handle, object_name, NULL,
-					&ps->resources);
-		if (ps->resources.count) {
-			device->power.flags.power_resources = 1;
-			ps->flags.valid = 1;
-		}
-
-		/* Evaluate "_PSx" to see if we can do explicit sets */
-		object_name[2] = 'S';
-		status = acpi_get_handle(device->handle, object_name, &handle);
-		if (ACPI_SUCCESS(status)) {
-			ps->flags.explicit_set = 1;
-			ps->flags.valid = 1;
-		}
-
-		/* State is valid if we have some power control */
-		if (ps->resources.count || ps->flags.explicit_set)
-			ps->flags.valid = 1;
-
-		ps->power = -1;	/* Unknown - driver assigned */
-		ps->latency = -1;	/* Unknown - driver assigned */
-	}
-
-	/* Set defaults for D0 and D3 states (always valid) */
-	device->power.states[ACPI_STATE_D0].flags.valid = 1;
-	device->power.states[ACPI_STATE_D0].power = 100;
-	device->power.states[ACPI_STATE_D3].flags.valid = 1;
-	device->power.states[ACPI_STATE_D3].power = 0;
-
-	/* TBD: System wake support and resource requirements. */
-
-	device->power.state = ACPI_STATE_UNKNOWN;
-
-	return 0;
-}
-
-int acpi_match_ids(struct acpi_device *device, char *ids)
-{
-	if (device->flags.hardware_id)
-		if (strstr(ids, device->pnp.hardware_id))
-			return 0;
-
-	if (device->flags.compatible_ids) {
-		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
-		int i;
-
-		/* compare multiple _CID entries against driver ids */
-		for (i = 0; i < cid_list->count; i++) {
-			if (strstr(ids, cid_list->id[i].value))
-				return 0;
-		}
-	}
-	return -ENOENT;
-}
-
-static acpi_status
-acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
-					     union acpi_object *package)
-{
-	int i = 0;
-	union acpi_object *element = NULL;
-
-	if (!device || !package || (package->package.count < 2))
-		return AE_BAD_PARAMETER;
-
-	element = &(package->package.elements[0]);
-	if (!element)
-		return AE_BAD_PARAMETER;
-	if (element->type == ACPI_TYPE_PACKAGE) {
-		if ((element->package.count < 2) ||
-		    (element->package.elements[0].type !=
-		     ACPI_TYPE_LOCAL_REFERENCE)
-		    || (element->package.elements[1].type != ACPI_TYPE_INTEGER))
-			return AE_BAD_DATA;
-		device->wakeup.gpe_device =
-		    element->package.elements[0].reference.handle;
-		device->wakeup.gpe_number =
-		    (u32) element->package.elements[1].integer.value;
-	} else if (element->type == ACPI_TYPE_INTEGER) {
-		device->wakeup.gpe_number = element->integer.value;
-	} else
-		return AE_BAD_DATA;
-
-	element = &(package->package.elements[1]);
-	if (element->type != ACPI_TYPE_INTEGER) {
-		return AE_BAD_DATA;
-	}
-	device->wakeup.sleep_state = element->integer.value;
-
-	if ((package->package.count - 2) > ACPI_MAX_HANDLES) {
-		return AE_NO_MEMORY;
-	}
-	device->wakeup.resources.count = package->package.count - 2;
-	for (i = 0; i < device->wakeup.resources.count; i++) {
-		element = &(package->package.elements[i + 2]);
-		if (element->type != ACPI_TYPE_ANY) {
-			return AE_BAD_DATA;
-		}
-
-		device->wakeup.resources.handles[i] = element->reference.handle;
-	}
-
-	return AE_OK;
-}
-
-static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
-{
-	acpi_status status = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *package = NULL;
-
-
-	/* _PRW */
-	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRW"));
-		goto end;
-	}
-
-	package = (union acpi_object *)buffer.pointer;
-	status = acpi_bus_extract_wakeup_device_power_package(device, package);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Extracting _PRW package"));
-		goto end;
-	}
-
-	kfree(buffer.pointer);
-
-	device->wakeup.flags.valid = 1;
-	/* Power button, Lid switch always enable wakeup */
-	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
-		device->wakeup.flags.run_wake = 1;
-
-      end:
-	if (ACPI_FAILURE(status))
-		device->flags.wake_capable = 0;
-	return 0;
-}
-
 /* --------------------------------------------------------------------------
 		ACPI sysfs device file support
    -------------------------------------------------------------------------- */
@@ -447,20 +220,86 @@ acpi_eject_store(struct acpi_device *dev
 }
 
 /* --------------------------------------------------------------------------
-                              Performance Management
+			ACPI Bus operations
    -------------------------------------------------------------------------- */
+static inline struct acpi_device * to_acpi_dev(struct device * dev)
+{
+	return container_of(dev, struct acpi_device, dev);
+}
 
-static int acpi_bus_get_perf_flags(struct acpi_device *device)
+static int root_suspend(struct acpi_device * acpi_dev, pm_message_t state)
 {
-	device->performance.state = ACPI_STATE_UNKNOWN;
+	struct acpi_device * dev, * next;
+	int result;
+
+	spin_lock(&acpi_device_lock);
+	list_for_each_entry_safe_reverse(dev, next, &acpi_device_list, g_list) {
+		if (dev->driver && dev->driver->ops.suspend) {
+			spin_unlock(&acpi_device_lock);
+			result = dev->driver->ops.suspend(dev, 0);
+			if (result) {
+				printk(KERN_ERR PREFIX "[%s - %s] Suspend failed: %d\n",
+				       acpi_device_name(dev),
+				       acpi_device_bid(dev), result);
+			}
+			spin_lock(&acpi_device_lock);
+		}
+	}
+	spin_unlock(&acpi_device_lock);
 	return 0;
 }
 
-/* --------------------------------------------------------------------------
-                                 Driver Management
-   -------------------------------------------------------------------------- */
+static int acpi_device_suspend(struct device * dev, pm_message_t state)
+{
+	struct acpi_device * acpi_dev = to_acpi_dev(dev);
 
-static LIST_HEAD(acpi_bus_drivers);
+	/*
+	 * For now, we should only register 1 generic device -
+	 * the ACPI root device - and from there, we walk the
+	 * tree of ACPI devices to suspend each one using the
+	 * ACPI driver methods.
+	 */
+	if (acpi_dev->handle == ACPI_ROOT_OBJECT)
+		root_suspend(acpi_dev, state);
+	return 0;
+}
+
+static int root_resume(struct acpi_device * acpi_dev)
+{
+	struct acpi_device * dev, * next;
+	int result;
+
+	spin_lock(&acpi_device_lock);
+	list_for_each_entry_safe(dev, next, &acpi_device_list, g_list) {
+		if (dev->driver && dev->driver->ops.resume) {
+			spin_unlock(&acpi_device_lock);
+			result = dev->driver->ops.resume(dev, 0);
+			if (result) {
+				printk(KERN_ERR PREFIX "[%s - %s] resume failed: %d\n",
+				       acpi_device_name(dev),
+				       acpi_device_bid(dev), result);
+			}
+			spin_lock(&acpi_device_lock);
+		}
+	}
+	spin_unlock(&acpi_device_lock);
+	return 0;
+}
+
+static int acpi_device_resume(struct device * dev)
+{
+	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+
+	/*
+	 * For now, we should only register 1 generic device -
+	 * the ACPI root device - and from there, we walk the
+	 * tree of ACPI devices to resume each one using the
+	 * ACPI driver methods.
+	 */
+	if (acpi_dev->handle == ACPI_ROOT_OBJECT)
+		root_resume(acpi_dev);
+	return 0;
+}
 
 /**
  * acpi_bus_match - match device IDs to driver's supported IDs
@@ -478,6 +317,72 @@ acpi_bus_match(struct acpi_device *devic
 	return acpi_match_ids(device, driver->ids);
 }
 
+static struct bus_type acpi_bus_type = {
+	.name		= "acpi",
+	.suspend	= acpi_device_suspend,
+	.resume		= acpi_device_resume,
+};
+
+static void acpi_device_register(struct acpi_device *device,
+				 struct acpi_device *parent)
+{
+	int err;
+
+	/*
+	 * Linkage
+	 * -------
+	 * Link this device to its parent and siblings.
+	 */
+	INIT_LIST_HEAD(&device->children);
+	INIT_LIST_HEAD(&device->node);
+	INIT_LIST_HEAD(&device->g_list);
+	INIT_LIST_HEAD(&device->wakeup_list);
+
+	spin_lock(&acpi_device_lock);
+	if (device->parent) {
+		list_add_tail(&device->node, &device->parent->children);
+		list_add_tail(&device->g_list, &device->parent->g_list);
+	} else
+		list_add_tail(&device->g_list, &acpi_device_list);
+	if (device->wakeup.flags.valid)
+		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
+	spin_unlock(&acpi_device_lock);
+
+	strlcpy(device->kobj.name, device->pnp.bus_id, KOBJ_NAME_LEN);
+	if (parent)
+		device->kobj.parent = &parent->kobj;
+	device->kobj.ktype = &ktype_acpi_ns;
+	device->kobj.kset = &acpi_namespace_kset;
+	err = kobject_register(&device->kobj);
+	if (err < 0)
+		printk(KERN_WARNING "%s: kobject_register error: %d\n",
+			__FUNCTION__, err);
+	create_sysfs_device_files(device);
+}
+
+static void acpi_device_unregister(struct acpi_device *device, int type)
+{
+	spin_lock(&acpi_device_lock);
+	if (device->parent) {
+		list_del(&device->node);
+		list_del(&device->g_list);
+	} else
+		list_del(&device->g_list);
+
+	list_del(&device->wakeup_list);
+
+	spin_unlock(&acpi_device_lock);
+
+	acpi_detach_data(device->handle, acpi_bus_data_handler);
+	remove_sysfs_device_files(device);
+	kobject_unregister(&device->kobj);
+}
+
+/* --------------------------------------------------------------------------
+                                 Driver Management
+   -------------------------------------------------------------------------- */
+static LIST_HEAD(acpi_bus_drivers);
+
 /**
  * acpi_bus_driver_init - add a device to a driver
  * @device: the device to add and initialize
@@ -583,114 +488,290 @@ static void acpi_driver_detach(struct ac
 			atomic_dec(&drv->references);
 		}
 	}
-	spin_unlock(&acpi_device_lock);
+	spin_unlock(&acpi_device_lock);
+}
+
+/**
+ * acpi_bus_register_driver - register a driver with the ACPI bus
+ * @driver: driver being registered
+ *
+ * Registers a driver with the ACPI bus.  Searches the namespace for all
+ * devices that match the driver's criteria and binds.  Returns zero for
+ * success or a negative error status for failure.
+ */
+int acpi_bus_register_driver(struct acpi_driver *driver)
+{
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	spin_lock(&acpi_device_lock);
+	list_add_tail(&driver->node, &acpi_bus_drivers);
+	spin_unlock(&acpi_device_lock);
+	acpi_driver_attach(driver);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(acpi_bus_register_driver);
+
+/**
+ * acpi_bus_unregister_driver - unregisters a driver with the APIC bus
+ * @driver: driver to unregister
+ *
+ * Unregisters a driver with the ACPI bus.  Searches the namespace for all
+ * devices that match the driver's criteria and unbinds.
+ */
+void acpi_bus_unregister_driver(struct acpi_driver *driver)
+{
+	acpi_driver_detach(driver);
+
+	if (!atomic_read(&driver->references)) {
+		spin_lock(&acpi_device_lock);
+		list_del_init(&driver->node);
+		spin_unlock(&acpi_device_lock);
+	}
+	return;
+}
+
+EXPORT_SYMBOL(acpi_bus_unregister_driver);
+
+/**
+ * acpi_bus_find_driver - check if there is a driver installed for the device
+ * @device: device that we are trying to find a supporting driver for
+ *
+ * Parses the list of registered drivers looking for a driver applicable for
+ * the specified device.
+ */
+static int acpi_bus_find_driver(struct acpi_device *device)
+{
+	int result = 0;
+	struct list_head *node, *next;
+
+
+	spin_lock(&acpi_device_lock);
+	list_for_each_safe(node, next, &acpi_bus_drivers) {
+		struct acpi_driver *driver =
+		    container_of(node, struct acpi_driver, node);
+
+		atomic_inc(&driver->references);
+		spin_unlock(&acpi_device_lock);
+		if (!acpi_bus_match(device, driver)) {
+			result = acpi_bus_driver_init(device, driver);
+			if (!result)
+				goto Done;
+		}
+		atomic_dec(&driver->references);
+		spin_lock(&acpi_device_lock);
+	}
+	spin_unlock(&acpi_device_lock);
+
+      Done:
+	return result;
+}
+
+/* --------------------------------------------------------------------------
+                                 Device Enumeration
+   -------------------------------------------------------------------------- */
+acpi_status
+acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
+{
+	acpi_status status;
+	acpi_handle tmp;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+
+	status = acpi_get_handle(handle, "_EJD", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	status = acpi_evaluate_object(handle, "_EJD", NULL, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		obj = buffer.pointer;
+		status = acpi_get_handle(NULL, obj->string.pointer, ejd);
+		kfree(buffer.pointer);
+	}
+	return status;
+}
+EXPORT_SYMBOL_GPL(acpi_bus_get_ejd);
+
+void acpi_bus_data_handler(acpi_handle handle, u32 function, void *context)
+{
+
+	/* TBD */
+
+	return;
+}
+
+int acpi_match_ids(struct acpi_device *device, char *ids)
+{
+	if (device->flags.hardware_id)
+		if (strstr(ids, device->pnp.hardware_id))
+			return 0;
+
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+
+		/* compare multiple _CID entries against driver ids */
+		for (i = 0; i < cid_list->count; i++) {
+			if (strstr(ids, cid_list->id[i].value))
+				return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+static int acpi_bus_get_perf_flags(struct acpi_device *device)
+{
+	device->performance.state = ACPI_STATE_UNKNOWN;
+	return 0;
+}
+
+static acpi_status
+acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
+					     union acpi_object *package)
+{
+	int i = 0;
+	union acpi_object *element = NULL;
+
+	if (!device || !package || (package->package.count < 2))
+		return AE_BAD_PARAMETER;
+
+	element = &(package->package.elements[0]);
+	if (!element)
+		return AE_BAD_PARAMETER;
+	if (element->type == ACPI_TYPE_PACKAGE) {
+		if ((element->package.count < 2) ||
+		    (element->package.elements[0].type !=
+		     ACPI_TYPE_LOCAL_REFERENCE)
+		    || (element->package.elements[1].type != ACPI_TYPE_INTEGER))
+			return AE_BAD_DATA;
+		device->wakeup.gpe_device =
+		    element->package.elements[0].reference.handle;
+		device->wakeup.gpe_number =
+		    (u32) element->package.elements[1].integer.value;
+	} else if (element->type == ACPI_TYPE_INTEGER) {
+		device->wakeup.gpe_number = element->integer.value;
+	} else
+		return AE_BAD_DATA;
+
+	element = &(package->package.elements[1]);
+	if (element->type != ACPI_TYPE_INTEGER) {
+		return AE_BAD_DATA;
+	}
+	device->wakeup.sleep_state = element->integer.value;
+
+	if ((package->package.count - 2) > ACPI_MAX_HANDLES) {
+		return AE_NO_MEMORY;
+	}
+	device->wakeup.resources.count = package->package.count - 2;
+	for (i = 0; i < device->wakeup.resources.count; i++) {
+		element = &(package->package.elements[i + 2]);
+		if (element->type != ACPI_TYPE_ANY) {
+			return AE_BAD_DATA;
+		}
+
+		device->wakeup.resources.handles[i] = element->reference.handle;
+	}
+
+	return AE_OK;
 }
 
-/**
- * acpi_bus_register_driver - register a driver with the ACPI bus
- * @driver: driver being registered
- *
- * Registers a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and binds.  Returns zero for
- * success or a negative error status for failure.
- */
-int acpi_bus_register_driver(struct acpi_driver *driver)
+static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 {
+	acpi_status status = 0;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *package = NULL;
 
-	if (acpi_disabled)
-		return -ENODEV;
 
-	spin_lock(&acpi_device_lock);
-	list_add_tail(&driver->node, &acpi_bus_drivers);
-	spin_unlock(&acpi_device_lock);
-	acpi_driver_attach(driver);
+	/* _PRW */
+	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRW"));
+		goto end;
+	}
 
-	return 0;
-}
+	package = (union acpi_object *)buffer.pointer;
+	status = acpi_bus_extract_wakeup_device_power_package(device, package);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Extracting _PRW package"));
+		goto end;
+	}
 
-EXPORT_SYMBOL(acpi_bus_register_driver);
+	kfree(buffer.pointer);
 
-/**
- * acpi_bus_unregister_driver - unregisters a driver with the APIC bus
- * @driver: driver to unregister
- *
- * Unregisters a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and unbinds.
- */
-void acpi_bus_unregister_driver(struct acpi_driver *driver)
-{
-	acpi_driver_detach(driver);
+	device->wakeup.flags.valid = 1;
+	/* Power button, Lid switch always enable wakeup */
+	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
+		device->wakeup.flags.run_wake = 1;
 
-	if (!atomic_read(&driver->references)) {
-		spin_lock(&acpi_device_lock);
-		list_del_init(&driver->node);
-		spin_unlock(&acpi_device_lock);
-	}
-	return;
+      end:
+	if (ACPI_FAILURE(status))
+		device->flags.wake_capable = 0;
+	return 0;
 }
 
-EXPORT_SYMBOL(acpi_bus_unregister_driver);
-
-/**
- * acpi_bus_find_driver - check if there is a driver installed for the device
- * @device: device that we are trying to find a supporting driver for
- *
- * Parses the list of registered drivers looking for a driver applicable for
- * the specified device.
- */
-static int acpi_bus_find_driver(struct acpi_device *device)
+static int acpi_bus_get_power_flags(struct acpi_device *device)
 {
-	int result = 0;
-	struct list_head *node, *next;
+	acpi_status status = 0;
+	acpi_handle handle = NULL;
+	u32 i = 0;
 
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_bus_drivers) {
-		struct acpi_driver *driver =
-		    container_of(node, struct acpi_driver, node);
+	/*
+	 * Power Management Flags
+	 */
+	status = acpi_get_handle(device->handle, "_PSC", &handle);
+	if (ACPI_SUCCESS(status))
+		device->power.flags.explicit_get = 1;
+	status = acpi_get_handle(device->handle, "_IRC", &handle);
+	if (ACPI_SUCCESS(status))
+		device->power.flags.inrush_current = 1;
 
-		atomic_inc(&driver->references);
-		spin_unlock(&acpi_device_lock);
-		if (!acpi_bus_match(device, driver)) {
-			result = acpi_bus_driver_init(device, driver);
-			if (!result)
-				goto Done;
+	/*
+	 * Enumerate supported power management states
+	 */
+	for (i = ACPI_STATE_D0; i <= ACPI_STATE_D3; i++) {
+		struct acpi_device_power_state *ps = &device->power.states[i];
+		char object_name[5] = { '_', 'P', 'R', '0' + i, '\0' };
+
+		/* Evaluate "_PRx" to se if power resources are referenced */
+		acpi_evaluate_reference(device->handle, object_name, NULL,
+					&ps->resources);
+		if (ps->resources.count) {
+			device->power.flags.power_resources = 1;
+			ps->flags.valid = 1;
 		}
-		atomic_dec(&driver->references);
-		spin_lock(&acpi_device_lock);
-	}
-	spin_unlock(&acpi_device_lock);
 
-      Done:
-	return result;
-}
+		/* Evaluate "_PSx" to see if we can do explicit sets */
+		object_name[2] = 'S';
+		status = acpi_get_handle(device->handle, object_name, &handle);
+		if (ACPI_SUCCESS(status)) {
+			ps->flags.explicit_set = 1;
+			ps->flags.valid = 1;
+		}
 
-/* --------------------------------------------------------------------------
-                                 Device Enumeration
-   -------------------------------------------------------------------------- */
+		/* State is valid if we have some power control */
+		if (ps->resources.count || ps->flags.explicit_set)
+			ps->flags.valid = 1;
 
-acpi_status
-acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
-{
-	acpi_status status;
-	acpi_handle tmp;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *obj;
+		ps->power = -1;	/* Unknown - driver assigned */
+		ps->latency = -1;	/* Unknown - driver assigned */
+	}
 
-	status = acpi_get_handle(handle, "_EJD", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
+	/* Set defaults for D0 and D3 states (always valid) */
+	device->power.states[ACPI_STATE_D0].flags.valid = 1;
+	device->power.states[ACPI_STATE_D0].power = 100;
+	device->power.states[ACPI_STATE_D3].flags.valid = 1;
+	device->power.states[ACPI_STATE_D3].power = 0;
 
-	status = acpi_evaluate_object(handle, "_EJD", NULL, &buffer);
-	if (ACPI_SUCCESS(status)) {
-		obj = buffer.pointer;
-		status = acpi_get_handle(NULL, obj->string.pointer, ejd);
-		kfree(buffer.pointer);
-	}
-	return status;
-}
-EXPORT_SYMBOL_GPL(acpi_bus_get_ejd);
+	/* TBD: System wake support and resource requirements. */
+
+	device->power.state = ACPI_STATE_UNKNOWN;
 
+	return 0;
+}
 
 static int acpi_bus_get_flags(struct acpi_device *device)
 {
@@ -1353,100 +1434,6 @@ static int acpi_bus_scan_fixed(struct ac
 	return result;
 }
 
-
-static inline struct acpi_device * to_acpi_dev(struct device * dev)
-{
-	return container_of(dev, struct acpi_device, dev);
-}
-
-
-static int root_suspend(struct acpi_device * acpi_dev, pm_message_t state)
-{
-	struct acpi_device * dev, * next;
-	int result;
-
-	spin_lock(&acpi_device_lock);
-	list_for_each_entry_safe_reverse(dev, next, &acpi_device_list, g_list) {
-		if (dev->driver && dev->driver->ops.suspend) {
-			spin_unlock(&acpi_device_lock);
-			result = dev->driver->ops.suspend(dev, 0);
-			if (result) {
-				printk(KERN_ERR PREFIX "[%s - %s] Suspend failed: %d\n",
-				       acpi_device_name(dev),
-				       acpi_device_bid(dev), result);
-			}
-			spin_lock(&acpi_device_lock);
-		}
-	}
-	spin_unlock(&acpi_device_lock);
-	return 0;
-}
-
-
-static int acpi_device_suspend(struct device * dev, pm_message_t state)
-{
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
-
-	/*
-	 * For now, we should only register 1 generic device -
-	 * the ACPI root device - and from there, we walk the
-	 * tree of ACPI devices to suspend each one using the
-	 * ACPI driver methods.
-	 */
-	if (acpi_dev->handle == ACPI_ROOT_OBJECT)
-		root_suspend(acpi_dev, state);
-	return 0;
-}
-
-
-
-static int root_resume(struct acpi_device * acpi_dev)
-{
-	struct acpi_device * dev, * next;
-	int result;
-
-	spin_lock(&acpi_device_lock);
-	list_for_each_entry_safe(dev, next, &acpi_device_list, g_list) {
-		if (dev->driver && dev->driver->ops.resume) {
-			spin_unlock(&acpi_device_lock);
-			result = dev->driver->ops.resume(dev, 0);
-			if (result) {
-				printk(KERN_ERR PREFIX "[%s - %s] resume failed: %d\n",
-				       acpi_device_name(dev),
-				       acpi_device_bid(dev), result);
-			}
-			spin_lock(&acpi_device_lock);
-		}
-	}
-	spin_unlock(&acpi_device_lock);
-	return 0;
-}
-
-
-static int acpi_device_resume(struct device * dev)
-{
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
-
-	/*
-	 * For now, we should only register 1 generic device -
-	 * the ACPI root device - and from there, we walk the
-	 * tree of ACPI devices to resume each one using the
-	 * ACPI driver methods.
-	 */
-	if (acpi_dev->handle == ACPI_ROOT_OBJECT)
-		root_resume(acpi_dev);
-	return 0;
-}
-
-
-static struct bus_type acpi_bus_type = {
-	.name		= "acpi",
-	.suspend	= acpi_device_suspend,
-	.resume		= acpi_device_resume,
-};
-
-
-
 static int __init acpi_scan_init(void)
 {
 	int result;
