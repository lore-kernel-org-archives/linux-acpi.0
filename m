From: Len Brown <len.brown@intel.com>
Subject: [PATCH 49/65] ACPICA: Restructured module into multiple functions.
Date: Fri, 24 Nov 2006 02:18:59 -0500
Message-ID: <11643528091601-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41795 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934473AbWKXHQN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:13 -0500
In-Reply-To: <1164352808199-git-send-email-len.brown@intel.com>
Message-Id: <e885033cdaa6db92d00b3ea53e69763ba45ef7df.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Restructured the AML ParseLoop function, breaking it into several
subfunctions in order to reduce CPU stack use and improve maintainability

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psloop.c | 1406 +++++++++++++++++++++++-------------------
 include/acpi/acexcep.h       |    8 +-
 2 files changed, 789 insertions(+), 625 deletions(-)

diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index e1541db..a83be52 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -42,12 +42,11 @@
  */
 
 /*
- * Parse the AML and build an operation tree as most interpreters,
- * like Perl, do.  Parsing is done by hand rather than with a YACC
- * generated parser to tightly constrain stack and dynamic memory
- * usage.  At the same time, parsing is kept flexible and the code
- * fairly compact by parsing based on a list of AML opcode
- * templates in aml_op_info[]
+ * Parse the AML and build an operation tree as most interpreters, (such as
+ * Perl) do. Parsing is done by hand rather than with a YACC generated parser
+ * to tightly constrain stack and dynamic memory usage. Parsing is kept
+ * flexible and the code fairly compact by parsing based on a list of AML
+ * opcode templates in aml_op_info[].
  */
 
 #include <acpi/acpi.h>
@@ -60,766 +59,679 @@ ACPI_MODULE_NAME("psloop")
 
 static u32 acpi_gbl_depth = 0;
 
+/* Local prototypes */
+
+static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state);
+
+static acpi_status
+acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
+		       u8 * aml_op_start,
+		       union acpi_parse_object *unnamed_op,
+		       union acpi_parse_object **op);
+
+static acpi_status
+acpi_ps_create_op(struct acpi_walk_state *walk_state,
+		  u8 * aml_op_start, union acpi_parse_object **new_op);
+
+static acpi_status
+acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
+		      u8 * aml_op_start, union acpi_parse_object *op);
+
+static acpi_status
+acpi_ps_complete_op(struct acpi_walk_state *walk_state,
+		    union acpi_parse_object **op, acpi_status status);
+
+static acpi_status
+acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
+			  union acpi_parse_object *op, acpi_status status);
+
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ps_parse_loop
+ * FUNCTION:    acpi_ps_get_aml_opcode
  *
  * PARAMETERS:  walk_state          - Current state
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Parse AML (pointed to by the current parser state) and return
- *              a tree of ops.
+ * DESCRIPTION: Extract the next AML opcode from the input stream.
  *
  ******************************************************************************/
 
-acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
+static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 {
-	acpi_status status = AE_OK;
-	acpi_status status2;
-	union acpi_parse_object *op = NULL;	/* current op */
-	union acpi_parse_object *arg = NULL;
-	union acpi_parse_object *pre_op = NULL;
-	struct acpi_parse_state *parser_state;
-	u8 *aml_op_start = NULL;
 
-	ACPI_FUNCTION_TRACE_PTR(ps_parse_loop, walk_state);
+	ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
 
-	if (walk_state->descending_callback == NULL) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
+	walk_state->aml_offset =
+	    (u32) ACPI_PTR_DIFF(walk_state->parser_state.aml,
+				walk_state->parser_state.aml_start);
+	walk_state->opcode = acpi_ps_peek_opcode(&(walk_state->parser_state));
 
-	parser_state = &walk_state->parser_state;
-	walk_state->arg_types = 0;
+	/*
+	 * First cut to determine what we have found:
+	 * 1) A valid AML opcode
+	 * 2) A name string
+	 * 3) An unknown/invalid opcode
+	 */
+	walk_state->op_info = acpi_ps_get_opcode_info(walk_state->opcode);
 
-#if (!defined (ACPI_NO_METHOD_EXECUTION) && !defined (ACPI_CONSTANT_EVAL_ONLY))
+	switch (walk_state->op_info->class) {
+	case AML_CLASS_ASCII:
+	case AML_CLASS_PREFIX:
+		/*
+		 * Starts with a valid prefix or ASCII char, this is a name
+		 * string. Convert the bare name string to a namepath.
+		 */
+		walk_state->opcode = AML_INT_NAMEPATH_OP;
+		walk_state->arg_types = ARGP_NAMESTRING;
+		break;
 
-	if (walk_state->walk_type & ACPI_WALK_METHOD_RESTART) {
+	case AML_CLASS_UNKNOWN:
 
-		/* We are restarting a preempted control method */
+		/* The opcode is unrecognized. Just skip unknown opcodes */
 
-		if (acpi_ps_has_completed_scope(parser_state)) {
-			/*
-			 * We must check if a predicate to an IF or WHILE statement
-			 * was just completed
-			 */
-			if ((parser_state->scope->parse_scope.op) &&
-			    ((parser_state->scope->parse_scope.op->common.
-			      aml_opcode == AML_IF_OP)
-			     || (parser_state->scope->parse_scope.op->common.
-				 aml_opcode == AML_WHILE_OP))
-			    && (walk_state->control_state)
-			    && (walk_state->control_state->common.state ==
-				ACPI_CONTROL_PREDICATE_EXECUTING)) {
-				/*
-				 * A predicate was just completed, get the value of the
-				 * predicate and branch based on that value
-				 */
-				walk_state->op = NULL;
-				status =
-				    acpi_ds_get_predicate_value(walk_state,
-								ACPI_TO_POINTER
-								(TRUE));
-				if (ACPI_FAILURE(status)
-				    && ((status & AE_CODE_MASK) !=
-					AE_CODE_CONTROL)) {
-					if (status == AE_AML_NO_RETURN_VALUE) {
-						ACPI_EXCEPTION((AE_INFO, status,
-								"Invoked method did not return a value"));
+		ACPI_ERROR((AE_INFO,
+			    "Found unknown opcode %X at AML address %p offset %X, ignoring",
+			    walk_state->opcode, walk_state->parser_state.aml,
+			    walk_state->aml_offset));
 
-					}
-					ACPI_EXCEPTION((AE_INFO, status,
-							"GetPredicate Failed"));
-					return_ACPI_STATUS(status);
-				}
+		ACPI_DUMP_BUFFER(walk_state->parser_state.aml, 128);
 
-				status =
-				    acpi_ps_next_parse_state(walk_state, op,
-							     status);
-			}
+		/* Assume one-byte bad opcode */
 
-			acpi_ps_pop_scope(parser_state, &op,
-					  &walk_state->arg_types,
-					  &walk_state->arg_count);
-			ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-					  "Popped scope, Op=%p\n", op));
-		} else if (walk_state->prev_op) {
+		walk_state->parser_state.aml++;
+		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 
-			/* We were in the middle of an op */
+	default:
 
-			op = walk_state->prev_op;
-			walk_state->arg_types = walk_state->prev_arg_types;
-		}
+		/* Found opcode info, this is a normal opcode */
+
+		walk_state->parser_state.aml +=
+		    acpi_ps_get_opcode_size(walk_state->opcode);
+		walk_state->arg_types = walk_state->op_info->parse_args;
+		break;
 	}
