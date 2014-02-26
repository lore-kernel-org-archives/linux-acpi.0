From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/18] ACPICA: Cleanup/improve global variable declarations.
Date: Wed, 26 Feb 2014 10:32:38 +0800
Message-ID: <35cc2d6903ecfcfa447e5a154eb850c61411fb1d.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65074 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaBZCdH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:33:07 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This change cleans up the entire global variable mechaninism including
the related macros. Also reduces warnings from the "sparse" utility
in the Linux environment. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |  353 +++++++++++++++++++---------------------
 drivers/acpi/acpica/utglobal.c |   37 ++---
 2 files changed, 189 insertions(+), 201 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 71b7e5f..6b45c44 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -53,11 +53,19 @@
  * to simplify maintenance of the code.
  */
 #ifdef DEFINE_ACPI_GLOBALS
-#define ACPI_EXTERN
-#define ACPI_INIT_GLOBAL(a,b) a=b
+#define ACPI_GLOBAL(type,name) \
+	extern type name; \
+	type name
+
+#define ACPI_INIT_GLOBAL(type,name,value) \
+	type name=value
+
 #else
-#define ACPI_EXTERN extern
-#define ACPI_INIT_GLOBAL(a,b) a
+#define ACPI_GLOBAL(type,name) \
+	extern type name
+
+#define ACPI_INIT_GLOBAL(type,name,value) \
+	extern type name
 #endif
 
 #ifdef DEFINE_ACPI_GLOBALS
@@ -84,7 +92,7 @@
  * 5) Allow unresolved references (invalid target name) in package objects
  * 6) Enable warning messages for behavior that is not ACPI spec compliant
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_interpreter_slack, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_interpreter_slack, FALSE);
 
 /*
  * Automatically serialize all methods that create named objects? Default
@@ -93,25 +101,25 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_interpreter_slack, FALSE);
  * that create named objects are marked Serialized in order to prevent
  * possible run-time problems if they are entered by more than one thread.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_auto_serialize_methods, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_auto_serialize_methods, TRUE);
 
 /*
  * Create the predefined _OSI method in the namespace? Default is TRUE
  * because ACPI CA is fully compatible with other ACPI implementations.
  * Changing this will revert ACPI CA (and machine ASL) to pre-OSI behavior.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_create_osi_method, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_create_osi_method, TRUE);
 
 /*
  * Optionally use default values for the ACPI register widths. Set this to
  * TRUE to use the defaults, if an FADT contains incorrect widths/lengths.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_use_default_register_widths, TRUE);
 
 /*
  * Optionally enable output from the AML Debug Object.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_aml_debug_object, FALSE);
 
 /*
  * Optionally copy the entire DSDT to local memory (instead of simply
@@ -119,7 +127,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
  * DSDT, creating the need for this option. Default is FALSE, do not copy
  * the DSDT.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_copy_dsdt_locally, FALSE);
 
 /*
  * Optionally ignore an XSDT if present and use the RSDT instead.
@@ -127,7 +135,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
  * of the RSDT, the XSDT has been found to be corrupt or ill-formed on
  * some machines. Default behavior is to use the XSDT if present.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_do_not_use_xsdt, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
 
 /*
  * Optionally use 32-bit FADT addresses if and when there is a conflict
@@ -137,7 +145,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_do_not_use_xsdt, FALSE);
  * some machines have been found to have a corrupted non-zero 64-bit
  * address. Default is FALSE, do not favor the 32-bit addresses.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_use32_bit_fadt_addresses, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_use32_bit_fadt_addresses, FALSE);
 
 /*
  * Optionally truncate I/O addresses to 16 bits. Provides compatibility
@@ -145,47 +153,28 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use32_bit_fadt_addresses, FALSE);
  * this value is set to TRUE if any Windows OSI strings have been
  * requested by the BIOS.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_truncate_io_addresses, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_truncate_io_addresses, FALSE);
 
 /*
  * Disable runtime checking and repair of values returned by control methods.
  * Use only if the repair is causing a problem on a particular machine.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_auto_repair, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_auto_repair, FALSE);
 
 /*
  * Optionally do not load any SSDTs from the RSDT/XSDT during initialization.
  * This can be useful for debugging ACPI problems on some machines.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_ssdt_table_load, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_ssdt_table_load, FALSE);
 
 /*
  * We keep track of the latest version of Windows that has been requested by
  * the BIOS.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_osi_data, 0);
-
-/* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
-
-struct acpi_table_fadt acpi_gbl_FADT;
-u32 acpi_current_gpe_count;
-u32 acpi_gbl_trace_flags;
-acpi_name acpi_gbl_trace_method_name;
-u8 acpi_gbl_system_awake_and_running;
-
-/*
- * ACPI 5.0 introduces the concept of a "reduced hardware platform", meaning
- * that the ACPI hardware is no longer required. A flag in the FADT indicates
- * a reduced HW machine, and that flag is duplicated here for convenience.
- */
-u8 acpi_gbl_reduced_hardware;
+ACPI_INIT_GLOBAL(u8, acpi_gbl_osi_data, 0);
 
 #endif				/* DEFINE_ACPI_GLOBALS */
 
