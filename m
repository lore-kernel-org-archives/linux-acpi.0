From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 8/11]introduce .uevent for devices in dock
Date: Wed, 27 Aug 2008 11:14:53 +0800
Message-ID: <1219806893.32665.64.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3093 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbYH0DFM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 23:05:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

dock's uevent reported itself, not ata. It might be difficult to find an
ata device just according to a dock. This patch introduces docking ops
for each device in a dock. when docking, dock driver can send device
specific uevent. This should help dock station too (not just bay) 

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---
 drivers/acpi/dock.c                |   22 ++++++++++++------
 drivers/ata/libata-acpi.c          |   44 +++++++++++++++++++++++++++++++++++--
 drivers/pci/hotplug/acpiphp_glue.c |    6 +++--
 include/acpi/acpi_drivers.h        |    9 +++++--
 4 files changed, 68 insertions(+), 13 deletions(-)

Index: linux/include/acpi/acpi_drivers.h
===================================================================
--- linux.orig/include/acpi/acpi_drivers.h	2008-08-27 10:18:38.000000000 +0800
+++ linux/include/acpi/acpi_drivers.h	2008-08-27 10:22:24.000000000 +0800
@@ -116,12 +116,17 @@ int acpi_processor_set_thermal_limit(acp
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
@@ -137,7 +142,7 @@ static inline void unregister_dock_notif
 {
 }
 static inline int register_hotplug_dock_device(acpi_handle handle,
-					       acpi_notify_handler handler,
+					       struct acpi_dock_ops *ops,
 					       void *context)
 {
 	return -ENODEV;
Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-27 10:22:21.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-27 10:22:24.000000000 +0800
@@ -75,7 +75,7 @@ struct dock_dependent_device {
 	struct list_head list;
 	struct list_head hotplug_list;
 	acpi_handle handle;
-	acpi_notify_handler handler;
+	struct acpi_dock_ops *ops;
 	void *context;
 };
 
@@ -385,8 +385,8 @@ static void hotplug_dock_devices(struct 
 	 * First call driver specific hotplug functions
 	 */
 	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
-		if (dd->handler)
-			dd->handler(dd->handle, event, dd->context);
+		if (dd->ops && dd->ops->handler)
+			dd->ops->handler(dd->handle, event, dd->context);
 	}
 
 	/*
@@ -409,6 +409,7 @@ static void dock_event(struct dock_stati
 	struct device *dev = &ds->dock_device->dev;
 	char event_string[13];
 	char *envp[] = { event_string, NULL };
+	struct dock_dependent_device *dd;
 
 	if (num == UNDOCK_EVENT)
 		sprintf(event_string, "EVENT=undock");
@@ -419,7 +420,14 @@ static void dock_event(struct dock_stati
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
-register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler handler,
+register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 			     void *context)
 {
 	struct dock_dependent_device *dd;
@@ -609,7 +617,7 @@ register_hotplug_dock_device(acpi_handle
 	list_for_each_entry(dock_station, &dock_stations, sibiling) {
 		dd = find_dock_dependent_device(dock_station, handle);
 		if (dd) {
-			dd->handler = handler;
+			dd->ops = ops;
 			dd->context = context;
 			dock_add_hotplug_device(dock_station, dd);
 			return 0;
Index: linux/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux.orig/drivers/pci/hotplug/acpiphp_glue.c	2008-08-27 10:18:38.000000000 +0800
+++ linux/drivers/pci/hotplug/acpiphp_glue.c	2008-08-27 10:22:24.000000000 +0800
@@ -169,7 +169,9 @@ static int post_dock_fixups(struct notif
 }
 
 
-
+static struct acpi_dock_ops acpiphp_dock_ops = {
+	.handler = handle_hotplug_event_func,
+};
 
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
@@ -285,7 +287,7 @@ register_slot(acpi_handle handle, u32 lv
 		 */
 		newfunc->flags &= ~FUNC_HAS_EJ0;
 		if (register_hotplug_dock_device(handle,
-			handle_hotplug_event_func, newfunc))
+			&acpiphp_dock_ops, newfunc))
 			dbg("failed to register dock device\n");
 
 		/* we need to be notified when dock events happen
Index: linux/drivers/ata/libata-acpi.c
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2008-08-27 10:22:21.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2008-08-27 10:22:24.000000000 +0800
@@ -209,6 +209,46 @@ static void ata_acpi_ap_notify_dock(acpi
 	ata_acpi_handle_hotplug(ap, NULL, event);
 }
 
+static void ata_acpi_uevent(struct ata_port *ap, struct ata_device *dev,
+	u32 event)
+{
+	struct kobject *kobj = NULL;
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
+
+	if (dev) {
+		if (dev->sdev)
+			kobj = &dev->sdev->sdev_gendev.kobj;
+	} else
+		kobj = &ap->dev->kobj;
+
+	if (kobj) {
+		sprintf(event_string, "BAY_EVENT=%d", event);
+		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+static void ata_acpi_ap_uevent(acpi_handle handle, u32 event, void *data)
+{
+	ata_acpi_uevent(data, NULL, event);
+}
+
+static void ata_acpi_dev_uevent(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_device *dev = data;
+	ata_acpi_uevent(dev->link->ap, dev, event);
+}
+
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
@@ -244,7 +284,7 @@ void ata_acpi_associate(struct ata_host 
 		if (ap->acpi_handle) {
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
-					     ata_acpi_ap_notify_dock, ap);
+					     &ata_acpi_ap_dock_ops, ap);
 		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
@@ -253,7 +293,7 @@ void ata_acpi_associate(struct ata_host 
 			if (dev->acpi_handle) {
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
-					     ata_acpi_dev_notify_dock, dev);
+					     &ata_acpi_dev_dock_ops, dev);
 			}
 		}
 	}


