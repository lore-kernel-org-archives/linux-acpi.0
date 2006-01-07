From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch 5/9] acpi: kernel-doc fixes for scan.c
Date: Sat, 7 Jan 2006 05:21:01 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13368@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

applied.

thanks,
-len  

>-----Original Message-----
>From: akpm-3NddpPZAyC0@public.gmane.org [mailto:akpm-3NddpPZAyC0@public.gmane.org] 
>Sent: Friday, January 06, 2006 1:31 AM
>To: Brown, Len
>Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; akpm-3NddpPZAyC0@public.gmane.org; rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org
>Subject: [patch 5/9] acpi: kernel-doc fixes for scan.c
>
>
>From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
>
>Fix kernel-doc warnings in acpi/scan.c.
>
>Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
>Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
>---
>
> Documentation/DocBook/kernel-api.tmpl |    1 
> drivers/acpi/scan.c                   |   27 +++++++++++++++---------
> 2 files changed, 18 insertions(+), 10 deletions(-)
>
>diff -puN 
>Documentation/DocBook/kernel-api.tmpl~acpi-kernel-doc-fixes-for
>-scanc Documentation/DocBook/kernel-api.tmpl
>--- 
>devel/Documentation/DocBook/kernel-api.tmpl~acpi-kernel-doc-fix
>es-for-scanc	2006-01-05 22:28:24.000000000 -0800
>+++ devel-akpm/Documentation/DocBook/kernel-api.tmpl	
>2006-01-05 22:28:24.000000000 -0800
>@@ -369,6 +369,7 @@ X!Edrivers/acpi/motherboard.c
> X!Edrivers/acpi/bus.c
> -->
> !Edrivers/acpi/scan.c
>+!Idrivers/acpi/scan.c
> <!-- No correct structured comments
> X!Edrivers/acpi/pci_bind.c
> -->
>diff -puN drivers/acpi/scan.c~acpi-kernel-doc-fixes-for-scanc 
>drivers/acpi/scan.c
>--- devel/drivers/acpi/scan.c~acpi-kernel-doc-fixes-for-scanc	
>2006-01-05 22:28:24.000000000 -0800
>+++ devel-akpm/drivers/acpi/scan.c	2006-01-05 
>22:28:24.000000000 -0800
>@@ -475,8 +475,10 @@ static LIST_HEAD(acpi_bus_drivers);
> static DECLARE_MUTEX(acpi_bus_drivers_lock);
> 
> /**
>- * acpi_bus_match 
>- * --------------
>+ * acpi_bus_match - match device IDs to driver's supported IDs
>+ * @device: the device that we are trying to match to a driver
>+ * @driver: driver whose device id table is being checked
>+ *
>  * Checks the device's hardware (_HID) or compatible (_CID) 
>ids to see if it
>  * matches the specified driver's criteria.
>  */
>@@ -489,8 +491,10 @@ acpi_bus_match(struct acpi_device *devic
> }
> 
> /**
>- * acpi_bus_driver_init 
>- * --------------------
>+ * acpi_bus_driver_init - add a device to a driver
>+ * @device: the device to add and initialize
>+ * @driver: driver for the device
>+ *
>  * Used to initialize a device via its device driver.  Called 
>whenever a 
>  * driver is bound to a device.  Invokes the driver's add() 
>and start() ops.
>  */
>@@ -603,8 +607,9 @@ static int acpi_driver_detach(struct acp
> }
> 
> /**
>- * acpi_bus_register_driver 
>- * ------------------------ 
>+ * acpi_bus_register_driver - register a driver with the ACPI bus
>+ * @driver: driver being registered
>+ *
>  * Registers a driver with the ACPI bus.  Searches the 
>namespace for all
>  * devices that match the driver's criteria and binds.  Returns the
>  * number of devices that were claimed by the driver, or a negative
>@@ -633,8 +638,9 @@ int acpi_bus_register_driver(struct acpi
> EXPORT_SYMBOL(acpi_bus_register_driver);
> 
> /**
>- * acpi_bus_unregister_driver 
>- * --------------------------
>+ * acpi_bus_unregister_driver - unregisters a driver with the APIC bus
>+ * @driver: driver to unregister
>+ *
>  * Unregisters a driver with the ACPI bus.  Searches the 
>namespace for all
>  * devices that match the driver's criteria and unbinds.
>  */
>@@ -660,8 +666,9 @@ int acpi_bus_unregister_driver(struct ac
> EXPORT_SYMBOL(acpi_bus_unregister_driver);
> 
> /**
>- * acpi_bus_find_driver 
>- * --------------------
>+ * acpi_bus_find_driver - check if there is a driver 
>installed for the device
>+ * @device: device that we are trying to find a supporting driver for
>+ *
>  * Parses the list of registered drivers looking for a driver 
>applicable for
>  * the specified device.
>  */
>_
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
