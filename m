From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] ACPI / scan: Mode bus operations and notification routines to bus.c
Date: Tue, 14 Jul 2015 01:18:52 +0200
Message-ID: <2198044.pUuRcSfuqb@vostro.rjw.lan>
References: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53685 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751140AbbGMWxZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2015 18:53:25 -0400
In-Reply-To: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To reduce the size of scan.c and improve the readability of it, move
code related to device notification, the definitions of the ACPI bus
operations and the driver management code into drivers/acpi/bus.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c  |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c |  183 ---------------------------------------------------
 2 files changed, 184 insertions(+), 183 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -419,6 +419,65 @@ static void acpi_bus_notify(acpi_handle
 	acpi_evaluate_ost(handle, type, ost_code, NULL);
 }
 
+static void acpi_device_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+
+	device->driver->ops.notify(device, event);
+}
+
+static void acpi_device_notify_fixed(void *data)
+{
+	struct acpi_device *device = data;
+
+	/* Fixed hardware devices have no handles */
+	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
+}
+
+static u32 acpi_device_fixed_event(void *data)
+{
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_device_notify_fixed, data);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int acpi_device_install_notify_handler(struct acpi_device *device)
+{
+	acpi_status status;
+
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						     acpi_device_fixed_event,
+						     device);
+	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						     acpi_device_fixed_event,
+						     device);
+	else
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_device_notify,
+						     device);
+
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+	return 0;
+}
+
+static void acpi_device_remove_notify_handler(struct acpi_device *device)
+{
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_device_fixed_event);
+	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_device_fixed_event);
+	else
+		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					   acpi_device_notify);
+}
+
 /* --------------------------------------------------------------------------
                              Device Matching
    -------------------------------------------------------------------------- */