-/* Do not disassemble buffers to resource descriptors */
-
-ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_no_resource_disassembly, FALSE);
-
 /*****************************************************************************
  *
  * ACPI Table globals
@@ -193,37 +182,36 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_no_resource_disassembly, FALSE);
  ****************************************************************************/
 
 /*
- * acpi_gbl_root_table_list is the master list of ACPI tables that were
- * found in the RSDT/XSDT.
+ * Master list of all ACPI tables that were found in the RSDT/XSDT.
  */
-ACPI_EXTERN struct acpi_table_list acpi_gbl_root_table_list;
+ACPI_GLOBAL(struct acpi_table_list, acpi_gbl_root_table_list);
+
+/* DSDT information. Used to check for DSDT corruption */
+
+ACPI_GLOBAL(struct acpi_table_header *, acpi_gbl_DSDT);
+ACPI_GLOBAL(struct acpi_table_header, acpi_gbl_original_dsdt_header);
 
 #if (!ACPI_REDUCED_HARDWARE)
-ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
+ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
 /* These addresses are calculated from the FADT Event Block addresses */
 
-ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_status;
-ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_enable;
-
-ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_status;
-ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
+ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1a_status);
+ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1a_enable);
 
-/* DSDT information. Used to check for DSDT corruption */
-
-ACPI_EXTERN struct acpi_table_header *acpi_gbl_DSDT;
-ACPI_EXTERN struct acpi_table_header acpi_gbl_original_dsdt_header;
+ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1b_status);
+ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1b_enable);
 
 /*
- * Handle both ACPI 1.0 and ACPI 2.0 Integer widths. The integer width is
+ * Handle both ACPI 1.0 and ACPI 2.0+ Integer widths. The integer width is
  * determined by the revision of the DSDT: If the DSDT revision is less than
  * 2, use only the lower 32 bits of the internal 64-bit Integer.
  */
-ACPI_EXTERN u8 acpi_gbl_integer_bit_width;
-ACPI_EXTERN u8 acpi_gbl_integer_byte_width;
-ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
+ACPI_GLOBAL(u8, acpi_gbl_integer_bit_width);
+ACPI_GLOBAL(u8, acpi_gbl_integer_byte_width);
+ACPI_GLOBAL(u8, acpi_gbl_integer_nybble_width);
 
 /*****************************************************************************
  *
@@ -236,36 +224,36 @@ ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
  * actual OS mutex handles, indexed by the local ACPI_MUTEX_HANDLEs.
  * (The table maps local handles to the real OS handles)
  */
-ACPI_EXTERN struct acpi_mutex_info acpi_gbl_mutex_info[ACPI_NUM_MUTEX];
+ACPI_GLOBAL(struct acpi_mutex_info, acpi_gbl_mutex_info[ACPI_NUM_MUTEX]);
 
 /*
  * Global lock mutex is an actual AML mutex object
  * Global lock semaphore works in conjunction with the actual global lock
  * Global lock spinlock is used for "pending" handshake
  */
-ACPI_EXTERN union acpi_operand_object *acpi_gbl_global_lock_mutex;
-ACPI_EXTERN acpi_semaphore acpi_gbl_global_lock_semaphore;
-ACPI_EXTERN acpi_spinlock acpi_gbl_global_lock_pending_lock;
-ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
-ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
-ACPI_EXTERN u8 acpi_gbl_global_lock_present;
-ACPI_EXTERN u8 acpi_gbl_global_lock_pending;
+ACPI_GLOBAL(union acpi_operand_object *, acpi_gbl_global_lock_mutex);
+ACPI_GLOBAL(acpi_semaphore, acpi_gbl_global_lock_semaphore);
+ACPI_GLOBAL(acpi_spinlock, acpi_gbl_global_lock_pending_lock);
+ACPI_GLOBAL(u16, acpi_gbl_global_lock_handle);
+ACPI_GLOBAL(u8, acpi_gbl_global_lock_acquired);
+ACPI_GLOBAL(u8, acpi_gbl_global_lock_present);
+ACPI_GLOBAL(u8, acpi_gbl_global_lock_pending);
 
 /*
  * Spinlocks are used for interfaces that can be possibly called at
  * interrupt level
  */
-ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
-ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
-ACPI_EXTERN acpi_spinlock acpi_gbl_reference_count_lock;
+ACPI_GLOBAL(acpi_spinlock, acpi_gbl_gpe_lock);	/* For GPE data structs and registers */
+ACPI_GLOBAL(acpi_spinlock, acpi_gbl_hardware_lock);	/* For ACPI H/W except GPE registers */
+ACPI_GLOBAL(acpi_spinlock, acpi_gbl_reference_count_lock);
 
 /* Mutex for _OSI support */
 
-ACPI_EXTERN acpi_mutex acpi_gbl_osi_mutex;
+ACPI_GLOBAL(acpi_mutex, acpi_gbl_osi_mutex);
 
 /* Reader/Writer lock is used for namespace walk and dynamic table unload */
 
-ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
+ACPI_GLOBAL(struct acpi_rw_lock, acpi_gbl_namespace_rw_lock);
 
 /*****************************************************************************
  *
@@ -275,70 +263,69 @@ ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
 
 /* Object caches */
 
-ACPI_EXTERN acpi_cache_t *acpi_gbl_namespace_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_state_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_ps_node_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_ps_node_ext_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_operand_cache;
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_namespace_cache);
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_state_cache);
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_ps_node_cache);
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_ps_node_ext_cache);
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_operand_cache);
+
+/* System */
+
+ACPI_INIT_GLOBAL(u32, acpi_gbl_startup_flags, 0);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_shutdown, TRUE);
 
 /* Global handlers */
 
-ACPI_EXTERN struct acpi_global_notify_handler acpi_gbl_global_notify[2];
-ACPI_EXTERN acpi_exception_handler acpi_gbl_exception_handler;
-ACPI_EXTERN acpi_init_handler acpi_gbl_init_handler;
-ACPI_EXTERN acpi_table_handler acpi_gbl_table_handler;
-ACPI_EXTERN void *acpi_gbl_table_handler_context;
-ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
-ACPI_EXTERN acpi_interface_handler acpi_gbl_interface_handler;
-ACPI_EXTERN struct acpi_sci_handler_info *acpi_gbl_sci_handler_list;
+ACPI_GLOBAL(struct acpi_global_notify_handler, acpi_gbl_global_notify[2]);
+ACPI_GLOBAL(acpi_exception_handler, acpi_gbl_exception_handler);
+ACPI_GLOBAL(acpi_init_handler, acpi_gbl_init_handler);
+ACPI_GLOBAL(acpi_table_handler, acpi_gbl_table_handler);
+ACPI_GLOBAL(void *, acpi_gbl_table_handler_context);
+ACPI_GLOBAL(struct acpi_walk_state *, acpi_gbl_breakpoint_walk);
+ACPI_GLOBAL(acpi_interface_handler, acpi_gbl_interface_handler);
+ACPI_GLOBAL(struct acpi_sci_handler_info *, acpi_gbl_sci_handler_list);
 
 /* Owner ID support */
 
-ACPI_EXTERN u32 acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS];
-ACPI_EXTERN u8 acpi_gbl_last_owner_id_index;
-ACPI_EXTERN u8 acpi_gbl_next_owner_id_offset;
+ACPI_GLOBAL(u32, acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS]);
+ACPI_GLOBAL(u8, acpi_gbl_last_owner_id_index);
+ACPI_GLOBAL(u8, acpi_gbl_next_owner_id_offset);
 
 /* Initialization sequencing */
 
-ACPI_EXTERN u8 acpi_gbl_reg_methods_executed;
+ACPI_GLOBAL(u8, acpi_gbl_reg_methods_executed);
 
 /* Misc */
 
