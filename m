From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/20] ACPICA: AcpiSrc: Fix indentation issues for macro invocations.
Date: Tue, 29 Oct 2013 09:30:22 +0800
Message-ID: <2720b17a7deda3738b14ecd2765c8d36740f6e91.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49358 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2Bab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:31 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

During the linuxizing process, some extra white spaces are added by the
"indent" program at the beginning of the line which is an invocation of a
macro and there is no ";" at the end of the line.

This patch adds new mode to AcpiSrc to remove extra spaces inserted before
invoking such macros and add an empty line between the invocations of such
macros (like the other function declarations).  This new mode is executed
after executing "indent" during the Linux release process.

The affected macros and files are:
 1. ACPI_HW_DEPENDENT_RETURN (acpixf.h/acdebug.h/acevents.h):
    This macro is used as a wrapper for hardware dependent APIs to offer a
    stub when the reduced hardware is configured during compilation.
 2. ACPI_EXPORT_SYMBOL (utglobal.c):
    This macro is used by Linux to export symbols to be found by Linux
    modules.  All such invocations are well formatted except those exported
    as global variables.

This can help to reduce the source code differences between Linux and
ACPICA, and also help to automate the release process.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    3 ++-
 drivers/acpi/acpica/acevents.h |    3 ++-
 drivers/acpi/acpica/utcache.c  |    2 +-
 drivers/acpi/acpica/utglobal.c |    3 +++
 include/acpi/acpixf.h          |   22 +++++++++++++++++-----
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 57cdc77..a9fd0b8 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -113,7 +113,8 @@ void acpi_db_display_handlers(void);
 ACPI_HW_DEPENDENT_RETURN_VOID(void
 			      acpi_db_generate_gpe(char *gpe_arg,
 						   char *block_arg))
- ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_generate_sci(void))
+
+ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_generate_sci(void))
 
 /*
  * dbconvert - miscellaneous conversion routines
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 3ae5fd0..41abe55 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -71,7 +71,8 @@ acpi_status acpi_ev_init_global_lock_handler(void);
 
 ACPI_HW_DEPENDENT_RETURN_OK(acpi_status
 			    acpi_ev_acquire_global_lock(u16 timeout))
- ACPI_HW_DEPENDENT_RETURN_OK(acpi_status acpi_ev_release_global_lock(void))
+
+ACPI_HW_DEPENDENT_RETURN_OK(acpi_status acpi_ev_release_global_lock(void))
  acpi_status acpi_ev_remove_global_lock_handler(void);
 
 /*
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index a877a96..366bfec 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -65,7 +65,7 @@ ACPI_MODULE_NAME("utcache")
 acpi_status
 acpi_os_create_cache(char *cache_name,
 		     u16 object_size,
-		     u16 max_depth, struct acpi_memory_list ** return_cache)
+		     u16 max_depth, struct acpi_memory_list **return_cache)
 {
 	struct acpi_memory_list *cache;
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 4f59784..77caa4f 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -378,6 +378,9 @@ acpi_status acpi_ut_init_globals(void)
 /* Public globals */
 
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
+
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
+
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+
 ACPI_EXPORT_SYMBOL(acpi_current_gpe_count)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9759bd5..cb2e744 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -54,6 +54,7 @@
 #include <acpi/acbuffer.h>
 
 extern u8 acpi_gbl_permanent_mmap;
+extern u32 acpi_rsdt_forced;
 
 /*
  * Globals that are publically available
@@ -110,7 +111,6 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
-extern u32 acpi_rsdt_forced;
 /*
  * Initialization
  */
@@ -130,9 +130,10 @@ acpi_status acpi_terminate(void);
  * Miscellaneous global interfaces
  */
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable(void))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
 #ifdef ACPI_FUTURE_USAGE
-acpi_status acpi_subsystem_status(void);
+ acpi_status acpi_subsystem_status(void);
 #endif
 
 #ifdef ACPI_FUTURE_USAGE
@@ -172,7 +173,7 @@ acpi_status acpi_load_tables(void);
  */
 acpi_status acpi_reallocate_root_table(void);
 
-acpi_status acpi_find_root_pointer(acpi_size *rsdp_address);
+acpi_status acpi_find_root_pointer(acpi_size * rsdp_address);
 
 acpi_status acpi_unload_table_id(acpi_owner_id id);
 
@@ -184,6 +185,7 @@ acpi_status
 acpi_get_table_with_size(acpi_string signature,
 	       u32 instance, struct acpi_table_header **out_table,
 	       acpi_size *tbl_size);
+
 acpi_status
 acpi_get_table(acpi_string signature,
 	       u32 instance, struct acpi_table_header **out_table);
@@ -274,13 +276,16 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_install_sci_handler(acpi_sci_handler
 							 address,
 							 void *context))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_sci_handler(acpi_sci_handler
 							 address))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_global_event_handler
 				 (acpi_gbl_event_handler handler,
 				  void *context))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_fixed_event_handler(u32
 								  acpi_event,
@@ -288,10 +293,12 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 								  handler,
 								  void
 								  *context))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_fixed_event_handler(u32 acpi_event,
 								 acpi_event_handler
 								 handler))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_gpe_handler(acpi_handle
 							  gpe_device,
@@ -300,6 +307,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							  acpi_gpe_handler
 							  address,
 							  void *context))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_gpe_handler(acpi_handle gpe_device,
 							 u32 gpe_number,
@@ -336,6 +344,7 @@ acpi_status acpi_install_interface_handler(acpi_interface_handler handler);
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_acquire_global_lock(u16 timeout,
 							 u32 *handle))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_release_global_lock(u32 handle))
 
@@ -362,6 +371,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_event_status(u32 event,
 						      acpi_event_status
 						      *event_status))
+
 /*
  * General Purpose Event (GPE) Interfaces
  */
@@ -392,10 +402,12 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							parent_device,
 							acpi_handle gpe_device,
 							u32 gpe_number))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_set_gpe_wake_mask(acpi_handle gpe_device,
 							u32 gpe_number,
 							u8 action))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_get_gpe_status(acpi_handle gpe_device,
 						     u32 gpe_number,
@@ -417,6 +429,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						       *gpe_block_address,
 						       u32 register_count,
 						       u32 interrupt_number))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_gpe_block(acpi_handle gpe_device))
 
@@ -491,7 +504,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
  * Sleep/Wake interfaces
  */
 acpi_status
-acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
+acpi_get_sleep_type_data(u8 sleep_state, u8 *slp_typ_a, u8 *slp_typ_b);
 
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
@@ -506,7 +519,6 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state);
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_set_firmware_waking_vector(u32
 								physical_address))
-
 #if ACPI_MACHINE_WIDTH == 64
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_set_firmware_waking_vector64(u64
-- 
1.7.10

