From: Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
Subject: Re: DSDT > 128k support
Date: Wed, 17 Nov 2004 23:11:50 +0900 (JST)
Message-ID: <20041117.231150.41631846.t-kochi@bq.jp.nec.com>
References: <20041117.230831.74752627.t-kochi@bq.jp.nec.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041117.230831.74752627.t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
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

Oops, forgot to attach the patch.

Signed-off-by: Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>

---
Takayoshi Kochi

Index: 2.6.10-rc/drivers/acpi/system.c
===================================================================
--- 2.6.10-rc/drivers/acpi/system.c	(revision 58)
+++ 2.6.10-rc/drivers/acpi/system.c	(working copy)
@@ -27,6 +27,8 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
+#include <acpi/acpi.h>
+#include <acpi/actables.h>
 #include <acpi/acpi_drivers.h>
 
 
@@ -91,18 +93,17 @@
 	loff_t			*ppos)
 {
 	acpi_status		status = AE_OK;
-	struct acpi_buffer	dsdt = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_table_header *tbl_ptr;
 	ssize_t			res;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_dsdt");
 
-	status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
+	status = acpi_tb_get_table_ptr(ACPI_TABLE_DSDT, 1, &tbl_ptr);
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
 
 	res = simple_read_from_buffer(buffer, count, ppos,
-				      dsdt.pointer, dsdt.length);
-	acpi_os_free(dsdt.pointer);
+				      tbl_ptr, tbl_ptr->length);
 
 	return_VALUE(res);
 }
@@ -122,18 +123,17 @@
 	loff_t			*ppos)
 {
 	acpi_status		status = AE_OK;
-	struct acpi_buffer	fadt = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_table_header *tbl_ptr;
 	ssize_t			res;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_fadt");
 
-	status = acpi_get_table(ACPI_TABLE_FADT, 1, &fadt);
+	status = acpi_tb_get_table_ptr(ACPI_TABLE_FADT, 1, &tbl_ptr);
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
 
 	res = simple_read_from_buffer(buffer, count, ppos,
-				      fadt.pointer, fadt.length);
-	acpi_os_free(fadt.pointer);
+				      tbl_ptr, tbl_ptr->length);
 
 	return_VALUE(res);
 }


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
