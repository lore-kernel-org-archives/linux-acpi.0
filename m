From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: make acpi_bus_register_driver() return success/failure, not device count
Date: Fri, 16 Sep 2005 11:39:02 -0600
Message-ID: <200509161139.02934.bjorn.helgaas@hp.com>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

acpi_bus_register_driver() should not return the number of devices
claimed.  We're not asking to find devices, we're making a driver
available to devices, including hot-pluggable devices that may
appear in the future.

I audited all callers of acpi_bus_register_driver(), and except
asus_acpi.c (fixed in previous patch), all either ignore the return
value or test only for failure (<0).

Previous post and discussion of this patch:
    http://sourceforge.net/mailarchive/message.php?msg_id=12489146

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work-vga2/drivers/acpi/scan.c
===================================================================
--- work-vga2.orig/drivers/acpi/scan.c	2005-09-15 09:52:33.000000000 -0600
+++ work-vga2/drivers/acpi/scan.c	2005-09-15 10:27:59.000000000 -0600
@@ -538,10 +538,9 @@
 	return_VALUE(result);
 }
 
-static int acpi_driver_attach(struct acpi_driver *drv)
+static void acpi_driver_attach(struct acpi_driver *drv)
 {
 	struct list_head *node, *next;
-	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
@@ -558,7 +557,6 @@
 			if (!acpi_bus_driver_init(dev, drv)) {
 				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
-				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));
@@ -567,7 +565,6 @@
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver *drv)
@@ -599,14 +596,11 @@
  * acpi_bus_register_driver 
  * ------------------------ 
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
@@ -618,9 +612,9 @@
 	spin_lock(&acpi_device_lock);
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
-	count = acpi_driver_attach(driver);
+	acpi_driver_attach(driver);
 
-	return_VALUE(count);
+	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_register_driver);


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