-#endif
 
-	/* Iterative parsing loop, while there is more AML to process: */
+	return_ACPI_STATUS(AE_OK);
+}
 
-	while ((parser_state->aml < parser_state->aml_end) || (op)) {
-		aml_op_start = parser_state->aml;
-		if (!op) {
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_build_named_op
+ *
+ * PARAMETERS:  walk_state          - Current state
+ *              aml_op_start        - Begin of named Op in AML
+ *              unnamed_op          - Early Op (not a named Op)
+ *              Op                  - Returned Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Parse a named Op
+ *
+ ******************************************************************************/
 
-			/* Get the next opcode from the AML stream */
+static acpi_status
+acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
+		       u8 * aml_op_start,
+		       union acpi_parse_object *unnamed_op,
+		       union acpi_parse_object **op)
+{
+	acpi_status status = AE_OK;
+	union acpi_parse_object *arg = NULL;
 
-			walk_state->aml_offset =
-			    (u32) ACPI_PTR_DIFF(parser_state->aml,
-						parser_state->aml_start);
-			walk_state->opcode = acpi_ps_peek_opcode(parser_state);
+	ACPI_FUNCTION_TRACE_PTR(ps_build_named_op, walk_state);
 
-			/*
-			 * First cut to determine what we have found:
-			 * 1) A valid AML opcode
-			 * 2) A name string
-			 * 3) An unknown/invalid opcode
-			 */
-			walk_state->op_info =
-			    acpi_ps_get_opcode_info(walk_state->opcode);
-			switch (walk_state->op_info->class) {
-			case AML_CLASS_ASCII:
-			case AML_CLASS_PREFIX:
-				/*
-				 * Starts with a valid prefix or ASCII char, this is a name
-				 * string.  Convert the bare name string to a namepath.
-				 */
-				walk_state->opcode = AML_INT_NAMEPATH_OP;
-				walk_state->arg_types = ARGP_NAMESTRING;
-				break;
+	unnamed_op->common.value.arg = NULL;
+	unnamed_op->common.aml_opcode = walk_state->opcode;
 
-			case AML_CLASS_UNKNOWN:
+	/*
+	 * Get and append arguments until we find the node that contains
+	 * the name (the type ARGP_NAME).
+	 */
+	while (GET_CURRENT_ARG_TYPE(walk_state->arg_types) &&
+	       (GET_CURRENT_ARG_TYPE(walk_state->arg_types) != ARGP_NAME)) {
+		status =
+		    acpi_ps_get_next_arg(walk_state,
+					 &(walk_state->parser_state),
+					 GET_CURRENT_ARG_TYPE(walk_state->
+							      arg_types), &arg);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 
-				/* The opcode is unrecognized.  Just skip unknown opcodes */
+		acpi_ps_append_arg(unnamed_op, arg);
+		INCREMENT_ARG_LIST(walk_state->arg_types);
+	}
 
-				ACPI_ERROR((AE_INFO,
-					    "Found unknown opcode %X at AML address %p offset %X, ignoring",
-					    walk_state->opcode,
-					    parser_state->aml,
-					    walk_state->aml_offset));
+	/*
+	 * Make sure that we found a NAME and didn't run out of arguments
+	 */
+	if (!GET_CURRENT_ARG_TYPE(walk_state->arg_types)) {
+		return_ACPI_STATUS(AE_AML_NO_OPERAND);
+	}
 
-				ACPI_DUMP_BUFFER(parser_state->aml, 128);
+	/* We know that this arg is a name, move to next arg */
 
-				/* Assume one-byte bad opcode */
+	INCREMENT_ARG_LIST(walk_state->arg_types);
 
-				parser_state->aml++;
-				continue;
+	/*
+	 * Find the object. This will either insert the object into
+	 * the namespace or simply look it up
+	 */
+	walk_state->op = NULL;
 
-			default:
+	status = walk_state->descending_callback(walk_state, op);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "During name lookup/catalog"));
+		return_ACPI_STATUS(status);
+	}
 
-				/* Found opcode info, this is a normal opcode */
+	if (!op) {
+		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
+	}
 
-				parser_state->aml +=
-				    acpi_ps_get_opcode_size(walk_state->opcode);
-				walk_state->arg_types =
-				    walk_state->op_info->parse_args;
-				break;
-			}
+	status = acpi_ps_next_parse_state(walk_state, *op, status);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_CTRL_PENDING) {
+			return_ACPI_STATUS(AE_CTRL_PARSE_PENDING);
+		}
+		return_ACPI_STATUS(status);
+	}
 
-			/* Create Op structure and append to parent's argument list */
+	acpi_ps_append_arg(*op, unnamed_op->common.value.arg);
+	acpi_gbl_depth++;
 
-			if (walk_state->op_info->flags & AML_NAMED) {
+	if ((*op)->common.aml_opcode == AML_REGION_OP) {
+		/*
+		 * Defer final parsing of an operation_region body, because we don't
+		 * have enough info in the first pass to parse it correctly (i.e.,
+		 * there may be method calls within the term_arg elements of the body.)
+		 *
+		 * However, we must continue parsing because the opregion is not a
+		 * standalone package -- we don't know where the end is at this point.
+		 *
+		 * (Length is unknown until parse of the body complete)
+		 */
+		(*op)->named.data = aml_op_start;
+		(*op)->named.length = 0;
+	}
 
-				/* Allocate a new pre_op if necessary */
+	return_ACPI_STATUS(AE_OK);
+}
 
-				if (!pre_op) {
-					pre_op =
-					    acpi_ps_alloc_op(walk_state->
-							     opcode);
-					if (!pre_op) {
-						status = AE_NO_MEMORY;
-						goto close_this_op;
-					}
-				}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_create_op
+ *
+ * PARAMETERS:  walk_state          - Current state
+ *              aml_op_start        - Op start in AML
+ *              new_op              - Returned Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get Op from AML
+ *
+ ******************************************************************************/
 
