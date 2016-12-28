From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/18] ACPICA: Parser: Allow method invocations as target operands
Date: Wed, 28 Dec 2016 15:29:43 +0800
Message-ID: <724cc2170c9ff2ef4d1fe3d9d385817f0f43b92b.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a6cca7a4786cdbfd29cea67e84b5b01a8ae6ff1c

Method invocations as target operands are allowed as target
operands in the ASL grammar. This change implements support
for this. Method must return a reference for this to work
properly at runtime, however.

Link: https://github.com/acpica/acpica/commit/a6cca7a4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psargs.c   | 86 ++++++++++++++++++++++++------------------
 drivers/acpi/acpica/psloop.c   |  4 ++
 drivers/acpi/acpica/psobject.c | 10 ++++-
 drivers/acpi/acpica/pstree.c   | 10 +++--
 4 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index c29c930..4e1065e 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -269,23 +269,13 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
-		if (walk_state->opcode == AML_UNLOAD_OP) {
-			/*
-			 * acpi_ps_get_next_namestring has increased the AML pointer,
-			 * so we need to restore the saved AML pointer for method call.
-			 */
-			walk_state->parser_state.aml = start;
-			walk_state->arg_count = 1;
-			acpi_ps_init_op(arg, AML_INT_METHODCALL_OP);
-			return_ACPI_STATUS(AE_OK);
-		}
 
 		/* This name is actually a control method invocation */
 
 		method_desc = acpi_ns_get_attached_object(node);
 		ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-				  "Control Method - %p Desc %p Path=%p\n", node,
-				  method_desc, path));
+				  "Control Method invocation %4.4s - %p Desc %p Path=%p\n",
+				  node->name.ascii, node, method_desc, path));
 
 		name_op = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP, start);
 		if (!name_op) {
@@ -719,6 +709,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE_PTR(ps_get_next_arg, parser_state);
 
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+			  "Expected argument type ARGP: %s (%2.2X)\n",
+			  acpi_ut_get_argument_type_name(arg_type), arg_type));
+
 	switch (arg_type) {
 	case ARGP_BYTEDATA:
 	case ARGP_WORDDATA:
@@ -796,11 +790,14 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 		}
 		break;
 
-	case ARGP_TARGET:
-	case ARGP_SUPERNAME:
 	case ARGP_SIMPLENAME:
 	case ARGP_NAME_OR_REF:
 
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+				  "**** SimpleName/NameOrRef: %s (%2.2X)\n",
+				  acpi_ut_get_argument_type_name(arg_type),
+				  arg_type));
+
 		subop = acpi_ps_peek_opcode(parser_state);
 		if (subop == 0 ||
 		    acpi_ps_is_leading_char(subop) ||
@@ -816,29 +813,41 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			/* To support super_name arg of Unload */
-
-			if (walk_state->opcode == AML_UNLOAD_OP) {
-				status =
-				    acpi_ps_get_next_namepath(walk_state,
-							      parser_state, arg,
-							      ACPI_POSSIBLE_METHOD_CALL);
-
-				/*
-				 * If the super_name argument is a method call, we have
-				 * already restored the AML pointer, just free this Arg
-				 */
-				if (arg->common.aml_opcode ==
-				    AML_INT_METHODCALL_OP) {
-					acpi_ps_free_op(arg);
-					arg = NULL;
-				}
-			} else {
-				status =
-				    acpi_ps_get_next_namepath(walk_state,
-							      parser_state, arg,
-							      ACPI_NOT_METHOD_CALL);
+			status =
+			    acpi_ps_get_next_namepath(walk_state, parser_state,
+						      arg,
+						      ACPI_NOT_METHOD_CALL);
+		} else {
+			/* Single complex argument, nothing returned */
+
+			walk_state->arg_count = 1;
+		}
+		break;
+
+	case ARGP_TARGET:
+	case ARGP_SUPERNAME:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+				  "**** Target/Supername: %s (%2.2X)\n",
+				  acpi_ut_get_argument_type_name(arg_type),
+				  arg_type));
+
+		subop = acpi_ps_peek_opcode(parser_state);
+		if (subop == 0) {
+
+			/* NULL target (zero). Convert to a NULL namepath */
+
+			arg =
+			    acpi_ps_alloc_op(AML_INT_NAMEPATH_OP,
+					     parser_state->aml);
+			if (!arg) {
+				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
+
+			status =
+			    acpi_ps_get_next_namepath(walk_state, parser_state,
+						      arg,
+						      ACPI_POSSIBLE_METHOD_CALL);
 		} else {
 			/* Single complex argument, nothing returned */
 
@@ -849,6 +858,11 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 	case ARGP_DATAOBJ:
 	case ARGP_TERMARG:
 
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+				  "**** TermArg/DataObj: %s (%2.2X)\n",
+				  acpi_ut_get_argument_type_name(arg_type),
+				  arg_type));
+
 		/* Single complex argument, nothing returned */
 
 		walk_state->arg_count = 1;
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 6a9f5059..ac022b5 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -92,6 +92,10 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE_PTR(ps_get_arguments, walk_state);
 
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+			  "Get arguments for opcode [%s]\n",
+			  op->common.aml_op_name));
+
 	switch (op->common.aml_opcode) {
 	case AML_BYTE_OP:	/* AML_BYTEDATA_ARG */
 	case AML_WORD_OP:	/* AML_WORDDATA_ARG */
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index db0e903..4abf007 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -348,7 +348,15 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 			    argument_count) {
 				op->common.flags |= ACPI_PARSEOP_TARGET;
 			}
-		} else if (parent_scope->common.aml_opcode == AML_INCREMENT_OP) {
+		}
+
+		/*
+		 * Special case for both Increment() and Decrement(), where
+		 * the lone argument is both a source and a target.
+		 */
+		else if ((parent_scope->common.aml_opcode == AML_INCREMENT_OP)
+			 || (parent_scope->common.aml_opcode ==
+			     AML_DECREMENT_OP)) {
 			op->common.flags |= ACPI_PARSEOP_TARGET;
 		}
 	}
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 0288cdb..4266e5e 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -129,10 +129,10 @@ acpi_ps_append_arg(union acpi_parse_object *op, union acpi_parse_object *arg)
 	union acpi_parse_object *prev_arg;
 	const struct acpi_opcode_info *op_info;
 
-	ACPI_FUNCTION_ENTRY();
+	ACPI_FUNCTION_TRACE(ps_append_arg);
 
 	if (!op) {
-		return;
+		return_VOID;
 	}
 
 	/* Get the info structure for this opcode */
@@ -144,7 +144,7 @@ acpi_ps_append_arg(union acpi_parse_object *op, union acpi_parse_object *arg)
 
 		ACPI_ERROR((AE_INFO, "Invalid AML Opcode: 0x%2.2X",
 			    op->common.aml_opcode));
-		return;
+		return_VOID;
 	}
 
 	/* Check if this opcode requires argument sub-objects */
@@ -153,7 +153,7 @@ acpi_ps_append_arg(union acpi_parse_object *op, union acpi_parse_object *arg)
 
 		/* Has no linked argument objects */
 
-		return;
+		return_VOID;
 	}
 
 	/* Append the argument to the linked argument list */
@@ -181,6 +181,8 @@ acpi_ps_append_arg(union acpi_parse_object *op, union acpi_parse_object *arg)
 
 		op->common.arg_list_length++;
 	}
+
+	return_VOID;
 }
 
 /*******************************************************************************
-- 
2.7.4