-ACPI_EXTERN u32 acpi_gbl_original_mode;
-ACPI_EXTERN u32 acpi_gbl_rsdp_original_location;
-ACPI_EXTERN u32 acpi_gbl_ns_lookup_count;
-ACPI_EXTERN u32 acpi_gbl_ps_find_count;
-ACPI_EXTERN u16 acpi_gbl_pm1_enable_register_save;
-ACPI_EXTERN u8 acpi_gbl_debugger_configuration;
-ACPI_EXTERN u8 acpi_gbl_step_to_next_call;
-ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
-ACPI_EXTERN u8 acpi_gbl_events_initialized;
-ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
-ACPI_EXTERN struct acpi_address_range
-    *acpi_gbl_address_range_list[ACPI_ADDRESS_RANGE_MAX];
-
-#ifndef DEFINE_ACPI_GLOBALS
-
-/* Other miscellaneous */
-
-extern u8 acpi_gbl_shutdown;
-extern u32 acpi_gbl_startup_flags;
+ACPI_GLOBAL(u32, acpi_gbl_original_mode);
+ACPI_GLOBAL(u32, acpi_gbl_rsdp_original_location);
+ACPI_GLOBAL(u32, acpi_gbl_ns_lookup_count);
+ACPI_GLOBAL(u32, acpi_gbl_ps_find_count);
+ACPI_GLOBAL(u16, acpi_gbl_pm1_enable_register_save);
+ACPI_GLOBAL(u8, acpi_gbl_debugger_configuration);
+ACPI_GLOBAL(u8, acpi_gbl_step_to_next_call);
+ACPI_GLOBAL(u8, acpi_gbl_acpi_hardware_present);
+ACPI_GLOBAL(u8, acpi_gbl_events_initialized);
+ACPI_GLOBAL(struct acpi_interface_info *, acpi_gbl_supported_interfaces);
+ACPI_GLOBAL(struct acpi_address_range *,
+	    acpi_gbl_address_range_list[ACPI_ADDRESS_RANGE_MAX]);
+
+/* Other miscellaneous, declared and initialized in utglobal */
+
 extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
 extern const char *acpi_gbl_lowest_dstate_names[ACPI_NUM_sx_w_METHODS];
 extern const char *acpi_gbl_highest_dstate_names[ACPI_NUM_sx_d_METHODS];
-extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
 extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
-
-#endif
+extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 
-/* Lists for tracking memory allocations */
+/* Lists for tracking memory allocations (debug only) */
 
-ACPI_EXTERN struct acpi_memory_list *acpi_gbl_global_list;
-ACPI_EXTERN struct acpi_memory_list *acpi_gbl_ns_node_list;
-ACPI_EXTERN u8 acpi_gbl_display_final_mem_stats;
-ACPI_EXTERN u8 acpi_gbl_disable_mem_tracking;
+ACPI_GLOBAL(struct acpi_memory_list *, acpi_gbl_global_list);
+ACPI_GLOBAL(struct acpi_memory_list *, acpi_gbl_ns_node_list);
+ACPI_GLOBAL(u8, acpi_gbl_display_final_mem_stats);
+ACPI_GLOBAL(u8, acpi_gbl_disable_mem_tracking);
 #endif
 
 /*****************************************************************************
@@ -353,22 +340,23 @@ ACPI_EXTERN u8 acpi_gbl_disable_mem_tracking;
 #define NUM_PREDEFINED_NAMES            9
 #endif
 
-ACPI_EXTERN struct acpi_namespace_node acpi_gbl_root_node_struct;
-ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_root_node;
-ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_fadt_gpe_device;
-ACPI_EXTERN union acpi_operand_object *acpi_gbl_module_code_list;
+ACPI_GLOBAL(struct acpi_namespace_node, acpi_gbl_root_node_struct);
+ACPI_GLOBAL(struct acpi_namespace_node *, acpi_gbl_root_node);
+ACPI_GLOBAL(struct acpi_namespace_node *, acpi_gbl_fadt_gpe_device);
+ACPI_GLOBAL(union acpi_operand_object *, acpi_gbl_module_code_list);
 
 extern const u8 acpi_gbl_ns_properties[ACPI_NUM_NS_TYPES];
 extern const struct acpi_predefined_names
     acpi_gbl_pre_defined_names[NUM_PREDEFINED_NAMES];
 
 #ifdef ACPI_DEBUG_OUTPUT
-ACPI_EXTERN u32 acpi_gbl_current_node_count;
-ACPI_EXTERN u32 acpi_gbl_current_node_size;
-ACPI_EXTERN u32 acpi_gbl_max_concurrent_node_count;
-ACPI_EXTERN acpi_size *acpi_gbl_entry_stack_pointer;
-ACPI_EXTERN acpi_size *acpi_gbl_lowest_stack_pointer;
-ACPI_EXTERN u32 acpi_gbl_deepest_nesting;
+ACPI_GLOBAL(u32, acpi_gbl_current_node_count);
+ACPI_GLOBAL(u32, acpi_gbl_current_node_size);
+ACPI_GLOBAL(u32, acpi_gbl_max_concurrent_node_count);
+ACPI_GLOBAL(acpi_size *, acpi_gbl_entry_stack_pointer);
+ACPI_GLOBAL(acpi_size *, acpi_gbl_lowest_stack_pointer);
+ACPI_GLOBAL(u32, acpi_gbl_deepest_nesting);
+ACPI_INIT_GLOBAL(u32, acpi_gbl_nesting_level, 0);
 #endif
 
 /*****************************************************************************
@@ -377,11 +365,11 @@ ACPI_EXTERN u32 acpi_gbl_deepest_nesting;
  *
  ****************************************************************************/
 
