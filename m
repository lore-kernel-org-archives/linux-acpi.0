From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 4/8] FIx duplicate notification handler register
Date: Fri, 06 Jun 2008 13:22:44 +0800
Message-ID: <1212729764.25188.27.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2965 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbYFFFRU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jun 2008 01:17:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

=EF=BB=BFBattery driver already registers notification handler. To avoi=
d register
notification handler again, the patch introduced a notifier chain in
global system notifier handler and use it in dock driver, so we can
avoid register notification handler.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/bus.c      |   15 +++++++++++++++
 drivers/acpi/dock.c     |   46 ++++++++++++++++++++++++---------------=
-------
 include/acpi/acpi_bus.h |    3 +++
 3 files changed, 42 insertions(+), 22 deletions(-)

Index: linux/drivers/acpi/bus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/bus.c	2008-06-06 10:57:52.000000000 +0800
+++ linux/drivers/acpi/bus.c	2008-06-06 10:57:59.000000000 +0800
@@ -474,6 +474,19 @@ static int acpi_bus_check_scope(struct a
 	return 0;
 }
=20
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
@@ -484,6 +497,8 @@ static void acpi_bus_notify(acpi_handle=20
 	int result =3D 0;
 	struct acpi_device *device =3D NULL;
=20
+	blocking_notifier_call_chain(&acpi_bus_notify_list,
+		type, (void *)handle);
=20
 	if (acpi_bus_get_device(handle, &device))
 		return;
Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-06-06 10:57:52.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-06-06 10:57:59.000000000 +0800
@@ -745,6 +745,28 @@ static void dock_notify(acpi_handle hand
 	}
 }
=20
+static int acpi_dock_notifier_call(struct notifier_block *this,
+	unsigned long event, void *data)
+{
+	struct dock_station *dock_station;
+	acpi_handle handle =3D (acpi_handle)data;
+
+	if (event !=3D ACPI_NOTIFY_BUS_CHECK && event !=3D ACPI_NOTIFY_DEVICE=
_CHECK
+	   && event !=3D ACPI_NOTIFY_EJECT_REQUEST)
+		return 0;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		if (dock_station->handle =3D=3D handle) {
+			dock_notify(handle, event, dock_station);
+			return 0 ;
+		}
+	}
+	return 0;
+}
+
+static struct notifier_block dock_acpi_notifier =3D {
+	.notifier_call =3D acpi_dock_notifier_call,
+};
+
 /**
  * find_dock_devices - find devices on the dock station
  * @handle: the handle of the device we are examining
@@ -854,7 +876,6 @@ static DEVICE_ATTR(uid, S_IRUGO, show_do
 static int dock_add(acpi_handle handle)
 {
 	int ret;
-	acpi_status status;
 	struct dock_dependent_device *dd;
 	struct dock_station *dock_station;
 	struct platform_device *dock_device;
@@ -946,23 +967,10 @@ static int dock_add(acpi_handle handle)
 	}
 	add_dock_dependent_device(dock_station, dd);
=20
-	/* register for dock events */
-	status =3D acpi_install_notify_handler(dock_station->handle,
-					     ACPI_SYSTEM_NOTIFY,
-					     dock_notify, dock_station);
-
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing notify handler\n");
-		ret =3D -ENODEV;
-		goto dock_add_err;
-	}
-
 	dock_station_count++;
 	list_add(&dock_station->sibiling, &dock_stations);
 	return 0;
=20
-dock_add_err:
-	kfree(dd);
 dock_add_err_unregister:
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
@@ -980,7 +988,6 @@ dock_add_err_unregister:
 static int dock_remove(struct dock_station *dock_station)
 {
 	struct dock_dependent_device *dd, *tmp;
-	acpi_status status;
 	struct platform_device *dock_device =3D dock_station->dock_device;
=20
 	if (!dock_station_count)
@@ -991,13 +998,6 @@ static int dock_remove(struct dock_stati
 				 list)
 	    kfree(dd);
=20
-	/* remove dock notify handler */
-	status =3D acpi_remove_notify_handler(dock_station->handle,
-					    ACPI_SYSTEM_NOTIFY,
-					    dock_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Error removing notify handler\n");
-
 	/* cleanup sysfs */
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
@@ -1056,6 +1056,7 @@ static int __init dock_init(void)
 		return 0;
 	}
=20
+	register_acpi_bus_notifier(&dock_acpi_notifier);
 	printk(KERN_INFO PREFIX "%s: %d docks/bays found\n",
 		ACPI_DOCK_DRIVER_DESCRIPTION, dock_station_count);
 	return 0;
@@ -1065,6 +1066,7 @@ static void __exit dock_exit(void)
 {
 	struct dock_station *dock_station;
=20
+	unregister_acpi_bus_notifier(&dock_acpi_notifier);
 	list_for_each_entry(dock_station, &dock_stations, sibiling)
 		dock_remove(dock_station);
 }
Index: linux/include/acpi/acpi_bus.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/acpi/acpi_bus.h	2008-06-06 10:57:52.000000000 +0=
800
+++ linux/include/acpi/acpi_bus.h	2008-06-06 10:57:59.000000000 +0800
@@ -326,6 +326,9 @@ int acpi_bus_get_private_data(acpi_handl
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
+
+extern int register_acpi_bus_notifier(struct notifier_block *nb);
+extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
 /*
  * External Functions
  */


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
