From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] 2.4/2.6 use xdsdt to print table header
Date: Mon, 12 Jan 2004 17:32:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073953935.6497.173.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


   I'm resending this patch to get it into the main ACPI source.  This
fixes a problem where the DSDT pointer in the FADT is NULL because it
uses the 64bit XDSDT instead.  The current code is happy to map a NULL
address and return success to the caller.  This can crash the system or
printout garbage headers to the console.  It's a simple matter to check
table revision and use the XDSDT in favor of the DSDT.  This has been
living happily in both the 2.4 and 2.6 ia64 tree for some time.  Please
accept.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Mon Jan 12 15:37:12 2004
+++ b/drivers/acpi/tables.c	Mon Jan 12 15:37:12 2004
@@ -262,10 +262,17 @@
 
 	/* Map the DSDT header via the pointer in the FADT */
 	if (id == ACPI_DSDT) {
-		struct acpi_table_fadt *fadt = (struct acpi_table_fadt *) *header;
+		struct fadt_descriptor_rev2 *fadt = (struct fadt_descriptor_rev2 *) *header;
+
+		if (fadt->revision == 3 && fadt->Xdsdt) {
+			*header = (void *) __acpi_map_table(fadt->Xdsdt,
+					sizeof(struct acpi_table_header));
+		} else if (fadt->V1_dsdt) {
+			*header = (void *) __acpi_map_table(fadt->V1_dsdt,
+					sizeof(struct acpi_table_header));
+		} else
+			*header = 0;
 
-		*header = (void *) __acpi_map_table(fadt->dsdt_addr,
-				sizeof(struct acpi_table_header));
 		if (!*header) {
 			printk(KERN_WARNING PREFIX "Unable to map DSDT\n");
 			return -ENODEV;





-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
