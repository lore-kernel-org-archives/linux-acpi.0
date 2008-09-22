From: Holger Macht <hmacht@suse.de>
Subject: Re: Problem with kernel commit
	664d080c41463570b95717b5ad86e79dc1be0877
Date: Mon, 22 Sep 2008 12:57:48 +0200
Message-ID: <20080922105747.GA26633@homac.suse.de>
References: <20080921173506.GA15741@tarantula.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:54687 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbYIVK57 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 06:57:59 -0400
Content-Disposition: inline
In-Reply-To: <20080921173506.GA15741@tarantula.kolej.mff.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal 'vorner' Vaner <vorner@ucw.cz>
Cc: linux-acpi@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>, trenn@suse.de


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun 21. Sep - 19:35:06, Michal 'vorner' Vaner wrote:
> Hello
> 
> Recently, I updated my kernel from 2.6.25 to latest .27 rc and found a
> problem. I have a dell latitude D510 laptop with a media bay slot. If I
> have any disk-like device inserted (CDRom or secondary disk) and remove
> it, acpi starts generating ~250 interrupts per second (found out by
> powertop) and kacpid and kacpid_notify start using all available CPU
> time. It stops after any disk-like device is plugged back in, however,
> inserting secondary battery does not help (which means replacing a
> CDRom with a battery has the opposite than desired effect, making the
> runtime shorter).
> 
> By bisecting the kernel sources, I identified it to the commit
> 664d080c41463570b95717b5ad86e79dc1be0877 (ACPI: Properly handle bay
> devices in dock stations, from Linus's branch), which mentions you
> as an author.
> 
> I would like to help to fix it, so if you need any information, I will
> try to get them. Also, I have some experience in programming and trying
> a development version of kernel is not a problem for me, but I did not
> yet get into kernel development.

Can you please try the patch I have attached? It is the all-in-one patch
for the patch series Shaohua Li posted some time ago and applies to
current Linus' git.

Thanks,
	Holger

--xgyAXRrhYN0wYx8y
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="acpi-merge-bay-into-dock.patch"

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 735f5ea..3919d6d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -160,15 +160,8 @@ config ACPI_DOCK
 	tristate "Dock"
 	depends on EXPERIMENTAL
 	help
-	  This driver adds support for ACPI controlled docking stations
-
-config ACPI_BAY
-	tristate "Removable Drive Bay (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	depends on ACPI_DOCK
-	help
-	  This driver adds support for ACPI controlled removable drive
-	  bays such as the IBM ultrabay or the Dell Module Bay.
+	  This driver adds support for ACPI controlled docking stations and removable
+	  drive bays such as the IBM ultrabay or the Dell Module Bay.
 
 config ACPI_PROCESSOR
 	tristate "Processor"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 52a4cd4..ad4bfd5 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_DOCK)		+= dock.o