-				pre_op->common.value.arg = NULL;
-				pre_op->common.aml_opcode = walk_state->opcode;
+static acpi_status
+acpi_ps_create_op(struct acpi_walk_state *walk_state,
+		  u8 * aml_op_start, union acpi_parse_object **new_op)
+{
+	acpi_status status = AE_OK;
+	union acpi_parse_object *op;
+	union acpi_parse_object *named_op = NULL;
 
-				/*
-				 * Get and append arguments until we find the node that contains
-				 * the name (the type ARGP_NAME).
-				 */
-				while (GET_CURRENT_ARG_TYPE
-				       (walk_state->arg_types)
-				       &&
-				       (GET_CURRENT_ARG_TYPE
-					(walk_state->arg_types) != ARGP_NAME)) {
-					status =
-					    acpi_ps_get_next_arg(walk_state,
-								 parser_state,
-								 GET_CURRENT_ARG_TYPE
-								 (walk_state->
-								  arg_types),
-								 &arg);
-					if (ACPI_FAILURE(status)) {
-						goto close_this_op;
-					}
+	ACPI_FUNCTION_TRACE_PTR(ps_create_op, walk_state);
 
-					acpi_ps_append_arg(pre_op, arg);
-					INCREMENT_ARG_LIST(walk_state->
-							   arg_types);
-				}
+	status = acpi_ps_get_aml_opcode(walk_state);
+	if (status == AE_CTRL_PARSE_CONTINUE) {
+		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
+	}
 
-				/*
-				 * Make sure that we found a NAME and didn't run out of
-				 * arguments
-				 */
-				if (!GET_CURRENT_ARG_TYPE
-				    (walk_state->arg_types)) {
-					status = AE_AML_NO_OPERAND;
-					goto close_this_op;
-				}
+	/* Create Op structure and append to parent's argument list */
 
-				/* We know that this arg is a name, move to next arg */
+	walk_state->op_info = acpi_ps_get_opcode_info(walk_state->opcode);
+	op = acpi_ps_alloc_op(walk_state->opcode);
+	if (!op) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
 
-				INCREMENT_ARG_LIST(walk_state->arg_types);
+	if (walk_state->op_info->flags & AML_NAMED) {
+		status =
+		    acpi_ps_build_named_op(walk_state, aml_op_start, op,
+					   &named_op);
+		acpi_ps_free_op(op);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 
-				/*
-				 * Find the object.  This will either insert the object into
-				 * the namespace or simply look it up
-				 */
-				walk_state->op = NULL;
+		*new_op = named_op;
+		return_ACPI_STATUS(AE_OK);
+	}
 
-				status =
-				    walk_state->descending_callback(walk_state,
-								    &op);
-				if (ACPI_FAILURE(status)) {
-					ACPI_EXCEPTION((AE_INFO, status,
-							"During name lookup/catalog"));
-					goto close_this_op;
-				}
+	/* Not a named opcode, just allocate Op and append to parent */
 
-				if (!op) {
-					continue;
-				}
+	if (walk_state->op_info->flags & AML_CREATE) {
+		/*
+		 * Backup to beginning of create_xXXfield declaration
+		 * body_length is unknown until we parse the body
+		 */
+		op->named.data = aml_op_start;
+		op->named.length = 0;
+	}
 
-				status =
-				    acpi_ps_next_parse_state(walk_state, op,
-							     status);
-				if (status == AE_CTRL_PENDING) {
-					status = AE_OK;
-					goto close_this_op;
-				}
+	acpi_ps_append_arg(acpi_ps_get_parent_scope
+			   (&(walk_state->parser_state)), op);
 
-				if (ACPI_FAILURE(status)) {
-					goto close_this_op;
-				}
+	if (walk_state->descending_callback != NULL) {
+		/*
+		 * Find the object. This will either insert the object into
+		 * the namespace or simply look it up
+		 */
+		walk_state->op = *new_op = op;
 
-				acpi_ps_append_arg(op,
-						   pre_op->common.value.arg);
-				acpi_gbl_depth++;
-
-				if (op->common.aml_opcode == AML_REGION_OP) {
-					/*
-					 * Defer final parsing of an operation_region body,
-					 * because we don't have enough info in the first pass
-					 * to parse it correctly (i.e., there may be method
-					 * calls within the term_arg elements of the body.)
-					 *
-					 * However, we must continue parsing because
-					 * the opregion is not a standalone package --
-					 * we don't know where the end is at this point.
-					 *
-					 * (Length is unknown until parse of the body complete)
-					 */
-					op->named.data = aml_op_start;
-					op->named.length = 0;
-				}
-			} else {
-				/* Not a named opcode, just allocate Op and append to parent */
+		status = walk_state->descending_callback(walk_state, &op);
+		status = acpi_ps_next_parse_state(walk_state, op, status);
+		if (status == AE_CTRL_PENDING) {
+			status = AE_CTRL_PARSE_PENDING;
+		}
+	}
 
-				walk_state->op_info =
-				    acpi_ps_get_opcode_info(walk_state->opcode);
-				op = acpi_ps_alloc_op(walk_state->opcode);
-				if (!op) {
-					status = AE_NO_MEMORY;
-					goto close_this_op;
-				}
+	return_ACPI_STATUS(status);
+}
 
-				if (walk_state->op_info->flags & AML_CREATE) {
-					/*
-					 * Backup to beginning of create_xXXfield declaration
-					 * body_length is unknown until we parse the body
-					 */
-					op->named.data = aml_op_start;
-					op->named.length = 0;
-				}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_get_arguments
+ *
+ * PARAMETERS:  walk_state          - Current state
+ *              aml_op_start        - Op start in AML
+ *              Op                  - Current Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Get arguments for passed Op.
+ *
+ ******************************************************************************/
 
