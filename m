From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: acpi_bus_unregister_driver(): make void
Date: Fri, 31 Mar 2006 15:29:14 -0700
Message-ID: <200603311529.14370.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:30911 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751458AbWCaW3T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 17:29:19 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Francois Romieu <romieu@fr.zoreil.com>

Nobody looks at the return value, and this brings it into line with
pci_unregister_driver(), etc.  Also removed validation of the driver
pointer passed in to register and unregister.  More consistent, and
we'll find bugs faster if we fault rather than returning an error
that's ignored.

Also makes internal functions acpi_device_unregister() and
acpi_driver_detach() void, since nobody uses their returns either.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/drivers/acpi/scan.c
===================================================================
--- work-mm5.orig/drivers/acpi/scan.c	2006-03-23 10:22:40.000000000 -0700
+++ work-mm5/drivers/acpi/scan.c	2006-03-31 15:00:20.000000000 -0700
@@ -143,7 +143,7 @@
 	create_sysfs_device_files(device);
 }
 
-static int acpi_device_unregister(struct acpi_device *device, int type)
+static void acpi_device_unregister(struct acpi_device *device, int type)
 {
 	spin_lock(&acpi_device_lock);
 	if (device->parent) {
@@ -159,7 +159,6 @@
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
 	remove_sysfs_device_files(device);
 	kobject_unregister(&device->kobj);
-	return 0;
 }
 
 void acpi_bus_data_handler(acpi_handle handle, u32 function, void *context)
@@ -600,7 +599,7 @@
 	spin_unlock(&acpi_device_lock);
 }
 
-static int acpi_driver_detach(struct acpi_driver *drv)
+static void acpi_driver_detach(struct acpi_driver *drv)
 {
 	struct list_head *node, *next;
 
@@ -622,7 +621,6 @@
 		}
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(0);
 }
 
 /**
@@ -640,9 +638,6 @@
 	if (acpi_disabled)
 		return_VALUE(-ENODEV);
 
-	if (!driver)
-		return_VALUE(-EINVAL);
-
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
@@ -660,13 +655,10 @@
  * Unregisters a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and unbinds.
  */
-int acpi_bus_unregister_driver(struct acpi_driver *driver)
+void acpi_bus_unregister_driver(struct acpi_driver *driver)
 {
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
-	if (!driver)
-		return_VALUE(-EINVAL);
-
 	acpi_driver_detach(driver);
 
 	if (!atomic_read(&driver->references)) {
@@ -674,7 +666,6 @@
 		list_del_init(&driver->node);
 		spin_unlock(&acpi_device_lock);
 	}
-	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
Index: work-mm5/include/acpi/acpi_bus.h
===================================================================
--- work-mm5.orig/include/acpi/acpi_bus.h	2006-03-23 10:22:49.000000000 -0700
+++ work-mm5/include/acpi/acpi_bus.h	2006-03-31 15:04:45.000000000 -0700
@@ -327,7 +327,7 @@
 int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_receive_event(struct acpi_bus_event *event);
 int acpi_bus_register_driver(struct acpi_driver *driver);
-int acpi_bus_unregister_driver(struct acpi_driver *driver);
+void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
 		 acpi_handle handle, int type);
 int acpi_bus_trim(struct acpi_device *start, int rmdevice);
