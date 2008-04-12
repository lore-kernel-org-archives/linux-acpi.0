From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/73] ACPICA: Cosmetic changes only, no functional changes
Date: Sat, 12 Apr 2008 00:25:17 -0400
Message-ID: <c5a20d0e0dca90d4e5bc9aa79a9d408fe823761a.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20142 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752944AbYDLE2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:08 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Lint changes, fix compiler warnings, etc.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |   38 ++++++++++++++++-------------------
 drivers/acpi/dispatcher/dsobject.c |    4 ++-
 drivers/acpi/dispatcher/dsopcode.c |    2 +-
 drivers/acpi/dispatcher/dsutils.c  |   10 +++-----
 drivers/acpi/dispatcher/dswstate.c |    6 ++--
 drivers/acpi/executer/exconfig.c   |   10 ++++----
 drivers/acpi/executer/exdump.c     |   10 +++++++-
 drivers/acpi/executer/exfldio.c    |    3 +-
 drivers/acpi/executer/exregion.c   |    8 ++++--
 drivers/acpi/executer/exstore.c    |    6 +++-
 drivers/acpi/executer/exsystem.c   |    1 -
 drivers/acpi/executer/exutils.c    |    1 -
 drivers/acpi/parser/psopcode.c     |    3 +-
 include/acpi/acglobal.h            |    8 ++----
 include/acpi/acmacros.h            |   10 +++++++++
 include/acpi/actypes.h             |    2 +
 16 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 3db651c..7a99740 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -42,7 +42,6 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/acparser.h>
 #include <acpi/amlcode.h>
 #include <acpi/acdispat.h>
 #include <acpi/acinterp.h>
@@ -102,7 +101,7 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 						    walk_state->opcode,
 						    walk_state->aml_offset,
 						    NULL);
-		(void)acpi_ex_enter_interpreter();
+		acpi_ex_enter_interpreter();
 	}
 #ifdef ACPI_DISASSEMBLER
 	if (ACPI_FAILURE(status)) {
@@ -535,7 +534,6 @@ void
 acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 				 struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_terminate_control_method, walk_state);
 
@@ -550,29 +548,27 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		/* Delete all arguments and locals */
 
 		acpi_ds_method_data_delete_all(walk_state);
-	}
 
-	/*
-	 * If method is serialized, release the mutex and restore the
-	 * current sync level for this thread
-	 */
-	if (method_desc->method.mutex) {
+		/*
+		 * If method is serialized, release the mutex and restore the
+		 * current sync level for this thread
+		 */
+		if (method_desc->method.mutex) {
 
-		/* Acquisition Depth handles recursive calls */
+			/* Acquisition Depth handles recursive calls */
 
-		method_desc->method.mutex->mutex.acquisition_depth--;
-		if (!method_desc->method.mutex->mutex.acquisition_depth) {
-			walk_state->thread->current_sync_level =
-			    method_desc->method.mutex->mutex.
-			    original_sync_level;
+			method_desc->method.mutex->mutex.acquisition_depth--;
+			if (!method_desc->method.mutex->mutex.acquisition_depth) {
+				walk_state->thread->current_sync_level =
+				    method_desc->method.mutex->mutex.
+				    original_sync_level;
 
-			acpi_os_release_mutex(method_desc->method.mutex->mutex.
-					      os_mutex);
-			method_desc->method.mutex->mutex.thread_id = 0;
+				acpi_os_release_mutex(method_desc->method.
+						      mutex->mutex.os_mutex);
+				method_desc->method.mutex->mutex.thread_id = 0;
+			}
 		}
-	}
 
-	if (walk_state) {
 		/*
 		 * Delete any namespace objects created anywhere within
 		 * the namespace by the execution of this method
@@ -613,7 +609,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		 */
 		if ((method_desc->method.method_flags & AML_METHOD_SERIALIZED)
 		    && (!method_desc->method.mutex)) {
-			status = acpi_ds_create_method_mutex(method_desc);
+			(void)acpi_ds_create_method_mutex(method_desc);
 		}
 
 		/* No more threads, we can free the owner_id */
diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 7556d91..58d4d91 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -157,7 +157,9 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 			 * will remain as named references. This behavior is not described
 			 * in the ACPI spec, but it appears to be an oversight.
 			 */
-			obj_desc = (union acpi_operand_object *)op->common.node;
+			obj_desc =
+			    ACPI_CAST_PTR(union acpi_operand_object,
+					  op->common.node);
 
 			status =
 			    acpi_ex_resolve_node_to_value(ACPI_CAST_INDIRECT_PTR
diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 0c4630d..f0847ee 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -770,7 +770,7 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "RgnObj %p Addr %8.8X%8.8X Len %X\n",
 			  obj_desc,
-			  ACPI_FORMAT_UINT64(obj_desc->region.address),
+			  ACPI_FORMAT_NATIVE_UINT(obj_desc->region.address),
 			  obj_desc->region.length));
 
 	/* Now the address and length are valid for this opregion */
diff --git a/drivers/acpi/dispatcher/dsutils.c b/drivers/acpi/dispatcher/dsutils.c
index 36518b4..97d01dc 100644
--- a/drivers/acpi/dispatcher/dsutils.c
+++ b/drivers/acpi/dispatcher/dsutils.c
@@ -700,10 +700,9 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	acpi_status status = AE_OK;
 	union acpi_parse_object *arg;
 	union acpi_parse_object *arguments[ACPI_OBJ_NUM_OPERANDS];
-	u8 arg_count = 0;
-	u8 count = 0;
-	u8 index = walk_state->num_operands;
-	u8 i;
+	u32 arg_count = 0;
+	u32 index = walk_state->num_operands;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_create_operands, first_arg);
 
