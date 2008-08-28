From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 5/11]Fix duplicate notification handler register
Date: Thu, 28 Aug 2008 10:04:29 +0800
Message-ID: <1219889069.29375.31.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1027 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387AbYH1Byp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 21:54:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Battery driver already registers notification handler. To avoid register
notification handler again, the patch introduced a notifier chain in
global system notifier handler and use it in dock driver, so we can
avoid register notification handler.

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---
 drivers/acpi/bus.c      |   15 +++++++++++++++
 drivers/acpi/dock.c     |   46 ++++++++++++++++++++++++----------------------
 include/acpi/acpi_bus.h |    3 +++
 3 files changed, 42 insertions(+), 22 deletions(-)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c	2008-08-28 09:32:33.000000000 +0800
+++ linux/drivers/acpi/bus.c	2008-08-28 09:41:22.000000000 +0800
@@ -525,6 +525,19 @@ static int acpi_bus_check_scope(struct a
 	return 0;
 }
 
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
@@ -535,6 +548,8 @@ static void acpi_bus_notify(acpi_handle 
 	int result = 0;
 	struct acpi_device *device = NULL;
 
+	blocking_notifier_call_chain(&acpi_bus_notify_list,
+		type, (void *)handle);
 
 	if (acpi_bus_get_device(handle, &device))
 		return;
Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-28 09:40:23.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-28 09:41:22.000000000 +0800
@@ -748,6 +748,28 @@ static void dock_notify(acpi_handle hand
 	}
 }
 
+static int acpi_dock_notifier_call(struct notifier_block *this,
+	unsigned long event, void *data)
+{
+	struct dock_station *dock_station;
+	acpi_handle handle = (acpi_handle)data;
+
+	if (event != ACPI_NOTIFY_BUS_CHECK && event != ACPI_NOTIFY_DEVICE_CHECK
+	   && event != ACPI_NOTIFY_EJECT_REQUEST)
+		return 0;
+	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		if (dock_station->handle == handle) {
+			dock_notify(handle, event, dock_station);
+			return 0 ;
+		}
+	}
+	return 0;
+}
+
+static struct notifier_block dock_acpi_notifier = {
+	.notifier_call = acpi_dock_notifier_call,
+};
+
 /**
  * find_dock_devices - find devices on the dock station
  * @handle: the handle of the device we are examining
@@ -861,7 +883,6 @@ static DEVICE_ATTR(uid, S_IRUGO, show_do
 static int dock_add(acpi_handle handle)
 {
 	int ret;
-	acpi_status status;
 	struct dock_dependent_device *dd;
 	struct dock_station *dock_station;
 	struct platform_device *dock_device;
@@ -956,23 +977,10 @@ static int dock_add(acpi_handle handle)
 	}
 	add_dock_dependent_device(dock_station, dd);
 
-	/* register for dock events */
-	status = acpi_install_notify_handler(dock_station->handle,
-					     ACPI_SYSTEM_NOTIFY,
-					     dock_notify, dock_station);
-
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing notify handler\n");
-		ret = -ENODEV;
-		goto dock_add_err;
-	}
-
 	dock_station_count++;
 	list_add(&dock_station->sibiling, &dock_stations);
 	return 0;
 
-dock_add_err:
-	kfree(dd);
 dock_add_err_unregister:
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
@@ -990,7 +998,6 @@ dock_add_err_unregister:
 static int dock_remove(struct dock_station *dock_station)
 {
 	struct dock_dependent_device *dd, *tmp;
-	acpi_status status;
 	struct platform_device *dock_device = dock_station->dock_device;
 
 	if (!dock_station_count)
@@ -1001,13 +1008,6 @@ static int dock_remove(struct dock_stati
 				 list)
 	    kfree(dd);
 
-	/* remove dock notify handler */
-	status = acpi_remove_notify_handler(dock_station->handle,
-					    ACPI_SYSTEM_NOTIFY,
-					    dock_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Error removing notify handler\n");
-
 	/* cleanup sysfs */
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
@@ -1069,6 +1069,7 @@ static int __init dock_init(void)
 		return 0;
 	}
 
+	register_acpi_bus_notifier(&dock_acpi_notifier);
 	printk(KERN_INFO PREFIX "%s: %d docks/bays found\n",
 		ACPI_DOCK_DRIVER_DESCRIPTION, dock_station_count);
 	return 0;
@@ -1078,6 +1079,7 @@ static void __exit dock_exit(void)
 {
 	struct dock_station *dock_station;
 
+	unregister_acpi_bus_notifier(&dock_acpi_notifier);
 	list_for_each_entry(dock_station, &dock_stations, sibiling)
 		dock_remove(dock_station);
 }
Index: linux/include/acpi/acpi_bus.h
===================================================================
--- linux.orig/include/acpi/acpi_bus.h	2008-08-28 09:32:33.000000000 +0800
+++ linux/include/acpi/acpi_bus.h	2008-08-28 09:41:22.000000000 +0800
@@ -327,6 +327,9 @@ int acpi_bus_get_private_data(acpi_handl
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
+
+extern int register_acpi_bus_notifier(struct notifier_block *nb);
+extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
 /*
  * External Functions
  */


