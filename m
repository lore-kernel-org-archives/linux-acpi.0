From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: make acpi_bus_register_driver() return zero for success, not device count
Date: Wed, 27 Jul 2005 16:28:25 -0600
Message-ID: <200507271628.25844.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

pci_register_driver() used to return the number of devices claimed,
and we made acpi_bus_register_driver() consistent with that.  But
pci_register_driver() recently changed to return only success/failure
(because the interface is to register the *driver*, not claim devices,
and devices may be hot-plugged later).

So let's do the same with acpi_bus_register_driver().

Note that asus_acpi.c used to unregister itself if it didn't claim
any devices.  Now it will remain registered, like everything else
in drivers/acpi.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work/drivers/acpi/scan.c
===================================================================
--- work.orig/drivers/acpi/scan.c	2005-07-27 10:17:43.000000000 -0600
+++ work/drivers/acpi/scan.c	2005-07-27 10:17:55.000000000 -0600
@@ -578,10 +578,9 @@
 	return_VALUE(result);
 }
 
-static int acpi_driver_attach(struct acpi_driver * drv)
+static void acpi_driver_attach(struct acpi_driver * drv)
 {
 	struct list_head * node, * next;
-	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -597,7 +596,6 @@
 			if (!acpi_bus_driver_init(dev, drv)) {
 				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
-				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));
 			}
@@ -605,7 +603,6 @@
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver * drv)
@@ -636,16 +633,13 @@
  * acpi_bus_register_driver 
  * ------------------------ 
  * Registers a driver with the ACPI bus.  Searches the namespace for all
- * devices that match the driver's criteria and binds.  Returns the
- * number of devices that were claimed by the driver, or a negative
- * error status for failure.
+ * devices that match the driver's criteria and binds.  Returns zero for
+ * success or a negative error status for failure.
  */
 int
 acpi_bus_register_driver (
 	struct acpi_driver	*driver)
 {
-	int count;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_register_driver");
 
 	if (acpi_disabled)
@@ -657,9 +651,9 @@
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
-	count = acpi_driver_attach(driver);
+	acpi_driver_attach(driver);
 
-	return_VALUE(count);
+	return_VALUE(0);
 }
 EXPORT_SYMBOL(acpi_bus_register_driver);
 
Index: work/drivers/acpi/asus_acpi.c
===================================================================
--- work.orig/drivers/acpi/asus_acpi.c	2005-07-27 10:17:43.000000000 -0600
+++ work/drivers/acpi/asus_acpi.c	2005-07-27 10:17:55.000000000 -0600
@@ -1216,8 +1216,7 @@
 	asus_proc_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&asus_hotk_driver);
-	if (result < 1) {
-		acpi_bus_unregister_driver(&asus_hotk_driver);
+	if (result < 0) {
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
 		return -ENODEV;
 	}


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
