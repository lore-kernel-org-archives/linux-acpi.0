From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/4] ACPI: make acpi_bus_register_driver() return success/failure, not device count
Date: Mon, 6 Feb 2006 17:19:19 -0700
Message-ID: <200602061719.19296.bjorn.helgaas@hp.com>
References: <200602061716.41470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:36292 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932389AbWBGATU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 19:19:20 -0500
In-Reply-To: <200602061716.41470.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Karol Kozimor <sziwan@hell.org.pl>, julien.lerouge@free.fr, acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Narayanan R S <nars@kadamba.org>, Andrew Morton <akpm@osdl.org>

acpi_bus_register_driver() should not return the number of devices
claimed.  We're not asking to find devices, we're making a driver
available to devices, including hot-pluggable devices that may
appear in the future.

I audited all callers of acpi_bus_register_driver(), and except
asus_acpi.c and sonypi.c (fixed in previous patches), all either
ignore the return value or test only for failure (<0).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/scan.c
===================================================================
--- work-mm4.orig/drivers/acpi/scan.c	2006-02-01 16:24:45.000000000 -0700
+++ work-mm4/drivers/acpi/scan.c	2006-02-02 15:13:02.000000000 -0700
@@ -550,10 +550,9 @@
 	return_VALUE(result);
 }
 
-static int acpi_driver_attach(struct acpi_driver *drv)
+static void acpi_driver_attach(struct acpi_driver *drv)
 {
 	struct list_head *node, *next;
-	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -570,7 +569,6 @@
 			if (!acpi_bus_driver_init(dev, drv)) {
 				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
-				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));
@@ -579,7 +577,6 @@
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver *drv)
@@ -612,14 +609,11 @@
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
@@ -631,9 +625,9 @@
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
-	count = acpi_driver_attach(driver);
+	acpi_driver_attach(driver);
 
-	return_VALUE(count);
+	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_register_driver);
