From: Len Brown <lenb@kernel.org>
Subject: [PATCH 102/103] ACPI: dock: minor whitespace and style cleanups
Date: Wed, 16 Dec 2009 03:36:53 -0500
Message-ID: <747479a3fb42849fe73b9b1f7545d751bde7d632.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761992AbZLPLFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:05:55 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:52 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Removed some stray whitespaces
Added whitespace when needed for legibility
Removed unneeded curly braces
Removed useless void casts
Removed unnecessary local variable initialization
Renamed variables to help out with 80-column fixes

Signed-off-by: Alex Chiang <achiang@hp.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |  103 ++++++++++++++++++++++----------------------------
 1 files changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index cfcd8ee..d4c3d82 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -238,6 +238,7 @@ static int is_battery(acpi_handle handle)
 static int is_ejectable_bay(acpi_handle handle)
 {
 	acpi_handle phandle;
+
 	if (!is_ejectable(handle))
 		return 0;
 	if (is_battery(handle) || is_ata(handle))
@@ -264,14 +265,13 @@ int is_dock_device(acpi_handle handle)
 
 	if (is_dock(handle))
 		return 1;
-	list_for_each_entry(dock_station, &dock_stations, sibling) {
+
+	list_for_each_entry(dock_station, &dock_stations, sibling)
 		if (find_dock_dependent_device(dock_station, handle))
 			return 1;
-	}
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(is_dock_device);
 
 /**
@@ -294,8 +294,6 @@ static int dock_present(struct dock_station *ds)
 	return 0;
 }
 
-
-
 /**
  * dock_create_acpi_device - add new devices to acpi
  * @handle - handle of the device to add
@@ -309,7 +307,7 @@ static int dock_present(struct dock_station *ds)
  */
 static struct acpi_device * dock_create_acpi_device(acpi_handle handle)
 {
-	struct acpi_device *device = NULL;
+	struct acpi_device *device;
 	struct acpi_device *parent_device;
 	acpi_handle parent;
 	int ret;
@@ -326,8 +324,7 @@ static struct acpi_device * dock_create_acpi_device(acpi_handle handle)
 		ret = acpi_bus_add(&device, parent_device, handle,
 			ACPI_BUS_TYPE_DEVICE);
 		if (ret) {
-			pr_debug("error adding bus, %x\n",
-				-ret);
+			pr_debug("error adding bus, %x\n", -ret);
 			return NULL;
 		}
 	}
@@ -353,7 +350,6 @@ static void dock_remove_acpi_device(acpi_handle handle)
 	}
 }
 
-
 /**
  * hotplug_dock_devices - insert or remove devices on the dock station
  * @ds: the dock station
@@ -373,10 +369,9 @@ static void hotplug_dock_devices(struct dock_station *ds, u32 event)
 	/*
 	 * First call driver specific hotplug functions
 	 */
-	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
+	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list)
 		if (dd->ops && dd->ops->handler)
 			dd->ops->handler(dd->handle, event, dd->context);
-	}
 
 	/*
 	 * Now make sure that an acpi_device is created for each
@@ -415,6 +410,7 @@ static void dock_event(struct dock_station *ds, u32 event, int num)
 	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list)
 		if (dd->ops && dd->ops->uevent)
 			dd->ops->uevent(dd->handle, event, dd->context);
+
 	if (num != DOCK_EVENT)
 		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
@@ -445,8 +441,8 @@ static void eject_dock(struct dock_station *ds)
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = 1;
 
-	if (ACPI_FAILURE(acpi_evaluate_object(ds->handle, "_EJ0",
-					      &arg_list, NULL)))
+	status = acpi_evaluate_object(ds->handle, "_EJ0", &arg_list, NULL);
+	if (ACPI_FAILURE(status))
 		pr_debug("Failed to evaluate _EJ0!\n");
 }
 
@@ -566,7 +562,6 @@ int register_dock_notifier(struct notifier_block *nb)
 
 	return atomic_notifier_chain_register(&dock_notifier_list, nb);
 }
-
 EXPORT_SYMBOL_GPL(register_dock_notifier);
 
 /**
@@ -580,7 +575,6 @@ void unregister_dock_notifier(struct notifier_block *nb)
 
 	atomic_notifier_chain_unregister(&dock_notifier_list, nb);
 }
-
 EXPORT_SYMBOL_GPL(unregister_dock_notifier);
 
 /**
@@ -625,7 +619,6 @@ register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(register_hotplug_dock_device);
 
 /**
@@ -646,7 +639,6 @@ void unregister_hotplug_dock_device(acpi_handle handle)
 			dock_del_hotplug_device(dock_station, dd);
 	}
 }
-
 EXPORT_SYMBOL_GPL(unregister_hotplug_dock_device);
 
 /**
@@ -761,7 +753,7 @@ struct dock_data {
 
 static void acpi_dock_deferred_cb(void *context)
 {
-	struct dock_data *data = (struct dock_data *)context;
+	struct dock_data *data = context;
 
 	dock_notify(data->handle, data->event, data->ds);
 	kfree(data);
@@ -771,23 +763,22 @@ static int acpi_dock_notifier_call(struct notifier_block *this,
 	unsigned long event, void *data)
 {
 	struct dock_station *dock_station;
-	acpi_handle handle = (acpi_handle)data;
+	acpi_handle handle = data;
 
 	if (event != ACPI_NOTIFY_BUS_CHECK && event != ACPI_NOTIFY_DEVICE_CHECK
 	   && event != ACPI_NOTIFY_EJECT_REQUEST)
 		return 0;
 	list_for_each_entry(dock_station, &dock_stations, sibling) {
 		if (dock_station->handle == handle) {
-			struct dock_data *dock_data;
+			struct dock_data *dd;
 
-			dock_data = kmalloc(sizeof(*dock_data), GFP_KERNEL);
-			if (!dock_data)
+			dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+			if (!dd)
 				return 0;
-			dock_data->handle = handle;
-			dock_data->event = event;
-			dock_data->ds = dock_station;
-			acpi_os_hotplug_execute(acpi_dock_deferred_cb,
-				dock_data);
+			dd->handle = handle;
+			dd->event = event;
+			dd->ds = dock_station;
+			acpi_os_hotplug_execute(acpi_dock_deferred_cb, dd);
 			return 0 ;
 		}
 	}
@@ -941,28 +932,28 @@ static int dock_add(acpi_handle handle)
 {
 	int ret, id;
 	struct dock_station ds, *dock_station;
-	struct platform_device *dock_device;
+	struct platform_device *dd;
 
 	id = dock_station_count;
-	dock_device =
-		platform_device_register_data(NULL, "dock",
-			id, &ds, sizeof(ds));
-	if (IS_ERR(dock_device))
-		return PTR_ERR(dock_device);
+	dd = platform_device_register_data(NULL, "dock", id, &ds, sizeof(ds));
+	if (IS_ERR(dd))
+		return PTR_ERR(dd);
+
+	dock_station = dd->dev.platform_data;
 
-	dock_station = dock_device->dev.platform_data;
 	dock_station->handle = handle;
-	dock_station->dock_device = dock_device;
+	dock_station->dock_device = dd;
 	dock_station->last_dock_time = jiffies - HZ;
-	INIT_LIST_HEAD(&dock_station->dependent_devices);
-	INIT_LIST_HEAD(&dock_station->hotplug_devices);
-	INIT_LIST_HEAD(&dock_station->sibling);
-	spin_lock_init(&dock_station->dd_lock);
+
 	mutex_init(&dock_station->hp_lock);
+	spin_lock_init(&dock_station->dd_lock);
+	INIT_LIST_HEAD(&dock_station->sibling);
+	INIT_LIST_HEAD(&dock_station->hotplug_devices);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
+	INIT_LIST_HEAD(&dock_station->dependent_devices);
 
 	/* we want the dock device to send uevents */