-obj-$(CONFIG_ACPI_BAY)		+= bay.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
deleted file mode 100644
index 61b6c5b..0000000
--- a/drivers/acpi/bay.c
+++ /dev/null
@@ -1,411 +0,0 @@
-/*
- *  bay.c - ACPI removable drive bay driver
- *
- *  Copyright (C) 2006 Kristen Carlson Accardi <kristen.c.accardi@intel.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or (at
- *  your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/notifier.h>
-#include <acpi/acpi_bus.h>
-#include <acpi/acpi_drivers.h>
-#include <linux/seq_file.h>
-#include <asm/uaccess.h>
-#include <linux/platform_device.h>
-
-ACPI_MODULE_NAME("bay");
-MODULE_AUTHOR("Kristen Carlson Accardi");
-MODULE_DESCRIPTION("ACPI Removable Drive Bay Driver");
-MODULE_LICENSE("GPL");
-#define ACPI_BAY_CLASS "bay"
-#define ACPI_BAY_COMPONENT	0x10000000
-#define _COMPONENT ACPI_BAY_COMPONENT
-#define bay_dprintk(h,s) {\
-	char prefix[80] = {'\0'};\
-	struct acpi_buffer buffer = {sizeof(prefix), prefix};\
-	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
-	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
-static void bay_notify(acpi_handle handle, u32 event, void *data);
-
-static const struct acpi_device_id bay_device_ids[] = {
-	{"LNXIOBAY", 0},
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, bay_device_ids);
-
-struct bay {
-	acpi_handle handle;
-	char *name;
-	struct list_head list;
-	struct platform_device *pdev;
-};
-
-static LIST_HEAD(drive_bays);
-
-
-/*****************************************************************************
- *                         Drive Bay functions                               *
- *****************************************************************************/
-/**
- * is_ejectable - see if a device is ejectable
- * @handle: acpi handle of the device
- *
- * If an acpi object has a _EJ0 method, then it is ejectable
- */
-static int is_ejectable(acpi_handle handle)
-{
-	acpi_status status;
-	acpi_handle tmp;
-
-	status = acpi_get_handle(handle, "_EJ0", &tmp);
-	if (ACPI_FAILURE(status))
-		return 0;
-	return 1;
-}
-
-/**
- * bay_present - see if the bay device is present
- * @bay: the drive bay
- *
- * execute the _STA method.
- */
-static int bay_present(struct bay *bay)
-{
-	unsigned long sta;
-	acpi_status status;
-
-	if (bay) {
-		status = acpi_evaluate_integer(bay->handle, "_STA", NULL, &sta);
-		if (ACPI_SUCCESS(status) && sta)
-			return 1;
-	}
-	return 0;
-}
-
-/**
- * eject_device - respond to an eject request
- * @handle - the device to eject
- *
- * Call this devices _EJ0 method.
- */
-static void eject_device(acpi_handle handle)
-{
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-
-	bay_dprintk(handle, "Ejecting device");
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = 1;
-
-	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_EJ0",
-					      &arg_list, NULL)))
-		pr_debug("Failed to evaluate _EJ0!\n");
-}
-
-/*
- * show_present - read method for "present" file in sysfs
- */
-static ssize_t show_present(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	struct bay *bay = dev_get_drvdata(dev);
-	return snprintf(buf, PAGE_SIZE, "%d\n", bay_present(bay));
-
-}
-static DEVICE_ATTR(present, S_IRUGO, show_present, NULL);
-
-/*
- * write_eject - write method for "eject" file in sysfs
- */
-static ssize_t write_eject(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
-{
-	struct bay *bay = dev_get_drvdata(dev);
-
-	if (!count)
-		return -EINVAL;
-
-	eject_device(bay->handle);
-	return count;
-}
-static DEVICE_ATTR(eject, S_IWUSR, NULL, write_eject);
-
-/**
- * is_ata - see if a device is an ata device
- * @handle: acpi handle of the device
- *
- * If an acpi object has one of 4 ATA ACPI methods defined,
- * then it is an ATA device
- */
-static int is_ata(acpi_handle handle)
-{
-	acpi_handle tmp;
-
-	if ((ACPI_SUCCESS(acpi_get_handle(handle, "_GTF", &tmp))) ||
-	   (ACPI_SUCCESS(acpi_get_handle(handle, "_GTM", &tmp))) ||
-	   (ACPI_SUCCESS(acpi_get_handle(handle, "_STM", &tmp))) ||
-	   (ACPI_SUCCESS(acpi_get_handle(handle, "_SDD", &tmp))))
-		return 1;
-
-	return 0;
-}
-
-/**
- * parent_is_ata(acpi_handle handle)
- *
- */
-static int parent_is_ata(acpi_handle handle)
-{
-	acpi_handle phandle;
-
-	if (acpi_get_parent(handle, &phandle))
-		return 0;
-
-	return is_ata(phandle);
-}
-
-/**
- * is_ejectable_bay - see if a device is an ejectable drive bay
- * @handle: acpi handle of the device
- *
- * If an acpi object is ejectable and has one of the ACPI ATA
- * methods defined, then we can safely call it an ejectable
- * drive bay
- */
-static int is_ejectable_bay(acpi_handle handle)
-{
-	if ((is_ata(handle) || parent_is_ata(handle)) && is_ejectable(handle))
-		return 1;
-	return 0;
-}
-
-#if 0
-/**
- * eject_removable_drive - try to eject this drive
- * @dev : the device structure of the drive
- *
- * If a device is a removable drive that requires an _EJ0 method
- * to be executed in order to safely remove from the system, do
- * it.  ATM - always returns success
- */
-int eject_removable_drive(struct device *dev)
-{
-	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
-
-	if (handle) {
-		bay_dprintk(handle, "Got device handle");
-		if (is_ejectable_bay(handle))
-			eject_device(handle);
-	} else {
-		printk("No acpi handle for device\n");
-	}
-
-	/* should I return an error code? */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eject_removable_drive);
-#endif  /*  0  */
-
-static int acpi_bay_add_fs(struct bay *bay)
-{
-	int ret;
-	struct device *dev = &bay->pdev->dev;
-
-	ret = device_create_file(dev, &dev_attr_present);
-	if (ret)
-		goto add_fs_err;
-	ret = device_create_file(dev, &dev_attr_eject);
-	if (ret) {
-		device_remove_file(dev, &dev_attr_present);
-		goto add_fs_err;
-	}
-	return 0;
-
- add_fs_err:
-	bay_dprintk(bay->handle, "Error adding sysfs files\n");
-	return ret;
-}
-
-static void acpi_bay_remove_fs(struct bay *bay)
-{
-	struct device *dev = &bay->pdev->dev;
-
-	/* cleanup sysfs */
-	device_remove_file(dev, &dev_attr_present);
-	device_remove_file(dev, &dev_attr_eject);
-}
-
-static int bay_is_dock_device(acpi_handle handle)
-{
-	acpi_handle parent;
-
-	acpi_get_parent(handle, &parent);
-
-	/* if the device or it's parent is dependent on the
-	 * dock, then we are a dock device
-	 */
-	return (is_dock_device(handle) || is_dock_device(parent));
-}
-
-static int bay_add(acpi_handle handle, int id)
-{
-	acpi_status status;
-	struct bay *new_bay;
-	struct platform_device *pdev;
-	struct acpi_buffer nbuffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &nbuffer);
-
-	bay_dprintk(handle, "Adding notify handler");
-
-	/*
-	 * Initialize bay device structure
-	 */
-	new_bay = kzalloc(sizeof(*new_bay), GFP_ATOMIC);
-	INIT_LIST_HEAD(&new_bay->list);
-	new_bay->handle = handle;
-	new_bay->name = (char *)nbuffer.pointer;
-
-	/* initialize platform device stuff */
-	pdev = platform_device_register_simple(ACPI_BAY_CLASS, id, NULL, 0);
-	if (IS_ERR(pdev)) {
-		printk(KERN_ERR PREFIX "Error registering bay device\n");
-		goto bay_add_err;
-	}
-	new_bay->pdev = pdev;
-	platform_set_drvdata(pdev, new_bay);
-
-	/*
-	 * we want the bay driver to be able to send uevents
-	 */
-	pdev->dev.uevent_suppress = 0;
-
-	/* register for events on this device */
-	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-			bay_notify, new_bay);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_INFO PREFIX "Error installing bay notify handler\n");
-		platform_device_unregister(new_bay->pdev);
-		goto bay_add_err;
-	}
-
-	if (acpi_bay_add_fs(new_bay)) {
-		acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-					   bay_notify);
-		platform_device_unregister(new_bay->pdev);
-		goto bay_add_err;
-	}
-
-	/* if we are on a dock station, we should register for dock
-	 * notifications.
-	 */
-	if (bay_is_dock_device(handle)) {
-		bay_dprintk(handle, "Is dependent on dock\n");
-		register_hotplug_dock_device(handle, bay_notify, new_bay);
-	}
-	list_add(&new_bay->list, &drive_bays);
-	printk(KERN_INFO PREFIX "Bay [%s] Added\n", new_bay->name);
-	return 0;
-
-bay_add_err:
-	kfree(new_bay->name);
-	kfree(new_bay);
-	return -ENODEV;
-}
-
-/**
- * bay_notify - act upon an acpi bay notification
- * @handle: the bay handle
- * @event: the acpi event
- * @data: our driver data struct
- *
- */
-static void bay_notify(acpi_handle handle, u32 event, void *data)
-{
-	struct bay *bay_dev = (struct bay *)data;
-	struct device *dev = &bay_dev->pdev->dev;
-	char event_string[12];
-	char *envp[] = { event_string, NULL };
-
-	bay_dprintk(handle, "Bay event");
-	sprintf(event_string, "BAY_EVENT=%d", event);
-	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
-}
-
-static acpi_status
-find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	int *count = (int *)context;
-
-	/*
-	 * there could be more than one ejectable bay.
-	 * so, just return AE_OK always so that every object
-	 * will be checked.
-	 */
-	if (is_ejectable_bay(handle)) {
-		bay_dprintk(handle, "found ejectable bay");
-		if (!bay_add(handle, *count))
-			(*count)++;
-	}
-	return AE_OK;
-}
-
-static int __init bay_init(void)
-{
-	int bays = 0;
-
-	INIT_LIST_HEAD(&drive_bays);
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	/* look for dockable drive bays */
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-		ACPI_UINT32_MAX, find_bay, &bays, NULL);
-
-	if (!bays)
-		return -ENODEV;
-
-	return 0;
-}
-
-static void __exit bay_exit(void)
-{
-	struct bay *bay, *tmp;
-
-	list_for_each_entry_safe(bay, tmp, &drive_bays, list) {
-		if (is_dock_device(bay->handle))
-			unregister_hotplug_dock_device(bay->handle);
-		acpi_bay_remove_fs(bay);
-		acpi_remove_notify_handler(bay->handle, ACPI_SYSTEM_NOTIFY,
-			bay_notify);
-		platform_device_unregister(bay->pdev);
-		kfree(bay->name);
-		kfree(bay);
-	}
-}
-
-postcore_initcall(bay_init);
-module_exit(bay_exit);
-
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ccae305..0dc4494 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -496,6 +496,19 @@ static int acpi_bus_check_scope(struct acpi_device *device)
 	return 0;
 }
 
