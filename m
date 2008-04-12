From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/73] ACPICA: Implemented full support for deferred execution for the TermArg string arguments for DataTableRegion
Date: Sat, 12 Apr 2008 00:25:26 -0400
Message-ID: <b5794ed20a80ab673e410d300723d2db39e94845.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754141AbYDLE2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:13 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This enables forward references and full operand resolution for
the three string arguments. Similar to OperationRegion deferred
argument execution.) Lin Ming. BZ 430

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |  103 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/dispatcher/dswexec.c  |   11 ++++
 drivers/acpi/dispatcher/dswload.c  |   29 +++++++---
 drivers/acpi/executer/excreate.c   |   95 ---------------------------------
 drivers/acpi/executer/exmutex.c    |   16 ++++++
 drivers/acpi/parser/psloop.c       |    6 ++-
 drivers/acpi/parser/psopcode.c     |    4 +-
 include/acpi/acdispat.h            |    4 ++
 include/acpi/acinterp.h            |    2 -
 9 files changed, 160 insertions(+), 110 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index f0847ee..a3f2979 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -49,6 +49,7 @@
 #include <acpi/acinterp.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acevents.h>
+#include <acpi/actables.h>
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsopcode")
@@ -782,6 +783,108 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ds_eval_table_region_operands
+ *
+ * PARAMETERS:  walk_state      - Current walk
+ *              Op              - A valid region Op object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get region address and length
+ *              Called from acpi_ds_exec_end_op during data_table_region parse tree walk
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
+				   union acpi_parse_object *op)
+{
+	acpi_status status;
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object **operand;
+	struct acpi_namespace_node *node;
+	union acpi_parse_object *next_op;
+	acpi_native_uint table_index;
+	struct acpi_table_header *table;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_eval_table_region_operands, op);
+
+	/*
+	 * This is where we evaluate the signature_string and oem_iDString
+	 * and oem_table_iDString of the data_table_region declaration
+	 */
+	node = op->common.node;
+
+	/* next_op points to signature_string op */
+
+	next_op = op->common.value.arg;
+
+	/*
+	 * Evaluate/create the signature_string and oem_iDString
+	 * and oem_table_iDString operands
+	 */
+	status = acpi_ds_create_operands(walk_state, next_op);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/*
+	 * Resolve the signature_string and oem_iDString
+	 * and oem_table_iDString operands
+	 */
+	status = acpi_ex_resolve_operands(op->common.aml_opcode,
+					  ACPI_WALK_OPERANDS, walk_state);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS, ACPI_IMODE_EXECUTE,
+			   acpi_ps_get_opcode_name(op->common.aml_opcode),
+			   1, "after AcpiExResolveOperands");
+
+	operand = &walk_state->operands[0];
+
+	/* Find the ACPI table */
+
+	status = acpi_tb_find_table(operand[0]->string.pointer,
+				    operand[1]->string.pointer,
+				    operand[2]->string.pointer, &table_index);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	acpi_ut_remove_reference(operand[0]);
+	acpi_ut_remove_reference(operand[1]);
+	acpi_ut_remove_reference(operand[2]);
+
+	status = acpi_get_table_by_index(table_index, &table);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	obj_desc = acpi_ns_get_attached_object(node);
+	if (!obj_desc) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	obj_desc->region.address =
+	    (acpi_physical_address) ACPI_TO_INTEGER(table);
+	obj_desc->region.length = table->length;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "RgnObj %p Addr %8.8X%8.8X Len %X\n",
+			  obj_desc,
+			  ACPI_FORMAT_NATIVE_UINT(obj_desc->region.address),
+			  obj_desc->region.length));
+
+	/* Now the address and length are valid for this opregion */
+
+	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ds_eval_data_object_operands
  *
  * PARAMETERS:  walk_state      - Current walk
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index 6af4671..8ba4bb3 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -641,6 +641,17 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 				if (ACPI_FAILURE(status)) {
 					break;
 				}
+			} else if (op->common.aml_opcode == AML_DATA_REGION_OP) {
+				ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+						  "Executing DataTableRegion Strings Op=%p\n",
+						  op));
+
+				status =
+				    acpi_ds_eval_table_region_operands
+				    (walk_state, op);
+				if (ACPI_FAILURE(status)) {
+					break;
+				}
 			}
 			break;
 
diff --git a/drivers/acpi/dispatcher/dswload.c b/drivers/acpi/dispatcher/dswload.c
index 8ab9d1b..ec68c1d 100644
--- a/drivers/acpi/dispatcher/dswload.c
+++ b/drivers/acpi/dispatcher/dswload.c
@@ -443,6 +443,15 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
 			}
