From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: [PATCH] Large /proc/acpi/dsdt fails
Date: Wed, 11 Sep 2002 17:27:54 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020912092738.JAMRC0A82654.59A07363@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE46@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE46-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 11 Sep 2002 13:50:35 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
> > The current /proc/acpi/dsdt reader function uses acpi_get_table() API
> > to get DSDT.  The API uses acpi_os_malloc (that is, kmalloc) to
> > allocate a buffer to copy the whole table.
> > 
> > This is not so good because:
> >  1. kmalloc will fail if DSDT is larger than 128K
> >  2. the copy is redundant
> > 
> > So I changed the /proc/acpi/{dsdt,fadt} functions from two-copy
> > to single-copy so that you can avoid extra kmalloc.
> 
> It avoids the extra kmalloc but uses a variable that is not part of the
> external interpreter interface - it is "private". C lets us down here
> because it does not have "module-level" globals, only per-file and global.

Okay.

> So I don't think the extra copy is a big deal, but maybe we want to figure
> out a way to allow larger than 128K DSDTs through this interface.
> acpi_system_read_dsdt could allocate a suitable sized buffer via vmalloc and
> pass that to acpi_get_table, possibly?

I'd think that is a hack and not a clean solution if we consider
future maintenanceability (some people may wonder and say "why use
vmalloc? use ACPI_ALLOCATE_BUFFER!").

How about this patch?
I made a new API, acpi_get_table_pointer().

Though there's a similar API (acpi_get_firmware_table() ),
it seems not to handle DSDT correctly... (returns AE_NO_EXIST)

Index: acpi-2419/drivers/acpi/acpi_ksyms.c
===================================================================
RCS file: /data/cvsroot/lia64-2.4/drivers/acpi/acpi_ksyms.c,v
retrieving revision 1.1.1.7.6.1
diff -u -r1.1.1.7.6.1 acpi_ksyms.c
--- acpi-2419/drivers/acpi/acpi_ksyms.c	25 Aug 2002 01:34:14 -0000	1.1.1.7.6.1
+++ acpi-2419/drivers/acpi/acpi_ksyms.c	12 Sep 2002 00:25:05 -0000
@@ -62,6 +62,7 @@
 EXPORT_SYMBOL(acpi_get_next_object);
 EXPORT_SYMBOL(acpi_evaluate_object);
 EXPORT_SYMBOL(acpi_get_table);
+EXPORT_SYMBOL(acpi_get_table_pointer);
 EXPORT_SYMBOL(acpi_get_firmware_table);
 EXPORT_SYMBOL(acpi_install_notify_handler);
 EXPORT_SYMBOL(acpi_remove_notify_handler);
Index: acpi-2419/drivers/acpi/system.c
===================================================================
RCS file: /data/cvsroot/lia64-2.4/drivers/acpi/system.c,v
retrieving revision 1.1.1.1.8.2
diff -u -r1.1.1.1.8.2 system.c
--- acpi-2419/drivers/acpi/system.c	31 Aug 2002 22:48:33 -0000	1.1.1.1.8.2
+++ acpi-2419/drivers/acpi/system.c	12 Sep 2002 00:25:05 -0000
@@ -293,30 +293,27 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	acpi_status		status = AE_OK;
-	acpi_buffer		dsdt = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status		status;
 	void			*data = 0;
 	size_t			size = 0;
+	acpi_table_header	*dsdt;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_dsdt");
 
-	status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
+	status = acpi_get_table_pointer(ACPI_TABLE_DSDT, 1, &dsdt);
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
 
-	if (*ppos < dsdt.length) {
-		data = dsdt.pointer + file->f_pos;
-		size = dsdt.length - file->f_pos;
+	if (*ppos < dsdt->length) {
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
@@ -336,29 +333,28 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	acpi_status		status = AE_OK;
-	acpi_buffer		fadt = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status		status;
 	void			*data = 0;
 	size_t			size = 0;
+	acpi_table_header	*fadt;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_fadt");
 
-	status = acpi_get_table(ACPI_TABLE_FADT, 1, &fadt);
+	status = acpi_get_table_pointer(ACPI_TABLE_FADT, 1, &fadt);
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
 
-	if (*ppos < fadt.length) {
-		data = fadt.pointer + file->f_pos;
-		size = fadt.length - file->f_pos;
+	/* non-null fadt is guaranteed in acpi_get_table_pointer */
+
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
 
Index: acpi-2419/drivers/acpi/include/acpixf.h
===================================================================
RCS file: /data/cvsroot/lia64-2.4/drivers/acpi/include/acpixf.h,v
retrieving revision 1.1.1.7.8.1
diff -u -r1.1.1.7.8.1 acpixf.h
--- acpi-2419/drivers/acpi/include/acpixf.h	25 Aug 2002 01:34:15 -0000	1.1.1.7.8.1
+++ acpi-2419/drivers/acpi/include/acpixf.h	12 Sep 2002 00:25:05 -0000
@@ -131,6 +131,12 @@
 	acpi_buffer             *ret_buffer);
 
 acpi_status
+acpi_get_table_pointer (
+	acpi_table_type         table_type,
+	u32                     instance,
+	acpi_table_header       **out_table_pointer);
+
+acpi_status
 acpi_get_firmware_table (
 	acpi_string             signature,
 	u32                     instance,
Index: acpi-2419/drivers/acpi/tables/tbxface.c
===================================================================
RCS file: /data/cvsroot/lia64-2.4/drivers/acpi/tables/tbxface.c,v
retrieving revision 1.1.1.7.8.1
diff -u -r1.1.1.7.8.1 tbxface.c
--- acpi-2419/drivers/acpi/tables/tbxface.c	25 Aug 2002 01:34:16 -0000	1.1.1.7.8.1
+++ acpi-2419/drivers/acpi/tables/tbxface.c	12 Sep 2002 00:25:05 -0000
@@ -423,3 +423,65 @@
 }
 
 
+/*******************************************************************************
+ *
+ * FUNCTION:    Acpi_get_table_pointer
+ *
+ * PARAMETERS:  Table_type      - one of the defined table types
+ *              Instance        - the non zero instance of the table, allows
+ *                                support for multiple tables of the same type
+ *                                see Acpi_gbl_Acpi_table_flag
+ *              Out_table_pointer - pointer to the table if successful
+ *
+ * DESCRIPTION: This function is called to get a pointer of an ACPI table.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_get_table_pointer (
+	acpi_table_type         table_type,
+	u32                     instance,
+	acpi_table_header       **out_table_pointer)
+{
+	acpi_table_header       *tbl_ptr;
+	acpi_status             status;
+
+
+	ACPI_FUNCTION_TRACE ("Acpi_get_table_pointer");
+
+
+	if ((instance == 0)                 ||
+		(!out_table_pointer)) {
+		return_ACPI_STATUS (AE_BAD_PARAMETER);
+	}
+
+	/* Check the table type and instance */
+
+	if ((table_type > ACPI_TABLE_MAX)   ||
+		(ACPI_IS_SINGLE_TABLE (acpi_gbl_acpi_table_data[table_type].flags) &&
+		 instance > 1)) {
+		return_ACPI_STATUS (AE_BAD_PARAMETER);
+	}
+
+
+	/* Get a pointer to the entire table */
+
+	status = acpi_tb_get_table_ptr (table_type, instance, &tbl_ptr);
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
+
+	/*
+	 * The function will return a NULL pointer if the table is not loaded
+	 */
+	if (tbl_ptr == NULL) {
+		return_ACPI_STATUS (AE_NOT_EXIST);
+	}
+
+	/*
+	 * Copy the pointer to caller's variable
+	 */
+	*out_table_pointer = tbl_ptr;
+
+	return_ACPI_STATUS (status);
+}



Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
In remembrance
www.osdn.com/911/
