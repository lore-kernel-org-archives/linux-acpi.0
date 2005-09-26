From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] alignment bug fix in acpi/glue.c
Date: Mon, 26 Sep 2005 10:34:48 -0600
Message-ID: <1127752488.6529.14.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Patch below fixes a bug that shows up as an unaligned access on ia64.
acpi_evaluate_integer() is storing 8 bytes into this 4 byte variable.

Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>

diff -r db9b9552a2b4 drivers/acpi/glue.c
--- a/drivers/acpi/glue.c	Sat Sep 24 23:56:08 2005
+++ b/drivers/acpi/glue.c	Mon Sep 26 10:19:36 2005
@@ -96,7 +96,7 @@
 static acpi_status
 do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 {
-	int *busnr = (int *)data;
+	u64 *busnr = (u64 *)data;
 	struct acpi_resource_address64 address;
 
 	if (resource->id != ACPI_RSTYPE_ADDRESS16 &&
@@ -115,13 +115,13 @@
 static int get_root_bridge_busnr(acpi_handle handle)
 {
 	acpi_status status;
-	int bus, bbn;
+	u64 bus;
+	unsigned long bbn;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
-	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
-				       (unsigned long *)&bbn);
+	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL, &bbn);
 	if (status == AE_NOT_FOUND) {
 		/* Assume bus = 0 */
 		printk(KERN_INFO PREFIX
@@ -153,7 +153,7 @@
 	}
       exit:
 	acpi_os_free(buffer.pointer);
-	return bbn;
+	return (int)bbn;
 }
 
 static acpi_status





-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