+static BLOCKING_NOTIFIER_HEAD(acpi_bus_notify_list);
+int register_acpi_bus_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&acpi_bus_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_acpi_bus_notifier);
+
+void unregister_acpi_bus_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&acpi_bus_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_acpi_bus_notifier);
+
 /**
  * acpi_bus_notify
  * ---------------
@@ -506,6 +519,8 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	int result = 0;
 	struct acpi_device *device = NULL;
 
+	blocking_notifier_call_chain(&acpi_bus_notify_list,
+		type, (void *)handle);
 
 	if (acpi_bus_get_device(handle, &device))
 		return;
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7d2edf1..b7d1581 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -48,7 +48,6 @@ MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
 	" before undocking");
 
 static struct atomic_notifier_head dock_notifier_list;
-static struct platform_device *dock_device;
 static char dock_device_name[] = "dock";
 
 static const struct acpi_device_id dock_device_ids[] = {
@@ -65,23 +64,29 @@ struct dock_station {
 	struct mutex hp_lock;
 	struct list_head dependent_devices;
 	struct list_head hotplug_devices;
+
+	struct list_head sibiling;
+	struct platform_device *dock_device;
 };
+static LIST_HEAD(dock_stations);
+static int dock_station_count;
 
 struct dock_dependent_device {
 	struct list_head list;
 	struct list_head hotplug_list;
 	acpi_handle handle;
-	acpi_notify_handler handler;
+	struct acpi_dock_ops *ops;
 	void *context;
 };
 
 #define DOCK_DOCKING	0x00000001
 #define DOCK_UNDOCKING  0x00000002
+#define DOCK_IS_DOCK	0x00000010
+#define DOCK_IS_ATA	0x00000020
+#define DOCK_IS_BAT	0x00000040
 #define DOCK_EVENT	3
 #define UNDOCK_EVENT	2
 
-static struct dock_station *dock_station;
-
 /*****************************************************************************
  *                         Dock Dependent device functions                   *
  *****************************************************************************/
@@ -199,6 +204,60 @@ static int is_dock(acpi_handle handle)
 	return 1;
 }
 
+static int is_ejectable(acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status = acpi_get_handle(handle, "_EJ0", &tmp);
+	if (ACPI_FAILURE(status))
+		return 0;
+	return 1;
+}
+
+static int is_ata(acpi_handle handle)
+{
+	acpi_handle tmp;
+
+	if ((ACPI_SUCCESS(acpi_get_handle(handle, "_GTF", &tmp))) ||
+	   (ACPI_SUCCESS(acpi_get_handle(handle, "_GTM", &tmp))) ||
+	   (ACPI_SUCCESS(acpi_get_handle(handle, "_STM", &tmp))) ||
+	   (ACPI_SUCCESS(acpi_get_handle(handle, "_SDD", &tmp))))
+		return 1;
+
+	return 0;
+}
+
+static int is_battery(acpi_handle handle)
+{
+	struct acpi_device_info *info;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	int ret = 1;
+
+	if (!ACPI_SUCCESS(acpi_get_object_info(handle, &buffer)))
+		return 0;
+	info = buffer.pointer;
+	if (!(info->valid & ACPI_VALID_HID))
+		ret = 0;
+	else
+		ret = !strcmp("PNP0C0A", info->hardware_id.value);
+
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static int is_ejectable_bay(acpi_handle handle)
+{
+	acpi_handle phandle;
+	if (!is_ejectable(handle))
+		return 0;
+	if (is_battery(handle) || is_ata(handle))
+		return 1;
+	if (!acpi_get_parent(handle, &phandle) && is_ata(phandle))
+		return 1;
+	return 0;
+}
+
 /**
  * is_dock_device - see if a device is on a dock station
  * @handle: acpi handle of the device
@@ -209,11 +268,17 @@ static int is_dock(acpi_handle handle)
  */
 int is_dock_device(acpi_handle handle)
 {
-	if (!dock_station)
+	struct dock_station *dock_station;
+
+	if (!dock_station_count)
 		return 0;
 
-	if (is_dock(handle) || find_dock_dependent_device(dock_station, handle))
+	if (is_dock(handle))
 		return 1;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		if (find_dock_dependent_device(dock_station, handle))
+			return 1;
+	}
 
 	return 0;
 }
