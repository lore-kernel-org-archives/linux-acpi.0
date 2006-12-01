From: Zhang Rui <rui.zhang@intel.com>
Subject: updated patches of sysfs branch
Date: Fri, 01 Dec 2006 16:55:05 +0800
Message-ID: <1164963305.6324.5.camel@localhost.localdomain>
References: <11643454612902-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-onxsoPKTHcCeTpF/WL5+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35487 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S967562AbWLAIvP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Dec 2006 03:51:15 -0500
In-Reply-To: <11643454612902-git-send-email-len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, len.brown@intel.com, shaohua.li@intel.com


--=-onxsoPKTHcCeTpF/WL5+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> The following patches are on the "sysfs" branch of the ACPI git tree.
> 
> To test, apply this e-mail series, or git pull from here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git sysfs
> 
> I am hopeful that this series will settle down and make the test branch
> shortly, and thus make its way into an upcoming -mm release, and then upstream.
>
These are updated patches against 2.6.19. Len, could you update them in
sysfs branch please?

Four patches are refreshed in all.
[PATCH 4]: ACPI: add ACPI bus_type for driver model
remove parameter "int state" of battery driver .resume method, which is
added recently.
[PATCH 11]: ACPI: Convert ACPI PCI .bind/.unbind to use PCI bridge
driver
remove useless codes and comments which is shown in last patch.
[PATCH 13]: ACPI: use unique number as bus_id of ACPI devices in sysfs
use "PNPID:instance_no" as bus_id of ACPI devices in sysfs instead of
unique numbers.
[PATCH 14]: ACPI: ibm_acpi: don't use '/' in driver names
We add a new patch in this patch series. 
	ibm_acpi uses '/' in driver names, and this causes a failure when register an ibm_acpi driver.
	This patch replace '/' with '_' in driver names.
	Thank Henrique de Moraes Holschuh for generating this patch.

Thanks,
Ray


--=-onxsoPKTHcCeTpF/WL5+
Content-Disposition: attachment; filename=04-add-ACPI-bus_type-for-driver-model.patch
Content-Type: message/rfc822; name=04-add-ACPI-bus_type-for-driver-model.patch

From: Patrick Mochel <mochel@linux.intel.com>
Date: Fri, 01 Dec 2006 16:52:46 +0800
Subject: No Subject
Message-Id: <1164963166.6324.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Add ACPI bus_type for Linux driver model.

1.	.shutdown method is added into acpi_driver.ops
	needed by bus_type operations.
2.	remove useless parameter 'int state' in .resume method.
3.	change parameter 'int state'
	to 'pm_message_t state' in .suspend method.

Note:	The new .uevent method mark ACPI drivers by PNPID instead of by name.
	Udev script needs to look for "HWID=" or "COMPTID=" to load
	ACPI drivers as a result.

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c  |    4 -
 drivers/acpi/fan.c      |    8 +-
 drivers/acpi/scan.c     |  158 +++++++++++++++++++++++++++---------------------
 drivers/acpi/thermal.c  |    4 -
 include/acpi/acpi_bus.h |    9 +-
 5 files changed, 105 insertions(+), 78 deletions(-)

Index: linux-2.6.19/drivers/acpi/fan.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/fan.c	2006-12-01 15:18:30.000000000 +0800
+++ linux-2.6.19/drivers/acpi/fan.c	2006-12-01 15:18:34.000000000 +0800
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
Index: linux-2.6.19/drivers/acpi/scan.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/scan.c	2006-12-01 15:18:30.000000000 +0800
+++ linux-2.6.19/drivers/acpi/scan.c	2006-12-01 15:18:34.000000000 +0800
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
Index: linux-2.6.19/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/thermal.c	2006-12-01 15:18:30.000000000 +0800
+++ linux-2.6.19/drivers/acpi/thermal.c	2006-12-01 15:18:34.000000000 +0800
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
Index: linux-2.6.19/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.19.orig/include/acpi/acpi_bus.h	2006-12-01 15:18:30.000000000 +0800
+++ linux-2.6.19/include/acpi/acpi_bus.h	2006-12-01 15:18:34.000000000 +0800
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
Index: linux-2.6.19/drivers/acpi/battery.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/battery.c	2006-12-01 15:03:38.000000000 +0800
+++ linux-2.6.19/drivers/acpi/battery.c	2006-12-01 15:19:23.000000000 +0800
@@ -64,7 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
-static int acpi_battery_resume(struct acpi_device *device, int status);
+static int acpi_battery_resume(struct acpi_device *device);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -756,7 +756,7 @@ static int acpi_battery_remove(struct ac
 }
 
 /* this is needed to learn about changes made in suspended state */
