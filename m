From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: OSLayer cleanup
Date: Wed, 28 Aug 2002 10:01:14 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020829020107.CBIQC0A82654.59A07363@mvf.biglobe.ne.jp>
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

While auditing the OSL code in the current ACPI driver,
I found some obsolete functions.  If this looks reasonable,
please apply.

In include/acpiosxf.h:
  acpi_os_get_timer()
  acpi_os_redirect_output()
  acpi_os_dbg_assert()

  These 3 functions are declared but not defined.

In osl.c
  acpi_os_callocate()
  acpi_os_breakpoint()

  These 2 functions are obsolete.

  acpi_os_load_module()
  acpi_os_unload_module()

  These 2 functions are not declared in acpiosxf.h and no one
  is using these APIs.  What are they for?

Index: acpi-2.5/drivers/acpi/osl.c
diff -u acpi-2.5/drivers/acpi/osl.c:1.1.1.1 acpi-2.5/drivers/acpi/osl.c:1.1.1.1.2.1
--- acpi-2.5/drivers/acpi/osl.c:1.1.1.1	Wed Aug 28 00:13:27 2002
+++ acpi-2.5/drivers/acpi/osl.c	Wed Aug 28 00:43:16 2002
@@ -133,16 +133,6 @@
 	return kmalloc(size, GFP_KERNEL);
 }
 
-void *
-acpi_os_callocate(ACPI_SIZE size)
-{
-	void *ptr = acpi_os_allocate(size);
-	if (ptr)
-		memset(ptr, 0, size);
-
-	return ptr;
-}
-
 void
 acpi_os_free(void *ptr)
 {
@@ -516,37 +506,6 @@
 
 #endif /*CONFIG_ACPI_PCI*/
 
-acpi_status
-acpi_os_load_module (
-	char *module_name)
-{
-	ACPI_FUNCTION_TRACE ("os_load_module");
-
-	if (!module_name)
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-
-	if (request_module(module_name) < 0) {
-		ACPI_DEBUG_PRINT ((ACPI_DB_WARN, "Unable to load module [%s].\n", module_name));
-		return_ACPI_STATUS (AE_ERROR);
-	}
-
-	return_ACPI_STATUS (AE_OK);
-}
-
-acpi_status
-acpi_os_unload_module (
-	char *module_name)
-{
-	if (!module_name)
-		return AE_BAD_PARAMETER;
-
-	/* TODO: How on Linux? */
-	/* this is done automatically for all modules with
-	use_count = 0, I think. see: MOD_INC_USE_COUNT -ASG */
-
-	return AE_OK;
-}
-
 
 /*
  * See acpi_os_queue_for_execution()
@@ -688,9 +647,10 @@
 
 	ACPI_FUNCTION_TRACE ("os_create_semaphore");
 
-	sem = acpi_os_callocate(sizeof(struct semaphore));
+	sem = acpi_os_allocate(sizeof(struct semaphore));
 	if (!sem)
 		return_ACPI_STATUS (AE_NO_MEMORY);
+	memset(sem, 0, sizeof(struct semaphore));
 
 	sema_init(sem, initial_units);
 
@@ -906,12 +866,3 @@
 
 	return AE_OK;
 }
-
-acpi_status
-acpi_os_breakpoint(NATIVE_CHAR *msg)
-{
-	acpi_os_printf("breakpoint: %s", msg);
-	
-	return AE_OK;
-}
-
Index: acpi-2.5/drivers/acpi/include/acpiosxf.h
diff -u acpi-2.5/drivers/acpi/include/acpiosxf.h:1.1.1.1 acpi-2.5/drivers/acpi/include/acpiosxf.h:1.1.1.1.2.1
--- acpi-2.5/drivers/acpi/include/acpiosxf.h:1.1.1.1	Wed Aug 28 00:13:27 2002
+++ acpi-2.5/drivers/acpi/include/acpiosxf.h	Wed Aug 28 00:43:23 2002
@@ -261,10 +261,6 @@
 	void                    *pointer,
 	u32                     length);
 
-u32
-acpi_os_get_timer (
-	void);
-
 acpi_status
 acpi_os_signal (
 	u32                     function,
@@ -284,10 +280,6 @@
 	const NATIVE_CHAR       *format,
 	va_list                 args);
 
-void
-acpi_os_redirect_output (
-	void                    *destination);
-
 
 /*
  * Debug input
@@ -296,18 +288,6 @@
 u32
 acpi_os_get_line (
 	NATIVE_CHAR             *buffer);
-
-
-/*
- * Debug
- */
-
-void
-acpi_os_dbg_assert(
-	void                    *failed_assertion,
-	void                    *file_name,
-	u32                     line_number,
-	NATIVE_CHAR             *message);
 
 
 #endif /* __ACPIOSXF_H__ */


Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
