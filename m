From: Zhang Rui <rui.zhang@intel.com>
Subject: [04/14] acpi: add ACPI bus_type for driver model
Date: Fri, 22 Sep 2006 17:24:04 +0800
Message-ID: <1158917044.11985.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32137 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751103AbWIVJWa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:22:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Patrick Mochel <mochel@linux.intel.com>
From: Li Shaohua <shaohua.li@intel.com>

Add ACPI bus_type for Linux driver model. 

1.	.shutdown method is added into acpi_driver.ops 
	needed by bus_type operations.
2.	remove useless parameter 'int state' in .resume method.
3.	change parameter 'int state'
	to 'pm_message_t state' in .suspend method.

Note:	The new .uevent method mark ACPI drivers by PNPID instead of by name.
	Udev script needs to look for "HWID=" or "COMPTID=" to load 
	ACPI drivers as a result.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/fan.c      |    8 +-
 drivers/acpi/scan.c     |  158 +++++++++++++++++++++++++++---------------------
 drivers/acpi/thermal.c  |    4 -
 include/acpi/acpi_bus.h |    9 +-
 4 files changed, 103 insertions(+), 76 deletions(-)

Index: linux-2.6.18/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/scan.c	2006-09-22 09:26:49.000000000 +0800
+++ linux-2.6.18/drivers/acpi/scan.c	2006-09-22 09:26:53.000000000 +0800
@@ -222,100 +222,124 @@ acpi_eject_store(struct acpi_device *dev
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
-static int root_suspend(struct acpi_device * acpi_dev, pm_message_t state)
+static int acpi_device_suspend(struct device *dev, pm_message_t state)
 {
-	struct acpi_device * dev, * next;
-	int result;
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = acpi_dev->driver;
 
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
+	if (acpi_drv && acpi_drv->ops.suspend)
+		return acpi_drv->ops.suspend(acpi_dev, state);
 	return 0;
 }
 
-static int acpi_device_suspend(struct device * dev, pm_message_t state)
+static int acpi_device_resume(struct device *dev)
 {
-	struct acpi_device * acpi_dev = to_acpi_device(dev);
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = acpi_dev->driver;
 
-	/*
-	 * For now, we should only register 1 generic device -
-	 * the ACPI root device - and from there, we walk the
-	 * tree of ACPI devices to suspend each one using the
-	 * ACPI driver methods.
-	 */
-	if (acpi_dev->handle == ACPI_ROOT_OBJECT)
-		root_suspend(acpi_dev, state);
+	if (acpi_drv && acpi_drv->ops.resume)
+		return acpi_drv->ops.resume(acpi_dev);
 	return 0;
 }
 
-static int root_resume(struct acpi_device * acpi_dev)
+static int acpi_bus_match(struct device *dev, struct device_driver *drv)
 {
-	struct acpi_device * dev, * next;
-	int result;
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
 
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
+	if (acpi_drv->ops.match)
+		return !acpi_drv->ops.match(acpi_dev, acpi_drv);
+	return !acpi_match_ids(acpi_dev, acpi_drv->ids);
+}
+
+static int acpi_device_uevent(struct device *dev, char **envp, int num_envp,
+	char *buffer, int buffer_size)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	int i = 0, length = 0, ret = 0;
+
+	if (acpi_dev->flags.hardware_id)
+		ret = add_uevent_var(envp, num_envp, &i,
+			buffer, buffer_size, &length,
+			"HWID=%s", acpi_dev->pnp.hardware_id);
+	if (ret)
+		return -ENOMEM;
+	if (acpi_dev->flags.compatible_ids) {
+		int j;
+		struct acpi_compatible_id_list *cid_list;
+
+		cid_list = acpi_dev->pnp.cid_list;
+
+		for (j = 0; j < cid_list->count; j++) {
+			ret = add_uevent_var(envp, num_envp, &i, buffer,
+				buffer_size, &length, "COMPTID=%s",
+				cid_list->id[j].value);
+			if (ret)
+				return -ENOMEM;
 		}
 	}
-	spin_unlock(&acpi_device_lock);
+
+	envp[i] = NULL;
 	return 0;
 }
 
-static int acpi_device_resume(struct device * dev)
+static int acpi_bus_driver_init(struct acpi_device *, struct acpi_driver *);
+static int acpi_start_single_object(struct acpi_device *);
+static int acpi_device_probe(struct device * dev)
 {
-	struct acpi_device * acpi_dev = to_acpi_device(dev);
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
+	int ret;
 
-	/*
-	 * For now, we should only register 1 generic device -
-	 * the ACPI root device - and from there, we walk the
-	 * tree of ACPI devices to resume each one using the
-	 * ACPI driver methods.
-	 */
-	if (acpi_dev->handle == ACPI_ROOT_OBJECT)
-		root_resume(acpi_dev);
+	ret = acpi_bus_driver_init(acpi_dev, acpi_drv);
+	if (!ret) {
+		acpi_start_single_object(acpi_dev);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Found driver [%s] for device [%s]\n",
+			acpi_drv->name, acpi_dev->pnp.bus_id));
+		get_device(dev);
+	}
+	return ret;
+}
+
+static int acpi_device_remove(struct device * dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = acpi_dev->driver;
+
+	if (acpi_drv) {
+		if (acpi_drv->ops.stop)
+			acpi_drv->ops.stop(acpi_dev, ACPI_BUS_REMOVAL_NORMAL);
+		if (acpi_drv->ops.remove)
+			acpi_drv->ops.remove(acpi_dev, ACPI_BUS_REMOVAL_NORMAL);
+	}
+	acpi_dev->driver = NULL;
+	acpi_driver_data(dev) = NULL;
+
+	put_device(dev);
 	return 0;
 }
 