-static int acpi_battery_resume(struct acpi_device *device, int state)
+static int acpi_battery_resume(struct acpi_device *device)
 {
 	struct acpi_battery *battery;
 

--=-onxsoPKTHcCeTpF/WL5+
Content-Disposition: attachment; filename*0=11-convert-ACPI-PCI-bind-unbind-to-use-PCI-bridge-driver.patc; filename*1=h
Content-Type: message/rfc822; name=11-convert-ACPI-PCI-bind-unbind-to-use-PCI-bridge-driver.patch

From: Li Shaohua <shaohua.li@intel.com>
Date: Fri, 01 Dec 2006 16:52:46 +0800
Subject: No Subject
Message-Id: <1164963166.6324.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

acpi_device had a .bind/.unbind methods, but Linux driver model does not.
Cut ACPI PCI code over to use the Linux driver model methods.

Convert bind/unbind to use a new pci bridge driver.
The driver will add/remove _PRT, so we can eventually
remove .bind/.unbind methods.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_bind.c |   56 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/acpi/pci_root.c |    5 ----
 drivers/acpi/scan.c     |   17 --------------
 3 files changed, 52 insertions(+), 26 deletions(-)

Index: linux-2.6.19/drivers/acpi/pci_bind.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/pci_bind.c	2006-12-01 15:20:34.000000000 +0800
+++ linux-2.6.19/drivers/acpi/pci_bind.c	2006-12-01 15:21:30.000000000 +0800
@@ -223,8 +223,6 @@ int acpi_pci_bind(struct acpi_device *de
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
-		device->ops.bind = acpi_pci_bind;
-		device->ops.unbind = acpi_pci_unbind;
 	}
 
 	/*
@@ -354,8 +352,6 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	data->id = *id;
 	data->bus = bus;
-	device->ops.bind = acpi_pci_bind;
-	device->ops.unbind = acpi_pci_unbind;
 
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -378,3 +374,55 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	return result;
 }
+
+#define ACPI_PCI_BRIDGE_DRIVER_NAME "ACPI PCI Bridge Driver"
+
+static int acpi_pci_bridge_add(struct acpi_device *device);
+static int acpi_pci_bridge_remove(struct acpi_device *device, int type);
+static int acpi_pci_bridge_match(struct acpi_device *device,
+       struct acpi_driver *driver);
+static struct acpi_driver acpi_pci_bridge_driver = {
+       .name = ACPI_PCI_BRIDGE_DRIVER_NAME,
+       .ops = {
+               .add = acpi_pci_bridge_add,
+               .remove = acpi_pci_bridge_remove,
+               .match = acpi_pci_bridge_match,
+       },
+};
+
+static int acpi_pci_bridge_match(struct acpi_device *device,
+       struct acpi_driver *driver)
+{
+       acpi_status status;
+       acpi_handle handle;
+
+       /* pci bridge has _PRT but isn't PNP0A03 */
+       status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
+       if (ACPI_FAILURE(status))
+               return -ENODEV;
+       if (!acpi_match_ids(device, "PNP0A03"))
+               return -ENODEV;
+       return 0;
+}
+
+static int acpi_pci_bridge_add(struct acpi_device *device)
+{
+       return acpi_pci_bind(device);
+}
+
+static int acpi_pci_bridge_remove(struct acpi_device *device, int type)
+{
+       return acpi_pci_unbind(device);
+}
+
+static int __init acpi_pci_bridge_init(void)
+{
+       if (acpi_pci_disabled)
+               return 0;
+       if (acpi_bus_register_driver(&acpi_pci_bridge_driver) < 0)
+               return -ENODEV;
+       return 0;
+}
+
+/* Should be called after ACPI pci root driver */
+subsys_initcall(acpi_pci_bridge_init);
Index: linux-2.6.19/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/pci_root.c	2006-12-01 15:20:34.000000000 +0800
+++ linux-2.6.19/drivers/acpi/pci_root.c	2006-12-01 15:21:30.000000000 +0800
@@ -175,11 +175,6 @@ static int acpi_pci_root_add(struct acpi
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	acpi_driver_data(device) = root;
 
-	/*
-	 * TBD: Doesn't the bus driver automatically set this?
-	 */
-	device->ops.bind = acpi_pci_bind;
-
 	/* 
 	 * Segment
 	 * -------
Index: linux-2.6.19/drivers/acpi/scan.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/scan.c	2006-12-01 15:20:34.000000000 +0800
+++ linux-2.6.19/drivers/acpi/scan.c	2006-12-01 15:22:25.000000000 +0800
@@ -866,11 +866,6 @@ static int acpi_bus_remove(struct acpi_d
 	if (!rmdevice)
 		return 0;
 
-	if (dev->flags.bus_address) {
-		if ((dev->parent) && (dev->parent->ops.unbind))
-			dev->parent->ops.unbind(dev);
-	}
-
 	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
 
 	return 0;
@@ -987,18 +982,6 @@ acpi_add_single_object(struct acpi_devic
 
 	acpi_device_register(device, parent);
 
-	/*
-	 * Bind _ADR-Based Devices
-	 * -----------------------
-	 * If there's a a bus address (_ADR) then we utilize the parent's 
-	 * 'bind' function (if exists) to bind the ACPI- and natively-
-	 * enumerated device representations.
-	 */
-	if (device->flags.bus_address) {
-		if (device->parent && device->parent->ops.bind)
-			device->parent->ops.bind(device);
-	}
-
       end:
 	if (!result)
 		*child = device;

--=-onxsoPKTHcCeTpF/WL5+
Content-Disposition: attachment; filename*0=13-use-PNPID-and-instance_no-as-bus_id-of-ACPI-devices-in-sys; filename*1=fs.patch
Content-Type: text/x-patch; name*0=13-use-PNPID-and-instance_no-as-bus_id-of-ACPI-devices-in-sysfs.p; name*1=atch; charset=utf-8
Content-Transfer-Encoding: 7bit

Previously we used the device name in the DSDT, but would
crash upon encountering a duplicate. Also, exposing the
DSDT device name to the user in a patch isn't a good idea,
because it is arbitrary.

After some discussion, we finally decided to use
"PNPID:instance_no" as the bus_id of ACPI devices.

Two attributes for each device are added at the same time,
the full pathname in ACPI namespace and hardware_id if it has.

NOTE:	acpi_bus_id_list is used to keep the information of PNPID
	and instance number of the given PNPID. Loop the
	acpi_bus_id_list to find the instance_no of the	same PNPID
	when register a device. If failed, i.e. we don't have a
	node with this PNPID, allocate one and link it to this list.

NOTE:	Now I don't take the memory free work in charge.
	If necessary, I can add a reference count in
	struct acpi_device_bus_id, and check the reference and
	when unregister a device, i.e. memory is freed when
	the reference count of a given PNPID is 0.
	
Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/scan.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 94 insertions(+), 9 deletions(-)

Index: linux-2.6.19/drivers/acpi/scan.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/scan.c	2006-12-01 16:23:50.000000000 +0800
+++ linux-2.6.19/drivers/acpi/scan.c	2006-12-01 16:29:05.000000000 +0800
@@ -21,9 +21,15 @@ extern struct acpi_device *acpi_root;
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 static LIST_HEAD(acpi_device_list);
+static LIST_HEAD(acpi_bus_id_list);
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
+struct acpi_device_bus_id{
+	char bus_id[9];
+	unsigned int instance_no;
+	struct list_head node;
+};
 static int acpi_eject_operation(acpi_handle handle, int lockable)
 {
 	struct acpi_object_list arg_list;
@@ -103,18 +109,61 @@ acpi_eject_store(struct device *d, struc
 
 static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
 
-static void acpi_device_setup_files(struct acpi_device *dev)
+static ssize_t
+acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%s\n", acpi_dev->pnp.hardware_id);
+}
+static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
+
+static ssize_t
+acpi_device_path_show(struct device *dev, struct device_attribute *attr, char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
+	int result;
+
+	result = acpi_get_name(acpi_dev->handle, ACPI_FULL_PATHNAME, &path);
+	if(result)
+		goto end;
+
+	result = sprintf(buf, "%s\n", (char*)path.pointer);
+	kfree(path.pointer);
+  end:
+	return result;
+}
+static DEVICE_ATTR(path, 0444, acpi_device_path_show, NULL);
+
+static int acpi_device_setup_files(struct acpi_device *dev)
 {
 	acpi_status status;
 	acpi_handle temp;
+	int result = 0;
 
 	/*
-	 * If device has _EJ0, 'eject' file is created that is used to trigger
-	 * hot-removal function from userland.
+	 * Devices gotten from FADT don't need "path" attribute
 	 */
+	if(dev->handle) {
+		result = device_create_file(&dev->dev, &dev_attr_path);
+		if(result)
+			goto end;
+	}
+
+	if(dev->flags.hardware_id) {
+		result = device_create_file(&dev->dev, &dev_attr_hid);
+		if(result)
+			goto end;
+	}
+
+        /*
+         * If device has _EJ0, 'eject' file is created that is used to trigger
+         * hot-removal function from userland.
+         */
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
-		device_create_file(&dev->dev, &dev_attr_eject);
+		result = device_create_file(&dev->dev, &dev_attr_eject);
+  end:
+	return result;
 }
 
 static void acpi_device_remove_files(struct acpi_device *dev)
@@ -129,6 +178,11 @@ static void acpi_device_remove_files(str
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
+
+	if(dev->flags.hardware_id)
+		device_remove_file(&dev->dev, &dev_attr_hid);
+	if(dev->handle)
+		device_remove_file(&dev->dev, &dev_attr_path);
 }
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
@@ -260,9 +314,13 @@ static struct bus_type acpi_bus_type = {
 	.uevent		= acpi_device_uevent,
 };
 
-static void acpi_device_register(struct acpi_device *device,
+static int acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
+	int result;
+	struct list_head *node, *next;
+	struct acpi_device_bus_id *acpi_device_bus_id;
+	int found = 0;
 	/*
 	 * Linkage
 	 * -------
@@ -281,18 +339,45 @@ static void acpi_device_register(struct 
 		list_add_tail(&device->g_list, &acpi_device_list);
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
+	/*
+	 * Find suitable bus_id and instance number in acpi_bus_id_list
+	 * If failed, create one and link it into acpi_bus_id_list
+	 */
+	list_for_each_safe(node, next, &acpi_bus_id_list) {
+		acpi_device_bus_id = container_of(node, struct acpi_device_bus_id, node);
+		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "PNPIDNON")) {
+			acpi_device_bus_id->instance_no ++;
+			found = 1;
+			break;
+		}
+	}
+	if(!found) {
+		acpi_device_bus_id = kmalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
+		memset(acpi_device_bus_id, sizeof(struct acpi_device_bus_id), 0);
+		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "PNPIDNON");
+		acpi_device_bus_id->instance_no = 0;
+		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
+		}
+	sprintf(device->dev.bus_id, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 	spin_unlock(&acpi_device_lock);
 
 	if (device->parent)
 		device->dev.parent = &parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device_initialize(&device->dev);
-	sprintf(device->dev.bus_id, "%s", device->pnp.bus_id);
 	device->dev.release = &acpi_device_release;
-	device_add(&device->dev);
+	result = device_add(&device->dev);
+	if(result) {
+		printk("Error adding device %s", device->dev.bus_id);
+		return result;
+	}
+
+	result = acpi_device_setup_files(device);
+	if(result)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->dev.bus_id));
 
