From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 11/26] ACPI: make acpi_bus_register_driver() return success/failure, not device count
Date: Sun, 2 Apr 2006 00:21:46 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DE9@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47405 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751221AbWDBFVt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:21:49 -0500
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
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 11/26] ACPI: make acpi_bus_register_driver() 
>return success/failure, not device count
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>acpi_bus_register_driver() should not return the number of 
>devices claimed. 
>We're not asking to find devices, we're making a driver 
>available to devices,
>including hot-pluggable devices that may appear in the future.
>
>I audited all callers of acpi_bus_register_driver(), and 
>except asus_acpi.c
>and sonypi.c (fixed in previous patches), all either ignore 
>the return value
>or test only for failure (<0).
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/scan.c |   16 +++++-----------
> 1 files changed, 5 insertions(+), 11 deletions(-)
>
>diff -puN 
>drivers/acpi/scan.c~acpi-make-acpi_bus_register_driver-return-s
uccess-failure-not-device-count drivers/acpi/scan.c
>--- 
>devel/drivers/acpi/scan.c~acpi-make-acpi_bus_register_driver-re
turn-success-failure-not-device-count	2006-03-28 >14:03:04.000000000 -0800
>+++ devel-akpm/drivers/acpi/scan.c	2006-03-28 
>14:03:04.000000000 -0800
>@@ -548,10 +548,9 @@ static int acpi_start_single_object(stru
> 	return_VALUE(result);
> }
> 
>-static int acpi_driver_attach(struct acpi_driver *drv)
>+static void acpi_driver_attach(struct acpi_driver *drv)
> {
> 	struct list_head *node, *next;
>-	int count = 0;
> 
> 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
> 
>@@ -568,7 +567,6 @@ static int acpi_driver_attach(struct acp
> 			if (!acpi_bus_driver_init(dev, drv)) {
> 				acpi_start_single_object(dev);
> 				atomic_inc(&drv->references);
>-				count++;
> 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> 						  "Found driver 
>[%s] for device [%s]\n",
> 						  drv->name, 
>dev->pnp.bus_id));
>@@ -577,7 +575,6 @@ static int acpi_driver_attach(struct acp
> 		spin_lock(&acpi_device_lock);
> 	}
> 	spin_unlock(&acpi_device_lock);
>-	return_VALUE(count);
> }
> 
> static int acpi_driver_detach(struct acpi_driver *drv)
>@@ -610,14 +607,11 @@ static int acpi_driver_detach(struct acp
>  * @driver: driver being registered
>  *
>  * Registers a driver with the ACPI bus.  Searches the 
>namespace for all
>- * devices that match the driver's criteria and binds.  Returns the
>- * number of devices that were claimed by the driver, or a negative
>- * error status for failure.
>+ * devices that match the driver's criteria and binds.  
>Returns zero for
>+ * success or a negative error status for failure.
>  */
> int acpi_bus_register_driver(struct acpi_driver *driver)
> {
>-	int count;
>-
> 	ACPI_FUNCTION_TRACE("acpi_bus_register_driver");
> 
> 	if (acpi_disabled)
>@@ -629,9 +623,9 @@ int acpi_bus_register_driver(struct acpi
> 	spin_lock(&acpi_device_lock);
> 	list_add_tail(&driver->node, &acpi_bus_drivers);
> 	spin_unlock(&acpi_device_lock);
>-	count = acpi_driver_attach(driver);
>+	acpi_driver_attach(driver);
> 
>-	return_VALUE(count);
>+	return_VALUE(0);
> }
> 
> EXPORT_SYMBOL(acpi_bus_register_driver);
>_
>
