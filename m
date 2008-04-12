From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/73] ACPICA: Implemented full argument resolution support for the BankValue argument to BankField
Date: Sat, 12 Apr 2008 00:25:28 -0400
Message-ID: <db82915823cfdf655255eed10d972a09917fcce2.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753156AbYDLE2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:08 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Previously, only constants were supported, now any TermArg may
be used. Lin Ming BZ 387, 393

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsfield.c  |   80 ++++++++++----------
 drivers/acpi/dispatcher/dsopcode.c |  144 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/dispatcher/dsutils.c  |    4 +-
 drivers/acpi/dispatcher/dswexec.c  |   11 +++
 drivers/acpi/executer/exprep.c     |   15 ++++
 drivers/acpi/namespace/nsinit.c    |   10 +++
 drivers/acpi/parser/psloop.c       |   19 +++++
 drivers/acpi/parser/psopcode.c     |    5 +-
 drivers/acpi/parser/psparse.c      |    2 +
 drivers/acpi/utilities/utdelete.c  |   11 +++
 drivers/acpi/utilities/utobject.c  |    1 +
 include/acpi/acdispat.h            |    7 ++
 12 files changed, 267 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsfield.c b/drivers/acpi/dispatcher/dsfield.c
index f049639..e87f6bf 100644
--- a/drivers/acpi/dispatcher/dsfield.c
+++ b/drivers/acpi/dispatcher/dsfield.c
@@ -281,11 +281,17 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 				arg->common.node = info->field_node;
 				info->field_bit_length = arg->common.value.size;
 
-				/* Create and initialize an object for the new Field Node */
-
-				status = acpi_ex_prep_field_value(info);
-				if (ACPI_FAILURE(status)) {
-					return_ACPI_STATUS(status);
+				/*
+				 * If there is no object attached to the node, this node was just created
+				 * and we need to create the field object.  Otherwise, this was a lookup
+				 * of an existing node and we don't want to create the field object again.
+				 */
+				if (!acpi_ns_get_attached_object
+				    (info->field_node)) {
+					status = acpi_ex_prep_field_value(info);
+					if (ACPI_FAILURE(status)) {
+						return_ACPI_STATUS(status);
+					}
 				}
 			}
 
@@ -399,9 +405,22 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 	union acpi_parse_object *arg = NULL;
 	struct acpi_namespace_node *node;
 	u8 type = 0;
+	u32 flags;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_init_field_objects, op);
 
