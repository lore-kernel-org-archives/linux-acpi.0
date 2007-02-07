From: Len Brown <lenb@kernel.org>
Subject: [PATCH 91/140] ACPICA: Eliminate control method 2-pass parse/execute.
Date: Wed,  7 Feb 2007 13:51:45 -0500
Message-ID: <117087450515-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <9bc75cff4919f9d947982d805aed89582a20d04d.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24742 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422805AbXBGSzL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:11 -0500
In-Reply-To: <1170874504414-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Valery Podrezov <valery.a.podrezov@intel.com>, Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Valery Podrezov <valery.a.podrezov@intel.com>

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
@@ -327,7 +327,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	ACPI_FUNCTION_TRACE_PTR(ds_call_control_method, this_walk_state);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "Execute method %p, currentstate=%p\n",
+			  "Calling method %p, currentstate=%p\n",
 			  this_walk_state->prev_op, this_walk_state));
 
 	/*
@@ -351,49 +351,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
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
@@ -445,8 +403,8 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
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
@@ -226,7 +226,7 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
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
@@ -54,8 +54,6 @@ static void acpi_ps_start_trace(struct acpi_evaluate_info *info);
 
 static void acpi_ps_stop_trace(struct acpi_evaluate_info *info);
 
-static acpi_status acpi_ps_execute_pass(struct acpi_evaluate_info *info);
-
 static void
 acpi_ps_update_parameter_list(struct acpi_evaluate_info *info, u16 action);
 
@@ -215,6 +213,8 @@ static void acpi_ps_stop_trace(struct acpi_evaluate_info *info)
 acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 {
 	acpi_status status;
+	union acpi_parse_object *op;
+	struct acpi_walk_state *walk_state;
 
 	ACPI_FUNCTION_TRACE(ps_execute_method);
 
@@ -234,8 +234,7 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 	}
 
 	/*
-	 * The caller "owns" the parameters, so give each one an extra
-	 * reference
+	 * The caller "owns" the parameters, so give each one an extra reference
 	 */
 	acpi_ps_update_parameter_list(info, REF_INCREMENT);
 
@@ -244,30 +243,50 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
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
@@ -330,62 +349,3 @@ acpi_ps_update_parameter_list(struct acpi_evaluate_info *info, u16 action)
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
1.5.0.rc3.39.gec804
