From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 6/8] libata hotplug to align with dock driver
Date: Thu, 22 May 2008 14:34:10 +0800
Message-ID: <1211438050.25221.44.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20932 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbYEVG3e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 02:29:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>

dock driver can handle ata(bay) hotplug now. dock driver already handles
_EJ0 and _STA, so remove them. Also libata doesn't need register
notification handler anymore. 

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c       |    2 -
 drivers/ata/libata-acpi.c |   57 +++++++++++++---------------------------------
 2 files changed, 18 insertions(+), 41 deletions(-)

Index: linux/drivers/ata/libata-acpi.c
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2008-05-22 10:54:32.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2008-05-22 14:09:13.000000000 +0800
@@ -127,9 +127,7 @@ static void ata_acpi_handle_hotplug(stru
 	struct kobject *kobj = NULL;
 	int wait = 0;
 	unsigned long flags;
-	acpi_handle handle, tmphandle;
-	unsigned long sta;
-	acpi_status status;
+	acpi_handle handle;
 
 	if (!ap)
 		ap = dev->link->ap;
@@ -142,45 +140,30 @@ static void ata_acpi_handle_hotplug(stru
 	else
 		handle = ap->acpi_handle;
 
-	status = acpi_get_handle(handle, "_EJ0", &tmphandle);
-	if (ACPI_FAILURE(status)) {
-		/* This device is not ejectable */
-		spin_unlock_irqrestore(ap->lock, flags);
-		return;
-	}
-
-	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status)) {
-		printk ("Unable to determine bay status\n");
-		spin_unlock_irqrestore(ap->lock, flags);
-		return;
-	}
-
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		ata_ehi_push_desc(ehi, "ACPI event");
-		if (!sta) {
+		ata_ehi_hotplugged(ehi);
+		ata_port_freeze(ap);
+		break;
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		ata_ehi_push_desc(ehi, "ACPI event");
                 /* Device has been unplugged */
-			if (dev)
-				dev->flags |= ATA_DFLAG_DETACH;
-			else {
-				struct ata_link *tlink;
-				struct ata_device *tdev;
-
-				ata_port_for_each_link(tlink, ap) {
-					ata_link_for_each_dev(tdev, tlink) {
-						tdev->flags |=
-							ATA_DFLAG_DETACH;
-					}
+		if (dev)
+			dev->flags |= ATA_DFLAG_DETACH;
+		else {
+			struct ata_link *tlink;
+			struct ata_device *tdev;
+
+			ata_port_for_each_link(tlink, ap) {
+				ata_link_for_each_dev(tdev, tlink) {
+					tdev->flags |= ATA_DFLAG_DETACH;
 				}
 			}
-			ata_port_schedule_eh(ap);
-			wait = 1;
-		} else {
-			ata_ehi_hotplugged(ehi);
-			ata_port_freeze(ap);
 		}
+		ata_port_schedule_eh(ap);
+		wait = 1;
 	}
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -247,9 +230,6 @@ void ata_acpi_associate(struct ata_host 
 			ata_acpi_associate_ide_port(ap);
 
 		if (ap->acpi_handle) {
-			acpi_install_notify_handler(ap->acpi_handle,
-						    ACPI_SYSTEM_NOTIFY,
-						    ata_acpi_ap_notify, ap);
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
 						     ata_acpi_ap_notify, ap);
@@ -259,9 +239,6 @@ void ata_acpi_associate(struct ata_host 
 			struct ata_device *dev = &ap->link.device[j];
 
 			if (dev->acpi_handle) {
-				acpi_install_notify_handler(dev->acpi_handle,
-						ACPI_SYSTEM_NOTIFY,
-						ata_acpi_dev_notify, dev);
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
 						ata_acpi_dev_notify, dev);
Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-05-22 10:58:08.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-05-22 14:08:37.000000000 +0800
@@ -717,7 +717,7 @@ static void dock_notify(acpi_handle hand
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		dock_lock(ds, 0);
 		begin_undock(ds);
-		if (immediate_undock)
+		if (immediate_undock && !(ds->flags & DOCK_IS_ATA))
 			handle_eject_request(ds, event);
 		else
 			dock_event(ds, event, UNDOCK_EVENT);


