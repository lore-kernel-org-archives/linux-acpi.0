From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: [PATCH][20020918/2.4.20-pre7] ACPI_DEBUG / ACPI_DEBUG_OUTPUT
Date: Fri, 20 Sep 2002 19:56:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020920195621.A509@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ACPI_DEBUG was not defined anywhere anymore, so /proc/acpi/dbg_level and
dbg_layer were missing (among a few other things). This patch replaces
ACPI_DEBUG with the new ACPI_DEBUG_OUTPUT.

	Dominik

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi_debug.diff"

--- linux/drivers/acpi/utils.c.original	Fri Sep 20 19:48:11 2002
+++ linux/drivers/acpi/utils.c	Fri Sep 20 19:49:38 2002
@@ -39,7 +39,7 @@
                             Object Evaluation Helpers
    -------------------------------------------------------------------------- */
 
-#ifdef ACPI_DEBUG
+#ifdef ACPI_DEBUG_OUTPUT
 #define acpi_util_eval_error(h,p,s) {\
 	char prefix[80] = {'\0'};\
 	acpi_buffer buffer = {sizeof(prefix), prefix};\
--- linux/drivers/acpi/system.c.original	Fri Sep 20 19:47:15 2002
+++ linux/drivers/acpi/system.c	Fri Sep 20 19:50:24 2002
@@ -366,7 +366,7 @@
 }
 
 
-#ifdef ACPI_DEBUG
+#ifdef ACPI_DEBUG_OUTPUT
 
 static int
 acpi_system_read_debug (
@@ -440,7 +440,7 @@
 	return_VALUE(count);
 }
 
-#endif /* ACPI_DEBUG */
+#endif /* ACPI_DEBUG_OUTPUT */
 
 
 #ifdef CONFIG_ACPI_SLEEP
@@ -892,7 +892,7 @@
 
 #endif /*CONFIG_ACPI_SLEEP*/
 
-#ifdef ACPI_DEBUG
+#ifdef ACPI_DEBUG_OUTPUT
 
 	/* 'debug_layer' [R/W] */
 	entry = create_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER,
@@ -920,7 +920,7 @@
 		entry->data = (void *) 1;
 	}
 
-#endif /*ACPI_DEBUG*/
+#endif /*ACPI_DEBUG_OUTPUT */
 
 	return_VALUE(0);
 }
@@ -942,7 +942,7 @@
 	remove_proc_entry(ACPI_SYSTEM_FILE_SLEEP, acpi_device_dir(device));
 	remove_proc_entry(ACPI_SYSTEM_FILE_ALARM, acpi_device_dir(device));
 #endif
-#ifdef ACPI_DEBUG
+#ifdef ACPI_DEBUG_OUTPUT
 	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER,
 		acpi_device_dir(device));
 	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LEVEL,
--- linux/drivers/acpi/acpi_ksyms.c.original	Fri Sep 20 19:48:03 2002
+++ linux/drivers/acpi/acpi_ksyms.c	Fri Sep 20 19:50:44 2002
@@ -43,7 +43,7 @@
 
 /* ACPI Core Subsystem */
 
-#ifdef ACPI_DEBUG
+#ifdef ACPI_DEBUG_OUTPUT
 EXPORT_SYMBOL(acpi_dbg_layer);
 EXPORT_SYMBOL(acpi_dbg_level);
 EXPORT_SYMBOL(acpi_ut_debug_print_raw);
@@ -52,7 +52,7 @@
 EXPORT_SYMBOL(acpi_ut_value_exit);
 EXPORT_SYMBOL(acpi_ut_exit);
 EXPORT_SYMBOL(acpi_ut_trace);
-#endif /*ACPI_DEBUG*/
+#endif /*ACPI_DEBUG_OUTPUT*/
 
 EXPORT_SYMBOL(acpi_get_handle);
 EXPORT_SYMBOL(acpi_get_parent);

--GvXjxJ+pjyke8COw--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
