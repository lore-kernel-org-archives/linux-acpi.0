From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/26] ACPICA: Fix unmerged debugger divergences.
Date: Wed, 31 Oct 2012 10:25:15 +0800
Message-ID: <fe8422b40d27b35116ad26a5e5d1ca226e562c3a.1351649950.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4599 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2JaCZW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:25:22 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>

Debugger improvements in ACPICA are always ignored by ACPICA Linux
release.  This will lead to divergences between Linux and ACPICA.
This patch fixes such unmerged debugger updates.

Following patches are included:
1. Fixed a couple compiler warnings for extra extern
   Wed, 14 Mar 2007 21:12:19 +0000
2. Cleanup for internal Reference Object.
   Wed, 27 Aug 2008 10:11:30 -0700
3. Debugger: Lock method args for multithread command.
   Fri, 24 Apr 2009 12:28:49 -0700
4. Debugger: Add max count argument for Batch command.
   Tue, 29 Sep 2009 12:31:58 -0700
5. Add new host interfaces for _OSI support.
   Thu, 5 Aug 2010 14:18:28 -0700
6. Increase debugger buffer size for method return objects.
   Wed, 17 Nov 2010 13:48:30 -0800
7. Debugger: Add command to display status of global handlers.
   Tue, 25 Jan 2011 13:47:58 -0800
8. Debugger: Split large dbcmds.c file.
   Wed, 26 Jan 2011 13:03:41 -0800
9. Debugger/AcpiExec: Add support to pass complex args to methods.
   Tue, 17 May 2011 13:33:39 -0700
10.Debugger: Add Template command to dump resource templates.
   Fri, 28 Oct 2011 14:18:51 -0700
11.Support for custom ACPICA build for ACPI 5.0 reduced hardware.
   Wed, 1 Feb 2012 13:18:17 -0800
12.Debugger: Improve command help support.
   Wed, 15 Feb 2012 07:59:26 -0800
13.Update ACPI_HW_DEPENDENT* macro invocations.
   Wed, 15 Feb 2012 08:14:08 -0800
14.Debugger: Rename function to simplify source code conversion.
   Wed, 13 Jun 2012 14:23:06 -0700
15.Debugger: Enhance "Tables" and "Unload" commands.
   Fri, 29 Jun 2012 13:10:58 -0700
16.Debugger: update prototype for AcpiDbSleep function.
   Fri, 17 Aug 2012 13:43:02 -0700

This patch will not affect the generated vmlinx binary.
This will decrease 264 lines of 20120913 divergence.diff.

Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |   94 ++++++++++++++++++++++++++--------------
 drivers/acpi/acpica/acglobal.h |   69 +++++++++++++++--------------
 drivers/acpi/acpica/aclocal.h  |    2 +
 include/acpi/acconfig.h        |    1 +
 4 files changed, 101 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 5e8abb0..432a318 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -44,17 +44,28 @@
 #ifndef __ACDEBUG_H__
 #define __ACDEBUG_H__
 
-#define ACPI_DEBUG_BUFFER_SIZE  4196
+#define ACPI_DEBUG_BUFFER_SIZE  0x4000	/* 16K buffer for return objects */
 