-/**
- * acpi_bus_match - match device IDs to driver's supported IDs
- * @device: the device that we are trying to match to a driver
- * @driver: driver whose device id table is being checked
- *
- * Checks the device's hardware (_HID) or compatible (_CID) ids to see if it
- * matches the specified driver's criteria.
- */
-static int
-acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver)
+static void acpi_device_shutdown(struct device *dev)
 {
-	if (driver && driver->ops.match)
-		return driver->ops.match(device, driver);
-	return acpi_match_ids(device, driver->ids);
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = acpi_dev->driver;
+
+	if (acpi_drv && acpi_drv->ops.shutdown)
+		acpi_drv->ops.shutdown(acpi_dev);
+
+	return ;
 }
 
 static struct bus_type acpi_bus_type = {
 	.name		= "acpi",
 	.suspend	= acpi_device_suspend,
 	.resume		= acpi_device_resume,
+	.shutdown	= acpi_device_shutdown,
+	.match		= acpi_bus_match,
+	.probe		= acpi_device_probe,
+	.remove		= acpi_device_remove,
+	.uevent		= acpi_device_uevent,
 };
 
 static void acpi_device_register(struct acpi_device *device,
@@ -449,7 +473,7 @@ static void acpi_driver_attach(struct ac
 			continue;
 		spin_unlock(&acpi_device_lock);
 
-		if (!acpi_bus_match(dev, drv)) {
+		if (!acpi_bus_match(&(dev->dev), &(drv->drv))) {
 			if (!acpi_bus_driver_init(dev, drv)) {
 				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
@@ -551,7 +575,7 @@ static int acpi_bus_find_driver(struct a
 
 		atomic_inc(&driver->references);
 		spin_unlock(&acpi_device_lock);
-		if (!acpi_bus_match(device, driver)) {
+		if (!acpi_bus_match(&(device->dev), &(driver->drv))) {
 			result = acpi_bus_driver_init(device, driver);
 			if (!result)
 				goto Done;
Index: linux-2.6.18/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18.orig/include/acpi/acpi_bus.h	2006-09-22 09:26:49.000000000 +0800
+++ linux-2.6.18/include/acpi/acpi_bus.h	2006-09-22 09:26:53.000000000 +0800
@@ -92,13 +92,14 @@ typedef int (*acpi_op_remove) (struct ac
 typedef int (*acpi_op_lock) (struct acpi_device * device, int type);
 typedef int (*acpi_op_start) (struct acpi_device * device);
 typedef int (*acpi_op_stop) (struct acpi_device * device, int type);
-typedef int (*acpi_op_suspend) (struct acpi_device * device, int state);
-typedef int (*acpi_op_resume) (struct acpi_device * device, int state);
+typedef int (*acpi_op_suspend) (struct acpi_device * device, pm_message_t state);
+typedef int (*acpi_op_resume) (struct acpi_device * device);
 typedef int (*acpi_op_scan) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
 typedef int (*acpi_op_match) (struct acpi_device * device,
 			      struct acpi_driver * driver);
+typedef int (*acpi_op_shutdown) (struct acpi_device * device);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
@@ -112,7 +113,8 @@ struct acpi_bus_ops {
 	u32 acpi_op_bind:1;
 	u32 acpi_op_unbind:1;
 	u32 acpi_op_match:1;
-	u32 reserved:21;
+	u32 acpi_op_shutdown:1;
+	u32 reserved:20;
 };
 
 struct acpi_device_ops {
@@ -127,6 +129,7 @@ struct acpi_device_ops {
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_match match;
+	acpi_op_shutdown shutdown;
 };
 
 struct acpi_driver {
Index: linux-2.6.18/drivers/acpi/fan.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/fan.c	2006-09-22 09:26:49.000000000 +0800
+++ linux-2.6.18/drivers/acpi/fan.c	2006-09-22 09:27:24.000000000 +0800
@@ -48,8 +48,8 @@ MODULE_LICENSE("GPL");
 
 static int acpi_fan_add(struct acpi_device *device);
 static int acpi_fan_remove(struct acpi_device *device, int type);
-static int acpi_fan_suspend(struct acpi_device *device, int state);
-static int acpi_fan_resume(struct acpi_device *device, int state);
+static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state);
+static int acpi_fan_resume(struct acpi_device *device);
 
 static struct acpi_driver acpi_fan_driver = {
 	.name = ACPI_FAN_DRIVER_NAME,
@@ -238,7 +238,7 @@ static int acpi_fan_remove(struct acpi_d
 	return 0;
 }
 
-static int acpi_fan_suspend(struct acpi_device *device, int state)
+static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state)
 {
 	if (!device)
 		return -EINVAL;
@@ -248,7 +248,7 @@ static int acpi_fan_suspend(struct acpi_
 	return AE_OK;
 }
 
-static int acpi_fan_resume(struct acpi_device *device, int state)
+static int acpi_fan_resume(struct acpi_device *device)
 {
 	int result = 0;
 	int power_state = 0;
Index: linux-2.6.18/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/thermal.c	2006-09-22 09:26:49.000000000 +0800
+++ linux-2.6.18/drivers/acpi/thermal.c	2006-09-22 09:26:53.000000000 +0800
@@ -82,7 +82,7 @@ MODULE_PARM_DESC(tzp, "Thermal zone poll
 
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
-static int acpi_thermal_resume(struct acpi_device *device, int state);
+static int acpi_thermal_resume(struct acpi_device *device);
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
@@ -1356,7 +1356,7 @@ static int acpi_thermal_remove(struct ac
 	return 0;
 }
 
-static int acpi_thermal_resume(struct acpi_device *device, int state)
+static int acpi_thermal_resume(struct acpi_device *device)
 {
 	struct acpi_thermal *tz = NULL;
 	int i;