+		} else if (op->common.aml_opcode == AML_DATA_REGION_OP) {
+			status =
+			    acpi_ex_create_region(op->named.data,
+						  op->named.length,
+						  REGION_DATA_TABLE,
+						  walk_state);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
 		}
 	}
 #endif
@@ -823,6 +832,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 	struct acpi_namespace_node *new_node;
 #ifndef ACPI_NO_METHOD_EXECUTION
 	u32 i;
+	u8 region_space;
 #endif
 
 	ACPI_FUNCTION_TRACE(ds_load2_end_op);
@@ -1003,11 +1013,6 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 			status = acpi_ex_create_event(walk_state);
 			break;
 
-		case AML_DATA_REGION_OP:
-
-			status = acpi_ex_create_table_region(walk_state);
-			break;
-
 		case AML_ALIAS_OP:
 
 			status = acpi_ex_create_alias(walk_state);
@@ -1035,6 +1040,15 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 		switch (op->common.aml_opcode) {
 #ifndef ACPI_NO_METHOD_EXECUTION
 		case AML_REGION_OP:
+		case AML_DATA_REGION_OP:
+
+			if (op->common.aml_opcode == AML_REGION_OP) {
+				region_space = (acpi_adr_space_type)
+				    ((op->common.value.arg)->common.value.
+				     integer);
+			} else {
+				region_space = REGION_DATA_TABLE;
+			}
 
 			/*
 			 * If we are executing a method, initialize the region
@@ -1043,10 +1057,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				status =
 				    acpi_ex_create_region(op->named.data,
 							  op->named.length,
-							  (acpi_adr_space_type)
-							  ((op->common.value.
-							    arg)->common.value.
-							   integer),
+							  region_space,
 							  walk_state);
 				if (ACPI_FAILURE(status)) {
 					return (status);
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index b391439..0396bd4 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -352,101 +352,6 @@ acpi_ex_create_region(u8 * aml_start,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_create_table_region
- *
- * PARAMETERS:  walk_state          - Current state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Create a new data_table_region object
- *
- ******************************************************************************/
-
-acpi_status acpi_ex_create_table_region(struct acpi_walk_state *walk_state)
-{
-	acpi_status status;
-	union acpi_operand_object **operand = &walk_state->operands[0];
-	union acpi_operand_object *obj_desc;
-	struct acpi_namespace_node *node;
-	union acpi_operand_object *region_obj2;
-	acpi_native_uint table_index;
-	struct acpi_table_header *table;
-
-	ACPI_FUNCTION_TRACE(ex_create_table_region);
-
-	/* Get the Node from the object stack  */
-
-	node = walk_state->op->common.node;
-
-	/*
-	 * If the region object is already attached to this node,
-	 * just return
-	 */
-	if (acpi_ns_get_attached_object(node)) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Find the ACPI table */
-
-	status = acpi_tb_find_table(operand[1]->string.pointer,
-				    operand[2]->string.pointer,
-				    operand[3]->string.pointer, &table_index);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Create the region descriptor */
-
-	obj_desc = acpi_ut_create_internal_object(ACPI_TYPE_REGION);
-	if (!obj_desc) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	region_obj2 = obj_desc->common.next_object;
-	region_obj2->extra.region_context = NULL;
-
-	status = acpi_get_table_by_index(table_index, &table);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Init the region from the operands */
-
-	obj_desc->region.space_id = REGION_DATA_TABLE;
-	obj_desc->region.address =
-	    (acpi_physical_address) ACPI_TO_INTEGER(table);
-	obj_desc->region.length = table->length;
-	obj_desc->region.node = node;
-	obj_desc->region.flags = AOPOBJ_DATA_VALID;
-
-	/* Install the new region object in the parent Node */
-
-	status = acpi_ns_attach_object(node, obj_desc, ACPI_TYPE_REGION);
-	if (ACPI_FAILURE(status)) {
-		goto cleanup;
-	}
-
-	status = acpi_ev_initialize_region(obj_desc, FALSE);
-	if (ACPI_FAILURE(status)) {
-		if (status == AE_NOT_EXIST) {
-			status = AE_OK;
-		} else {
-			goto cleanup;
-		}
-	}
-
-	obj_desc->region.flags |= AOPOBJ_SETUP_COMPLETE;
-
-      cleanup:
-
-	/* Remove local reference to the object */
-
-	acpi_ut_remove_reference(obj_desc);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_create_processor
  *
  * PARAMETERS:  walk_state          - Current state
diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index b8d035c..7c70938 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -85,6 +85,7 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
 	} else {
 		thread->acquired_mutex_list = obj_desc->mutex.next;
 	}
+	return;
 }
 
 /*******************************************************************************
@@ -298,6 +299,17 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 		return (AE_NOT_ACQUIRED);
 	}
 
+	/* No obj_desc->Mutex.owner_thread for Global Lock */
+
+	/*
+	 * Mutex to be released must be at the head of acquired list to prevent
+	 * deadlock. (The head of the list is the last mutex acquired.)
+	 */
+	if (obj_desc->mutex.owner_thread &&
+	    (obj_desc != obj_desc->mutex.owner_thread->acquired_mutex_list)) {
+		return (AE_AML_MUTEX_ORDER);
+	}
+
 	/* Match multiple Acquires with multiple Releases */
 
 	obj_desc->mutex.acquisition_depth--;
