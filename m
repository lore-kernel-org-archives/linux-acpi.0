From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/13] ACPI: change registration interface to follow driver model
Date: Fri, 24 Nov 2006 00:17:33 -0500
Message-ID: <11643454662740-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com> <11643454641312-git-send-email-len.brown@intel.com> <11643454642611-git-send-email-len.brown@intel.com> <11643454652241-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49851 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934280AbWKXFNz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:13:55 -0500
In-Reply-To: <11643454652241-git-send-email-len.brown@intel.com>
Message-Id: <eb3ec2290520985fd3a9392342ab586fba1e33c3.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>, Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Patrick Mochel <mochel@linux.intel.com>

ACPI device/driver registration Interfaces are modified
to follow Linux driver model.

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |  175 ++++++++---------------------------------------
 include/acpi/acpi_bus.h |    3 +-
 2 files changed, 30 insertions(+), 148 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4647462..b616e17 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -25,7 +25,7 @@ DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
 
-static void acpi_device_release(struct kobject *kobj)
+static void acpi_device_release_legacy(struct kobject *kobj)
 {
 	struct acpi_device *dev = container_of(kobj, struct acpi_device, kobj);
 	kfree(dev->pnp.cid_list);
@@ -75,7 +75,7 @@ static struct sysfs_ops acpi_device_sysf
 
 static struct kobj_type ktype_acpi_ns = {
 	.sysfs_ops = &acpi_device_sysfs_ops,
-	.release = acpi_device_release,
+	.release = acpi_device_release_legacy,
 };
 
 static int namespace_uevent(struct kset *kset, struct kobject *kobj,
@@ -222,6 +222,14 @@ acpi_eject_store(struct acpi_device *dev
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
+static void acpi_device_release(struct device *dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	kfree(acpi_dev->pnp.cid_list);
+	kfree(acpi_dev);
+}
+
 static int acpi_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
@@ -377,6 +385,14 @@ static void acpi_device_register(struct
 		printk(KERN_WARNING "%s: kobject_register error: %d\n",
 			__FUNCTION__, err);
 	create_sysfs_device_files(device);
+
+	if (device->parent)
+		device->dev.parent = &parent->dev;
+	device->dev.bus = &acpi_bus_type;
+	device_initialize(&device->dev);
+	sprintf(device->dev.bus_id, "%s", device->pnp.bus_id);
+	device->dev.release = &acpi_device_release;
+	device_add(&device->dev);
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -395,20 +411,20 @@ static void acpi_device_unregister(struc
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
 	remove_sysfs_device_files(device);
 	kobject_unregister(&device->kobj);
+
+	device_unregister(&device->dev);
 }
 
 /* --------------------------------------------------------------------------
                                  Driver Management
    -------------------------------------------------------------------------- */
-static LIST_HEAD(acpi_bus_drivers);
-
 /**
  * acpi_bus_driver_init - add a device to a driver
  * @device: the device to add and initialize
  * @driver: driver for the device
  *
  * Used to initialize a device via its device driver.  Called whenever a 
- * driver is bound to a device.  Invokes the driver's add() and start() ops.
+ * driver is bound to a device.  Invokes the driver's add() ops.
  */
 static int
 acpi_bus_driver_init(struct acpi_device *device, struct acpi_driver *driver)
@@ -459,57 +475,6 @@ static int acpi_start_single_object(stru
 	return result;
 }
 
-static void acpi_driver_attach(struct acpi_driver *drv)
-{
-	struct list_head *node, *next;
-
-
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_device_list) {
-		struct acpi_device *dev =
-		    container_of(node, struct acpi_device, g_list);
-
-		if (dev->driver || !dev->status.present)
-			continue;
-		spin_unlock(&acpi_device_lock);
-
-		if (!acpi_bus_match(&(dev->dev), &(drv->drv))) {
-			if (!acpi_bus_driver_init(dev, drv)) {
-				acpi_start_single_object(dev);
-				atomic_inc(&drv->references);
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Found driver [%s] for device [%s]\n",
-						  drv->name, dev->pnp.bus_id));
-			}
-		}
-		spin_lock(&acpi_device_lock);
-	}
-	spin_unlock(&acpi_device_lock);
-}
-
-static void acpi_driver_detach(struct acpi_driver *drv)
-{
-	struct list_head *node, *next;
-
-
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_device_list) {
-		struct acpi_device *dev =
-		    container_of(node, struct acpi_device, g_list);
-
-		if (dev->driver == drv) {
-			spin_unlock(&acpi_device_lock);
-			if (drv->ops.remove)
-				drv->ops.remove(dev, ACPI_BUS_REMOVAL_NORMAL);
-			spin_lock(&acpi_device_lock);
-			dev->driver = NULL;
-			dev->driver_data = NULL;
-			atomic_dec(&drv->references);
-		}
-	}
-	spin_unlock(&acpi_device_lock);
-}
-
 /**
  * acpi_bus_register_driver - register a driver with the ACPI bus
  * @driver: driver being registered
@@ -520,16 +485,16 @@ static void acpi_driver_detach(struct ac
  */
 int acpi_bus_register_driver(struct acpi_driver *driver)
 {
+	int ret;
 
 	if (acpi_disabled)
 		return -ENODEV;
+	driver->drv.name = driver->name;
+	driver->drv.bus = &acpi_bus_type;
+	driver->drv.owner = driver->owner;
 
-	spin_lock(&acpi_device_lock);
-	list_add_tail(&driver->node, &acpi_bus_drivers);
-	spin_unlock(&acpi_device_lock);
-	acpi_driver_attach(driver);
-
-	return 0;
+	ret = driver_register(&driver->drv);
+	return ret;
 }
 
 EXPORT_SYMBOL(acpi_bus_register_driver);
