From: Len Brown <len.brown@intel.com>
Subject: [PATCH 50/65] ACPICA: Eliminate control method 2-pass parse/execute.
Date: Fri, 24 Nov 2006 02:19:00 -0500
Message-ID: <11643528111088-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12136 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934495AbWKXHQO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:14 -0500
In-Reply-To: <11643528091601-git-send-email-len.brown@intel.com>
Message-Id: <debc56bf59819095a2e54a41c2a25d6475a6e761.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Completed an AML interpreter performance enhancement for control method
execution. Previously a 2-pass parse/execution, control methods are now
completely parsed and executed in single pass. This improves overall
interpreter performance by ~25%, reduces code size, and reduces CPU stack use.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |   50 +--------------
 drivers/acpi/parser/psloop.c       |    2 +-
 drivers/acpi/parser/psxface.c      |  114 ++++++++++++------------------------
 3 files changed, 42 insertions(+), 124 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index cf888ad..aa60dca 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -327,7 +327,7 @@ acpi_ds_call_control_method(struct acpi_
 	ACPI_FUNCTION_TRACE_PTR(ds_call_control_method, this_walk_state);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "Execute method %p, currentstate=%p\n",
+			  "Calling method %p, currentstate=%p\n",
 			  this_walk_state->prev_op, this_walk_state));
 
 	/*
@@ -351,49 +351,7 @@ acpi_ds_call_control_method(struct acpi_
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * 1) Parse the method. All "normal" methods are parsed for each execution.
-	 * Internal methods (_OSI, etc.) do not require parsing.
-	 */
-	if (!(obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY)) {
-
-		/* Create a new walk state for the parse */
-
-		next_walk_state =
-		    acpi_ds_create_walk_state(obj_desc->method.owner_id, op,
-					      obj_desc, NULL);
-		if (!next_walk_state) {
-			status = AE_NO_MEMORY;
-			goto cleanup;
-		}
-
-		/* Create and init a parse tree root */
-
-		op = acpi_ps_create_scope_op();
-		if (!op) {
-			status = AE_NO_MEMORY;
-			goto cleanup;
-		}
-
-		status = acpi_ds_init_aml_walk(next_walk_state, op, method_node,
-					       obj_desc->method.aml_start,
-					       obj_desc->method.aml_length,
-					       NULL, 1);
-		if (ACPI_FAILURE(status)) {
-			acpi_ps_delete_parse_tree(op);
-			goto cleanup;
-		}
-
-		/* Begin AML parse (deletes next_walk_state) */
-
-		status = acpi_ps_parse_aml(next_walk_state);
-		acpi_ps_delete_parse_tree(op);
-		if (ACPI_FAILURE(status)) {
-			goto cleanup;
-		}
-	}
-
-	/* 2) Begin method execution. Create a new walk state */
+	/* Begin method parse/execution. Create a new walk state */
 
 	next_walk_state = acpi_ds_create_walk_state(obj_desc->method.owner_id,
 						    NULL, obj_desc, thread);
@@ -445,8 +403,8 @@ acpi_ds_call_control_method(struct acpi_
 	this_walk_state->num_operands = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "Starting nested execution, newstate=%p\n",
-			  next_walk_state));
+			  "**** Begin nested execution of [%4.4s] **** WalkState=%p\n",
+			  method_node->name.ascii, next_walk_state));
 
 	/* Invoke an internal method if necessary */
 
diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index a83be52..881687c 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -226,7 +226,7 @@ acpi_ps_build_named_op(struct acpi_walk_
 		return_ACPI_STATUS(status);
 	}
 
