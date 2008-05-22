From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 3/8] makeing dock driver supports bay and battery hotplug
Date: Thu, 22 May 2008 14:33:11 +0800
Message-ID: <1211437991.25221.38.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20780 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756170AbYEVG2h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 02:28:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>

Making dock driver supports bay and battery hotplug. They are all
regarded as dock, and unified handled. 

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c |  191 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 145 insertions(+), 46 deletions(-)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-05-22 09:28:20.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-05-22 10:01:54.000000000 +0800
@@ -48,7 +48,6 @@ MODULE_PARM_DESC(immediate_undock, "1 (d
 	" before undocking");
 
 static struct atomic_notifier_head dock_notifier_list;
-static struct platform_device *dock_device;
 static char dock_device_name[] = "dock";
 
 static const struct acpi_device_id dock_device_ids[] = {
@@ -65,7 +64,12 @@ struct dock_station {
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
@@ -77,11 +81,11 @@ struct dock_dependent_device {
 
 #define DOCK_DOCKING	0x00000001
 #define DOCK_UNDOCKING  0x00000002
+#define DOCK_IS_DOCK	0x00000010
+#define DOCK_IS_ATA	0x00000020
 #define DOCK_EVENT	3
 #define UNDOCK_EVENT	2
 
-static struct dock_station *dock_station;
-
 /*****************************************************************************
  *                         Dock Dependent device functions                   *
  *****************************************************************************/
@@ -199,6 +203,60 @@ static int is_dock(acpi_handle handle)
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
@@ -209,11 +267,17 @@ static int is_dock(acpi_handle handle)
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
@@ -341,7 +405,7 @@ static void hotplug_dock_devices(struct 
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
-	struct device *dev = &dock_device->dev;
+	struct device *dev = &ds->dock_device->dev;
 	char event_string[13];
 	char *envp[] = { event_string, NULL };
 
@@ -414,7 +478,7 @@ static void handle_dock(struct dock_stat
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = dock;
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
 		printk(KERN_ERR PREFIX "%s - failed to execute _DCK\n",
 			 (char *)name_buffer.pointer);
 	kfree(buffer.pointer);
@@ -495,7 +559,7 @@ static int dock_in_progress(struct dock_
  */
 int register_dock_notifier(struct notifier_block *nb)
 {
-	if (!dock_station)
+	if (!dock_station_count)
 		return -ENODEV;
 
 	return atomic_notifier_chain_register(&dock_notifier_list, nb);
@@ -509,7 +573,7 @@ EXPORT_SYMBOL_GPL(register_dock_notifier
  */
 void unregister_dock_notifier(struct notifier_block *nb)
 {
-	if (!dock_station)
+	if (!dock_station_count)
 		return;
 
 	atomic_notifier_chain_unregister(&dock_notifier_list, nb);
@@ -532,20 +596,23 @@ register_hotplug_dock_device(acpi_handle
 			     void *context)
 {
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
 
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
+		dd = find_dock_dependent_device(dock_station, handle);
+		if (dd) {
+			dd->handler = handler;
+			dd->context = context;
+			dock_add_hotplug_device(dock_station, dd);
+			return 0;
+		}
 	}
 
 	return -EINVAL;
@@ -560,13 +627,16 @@ EXPORT_SYMBOL_GPL(register_hotplug_dock_
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
@@ -617,8 +687,17 @@ static void dock_notify(acpi_handle hand
 	struct dock_station *ds = data;
 	struct acpi_device *tmp;
 
+	/*
+         * According to acpi spec 3.0a, if a DEVICE_CHECK notification
+	 * is sent and _DCK is present, it is assumed to mean an undock
+	 * request.
+	 */
+	if ((ds->flags & DOCK_IS_DOCK) && event == ACPI_NOTIFY_DEVICE_CHECK)
+		event = ACPI_NOTIFY_EJECT_REQUEST;
+
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
+	case ACPI_NOTIFY_DEVICE_CHECK:
 		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle, &tmp)) {
 			begin_dock(ds);
 			dock(ds);
@@ -635,15 +714,6 @@ static void dock_notify(acpi_handle hand
 			dock_lock(ds, 1);
 		}
 		break;
-	case ACPI_NOTIFY_DEVICE_CHECK:
-	/*
-         * According to acpi spec 3.0a, if a DEVICE_CHECK notification
-         * is sent and _DCK is present, it is assumed to mean an
-         * undock request.  This notify routine will only be called
-         * for objects defining _DCK, so we will fall through to eject
-         * request here.  However, we will pass an eject request through
-	 * to the driver who wish to hotplug.
-         */
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		dock_lock(ds, 0);
 		begin_undock(ds);
@@ -703,6 +773,7 @@ fdd_out:
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
+	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
 
 }
@@ -714,6 +785,7 @@ static DEVICE_ATTR(docked, S_IRUGO, show
 static ssize_t show_flags(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
+	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
 
 }
@@ -726,6 +798,7 @@ static ssize_t write_undock(struct devic
 			   const char *buf, size_t count)
 {
 	int ret;
+	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);
 
 	if (!count)
 		return -EINVAL;
@@ -744,6 +817,7 @@ static ssize_t show_dock_uid(struct devi
 			     struct device_attribute *attr, char *buf)
 {
 	unsigned long lbuf;
+	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);
 	acpi_status status = acpi_evaluate_integer(dock_station->handle,
 					"_UID", NULL, &lbuf);
 	if (ACPI_FAILURE(status))
@@ -765,6 +839,8 @@ static int dock_add(acpi_handle handle)
 	int ret;
 	acpi_status status;
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
+	struct platform_device *dock_device;
 
 	/* allocate & initialize the dock_station private data */
 	dock_station = kzalloc(sizeof(*dock_station), GFP_KERNEL);
@@ -774,22 +850,31 @@ static int dock_add(acpi_handle handle)
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
+	platform_device_add_data(dock_device, &dock_station, sizeof(struct dock_station *));
 
 	/* we want the dock device to send uevents */
 	dock_device->dev.uevent_suppress = 0;
 
+	if (is_dock(handle))
+		dock_station->flags |= DOCK_IS_DOCK;
+	if (is_ata(handle))
+		dock_station->flags |= DOCK_IS_ATA;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
@@ -855,8 +940,8 @@ static int dock_add(acpi_handle handle)
 		goto dock_add_err;
 	}
 
-	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_DESCRIPTION);
-
+	dock_station_count++;
+	list_add(&dock_station->sibiling, &dock_stations);
 	return 0;
 
 dock_add_err:
@@ -875,12 +960,13 @@ dock_add_err_unregister:
 /**
  * dock_remove - free up resources related to the dock station
  */
-static int dock_remove(void)
+static int dock_remove(struct dock_station *dock_station)
 {
 	struct dock_dependent_device *dd, *tmp;
 	acpi_status status;
+	struct platform_device *dock_device = dock_station->dock_device;
 
-	if (!dock_station)
+	if (!dock_station_count)
 		return 0;
 
 	/* remove dependent devices */
@@ -920,38 +1006,51 @@ static int dock_remove(void)
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
+	/* If bay is in a dock, it's already handled */
+	if (is_ejectable_bay(handle) && !is_dock_device(handle))
+		dock_add(handle);
+	return AE_OK;
+}
 
+static int __init dock_init(void)
+{
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
 
+	printk(KERN_INFO PREFIX "%s: %d docks/bays found\n",
+		ACPI_DOCK_DRIVER_DESCRIPTION, dock_station_count);
 	return 0;
 }
 
 static void __exit dock_exit(void)
 {
-	dock_remove();
+	struct dock_station *dock_station;
+
+	list_for_each_entry(dock_station, &dock_stations, sibiling)
+		dock_remove(dock_station);
 }
 
-postcore_initcall(dock_init);
+subsys_initcall(dock_init);
 module_exit(dock_exit);