-struct command_info {
+struct acpi_db_command_info {
 	char *name;		/* Command Name */
 	u8 min_args;		/* Minimum arguments required */
 };
 
-struct argument_info {
+struct acpi_db_command_help {
+	u8 line_count;		/* Number of help lines */
+	char *invocation;	/* Command Invocation */
+	char *description;	/* Command Description */
+};
+
+struct acpi_db_argument_info {
 	char *name;		/* Argument Name */
 };
 
+struct acpi_db_execute_walk {
+	u32 count;
+	u32 max_count;
+};
+
 #define PARAM_LIST(pl)                  pl
 #define DBTEST_OUTPUT_LEVEL(lvl)        if (acpi_gbl_db_opt_verbose)
 #define VERBOSE_PRINT(fp)               DBTEST_OUTPUT_LEVEL(lvl) {\
@@ -77,59 +88,71 @@ acpi_db_single_step(struct acpi_walk_state *walk_state,
 /*
  * dbcmds - debug commands and output routines
  */
-acpi_status acpi_db_disassemble_method(char *name);
+struct acpi_namespace_node *acpi_db_convert_to_node(char *in_string);
 
 void acpi_db_display_table_info(char *table_arg);
 
-void acpi_db_unload_acpi_table(char *table_arg, char *instance_arg);
+void acpi_db_display_template(char *buffer_arg);
 
-void
-acpi_db_set_method_breakpoint(char *location,
-			      struct acpi_walk_state *walk_state,
-			      union acpi_parse_object *op);
+void acpi_db_unload_acpi_table(char *name);
 
-void acpi_db_set_method_call_breakpoint(union acpi_parse_object *op);
+void acpi_db_send_notify(char *name, u32 value);
 
-void acpi_db_get_bus_info(void);
+void acpi_db_display_interfaces(char *action_arg, char *interface_name_arg);
 
-void acpi_db_disassemble_aml(char *statements, union acpi_parse_object *op);
+acpi_status acpi_db_sleep(char *object_arg);
 
-void acpi_db_dump_namespace(char *start_arg, char *depth_arg);
+void acpi_db_display_locks(void);
 
-void acpi_db_dump_namespace_by_owner(char *owner_arg, char *depth_arg);
+void acpi_db_display_resources(char *object_arg);
 
-void acpi_db_send_notify(char *name, u32 value);
+ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_display_gpes(void))
+
+void acpi_db_display_handlers(void);
+
+ACPI_HW_DEPENDENT_RETURN_VOID(void
+			      acpi_db_generate_gpe(char *gpe_arg,
+						   char *block_arg))
+
+/*
+ * dbmethod - control method commands
+ */
+void
+acpi_db_set_method_breakpoint(char *location,
+			      struct acpi_walk_state *walk_state,
+			      union acpi_parse_object *op);
+
+void acpi_db_set_method_call_breakpoint(union acpi_parse_object *op);
 
 void acpi_db_set_method_data(char *type_arg, char *index_arg, char *value_arg);
 
-acpi_status
-acpi_db_display_objects(char *obj_type_arg, char *display_count_arg);
+acpi_status acpi_db_disassemble_method(char *name);
 
-void acpi_db_display_interfaces(char *action_arg, char *interface_name_arg);
+void acpi_db_disassemble_aml(char *statements, union acpi_parse_object *op);
 
-acpi_status acpi_db_find_name_in_namespace(char *name_arg);
+void acpi_db_batch_execute(char *count_arg);
 
+/*
+ * dbnames - namespace commands
+ */
 void acpi_db_set_scope(char *name);
 
-ACPI_HW_DEPENDENT_RETURN_OK(acpi_status acpi_db_sleep(char *object_arg))
+void acpi_db_dump_namespace(char *start_arg, char *depth_arg);
 
-void acpi_db_find_references(char *object_arg);
+void acpi_db_dump_namespace_by_owner(char *owner_arg, char *depth_arg);
 
-void acpi_db_display_locks(void);
+acpi_status acpi_db_find_name_in_namespace(char *name_arg);
 
-void acpi_db_display_resources(char *object_arg);
+void acpi_db_check_predefined_names(void);
 
-ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_display_gpes(void))
+acpi_status
+acpi_db_display_objects(char *obj_type_arg, char *display_count_arg);
 
 void acpi_db_check_integrity(void);
 
-ACPI_HW_DEPENDENT_RETURN_VOID(void
-			      acpi_db_generate_gpe(char *gpe_arg,
-						   char *block_arg))
-
-void acpi_db_check_predefined_names(void);
+void acpi_db_find_references(char *object_arg);
 
-void acpi_db_batch_execute(void);
+void acpi_db_get_bus_info(void);
 
 /*
  * dbdisply - debug display commands
@@ -161,7 +184,8 @@ acpi_db_display_argument_object(union acpi_operand_object *obj_desc,
 /*
  * dbexec - debugger control method execution
  */
-void acpi_db_execute(char *name, char **args, u32 flags);
+void
+acpi_db_execute(char *name, char **args, acpi_object_type * types, u32 flags);
 
 void
 acpi_db_create_execution_threads(char *num_threads_arg,
@@ -175,7 +199,8 @@ u32 acpi_db_get_cache_info(struct acpi_memory_list *cache);
  * dbfileio - Debugger file I/O commands
  */
 acpi_object_type
-acpi_db_match_argument(char *user_argument, struct argument_info *arguments);
+acpi_db_match_argument(char *user_argument,
+		       struct acpi_db_argument_info *arguments);
 
 void acpi_db_close_debug_file(void);
 
@@ -208,6 +233,11 @@ acpi_db_command_dispatch(char *input_buffer,
 
 void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context);
 
+acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op);
+
+char *acpi_db_get_next_token(char *string,
+			     char **next, acpi_object_type * return_type);
+
 /*
  * dbstats - Generation and display of ACPI table statistics
  */
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ce79100..fe20e18 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -155,26 +155,6 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_no_resource_disassembly, FALSE);
 
 /*****************************************************************************
  *
- * Debug support
- *
- ****************************************************************************/
-
-/* Procedure nesting level for debug output */
-
-extern u32 acpi_gbl_nesting_level;
-
-ACPI_EXTERN u32 acpi_gpe_count;
-ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
-
-/* Support for dynamic control method tracing mechanism */
-
-ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
-ACPI_EXTERN u32 acpi_gbl_original_dbg_layer;
-ACPI_EXTERN u32 acpi_gbl_trace_dbg_level;
-ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
-
-/*****************************************************************************
- *
  * ACPI Table globals
  *
  ****************************************************************************/