-	if (!op) {
+	if (!*op) {
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
 
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 5d996c1..9069c69 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -54,8 +54,6 @@ static void acpi_ps_start_trace(struct a
 
 static void acpi_ps_stop_trace(struct acpi_evaluate_info *info);
 
-static acpi_status acpi_ps_execute_pass(struct acpi_evaluate_info *info);
-
 static void
 acpi_ps_update_parameter_list(struct acpi_evaluate_info *info, u16 action);
 
@@ -215,6 +213,8 @@ static void acpi_ps_stop_trace(struct ac
 acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 {
 	acpi_status status;
+	union acpi_parse_object *op;
+	struct acpi_walk_state *walk_state;
 
 	ACPI_FUNCTION_TRACE(ps_execute_method);
 
@@ -234,8 +234,7 @@ acpi_status acpi_ps_execute_method(struc
 	}
 
 	/*
-	 * The caller "owns" the parameters, so give each one an extra
-	 * reference
+	 * The caller "owns" the parameters, so give each one an extra reference
 	 */
 	acpi_ps_update_parameter_list(info, REF_INCREMENT);
 
@@ -244,30 +243,50 @@ acpi_status acpi_ps_execute_method(struc
 	acpi_ps_start_trace(info);
 
 	/*
-	 * 1) Perform the first pass parse of the method to enter any
-	 *    named objects that it creates into the namespace
+	 * Execute the method. Performs parse simultaneously
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-			  "**** Begin Method Parse **** Entry=%p obj=%p\n",
-			  info->resolved_node, info->obj_desc));
+			  "**** Begin Method Parse/Execute [%4.4s] **** Node=%p Obj=%p\n",
+			  info->resolved_node->name.ascii, info->resolved_node,
+			  info->obj_desc));
 
-	info->pass_number = 1;
-	status = acpi_ps_execute_pass(info);
-	if (ACPI_FAILURE(status)) {
+	/* Create and init a Root Node */
+
+	op = acpi_ps_create_scope_op();
+	if (!op) {
+		status = AE_NO_MEMORY;
 		goto cleanup;
 	}
 
-	/*
-	 * 2) Execute the method. Performs second pass parse simultaneously
-	 */
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-			  "**** Begin Method Execution **** Entry=%p obj=%p\n",
-			  info->resolved_node, info->obj_desc));
+	/* Create and initialize a new walk state */
 
 	info->pass_number = 3;
-	status = acpi_ps_execute_pass(info);
+	walk_state =
+	    acpi_ds_create_walk_state(info->obj_desc->method.owner_id, NULL,
+				      NULL, NULL);
+	if (!walk_state) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	status = acpi_ds_init_aml_walk(walk_state, op, info->resolved_node,
+				       info->obj_desc->method.aml_start,
+				       info->obj_desc->method.aml_length, info,
+				       info->pass_number);
+	if (ACPI_FAILURE(status)) {
+		acpi_ds_delete_walk_state(walk_state);
+		goto cleanup;
+	}
+
+	/* Parse the AML */
+
+	status = acpi_ps_parse_aml(walk_state);
+
+	/* walk_state was deleted by parse_aml */
 
       cleanup:
+	acpi_ps_delete_parse_tree(op);
+
 	/* End optional tracing */
 
 	acpi_ps_stop_trace(info);
@@ -330,62 +349,3 @@ acpi_ps_update_parameter_list(struct acp
 		}
 	}
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ps_execute_pass
- *
- * PARAMETERS:  Info            - See struct acpi_evaluate_info
- *                                (Used: pass_number, Node, and obj_desc)
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Single AML pass: Parse or Execute a control method
- *
- ******************************************************************************/
-
-static acpi_status acpi_ps_execute_pass(struct acpi_evaluate_info *info)
-{
-	acpi_status status;
-	union acpi_parse_object *op;
-	struct acpi_walk_state *walk_state;
-
-	ACPI_FUNCTION_TRACE(ps_execute_pass);
-
-	/* Create and init a Root Node */
-
-	op = acpi_ps_create_scope_op();
-	if (!op) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	/* Create and initialize a new walk state */
-
-	walk_state =
-	    acpi_ds_create_walk_state(info->obj_desc->method.owner_id, NULL,
-				      NULL, NULL);
-	if (!walk_state) {
-		status = AE_NO_MEMORY;
-		goto cleanup;
-	}
-
-	status = acpi_ds_init_aml_walk(walk_state, op, info->resolved_node,
-				       info->obj_desc->method.aml_start,
-				       info->obj_desc->method.aml_length,
-				       info->pass_number == 1 ? NULL : info,
-				       info->pass_number);
-	if (ACPI_FAILURE(status)) {
-		acpi_ds_delete_walk_state(walk_state);
-		goto cleanup;
-	}
-
-	/* Parse the AML */
-
-	status = acpi_ps_parse_aml(walk_state);
-
-	/* Walk state was deleted by parse_aml */
-
-      cleanup:
-	acpi_ps_delete_parse_tree(op);
-	return_ACPI_STATUS(status);
-}
-- 
1.4.4.1
