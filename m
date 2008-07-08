From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 7/10]introduce .uevent for devices in dock
Date: Tue, 08 Jul 2008 13:50:51 +0800
Message-ID: <1215496251.17826.41.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55524 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbYGHFnp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 01:43:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

=EF=BB=BF=EF=BB=BFdock's uevent reported itself, not ata. It might be d=
ifficult to find an
ata device just according to a dock. This patch introduces docking ops
for each device in a dock. when docking, dock driver can send device
specific uevent. This should help dock station too (not just bay)=20

Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/dock.c                |   22 ++++++++++++------
 drivers/ata/libata-acpi.c          |   44 ++++++++++++++++++++++++++++=
+++++++--
 drivers/pci/hotplug/acpiphp_glue.c |    6 +++--
 include/acpi/acpi_drivers.h        |    9 +++++--
 4 files changed, 68 insertions(+), 13 deletions(-)

Index: linux/include/acpi/acpi_drivers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/acpi/acpi_drivers.h	2008-06-30 16:03:12.00000000=
0 +0800
+++ linux/include/acpi/acpi_drivers.h	2008-07-07 11:50:34.000000000 +08=
00
@@ -113,12 +113,17 @@ int acpi_processor_set_thermal_limit(acp
 /*--------------------------------------------------------------------=
------
                                   Dock Station
   --------------------------------------------------------------------=
------ */
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
@@ -134,7 +139,7 @@ static inline void unregister_dock_notif
 {
 }
 static inline int register_hotplug_dock_device(acpi_handle handle,
-					       acpi_notify_handler handler,
+					       struct acpi_dock_ops *ops,
 					       void *context)
 {
 	return -ENODEV;
Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-07-07 11:50:29.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-07-07 11:50:34.000000000 +0800
@@ -75,7 +75,7 @@ struct dock_dependent_device {
 	struct list_head list;
 	struct list_head hotplug_list;
 	acpi_handle handle;
-	acpi_notify_handler handler;
+	struct acpi_dock_ops *ops;
 	void *context;
 };
=20
@@ -385,8 +385,8 @@ static void hotplug_dock_devices(struct=20
 	 * First call driver specific hotplug functions
 	 */
 	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
-		if (dd->handler)
-			dd->handler(dd->handle, event, dd->context);
+		if (dd->ops && dd->ops->handler)
+			dd->ops->handler(dd->handle, event, dd->context);
 	}
=20
 	/*
@@ -409,6 +409,7 @@ static void dock_event(struct dock_stati
 	struct device *dev =3D &ds->dock_device->dev;
 	char event_string[13];
 	char *envp[] =3D { event_string, NULL };
+	struct dock_dependent_device *dd;
=20
 	if (num =3D=3D UNDOCK_EVENT)
 		sprintf(event_string, "EVENT=3Dundock");
@@ -419,7 +420,14 @@ static void dock_event(struct dock_stati
 	 * Indicate that the status of the dock station has
 	 * changed.
 	 */
-	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+	if (num =3D=3D DOCK_EVENT)
+		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+
+	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list)
+		if (dd->ops && dd->ops->uevent)
+			dd->ops->uevent(dd->handle, event, dd->context);
+	if (num !=3D DOCK_EVENT)
+		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
=20
 /**
@@ -585,7 +593,7 @@ EXPORT_SYMBOL_GPL(unregister_dock_notifi
 /**
  * register_hotplug_dock_device - register a hotplug function
  * @handle: the handle of the device
- * @handler: the acpi_notifier_handler to call after docking
+ * @ops: handlers to call after docking
  * @context: device specific data
  *
  * If a driver would like to perform a hotplug operation after a dock
@@ -593,7 +601,7 @@ EXPORT_SYMBOL_GPL(unregister_dock_notifi
  * the dock driver after _DCK is executed.
  */
 int
-register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler h=
andler,
+register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops =
*ops,
 			     void *context)
 {
 	struct dock_dependent_device *dd;
@@ -609,7 +617,7 @@ register_hotplug_dock_device(acpi_handle
 	list_for_each_entry(dock_station, &dock_stations, sibiling) {
 		dd =3D find_dock_dependent_device(dock_station, handle);
 		if (dd) {
-			dd->handler =3D handler;
+			dd->ops =3D ops;
 			dd->context =3D context;
 			dock_add_hotplug_device(dock_station, dd);
 			return 0;
Index: linux/drivers/pci/hotplug/acpiphp_glue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/pci/hotplug/acpiphp_glue.c	2008-07-07 09:20:10.0=
00000000 +0800
+++ linux/drivers/pci/hotplug/acpiphp_glue.c	2008-07-07 11:50:34.000000=
000 +0800
@@ -169,7 +169,9 @@ static int post_dock_fixups(struct notif
 }
=20

-
+static struct acpi_dock_ops acpiphp_dock_ops =3D {
+	.handler =3D handle_hotplug_event_func,
+};
=20
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
@@ -280,7 +282,7 @@ register_slot(acpi_handle handle, u32 lv
 		 */
 		newfunc->flags &=3D ~FUNC_HAS_EJ0;
 		if (register_hotplug_dock_device(handle,
-			handle_hotplug_event_func, newfunc))
+			&acpiphp_dock_ops, newfunc))
 			dbg("failed to register dock device\n");
=20
 		/* we need to be notified when dock events happen
Index: linux/drivers/ata/libata-acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/ata/libata-acpi.c	2008-07-07 11:50:29.000000000 =
+0800
+++ linux/drivers/ata/libata-acpi.c	2008-07-07 11:50:34.000000000 +0800
@@ -206,6 +206,46 @@ static void ata_acpi_ap_notify_dock(acpi
 	ata_acpi_handle_hotplug(ap, NULL, event);
 }
=20
+static void ata_acpi_uevent(struct ata_port *ap, struct ata_device *de=
v,
+	u32 event)
+{
+	struct kobject *kobj =3D NULL;
+	char event_string[12];
+	char *envp[] =3D { event_string, NULL };
+
+	if (dev) {
+		if (dev->sdev)
+			kobj =3D &dev->sdev->sdev_gendev.kobj;
+	} else
+		kobj =3D &ap->dev->kobj;
+
+	if (kobj) {
+		sprintf(event_string, "BAY_EVENT=3D%d", event);
+		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+static void ata_acpi_ap_uevent(acpi_handle handle, u32 event, void *da=
ta)
+{
+	ata_acpi_uevent(data, NULL, event);
+}
+
+static void ata_acpi_dev_uevent(acpi_handle handle, u32 event, void *d=
ata)
+{
+	struct ata_device *dev =3D data;
+	ata_acpi_uevent(dev->link->ap, dev, event);
+}
+
+static struct acpi_dock_ops ata_acpi_dev_dock_ops =3D {
+	.handler =3D ata_acpi_dev_notify_dock,
+	.uevent =3D ata_acpi_dev_uevent,
+};
+
+static struct acpi_dock_ops ata_acpi_ap_dock_ops =3D {
+	.handler =3D ata_acpi_ap_notify_dock,
+	.uevent =3D ata_acpi_ap_uevent,
+};
+
 /**
  * ata_acpi_associate - associate ATA host with ACPI objects
  * @host: target ATA host
@@ -241,7 +281,7 @@ void ata_acpi_associate(struct ata_host=20
 		if (ap->acpi_handle) {
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
-					     ata_acpi_ap_notify_dock, ap);
+					     &ata_acpi_ap_dock_ops, ap);
 		}
=20
 		for (j =3D 0; j < ata_link_max_devices(&ap->link); j++) {
@@ -250,7 +290,7 @@ void ata_acpi_associate(struct ata_host=20
 			if (dev->acpi_handle) {
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
-					     ata_acpi_dev_notify_dock, dev);
+					     &ata_acpi_dev_dock_ops, dev);
 			}
 		}
 	}


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