@@ -543,52 +508,11 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
  */
 void acpi_bus_unregister_driver(struct acpi_driver *driver)
 {
-	acpi_driver_detach(driver);
-
-	if (!atomic_read(&driver->references)) {
-		spin_lock(&acpi_device_lock);
-		list_del_init(&driver->node);
-		spin_unlock(&acpi_device_lock);
-	}
-	return;
+	driver_unregister(&driver->drv);
 }
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
-/**
- * acpi_bus_find_driver - check if there is a driver installed for the device
- * @device: device that we are trying to find a supporting driver for
- *
- * Parses the list of registered drivers looking for a driver applicable for
- * the specified device.
- */
-static int acpi_bus_find_driver(struct acpi_device *device)
-{
-	int result = 0;
-	struct list_head *node, *next;
-
-
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_bus_drivers) {
-		struct acpi_driver *driver =
-		    container_of(node, struct acpi_driver, node);
-
-		atomic_inc(&driver->references);
-		spin_unlock(&acpi_device_lock);
-		if (!acpi_bus_match(&(device->dev), &(driver->drv))) {
-			result = acpi_bus_driver_init(device, driver);
-			if (!result)
-				goto Done;
-		}
-		atomic_dec(&driver->references);
-		spin_lock(&acpi_device_lock);
-	}
-	spin_unlock(&acpi_device_lock);
-
-      Done:
-	return result;
-}
-
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
@@ -1033,32 +957,10 @@ static void acpi_device_get_debug_info(s
 
 static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 {
-	int result = 0;
-	struct acpi_driver *driver;
-
-
 	if (!dev)
 		return -EINVAL;
 
-	driver = dev->driver;
-
-	if ((driver) && (driver->ops.remove)) {
-
-		if (driver->ops.stop) {
-			result = driver->ops.stop(dev, ACPI_BUS_REMOVAL_EJECT);
-			if (result)
-				return result;
-		}
-
-		result = dev->driver->ops.remove(dev, ACPI_BUS_REMOVAL_EJECT);
-		if (result) {
-			return result;
-		}
-
-		atomic_dec(&dev->driver->references);
-		dev->driver = NULL;
-		acpi_driver_data(dev) = NULL;
-	}
+	device_release_driver(&dev->dev);
 
 	if (!rmdevice)
 		return 0;
@@ -1193,17 +1095,6 @@ acpi_add_single_object(struct acpi_devic
 			device->parent->ops.bind(device);
 	}
 
-	/*
-	 * Locate & Attach Driver
-	 * ----------------------
-	 * If there's a hardware id (_HID) or compatible ids (_CID) we check
-	 * to see if there's a driver installed for this kind of device.  Note
-	 * that drivers can install before or after a device is enumerated.
-	 *
-	 * TBD: Assumes LDM provides driver hot-plug capability.
-	 */
-	acpi_bus_find_driver(device);
-
       end:
 	if (!result)
 		*child = device;
@@ -1484,14 +1375,6 @@ static int __init acpi_scan_init(void)
 	if (result)
 		goto Done;
 
-	acpi_root->dev.bus = &acpi_bus_type;
-	snprintf(acpi_root->dev.bus_id, BUS_ID_SIZE, "%s", acpi_bus_type.name);
-	result = device_register(&acpi_root->dev);
-	if (result) {
-		/* We don't want to quit even if we failed to add suspend/resume */
-		printk(KERN_ERR PREFIX "Could not register device\n");
-	}
-
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8fb7158..137fdee 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -133,13 +133,12 @@ struct acpi_device_ops {
 };
 
 struct acpi_driver {
-	struct list_head node;
 	char name[80];
 	char class[80];
-	atomic_t references;
 	char *ids;		/* Supported Hardware IDs */
 	struct acpi_device_ops ops;
 	struct device_driver drv;
+	struct module *owner;
 };
 
 /*
-- 
1.4.4.g59427
