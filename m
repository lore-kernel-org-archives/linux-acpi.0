From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/73] ACPICA: changed order of interpretation of operand objects
Date: Sat, 12 Apr 2008 00:24:47 -0400
Message-ID: <cbaa466e33d098379edcd2eaa5b0c0c5ac64a811.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752186AbYDLE14 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:56 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The interpreter now evaluates operands in the order that they
appear (both in the
 AML and ASL), instead of in reverse order. This previously
 caused subtle incompatibilities with the MS interpreter as well
 as being non-intuitive.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsutils.c |  113 ++++++++++++++++++++++++++++++++++++-
 drivers/acpi/dispatcher/dswexec.c |   11 +++-
 drivers/acpi/executer/exutils.c   |    3 +-
 drivers/acpi/parser/psloop.c      |   23 +++++++-
 drivers/acpi/parser/psopcode.c    |   26 +++++++++
 drivers/acpi/parser/pstree.c      |    2 +
 include/acpi/acdispat.h           |    2 +
 include/acpi/aclocal.h            |    3 +
 include/acpi/acparser.h           |    2 +
 9 files changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsutils.c b/drivers/acpi/dispatcher/dsutils.c
index d2a8cfd..36518b4 100644
--- a/drivers/acpi/dispatcher/dsutils.c
+++ b/drivers/acpi/dispatcher/dsutils.c
@@ -472,7 +472,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 	/* A valid name must be looked up in the namespace */
 
 	if ((arg->common.aml_opcode == AML_INT_NAMEPATH_OP) &&
-	    (arg->common.value.string)) {
+	    (arg->common.value.string) &&
+	    !(arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Getting a name: Arg=%p\n",
 				  arg));
 
