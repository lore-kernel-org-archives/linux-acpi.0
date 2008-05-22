From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 7/8]introduce .uevent for devices in dock
Date: Thu, 22 May 2008 14:34:15 +0800
Message-ID: <1211438055.25221.45.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12896 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914AbYEVG3j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 02:29:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>

dock's uevent reported itself, not ata. It might be difficult to find an
ata device just according to a dock. This patch introduces docking ops
for each device in a dock. when docking, dock driver can send device
specific uevent. This should help dock station too (not just bay) 

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c                |   17 +++++++-----
 drivers/ata/libata-acpi.c          |   51 +++++++++++++++++++++++++++----------
 drivers/pci/hotplug/acpiphp_glue.c |    6 ++--
 include/acpi/acpi_drivers.h        |    9 +++++-
 4 files changed, 60 insertions(+), 23 deletions(-)

Index: linux/drivers/ata/libata-acpi.c
===================================================================
--- linux.orig/drivers/ata/libata-acpi.c	2008-05-22 14:09:13.000000000 +0800
+++ linux/drivers/ata/libata-acpi.c	2008-05-22 14:10:21.000000000 +0800
@@ -121,10 +121,7 @@ static void ata_acpi_associate_ide_port(
 static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device
 				    *dev, u32 event)
 {
-	char event_string[12];
-	char *envp[] = { event_string, NULL };
 	struct ata_eh_info *ehi;
-	struct kobject *kobj = NULL;
 	int wait = 0;
 	unsigned long flags;
 	acpi_handle handle;
@@ -170,6 +167,28 @@ static void ata_acpi_handle_hotplug(stru
 
 	if (wait)
 		ata_port_wait_eh(ap);
+}
+
+static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_device *dev = data;
+
+	ata_acpi_handle_hotplug(NULL, dev, event);
+}
+
+static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_port *ap = data;
+
+	ata_acpi_handle_hotplug(ap, NULL, event);
+}
+
+static void ata_acpi_uevent(struct ata_port *ap, struct ata_device *dev,
+	u32 event)
+{
+	struct kobject *kobj = NULL;
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
 
 	if (dev) {
 		if (dev->sdev)
@@ -183,20 +202,26 @@ static void ata_acpi_handle_hotplug(stru
 	}
 }
 
-static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
+static void ata_acpi_ap_uevent(acpi_handle handle, u32 event, void *data)
 {
-	struct ata_device *dev = data;
-
-	ata_acpi_handle_hotplug(NULL, dev, event);
+	ata_acpi_uevent(data, NULL, event);
 }
 
-static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
+static void ata_acpi_dev_uevent(acpi_handle handle, u32 event, void *data)
 {
-	struct ata_port *ap = data;
-
-	ata_acpi_handle_hotplug(ap, NULL, event);
+	ata_acpi_uevent(NULL, data, event);
 }
 
+static struct acpi_dock_ops ata_acpi_dev_dock_ops = {
+	.handler = ata_acpi_dev_notify,
+	.uevent = ata_acpi_dev_uevent,
+};
+
+static struct acpi_dock_ops ata_acpi_ap_dock_ops = {
+	.handler = ata_acpi_ap_notify,
+	.uevent = ata_acpi_ap_uevent,
+};
+
 /**
  * ata_acpi_associate - associate ATA host with ACPI objects
  * @host: target ATA host
@@ -232,7 +257,7 @@ void ata_acpi_associate(struct ata_host 
 		if (ap->acpi_handle) {
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
-						     ata_acpi_ap_notify, ap);
+						     &ata_acpi_ap_dock_ops, ap);
 		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
@@ -241,7 +266,7 @@ void ata_acpi_associate(struct ata_host 
 			if (dev->acpi_handle) {
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
-						ata_acpi_dev_notify, dev);
+						&ata_acpi_dev_dock_ops, dev);
 			}
 		}
 	}
Index: linux/include/acpi/acpi_drivers.h
===================================================================
--- linux.orig/include/acpi/acpi_drivers.h	2008-05-22 14:08:37.000000000 +0800
+++ linux/include/acpi/acpi_drivers.h	2008-05-22 14:10:21.000000000 +0800
@@ -113,12 +113,17 @@ int acpi_processor_set_thermal_limit(acp
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
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-05-22 14:08:37.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-05-22 14:10:21.000000000 +0800
@@ -75,7 +75,7 @@ struct dock_dependent_device {
 	struct list_head list;
 	struct list_head hotplug_list;
 	acpi_handle handle;
-	acpi_notify_handler handler;
+	struct acpi_dock_ops *ops;
 	void *context;
 };
 
@@ -384,8 +384,8 @@ static void hotplug_dock_devices(struct 
 	 * First call driver specific hotplug functions
 	 */
 	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
-		if (dd->handler)
-			dd->handler(dd->handle, event, dd->context);
+		if (dd->ops && dd->ops->handler)
+			dd->ops->handler(dd->handle, event, dd->context);
 	}
 
 	/*
@@ -408,6 +408,7 @@ static void dock_event(struct dock_stati
 	struct device *dev = &ds->dock_device->dev;
 	char event_string[13];
 	char *envp[] = { event_string, NULL };
+	struct dock_dependent_device *dd;
 
 	if (num == UNDOCK_EVENT)
 		sprintf(event_string, "EVENT=undock");
@@ -419,6 +420,10 @@ static void dock_event(struct dock_stati
 	 * changed.
 	 */
 	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+
+	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list)
+		if (dd->ops && dd->ops->uevent)
+			dd->ops->uevent(dd->handle, event, dd->context);
 }
 
 /**
@@ -584,7 +589,7 @@ EXPORT_SYMBOL_GPL(unregister_dock_notifi
 /**
  * register_hotplug_dock_device - register a hotplug function
  * @handle: the handle of the device
- * @handler: the acpi_notifier_handler to call after docking
+ * @ops: handlers to call after docking
  * @context: device specific data
  *
  * If a driver would like to perform a hotplug operation after a dock
@@ -592,7 +597,7 @@ EXPORT_SYMBOL_GPL(unregister_dock_notifi
  * the dock driver after _DCK is executed.
  */
 int
-register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler handler,
+register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 			     void *context)
 {
 	struct dock_dependent_device *dd;
@@ -608,7 +613,7 @@ register_hotplug_dock_device(acpi_handle
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
--- linux.orig/drivers/pci/hotplug/acpiphp_glue.c	2008-05-22 14:08:37.000000000 +0800
+++ linux/drivers/pci/hotplug/acpiphp_glue.c	2008-05-22 14:10:21.000000000 +0800
@@ -169,7 +169,9 @@ static int post_dock_fixups(struct notif
 }
 

-
+static struct acpi_dock_ops acpiphp_dock_ops = {
+	.handler = handle_hotplug_event_func,
+};
 
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
@@ -280,7 +282,7 @@ register_slot(acpi_handle handle, u32 lv
 		 */
 		newfunc->flags &= ~FUNC_HAS_EJ0;
 		if (register_hotplug_dock_device(handle,
-			handle_hotplug_event_func, newfunc))
+			&acpiphp_dock_ops, newfunc))
 			dbg("failed to register dock device\n");
 
 		/* we need to be notified when dock events happen