-				acpi_ps_append_arg(acpi_ps_get_parent_scope
-						   (parser_state), op);
+static acpi_status
+acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
+		      u8 * aml_op_start, union acpi_parse_object *op)
+{
+	acpi_status status = AE_OK;
+	union acpi_parse_object *arg = NULL;
 
-				if ((walk_state->descending_callback != NULL)) {
-					/*
-					 * Find the object. This will either insert the object into
-					 * the namespace or simply look it up
-					 */
-					walk_state->op = op;
+	ACPI_FUNCTION_TRACE_PTR(ps_get_arguments, walk_state);
 
-					status =
-					    walk_state->
-					    descending_callback(walk_state,
-								&op);
-					status =
-					    acpi_ps_next_parse_state(walk_state,
-								     op,
-								     status);
-					if (status == AE_CTRL_PENDING) {
-						status = AE_OK;
-						goto close_this_op;
-					}
+	switch (op->common.aml_opcode) {
+	case AML_BYTE_OP:	/* AML_BYTEDATA_ARG */
+	case AML_WORD_OP:	/* AML_WORDDATA_ARG */
+	case AML_DWORD_OP:	/* AML_DWORDATA_ARG */
+	case AML_QWORD_OP:	/* AML_QWORDATA_ARG */
+	case AML_STRING_OP:	/* AML_ASCIICHARLIST_ARG */
 
-					if (ACPI_FAILURE(status)) {
-						goto close_this_op;
-					}
-				}
-			}
+		/* Fill in constant or string argument directly */
 
-			op->common.aml_offset = walk_state->aml_offset;
+		acpi_ps_get_next_simple_arg(&(walk_state->parser_state),
+					    GET_CURRENT_ARG_TYPE(walk_state->
+								 arg_types),
+					    op);
+		break;
 
-			if (walk_state->op_info) {
-				ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-						  "Opcode %4.4X [%s] Op %p Aml %p AmlOffset %5.5X\n",
-						  (u32) op->common.aml_opcode,
-						  walk_state->op_info->name, op,
-						  parser_state->aml,
-						  op->common.aml_offset));
-			}
+	case AML_INT_NAMEPATH_OP:	/* AML_NAMESTRING_ARG */
+
+		status =
+		    acpi_ps_get_next_namepath(walk_state,
+					      &(walk_state->parser_state), op,
+					      1);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
 		}
 
+		walk_state->arg_types = 0;
+		break;
+
+	default:
 		/*
-		 * Start arg_count at zero because we don't know if there are
-		 * any args yet
+		 * Op is not a constant or string, append each argument to the Op
 		 */
-		walk_state->arg_count = 0;
-
-		/* Are there any arguments that must be processed? */
-
-		if (walk_state->arg_types) {
-
-			/* Get arguments */
-
-			switch (op->common.aml_opcode) {
-			case AML_BYTE_OP:	/* AML_BYTEDATA_ARG */
-			case AML_WORD_OP:	/* AML_WORDDATA_ARG */
-			case AML_DWORD_OP:	/* AML_DWORDATA_ARG */
-			case AML_QWORD_OP:	/* AML_QWORDATA_ARG */
-			case AML_STRING_OP:	/* AML_ASCIICHARLIST_ARG */
-
-				/* Fill in constant or string argument directly */
-
-				acpi_ps_get_next_simple_arg(parser_state,
-							    GET_CURRENT_ARG_TYPE
-							    (walk_state->
-							     arg_types), op);
-				break;
-
-			case AML_INT_NAMEPATH_OP:	/* AML_NAMESTRING_ARG */
-
-				status =
-				    acpi_ps_get_next_namepath(walk_state,
-							      parser_state, op,
-							      1);
-				if (ACPI_FAILURE(status)) {
-					goto close_this_op;
-				}
-
-				walk_state->arg_types = 0;
-				break;
+		while (GET_CURRENT_ARG_TYPE(walk_state->arg_types)
+		       && !walk_state->arg_count) {
+			walk_state->aml_offset =
+			    (u32) ACPI_PTR_DIFF(walk_state->parser_state.aml,
+						walk_state->parser_state.
+						aml_start);
 
-			default:
-				/*
-				 * Op is not a constant or string, append each argument
-				 * to the Op
-				 */
-				while (GET_CURRENT_ARG_TYPE
-				       (walk_state->arg_types)
-				       && !walk_state->arg_count) {
-					walk_state->aml_offset = (u32)
-					    ACPI_PTR_DIFF(parser_state->aml,
-							  parser_state->
-							  aml_start);
+			status =
+			    acpi_ps_get_next_arg(walk_state,
+						 &(walk_state->parser_state),
+						 GET_CURRENT_ARG_TYPE
+						 (walk_state->arg_types), &arg);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
 
-					status =
-					    acpi_ps_get_next_arg(walk_state,
-								 parser_state,
-								 GET_CURRENT_ARG_TYPE
-								 (walk_state->
-								  arg_types),
-								 &arg);
-					if (ACPI_FAILURE(status)) {
-						goto close_this_op;
-					}
+			if (arg) {
+				arg->common.aml_offset = walk_state->aml_offset;
+				acpi_ps_append_arg(op, arg);
+			}
 
-					if (arg) {
-						arg->common.aml_offset =
-						    walk_state->aml_offset;
-						acpi_ps_append_arg(op, arg);
-					}
-					INCREMENT_ARG_LIST(walk_state->
-							   arg_types);
-				}
+			INCREMENT_ARG_LIST(walk_state->arg_types);
+		}
 
-				/* Special processing for certain opcodes */
+		/* Special processing for certain opcodes */
 
-				/* TBD (remove): Temporary mechanism to disable this code if needed */
+		/* TBD (remove): Temporary mechanism to disable this code if needed */
 
 #ifdef ACPI_ENABLE_MODULE_LEVEL_CODE
 
-				if ((walk_state->pass_number <=
-				     ACPI_IMODE_LOAD_PASS1)
-				    &&
-				    ((walk_state->
-				      parse_flags & ACPI_PARSE_DISASSEMBLE) ==
-				     0)) {
-					/*
-					 * We want to skip If/Else/While constructs during Pass1
-					 * because we want to actually conditionally execute the
-					 * code during Pass2.
-					 *
-					 * Except for disassembly, where we always want to
-					 * walk the If/Else/While packages
-					 */
-					switch (op->common.aml_opcode) {
-					case AML_IF_OP:
-					case AML_ELSE_OP:
-					case AML_WHILE_OP:
-
-						ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-								  "Pass1: Skipping an If/Else/While body\n"));
-
-						/* Skip body of if/else/while in pass 1 */
-
-						parser_state->aml =
-						    parser_state->pkg_end;
-						walk_state->arg_count = 0;
-						break;
-
-					default:
-						break;
-					}
-				}
-#endif
-				switch (op->common.aml_opcode) {
-				case AML_METHOD_OP:
-
-					/*
-					 * Skip parsing of control method
-					 * because we don't have enough info in the first pass
-					 * to parse it correctly.
-					 *
-					 * Save the length and address of the body
-					 */
-					op->named.data = parser_state->aml;
-					op->named.length =
-					    (u32) (parser_state->pkg_end -
-						   parser_state->aml);
-
-					/* Skip body of method */
-
-					parser_state->aml =
-					    parser_state->pkg_end;
-					walk_state->arg_count = 0;
-					break;
-
-				case AML_BUFFER_OP:
-				case AML_PACKAGE_OP:
-				case AML_VAR_PACKAGE_OP:
-
-					if ((op->common.parent) &&
-					    (op->common.parent->common.
-					     aml_opcode == AML_NAME_OP)
-					    && (walk_state->pass_number <=
-						ACPI_IMODE_LOAD_PASS2)) {
-						/*
-						 * Skip parsing of Buffers and Packages
-						 * because we don't have enough info in the first pass
-						 * to parse them correctly.
-						 */
-						op->named.data = aml_op_start;
-						op->named.length =
-						    (u32) (parser_state->
-							   pkg_end -
-							   aml_op_start);
-
-						/* Skip body */
-
-						parser_state->aml =
-						    parser_state->pkg_end;
-						walk_state->arg_count = 0;
-					}
-					break;
+		if ((walk_state->pass_number <= ACPI_IMODE_LOAD_PASS1) &&
+		    ((walk_state->parse_flags & ACPI_PARSE_DISASSEMBLE) == 0)) {
+			/*
+			 * We want to skip If/Else/While constructs during Pass1 because we
+			 * want to actually conditionally execute the code during Pass2.
+			 *
+			 * Except for disassembly, where we always want to walk the
+			 * If/Else/While packages
+			 */
+			switch (op->common.aml_opcode) {
+			case AML_IF_OP:
+			case AML_ELSE_OP:
+			case AML_WHILE_OP:
 
-				case AML_WHILE_OP:
+				ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+						  "Pass1: Skipping an If/Else/While body\n"));
 
-					if (walk_state->control_state) {
-						walk_state->control_state->
-						    control.package_end =
-						    parser_state->pkg_end;
-					}
-					break;
+				/* Skip body of if/else/while in pass 1 */
 
-				default:
+				walk_state->parser_state.aml =
+				    walk_state->parser_state.pkg_end;
+				walk_state->arg_count = 0;
+				break;
 
-					/* No action for all other opcodes */
-					break;
-				}
+			default:
 				break;
 			}
 		}
