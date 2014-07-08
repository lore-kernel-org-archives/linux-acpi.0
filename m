From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/25] ACPICA: Utilities: Cleanup DEFINE_ACPI_GLOBALS by moving acpi_ut_init_global() from utglobal.c to utinit.c.
Date: Tue,  8 Jul 2014 10:06:39 +0800
Message-ID: <3b6d8e30dbbf1ce057dbd33dfa41c5be1979b645.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50452 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbaGHCGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:06:53 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The utglobal.c is used to define and initialize global variables.  It makes
sense if just adding utglobal.o to applications that are using such
variables. But acpi_ut_init_globals() is preventing us from doing so as
this initialization function references other components' initializations
code, which leads to the requirement that many files should also get linked
if one wants to link utglobal.o.

It is possible to just move acpi_ut_init_global() to utinit.c for
applications that require this function to link.

By linking utglobal.o, we can stop defining DEFINE_ACPI_GLOBALS for
applications (currently only acpidump is affected). Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utglobal.c             |  146 ----------------------------
 drivers/acpi/acpica/utinit.c               |  146 ++++++++++++++++++++++++++++
 tools/power/acpi/Makefile                  |    1 +
 tools/power/acpi/tools/acpidump/acpidump.h |    1 -
 4 files changed, 147 insertions(+), 147 deletions(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index d69be3c..77ceac7 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -214,152 +214,6 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS] =
 };
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_init_globals
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Initialize ACPICA globals. All globals that require specific
- *              initialization should be initialized here. This allows for
- *              a warm restart.
- *
- ******************************************************************************/
-
-acpi_status acpi_ut_init_globals(void)
-{
-	acpi_status status;
-	u32 i;
-
-	ACPI_FUNCTION_TRACE(ut_init_globals);
-
-	/* Create all memory caches */
-
-	status = acpi_ut_create_caches();
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Address Range lists */
-
-	for (i = 0; i < ACPI_ADDRESS_RANGE_MAX; i++) {
-		acpi_gbl_address_range_list[i] = NULL;
-	}
-
-	/* Mutex locked flags */
-
-	for (i = 0; i < ACPI_NUM_MUTEX; i++) {
-		acpi_gbl_mutex_info[i].mutex = NULL;
-		acpi_gbl_mutex_info[i].thread_id = ACPI_MUTEX_NOT_ACQUIRED;
-		acpi_gbl_mutex_info[i].use_count = 0;
-	}
-
-	for (i = 0; i < ACPI_NUM_OWNERID_MASKS; i++) {
-		acpi_gbl_owner_id_mask[i] = 0;
-	}
-
-	/* Last owner_ID is never valid */
-
-	acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS - 1] = 0x80000000;
-
-	/* Event counters */
-
-	acpi_method_count = 0;
-	acpi_sci_count = 0;
-	acpi_gpe_count = 0;
-
-	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
-		acpi_fixed_event_count[i] = 0;
-	}
-
-#if (!ACPI_REDUCED_HARDWARE)
-
-	/* GPE/SCI support */
-
-	acpi_gbl_all_gpes_initialized = FALSE;
-	acpi_gbl_gpe_xrupt_list_head = NULL;
-	acpi_gbl_gpe_fadt_blocks[0] = NULL;
-	acpi_gbl_gpe_fadt_blocks[1] = NULL;
-	acpi_current_gpe_count = 0;
-
-	acpi_gbl_global_event_handler = NULL;
-	acpi_gbl_sci_handler_list = NULL;
-
-#endif				/* !ACPI_REDUCED_HARDWARE */
-
-	/* Global handlers */
-
-	acpi_gbl_global_notify[0].handler = NULL;
-	acpi_gbl_global_notify[1].handler = NULL;
-	acpi_gbl_exception_handler = NULL;
-	acpi_gbl_init_handler = NULL;
-	acpi_gbl_table_handler = NULL;
-	acpi_gbl_interface_handler = NULL;
-
-	/* Global Lock support */
-
-	acpi_gbl_global_lock_semaphore = NULL;
-	acpi_gbl_global_lock_mutex = NULL;
-	acpi_gbl_global_lock_acquired = FALSE;
-	acpi_gbl_global_lock_handle = 0;
-	acpi_gbl_global_lock_present = FALSE;
-
-	/* Miscellaneous variables */
-
-	acpi_gbl_DSDT = NULL;
-	acpi_gbl_cm_single_step = FALSE;
-	acpi_gbl_shutdown = FALSE;
-	acpi_gbl_ns_lookup_count = 0;
-	acpi_gbl_ps_find_count = 0;
-	acpi_gbl_acpi_hardware_present = TRUE;
-	acpi_gbl_last_owner_id_index = 0;
-	acpi_gbl_next_owner_id_offset = 0;
-	acpi_gbl_trace_dbg_level = 0;
-	acpi_gbl_trace_dbg_layer = 0;
-	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
-	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
-	acpi_gbl_osi_mutex = NULL;
-	acpi_gbl_reg_methods_executed = FALSE;
-
-	/* Hardware oriented */
-
-	acpi_gbl_events_initialized = FALSE;
-	acpi_gbl_system_awake_and_running = TRUE;
-
-	/* Namespace */
-
-	acpi_gbl_module_code_list = NULL;
-	acpi_gbl_root_node = NULL;
-	acpi_gbl_root_node_struct.name.integer = ACPI_ROOT_NAME;
-	acpi_gbl_root_node_struct.descriptor_type = ACPI_DESC_TYPE_NAMED;
-	acpi_gbl_root_node_struct.type = ACPI_TYPE_DEVICE;
-	acpi_gbl_root_node_struct.parent = NULL;
-	acpi_gbl_root_node_struct.child = NULL;
-	acpi_gbl_root_node_struct.peer = NULL;
-	acpi_gbl_root_node_struct.object = NULL;
-
-#ifdef ACPI_DISASSEMBLER
-	acpi_gbl_external_list = NULL;
-	acpi_gbl_num_external_methods = 0;
-	acpi_gbl_resolved_external_methods = 0;
-#endif
-
-#ifdef ACPI_DEBUG_OUTPUT
-	acpi_gbl_lowest_stack_pointer = ACPI_CAST_PTR(acpi_size, ACPI_SIZE_MAX);
-#endif
-
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-	acpi_gbl_display_final_mem_stats = FALSE;
-	acpi_gbl_disable_mem_tracking = FALSE;
-#endif
-
-	ACPI_DEBUGGER_EXEC(acpi_gbl_db_terminate_threads = FALSE);
-
-	return_ACPI_STATUS(AE_OK);
-}
-
 /* Public globals */
 
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 5f56fc4..a793662 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -102,6 +102,152 @@ static void acpi_ut_free_gpe_lists(void)
 }
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_init_globals
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Initialize ACPICA globals. All globals that require specific
+ *              initialization should be initialized here. This allows for
+ *              a warm restart.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_init_globals(void)
+{
+	acpi_status status;
+	u32 i;
+
+	ACPI_FUNCTION_TRACE(ut_init_globals);
+
+	/* Create all memory caches */
+
+	status = acpi_ut_create_caches();
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Address Range lists */
+
+	for (i = 0; i < ACPI_ADDRESS_RANGE_MAX; i++) {
+		acpi_gbl_address_range_list[i] = NULL;
+	}
+
+	/* Mutex locked flags */
+
+	for (i = 0; i < ACPI_NUM_MUTEX; i++) {
+		acpi_gbl_mutex_info[i].mutex = NULL;
+		acpi_gbl_mutex_info[i].thread_id = ACPI_MUTEX_NOT_ACQUIRED;
+		acpi_gbl_mutex_info[i].use_count = 0;
+	}
+
+	for (i = 0; i < ACPI_NUM_OWNERID_MASKS; i++) {
+		acpi_gbl_owner_id_mask[i] = 0;
+	}
+
+	/* Last owner_ID is never valid */
+
+	acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS - 1] = 0x80000000;
+
+	/* Event counters */
+
+	acpi_method_count = 0;
+	acpi_sci_count = 0;
+	acpi_gpe_count = 0;
+
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+		acpi_fixed_event_count[i] = 0;
+	}
+
+#if (!ACPI_REDUCED_HARDWARE)
+
+	/* GPE/SCI support */
+
+	acpi_gbl_all_gpes_initialized = FALSE;
+	acpi_gbl_gpe_xrupt_list_head = NULL;
+	acpi_gbl_gpe_fadt_blocks[0] = NULL;
+	acpi_gbl_gpe_fadt_blocks[1] = NULL;
+	acpi_current_gpe_count = 0;
+
+	acpi_gbl_global_event_handler = NULL;
+	acpi_gbl_sci_handler_list = NULL;
+
+#endif				/* !ACPI_REDUCED_HARDWARE */
+
+	/* Global handlers */
+
+	acpi_gbl_global_notify[0].handler = NULL;
+	acpi_gbl_global_notify[1].handler = NULL;
+	acpi_gbl_exception_handler = NULL;
+	acpi_gbl_init_handler = NULL;
+	acpi_gbl_table_handler = NULL;
+	acpi_gbl_interface_handler = NULL;
+
+	/* Global Lock support */
+
+	acpi_gbl_global_lock_semaphore = NULL;
+	acpi_gbl_global_lock_mutex = NULL;
+	acpi_gbl_global_lock_acquired = FALSE;
+	acpi_gbl_global_lock_handle = 0;
+	acpi_gbl_global_lock_present = FALSE;
+
+	/* Miscellaneous variables */
+
+	acpi_gbl_DSDT = NULL;
+	acpi_gbl_cm_single_step = FALSE;
+	acpi_gbl_shutdown = FALSE;
+	acpi_gbl_ns_lookup_count = 0;
+	acpi_gbl_ps_find_count = 0;
+	acpi_gbl_acpi_hardware_present = TRUE;
+	acpi_gbl_last_owner_id_index = 0;
+	acpi_gbl_next_owner_id_offset = 0;
+	acpi_gbl_trace_dbg_level = 0;
+	acpi_gbl_trace_dbg_layer = 0;
+	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
+	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
+	acpi_gbl_osi_mutex = NULL;
+	acpi_gbl_reg_methods_executed = FALSE;
+
+	/* Hardware oriented */
+
+	acpi_gbl_events_initialized = FALSE;
+	acpi_gbl_system_awake_and_running = TRUE;
+
+	/* Namespace */
+
+	acpi_gbl_module_code_list = NULL;
+	acpi_gbl_root_node = NULL;
+	acpi_gbl_root_node_struct.name.integer = ACPI_ROOT_NAME;
+	acpi_gbl_root_node_struct.descriptor_type = ACPI_DESC_TYPE_NAMED;
+	acpi_gbl_root_node_struct.type = ACPI_TYPE_DEVICE;
+	acpi_gbl_root_node_struct.parent = NULL;
+	acpi_gbl_root_node_struct.child = NULL;
+	acpi_gbl_root_node_struct.peer = NULL;
+	acpi_gbl_root_node_struct.object = NULL;
+
+#ifdef ACPI_DISASSEMBLER
+	acpi_gbl_external_list = NULL;
+	acpi_gbl_num_external_methods = 0;
+	acpi_gbl_resolved_external_methods = 0;
+#endif
+
+#ifdef ACPI_DEBUG_OUTPUT
+	acpi_gbl_lowest_stack_pointer = ACPI_CAST_PTR(acpi_size, ACPI_SIZE_MAX);
+#endif
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+	acpi_gbl_display_final_mem_stats = FALSE;
+	acpi_gbl_disable_mem_tracking = FALSE;
+#endif
+
+	ACPI_DEBUGGER_EXEC(acpi_gbl_db_terminate_threads = FALSE);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_ut_terminate
diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index e5a3c4b..61446db 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -112,6 +112,7 @@ DUMP_OBJS = \
 	tbxfroot.o\
 	utbuffer.o\
 	utexcep.o\
+	utglobal.o\
 	utmath.o\
 	utstring.o\
 	utxferror.o\
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 46f5195..8efc848 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -47,7 +47,6 @@
 #ifdef _DECLARE_GLOBALS
 #define EXTERN
 #define INIT_GLOBAL(a,b)        a=b
-#define DEFINE_ACPI_GLOBALS     1
 #else
 #define EXTERN                  extern
 #define INIT_GLOBAL(a,b)        a
-- 
1.7.10

