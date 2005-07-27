From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: simplify scan.c coding
Date: Wed, 27 Jul 2005 16:30:01 -0600
Message-ID: <200507271630.01700.bjorn.helgaas@hp.com>
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

acpi_match_ids(): "buffer" is no longer used and its leftover management
    code is an unnecessary complication.

acpi_bus_unregister_driver(): No functional change, just simplify the
    control flow.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work/drivers/acpi/scan.c
===================================================================
--- work.orig/drivers/acpi/scan.c	2005-07-27 10:17:55.000000000 -0600
+++ work/drivers/acpi/scan.c	2005-07-27 10:18:55.000000000 -0600
@@ -254,30 +254,22 @@
 	struct acpi_device	*device,
 	char			*ids)
 {
-	int error = 0;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-
 	if (device->flags.hardware_id)
 		if (strstr(ids, device->pnp.hardware_id))
-			goto Done;
+			return 0;
 
 	if (device->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
 		int i;
 
 		/* compare multiple _CID entries against driver ids */
-		for (i = 0; i < cid_list->count; i++)
-		{
+		for (i = 0; i < cid_list->count; i++) {
 			if (strstr(ids, cid_list->id[i].value))
-				goto Done;
+				return 0;
 		}
 	}
-	error = -ENOENT;
 
- Done:
-	if (buffer.pointer)
-		acpi_os_free(buffer.pointer);
-	return error;
+	return -ENOENT;
 }
 
 static acpi_status
@@ -668,21 +660,19 @@
 acpi_bus_unregister_driver (
 	struct acpi_driver	*driver)
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
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