@@ -614,6 +673,131 @@ bool acpi_driver_match_device(struct dev
 EXPORT_SYMBOL_GPL(acpi_driver_match_device);
 
 /* --------------------------------------------------------------------------
+                              ACPI Driver Management
+   -------------------------------------------------------------------------- */
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
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+	driver->drv.name = driver->name;
+	driver->drv.bus = &acpi_bus_type;
+	driver->drv.owner = driver->owner;
+
+	ret = driver_register(&driver->drv);
+	return ret;
+}
+
+EXPORT_SYMBOL(acpi_bus_register_driver);
+
+/**
+ * acpi_bus_unregister_driver - unregisters a driver with the ACPI bus
+ * @driver: driver to unregister
+ *
+ * Unregisters a driver with the ACPI bus.  Searches the namespace for all
+ * devices that match the driver's criteria and unbinds.
+ */
+void acpi_bus_unregister_driver(struct acpi_driver *driver)
+{
+	driver_unregister(&driver->drv);
+}
+
+EXPORT_SYMBOL(acpi_bus_unregister_driver);
+
+/* --------------------------------------------------------------------------
+                              ACPI Bus operations
+   -------------------------------------------------------------------------- */
+
+static int acpi_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
+
+	return acpi_dev->flags.match_driver
+		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
+}
+
+static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
+}
+
+static int acpi_device_probe(struct device *dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
+	int ret;
+
+	if (acpi_dev->handler && !acpi_is_pnp_device(acpi_dev))
+		return -EINVAL;
+
+	if (!acpi_drv->ops.add)
+		return -ENOSYS;
+
+	ret = acpi_drv->ops.add(acpi_dev);
+	if (ret)
+		return ret;
+
+	acpi_dev->driver = acpi_drv;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "Driver [%s] successfully bound to device [%s]\n",
+			  acpi_drv->name, acpi_dev->pnp.bus_id));
+
+	if (acpi_drv->ops.notify) {
+		ret = acpi_device_install_notify_handler(acpi_dev);
+		if (ret) {
+			if (acpi_drv->ops.remove)
+				acpi_drv->ops.remove(acpi_dev);
+
+			acpi_dev->driver = NULL;
+			acpi_dev->driver_data = NULL;
+			return ret;
+		}
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
+			  acpi_drv->name, acpi_dev->pnp.bus_id));
+	get_device(dev);
+	return 0;
+}
+
+static int acpi_device_remove(struct device * dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = acpi_dev->driver;
+
+	if (acpi_drv) {
+		if (acpi_drv->ops.notify)
+			acpi_device_remove_notify_handler(acpi_dev);
+		if (acpi_drv->ops.remove)
+			acpi_drv->ops.remove(acpi_dev);
+	}
+	acpi_dev->driver = NULL;
+	acpi_dev->driver_data = NULL;
+
+	put_device(dev);
+	return 0;
+}
+
+struct bus_type acpi_bus_type = {
+	.name		= "acpi",
+	.match		= acpi_bus_match,
+	.probe		= acpi_device_probe,
+	.remove		= acpi_device_remove,
+	.uevent		= acpi_device_uevent,
+};
+
+/* --------------------------------------------------------------------------
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
 
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -444,10 +444,6 @@ void acpi_device_hotplug(struct acpi_dev
 	unlock_device_hotplug();
 }
 
-/* --------------------------------------------------------------------------
-			ACPI Bus operations
-   -------------------------------------------------------------------------- */
-
 static void acpi_free_power_resources_lists(struct acpi_device *device)
 {
 	int i;
@@ -474,144 +470,6 @@ static void acpi_device_release(struct d
 	kfree(acpi_dev);
 }
 
-static int acpi_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
-
-	return acpi_dev->flags.match_driver
-		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
-}
-
-static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
-}
-
-static void acpi_device_notify(acpi_handle handle, u32 event, void *data)
-{
-	struct acpi_device *device = data;
-
-	device->driver->ops.notify(device, event);
-}
-
-static void acpi_device_notify_fixed(void *data)
-{
-	struct acpi_device *device = data;
-
-	/* Fixed hardware devices have no handles */
-	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
-}
-
-static u32 acpi_device_fixed_event(void *data)
-{
-	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_device_notify_fixed, data);
-	return ACPI_INTERRUPT_HANDLED;
-}
-
-static int acpi_device_install_notify_handler(struct acpi_device *device)
-{
-	acpi_status status;
-
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	else
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_device_notify,
-						     device);
-
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-	return 0;
-}
-
-static void acpi_device_remove_notify_handler(struct acpi_device *device)
-{
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_device_fixed_event);
-	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_device_fixed_event);
-	else
-		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-					   acpi_device_notify);
-}
-
-static int acpi_device_probe(struct device *dev)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
-	int ret;
-
-	if (acpi_dev->handler && !acpi_is_pnp_device(acpi_dev))
-		return -EINVAL;
-
-	if (!acpi_drv->ops.add)
-		return -ENOSYS;
-
-	ret = acpi_drv->ops.add(acpi_dev);
-	if (ret)
-		return ret;
-
-	acpi_dev->driver = acpi_drv;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Driver [%s] successfully bound to device [%s]\n",
-			  acpi_drv->name, acpi_dev->pnp.bus_id));
-
-	if (acpi_drv->ops.notify) {
-		ret = acpi_device_install_notify_handler(acpi_dev);
-		if (ret) {
-			if (acpi_drv->ops.remove)
-				acpi_drv->ops.remove(acpi_dev);
-
-			acpi_dev->driver = NULL;
-			acpi_dev->driver_data = NULL;
-			return ret;
-		}
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
-			  acpi_drv->name, acpi_dev->pnp.bus_id));
-	get_device(dev);
-	return 0;
-}
-
-static int acpi_device_remove(struct device * dev)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = acpi_dev->driver;
-
-	if (acpi_drv) {
-		if (acpi_drv->ops.notify)
-			acpi_device_remove_notify_handler(acpi_dev);
-		if (acpi_drv->ops.remove)
-			acpi_drv->ops.remove(acpi_dev);
-	}
-	acpi_dev->driver = NULL;
-	acpi_dev->driver_data = NULL;
-
-	put_device(dev);
-	return 0;
-}
-
-struct bus_type acpi_bus_type = {
-	.name		= "acpi",
-	.match		= acpi_bus_match,
-	.probe		= acpi_device_probe,
-	.remove		= acpi_device_remove,
-	.uevent		= acpi_device_uevent,
-};
-
 static void acpi_device_del(struct acpi_device *device)
 {
 	mutex_lock(&acpi_device_lock);
@@ -859,47 +717,6 @@ struct acpi_device *acpi_get_next_child(
 }
 
 /* --------------------------------------------------------------------------
-                                 Driver Management
-   -------------------------------------------------------------------------- */
-/**
- * acpi_bus_register_driver - register a driver with the ACPI bus
- * @driver: driver being registered
- *
- * Registers a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and binds.  Returns zero for
- * success or a negative error status for failure.
- */
-int acpi_bus_register_driver(struct acpi_driver *driver)
-{
-	int ret;
-
-	if (acpi_disabled)
-		return -ENODEV;
-	driver->drv.name = driver->name;
-	driver->drv.bus = &acpi_bus_type;
-	driver->drv.owner = driver->owner;
-
-	ret = driver_register(&driver->drv);
-	return ret;
-}
-
-EXPORT_SYMBOL(acpi_bus_register_driver);
-
-/**
- * acpi_bus_unregister_driver - unregisters a driver with the ACPI bus
- * @driver: driver to unregister
- *
- * Unregisters a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and unbinds.
- */
-void acpi_bus_unregister_driver(struct acpi_driver *driver)
-{
-	driver_unregister(&driver->drv);
-}
-
-EXPORT_SYMBOL(acpi_bus_unregister_driver);
-
-/* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
 static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)

