From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 7/11]libata hotplug to align with dock driver
Date: Thu, 28 Aug 2008 10:05:45 +0800
Message-ID: <1219889145.29375.37.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4167 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbYH1B4B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 21:56:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

dock driver can handle ata(bay) hotplug now. dock driver already handles
_EJ0 and _STA, so remove them. Also libata doesn't need register
notification handler anymore. 

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---
 drivers/acpi/dock.c       |    3 -
 drivers/ata/libata-acpi.c |  107 ++++++----------------------------------------
 2 files changed, 16 insertions(+), 94 deletions(-)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-28 09:44:52.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-28 09:46:12.000000000 +0800
@@ -738,7 +738,8 @@ static void dock_notify(acpi_handle hand
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
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2008-08-28 09:32:33.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2008-08-28 09:46:12.000000000 +0800
@@ -120,21 +120,6 @@ static void ata_acpi_associate_ide_port(
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
@@ -157,7 +142,6 @@ static void ata_acpi_detach_device(struc
  * @ap: ATA port ACPI event occurred
  * @dev: ATA device ACPI event occurred (can be NULL)
  * @event: ACPI event which occurred
- * @is_dock_event: boolean indicating whether the event was a dock one
  *
  * All ACPI bay / device realted events end up in this function.  If
  * the event is port-wide @dev is NULL.  If the event is specific to a
@@ -171,115 +155,58 @@ static void ata_acpi_detach_device(struc
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
-}
-
-static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
-{
-	struct ata_device *dev = data;
-
-	ata_acpi_handle_hotplug(dev->link->ap, dev, event, 0);
-}
-
-static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
-{
-	struct ata_port *ap = data;
-
-	ata_acpi_handle_hotplug(ap, NULL, event, 0);
+	ata_acpi_handle_hotplug(ap, NULL, event);
 }
 
 /**
@@ -315,9 +242,6 @@ void ata_acpi_associate(struct ata_host 
 			ata_acpi_associate_ide_port(ap);
 
 		if (ap->acpi_handle) {
-			acpi_install_notify_handler(ap->acpi_handle,
-						    ACPI_SYSTEM_NOTIFY,
-						    ata_acpi_ap_notify, ap);
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
 					     ata_acpi_ap_notify_dock, ap);
@@ -327,9 +251,6 @@ void ata_acpi_associate(struct ata_host 
 			struct ata_device *dev = &ap->link.device[j];
 
 			if (dev->acpi_handle) {
-				acpi_install_notify_handler(dev->acpi_handle,
-						ACPI_SYSTEM_NOTIFY,
-						ata_acpi_dev_notify, dev);
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
 					     ata_acpi_dev_notify_dock, dev);