-ACPI_EXTERN struct acpi_thread_state *acpi_gbl_current_walk_list;
+ACPI_GLOBAL(struct acpi_thread_state *, acpi_gbl_current_walk_list);
 
 /* Control method single step flag */
 
-ACPI_EXTERN u8 acpi_gbl_cm_single_step;
+ACPI_GLOBAL(u8, acpi_gbl_cm_single_step);
 
 /*****************************************************************************
  *
@@ -391,8 +379,9 @@ ACPI_EXTERN u8 acpi_gbl_cm_single_step;
 
 extern struct acpi_bit_register_info
     acpi_gbl_bit_register_info[ACPI_NUM_BITREG];
-ACPI_EXTERN u8 acpi_gbl_sleep_type_a;
-ACPI_EXTERN u8 acpi_gbl_sleep_type_b;
+
+ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a);
+ACPI_GLOBAL(u8, acpi_gbl_sleep_type_b);
 
 /*****************************************************************************
  *
@@ -402,14 +391,15 @@ ACPI_EXTERN u8 acpi_gbl_sleep_type_b;
 
 #if (!ACPI_REDUCED_HARDWARE)
 
-ACPI_EXTERN u8 acpi_gbl_all_gpes_initialized;
-ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
-ACPI_EXTERN struct acpi_gpe_block_info
-    *acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
-ACPI_EXTERN acpi_gbl_event_handler acpi_gbl_global_event_handler;
-ACPI_EXTERN void *acpi_gbl_global_event_handler_context;
-ACPI_EXTERN struct acpi_fixed_event_handler
-    acpi_gbl_fixed_event_handlers[ACPI_NUM_FIXED_EVENTS];
+ACPI_GLOBAL(u8, acpi_gbl_all_gpes_initialized);
+ACPI_GLOBAL(struct acpi_gpe_xrupt_info *, acpi_gbl_gpe_xrupt_list_head);
+ACPI_GLOBAL(struct acpi_gpe_block_info *,
+	    acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS]);
+ACPI_GLOBAL(acpi_gbl_event_handler, acpi_gbl_global_event_handler);
+ACPI_GLOBAL(void *, acpi_gbl_global_event_handler_context);
+ACPI_GLOBAL(struct acpi_fixed_event_handler,
+	    acpi_gbl_fixed_event_handlers[ACPI_NUM_FIXED_EVENTS]);
+
 extern struct acpi_fixed_event_info
     acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS];
 
@@ -421,23 +411,19 @@ extern struct acpi_fixed_event_info
  *
  ****************************************************************************/
 
-/* Procedure nesting level for debug output */
-
-extern u32 acpi_gbl_nesting_level;
-
 /* Event counters */
 
-ACPI_EXTERN u32 acpi_method_count;
-ACPI_EXTERN u32 acpi_gpe_count;
-ACPI_EXTERN u32 acpi_sci_count;
-ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
+ACPI_GLOBAL(u32, acpi_method_count);
+ACPI_GLOBAL(u32, acpi_gpe_count);
+ACPI_GLOBAL(u32, acpi_sci_count);
+ACPI_GLOBAL(u32, acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS]);
 
 /* Support for dynamic control method tracing mechanism */
 
-ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
-ACPI_EXTERN u32 acpi_gbl_original_dbg_layer;
-ACPI_EXTERN u32 acpi_gbl_trace_dbg_level;
-ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
+ACPI_GLOBAL(u32, acpi_gbl_original_dbg_level);
+ACPI_GLOBAL(u32, acpi_gbl_original_dbg_layer);
+ACPI_GLOBAL(u32, acpi_gbl_trace_dbg_level);
+ACPI_GLOBAL(u32, acpi_gbl_trace_dbg_layer);
 
 /*****************************************************************************
  *
@@ -445,61 +431,64 @@ ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
  *
  ****************************************************************************/
 
-ACPI_EXTERN u8 acpi_gbl_db_output_flags;
+ACPI_GLOBAL(u8, acpi_gbl_db_output_flags);
 
 #ifdef ACPI_DISASSEMBLER
 
-ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_ignore_noop_operator, FALSE);
+/* Do not disassemble buffers to resource descriptors */
+
+ACPI_INIT_GLOBAL(u8, acpi_gbl_no_resource_disassembly, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_ignore_noop_operator, FALSE);
 
-ACPI_EXTERN u8 acpi_gbl_db_opt_disasm;
-ACPI_EXTERN u8 acpi_gbl_db_opt_verbose;
-ACPI_EXTERN u8 acpi_gbl_num_external_methods;
-ACPI_EXTERN u32 acpi_gbl_resolved_external_methods;
-ACPI_EXTERN struct acpi_external_list *acpi_gbl_external_list;
-ACPI_EXTERN struct acpi_external_file *acpi_gbl_external_file_list;
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_disasm);
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_verbose);
+ACPI_GLOBAL(u8, acpi_gbl_num_external_methods);
+ACPI_GLOBAL(u32, acpi_gbl_resolved_external_methods);
+ACPI_GLOBAL(struct acpi_external_list *, acpi_gbl_external_list);
+ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
 #endif
 
 #ifdef ACPI_DEBUGGER
 
-extern u8 acpi_gbl_method_executing;
-extern u8 acpi_gbl_abort_method;
-extern u8 acpi_gbl_db_terminate_threads;
+ACPI_INIT_GLOBAL(u8, acpi_gbl_db_terminate_threads, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_abort_method, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_method_executing, FALSE);
 
-ACPI_EXTERN u8 acpi_gbl_db_opt_tables;
-ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
-ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
-ACPI_EXTERN u8 acpi_gbl_db_opt_no_region_support;
-ACPI_EXTERN u8 acpi_gbl_db_output_to_file;
-ACPI_EXTERN char *acpi_gbl_db_buffer;
-ACPI_EXTERN char *acpi_gbl_db_filename;
-ACPI_EXTERN u32 acpi_gbl_db_debug_level;
-ACPI_EXTERN u32 acpi_gbl_db_console_debug_level;
-ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_db_scope_node;
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_tables);
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_stats);
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_ini_methods);
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_region_support);
+ACPI_GLOBAL(u8, acpi_gbl_db_output_to_file);
+ACPI_GLOBAL(char *, acpi_gbl_db_buffer);
+ACPI_GLOBAL(char *, acpi_gbl_db_filename);
+ACPI_GLOBAL(u32, acpi_gbl_db_debug_level);
+ACPI_GLOBAL(u32, acpi_gbl_db_console_debug_level);
+ACPI_GLOBAL(struct acpi_namespace_node *, acpi_gbl_db_scope_node);
 
-ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
-ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
+ACPI_GLOBAL(char *, acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS]);
+ACPI_GLOBAL(acpi_object_type, acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS]);
 
 /* These buffers should all be the same size */
 
-ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
-ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
-ACPI_EXTERN char acpi_gbl_db_scope_buf[ACPI_DB_LINE_BUFFER_SIZE];
-ACPI_EXTERN char acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE];
+ACPI_GLOBAL(char, acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE]);
+ACPI_GLOBAL(char, acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE]);
+ACPI_GLOBAL(char, acpi_gbl_db_scope_buf[ACPI_DB_LINE_BUFFER_SIZE]);
+ACPI_GLOBAL(char, acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE]);
 
 /*
  * Statistic globals
  */
