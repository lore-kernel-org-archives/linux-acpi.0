From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] return number of devices claimed from acpi_bus_register_driver()
Date: Thu, 29 Jul 2004 12:09:28 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407291209.28801.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

pnp_register_driver() and pci_register_driver() return the number of
devices claimed by the driver.  This makes acpi_bus_register_driver()
do the same.

All existing callers of acpi_bus_register_driver() either ignore the
return value or check only for negative (error) return values.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

===== drivers/acpi/scan.c 1.28 vs edited =====
--- 1.28/drivers/acpi/scan.c	2004-06-30 09:55:20 -06:00
+++ edited/drivers/acpi/scan.c	2004-07-29 11:43:17 -06:00
@@ -276,6 +276,7 @@
 static int acpi_driver_attach(struct acpi_driver * drv)
 {
 	struct list_head * node, * next;
+	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -290,6 +291,7 @@
 		if (!acpi_bus_match(dev, drv)) {
 			if (!acpi_bus_driver_init(dev, drv)) {
 				atomic_inc(&drv->references);
+				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));
 			}
@@ -297,7 +299,7 @@
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(0);
+	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver * drv)
@@ -328,28 +330,30 @@
  * acpi_bus_register_driver 
  * ------------------------ 
  * Registers a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and binds.
+ * devices that match the driver's criteria and binds.  Returns the
+ * number of devices that were claimed by the driver, or a negative
+ * error status for failure.
  */
 int
 acpi_bus_register_driver (
 	struct acpi_driver	*driver)
 {
-	int error = 0;
+	int count;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_register_driver");
 
 	if (acpi_disabled)
 		return_VALUE(-ENODEV);
 
-	if (driver) {
-		spin_lock(&acpi_device_lock);
-		list_add_tail(&driver->node, &acpi_bus_drivers);
-		spin_unlock(&acpi_device_lock);
-		acpi_driver_attach(driver);
-	} else
-		error = -EINVAL;
+	if (!driver)
+		return_VALUE(-EINVAL);
+
+	spin_lock(&acpi_device_lock);
+	list_add_tail(&driver->node, &acpi_bus_drivers);
+	spin_unlock(&acpi_device_lock);
+	count = acpi_driver_attach(driver);
 
-	return_VALUE(error);
+	return_VALUE(count);
 }
 
 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