@@ -320,8 +385,8 @@ static void hotplug_dock_devices(struct dock_station *ds, u32 event)
 	 * First call driver specific hotplug functions
 	 */
 	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
-		if (dd->handler)
-			dd->handler(dd->handle, event, dd->context);
+		if (dd->ops && dd->ops->handler)
+			dd->ops->handler(dd->handle, event, dd->context);
 	}
 
 	/*
@@ -341,9 +406,10 @@ static void hotplug_dock_devices(struct dock_station *ds, u32 event)
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
-	struct device *dev = &dock_device->dev;
+	struct device *dev = &ds->dock_device->dev;
 	char event_string[13];
 	char *envp[] = { event_string, NULL };
+	struct dock_dependent_device *dd;
 
 	if (num == UNDOCK_EVENT)
 		sprintf(event_string, "EVENT=undock");
@@ -354,7 +420,14 @@ static void dock_event(struct dock_station *ds, u32 event, int num)
 	 * Indicate that the status of the dock station has
 	 * changed.
 	 */
-	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+	if (num == DOCK_EVENT)
+		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+
+	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list)
+		if (dd->ops && dd->ops->uevent)
+			dd->ops->uevent(dd->handle, event, dd->context);
+	if (num != DOCK_EVENT)
+		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
 
 /**
@@ -414,7 +487,7 @@ static void handle_dock(struct dock_station *ds, int dock)
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = dock;
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
 		printk(KERN_ERR PREFIX "%s - failed to execute _DCK\n",
 			 (char *)name_buffer.pointer);
 	kfree(buffer.pointer);
@@ -452,6 +525,25 @@ static inline void complete_undock(struct dock_station *ds)
 	ds->flags &= ~(DOCK_UNDOCKING);
 }
 
+static void dock_lock(struct dock_station *ds, int lock)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = !!lock;
+	status = acpi_evaluate_object(ds->handle, "_LCK", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		if (lock)
+			printk(KERN_WARNING PREFIX "Locking device failed\n");
+		else
+			printk(KERN_WARNING PREFIX "Unlocking device failed\n");
+	}
+}
+
 /**
  * dock_in_progress - see if we are in the middle of handling a dock event
  * @ds: the dock station
@@ -479,7 +571,7 @@ static int dock_in_progress(struct dock_station *ds)
  */
 int register_dock_notifier(struct notifier_block *nb)
 {
-	if (!dock_station)
+	if (!dock_station_count)
 		return -ENODEV;
 
 	return atomic_notifier_chain_register(&dock_notifier_list, nb);
@@ -493,7 +585,7 @@ EXPORT_SYMBOL_GPL(register_dock_notifier);
  */
 void unregister_dock_notifier(struct notifier_block *nb)
 {
-	if (!dock_station)
+	if (!dock_station_count)
 		return;
 
 	atomic_notifier_chain_unregister(&dock_notifier_list, nb);
@@ -504,7 +596,7 @@ EXPORT_SYMBOL_GPL(unregister_dock_notifier);
 /**
  * register_hotplug_dock_device - register a hotplug function
  * @handle: the handle of the device
- * @handler: the acpi_notifier_handler to call after docking
+ * @ops: handlers to call after docking
  * @context: device specific data
  *
  * If a driver would like to perform a hotplug operation after a dock
@@ -512,27 +604,36 @@ EXPORT_SYMBOL_GPL(unregister_dock_notifier);
  * the dock driver after _DCK is executed.
  */
 int
-register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler handler,
+register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 			     void *context)
 {
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
+	int ret = -EINVAL;
 
-	if (!dock_station)
+	if (!dock_station_count)
 		return -ENODEV;
 
 	/*
 	 * make sure this handle is for a device dependent on the dock,
 	 * this would include the dock station itself
 	 */
-	dd = find_dock_dependent_device(dock_station, handle);
-	if (dd) {
-		dd->handler = handler;
-		dd->context = context;
-		dock_add_hotplug_device(dock_station, dd);
-		return 0;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		/*
+		 * An ATA bay can be in a dock and itself can be ejected
+		 * seperately, so there are two 'dock stations' which need the
+		 * ops
+		 */
+		dd = find_dock_dependent_device(dock_station, handle);
+		if (dd) {
+			dd->ops = ops;
+			dd->context = context;
+			dock_add_hotplug_device(dock_station, dd);
+			ret = 0;
+		}
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(register_hotplug_dock_device);
@@ -544,13 +645,16 @@ EXPORT_SYMBOL_GPL(register_hotplug_dock_device);
 void unregister_hotplug_dock_device(acpi_handle handle)
 {
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
 
-	if (!dock_station)
+	if (!dock_station_count)
 		return;
 
-	dd = find_dock_dependent_device(dock_station, handle);
-	if (dd)
-		dock_del_hotplug_device(dock_station, dd);
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		dd = find_dock_dependent_device(dock_station, handle);
+		if (dd)
+			dock_del_hotplug_device(dock_station, dd);
+	}
 }
 
 EXPORT_SYMBOL_GPL(unregister_hotplug_dock_device);
@@ -575,13 +679,9 @@ static int handle_eject_request(struct dock_station *ds, u32 event)
 	 */
 	dock_event(ds, event, UNDOCK_EVENT);
 
-	if (!dock_present(ds)) {
-		complete_undock(ds);
-		return -ENODEV;
-	}
-
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
+	dock_lock(ds, 0);
 	eject_dock(ds);
 	if (dock_present(ds)) {
 		printk(KERN_ERR PREFIX "Unable to undock!\n");
@@ -604,14 +704,36 @@ static int handle_eject_request(struct dock_station *ds, u32 event)
 static void dock_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct dock_station *ds = data;
+	struct acpi_device *tmp;
+	int surprise_removal = 0;
+
+	/*
+	 * According to acpi spec 3.0a, if a DEVICE_CHECK notification
+	 * is sent and _DCK is present, it is assumed to mean an undock
+	 * request.
+	 */
+	if ((ds->flags & DOCK_IS_DOCK) && event == ACPI_NOTIFY_DEVICE_CHECK)
+		event = ACPI_NOTIFY_EJECT_REQUEST;
 
+	/*
+	 * dock station: BUS_CHECK - docked or surprise removal
+	 *		 DEVICE_CHECK - undocked
+	 * other device: BUS_CHECK/DEVICE_CHECK - added or surprise removal
+	 *
+	 * To simplify event handling, dock dependent device handler always
+	 * get ACPI_NOTIFY_BUS_CHECK/ACPI_NOTIFY_DEVICE_CHECK for add and
+	 * ACPI_NOTIFY_EJECT_REQUEST for removal
+	 */
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		if (!dock_in_progress(ds) && dock_present(ds)) {
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle,
+		   &tmp)) {
 			begin_dock(ds);
 			dock(ds);
 			if (!dock_present(ds)) {
 				printk(KERN_ERR PREFIX "Unable to dock!\n");
+				complete_dock(ds);
 				break;
 			}
 			atomic_notifier_call_chain(&dock_notifier_list,
@@ -619,20 +741,19 @@ static void dock_notify(acpi_handle handle, u32 event, void *data)
 			hotplug_dock_devices(ds, event);
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
+			dock_lock(ds, 1);
+			break;
 		}
-		break;
-	case ACPI_NOTIFY_DEVICE_CHECK:
-	/*
-         * According to acpi spec 3.0a, if a DEVICE_CHECK notification
-         * is sent and _DCK is present, it is assumed to mean an
-         * undock request.  This notify routine will only be called
-         * for objects defining _DCK, so we will fall through to eject
-         * request here.  However, we will pass an eject request through
-	 * to the driver who wish to hotplug.
-         */
+		if (dock_present(ds) || dock_in_progress(ds))
+			break;
+		/* This is a surprise removal */
+		surprise_removal = 1;
+		event = ACPI_NOTIFY_EJECT_REQUEST;
+		/* Fall back */
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		begin_undock(ds);
-		if (immediate_undock)
+		if ((immediate_undock && !(ds->flags & DOCK_IS_ATA))
+		   || surprise_removal)
 			handle_eject_request(ds, event);
 		else
 			dock_event(ds, event, UNDOCK_EVENT);
@@ -642,6 +763,51 @@ static void dock_notify(acpi_handle handle, u32 event, void *data)
 	}
 }
 
+struct dock_data {
+	acpi_handle handle;
+	unsigned long event;
+	struct dock_station *ds;
+};
+
+static void acpi_dock_deferred_cb(void *context)
+{
+	struct dock_data *data = (struct dock_data *)context;
+
+	dock_notify(data->handle, data->event, data->ds);
+	kfree(data);
+}
+
+static int acpi_dock_notifier_call(struct notifier_block *this,
+	unsigned long event, void *data)
+{
+	struct dock_station *dock_station;
+	acpi_handle handle = (acpi_handle)data;
+
+	if (event != ACPI_NOTIFY_BUS_CHECK && event != ACPI_NOTIFY_DEVICE_CHECK
+	   && event != ACPI_NOTIFY_EJECT_REQUEST)
+		return 0;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		if (dock_station->handle == handle) {
+			struct dock_data *dock_data;
+
+			dock_data = kmalloc(sizeof(*dock_data), GFP_KERNEL);
+			if (!dock_data)
+				return 0;
+			dock_data->handle = handle;
+			dock_data->event = event;
+			dock_data->ds = dock_station;
+			acpi_os_hotplug_execute(acpi_dock_deferred_cb,
+				dock_data);
+			return 0 ;
+		}
+	}
+	return 0;
+}
+
+static struct notifier_block dock_acpi_notifier = {
+	.notifier_call = acpi_dock_notifier_call,
+};
+
 /**
  * find_dock_devices - find devices on the dock station
  * @handle: the handle of the device we are examining
@@ -688,6 +854,8 @@ fdd_out:
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
 
 }
@@ -699,6 +867,8 @@ static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 static ssize_t show_flags(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
 
 }
@@ -711,6 +881,8 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
 	int ret;
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
 
 	if (!count)
 		return -EINVAL;
@@ -728,6 +900,8 @@ static ssize_t show_dock_uid(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	unsigned long lbuf;
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
 	acpi_status status = acpi_evaluate_integer(dock_station->handle,
 					"_UID", NULL, &lbuf);
 	if (ACPI_FAILURE(status))
@@ -737,6 +911,26 @@ static ssize_t show_dock_uid(struct device *dev,
 }
 static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 
+static ssize_t show_dock_type(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
+	char *type;
+
+	if (dock_station->flags & DOCK_IS_DOCK)
+		type = "dock_station";
+	else if (dock_station->flags & DOCK_IS_ATA)
+		type = "ata_bay";
+	else if (dock_station->flags & DOCK_IS_BAT)
+		type = "battery_bay";
+	else
+		type = "unknown";
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", type);
+}
+static DEVICE_ATTR(type, S_IRUGO, show_dock_type, NULL);
+
 /**
  * dock_add - add a new dock station
  * @handle: the dock station handle
@@ -747,8 +941,9 @@ static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 static int dock_add(acpi_handle handle)
 {
 	int ret;
-	acpi_status status;
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
+	struct platform_device *dock_device;
 
 	/* allocate & initialize the dock_station private data */
 	dock_station = kzalloc(sizeof(*dock_station), GFP_KERNEL);
