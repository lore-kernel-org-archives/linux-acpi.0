From: akpm@osdl.org
Subject: [patch 09/16] acpi_bus_unregister_driver(): make void
Date: Thu, 27 Apr 2006 02:25:08 -0700
Message-ID: <200604270926.k3R9Qa2I025096@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:43725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965007AbWD0J0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:26:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Nobody looks at the return value, and this brings it into line with
pci_unregister_driver(), etc.  Also removed validation of the driver
pointer passed in to register and unregister.  More consistent, and we'll
find bugs faster if we fault rather than returning an error that's ignored.

Also makes internal functions acpi_device_unregister() and
acpi_driver_detach() void, since nobody uses their returns either.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/scan.c     |   15 +++------------
 include/acpi/acpi_bus.h |    2 +-
 2 files changed, 4 insertions(+), 13 deletions(-)

diff -puN drivers/acpi/scan.c~acpi_bus_unregister_driver-make-void drivers/acpi/scan.c
--- devel/drivers/acpi/scan.c~acpi_bus_unregister_driver-make-void	2006-04-10 23:16:23.000000000 -0700
+++ devel-akpm/drivers/acpi/scan.c	2006-04-10 23:16:23.000000000 -0700
@@ -143,7 +143,7 @@ static void acpi_device_register(struct 
 	create_sysfs_device_files(device);
 }
 
-static int acpi_device_unregister(struct acpi_device *device, int type)
+static void acpi_device_unregister(struct acpi_device *device, int type)
 {
 	spin_lock(&acpi_device_lock);
 	if (device->parent) {
@@ -159,7 +159,6 @@ static int acpi_device_unregister(struct
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
 	remove_sysfs_device_files(device);
 	kobject_unregister(&device->kobj);
-	return 0;
 }
 
 void acpi_bus_data_handler(acpi_handle handle, u32 function, void *context)
@@ -566,7 +565,7 @@ static void acpi_driver_attach(struct ac
 	spin_unlock(&acpi_device_lock);
 }
 
-static int acpi_driver_detach(struct acpi_driver *drv)
+static void acpi_driver_detach(struct acpi_driver *drv)
 {
 	struct list_head *node, *next;
 
@@ -588,7 +587,6 @@ static int acpi_driver_detach(struct acp
 		}
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(0);
 }
 
 /**
@@ -606,9 +604,6 @@ int acpi_bus_register_driver(struct acpi
 	if (acpi_disabled)
 		return_VALUE(-ENODEV);
 
-	if (!driver)
-		return_VALUE(-EINVAL);
-
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
@@ -626,13 +621,10 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
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
@@ -640,7 +632,6 @@ int acpi_bus_unregister_driver(struct ac
 		list_del_init(&driver->node);
 		spin_unlock(&acpi_device_lock);
 	}
-	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
diff -puN include/acpi/acpi_bus.h~acpi_bus_unregister_driver-make-void include/acpi/acpi_bus.h
--- devel/include/acpi/acpi_bus.h~acpi_bus_unregister_driver-make-void	2006-04-10 23:16:23.000000000 -0700
+++ devel-akpm/include/acpi/acpi_bus.h	2006-04-10 23:16:23.000000000 -0700
@@ -327,7 +327,7 @@ int acpi_bus_set_power(acpi_handle handl
 int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_receive_event(struct acpi_bus_event *event);
 int acpi_bus_register_driver(struct acpi_driver *driver);
-int acpi_bus_unregister_driver(struct acpi_driver *driver);
+void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
 		 acpi_handle handle, int type);
 int acpi_bus_trim(struct acpi_device *start, int rmdevice);
_