-ACPI_EXTERN u16 acpi_gbl_obj_type_count[ACPI_TYPE_NS_NODE_MAX + 1];
-ACPI_EXTERN u16 acpi_gbl_node_type_count[ACPI_TYPE_NS_NODE_MAX + 1];
-ACPI_EXTERN u16 acpi_gbl_obj_type_count_misc;
-ACPI_EXTERN u16 acpi_gbl_node_type_count_misc;
-ACPI_EXTERN u32 acpi_gbl_num_nodes;
-ACPI_EXTERN u32 acpi_gbl_num_objects;
-
-ACPI_EXTERN u32 acpi_gbl_size_of_parse_tree;
-ACPI_EXTERN u32 acpi_gbl_size_of_method_trees;
-ACPI_EXTERN u32 acpi_gbl_size_of_node_entries;
-ACPI_EXTERN u32 acpi_gbl_size_of_acpi_objects;
+ACPI_GLOBAL(u16, acpi_gbl_obj_type_count[ACPI_TYPE_NS_NODE_MAX + 1]);
+ACPI_GLOBAL(u16, acpi_gbl_node_type_count[ACPI_TYPE_NS_NODE_MAX + 1]);
+ACPI_GLOBAL(u16, acpi_gbl_obj_type_count_misc);
+ACPI_GLOBAL(u16, acpi_gbl_node_type_count_misc);
+ACPI_GLOBAL(u32, acpi_gbl_num_nodes);
+ACPI_GLOBAL(u32, acpi_gbl_num_objects);
+
+ACPI_GLOBAL(u32, acpi_gbl_size_of_parse_tree);
+ACPI_GLOBAL(u32, acpi_gbl_size_of_method_trees);
+ACPI_GLOBAL(u32, acpi_gbl_size_of_node_entries);
+ACPI_GLOBAL(u32, acpi_gbl_size_of_acpi_objects);
 
 #endif				/* ACPI_DEBUGGER */
 
@@ -511,7 +500,7 @@ ACPI_EXTERN u32 acpi_gbl_size_of_acpi_objects;
 
 #ifdef ACPI_APPLICATION
 
-ACPI_FILE ACPI_INIT_GLOBAL(acpi_gbl_debug_file, NULL);
+ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_debug_file, NULL);
 
 #endif				/* ACPI_APPLICATION */
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 21785da..f3abeae 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -55,31 +55,27 @@ ACPI_MODULE_NAME("utglobal")
  * Static global variable initialization.
  *
  ******************************************************************************/
-/*
- * We want the debug switches statically initialized so they
- * are already set when the debugger is entered.
- */
-/* Debug switch - level and trace mask */
+/* Debug output control masks */
 u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
 
-/* Debug switch - layer (component) mask */
-
 u32 acpi_dbg_layer = 0;
-u32 acpi_gbl_nesting_level = 0;
 
-/* Debugger globals */
+/* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
-u8 acpi_gbl_db_terminate_threads = FALSE;
-u8 acpi_gbl_abort_method = FALSE;
-u8 acpi_gbl_method_executing = FALSE;
+struct acpi_table_fadt acpi_gbl_FADT;
+u32 acpi_gbl_trace_flags;
+acpi_name acpi_gbl_trace_method_name;
+u8 acpi_gbl_system_awake_and_running;
+u32 acpi_current_gpe_count;
 
-/* System flags */
-
-u32 acpi_gbl_startup_flags = 0;
-
-/* System starts uninitialized */
+/*
+ * ACPI 5.0 introduces the concept of a "reduced hardware platform", meaning
+ * that the ACPI hardware is no longer required. A flag in the FADT indicates
+ * a reduced HW machine, and that flag is duplicated here for convenience.
+ */
+u8 acpi_gbl_reduced_hardware;
 
-u8 acpi_gbl_shutdown = TRUE;
+/* Various state name strings */
 
 const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT] = {
 	"\\_S0_",
@@ -335,7 +331,6 @@ acpi_status acpi_ut_init_globals(void)
 
 	acpi_gbl_DSDT = NULL;
 	acpi_gbl_cm_single_step = FALSE;
-	acpi_gbl_db_terminate_threads = FALSE;
 	acpi_gbl_shutdown = FALSE;
 	acpi_gbl_ns_lookup_count = 0;
 	acpi_gbl_ps_find_count = 0;
@@ -382,6 +377,10 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_disable_mem_tracking = FALSE;
 #endif
 
+#ifdef ACPI_DEBUGGER
+	acpi_gbl_db_terminate_threads = FALSE;
+#endif
+
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
1.7.10

