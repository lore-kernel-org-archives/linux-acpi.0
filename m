From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: [PATCH] Debugging memory deallocation ...
Date: Mon, 15 Sep 2003 20:49:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309152049.58283.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hi!

Following patch make acpi_ut_free_and_track function to CHECK address BEFORE deallocating it.


Hrvoje

--- /usr/src/linux-2.4.22/drivers/acpi/utilities/utalloc.c      2003-08-25 13:44:41.000000000 +0200
+++ utalloc.c   2003-09-15 20:46:37.000000000 +0200
@@ -564,7 +562,7 @@
        char                            *module,
        u32                             line)
 {
-       struct acpi_debug_mem_block     *debug_block;
+       struct acpi_debug_mem_block     *debug_block,*element;
        acpi_status                     status;


@@ -581,6 +579,13 @@
        debug_block = ACPI_CAST_PTR (struct acpi_debug_mem_block,
                          (((char *) allocation) - sizeof (struct acpi_debug_mem_header)));

+       element = acpi_ut_find_allocation (ACPI_MEM_LIST_GLOBAL, debug_block);
+       if( element == NULL )
+       {
+               ACPI_REPORT_ERROR (("Trying to free unallocated segment\n"))
+               return_VOID;
+       }
+
        acpi_gbl_memory_lists[ACPI_MEM_LIST_GLOBAL].total_freed++;
        acpi_gbl_memory_lists[ACPI_MEM_LIST_GLOBAL].current_total_size -= debug_block->size;



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