+	/*
+	 * During the load phase, we want to enter the name of the field into
+	 * the namespace. During the execute phase (when we evaluate the bank_value
+	 * operand), we want to lookup the name.
+	 */
+	if (walk_state->deferred_node) {
+		flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE;
+	} else {
+		flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE |
+		    ACPI_NS_ERROR_IF_FOUND;
+	}
+
 	switch (walk_state->opcode) {
 	case AML_FIELD_OP:
 		arg = acpi_ps_get_arg(op, 2);
@@ -433,10 +452,7 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 			status = acpi_ns_lookup(walk_state->scope_info,
 						(char *)&arg->named.name,
 						type, ACPI_IMODE_LOAD_PASS1,
-						ACPI_NS_NO_UPSEARCH |
-						ACPI_NS_DONT_OPEN_SCOPE |
-						ACPI_NS_ERROR_IF_FOUND,
-						walk_state, &node);
+						flags, walk_state, &node);
 			if (ACPI_FAILURE(status)) {
 				ACPI_ERROR_NAMESPACE((char *)&arg->named.name,
 						     status);
@@ -466,7 +482,7 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
  *
  * PARAMETERS:  Op              - Op containing the Field definition and args
  *              region_node     - Object for the containing Operation Region
- *  `           walk_state      - Current method state
+ *              walk_state      - Current method state
  *
  * RETURN:      Status
  *
@@ -513,36 +529,13 @@ acpi_ds_create_bank_field(union acpi_parse_object *op,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Third arg is the bank_value */
-
-	/* TBD: This arg is a term_arg, not a constant, and must be evaluated */
-
+	/*
+	 * Third arg is the bank_value
+	 * This arg is a term_arg, not a constant
+	 * It will be evaluated later, by acpi_ds_eval_bank_field_operands
+	 */
 	arg = arg->common.next;
 
-	/* Currently, only the following constants are supported */
-
-	switch (arg->common.aml_opcode) {
-	case AML_ZERO_OP:
-		info.bank_value = 0;
-		break;
-
-	case AML_ONE_OP:
-		info.bank_value = 1;
-		break;
-
-	case AML_BYTE_OP:
-	case AML_WORD_OP:
-	case AML_DWORD_OP:
-	case AML_QWORD_OP:
-		info.bank_value = (u32) arg->common.value.integer;
-		break;
-
-	default:
-		info.bank_value = 0;
-		ACPI_ERROR((AE_INFO,
-			    "Non-constant BankValue for BankField is not implemented"));
-	}
-
 	/* Fourth arg is the field flags */
 
 	arg = arg->common.next;
@@ -553,8 +546,17 @@ acpi_ds_create_bank_field(union acpi_parse_object *op,
 	info.field_type = ACPI_TYPE_LOCAL_BANK_FIELD;
 	info.region_node = region_node;
 
-	status = acpi_ds_get_field_names(&info, walk_state, arg->common.next);
+	/*
+	 * Use Info.data_register_node to store bank_field Op
+	 * It's safe because data_register_node will never be used when create bank field
+	 * We store aml_start and aml_length in the bank_field Op for late evaluation
+	 * Used in acpi_ex_prep_field_value(Info)
+	 *
+	 * TBD: Or, should we add a field in struct acpi_create_field_info, like "void *ParentOp"?
+	 */
+	info.data_register_node = (struct acpi_namespace_node *)op;
 
+	status = acpi_ds_get_field_names(&info, walk_state, arg->common.next);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index a3f2979..35a7efd 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -220,6 +220,50 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ds_get_bank_field_arguments
+ *
+ * PARAMETERS:  obj_desc        - A valid bank_field object
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Get bank_field bank_value. This implements the late
+ *              evaluation of these field attributes.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
+{
+	union acpi_operand_object *extra_desc;
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_get_bank_field_arguments, obj_desc);
+
+	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Get the AML pointer (method object) and bank_field node */
+
+	extra_desc = acpi_ns_get_secondary_object(obj_desc);
+	node = obj_desc->bank_field.node;
+
+	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
+			(ACPI_TYPE_LOCAL_BANK_FIELD, node, NULL));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] BankField Arg Init\n",
+			  acpi_ut_get_node_name(node)));
+
+	/* Execute the AML code for the term_arg arguments */
+
+	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+					   extra_desc->extra.aml_length,
+					   extra_desc->extra.aml_start);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ds_get_buffer_arguments
  *
  * PARAMETERS:  obj_desc        - A valid Buffer object
@@ -987,6 +1031,106 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ds_eval_bank_field_operands
+ *
+ * PARAMETERS:  walk_state      - Current walk
+ *              Op              - A valid bank_field Op object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get bank_field bank_value
+ *              Called from acpi_ds_exec_end_op during bank_field parse tree walk
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_eval_bank_field_operands(struct acpi_walk_state *walk_state,
+				 union acpi_parse_object *op)
+{
+	acpi_status status;
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *operand_desc;
+	struct acpi_namespace_node *node;
+	union acpi_parse_object *next_op;
+	union acpi_parse_object *arg;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_eval_bank_field_operands, op);
+
+	/*
+	 * This is where we evaluate the bank_value field of the
+	 * bank_field declaration
+	 */
+
+	/* next_op points to the op that holds the Region */
+
+	next_op = op->common.value.arg;
+
+	/* next_op points to the op that holds the Bank Register */
+
+	next_op = next_op->common.next;
+
+	/* next_op points to the op that holds the Bank Value */
+
+	next_op = next_op->common.next;
+
+	/*
+	 * Set proper index into operand stack for acpi_ds_obj_stack_push
+	 * invoked inside acpi_ds_create_operand.
+	 *
+	 * We use walk_state->Operands[0] to store the evaluated bank_value
+	 */
+	walk_state->operand_index = 0;
+
+	status = acpi_ds_create_operand(walk_state, next_op, 0);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_ex_resolve_to_value(&walk_state->operands[0], walk_state);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS, ACPI_IMODE_EXECUTE,
+			   acpi_ps_get_opcode_name(op->common.aml_opcode),
+			   1, "after AcpiExResolveOperands");
+
+	/*
+	 * Get the bank_value operand and save it
+	 * (at Top of stack)
+	 */
+	operand_desc = walk_state->operands[0];
+
+	/* Arg points to the start Bank Field */
+
+	arg = acpi_ps_get_arg(op, 4);
+	while (arg) {
+
+		/* Ignore OFFSET and ACCESSAS terms here */
+
+		if (arg->common.aml_opcode == AML_INT_NAMEDFIELD_OP) {
+			node = arg->common.node;
+
+			obj_desc = acpi_ns_get_attached_object(node);
+			if (!obj_desc) {
+				return_ACPI_STATUS(AE_NOT_EXIST);
+			}
+
+			obj_desc->bank_field.value =
+			    (u32) operand_desc->integer.value;
+		}
+
+		/* Move to next field in the list */
+
+		arg = arg->common.next;
+	}
+
+	acpi_ut_remove_reference(operand_desc);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ds_exec_begin_control_op
  *
  * PARAMETERS:  walk_list       - The list that owns the walk stack
diff --git a/drivers/acpi/dispatcher/dsutils.c b/drivers/acpi/dispatcher/dsutils.c
index 97d01dc..f6c28d7 100644
--- a/drivers/acpi/dispatcher/dsutils.c
+++ b/drivers/acpi/dispatcher/dsutils.c
@@ -278,7 +278,9 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 			AML_VAR_PACKAGE_OP)
 		    || (op->common.parent->common.aml_opcode == AML_BUFFER_OP)
 		    || (op->common.parent->common.aml_opcode ==
-			AML_INT_EVAL_SUBTREE_OP)) {
+			AML_INT_EVAL_SUBTREE_OP)
+		    || (op->common.parent->common.aml_opcode ==
+			AML_BANK_FIELD_OP)) {
 			/*
 			 * These opcodes allow term_arg(s) as operands and therefore
 			 * the operands can be method calls.  The result is used.
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index 8ba4bb3..bfe4450 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -652,6 +652,17 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 				if (ACPI_FAILURE(status)) {
 					break;
 				}
+			} else if (op->common.aml_opcode == AML_BANK_FIELD_OP) {
+				ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+						  "Executing BankField Op=%p\n",
+						  op));
+
+				status =
+				    acpi_ds_eval_bank_field_operands(walk_state,
+								     op);
+				if (ACPI_FAILURE(status)) {
+					break;
+				}
 			}
 			break;
 
diff --git a/drivers/acpi/executer/exprep.c b/drivers/acpi/executer/exprep.c
index efe5d4b..6eb45bf 100644
--- a/drivers/acpi/executer/exprep.c
+++ b/drivers/acpi/executer/exprep.c
@@ -412,6 +412,7 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 {
 	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *second_desc = NULL;
 	u32 type;
 	acpi_status status;
 
@@ -494,6 +495,20 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 				  obj_desc->field.access_byte_width,
 				  obj_desc->bank_field.region_obj,
 				  obj_desc->bank_field.bank_obj));
+
+		/*
+		 * Remember location in AML stream of the field unit
+		 * opcode and operands -- since the bank_value
+		 * operands must be evaluated.
+		 */
+		second_desc = obj_desc->common.next_object;
+		second_desc->extra.aml_start =
+		    ((union acpi_parse_object *)(info->data_register_node))->
+		    named.data;
+		second_desc->extra.aml_length =
+		    ((union acpi_parse_object *)(info->data_register_node))->
+		    named.length;
+
 		break;
 
 	case ACPI_TYPE_LOCAL_INDEX_FIELD:
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
index 33db224..72b3245 100644
--- a/drivers/acpi/namespace/nsinit.c
+++ b/drivers/acpi/namespace/nsinit.c
@@ -244,6 +244,10 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 		info->field_count++;
 		break;
 
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
+		info->field_count++;
+		break;
+
 	case ACPI_TYPE_BUFFER:
 		info->buffer_count++;
 		break;
@@ -287,6 +291,12 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 		status = acpi_ds_get_buffer_field_arguments(obj_desc);
 		break;
 
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
+
+		info->field_init++;
+		status = acpi_ds_get_bank_field_arguments(obj_desc);
+		break;
+
 	case ACPI_TYPE_BUFFER:
 
 		info->buffer_init++;
diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index a079975..a7c7688 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -325,6 +325,15 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 		op->named.length = 0;
 	}
 
+	if (walk_state->opcode == AML_BANK_FIELD_OP) {
+		/*
+		 * Backup to beginning of bank_field declaration
+		 * body_length is unknown until we parse the body
+		 */
+		op->named.data = aml_op_start;
+		op->named.length = 0;
+	}
+
 	parent_scope = acpi_ps_get_parent_scope(&(walk_state->parser_state));
 	acpi_ps_append_arg(parent_scope, op);
 
@@ -1040,6 +1049,16 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 			    (u32) (parser_state->aml - op->named.data);
 		}
 
+		if (op->common.aml_opcode == AML_BANK_FIELD_OP) {
+			/*
+			 * Backup to beginning of bank_field declaration
+			 *
+			 * body_length is unknown until we parse the body
+			 */
+			op->named.length =
+			    (u32) (parser_state->aml - op->named.data);
+		}
+
 		/* This op complete, notify the dispatcher */
 
 		if (walk_state->ascending_callback != NULL) {
diff --git a/drivers/acpi/parser/psopcode.c b/drivers/acpi/parser/psopcode.c
index b273a0a..18ed59d 100644
--- a/drivers/acpi/parser/psopcode.c
+++ b/drivers/acpi/parser/psopcode.c
@@ -520,9 +520,10 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 		 AML_TYPE_NAMED_FIELD,
 		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_FIELD),
 /* 5F */ ACPI_OP("BankField", ARGP_BANK_FIELD_OP, ARGI_BANK_FIELD_OP,
-		 ACPI_TYPE_ANY, AML_CLASS_NAMED_OBJECT,
+		 ACPI_TYPE_LOCAL_BANK_FIELD, AML_CLASS_NAMED_OBJECT,
 		 AML_TYPE_NAMED_FIELD,
-		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_FIELD),
+		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_FIELD |
+		 AML_DEFER),
 
 /* Internal opcodes that map to invalid AML opcodes */
 
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 1442e55..a8995ca 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -205,6 +205,8 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 			    || (op->common.parent->common.aml_opcode ==
 				AML_PACKAGE_OP)
 			    || (op->common.parent->common.aml_opcode ==
+				AML_BANK_FIELD_OP)
+			    || (op->common.parent->common.aml_opcode ==
 				AML_VAR_PACKAGE_OP)) {
 				replacement_op =
 				    acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index 6a763cd..f5b2f6a 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -252,6 +252,17 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 		}
 		break;
 
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
+				  "***** Bank Field %p\n", object));
+
+		second_desc = acpi_ns_get_secondary_object(object);
+		if (second_desc) {
+			acpi_ut_delete_object_desc(second_desc);
+		}
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index e08b3fa..1eccd3d 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -107,6 +107,7 @@ union acpi_operand_object *acpi_ut_create_internal_object_dbg(char *module_name,
 	switch (type) {
 	case ACPI_TYPE_REGION:
 	case ACPI_TYPE_BUFFER_FIELD:
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
 
 		/* These types require a secondary object */
 
diff --git a/include/acpi/acdispat.h b/include/acpi/acdispat.h
index d8dabe8..a5b97f0 100644
--- a/include/acpi/acdispat.h
+++ b/include/acpi/acdispat.h
@@ -53,6 +53,9 @@
 acpi_status
 acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc);
 
+acpi_status
+acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc);
+
 acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *rgn_desc);
 
 acpi_status acpi_ds_get_buffer_arguments(union acpi_operand_object *obj_desc);
@@ -76,6 +79,10 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 				  union acpi_parse_object *op,
 				  union acpi_operand_object *obj_desc);
 
+acpi_status
+acpi_ds_eval_bank_field_operands(struct acpi_walk_state *walk_state,
+				 union acpi_parse_object *op);
+
 acpi_status acpi_ds_initialize_region(acpi_handle obj_handle);
 
 /*
-- 
1.5.5.29.g7134

