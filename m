From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 09/16] acpi_bus_unregister_driver(): make void
Date: Sat, 13 May 2006 23:34:26 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F339@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64823 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932318AbWENDea convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:34:30 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 09/16] acpi_bus_unregister_driver(): make void
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>Nobody looks at the return value, and this brings it into line with
>pci_unregister_driver(), etc.  Also removed validation of the driver
>pointer passed in to register and unregister.  More 
>consistent, and we'll
>find bugs faster if we fault rather than returning an error 
>that's ignored.
>
>Also makes internal functions acpi_device_unregister() and
>acpi_driver_detach() void, since nobody uses their returns either.
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/scan.c     |   15 +++------------
> include/acpi/acpi_bus.h |    2 +-
> 2 files changed, 4 insertions(+), 13 deletions(-)
>
>diff -puN 
>drivers/acpi/scan.c~acpi_bus_unregister_driver-make-void 
>drivers/acpi/scan.c
>--- 
>devel/drivers/acpi/scan.c~acpi_bus_unregister_driver-make-void	
>2006-04-10 23:16:23.000000000 -0700
>+++ devel-akpm/drivers/acpi/scan.c	2006-04-10 
>23:16:23.000000000 -0700
>@@ -143,7 +143,7 @@ static void acpi_device_register(struct 
> 	create_sysfs_device_files(device);
> }
> 
>-static int acpi_device_unregister(struct acpi_device *device, 
>int type)
>+static void acpi_device_unregister(struct acpi_device 
>*device, int type)
> {
> 	spin_lock(&acpi_device_lock);
> 	if (device->parent) {
>@@ -159,7 +159,6 @@ static int acpi_device_unregister(struct
> 	acpi_detach_data(device->handle, acpi_bus_data_handler);
> 	remove_sysfs_device_files(device);
> 	kobject_unregister(&device->kobj);
>-	return 0;
> }
> 
> void acpi_bus_data_handler(acpi_handle handle, u32 function, 
>void *context)
>@@ -566,7 +565,7 @@ static void acpi_driver_attach(struct ac
> 	spin_unlock(&acpi_device_lock);
> }
> 
>-static int acpi_driver_detach(struct acpi_driver *drv)
>+static void acpi_driver_detach(struct acpi_driver *drv)
> {
> 	struct list_head *node, *next;
> 
>@@ -588,7 +587,6 @@ static int acpi_driver_detach(struct acp
> 		}
> 	}
> 	spin_unlock(&acpi_device_lock);
>-	return_VALUE(0);
> }
> 
> /**
>@@ -606,9 +604,6 @@ int acpi_bus_register_driver(struct acpi
> 	if (acpi_disabled)
> 		return_VALUE(-ENODEV);
> 
>-	if (!driver)
>-		return_VALUE(-EINVAL);
>-
> 	spin_lock(&acpi_device_lock);
> 	list_add_tail(&driver->node, &acpi_bus_drivers);
> 	spin_unlock(&acpi_device_lock);
>@@ -626,13 +621,10 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
>  * Unregisters a driver with the ACPI bus.  Searches the 
>namespace for all
>  * devices that match the driver's criteria and unbinds.
>  */
>-int acpi_bus_unregister_driver(struct acpi_driver *driver)
>+void acpi_bus_unregister_driver(struct acpi_driver *driver)
> {
> 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
> 
>-	if (!driver)
>-		return_VALUE(-EINVAL);
>-
> 	acpi_driver_detach(driver);
> 
> 	if (!atomic_read(&driver->references)) {
>@@ -640,7 +632,6 @@ int acpi_bus_unregister_driver(struct ac
> 		list_del_init(&driver->node);
> 		spin_unlock(&acpi_device_lock);
> 	}
>-	return_VALUE(0);
> }
> 
> EXPORT_SYMBOL(acpi_bus_unregister_driver);
>diff -puN 
>include/acpi/acpi_bus.h~acpi_bus_unregister_driver-make-void 
>include/acpi/acpi_bus.h
>--- 
>devel/include/acpi/acpi_bus.h~acpi_bus_unregister_driver-ma
>ke-void	2006-04-10 23:16:23.000000000 -0700
>+++ devel-akpm/include/acpi/acpi_bus.h	2006-04-10 
>23:16:23.000000000 -0700
>@@ -327,7 +327,7 @@ int acpi_bus_set_power(acpi_handle handl
> int acpi_bus_generate_event(struct acpi_device *device, u8 
>type, int data);
> int acpi_bus_receive_event(struct acpi_bus_event *event);
> int acpi_bus_register_driver(struct acpi_driver *driver);
>-int acpi_bus_unregister_driver(struct acpi_driver *driver);
>+void acpi_bus_unregister_driver(struct acpi_driver *driver);
> int acpi_bus_add(struct acpi_device **child, struct 
>acpi_device *parent,
> 		 acpi_handle handle, int type);
> int acpi_bus_trim(struct acpi_device *start, int rmdevice);
>_
>