@@ -758,22 +953,34 @@ static int dock_add(acpi_handle handle)
 	dock_station->last_dock_time = jiffies - HZ;
 	INIT_LIST_HEAD(&dock_station->dependent_devices);
 	INIT_LIST_HEAD(&dock_station->hotplug_devices);
+	INIT_LIST_HEAD(&dock_station->sibiling);
 	spin_lock_init(&dock_station->dd_lock);
 	mutex_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
 	/* initialize platform device stuff */
-	dock_device =
-		platform_device_register_simple(dock_device_name, 0, NULL, 0);
+	dock_station->dock_device =
+		platform_device_register_simple(dock_device_name,
+			dock_station_count, NULL, 0);
+	dock_device = dock_station->dock_device;
 	if (IS_ERR(dock_device)) {
 		kfree(dock_station);
 		dock_station = NULL;
 		return PTR_ERR(dock_device);
 	}
+	platform_device_add_data(dock_device, &dock_station,
+		sizeof(struct dock_station *));
 
 	/* we want the dock device to send uevents */
 	dock_device->dev.uevent_suppress = 0;
 
+	if (is_dock(handle))
+		dock_station->flags |= DOCK_IS_DOCK;
+	if (is_ata(handle))
+		dock_station->flags |= DOCK_IS_ATA;
+	if (is_battery(handle))
+		dock_station->flags |= DOCK_IS_BAT;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
@@ -812,6 +1019,9 @@ static int dock_add(acpi_handle handle)
 		dock_station = NULL;
 		return ret;
 	}