@@ -259,15 +239,6 @@ ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE reg
  *
  ****************************************************************************/
 
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-
-/* Lists for tracking memory allocations */
-
-ACPI_EXTERN struct acpi_memory_list *acpi_gbl_global_list;
-ACPI_EXTERN struct acpi_memory_list *acpi_gbl_ns_node_list;
-ACPI_EXTERN u8 acpi_gbl_display_final_mem_stats;
-#endif
-
 /* Object caches */
 
 ACPI_EXTERN acpi_cache_t *acpi_gbl_namespace_cache;
@@ -326,6 +297,15 @@ extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
 
 #endif
 
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+
+/* Lists for tracking memory allocations */
+
+ACPI_EXTERN struct acpi_memory_list *acpi_gbl_global_list;
+ACPI_EXTERN struct acpi_memory_list *acpi_gbl_ns_node_list;
+ACPI_EXTERN u8 acpi_gbl_display_final_mem_stats;
+#endif
+
 /*****************************************************************************
  *
  * Namespace globals
@@ -403,6 +383,28 @@ ACPI_EXTERN void *acpi_gbl_global_event_handler_context;
 
 /*****************************************************************************
  *
+ * Debug support
+ *
+ ****************************************************************************/
+
+/* Procedure nesting level for debug output */
+
+extern u32 acpi_gbl_nesting_level;
+
+/* Event counters */
+
+ACPI_EXTERN u32 acpi_gpe_count;
+ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
+
+/* Support for dynamic control method tracing mechanism */
+
+ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
+ACPI_EXTERN u32 acpi_gbl_original_dbg_layer;
+ACPI_EXTERN u32 acpi_gbl_trace_dbg_level;
+ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
+
+/*****************************************************************************
+ *
  * Debugger globals
  *
  ****************************************************************************/
@@ -426,10 +428,11 @@ ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
 ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
 
 ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
-ACPI_EXTERN char acpi_gbl_db_line_buf[80];
-ACPI_EXTERN char acpi_gbl_db_parsed_buf[80];
-ACPI_EXTERN char acpi_gbl_db_scope_buf[40];
-ACPI_EXTERN char acpi_gbl_db_debug_filename[40];
+ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
+ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
+ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
+ACPI_EXTERN char acpi_gbl_db_scope_buf[80];
+ACPI_EXTERN char acpi_gbl_db_debug_filename[80];
 ACPI_EXTERN u8 acpi_gbl_db_output_to_file;
 ACPI_EXTERN char *acpi_gbl_db_buffer;
 ACPI_EXTERN char *acpi_gbl_db_filename;
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index c816ee6..b5a4651 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1031,6 +1031,7 @@ struct acpi_db_method_info {
 	acpi_handle method;
 	acpi_handle main_thread_gate;
 	acpi_handle thread_complete_gate;
+	acpi_handle info_gate;
 	acpi_thread_id *threads;
 	u32 num_threads;
 	u32 num_created;
@@ -1041,6 +1042,7 @@ struct acpi_db_method_info {
 	u32 num_loops;
 	char pathname[128];
 	char **args;
+	acpi_object_type *types;
 
 	/*
 	 * Arguments to be passed to method for the command
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 03f1485..0943457 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -241,6 +241,7 @@
  *****************************************************************************/
 
 #define ACPI_DEBUGGER_MAX_ARGS          8	/* Must be max method args + 1 */
+#define ACPI_DB_LINE_BUFFER_SIZE	512
 
 #define ACPI_DEBUGGER_COMMAND_PROMPT    '-'
 #define ACPI_DEBUGGER_EXECUTE_PROMPT    '%'
-- 
1.7.10

