From: akpm@osdl.org
Subject: [patch 11/22] ACPI: make acpi_bus_register_driver() return success/failure, not device count
Date: Tue, 07 Mar 2006 23:49:38 -0800
Message-ID: <200603080751.k287pR2T000978@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:2210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932420AbWCHHvp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 02:51:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

acpi_bus_register_driver() should not return the number of devices claimed. 
We're not asking to find devices, we're making a driver available to devices,
including hot-pluggable devices that may appear in the future.

I audited all callers of acpi_bus_register_driver(), and except asus_acpi.c
and sonypi.c (fixed in previous patches), all either ignore the return value
or test only for failure (<0).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/scan.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff -puN drivers/acpi/scan.c~acpi-make-acpi_bus_register_driver-return-success-failure-not-device-count drivers/acpi/scan.c
--- devel/drivers/acpi/scan.c~acpi-make-acpi_bus_register_driver-return-success-failure-not-device-count	2006-03-07 23:47:10.000000000 -0800
+++ devel-akpm/drivers/acpi/scan.c	2006-03-07 23:47:10.000000000 -0800
@@ -549,10 +549,9 @@ static int acpi_start_single_object(stru
 	return_VALUE(result);
 }
 
-static int acpi_driver_attach(struct acpi_driver *drv)
+static void acpi_driver_attach(struct acpi_driver *drv)
 {
 	struct list_head *node, *next;
-	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -569,7 +568,6 @@ static int acpi_driver_attach(struct acp
 			if (!acpi_bus_driver_init(dev, drv)) {
 				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
-				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));
@@ -578,7 +576,6 @@ static int acpi_driver_attach(struct acp
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver *drv)
@@ -611,14 +608,11 @@ static int acpi_driver_detach(struct acp
  * @driver: driver being registered
  *
  * Registers a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and binds.  Returns the
- * number of devices that were claimed by the driver, or a negative
- * error status for failure.
+ * devices that match the driver's criteria and binds.  Returns zero for
+ * success or a negative error status for failure.
  */
 int acpi_bus_register_driver(struct acpi_driver *driver)
 {
-	int count;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_register_driver");
 
 	if (acpi_disabled)
@@ -630,9 +624,9 @@ int acpi_bus_register_driver(struct acpi
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
-	count = acpi_driver_attach(driver);
+	acpi_driver_attach(driver);
 
-	return_VALUE(count);
+	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_register_driver);
_