+	ret = device_create_file(&dock_device->dev, &dev_attr_type);
+	if (ret)
+		printk(KERN_ERR"Error %d adding sysfs file\n", ret);
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -828,24 +1038,12 @@ static int dock_add(acpi_handle handle)
 	}
 	add_dock_dependent_device(dock_station, dd);
 
-	/* register for dock events */
-	status = acpi_install_notify_handler(dock_station->handle,
-					     ACPI_SYSTEM_NOTIFY,
-					     dock_notify, dock_station);
-
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing notify handler\n");
-		ret = -ENODEV;
-		goto dock_add_err;
-	}
-
-	printk(KERN_INFO PREFIX "%s\n", ACPI_DOCK_DRIVER_DESCRIPTION);
-
+	dock_station_count++;
+	list_add(&dock_station->sibiling, &dock_stations);
 	return 0;
 
-dock_add_err:
-	kfree(dd);
 dock_add_err_unregister:
+	device_remove_file(&dock_device->dev, &dev_attr_type);
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);
@@ -859,12 +1057,12 @@ dock_add_err_unregister:
 /**
  * dock_remove - free up resources related to the dock station
  */
-static int dock_remove(void)
+static int dock_remove(struct dock_station *dock_station)
 {
 	struct dock_dependent_device *dd, *tmp;
-	acpi_status status;
+	struct platform_device *dock_device = dock_station->dock_device;
 
-	if (!dock_station)
+	if (!dock_station_count)
 		return 0;
 
 	/* remove dependent devices */
@@ -872,14 +1070,8 @@ static int dock_remove(void)
 				 list)
 	    kfree(dd);
 
-	/* remove dock notify handler */
-	status = acpi_remove_notify_handler(dock_station->handle,
-					    ACPI_SYSTEM_NOTIFY,
-					    dock_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Error removing notify handler\n");
-
 	/* cleanup sysfs */
+	device_remove_file(&dock_device->dev, &dev_attr_type);
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);
@@ -904,41 +1096,60 @@ static int dock_remove(void)
 static acpi_status
 find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	int *count = context;
 	acpi_status status = AE_OK;
 
 	if (is_dock(handle)) {
 		if (dock_add(handle) >= 0) {
-			(*count)++;
 			status = AE_CTRL_TERMINATE;
 		}
 	}
 	return status;
 }
 
-static int __init dock_init(void)
+static acpi_status
+find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	int num = 0;
-
-	dock_station = NULL;
+	/* If bay is a dock, it's already handled */
+	if (is_ejectable_bay(handle) && !is_dock(handle))
+		dock_add(handle);
+	return AE_OK;
+}
 
+static int __init dock_init(void)
+{
 	if (acpi_disabled)
 		return 0;
 
 	/* look for a dock station */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, find_dock, &num, NULL);
+			    ACPI_UINT32_MAX, find_dock, NULL, NULL);
 
-	if (!num)
-		printk(KERN_INFO "No dock devices found.\n");
+	/* look for bay */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, find_bay, NULL, NULL);
+	if (!dock_station_count) {
+		printk(KERN_INFO PREFIX "No dock devices found.\n");
+		return 0;
+	}
 
+	register_acpi_bus_notifier(&dock_acpi_notifier);
+	printk(KERN_INFO PREFIX "%s: %d docks/bays found\n",
+		ACPI_DOCK_DRIVER_DESCRIPTION, dock_station_count);
 	return 0;
 }
 
 static void __exit dock_exit(void)
 {
-	dock_remove();
+	struct dock_station *dock_station;
+
+	unregister_acpi_bus_notifier(&dock_acpi_notifier);
+	list_for_each_entry(dock_station, &dock_stations, sibiling)
+		dock_remove(dock_station);
 }
 