@@ -734,14 +733,13 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 
 		/* Force the filling of the operand stack in inverse order */
 
-		walk_state->operand_index = index;
+		walk_state->operand_index = (u8) index;
 
 		status = acpi_ds_create_operand(walk_state, arg, index);
 		if (ACPI_FAILURE(status)) {
 			goto cleanup;
 		}
 
-		count++;
 		index--;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
diff --git a/drivers/acpi/dispatcher/dswstate.c b/drivers/acpi/dispatcher/dswstate.c
index 698d2e1..4c402be 100644
--- a/drivers/acpi/dispatcher/dswstate.c
+++ b/drivers/acpi/dispatcher/dswstate.c
@@ -220,7 +220,7 @@ static acpi_status acpi_ds_result_stack_push(struct acpi_walk_state *walk_state)
 
 	/* Check for stack overflow */
 
-	if ((walk_state->result_size + ACPI_RESULTS_FRAME_OBJ_NUM) >
+	if (((u32) walk_state->result_size + ACPI_RESULTS_FRAME_OBJ_NUM) >
 	    ACPI_RESULTS_OBJ_NUM_MAX) {
 		ACPI_ERROR((AE_INFO, "Result stack overflow: State=%p Num=%X",
 			    walk_state, walk_state->result_size));
@@ -400,7 +400,7 @@ void
 acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 				 struct acpi_walk_state *walk_state)
 {
-	u32 i;
+	acpi_native_int i;
 	union acpi_operand_object *obj_desc;
 
 	ACPI_FUNCTION_NAME(ds_obj_stack_pop_and_delete);
@@ -409,7 +409,7 @@ acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 		return;
 	}
 
-	for (i = (pop_count - 1); i >= 0; i--) {
+	for (i = (acpi_native_int) (pop_count - 1); i >= 0; i--) {
 		if (walk_state->num_operands == 0) {
 			return;
 		}
diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 3370aad..52b1e95 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -45,7 +45,6 @@
 #include <acpi/acinterp.h>
 #include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
 #include <acpi/actables.h>
 #include <acpi/acdispat.h>
 
@@ -341,9 +340,10 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		/* Validate checksum here. It won't get validated in tb_add_table */
 
-		status = acpi_tb_verify_checksum((struct acpi_table_header *)
-						 obj_desc->buffer.pointer,
-						 length);
+		status =
+		    acpi_tb_verify_checksum(ACPI_CAST_PTR
+					    (struct acpi_table_header,
+					     obj_desc->buffer.pointer), length);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -468,7 +468,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	 * (Offset contains the table_id)
 	 */
 	acpi_tb_delete_namespace_by_owner(table_index);
-	acpi_tb_release_owner_id(table_index);
+	(void)acpi_tb_release_owner_id(table_index);
 
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index fcb1da0..e48d916 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -506,6 +506,12 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 				       obj_desc->reference.object);
 			break;
 
+		case AML_LOAD_OP:
+
+			acpi_os_printf("Reference: [DdbHandle] TableIndex %p\n",
+				       obj_desc->reference.object);
+			break;
+
 		case AML_REF_OF_OP:
 
 			acpi_os_printf("Reference: (RefOf) %p\n",
@@ -631,8 +637,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 			acpi_os_printf("\n");
 		} else {
 			acpi_os_printf(" base %8.8X%8.8X Length %X\n",
-				       ACPI_FORMAT_UINT64(obj_desc->region.
-							  address),
+				       ACPI_FORMAT_NATIVE_UINT(obj_desc->region.
+							       address),
 				       obj_desc->region.length);
 		}
 		break;
diff --git a/drivers/acpi/executer/exfldio.c b/drivers/acpi/executer/exfldio.c
index 65a48b6..1ece1c3 100644
--- a/drivers/acpi/executer/exfldio.c
+++ b/drivers/acpi/executer/exfldio.c
@@ -263,7 +263,8 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 			      rgn_desc->region.space_id,
 			      obj_desc->common_field.access_byte_width,
 			      obj_desc->common_field.base_byte_offset,
-			      field_datum_byte_offset, (void *)address));
+			      field_datum_byte_offset, ACPI_CAST_PTR(void,
+								     address)));
 
 	/* Invoke the appropriate address_space/op_region handler */
 