-	acpi_device_setup_files(device);
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
+	return 0;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -1035,7 +1120,7 @@ acpi_add_single_object(struct acpi_devic
 
 	acpi_device_get_debug_info(device, handle, type);
 
-	acpi_device_register(device, parent);
+	result = acpi_device_register(device, parent);
 
       end:
 	if (!result)

--=-onxsoPKTHcCeTpF/WL5+
Content-Disposition: attachment; filename=14-fix-ibm_acpi-sub_driver-name.patch
Content-Type: message/rfc822; name=14-fix-ibm_acpi-sub_driver-name.patch

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Fri, 01 Dec 2006 16:54:46 +0800
Subject: No Subject
Message-Id: <1164963286.6324.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
Rui for noticing this.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---

 drivers/acpi/ibm_acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/ibm_acpi.c	2006-12-01 11:10:37.000000000 +0800
+++ linux-2.6.19/drivers/acpi/ibm_acpi.c	2006-12-01 11:33:30.000000000 +0800
@@ -1825,7 +1825,7 @@ static int __init register_driver(struct
 	}
 
 	memset(ibm->driver, 0, sizeof(struct acpi_driver));
-	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
+	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
 	ibm->driver->ids = ibm->hid;
 	ibm->driver->ops.add = &ibm_device_add;
 

--=-onxsoPKTHcCeTpF/WL5+--