+#endif
 
-		/* Check for arguments that need to be processed */
-
-		if (walk_state->arg_count) {
+		switch (op->common.aml_opcode) {
+		case AML_METHOD_OP:
 			/*
-			 * There are arguments (complex ones), push Op and
-			 * prepare for argument
+			 * Skip parsing of control method because we don't have enough
+			 * info in the first pass to parse it correctly.
+			 *
+			 * Save the length and address of the body
 			 */
-			status = acpi_ps_push_scope(parser_state, op,
-						    walk_state->arg_types,
-						    walk_state->arg_count);
-			if (ACPI_FAILURE(status)) {
-				goto close_this_op;
-			}
-			op = NULL;
-			continue;
-		}
+			op->named.data = walk_state->parser_state.aml;
+			op->named.length = (u32)
+			    (walk_state->parser_state.pkg_end -
+			     walk_state->parser_state.aml);
 
-		/*
-		 * All arguments have been processed -- Op is complete,
-		 * prepare for next
-		 */
-		walk_state->op_info =
-		    acpi_ps_get_opcode_info(op->common.aml_opcode);
-		if (walk_state->op_info->flags & AML_NAMED) {
-			if (acpi_gbl_depth) {
-				acpi_gbl_depth--;
-			}
+			/* Skip body of method */
 
-			if (op->common.aml_opcode == AML_REGION_OP) {
+			walk_state->parser_state.aml =
+			    walk_state->parser_state.pkg_end;
+			walk_state->arg_count = 0;
+			break;
+
+		case AML_BUFFER_OP:
+		case AML_PACKAGE_OP:
+		case AML_VAR_PACKAGE_OP:
+
+			if ((op->common.parent) &&
+			    (op->common.parent->common.aml_opcode ==
+			     AML_NAME_OP)
+			    && (walk_state->pass_number <=
+				ACPI_IMODE_LOAD_PASS2)) {
 				/*
-				 * Skip parsing of control method or opregion body,
-				 * because we don't have enough info in the first pass
-				 * to parse them correctly.
-				 *
-				 * Completed parsing an op_region declaration, we now
-				 * know the length.
+				 * Skip parsing of Buffers and Packages because we don't have
+				 * enough info in the first pass to parse them correctly.
 				 */
-				op->named.length =
-				    (u32) (parser_state->aml - op->named.data);
-			}
-		}
+				op->named.data = aml_op_start;
+				op->named.length = (u32)
+				    (walk_state->parser_state.pkg_end -
+				     aml_op_start);
 
-		if (walk_state->op_info->flags & AML_CREATE) {
-			/*
-			 * Backup to beginning of create_xXXfield declaration (1 for
-			 * Opcode)
-			 *
-			 * body_length is unknown until we parse the body
-			 */
-			op->named.length =
-			    (u32) (parser_state->aml - op->named.data);
-		}
+				/* Skip body */
 
-		/* This op complete, notify the dispatcher */
+				walk_state->parser_state.aml =
+				    walk_state->parser_state.pkg_end;
+				walk_state->arg_count = 0;
+			}
+			break;
 
-		if (walk_state->ascending_callback != NULL) {
-			walk_state->op = op;
-			walk_state->opcode = op->common.aml_opcode;
+		case AML_WHILE_OP:
 
-			status = walk_state->ascending_callback(walk_state);
-			status =
-			    acpi_ps_next_parse_state(walk_state, op, status);
-			if (status == AE_CTRL_PENDING) {
-				status = AE_OK;
-				goto close_this_op;
+			if (walk_state->control_state) {
+				walk_state->control_state->control.package_end =
+				    walk_state->parser_state.pkg_end;
 			}
-		}
-
-	      close_this_op:
-		/*
-		 * Finished one argument of the containing scope
-		 */
-		parser_state->scope->parse_scope.arg_count--;
+			break;
 
-		/* Finished with pre_op */
+		default:
 
-		if (pre_op) {
-			acpi_ps_free_op(pre_op);
-			pre_op = NULL;
+			/* No action for all other opcodes */
+			break;
 		}
 
-		/* Close this Op (will result in parse subtree deletion) */
+		break;
+	}
 
-		status2 = acpi_ps_complete_this_op(walk_state, op);
-		if (ACPI_FAILURE(status2)) {
-			return_ACPI_STATUS(status2);
-		}
-		op = NULL;
+	return_ACPI_STATUS(AE_OK);
+}
 
