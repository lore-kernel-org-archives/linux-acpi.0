From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: [PATCH] Large /proc/acpi/dsdt fails
Date: Wed, 11 Sep 2002 13:16:30 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020912051613.FCYRC0A8264C.1C79D883@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

The current /proc/acpi/dsdt reader function uses acpi_get_table() API
to get DSDT.  The API uses acpi_os_malloc (that is, kmalloc) to
allocate a buffer to copy the whole table.

This is not so good because:
 1. kmalloc will fail if DSDT is larger than 128K
 2. the copy is redundant

So I changed the /proc/acpi/{dsdt,fadt} functions from two-copy
to single-copy so that you can avoid extra kmalloc.

If this looks good, please apply.
(This patch is generated against 2.4.19, but applies 2.5-series with
some offset)

Index: acpi-2419/drivers/acpi/system.c
===================================================================
RCS file: /data/cvsroot/lia64-2.4/drivers/acpi/system.c,v
retrieving revision 1.1.1.1.8.2
diff -u -r1.1.1.1.8.2 system.c
--- acpi-2419/drivers/acpi/system.c	31 Aug 2002 22:48:33 -0000	1.1.1.1.8.2
+++ acpi-2419/drivers/acpi/system.c	11 Sep 2002 20:07:14 -0000
@@ -293,30 +293,24 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	acpi_status		status = AE_OK;
-	acpi_buffer		dsdt = {ACPI_ALLOCATE_BUFFER, NULL};
 	void			*data = 0;
 	size_t			size = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_dsdt");
 
-	status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
-	if (ACPI_FAILURE(status))
+	if (!acpi_gbl_DSDT)
 		return_VALUE(-ENODEV);
 
-	if (*ppos < dsdt.length) {
-		data = dsdt.pointer + file->f_pos;
-		size = dsdt.length - file->f_pos;
+	if (*ppos < acpi_gbl_DSDT->length) {
+		data = (char *) acpi_gbl_DSDT + file->f_pos;
+		size = acpi_gbl_DSDT->length - file->f_pos;
 		if (size > count)
 			size = count;
 		if (copy_to_user(buffer, data, size)) {
-			acpi_os_free(dsdt.pointer);
 			return_VALUE(-EFAULT);
 		}
 	}
 
-	acpi_os_free(dsdt.pointer);
-
 	*ppos += size;
 
 	return_VALUE(size);
@@ -336,29 +330,25 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	acpi_status		status = AE_OK;
-	acpi_buffer		fadt = {ACPI_ALLOCATE_BUFFER, NULL};
 	void			*data = 0;
 	size_t			size = 0;
+	acpi_table_header	*fadt;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_fadt");
 
-	status = acpi_get_table(ACPI_TABLE_FADT, 1, &fadt);
-	if (ACPI_FAILURE(status))
+	fadt = acpi_gbl_acpi_tables[ACPI_TABLE_FADT].pointer;
+	if (!fadt)
 		return_VALUE(-ENODEV);
 
-	if (*ppos < fadt.length) {
-		data = fadt.pointer + file->f_pos;
-		size = fadt.length - file->f_pos;
+	if (*ppos < fadt->length) {
+		data = (char *) fadt + file->f_pos;
+		size = fadt->length - file->f_pos;
 		if (size > count)
 			size = count;
 		if (copy_to_user(buffer, data, size)) {
-			acpi_os_free(fadt.pointer);
 			return_VALUE(-EFAULT);
 		}
 	}
-
-	acpi_os_free(fadt.pointer);
 
 	*ppos += size;
 



Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
In remembrance
www.osdn.com/911/