-postcore_initcall(dock_init);
+/*
+ * Must be called before drivers of devices in dock, otherwise we can't know
+ * which devices are in a dock
+ */
+subsys_initcall(dock_init);
 module_exit(dock_exit);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..750e0df 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -682,6 +682,22 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	return;
 }
 
+static void acpi_os_execute_hp_deferred(struct work_struct *work)
+{
+	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
+	if (!dpc) {
+		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
+		return;
+	}
+
+	acpi_os_wait_events_complete(NULL);
+
+	dpc->function(dpc->context);
+	kfree(dpc);
+
+	return;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_os_execute
@@ -697,12 +713,13 @@ static void acpi_os_execute_deferred(struct work_struct *work)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_execute(acpi_execute_type type,
-			    acpi_osd_exec_callback function, void *context)
+static acpi_status __acpi_os_execute(acpi_execute_type type,
+	acpi_osd_exec_callback function, void *context, int hp)
 {
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
+	int ret;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
@@ -726,9 +743,17 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	dpc->function = function;
 	dpc->context = context;
 
-	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	queue = (type == OSL_NOTIFY_HANDLER) ? kacpi_notify_wq : kacpid_wq;
-	if (!queue_work(queue, &dpc->work)) {
+	if (!hp) {
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		queue = (type == OSL_NOTIFY_HANDLER) ?
+			kacpi_notify_wq : kacpid_wq;
+		ret = queue_work(queue, &dpc->work);
+	} else {
+		INIT_WORK(&dpc->work, acpi_os_execute_hp_deferred);
+		ret = schedule_work(&dpc->work);
+	}
+
+	if (!ret) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			  "Call to queue_work() failed.\n"));
 		status = AE_ERROR;
@@ -737,8 +762,19 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	return_ACPI_STATUS(status);
 }
 
+acpi_status acpi_os_execute(acpi_execute_type type,
+			    acpi_osd_exec_callback function, void *context)
+{
+	return __acpi_os_execute(type, function, context, 0);
+}
 EXPORT_SYMBOL(acpi_os_execute);
 
+acpi_status acpi_os_hotplug_execute(acpi_osd_exec_callback function,
+	void *context)
+{
+	return __acpi_os_execute(0, function, context, 1);
+}
+
 void acpi_os_wait_events_complete(void *context)
 {
 	flush_workqueue(kacpid_wq);
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9330b79..c012307 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -120,21 +120,6 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
 }
 
-static void ata_acpi_eject_device(acpi_handle handle)
-{
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = 1;
-
-	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_EJ0",
-					      &arg_list, NULL)))
-		printk(KERN_ERR "Failed to evaluate _EJ0!\n");
-}
-
 /* @ap and @dev are the same as ata_acpi_handle_hotplug() */
 static void ata_acpi_detach_device(struct ata_port *ap, struct ata_device *dev)
 {
@@ -157,7 +142,6 @@ static void ata_acpi_detach_device(struct ata_port *ap, struct ata_device *dev)
  * @ap: ATA port ACPI event occurred
  * @dev: ATA device ACPI event occurred (can be NULL)
  * @event: ACPI event which occurred
- * @is_dock_event: boolean indicating whether the event was a dock one
  *
  * All ACPI bay / device realted events end up in this function.  If
  * the event is port-wide @dev is NULL.  If the event is specific to a
@@ -171,117 +155,100 @@ static void ata_acpi_detach_device(struct ata_port *ap, struct ata_device *dev)
  * ACPI notify handler context.  May sleep.
  */
 static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
-				    u32 event, int is_dock_event)
+				    u32 event)
 {
-	char event_string[12];
-	char *envp[] = { event_string, NULL };
 	struct ata_eh_info *ehi = &ap->link.eh_info;
-	struct kobject *kobj = NULL;
 	int wait = 0;
 	unsigned long flags;
-	acpi_handle handle, tmphandle;
-	unsigned long sta;
-	acpi_status status;
+	acpi_handle handle;
 
-	if (dev) {
-		if (dev->sdev)
-			kobj = &dev->sdev->sdev_gendev.kobj;
+	if (dev)
 		handle = dev->acpi_handle;
-	} else {
-		kobj = &ap->dev->kobj;
+	else
 		handle = ap->acpi_handle;
-	}
-
-	status = acpi_get_handle(handle, "_EJ0", &tmphandle);
-	if (ACPI_FAILURE(status))
-		/* This device does not support hotplug */
-		return;
-
-	if (event == ACPI_NOTIFY_BUS_CHECK ||
-	    event == ACPI_NOTIFY_DEVICE_CHECK)
-		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 
 	spin_lock_irqsave(ap->lock, flags);
-
+	/*
+	 * When dock driver calls into the routine, it will always use
+	 * ACPI_NOTIFY_BUS_CHECK/ACPI_NOTIFY_DEVICE_CHECK for add and
+	 * ACPI_NOTIFY_EJECT_REQUEST for remove
+	 */
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		ata_ehi_push_desc(ehi, "ACPI event");
 
-		if (ACPI_FAILURE(status)) {
-			ata_port_printk(ap, KERN_ERR,
-				"acpi: failed to determine bay status (0x%x)\n",
-				status);
-			break;
-		}
-
-		if (sta) {
-			ata_ehi_hotplugged(ehi);
-			ata_port_freeze(ap);
-		} else {
-			/* The device has gone - unplug it */
-			ata_acpi_detach_device(ap, dev);
-			wait = 1;
-		}
+		ata_ehi_hotplugged(ehi);
+		ata_port_freeze(ap);
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ata_ehi_push_desc(ehi, "ACPI event");
 
-		if (!is_dock_event)
-			break;
-
-		/* undock event - immediate unplug */
 		ata_acpi_detach_device(ap, dev);
 		wait = 1;
 		break;
 	}
 