-		switch (status) {
-		case AE_OK:
-			break;
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_complete_op
+ *
+ * PARAMETERS:  walk_state          - Current state
+ *              Op                  - Returned Op
+ *              Status              - Parse status before complete Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Complete Op
+ *
+ ******************************************************************************/
 
-		case AE_CTRL_TRANSFER:
+static acpi_status
+acpi_ps_complete_op(struct acpi_walk_state *walk_state,
+		    union acpi_parse_object **op, acpi_status status)
+{
+	acpi_status status2;
 
-			/* We are about to transfer to a called method. */
+	ACPI_FUNCTION_TRACE_PTR(ps_complete_op, walk_state);
 
-			walk_state->prev_op = op;
-			walk_state->prev_arg_types = walk_state->arg_types;
-			return_ACPI_STATUS(status);
+	/*
+	 * Finished one argument of the containing scope
+	 */
+	walk_state->parser_state.scope->parse_scope.arg_count--;
 
-		case AE_CTRL_END:
+	/* Close this Op (will result in parse subtree deletion) */
 
-			acpi_ps_pop_scope(parser_state, &op,
-					  &walk_state->arg_types,
-					  &walk_state->arg_count);
+	status2 = acpi_ps_complete_this_op(walk_state, *op);
+	if (ACPI_FAILURE(status2)) {
+		return_ACPI_STATUS(status2);
+	}
 
-			if (op) {
-				walk_state->op = op;
-				walk_state->op_info =
-				    acpi_ps_get_opcode_info(op->common.
-							    aml_opcode);
-				walk_state->opcode = op->common.aml_opcode;
+	*op = NULL;
 
-				status =
-				    walk_state->ascending_callback(walk_state);
-				status =
-				    acpi_ps_next_parse_state(walk_state, op,
-							     status);
+	switch (status) {
+	case AE_OK:
+		break;
 
-				status2 =
-				    acpi_ps_complete_this_op(walk_state, op);
-				if (ACPI_FAILURE(status2)) {
-					return_ACPI_STATUS(status2);
-				}
-				op = NULL;
-			}
-			status = AE_OK;
-			break;
+	case AE_CTRL_TRANSFER:
 
-		case AE_CTRL_BREAK:
-		case AE_CTRL_CONTINUE:
+		/* We are about to transfer to a called method */
 
-			/* Pop off scopes until we find the While */
+		walk_state->prev_op = NULL;
+		walk_state->prev_arg_types = walk_state->arg_types;
+		return_ACPI_STATUS(status);
 
-			while (!op || (op->common.aml_opcode != AML_WHILE_OP)) {
-				acpi_ps_pop_scope(parser_state, &op,
-						  &walk_state->arg_types,
-						  &walk_state->arg_count);
+	case AE_CTRL_END:
 
-				if (op->common.aml_opcode != AML_WHILE_OP) {
-					status2 =
-					    acpi_ds_result_stack_pop
-					    (walk_state);
-					if (ACPI_FAILURE(status2)) {
-						return_ACPI_STATUS(status2);
-					}
-				}
-			}
-
-			/* Close this iteration of the While loop */
+		acpi_ps_pop_scope(&(walk_state->parser_state), op,
+				  &walk_state->arg_types,
+				  &walk_state->arg_count);
 
-			walk_state->op = op;
+		if (*op) {
+			walk_state->op = *op;
 			walk_state->op_info =
-			    acpi_ps_get_opcode_info(op->common.aml_opcode);
-			walk_state->opcode = op->common.aml_opcode;
+			    acpi_ps_get_opcode_info((*op)->common.aml_opcode);
+			walk_state->opcode = (*op)->common.aml_opcode;
 
 			status = walk_state->ascending_callback(walk_state);
 			status =
-			    acpi_ps_next_parse_state(walk_state, op, status);
+			    acpi_ps_next_parse_state(walk_state, *op, status);
 
-			status2 = acpi_ps_complete_this_op(walk_state, op);
+			status2 = acpi_ps_complete_this_op(walk_state, *op);
 			if (ACPI_FAILURE(status2)) {
 				return_ACPI_STATUS(status2);
 			}
-			op = NULL;
-
-			status = AE_OK;
-			break;
+		}
 
-		case AE_CTRL_TERMINATE:
+		status = AE_OK;
+		break;
 
-			status = AE_OK;
+	case AE_CTRL_BREAK:
+	case AE_CTRL_CONTINUE:
 
-			/* Clean up */
-			do {
-				if (op) {
-					status2 =
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
-					if (ACPI_FAILURE(status2)) {
-						return_ACPI_STATUS(status2);
-					}
+		/* Pop off scopes until we find the While */
 
-					status2 =
-					    acpi_ds_result_stack_pop
-					    (walk_state);
-					if (ACPI_FAILURE(status2)) {
-						return_ACPI_STATUS(status2);
-					}
+		while (!(*op) || ((*op)->common.aml_opcode != AML_WHILE_OP)) {
+			acpi_ps_pop_scope(&(walk_state->parser_state), op,
+					  &walk_state->arg_types,
+					  &walk_state->arg_count);
 
-					acpi_ut_delete_generic_state
-					    (acpi_ut_pop_generic_state
-					     (&walk_state->control_state));
+			if ((*op)->common.aml_opcode != AML_WHILE_OP) {
+				status2 = acpi_ds_result_stack_pop(walk_state);
+				if (ACPI_FAILURE(status2)) {
+					return_ACPI_STATUS(status2);
 				}
+			}
+		}
 
-				acpi_ps_pop_scope(parser_state, &op,
-						  &walk_state->arg_types,
-						  &walk_state->arg_count);
+		/* Close this iteration of the While loop */
 
-			} while (op);
+		walk_state->op = *op;
+		walk_state->op_info =
+		    acpi_ps_get_opcode_info((*op)->common.aml_opcode);
+		walk_state->opcode = (*op)->common.aml_opcode;
 
-			return_ACPI_STATUS(status);
+		status = walk_state->ascending_callback(walk_state);
+		status = acpi_ps_next_parse_state(walk_state, *op, status);
 
-		default:	/* All other non-AE_OK status */
+		status2 = acpi_ps_complete_this_op(walk_state, *op);
+		if (ACPI_FAILURE(status2)) {
+			return_ACPI_STATUS(status2);
+		}
 
-			do {
-				if (op) {
-					status2 =
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
-					if (ACPI_FAILURE(status2)) {
-						return_ACPI_STATUS(status2);
-					}
+		status = AE_OK;
+		break;
+
+	case AE_CTRL_TERMINATE:
+
+		/* Clean up */
+		do {
+			if (*op) {
+				status2 =
+				    acpi_ps_complete_this_op(walk_state, *op);
+				if (ACPI_FAILURE(status2)) {
+					return_ACPI_STATUS(status2);
+				}
+				status2 = acpi_ds_result_stack_pop(walk_state);
+				if (ACPI_FAILURE(status2)) {
+					return_ACPI_STATUS(status2);
 				}
 
-				acpi_ps_pop_scope(parser_state, &op,
-						  &walk_state->arg_types,
-						  &walk_state->arg_count);
+				acpi_ut_delete_generic_state
+				    (acpi_ut_pop_generic_state
+				     (&walk_state->control_state));
+			}
 
-			} while (op);
+			acpi_ps_pop_scope(&(walk_state->parser_state), op,
+					  &walk_state->arg_types,
+					  &walk_state->arg_count);
 
-			/*
-			 * TBD: Cleanup parse ops on error
-			 */
-#if 0
-			if (op == NULL) {
-				acpi_ps_pop_scope(parser_state, &op,
-						  &walk_state->arg_types,
-						  &walk_state->arg_count);
+		} while (*op);
+
+		return_ACPI_STATUS(AE_OK);
+
+	default:		/* All other non-AE_OK status */
+
+		do {
+			if (*op) {
+				status2 =
+				    acpi_ps_complete_this_op(walk_state, *op);
+				if (ACPI_FAILURE(status2)) {
+					return_ACPI_STATUS(status2);
+				}
 			}
-#endif
-			walk_state->prev_op = op;
-			walk_state->prev_arg_types = walk_state->arg_types;
-			return_ACPI_STATUS(status);
-		}
 
-		/* This scope complete? */
+			acpi_ps_pop_scope(&(walk_state->parser_state), op,
+					  &walk_state->arg_types,
+					  &walk_state->arg_count);
 
-		if (acpi_ps_has_completed_scope(parser_state)) {
-			acpi_ps_pop_scope(parser_state, &op,
+		} while (*op);
+
+#if 0
+		/*
+		 * TBD: Cleanup parse ops on error
+		 */
+		if (*op == NULL) {
+			acpi_ps_pop_scope(parser_state, op,
 					  &walk_state->arg_types,
 					  &walk_state->arg_count);
-			ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-					  "Popped scope, Op=%p\n", op));
-		} else {
-			op = NULL;
 		}
+#endif
+		walk_state->prev_op = NULL;
+		walk_state->prev_arg_types = walk_state->arg_types;
+		return_ACPI_STATUS(status);
+	}
 
-	}			/* while parser_state->Aml */
+	/* This scope complete? */
+
+	if (acpi_ps_has_completed_scope(&(walk_state->parser_state))) {
+		acpi_ps_pop_scope(&(walk_state->parser_state), op,
+				  &walk_state->arg_types,
+				  &walk_state->arg_count);
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "Popped scope, Op=%p\n", *op));
+	} else {
+		*op = NULL;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_complete_final_op
+ *
+ * PARAMETERS:  walk_state          - Current state
+ *              Op                  - Current Op
+ *              Status              - Current parse status before complete last
+ *                                    Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Complete last Op.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
+			  union acpi_parse_object *op, acpi_status status)
+{
+	acpi_status status2;
+
+	ACPI_FUNCTION_TRACE_PTR(ps_complete_final_op, walk_state);
 
 	/*
 	 * Complete the last Op (if not completed), and clear the scope stack.
 	 * It is easily possible to end an AML "package" with an unbounded number
 	 * of open scopes (such as when several ASL blocks are closed with
-	 * sequential closing braces).  We want to terminate each one cleanly.
+	 * sequential closing braces). We want to terminate each one cleanly.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "AML package complete at Op %p\n",
 			  op));
@@ -838,8 +750,12 @@ acpi_status acpi_ps_parse_loop(struct ac
 				    acpi_ps_next_parse_state(walk_state, op,
 							     status);
 				if (status == AE_CTRL_PENDING) {
-					status = AE_OK;
-					goto close_this_op;
+					status =
+					    acpi_ps_complete_op(walk_state, &op,
+								AE_OK);
+					if (ACPI_FAILURE(status)) {
+						return_ACPI_STATUS(status);
+					}
 				}
 
 				if (status == AE_CTRL_TERMINATE) {
@@ -858,7 +774,9 @@ acpi_status acpi_ps_parse_loop(struct ac
 							}
 						}
 
-						acpi_ps_pop_scope(parser_state,
+						acpi_ps_pop_scope(&
+								  (walk_state->
+								   parser_state),
 								  &op,
 								  &walk_state->
 								  arg_types,
@@ -887,10 +805,252 @@ acpi_status acpi_ps_parse_loop(struct ac
 			}
 		}
 
-		acpi_ps_pop_scope(parser_state, &op, &walk_state->arg_types,
+		acpi_ps_pop_scope(&(walk_state->parser_state), &op,
+				  &walk_state->arg_types,
 				  &walk_state->arg_count);
 
 	} while (op);
 
 	return_ACPI_STATUS(status);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_parse_loop
+ *
+ * PARAMETERS:  walk_state          - Current state
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Parse AML (pointed to by the current parser state) and return
+ *              a tree of ops.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
+{
+	acpi_status status = AE_OK;
+	union acpi_parse_object *op = NULL;	/* current op */
+	struct acpi_parse_state *parser_state;
+	u8 *aml_op_start = NULL;
+
+	ACPI_FUNCTION_TRACE_PTR(ps_parse_loop, walk_state);
+
+	if (walk_state->descending_callback == NULL) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	parser_state = &walk_state->parser_state;
+	walk_state->arg_types = 0;
+
+#if (!defined (ACPI_NO_METHOD_EXECUTION) && !defined (ACPI_CONSTANT_EVAL_ONLY))
+
+	if (walk_state->walk_type & ACPI_WALK_METHOD_RESTART) {
+
+		/* We are restarting a preempted control method */
+
+		if (acpi_ps_has_completed_scope(parser_state)) {
+			/*
+			 * We must check if a predicate to an IF or WHILE statement
+			 * was just completed
+			 */
+			if ((parser_state->scope->parse_scope.op) &&
+			    ((parser_state->scope->parse_scope.op->common.
+			      aml_opcode == AML_IF_OP)
+			     || (parser_state->scope->parse_scope.op->common.
+				 aml_opcode == AML_WHILE_OP))
+			    && (walk_state->control_state)
+			    && (walk_state->control_state->common.state ==
+				ACPI_CONTROL_PREDICATE_EXECUTING)) {
+				/*
+				 * A predicate was just completed, get the value of the
+				 * predicate and branch based on that value
+				 */
+				walk_state->op = NULL;
+				status =
+				    acpi_ds_get_predicate_value(walk_state,
+								ACPI_TO_POINTER
+								(TRUE));
+				if (ACPI_FAILURE(status)
+				    && ((status & AE_CODE_MASK) !=
+					AE_CODE_CONTROL)) {
+					if (status == AE_AML_NO_RETURN_VALUE) {
+						ACPI_EXCEPTION((AE_INFO, status,
+								"Invoked method did not return a value"));
+
+					}
+
+					ACPI_EXCEPTION((AE_INFO, status,
+							"GetPredicate Failed"));
+					return_ACPI_STATUS(status);
+				}
+
+				status =
+				    acpi_ps_next_parse_state(walk_state, op,
+							     status);
+			}
+
+			acpi_ps_pop_scope(parser_state, &op,
+					  &walk_state->arg_types,
+					  &walk_state->arg_count);
+			ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+					  "Popped scope, Op=%p\n", op));
+		} else if (walk_state->prev_op) {
+
+			/* We were in the middle of an op */
+
+			op = walk_state->prev_op;
+			walk_state->arg_types = walk_state->prev_arg_types;
+		}
+	}
+#endif
+
+	/* Iterative parsing loop, while there is more AML to process: */
+
+	while ((parser_state->aml < parser_state->aml_end) || (op)) {
+		aml_op_start = parser_state->aml;
+		if (!op) {
+			status =
+			    acpi_ps_create_op(walk_state, aml_op_start, &op);
+			if (ACPI_FAILURE(status)) {
+				if (status == AE_CTRL_PARSE_CONTINUE) {
+					continue;
+				}
+
+				if (status == AE_CTRL_PARSE_PENDING) {
+					status = AE_OK;
+				}
+
+				status =
+				    acpi_ps_complete_op(walk_state, &op,
+							status);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+
+				continue;
+			}
+
+			op->common.aml_offset = walk_state->aml_offset;
+
+			if (walk_state->op_info) {
+				ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+						  "Opcode %4.4X [%s] Op %p Aml %p AmlOffset %5.5X\n",
+						  (u32) op->common.aml_opcode,
+						  walk_state->op_info->name, op,
+						  parser_state->aml,
+						  op->common.aml_offset));
+			}
+		}
+
+		/*
+		 * Start arg_count at zero because we don't know if there are
+		 * any args yet
+		 */
+		walk_state->arg_count = 0;
+
+		/* Are there any arguments that must be processed? */
+
+		if (walk_state->arg_types) {
+
+			/* Get arguments */
+
+			status =
+			    acpi_ps_get_arguments(walk_state, aml_op_start, op);
+			if (ACPI_FAILURE(status)) {
+				status =
+				    acpi_ps_complete_op(walk_state, &op,
+							status);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+
+				continue;
+			}
+		}
+
+		/* Check for arguments that need to be processed */
+
+		if (walk_state->arg_count) {
+			/*
+			 * There are arguments (complex ones), push Op and
+			 * prepare for argument
+			 */
+			status = acpi_ps_push_scope(parser_state, op,
+						    walk_state->arg_types,
+						    walk_state->arg_count);
+			if (ACPI_FAILURE(status)) {
+				status =
+				    acpi_ps_complete_op(walk_state, &op,
+							status);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+
+				continue;
+			}
+
+			op = NULL;
+			continue;
+		}
+
+		/*
+		 * All arguments have been processed -- Op is complete,
+		 * prepare for next
+		 */
+		walk_state->op_info =
+		    acpi_ps_get_opcode_info(op->common.aml_opcode);
+		if (walk_state->op_info->flags & AML_NAMED) {
+			if (acpi_gbl_depth) {
+				acpi_gbl_depth--;
+			}
+
+			if (op->common.aml_opcode == AML_REGION_OP) {
+				/*
+				 * Skip parsing of control method or opregion body,
+				 * because we don't have enough info in the first pass
+				 * to parse them correctly.
+				 *
+				 * Completed parsing an op_region declaration, we now
+				 * know the length.
+				 */
+				op->named.length =
+				    (u32) (parser_state->aml - op->named.data);
+			}
+		}
+
+		if (walk_state->op_info->flags & AML_CREATE) {
+			/*
+			 * Backup to beginning of create_xXXfield declaration (1 for
+			 * Opcode)
+			 *
+			 * body_length is unknown until we parse the body
+			 */
+			op->named.length =
+			    (u32) (parser_state->aml - op->named.data);
+		}
+
+		/* This op complete, notify the dispatcher */
+
+		if (walk_state->ascending_callback != NULL) {
+			walk_state->op = op;
+			walk_state->opcode = op->common.aml_opcode;
+
+			status = walk_state->ascending_callback(walk_state);
+			status =
+			    acpi_ps_next_parse_state(walk_state, op, status);
+			if (status == AE_CTRL_PENDING) {
+				status = AE_OK;
+			}
+		}
+
+		status = acpi_ps_complete_op(walk_state, &op, status);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
+	}			/* while parser_state->Aml */
+
+	status = acpi_ps_complete_final_op(walk_state, op, status);
+	return_ACPI_STATUS(status);
+}
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 797ca1e..8fa00e8 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -178,8 +178,10 @@
 #define AE_CTRL_BREAK                   (acpi_status) (0x0009 | AE_CODE_CONTROL)
 #define AE_CTRL_CONTINUE                (acpi_status) (0x000A | AE_CODE_CONTROL)
 #define AE_CTRL_SKIP                    (acpi_status) (0x000B | AE_CODE_CONTROL)
+#define AE_CTRL_PARSE_CONTINUE          (acpi_status) (0x000C | AE_CODE_CONTROL)
+#define AE_CTRL_PARSE_PENDING           (acpi_status) (0x000D | AE_CODE_CONTROL)
 
-#define AE_CODE_CTRL_MAX                0x000B
+#define AE_CODE_CTRL_MAX                0x000D
 
 #ifdef DEFINE_ACPI_GLOBALS
 
@@ -291,7 +293,9 @@ char const *acpi_gbl_exception_names_ctr
 	"AE_CTRL_TRANSFER",
 	"AE_CTRL_BREAK",
 	"AE_CTRL_CONTINUE",
-	"AE_CTRL_SKIP"
+	"AE_CTRL_SKIP",
+	"AE_CTRL_PARSE_CONTINUE",
+	"AE_CTRL_PARSE_PENDING"
 };
 
 #endif				/* ACPI GLOBALS */
-- 
1.4.4.1