-	dev_set_uevent_suppress(&dock_device->dev, 0);
+	dev_set_uevent_suppress(&dd->dev, 0);
 
 	if (is_dock(handle))
 		dock_station->flags |= DOCK_IS_DOCK;
@@ -971,14 +962,13 @@ static int dock_add(acpi_handle handle)
 	if (is_battery(handle))
 		dock_station->flags |= DOCK_IS_BAT;
 
-	ret = sysfs_create_group(&dock_device->dev.kobj, &dock_attribute_group);
+	ret = sysfs_create_group(&dd->dev.kobj, &dock_attribute_group);
 	if (ret)
 		goto err_unregister;
 
 	/* Find dependent devices */
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, find_dock_devices, dock_station,
-			    NULL);
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+			    find_dock_devices, dock_station, NULL);
 
 	/* add the dock station as a device dependent on itself */
 	ret = add_dock_dependent_device(dock_station, handle);
@@ -990,9 +980,9 @@ static int dock_add(acpi_handle handle)
 	return 0;
 
 err_rmgroup:
-	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
+	sysfs_remove_group(&dd->dev.kobj, &dock_attribute_group);
 err_unregister:
-	platform_device_unregister(dock_device);
+	platform_device_unregister(dd);
 	printk(KERN_ERR "%s encountered error %d\n", __func__, ret);
 	return ret;
 }
@@ -1000,20 +990,19 @@ err_unregister:
 /**
  * dock_remove - free up resources related to the dock station
  */
-static int dock_remove(struct dock_station *dock_station)
+static int dock_remove(struct dock_station *ds)
 {
 	struct dock_dependent_device *dd, *tmp;
-	struct platform_device *dock_device = dock_station->dock_device;
+	struct platform_device *dock_device = ds->dock_device;
 
 	if (!dock_station_count)
 		return 0;
 
 	/* remove dependent devices */
-	list_for_each_entry_safe(dd, tmp, &dock_station->dependent_devices,
-				 list)
-	    kfree(dd);
+	list_for_each_entry_safe(dd, tmp, &ds->dependent_devices, list)
+		kfree(dd);
 
-	list_del(&dock_station->sibling);
+	list_del(&ds->sibling);
 
 	/* cleanup sysfs */
 	sysfs_remove_group(&dock_device->dev.kobj, &dock_attribute_group);
@@ -1036,11 +1025,10 @@ find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status = AE_OK;
 
-	if (is_dock(handle)) {
-		if (dock_add(handle) >= 0) {
+	if (is_dock(handle))
+		if (dock_add(handle) >= 0)
 			status = AE_CTRL_TERMINATE;
-		}
-	}
+
 	return status;
 }
 
@@ -1078,8 +1066,7 @@ static int __init dock_init(void)
 
 static void __exit dock_exit(void)
 {
-	struct dock_station *dock_station;
-	struct dock_station *tmp;
+	struct dock_station *tmp, *dock_station;
 
 	unregister_acpi_bus_notifier(&dock_acpi_notifier);
 	list_for_each_entry_safe(dock_station, tmp, &dock_stations, sibling)
-- 
1.6.0.6

