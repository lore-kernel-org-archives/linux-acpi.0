From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Debugging with 2.4 patch
Date: Mon, 30 Sep 2002 19:34:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033407278.377.1.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_RiF61KjuJkTbu82v8UdLqw)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_RiF61KjuJkTbu82v8UdLqw)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hi,

when trying to debug the thermal-related oops on my athlon system (see
CALL FOR TESTING thread) I noticed the following

* Some functions in acpi/utilities/utdebug.c do not get compiled it even
if CONFIG_ACPI_DEBUG is set [1], because ACPI_DEBUG_OUTPUT does not get
set in acpi/utilities/Makefile. 

* I assume that in acpi/acpi_ksyms.c the above mentioned function
symbols then should be exported if ACPI_DEBUG_OUTPUT is set not if
ACPI_DEBUG is set. Though I did not double-check. 

* In case that ACPI_DEBUG_OUTPUT is to replace ACPI_DEBUG that should
happen for the proc interface stuff in acpi/system.c too.

Patch is attached.

Regards
-Knut

[1] which causes /sbin/modprobe thermal to fail, because of missing
symbols.

-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105








--Boundary_(ID_RiF61KjuJkTbu82v8UdLqw)
Content-type: text/x-patch; charset=ISO-8859-1; name=debug_all.patch
Content-disposition: attachment; filename=debug_all.patch
Content-transfer-encoding: 7BIT

diff -ur linux-2.4.20-pre7-acpi.virgin/drivers/acpi/acpi_ksyms.c linux-2.4.20-pre7-acpi/drivers/acpi/acpi_ksyms.c
--- linux-2.4.20-pre7-acpi.virgin/drivers/acpi/acpi_ksyms.c	Mon Sep 30 19:15:02 2002
+++ linux-2.4.20-pre7-acpi/drivers/acpi/acpi_ksyms.c	Mon Sep 30 19:17:54 2002
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
+#endif /* ACPI_DEBUG_OUTPUT */
 
 EXPORT_SYMBOL(acpi_get_handle);
 EXPORT_SYMBOL(acpi_get_parent);
diff -ur linux-2.4.20-pre7-acpi.virgin/drivers/acpi/system.c linux-2.4.20-pre7-acpi/drivers/acpi/system.c
--- linux-2.4.20-pre7-acpi.virgin/drivers/acpi/system.c	Mon Sep 30 19:15:03 2002
+++ linux-2.4.20-pre7-acpi/drivers/acpi/system.c	Mon Sep 30 19:17:14 2002
@@ -892,8 +892,7 @@
 
 #endif /*CONFIG_ACPI_SLEEP*/
 
-#ifdef ACPI_DEBUG
-
+#ifdef ACPI_DEBUG_OUTPUT
 	/* 'debug_layer' [R/W] */
 	entry = create_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER,
 		S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
diff -ur linux-2.4.20-pre7-acpi.virgin/drivers/acpi/utilities/Makefile linux-2.4.20-pre7-acpi/drivers/acpi/utilities/Makefile
--- linux-2.4.20-pre7-acpi.virgin/drivers/acpi/utilities/Makefile	Mon Sep 30 19:15:03 2002
+++ linux-2.4.20-pre7-acpi/drivers/acpi/utilities/Makefile	Mon Sep 30 18:48:03 2002
@@ -6,6 +6,10 @@
 
 obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
 
+ifdef CONFIG_ACPI_DEBUG
+  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
+endif
+
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
 include $(TOPDIR)/Rules.make

--Boundary_(ID_RiF61KjuJkTbu82v8UdLqw)--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