-	/* make sure kobj doesn't go away while ap->lock is released */
-	kobject_get(kobj);
-
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (wait) {
+	if (wait)
 		ata_port_wait_eh(ap);
-		ata_acpi_eject_device(handle);
-	}
-
-	if (kobj && !is_dock_event) {
-		sprintf(event_string, "BAY_EVENT=%d", event);
-		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
-	}
-
-	kobject_put(kobj);
 }
 
 static void ata_acpi_dev_notify_dock(acpi_handle handle, u32 event, void *data)
 {
 	struct ata_device *dev = data;
 
-	ata_acpi_handle_hotplug(dev->link->ap, dev, event, 1);
+	ata_acpi_handle_hotplug(dev->link->ap, dev, event);
 }
 
 static void ata_acpi_ap_notify_dock(acpi_handle handle, u32 event, void *data)
 {
 	struct ata_port *ap = data;
 
-	ata_acpi_handle_hotplug(ap, NULL, event, 1);
+	ata_acpi_handle_hotplug(ap, NULL, event);
 }
 
-static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
+static void ata_acpi_uevent(struct ata_port *ap, struct ata_device *dev,
+	u32 event)
 {
-	struct ata_device *dev = data;
+	struct kobject *kobj = NULL;
+	char event_string[20];
+	char *envp[] = { event_string, NULL };
+
+	if (dev) {
+		if (dev->sdev)
+			kobj = &dev->sdev->sdev_gendev.kobj;
+	} else
+		kobj = &ap->dev->kobj;
 
-	ata_acpi_handle_hotplug(dev->link->ap, dev, event, 0);
+	if (kobj) {
+		snprintf(event_string, 20, "BAY_EVENT=%d", event);
+		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
+	}
 }
 
-static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
+static void ata_acpi_ap_uevent(acpi_handle handle, u32 event, void *data)
 {
-	struct ata_port *ap = data;
+	ata_acpi_uevent(data, NULL, event);
+}
 
-	ata_acpi_handle_hotplug(ap, NULL, event, 0);
+static void ata_acpi_dev_uevent(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_device *dev = data;
+	ata_acpi_uevent(dev->link->ap, dev, event);
 }
 
+static struct acpi_dock_ops ata_acpi_dev_dock_ops = {
+	.handler = ata_acpi_dev_notify_dock,
+	.uevent = ata_acpi_dev_uevent,
+};
+
+static struct acpi_dock_ops ata_acpi_ap_dock_ops = {
+	.handler = ata_acpi_ap_notify_dock,
+	.uevent = ata_acpi_ap_uevent,
+};
+
 /**
  * ata_acpi_associate - associate ATA host with ACPI objects
  * @host: target ATA host
@@ -315,24 +282,18 @@ void ata_acpi_associate(struct ata_host *host)
 			ata_acpi_associate_ide_port(ap);
 
 		if (ap->acpi_handle) {
-			acpi_install_notify_handler(ap->acpi_handle,
-						    ACPI_SYSTEM_NOTIFY,
-						    ata_acpi_ap_notify, ap);
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
-					     ata_acpi_ap_notify_dock, ap);
+					     &ata_acpi_ap_dock_ops, ap);
 		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
 			struct ata_device *dev = &ap->link.device[j];
 
 			if (dev->acpi_handle) {
-				acpi_install_notify_handler(dev->acpi_handle,
-						ACPI_SYSTEM_NOTIFY,
-						ata_acpi_dev_notify, dev);
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
-					     ata_acpi_dev_notify_dock, dev);
+					     &ata_acpi_dev_dock_ops, dev);
 			}
 		}
 	}
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index a3e4705..db54c5e 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -169,7 +169,9 @@ static int post_dock_fixups(struct notifier_block *nb, unsigned long val,
 }
 
 
-
+static struct acpi_dock_ops acpiphp_dock_ops = {
+	.handler = handle_hotplug_event_func,
+};
 
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
@@ -285,7 +287,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 		 */
 		newfunc->flags &= ~FUNC_HAS_EJ0;
 		if (register_hotplug_dock_device(handle,
-			handle_hotplug_event_func, newfunc))
+			&acpiphp_dock_ops, newfunc))
 			dbg("failed to register dock device\n");
 
 		/* we need to be notified when dock events happen
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a5ac0bc..f74f882 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -327,6 +327,9 @@ int acpi_bus_get_private_data(acpi_handle, void **);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
+
+extern int register_acpi_bus_notifier(struct notifier_block *nb);
+extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
 /*
  * External Functions
  */
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index e5f38e5..4f5042a 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -115,12 +115,17 @@ int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
 /*--------------------------------------------------------------------------
                                   Dock Station
   -------------------------------------------------------------------------- */
+struct acpi_dock_ops {
+	acpi_notify_handler handler;
+	acpi_notify_handler uevent;
+};
+
 #if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
 extern int is_dock_device(acpi_handle handle);
 extern int register_dock_notifier(struct notifier_block *nb);
 extern void unregister_dock_notifier(struct notifier_block *nb);
 extern int register_hotplug_dock_device(acpi_handle handle,
-					acpi_notify_handler handler,
+					struct acpi_dock_ops *ops,
 					void *context);
 extern void unregister_hotplug_dock_device(acpi_handle handle);
 #else
@@ -136,7 +141,7 @@ static inline void unregister_dock_notifier(struct notifier_block *nb)
 {
 }
 static inline int register_hotplug_dock_device(acpi_handle handle,
-					       acpi_notify_handler handler,
+					       struct acpi_dock_ops *ops,
 					       void *context)
 {
 	return -ENODEV;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 3f93a6b..b91440a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -193,6 +193,9 @@ acpi_status
 acpi_os_execute(acpi_execute_type type,
 		acpi_osd_exec_callback function, void *context);
 
+acpi_status
+acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context);
+
 void acpi_os_wait_events_complete(void *context);
 
 void acpi_os_sleep(acpi_integer milliseconds);

--xgyAXRrhYN0wYx8y--
