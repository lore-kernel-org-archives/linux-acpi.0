From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: simplify acpi_match_ids()
Date: Mon, 13 Jun 2005 14:52:16 -0600
Message-ID: <200506131452.16106.bjorn.helgaas@hp.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"buffer" is no longer used and its leftover management code is an
unnecessary complication.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c	2005-05-03 11:53:51.000000000 -0600
+++ linux-2.6/drivers/acpi/scan.c	2005-06-13 14:37:17.000000000 -0600
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


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
