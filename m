From: Robert Vollmert <rvollmert-lists-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: bug report: multi-byte access in indexfields broken [patch]
Date: Mon, 22 Sep 2003 19:29:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030922172956.GA11120@krikkit>
References: <20030921200525.GB2968@krikkit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030921200525.GB2968-duT3ICHXG/I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Here's a patch.

--- exfldio.c.orig	2003-09-22 18:22:09.000000000 +0200
+++ exfldio.c	2003-09-22 19:16:11.000000000 +0200
@@ -346,6 +346,7 @@
 {
 	acpi_status                     status;
 	acpi_integer                    local_value;
+	acpi_integer                    index_field_value;
 
 
 	ACPI_FUNCTION_TRACE_U32 ("ex_field_datum_io", field_datum_byte_offset);
@@ -448,18 +449,22 @@
 
 	case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
+		/* Compute index value to access the current datum */
+
+		index_field_value = (acpi_integer) obj_desc->index_field.value
+			+ field_datum_byte_offset;
 
 		/* Ensure that the index_value is not beyond the capacity of the register */
 
 		if (acpi_ex_register_overflow (obj_desc->index_field.index_obj,
-				  (acpi_integer) obj_desc->index_field.value)) {
+					       index_field_value)) {
 			return_ACPI_STATUS (AE_AML_REGISTER_LIMIT);
 		}
 
 		/* Write the index value to the index_register (itself a region_field) */
 
 		status = acpi_ex_insert_into_field (obj_desc->index_field.index_obj,
-				 &obj_desc->index_field.value,
+				 &index_field_value,
 				 sizeof (obj_desc->index_field.value));
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
