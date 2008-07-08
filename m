From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 6/10] libata hotplug to align with dock driver
Date: Tue, 08 Jul 2008 13:50:46 +0800
Message-ID: <1215496246.17826.40.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29528 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYGHFnk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 01:43:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

=EF=BB=BF=EF=BB=BFdock driver can handle ata(bay) hotplug now. dock dri=
ver already handles
_EJ0 and _STA, so remove them. Also libata doesn't need register
notification handler anymore.=20

Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/dock.c       |    3 -
 drivers/ata/libata-acpi.c |  105 ++++++-------------------------------=
---------
 2 files changed, 16 insertions(+), 92 deletions(-)

Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-07-07 11:50:23.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-07-07 11:50:29.000000000 +0800
@@ -736,7 +736,8 @@ static void dock_notify(acpi_handle hand
 		/* Fall back */
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		begin_undock(ds);
-		if (immediate_undock || surprise_removal)
+		if ((immediate_undock && !(ds->flags & DOCK_IS_ATA))
+		   || surprise_removal)
 			handle_eject_request(ds, event);
 		else
 			dock_event(ds, event, UNDOCK_EVENT);
Index: linux/drivers/ata/libata-acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/ata/libata-acpi.c	2008-06-30 16:03:09.000000000 =
+0800
+++ linux/drivers/ata/libata-acpi.c	2008-07-07 11:50:29.000000000 +0800
@@ -118,21 +118,6 @@ static void ata_acpi_associate_ide_port(
 		ap->pflags |=3D ATA_PFLAG_INIT_GTM_VALID;
 }
=20
-static void ata_acpi_eject_device(acpi_handle handle)
-{
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-
-	arg_list.count =3D 1;
-	arg_list.pointer =3D &arg;
-	arg.type =3D ACPI_TYPE_INTEGER;
-	arg.integer.value =3D 1;
-
-	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_EJ0",
-					      &arg_list, NULL)))
-		printk(KERN_ERR "Failed to evaluate _EJ0!\n");
-}
-
 /* @ap and @dev are the same as ata_acpi_handle_hotplug() */
 static void ata_acpi_detach_device(struct ata_port *ap, struct ata_dev=
ice *dev)
 {
@@ -155,7 +140,6 @@ static void ata_acpi_detach_device(struc
  * @ap: ATA port ACPI event occurred
  * @dev: ATA device ACPI event occurred (can be NULL)
  * @event: ACPI event which occurred
- * @is_dock_event: boolean indicating whether the event was a dock one
  *
  * All ACPI bay / device realted events end up in this function.  If
  * the event is port-wide @dev is NULL.  If the event is specific to a
@@ -169,112 +153,57 @@ static void ata_acpi_detach_device(struc
  * ACPI notify handler context.  May sleep.
  */
 static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_de=
vice *dev,
-				    u32 event, int is_dock_event)
+				    u32 event)
 {
-	char event_string[12];
-	char *envp[] =3D { event_string, NULL };
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
-	struct kobject *kobj =3D NULL;
 	int wait =3D 0;
 	unsigned long flags;
-	acpi_handle handle, tmphandle;
-	unsigned long sta;
-	acpi_status status;
+	acpi_handle handle;
=20
-	if (dev) {
-		if (dev->sdev)
-			kobj =3D &dev->sdev->sdev_gendev.kobj;
+	if (dev)
 		handle =3D dev->acpi_handle;
-	} else {
-		kobj =3D &ap->dev->kobj;
+	else
 		handle =3D ap->acpi_handle;
-	}
-
-	status =3D acpi_get_handle(handle, "_EJ0", &tmphandle);
-	if (ACPI_FAILURE(status))
-		/* This device does not support hotplug */
-		return;
=20
 	spin_lock_irqsave(ap->lock, flags);
=20
+	/*
+	 * When dock driver calls into the routine, it will always use
+	 * ACPI_NOTIFY_BUS_CHECK/ACPI_NOTIFY_DEVICE_CHECK for add and
+	 * ACPI_NOTIFY_EJECT_REQUEST for remove
+	 */
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		ata_ehi_push_desc(ehi, "ACPI event");
-
-		status =3D acpi_evaluate_integer(handle, "_STA", NULL, &sta);
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
-			wait =3D 1;
-		}
+		ata_ehi_hotplugged(ehi);
+		ata_port_freeze(ap);
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ata_ehi_push_desc(ehi, "ACPI event");
-
-		if (!is_dock_event)
-			break;
-
-		/* undock event - immediate unplug */
 		ata_acpi_detach_device(ap, dev);
 		wait =3D 1;
 		break;
 	}
=20
-	/* make sure kobj doesn't go away while ap->lock is released */
-	kobject_get(kobj);
-
 	spin_unlock_irqrestore(ap->lock, flags);
=20
-	if (wait) {
+	if (wait)
 		ata_port_wait_eh(ap);
-		ata_acpi_eject_device(handle);
-	}
-
-	if (kobj && !is_dock_event) {
-		sprintf(event_string, "BAY_EVENT=3D%d", event);
-		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
-	}
-
-	kobject_put(kobj);
 }
=20
 static void ata_acpi_dev_notify_dock(acpi_handle handle, u32 event, vo=
id *data)
 {
 	struct ata_device *dev =3D data;
=20
-	ata_acpi_handle_hotplug(dev->link->ap, dev, event, 1);
+	ata_acpi_handle_hotplug(dev->link->ap, dev, event);
 }
=20
 static void ata_acpi_ap_notify_dock(acpi_handle handle, u32 event, voi=
d *data)
 {
 	struct ata_port *ap =3D data;
=20
-	ata_acpi_handle_hotplug(ap, NULL, event, 1);
-}
-
-static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *d=
ata)
-{
-	struct ata_device *dev =3D data;
-
-	ata_acpi_handle_hotplug(dev->link->ap, dev, event, 0);
-}
-
-static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *da=
ta)
-{
-	struct ata_port *ap =3D data;
-
-	ata_acpi_handle_hotplug(ap, NULL, event, 0);
+	ata_acpi_handle_hotplug(ap, NULL, event);
 }
=20
 /**
@@ -310,9 +239,6 @@ void ata_acpi_associate(struct ata_host=20
 			ata_acpi_associate_ide_port(ap);
=20
 		if (ap->acpi_handle) {
-			acpi_install_notify_handler(ap->acpi_handle,
-						    ACPI_SYSTEM_NOTIFY,
-						    ata_acpi_ap_notify, ap);
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
 					     ata_acpi_ap_notify_dock, ap);
@@ -322,9 +248,6 @@ void ata_acpi_associate(struct ata_host=20
 			struct ata_device *dev =3D &ap->link.device[j];
=20
 			if (dev->acpi_handle) {
-				acpi_install_notify_handler(dev->acpi_handle,
-						ACPI_SYSTEM_NOTIFY,
-						ata_acpi_dev_notify, dev);
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
 					     ata_acpi_dev_notify_dock, dev);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
