From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 3/8] makeing dock driver supports bay and battery hotplug
Date: Fri, 06 Jun 2008 13:22:33 +0800
Message-ID: <1212729753.25188.26.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49913 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbYFFFRJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jun 2008 01:17:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

=EF=BB=BFMaking dock driver supports bay and battery hotplug. They are =
all
regarded as dock, and unified handled.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/dock.c |  215 ++++++++++++++++++++++++++++++++++++++++---=
---------
 1 file changed, 166 insertions(+), 49 deletions(-)

Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-06-06 10:29:28.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-06-06 10:57:52.000000000 +0800
@@ -48,7 +48,6 @@ MODULE_PARM_DESC(immediate_undock, "1 (d
 	" before undocking");
=20
 static struct atomic_notifier_head dock_notifier_list;
-static struct platform_device *dock_device;
 static char dock_device_name[] =3D "dock";
=20
 static const struct acpi_device_id dock_device_ids[] =3D {
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
=20
 struct dock_dependent_device {
 	struct list_head list;
@@ -77,11 +81,11 @@ struct dock_dependent_device {
=20
 #define DOCK_DOCKING	0x00000001
 #define DOCK_UNDOCKING  0x00000002
+#define DOCK_IS_DOCK	0x00000010
+#define DOCK_IS_ATA	0x00000020
 #define DOCK_EVENT	3
 #define UNDOCK_EVENT	2
=20
-static struct dock_station *dock_station;
-
 /*********************************************************************=
********
  *                         Dock Dependent device functions            =
       *
  *********************************************************************=
********/
@@ -199,6 +203,60 @@ static int is_dock(acpi_handle handle)
 	return 1;
 }
=20
+static int is_ejectable(acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status =3D acpi_get_handle(handle, "_EJ0", &tmp);
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
+	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
+	int ret =3D 1;
+
+	if (!ACPI_SUCCESS(acpi_get_object_info(handle, &buffer)))
+		return 0;
+	info =3D buffer.pointer;
+	if (!(info->valid & ACPI_VALID_HID))
+		ret =3D 0;
+	else
+		ret =3D !strcmp("PNP0C0A", info->hardware_id.value);
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
=20
-	if (is_dock(handle) || find_dock_dependent_device(dock_station, handl=
e))
+	if (is_dock(handle))
 		return 1;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		if (find_dock_dependent_device(dock_station, handle))
+			return 1;
+	}
=20
 	return 0;
 }
@@ -341,7 +405,7 @@ static void hotplug_dock_devices(struct=20
=20
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
-	struct device *dev =3D &dock_device->dev;
+	struct device *dev =3D &ds->dock_device->dev;
 	char event_string[13];
 	char *envp[] =3D { event_string, NULL };
=20
@@ -414,7 +478,7 @@ static void handle_dock(struct dock_stat
 	arg.type =3D ACPI_TYPE_INTEGER;
 	arg.integer.value =3D dock;
 	status =3D acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffe=
r);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND)
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
=20
 	return atomic_notifier_chain_register(&dock_notifier_list, nb);
@@ -509,7 +573,7 @@ EXPORT_SYMBOL_GPL(register_dock_notifier
  */
 void unregister_dock_notifier(struct notifier_block *nb)
 {
-	if (!dock_station)
+	if (!dock_station_count)
 		return;
=20
 	atomic_notifier_chain_unregister(&dock_notifier_list, nb);
@@ -532,20 +596,23 @@ register_hotplug_dock_device(acpi_handle
 			     void *context)
 {
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
=20
-	if (!dock_station)
+	if (!dock_station_count)
 		return -ENODEV;
=20
 	/*
 	 * make sure this handle is for a device dependent on the dock,
 	 * this would include the dock station itself
 	 */
-	dd =3D find_dock_dependent_device(dock_station, handle);
-	if (dd) {
-		dd->handler =3D handler;
-		dd->context =3D context;
-		dock_add_hotplug_device(dock_station, dd);
-		return 0;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		dd =3D find_dock_dependent_device(dock_station, handle);
+		if (dd) {
+			dd->handler =3D handler;
+			dd->context =3D context;
+			dock_add_hotplug_device(dock_station, dd);
+			return 0;
+		}
 	}
=20
 	return -EINVAL;
@@ -560,13 +627,16 @@ EXPORT_SYMBOL_GPL(register_hotplug_dock_
 void unregister_hotplug_dock_device(acpi_handle handle)
 {
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
=20
-	if (!dock_station)
+	if (!dock_station_count)
 		return;
=20
-	dd =3D find_dock_dependent_device(dock_station, handle);
-	if (dd)
-		dock_del_hotplug_device(dock_station, dd);
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		dd =3D find_dock_dependent_device(dock_station, handle);
+		if (dd)
+			dock_del_hotplug_device(dock_station, dd);
+	}
 }
=20
 EXPORT_SYMBOL_GPL(unregister_hotplug_dock_device);
@@ -579,7 +649,9 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
  */
 static int handle_eject_request(struct dock_station *ds, u32 event)
 {
-	if (!dock_present(ds))
+	struct acpi_device *tmp;
+
+	if (acpi_bus_get_device(ds->handle, &tmp))
 		return -ENODEV;
=20
 	if (dock_in_progress(ds))
@@ -617,9 +689,28 @@ static void dock_notify(acpi_handle hand
 {
 	struct dock_station *ds =3D data;
 	struct acpi_device *tmp;
+	int surprise_removal =3D 0;
+
+	/*
+         * According to acpi spec 3.0a, if a DEVICE_CHECK notification
+	 * is sent and _DCK is present, it is assumed to mean an undock
+	 * request.
+	 */
+	if ((ds->flags & DOCK_IS_DOCK) && event =3D=3D ACPI_NOTIFY_DEVICE_CHE=
CK)
+		event =3D ACPI_NOTIFY_EJECT_REQUEST;
=20
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
+	case ACPI_NOTIFY_DEVICE_CHECK:
 		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle, &tmp)) =
{
 			begin_dock(ds);
 			dock(ds);
@@ -634,20 +725,17 @@ static void dock_notify(acpi_handle hand
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
 			dock_lock(ds, 1);
+			break;
 		}
-		break;
-	case ACPI_NOTIFY_DEVICE_CHECK:
-	/*
-         * According to acpi spec 3.0a, if a DEVICE_CHECK notification
-         * is sent and _DCK is present, it is assumed to mean an
-         * undock request.  This notify routine will only be called
-         * for objects defining _DCK, so we will fall through to eject
-         * request here.  However, we will pass an eject request throu=
gh
-	 * to the driver who wish to hotplug.
-         */
+		if (dock_present(ds) || dock_in_progress(ds))
+			break;
+		/* This is a surprise removal */
+		surprise_removal =3D 1;
+		event =3D ACPI_NOTIFY_EJECT_REQUEST;
+		/* Fall back */
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		begin_undock(ds);
-		if (immediate_undock)
+		if (immediate_undock || surprise_removal)
 			handle_eject_request(ds, event);
 		else
 			dock_event(ds, event, UNDOCK_EVENT);
@@ -703,6 +791,7 @@ fdd_out:
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
+	struct dock_station *dock_station =3D *((struct dock_station **)dev->=
platform_data);
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
=20
 }
@@ -714,6 +803,7 @@ static DEVICE_ATTR(docked, S_IRUGO, show
 static ssize_t show_flags(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
+	struct dock_station *dock_station =3D *((struct dock_station **)dev->=
platform_data);
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
=20
 }
@@ -726,6 +816,7 @@ static ssize_t write_undock(struct devic
 			   const char *buf, size_t count)
 {
 	int ret;
+	struct dock_station *dock_station =3D *((struct dock_station **)dev->=
platform_data);
=20
 	if (!count)
 		return -EINVAL;
@@ -743,6 +834,7 @@ static ssize_t show_dock_uid(struct devi
 			     struct device_attribute *attr, char *buf)
 {
 	unsigned long lbuf;
+	struct dock_station *dock_station =3D *((struct dock_station **)dev->=
platform_data);
 	acpi_status status =3D acpi_evaluate_integer(dock_station->handle,
 					"_UID", NULL, &lbuf);
 	if (ACPI_FAILURE(status))
@@ -764,6 +856,8 @@ static int dock_add(acpi_handle handle)
 	int ret;
 	acpi_status status;
 	struct dock_dependent_device *dd;
+	struct dock_station *dock_station;
+	struct platform_device *dock_device;
=20
 	/* allocate & initialize the dock_station private data */
 	dock_station =3D kzalloc(sizeof(*dock_station), GFP_KERNEL);
@@ -773,22 +867,31 @@ static int dock_add(acpi_handle handle)
 	dock_station->last_dock_time =3D jiffies - HZ;
 	INIT_LIST_HEAD(&dock_station->dependent_devices);
 	INIT_LIST_HEAD(&dock_station->hotplug_devices);
+	INIT_LIST_HEAD(&dock_station->sibiling);
 	spin_lock_init(&dock_station->dd_lock);
 	mutex_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
=20
 	/* initialize platform device stuff */
-	dock_device =3D
-		platform_device_register_simple(dock_device_name, 0, NULL, 0);
+	dock_station->dock_device =3D
+		platform_device_register_simple(dock_device_name,
+			dock_station_count, NULL, 0);
+	dock_device =3D dock_station->dock_device;
 	if (IS_ERR(dock_device)) {
 		kfree(dock_station);
 		dock_station =3D NULL;
 		return PTR_ERR(dock_device);
 	}
+	platform_device_add_data(dock_device, &dock_station, sizeof(struct do=
ck_station *));
=20
 	/* we want the dock device to send uevents */
 	dock_device->dev.uevent_suppress =3D 0;
=20
+	if (is_dock(handle))
+		dock_station->flags |=3D DOCK_IS_DOCK;
+	if (is_ata(handle))
+		dock_station->flags |=3D DOCK_IS_ATA;
+
 	ret =3D device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
@@ -854,8 +957,8 @@ static int dock_add(acpi_handle handle)
 		goto dock_add_err;
 	}
=20
-	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_DESCRIPTION);
-
+	dock_station_count++;
+	list_add(&dock_station->sibiling, &dock_stations);
 	return 0;
=20
 dock_add_err:
@@ -874,12 +977,13 @@ dock_add_err_unregister:
 /**
  * dock_remove - free up resources related to the dock station
  */
-static int dock_remove(void)
+static int dock_remove(struct dock_station *dock_station)
 {
 	struct dock_dependent_device *dd, *tmp;
 	acpi_status status;
+	struct platform_device *dock_device =3D dock_station->dock_device;
=20
-	if (!dock_station)
+	if (!dock_station_count)
 		return 0;
=20
 	/* remove dependent devices */
@@ -919,38 +1023,51 @@ static int dock_remove(void)
 static acpi_status
 find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	int *count =3D context;
 	acpi_status status =3D AE_OK;
=20
 	if (is_dock(handle)) {
 		if (dock_add(handle) >=3D 0) {
-			(*count)++;
 			status =3D AE_CTRL_TERMINATE;
 		}
 	}
 	return status;
 }
=20
-static int __init dock_init(void)
+static acpi_status
+find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	int num =3D 0;
-
-	dock_station =3D NULL;
+	/* If bay is in a dock, it's already handled */
+	if (is_ejectable_bay(handle) && !is_dock_device(handle))
+		dock_add(handle);
+	return AE_OK;
+}
=20
+static int __init dock_init(void)
+{
 	/* look for a dock station */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, find_dock, &num, NULL);
+			    ACPI_UINT32_MAX, find_dock, NULL, NULL);
=20
-	if (!num)
-		printk(KERN_INFO "No dock devices found.\n");
+	/* look for bay */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, find_bay, NULL, NULL);
+	if (!dock_station_count) {
+		printk(KERN_INFO PREFIX "No dock devices found.\n");
+		return 0;
+	}
=20
+	printk(KERN_INFO PREFIX "%s: %d docks/bays found\n",
+		ACPI_DOCK_DRIVER_DESCRIPTION, dock_station_count);
 	return 0;
 }
=20
 static void __exit dock_exit(void)
 {
-	dock_remove();
+	struct dock_station *dock_station;
+
+	list_for_each_entry(dock_station, &dock_stations, sibiling)
+		dock_remove(dock_station);
 }
=20
-postcore_initcall(dock_init);
+subsys_initcall(dock_init);
 module_exit(dock_exit);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