diff --git a/drivers/acpi/executer/exregion.c b/drivers/acpi/executer/exregion.c
index 3f51b7e..cbc6788 100644
--- a/drivers/acpi/executer/exregion.c
+++ b/drivers/acpi/executer/exregion.c
@@ -160,7 +160,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 		if (!mem_info->mapped_logical_address) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at %8.8X%8.8X, size %X",
-				    ACPI_FORMAT_UINT64(address),
+				    ACPI_FORMAT_NATIVE_UINT(address),
 				    (u32) window_size));
 			mem_info->mapped_length = 0;
 			return_ACPI_STATUS(AE_NO_MEMORY);
@@ -182,7 +182,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "System-Memory (width %d) R/W %d Address=%8.8X%8.8X\n",
-			  bit_width, function, ACPI_FORMAT_UINT64(address)));
+			  bit_width, function,
+			  ACPI_FORMAT_NATIVE_UINT(address)));
 
 	/*
 	 * Perform the memory read or write
@@ -284,7 +285,8 @@ acpi_ex_system_io_space_handler(u32 function,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "System-IO (width %d) R/W %d Address=%8.8X%8.8X\n",
-			  bit_width, function, ACPI_FORMAT_UINT64(address)));
+			  bit_width, function,
+			  ACPI_FORMAT_NATIVE_UINT(address)));
 
 	/* Decode the function parameter */
 
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index d860f9c..2408122 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -189,7 +189,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 		if (source_desc->reference.opcode == AML_LOAD_OP) {	/* Load and load_table */
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      " Table OwnerId %X\n",
+					      " Table OwnerId %p\n",
 					      source_desc->reference.object));
 			break;
 		}
@@ -213,7 +213,9 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 			    (source_desc->reference.node) !=
 			    ACPI_DESC_TYPE_NAMED) {
 				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-						      " %p - Not a valid namespace node\n"));
