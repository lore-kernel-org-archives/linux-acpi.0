From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: simplify scan.c coding
Date: Fri, 16 Sep 2005 11:36:52 -0600
Message-ID: <200509161136.52838.bjorn.helgaas@hp.com>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

No functional changes; just remove leftover, unused "buffer" and
simplify control flow (no need to remember error values and goto
the end, when we can simply return the value directly).

Previous post:
    http://sourceforge.net/mailarchive/message.php?msg_id=12489147

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work-vga2/drivers/acpi/scan.c
===================================================================
--- work-vga2.orig/drivers/acpi/scan.c	2005-09-14 09:28:10.000000000 -0600
+++ work-vga2/drivers/acpi/scan.c	2005-09-15 09:52:33.000000000 -0600
@@ -236,12 +236,9 @@
 
 int acpi_match_ids(struct acpi_device *device, char *ids)
 {
-	int error = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
 	if (device->flags.hardware_id)
 		if (strstr(ids, device->pnp.hardware_id))
-			goto Done;
+			return 0;
 
 	if (device->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
@@ -250,15 +247,10 @@
 		/* compare multiple _CID entries against driver ids */
 		for (i = 0; i < cid_list->count; i++) {
 			if (strstr(ids, cid_list->id[i].value))
-				goto Done;
+				return 0;
 		}
 	}
-	error = -ENOENT;
-
-      Done:
-	if (buffer.pointer)
-		acpi_os_free(buffer.pointer);
-	return error;
+	return -ENOENT;
 }
 
 static acpi_status
@@ -641,21 +633,19 @@
  */
 int acpi_bus_unregister_driver(struct acpi_driver *driver)
 {
-	int error = 0;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
-	if (driver) {
-		acpi_driver_detach(driver);
+	if (!driver)
+		return_VALUE(-EINVAL);
 
-		if (!atomic_read(&driver->references)) {
-			spin_lock(&acpi_device_lock);
-			list_del_init(&driver->node);
-			spin_unlock(&acpi_device_lock);
-		}
-	} else
-		error = -EINVAL;
-	return_VALUE(error);
+	acpi_driver_detach(driver);
+
+	if (!atomic_read(&driver->references)) {
+		spin_lock(&acpi_device_lock);
+		list_del_init(&driver->node);
+		spin_unlock(&acpi_device_lock);
+	}
+	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