@@ -595,7 +596,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 	} else {
 		/* Check for null name case */
 
-		if (arg->common.aml_opcode == AML_INT_NAMEPATH_OP) {
+		if ((arg->common.aml_opcode == AML_INT_NAMEPATH_OP) &&
+		    !(arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
 			/*
 			 * If the name is null, this means that this is an
 			 * optional result parameter that was not specified
@@ -617,7 +619,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
 		}
 
-		if (op_info->flags & AML_HAS_RETVAL) {
+		if ((op_info->flags & AML_HAS_RETVAL)
+		    || (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 					  "Argument previously created, already stacked\n"));
 
@@ -759,3 +762,107 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %d", index));
 	return_ACPI_STATUS(status);
 }
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_ds_evaluate_name_path
+ *
+ * PARAMETERS:  walk_state      - Current state of the parse tree walk,
+ *                                the opcode of current operation should be
+ *                                AML_INT_NAMEPATH_OP
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Translate the -name_path- parse tree object to the equivalent
+ *              interpreter object, convert it to value, if needed, duplicate
+ *              it, if needed, and push it onto the current result stack.
+ *
+ ****************************************************************************/
+
+acpi_status acpi_ds_evaluate_name_path(struct acpi_walk_state *walk_state)
+{
+	acpi_status status = AE_OK;
+	union acpi_parse_object *op = walk_state->op;
+	union acpi_operand_object **operand = &walk_state->operands[0];
+	union acpi_operand_object *new_obj_desc;
+	u8 type;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_evaluate_name_path, walk_state);
+
+	if (!op->common.parent) {
+
+		/* This happens after certain exception processing */
+
+		goto exit;
+	}
+
+	if ((op->common.parent->common.aml_opcode == AML_PACKAGE_OP) ||
+	    (op->common.parent->common.aml_opcode == AML_VAR_PACKAGE_OP) ||
+	    (op->common.parent->common.aml_opcode == AML_REF_OF_OP)) {
+
+		/* TBD: Should we specify this feature as a bit of op_info->Flags of these opcodes? */
+
+		goto exit;
+	}
+
+	status = acpi_ds_create_operand(walk_state, op, 0);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (op->common.flags & ACPI_PARSEOP_TARGET) {
+		new_obj_desc = *operand;
+		goto push_result;
+	}
+
+	type = ACPI_GET_OBJECT_TYPE(*operand);
+
+	status = acpi_ex_resolve_to_value(operand, walk_state);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (type == ACPI_TYPE_INTEGER) {
+
+		/* It was incremented by acpi_ex_resolve_to_value */
+
+		acpi_ut_remove_reference(*operand);
+
+		status =
+		    acpi_ut_copy_iobject_to_iobject(*operand, &new_obj_desc,
+						    walk_state);
+		if (ACPI_FAILURE(status)) {
+			goto exit;
+		}
+	} else {
+		/*
+		 * The object either was anew created or is
+		 * a Namespace node - don't decrement it.
+		 */
+		new_obj_desc = *operand;
+	}
+
+	/* Cleanup for name-path operand */
+
+	status = acpi_ds_obj_stack_pop(1, walk_state);
+	if (ACPI_FAILURE(status)) {
+		walk_state->result_obj = new_obj_desc;
+		goto exit;
+	}
+
+      push_result:
+
+	walk_state->result_obj = new_obj_desc;
+
+	status = acpi_ds_result_push(walk_state->result_obj, walk_state);
+	if (ACPI_SUCCESS(status)) {
+
+		/* Force to take it from stack */
+
+		op->common.flags |= ACPI_PARSEOP_IN_STACK;
+	}
+
+      exit:
+
+	return_ACPI_STATUS(status);
+}
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index 12b1485..514b9d2 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -375,10 +375,17 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 	/* Decode the Opcode Class */
 
 	switch (op_class) {
-	case AML_CLASS_ARGUMENT:	/* constants, literals, etc. - do nothing */
+	case AML_CLASS_ARGUMENT:	/* Constants, literals, etc. */
+
+		if (walk_state->opcode == AML_INT_NAMEPATH_OP) {
+			status = acpi_ds_evaluate_name_path(walk_state);
+			if (ACPI_FAILURE(status)) {
+				goto cleanup;
+			}
+		}
 		break;
 
-	case AML_CLASS_EXECUTE:	/* most operators with arguments */
+	case AML_CLASS_EXECUTE:	/* Most operators with arguments */
 
 		/* Build resolved operand stack */
 
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index c0837af..c40b191 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -217,9 +217,10 @@ void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
 
 	/*
 	 * Object must be a valid number and we must be executing
-	 * a control method
+	 * a control method. NS node could be there for AML_INT_NAMEPATH_OP.
 	 */
 	if ((!obj_desc) ||
+	    (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_OPERAND) ||
 	    (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER)) {
 		return;
 	}
diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index 266dd0c..4348b05 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -182,6 +182,7 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 	ACPI_FUNCTION_TRACE_PTR(ps_build_named_op, walk_state);
 
 	unnamed_op->common.value.arg = NULL;
+	unnamed_op->common.arg_list_length = 0;
 	unnamed_op->common.aml_opcode = walk_state->opcode;
 
 	/*
@@ -280,6 +281,9 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 	acpi_status status = AE_OK;
 	union acpi_parse_object *op;
 	union acpi_parse_object *named_op = NULL;
+	union acpi_parse_object *parent_scope;
+	u8 argument_count;
+	const struct acpi_opcode_info *op_info;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_create_op, walk_state);
 
@@ -320,8 +324,23 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 		op->named.length = 0;
 	}
 
-	acpi_ps_append_arg(acpi_ps_get_parent_scope
-			   (&(walk_state->parser_state)), op);
+	parent_scope = acpi_ps_get_parent_scope(&(walk_state->parser_state));
+	acpi_ps_append_arg(parent_scope, op);
+
+	if (parent_scope) {
+		op_info =
+		    acpi_ps_get_opcode_info(parent_scope->common.aml_opcode);
+		if (op_info->flags & AML_HAS_TARGET) {
+			argument_count =
+			    acpi_ps_get_argument_count(op_info->type);
+			if (parent_scope->common.arg_list_length >
+			    argument_count) {
+				op->common.flags |= ACPI_PARSEOP_TARGET;
+			}
+		} else if (parent_scope->common.aml_opcode == AML_INCREMENT_OP) {
+			op->common.flags |= ACPI_PARSEOP_TARGET;
+		}
+	}
 
 	if (walk_state->descending_callback != NULL) {
 		/*
diff --git a/drivers/acpi/parser/psopcode.c b/drivers/acpi/parser/psopcode.c
index 9296e86..3bf8105 100644
--- a/drivers/acpi/parser/psopcode.c
+++ b/drivers/acpi/parser/psopcode.c
@@ -49,6 +49,8 @@
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psopcode")
 
+const u8 acpi_gbl_argument_count[] = { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 6 };
+
 /*******************************************************************************
  *
  * NAME:        acpi_gbl_aml_op_info
@@ -59,6 +61,7 @@ ACPI_MODULE_NAME("psopcode")
  *              the operand type.
  *
  ******************************************************************************/
+
 /*
  * Summary of opcode types/flags
  *
@@ -176,6 +179,7 @@ ACPI_MODULE_NAME("psopcode")
 	AML_CREATE_QWORD_FIELD_OP
 
  ******************************************************************************/
+
 /*
  * Master Opcode information table.  A summary of everything we know about each
  * opcode, all in one place.
@@ -779,3 +783,25 @@ char *acpi_ps_get_opcode_name(u16 opcode)
 
 #endif
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_get_argument_count
+ *
+ * PARAMETERS:  op_type             - Type associated with the AML opcode
+ *
+ * RETURN:      Argument count
+ *
+ * DESCRIPTION: Obtain the number of expected arguments for an AML opcode
+ *
+ ******************************************************************************/
+
+u8 acpi_ps_get_argument_count(u32 op_type)
+{
+
+	if (op_type <= AML_TYPE_EXEC_6A_0T_1R) {
+		return (acpi_gbl_argument_count[op_type]);
+	}
+
+	return (0);
+}
diff --git a/drivers/acpi/parser/pstree.c b/drivers/acpi/parser/pstree.c
index 966e7ea..0e1a322 100644
--- a/drivers/acpi/parser/pstree.c
+++ b/drivers/acpi/parser/pstree.c
@@ -171,6 +171,8 @@ acpi_ps_append_arg(union acpi_parse_object *op, union acpi_parse_object *arg)
 	while (arg) {
 		arg->common.parent = op;
 		arg = arg->common.next;
+
+		op->common.arg_list_length++;
 	}
 }
 
diff --git a/include/acpi/acdispat.h b/include/acpi/acdispat.h
index 70d649e..3bffb4d 100644
--- a/include/acpi/acdispat.h
+++ b/include/acpi/acdispat.h
@@ -269,6 +269,8 @@ acpi_status acpi_ds_resolve_operands(struct acpi_walk_state *walk_state);
 
 void acpi_ds_clear_operands(struct acpi_walk_state *walk_state);
 
+acpi_status acpi_ds_evaluate_name_path(struct acpi_walk_state *walk_state);
+
 /*
  * dswscope - Scope Stack manipulation
  */
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 0b7c9a9..946da60 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -603,6 +603,7 @@ union acpi_parse_value {
 	union acpi_parse_object         *next;          /* Next op */\
 	struct acpi_namespace_node      *node;          /* For use by interpreter */\
 	union acpi_parse_value          value;          /* Value or args associated with the opcode */\
+	u8                              arg_list_length; /* Number of elements in the arg list */\
 	ACPI_DISASM_ONLY_MEMBERS (\
 	u8                              disasm_flags;   /* Used during AML disassembly */\
 	u8                              disasm_opcode;  /* Subtype used for disassembly */\
@@ -695,6 +696,8 @@ struct acpi_parse_state {
 #define ACPI_PARSEOP_NAMED              0x02
 #define ACPI_PARSEOP_DEFERRED           0x04
 #define ACPI_PARSEOP_BYTELIST           0x08
+#define ACPI_PARSEOP_IN_STACK           0x10
+#define ACPI_PARSEOP_TARGET             0x20
 #define ACPI_PARSEOP_IN_CACHE           0x80
 
 /* Parse object disasm_flags */
diff --git a/include/acpi/acparser.h b/include/acpi/acparser.h
index 85c358e..a3ae76b 100644
--- a/include/acpi/acparser.h
+++ b/include/acpi/acparser.h
@@ -109,6 +109,8 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode);
 
 char *acpi_ps_get_opcode_name(u16 opcode);
 
+u8 acpi_ps_get_argument_count(u32 op_type);
+
 /*
  * psparse - top level parsing routines
  */
-- 
1.5.5.29.g7134