+						      " %p - Not a valid namespace node\n",
+						      source_desc->reference.
+						      node));
 			} else {
 				acpi_ex_do_debug_object((source_desc->reference.
 							 node)->object,
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index 9460baf..a20a974 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -44,7 +44,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acinterp.h>
-#include <acpi/acevents.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exsystem")
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index fd543ee..1b93f4d 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -61,7 +61,6 @@
 #include <acpi/acpi.h>
 #include <acpi/acinterp.h>
 #include <acpi/amlcode.h>
-#include <acpi/acevents.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exutils")
diff --git a/drivers/acpi/parser/psopcode.c b/drivers/acpi/parser/psopcode.c
index 3bf8105..153621d 100644
--- a/drivers/acpi/parser/psopcode.c
+++ b/drivers/acpi/parser/psopcode.c
@@ -49,7 +49,8 @@
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psopcode")
 
-const u8 acpi_gbl_argument_count[] = { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 6 };
+static const u8 acpi_gbl_argument_count[] =
+    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 6 };
 
 /*******************************************************************************
  *
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 8624686..86cff21 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -267,8 +267,6 @@ extern char const *acpi_gbl_exception_names_ctrl[];
  *
  ****************************************************************************/
 
-#define NUM_NS_TYPES                    ACPI_TYPE_INVALID+1
-
 #if !defined (ACPI_NO_METHOD_EXECUTION) || defined (ACPI_CONSTANT_EVAL_ONLY)
 #define NUM_PREDEFINED_NAMES            10
 #else
@@ -279,7 +277,7 @@ ACPI_EXTERN struct acpi_namespace_node acpi_gbl_root_node_struct;
 ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_root_node;
 ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_fadt_gpe_device;
 
-extern const u8 acpi_gbl_ns_properties[NUM_NS_TYPES];
+extern const u8 acpi_gbl_ns_properties[ACPI_NUM_NS_TYPES];
 extern const struct acpi_predefined_names
     acpi_gbl_pre_defined_names[NUM_PREDEFINED_NAMES];
 
@@ -287,8 +285,8 @@ extern const struct acpi_predefined_names
 ACPI_EXTERN u32 acpi_gbl_current_node_count;
 ACPI_EXTERN u32 acpi_gbl_current_node_size;
 ACPI_EXTERN u32 acpi_gbl_max_concurrent_node_count;
-ACPI_EXTERN acpi_size acpi_gbl_entry_stack_pointer;
-ACPI_EXTERN acpi_size acpi_gbl_lowest_stack_pointer;
+ACPI_EXTERN acpi_size *acpi_gbl_entry_stack_pointer;
+ACPI_EXTERN acpi_size *acpi_gbl_lowest_stack_pointer;
 ACPI_EXTERN u32 acpi_gbl_deepest_nesting;
 #endif
 
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 401228d..dc6a037 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -65,7 +65,11 @@
  * Full 64-bit integer must be available on both 32-bit and 64-bit platforms
  */
 #define ACPI_LODWORD(l)                 ((u32)(u64)(l))
+#define ACPI_HIDWORD(l)                 ((u16)((((u64)(l)) >> 32) & 0xFFFFFFFF))
+
+#if 0
 #define ACPI_HIDWORD(l)                 ((u32)(((*(struct uint64_struct *)(void *)(&l))).hi))
+#endif
 
 /*
  * printf() format helpers
@@ -75,6 +79,12 @@
 
 #define ACPI_FORMAT_UINT64(i)           ACPI_HIDWORD(i),ACPI_LODWORD(i)
 
+#if ACPI_MACHINE_WIDTH == 64
+#define ACPI_FORMAT_NATIVE_UINT(i)      ACPI_FORMAT_UINT64(i)
+#else
+#define ACPI_FORMAT_NATIVE_UINT(i)      0, (i)
+#endif
+
 /*
  * Extract data using a pointer.  Any more than a byte and we
  * get into potential aligment issues -- see the STORE macros below.
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 766178c..bb44700 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -477,6 +477,8 @@ typedef u32 acpi_object_type;
 #define ACPI_TYPE_INVALID               0x1E
 #define ACPI_TYPE_NOT_FOUND             0xFF
 
+#define ACPI_NUM_NS_TYPES               (ACPI_TYPE_INVALID + 1)
+
 /*
  * All I/O
  */
-- 
1.5.5.29.g7134