@@ -403,6 +415,9 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	}
 
 	status = acpi_ex_release_mutex_object(obj_desc);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	if (obj_desc->mutex.acquisition_depth == 0) {
 
@@ -411,6 +426,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		walk_state->thread->current_sync_level =
 		    obj_desc->mutex.original_sync_level;
 	}
+
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index 4348b05..a079975 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -242,7 +242,8 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 	acpi_ps_append_arg(*op, unnamed_op->common.value.arg);
 	acpi_gbl_depth++;
 
-	if ((*op)->common.aml_opcode == AML_REGION_OP) {
+	if ((*op)->common.aml_opcode == AML_REGION_OP ||
+	    (*op)->common.aml_opcode == AML_DATA_REGION_OP) {
 		/*
 		 * Defer final parsing of an operation_region body, because we don't
 		 * have enough info in the first pass to parse it correctly (i.e.,
@@ -1013,7 +1014,8 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 				acpi_gbl_depth--;
 			}
 
-			if (op->common.aml_opcode == AML_REGION_OP) {
+			if (op->common.aml_opcode == AML_REGION_OP ||
+			    op->common.aml_opcode == AML_DATA_REGION_OP) {
 				/*
 				 * Skip parsing of control method or opregion body,
 				 * because we don't have enough info in the first pass
diff --git a/drivers/acpi/parser/psopcode.c b/drivers/acpi/parser/psopcode.c
index 153621d..b273a0a 100644
--- a/drivers/acpi/parser/psopcode.c
+++ b/drivers/acpi/parser/psopcode.c
@@ -624,9 +624,9 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 		 AML_TYPE_EXEC_6A_0T_1R, AML_FLAGS_EXEC_6A_0T_1R),
 /* 7C */ ACPI_OP("DataTableRegion", ARGP_DATA_REGION_OP,
 		 ARGI_DATA_REGION_OP, ACPI_TYPE_REGION,
-		 AML_CLASS_NAMED_OBJECT, AML_TYPE_NAMED_SIMPLE,
+		 AML_CLASS_NAMED_OBJECT, AML_TYPE_NAMED_COMPLEX,
 		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE |
-		 AML_NSNODE | AML_NAMED),
+		 AML_NSNODE | AML_NAMED | AML_DEFER),
 /* 7D */ ACPI_OP("[EvalSubTree]", ARGP_SCOPE_OP, ARGI_SCOPE_OP,
 		 ACPI_TYPE_ANY, AML_CLASS_NAMED_OBJECT,
 		 AML_TYPE_NAMED_NO_OBJ,
diff --git a/include/acpi/acdispat.h b/include/acpi/acdispat.h
index 3bffb4d..d8dabe8 100644
--- a/include/acpi/acdispat.h
+++ b/include/acpi/acdispat.h
@@ -68,6 +68,10 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 			     union acpi_parse_object *op);
 
 acpi_status
+acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
+				   union acpi_parse_object *op);
+
+acpi_status
 acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 				  union acpi_parse_object *op,
 				  union acpi_operand_object *obj_desc);
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index 92eb014..f4dd98f 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -215,8 +215,6 @@ acpi_ex_create_region(u8 * aml_start,
 		      u32 aml_length,
 		      u8 region_space, struct acpi_walk_state *walk_state);
 
-acpi_status acpi_ex_create_table_region(struct acpi_walk_state *walk_state);
-
 acpi_status acpi_ex_create_event(struct acpi_walk_state *walk_state);
 
 acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state);
-- 
1.5.5.29.g7134

