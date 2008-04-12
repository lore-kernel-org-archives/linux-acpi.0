From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/73] ACPICA: Several fixes for internal method result stack
Date: Sat, 12 Apr 2008 00:24:44 -0400
Message-ID: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752095AbYDLE15 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:57 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

fixes STACK_OVERFLOW exception on nested method calls. internal
bugzilla 262 and 275.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |    9 +-
 drivers/acpi/dispatcher/dsutils.c  |   52 +++-
 drivers/acpi/dispatcher/dswexec.c  |   43 +---
 drivers/acpi/dispatcher/dswstate.c |  513 ++++++++----------------------------
 drivers/acpi/parser/psloop.c       |   11 -
 drivers/acpi/parser/psparse.c      |   15 +-
 include/acpi/acconfig.h            |   13 +-
 include/acpi/acdispat.h            |   16 +-
 include/acpi/aclocal.h             |    5 +-
 include/acpi/acstruct.h            |    3 +
 10 files changed, 179 insertions(+), 501 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index f501e08..0c4630d 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -808,6 +808,12 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 
 	/* The first operand (for all of these data objects) is the length */
 
+	/*
+	 * Set proper index into operand stack for acpi_ds_obj_stack_push
+	 * invoked inside acpi_ds_create_operand.
+	 */
+	walk_state->operand_index = walk_state->num_operands;
+
 	status = acpi_ds_create_operand(walk_state, op->common.value.arg, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -1070,8 +1076,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 			 * is set to anything other than zero!
 			 */
 			walk_state->return_desc = walk_state->operands[0];
-		} else if ((walk_state->results) &&
-			   (walk_state->results->results.num_results > 0)) {
+		} else if (walk_state->result_count) {
 
 			/* Since we have a real Return(), delete any implicit return */
 
diff --git a/drivers/acpi/dispatcher/dsutils.c b/drivers/acpi/dispatcher/dsutils.c
index 71503c0..d2a8cfd 100644
--- a/drivers/acpi/dispatcher/dsutils.c
+++ b/drivers/acpi/dispatcher/dsutils.c
@@ -630,9 +630,7 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			 * Use value that was already previously returned
 			 * by the evaluation of this argument
 			 */
-			status =
-			    acpi_ds_result_pop_from_bottom(&obj_desc,
-							   walk_state);
+			status = acpi_ds_result_pop(&obj_desc, walk_state);
 			if (ACPI_FAILURE(status)) {
 				/*
 				 * Only error is underflow, and this indicates
@@ -698,27 +696,54 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 {
 	acpi_status status = AE_OK;
 	union acpi_parse_object *arg;
-	u32 arg_count = 0;
+	union acpi_parse_object *arguments[ACPI_OBJ_NUM_OPERANDS];
+	u8 arg_count = 0;
+	u8 count = 0;
+	u8 index = walk_state->num_operands;
+	u8 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_create_operands, first_arg);
 
-	/* For all arguments in the list... */
+	/* Get all arguments in the list */
 
 	arg = first_arg;
 	while (arg) {
-		status = acpi_ds_create_operand(walk_state, arg, arg_count);
-		if (ACPI_FAILURE(status)) {
-			goto cleanup;
+		if (index >= ACPI_OBJ_NUM_OPERANDS) {
+			return_ACPI_STATUS(AE_BAD_DATA);
 		}
 
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "Arg #%d (%p) done, Arg1=%p\n", arg_count,
-				  arg, first_arg));
+		arguments[index] = arg;
+		walk_state->operands[index] = NULL;
 
 		/* Move on to next argument, if any */
 
 		arg = arg->common.next;
 		arg_count++;
+		index++;
+	}
+
+	index--;
+
+	/* It is the appropriate order to get objects from the Result stack */
+
+	for (i = 0; i < arg_count; i++) {
+		arg = arguments[index];
+
+		/* Force the filling of the operand stack in inverse order */
+
+		walk_state->operand_index = index;
+
+		status = acpi_ds_create_operand(walk_state, arg, index);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
+		count++;
+		index--;
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "Arg #%d (%p) done, Arg1=%p\n", index, arg,
+				  first_arg));
 	}
 
 	return_ACPI_STATUS(status);
@@ -729,9 +754,8 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 * pop everything off of the operand stack and delete those
 	 * objects
 	 */
-	(void)acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
+	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
 
-	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %d",
-			(arg_count + 1)));
+	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %d", index));
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index 69693fa..12b1485 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -285,11 +285,6 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 	switch (opcode_class) {
 	case AML_CLASS_CONTROL:
 
-		status = acpi_ds_result_stack_push(walk_state);
-		if (ACPI_FAILURE(status)) {
-			goto error_exit;
-		}
-
 		status = acpi_ds_exec_begin_control_op(walk_state, op);
 		break;
 
@@ -305,20 +300,11 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 			status = acpi_ds_load2_begin_op(walk_state, NULL);
 		}
 
-		if (op->common.aml_opcode == AML_REGION_OP) {
-			status = acpi_ds_result_stack_push(walk_state);
-		}
 		break;
 
 	case AML_CLASS_EXECUTE:
 	case AML_CLASS_CREATE:
-		/*
-		 * Most operators with arguments (except create_xxx_field operators)
-		 * Start a new result/operand state
-		 */
-		if (walk_state->op_info->object_type != ACPI_TYPE_BUFFER_FIELD) {
-			status = acpi_ds_result_stack_push(walk_state);
-		}
+
 		break;
 
 	default:
@@ -374,6 +360,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 	/* Init the walk state */
 
 	walk_state->num_operands = 0;
+	walk_state->operand_index = 0;
 	walk_state->return_desc = NULL;
 	walk_state->result_obj = NULL;
 
@@ -400,13 +387,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 			goto cleanup;
 		}
 
-		/* Done with this result state (Now that operand stack is built) */
-
-		status = acpi_ds_result_stack_pop(walk_state);
-		if (ACPI_FAILURE(status)) {
-			goto cleanup;
-		}
-
 		/*
 		 * All opcodes require operand resolution, with the only exceptions
 		 * being the object_type and size_of operators.
@@ -487,16 +467,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 
 			status = acpi_ds_exec_end_control_op(walk_state, op);
 
-			/* Make sure to properly pop the result stack */
-
-			if (ACPI_SUCCESS(status)) {
-				status = acpi_ds_result_stack_pop(walk_state);
-			} else if (status == AE_CTRL_PENDING) {
-				status = acpi_ds_result_stack_pop(walk_state);
-				if (ACPI_SUCCESS(status)) {
-					status = AE_CTRL_PENDING;
-				}
-			}
 			break;
 
 		case AML_TYPE_METHOD_CALL:
@@ -632,13 +602,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 				break;
 			}
 
-			/* Done with result state (Now that operand stack is built) */
-
-			status = acpi_ds_result_stack_pop(walk_state);
-			if (ACPI_FAILURE(status)) {
-				goto cleanup;
-			}
-
 			/*
 			 * If a result object was returned from above, push it on the
 			 * current result stack
@@ -671,8 +634,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 				if (ACPI_FAILURE(status)) {
 					break;
 				}
-
-				status = acpi_ds_result_stack_pop(walk_state);
 			}
 			break;
 
diff --git a/drivers/acpi/dispatcher/dswstate.c b/drivers/acpi/dispatcher/dswstate.c
index 5afcdd9..698d2e1 100644
--- a/drivers/acpi/dispatcher/dswstate.c
+++ b/drivers/acpi/dispatcher/dswstate.c
@@ -49,85 +49,9 @@
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dswstate")
 
-/* Local prototypes */
-#ifdef ACPI_OBSOLETE_FUNCTIONS
-acpi_status
-acpi_ds_result_insert(void *object,
-		      u32 index, struct acpi_walk_state *walk_state);
-
-acpi_status acpi_ds_obj_stack_delete_all(struct acpi_walk_state *walk_state);
-
-acpi_status
-acpi_ds_obj_stack_pop_object(union acpi_operand_object **object,
-			     struct acpi_walk_state *walk_state);
-
-void *acpi_ds_obj_stack_get_value(u32 index,
-				  struct acpi_walk_state *walk_state);
-#endif
-
-#ifdef ACPI_FUTURE_USAGE
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_result_remove
- *
- * PARAMETERS:  Object              - Where to return the popped object
- *              Index               - Where to extract the object
- *              walk_state          - Current Walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Pop an object off the bottom of this walk's result stack.  In
- *              other words, this is a FIFO.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_result_remove(union acpi_operand_object **object,
-		      u32 index, struct acpi_walk_state *walk_state)
-{
-	union acpi_generic_state *state;
-
-	ACPI_FUNCTION_NAME(ds_result_remove);
-
-	state = walk_state->results;
-	if (!state) {
-		ACPI_ERROR((AE_INFO, "No result object pushed! State=%p",
-			    walk_state));
-		return (AE_NOT_EXIST);
-	}
-
-	if (index >= ACPI_OBJ_MAX_OPERAND) {
-		ACPI_ERROR((AE_INFO,
-			    "Index out of range: %X State=%p Num=%X",
-			    index, walk_state, state->results.num_results));
-	}
-
-	/* Check for a valid result object */
-
-	if (!state->results.obj_desc[index]) {
-		ACPI_ERROR((AE_INFO,
-			    "Null operand! State=%p #Ops=%X, Index=%X",
-			    walk_state, state->results.num_results, index));
-		return (AE_AML_NO_RETURN_VALUE);
-	}
-
-	/* Remove the object */
-
-	state->results.num_results--;
-
-	*object = state->results.obj_desc[index];
-	state->results.obj_desc[index] = NULL;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "Obj=%p [%s] Index=%X State=%p Num=%X\n",
-			  *object,
-			  (*object) ? acpi_ut_get_object_type_name(*object) :
-			  "NULL", index, walk_state,
-			  state->results.num_results));
-
-	return (AE_OK);
-}
-#endif				/*  ACPI_FUTURE_USAGE  */
+  /* Local prototypes */
+static acpi_status acpi_ds_result_stack_push(struct acpi_walk_state *ws);
+static acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state *ws);
 
 /*******************************************************************************
  *
@@ -138,122 +62,67 @@ acpi_ds_result_remove(union acpi_operand_object **object,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Pop an object off the bottom of this walk's result stack.  In
- *              other words, this is a FIFO.
+ * DESCRIPTION: Pop an object off the top of this walk's result stack
  *
  ******************************************************************************/
 
 acpi_status
-acpi_ds_result_pop(union acpi_operand_object ** object,
-		   struct acpi_walk_state * walk_state)
+acpi_ds_result_pop(union acpi_operand_object **object,
+		   struct acpi_walk_state *walk_state)
 {
 	acpi_native_uint index;
 	union acpi_generic_state *state;
+	acpi_status status;
 
 	ACPI_FUNCTION_NAME(ds_result_pop);
 
 	state = walk_state->results;
-	if (!state) {
-		return (AE_OK);
-	}
-
-	if (!state->results.num_results) {
-		ACPI_ERROR((AE_INFO, "Result stack is empty! State=%p",
-			    walk_state));
-		return (AE_AML_NO_RETURN_VALUE);
-	}
 
-	/* Remove top element */
+	/* Incorrect state of result stack */
 
-	state->results.num_results--;
-
-	for (index = ACPI_OBJ_NUM_OPERANDS; index; index--) {
-
-		/* Check for a valid result object */
-
-		if (state->results.obj_desc[index - 1]) {
-			*object = state->results.obj_desc[index - 1];
-			state->results.obj_desc[index - 1] = NULL;
-
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-					  "Obj=%p [%s] Index=%X State=%p Num=%X\n",
-					  *object,
-					  (*object) ?
-					  acpi_ut_get_object_type_name(*object)
-					  : "NULL", (u32) index - 1, walk_state,
-					  state->results.num_results));
-
-			return (AE_OK);
-		}
+	if (state && !walk_state->result_count) {
+		ACPI_ERROR((AE_INFO, "No results on result stack"));
+		return (AE_AML_INTERNAL);
 	}
 
-	ACPI_ERROR((AE_INFO, "No result objects! State=%p", walk_state));
-	return (AE_AML_NO_RETURN_VALUE);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_result_pop_from_bottom
- *
- * PARAMETERS:  Object              - Where to return the popped object
- *              walk_state          - Current Walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Pop an object off the bottom of this walk's result stack.  In
- *              other words, this is a FIFO.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_result_pop_from_bottom(union acpi_operand_object ** object,
-			       struct acpi_walk_state * walk_state)
-{
-	acpi_native_uint index;
-	union acpi_generic_state *state;
+	if (!state && walk_state->result_count) {
+		ACPI_ERROR((AE_INFO, "No result state for result stack"));
+		return (AE_AML_INTERNAL);
+	}
 
-	ACPI_FUNCTION_NAME(ds_result_pop_from_bottom);
+	/* Empty result stack */
 
-	state = walk_state->results;
 	if (!state) {
-		ACPI_ERROR((AE_INFO,
-			    "No result object pushed! State=%p", walk_state));
-		return (AE_NOT_EXIST);
-	}
-
-	if (!state->results.num_results) {
-		ACPI_ERROR((AE_INFO, "No result objects! State=%p",
+		ACPI_ERROR((AE_INFO, "Result stack is empty! State=%p",
 			    walk_state));
 		return (AE_AML_NO_RETURN_VALUE);
 	}
 
-	/* Remove Bottom element */
-
-	*object = state->results.obj_desc[0];
-
-	/* Push entire stack down one element */
-
-	for (index = 0; index < state->results.num_results; index++) {
-		state->results.obj_desc[index] =
-		    state->results.obj_desc[index + 1];
-	}
+	/* Return object of the top element and clean that top element result stack */
 
-	state->results.num_results--;
-
-	/* Check for a valid result object */
+	walk_state->result_count--;
+	index = walk_state->result_count % ACPI_RESULTS_FRAME_OBJ_NUM;
 
+	*object = state->results.obj_desc[index];
 	if (!*object) {
 		ACPI_ERROR((AE_INFO,
-			    "Null operand! State=%p #Ops=%X Index=%X",
-			    walk_state, state->results.num_results,
-			    (u32) index));
+			    "No result objects on result stack, State=%p",
+			    walk_state));
 		return (AE_AML_NO_RETURN_VALUE);
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Obj=%p [%s] Results=%p State=%p\n",
-			  *object,
-			  (*object) ? acpi_ut_get_object_type_name(*object) :
-			  "NULL", state, walk_state));
+	state->results.obj_desc[index] = NULL;
+	if (index == 0) {
+		status = acpi_ds_result_stack_pop(walk_state);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Obj=%p [%s] Index=%X State=%p Num=%X\n", *object,
+			  acpi_ut_get_object_type_name(*object),
+			  (u32) index, walk_state, walk_state->result_count));
 
 	return (AE_OK);
 }
@@ -276,39 +145,56 @@ acpi_ds_result_push(union acpi_operand_object * object,
 		    struct acpi_walk_state * walk_state)
 {
 	union acpi_generic_state *state;
+	acpi_status status;
+	acpi_native_uint index;
 
 	ACPI_FUNCTION_NAME(ds_result_push);
 
+	if (walk_state->result_count > walk_state->result_size) {
+		ACPI_ERROR((AE_INFO, "Result stack is full"));
+		return (AE_AML_INTERNAL);
+	} else if (walk_state->result_count == walk_state->result_size) {
+
+		/* Extend the result stack */
+
+		status = acpi_ds_result_stack_push(walk_state);
+		if (ACPI_FAILURE(status)) {
+			ACPI_ERROR((AE_INFO,
+				    "Failed to extend the result stack"));
+			return (status);
+		}
+	}
+
+	if (!(walk_state->result_count < walk_state->result_size)) {
+		ACPI_ERROR((AE_INFO, "No free elements in result stack"));
+		return (AE_AML_INTERNAL);
+	}
+
 	state = walk_state->results;
 	if (!state) {
 		ACPI_ERROR((AE_INFO, "No result stack frame during push"));
 		return (AE_AML_INTERNAL);
 	}
 
-	if (state->results.num_results == ACPI_OBJ_NUM_OPERANDS) {
-		ACPI_ERROR((AE_INFO,
-			    "Result stack overflow: Obj=%p State=%p Num=%X",
-			    object, walk_state, state->results.num_results));
-		return (AE_STACK_OVERFLOW);
-	}
-
 	if (!object) {
 		ACPI_ERROR((AE_INFO,
 			    "Null Object! Obj=%p State=%p Num=%X",
-			    object, walk_state, state->results.num_results));
+			    object, walk_state, walk_state->result_count));
 		return (AE_BAD_PARAMETER);
 	}
 
-	state->results.obj_desc[state->results.num_results] = object;
-	state->results.num_results++;
+	/* Assign the address of object to the top free element of result stack */
+
+	index = walk_state->result_count % ACPI_RESULTS_FRAME_OBJ_NUM;
+	state->results.obj_desc[index] = object;
+	walk_state->result_count++;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Obj=%p [%s] State=%p Num=%X Cur=%X\n",
 			  object,
-			  object ?
 			  acpi_ut_get_object_type_name((union
 							acpi_operand_object *)
-						       object) : "NULL",
-			  walk_state, state->results.num_results,
+						       object), walk_state,
+			  walk_state->result_count,
 			  walk_state->current_result));
 
 	return (AE_OK);
@@ -322,16 +208,25 @@ acpi_ds_result_push(union acpi_operand_object * object,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Push an object onto the walk_state result stack.
+ * DESCRIPTION: Push an object onto the walk_state result stack
  *
  ******************************************************************************/
 
-acpi_status acpi_ds_result_stack_push(struct acpi_walk_state * walk_state)
+static acpi_status acpi_ds_result_stack_push(struct acpi_walk_state *walk_state)
 {
 	union acpi_generic_state *state;
 
 	ACPI_FUNCTION_NAME(ds_result_stack_push);
 
+	/* Check for stack overflow */
+
+	if ((walk_state->result_size + ACPI_RESULTS_FRAME_OBJ_NUM) >
+	    ACPI_RESULTS_OBJ_NUM_MAX) {
+		ACPI_ERROR((AE_INFO, "Result stack overflow: State=%p Num=%X",
+			    walk_state, walk_state->result_size));
+		return (AE_STACK_OVERFLOW);
+	}
+
 	state = acpi_ut_create_generic_state();
 	if (!state) {
 		return (AE_NO_MEMORY);
@@ -340,6 +235,10 @@ acpi_status acpi_ds_result_stack_push(struct acpi_walk_state * walk_state)
 	state->common.descriptor_type = ACPI_DESC_TYPE_STATE_RESULT;
 	acpi_ut_push_generic_state(&walk_state->results, state);
 
+	/* Increase the length of the result stack by the length of frame */
+
+	walk_state->result_size += ACPI_RESULTS_FRAME_OBJ_NUM;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Results=%p State=%p\n",
 			  state, walk_state));
 
@@ -354,11 +253,11 @@ acpi_status acpi_ds_result_stack_push(struct acpi_walk_state * walk_state)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Pop an object off of the walk_state result stack.
+ * DESCRIPTION: Pop an object off of the walk_state result stack
  *
  ******************************************************************************/
 
-acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state * walk_state)
+static acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state *walk_state)
 {
 	union acpi_generic_state *state;
 
@@ -367,18 +266,27 @@ acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state * walk_state)
 	/* Check for stack underflow */
 
 	if (walk_state->results == NULL) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Underflow - State=%p\n",
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Result stack underflow - State=%p\n",
 				  walk_state));
 		return (AE_AML_NO_OPERAND);
 	}
 
+	if (walk_state->result_size < ACPI_RESULTS_FRAME_OBJ_NUM) {
+		ACPI_ERROR((AE_INFO, "Insufficient result stack size"));
+		return (AE_AML_INTERNAL);
+	}
+
 	state = acpi_ut_pop_generic_state(&walk_state->results);
+	acpi_ut_delete_generic_state(state);
+
+	/* Decrease the length of result stack by the length of frame */
+
+	walk_state->result_size -= ACPI_RESULTS_FRAME_OBJ_NUM;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Result=%p RemainingResults=%X State=%p\n",
-			  state, state->results.num_results, walk_state));
-
-	acpi_ut_delete_generic_state(state);
+			  state, walk_state->result_count, walk_state));
 
 	return (AE_OK);
 }
@@ -412,9 +320,13 @@ acpi_ds_obj_stack_push(void *object, struct acpi_walk_state * walk_state)
 
 	/* Put the object onto the stack */
 
-	walk_state->operands[walk_state->num_operands] = object;
+	walk_state->operands[walk_state->operand_index] = object;
 	walk_state->num_operands++;
 
+	/* For the usual order of filling the operand stack */
+
+	walk_state->operand_index++;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Obj=%p [%s] State=%p #Ops=%X\n",
 			  object,
 			  acpi_ut_get_object_type_name((union
@@ -484,43 +396,36 @@ acpi_ds_obj_stack_pop(u32 pop_count, struct acpi_walk_state * walk_state)
  *
  ******************************************************************************/
 
-acpi_status
+void
 acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
-				 struct acpi_walk_state * walk_state)
+				 struct acpi_walk_state *walk_state)
 {
 	u32 i;
 	union acpi_operand_object *obj_desc;
 
 	ACPI_FUNCTION_NAME(ds_obj_stack_pop_and_delete);
 
-	for (i = 0; i < pop_count; i++) {
-
-		/* Check for stack underflow */
+	if (pop_count == 0) {
+		return;
+	}
 
+	for (i = (pop_count - 1); i >= 0; i--) {
 		if (walk_state->num_operands == 0) {
-			ACPI_ERROR((AE_INFO,
-				    "Object stack underflow! Count=%X State=%p #Ops=%X",
-				    pop_count, walk_state,
-				    walk_state->num_operands));
-			return (AE_STACK_UNDERFLOW);
+			return;
 		}
 
 		/* Pop the stack and delete an object if present in this stack entry */
 
 		walk_state->num_operands--;
-		obj_desc = walk_state->operands[walk_state->num_operands];
+		obj_desc = walk_state->operands[i];
 		if (obj_desc) {
-			acpi_ut_remove_reference(walk_state->
-						 operands[walk_state->
-							  num_operands]);
-			walk_state->operands[walk_state->num_operands] = NULL;
+			acpi_ut_remove_reference(walk_state->operands[i]);
+			walk_state->operands[i] = NULL;
 		}
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Count=%X State=%p #Ops=%X\n",
 			  pop_count, walk_state, walk_state->num_operands));
-
-	return (AE_OK);
 }
 
 /*******************************************************************************
@@ -560,7 +465,7 @@ struct acpi_walk_state *acpi_ds_get_current_walk_state(struct acpi_thread_state
  *
  * RETURN:      None
  *
- * DESCRIPTION: Place the Thread state at the head of the state list.
+ * DESCRIPTION: Place the Thread state at the head of the state list
  *
  ******************************************************************************/
 
@@ -636,7 +541,6 @@ struct acpi_walk_state *acpi_ds_create_walk_state(acpi_owner_id owner_id, union
 						  *thread)
 {
 	struct acpi_walk_state *walk_state;
-	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ds_create_walk_state);
 
@@ -659,14 +563,6 @@ struct acpi_walk_state *acpi_ds_create_walk_state(acpi_owner_id owner_id, union
 	acpi_ds_method_data_init(walk_state);
 #endif
 
-	/* Create an initial result stack entry */
-
-	status = acpi_ds_result_stack_push(walk_state);
-	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(walk_state);
-		return_PTR(NULL);
-	}
-
 	/* Put the new state at the head of the walk list */
 
 	if (thread) {
@@ -860,190 +756,3 @@ void acpi_ds_delete_walk_state(struct acpi_walk_state *walk_state)
 	ACPI_FREE(walk_state);
 	return_VOID;
 }
-
-#ifdef ACPI_OBSOLETE_FUNCTIONS
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_result_insert
- *
- * PARAMETERS:  Object              - Object to push
- *              Index               - Where to insert the object
- *              walk_state          - Current Walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Insert an object onto this walk's result stack
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_result_insert(void *object,
-		      u32 index, struct acpi_walk_state *walk_state)
-{
-	union acpi_generic_state *state;
-
-	ACPI_FUNCTION_NAME(ds_result_insert);
-
-	state = walk_state->results;
-	if (!state) {
-		ACPI_ERROR((AE_INFO, "No result object pushed! State=%p",
-			    walk_state));
-		return (AE_NOT_EXIST);
-	}
-
-	if (index >= ACPI_OBJ_NUM_OPERANDS) {
-		ACPI_ERROR((AE_INFO,
-			    "Index out of range: %X Obj=%p State=%p Num=%X",
-			    index, object, walk_state,
-			    state->results.num_results));
-		return (AE_BAD_PARAMETER);
-	}
-
-	if (!object) {
-		ACPI_ERROR((AE_INFO,
-			    "Null Object! Index=%X Obj=%p State=%p Num=%X",
-			    index, object, walk_state,
-			    state->results.num_results));
-		return (AE_BAD_PARAMETER);
-	}
-
-	state->results.obj_desc[index] = object;
-	state->results.num_results++;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "Obj=%p [%s] State=%p Num=%X Cur=%X\n",
-			  object,
-			  object ?
-			  acpi_ut_get_object_type_name((union
-							acpi_operand_object *)
-						       object) : "NULL",
-			  walk_state, state->results.num_results,
-			  walk_state->current_result));
-
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_obj_stack_delete_all
- *
- * PARAMETERS:  walk_state          - Current Walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Clear the object stack by deleting all objects that are on it.
- *              Should be used with great care, if at all!
- *
- ******************************************************************************/
-
-acpi_status acpi_ds_obj_stack_delete_all(struct acpi_walk_state * walk_state)
-{
-	u32 i;
-
-	ACPI_FUNCTION_TRACE_PTR(ds_obj_stack_delete_all, walk_state);
-
-	/* The stack size is configurable, but fixed */
-
-	for (i = 0; i < ACPI_OBJ_NUM_OPERANDS; i++) {
-		if (walk_state->operands[i]) {
-			acpi_ut_remove_reference(walk_state->operands[i]);
-			walk_state->operands[i] = NULL;
-		}
-	}
-
-	return_ACPI_STATUS(AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_obj_stack_pop_object
- *
- * PARAMETERS:  Object              - Where to return the popped object
- *              walk_state          - Current Walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Pop this walk's object stack.  Objects on the stack are NOT
- *              deleted by this routine.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_obj_stack_pop_object(union acpi_operand_object **object,
-			     struct acpi_walk_state *walk_state)
-{
-	ACPI_FUNCTION_NAME(ds_obj_stack_pop_object);
-
-	/* Check for stack underflow */
-
-	if (walk_state->num_operands == 0) {
-		ACPI_ERROR((AE_INFO,
-			    "Missing operand/stack empty! State=%p #Ops=%X",
-			    walk_state, walk_state->num_operands));
-		*object = NULL;
-		return (AE_AML_NO_OPERAND);
-	}
-
-	/* Pop the stack */
-
-	walk_state->num_operands--;
-
-	/* Check for a valid operand */
-
-	if (!walk_state->operands[walk_state->num_operands]) {
-		ACPI_ERROR((AE_INFO,
-			    "Null operand! State=%p #Ops=%X",
-			    walk_state, walk_state->num_operands));
-		*object = NULL;
-		return (AE_AML_NO_OPERAND);
-	}
-
-	/* Get operand and set stack entry to null */
-
-	*object = walk_state->operands[walk_state->num_operands];
-	walk_state->operands[walk_state->num_operands] = NULL;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Obj=%p [%s] State=%p #Ops=%X\n",
-			  *object, acpi_ut_get_object_type_name(*object),
-			  walk_state, walk_state->num_operands));
-
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_obj_stack_get_value
- *
- * PARAMETERS:  Index               - Stack index whose value is desired.  Based
- *                                    on the top of the stack (index=0 == top)
- *              walk_state          - Current Walk state
- *
- * RETURN:      Pointer to the requested operand
- *
- * DESCRIPTION: Retrieve an object from this walk's operand stack.  Index must
- *              be within the range of the current stack pointer.
- *
- ******************************************************************************/
-
-void *acpi_ds_obj_stack_get_value(u32 index, struct acpi_walk_state *walk_state)
-{
-
-	ACPI_FUNCTION_TRACE_PTR(ds_obj_stack_get_value, walk_state);
-
-	/* Can't do it if the stack is empty */
-
-	if (walk_state->num_operands == 0) {
-		return_PTR(NULL);
-	}
-
-	/* or if the index is past the top of the stack */
-
-	if (index > (walk_state->num_operands - (u32) 1)) {
-		return_PTR(NULL);
-	}
-
-	return_PTR(walk_state->
-		   operands[(acpi_native_uint) (walk_state->num_operands - 1) -
-			    index]);
-}
-#endif
diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index 773aee8..266dd0c 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -603,13 +603,6 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 			acpi_ps_pop_scope(&(walk_state->parser_state), op,
 					  &walk_state->arg_types,
 					  &walk_state->arg_count);
-
-			if ((*op)->common.aml_opcode != AML_WHILE_OP) {
-				status2 = acpi_ds_result_stack_pop(walk_state);
-				if (ACPI_FAILURE(status2)) {
-					return_ACPI_STATUS(status2);
-				}
-			}
 		}
 
 		/* Close this iteration of the While loop */
@@ -640,10 +633,6 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 				if (ACPI_FAILURE(status2)) {
 					return_ACPI_STATUS(status2);
 				}
-				status2 = acpi_ds_result_stack_pop(walk_state);
-				if (ACPI_FAILURE(status2)) {
-					return_ACPI_STATUS(status2);
-				}
 
 				acpi_ut_delete_generic_state
 				    (acpi_ut_pop_generic_state
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 5d63f48..ce3139a 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -349,19 +349,13 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 
 		parser_state->aml = walk_state->aml_last_while;
 		walk_state->control_state->common.value = FALSE;
-		status = acpi_ds_result_stack_pop(walk_state);
-		if (ACPI_SUCCESS(status)) {
-			status = AE_CTRL_BREAK;
-		}
+		status = AE_CTRL_BREAK;
 		break;
 
 	case AE_CTRL_CONTINUE:
 
 		parser_state->aml = walk_state->aml_last_while;
-		status = acpi_ds_result_stack_pop(walk_state);
-		if (ACPI_SUCCESS(status)) {
-			status = AE_CTRL_CONTINUE;
-		}
+		status = AE_CTRL_CONTINUE;
 		break;
 
 	case AE_CTRL_PENDING:
@@ -383,10 +377,7 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 		 * Just close out this package
 		 */
 		parser_state->aml = acpi_ps_get_next_package_end(parser_state);
-		status = acpi_ds_result_stack_pop(walk_state);
-		if (ACPI_SUCCESS(status)) {
-			status = AE_CTRL_PENDING;
-		}
+		status = AE_CTRL_PENDING;
 		break;
 
 	case AE_CTRL_FALSE:
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 422f29c..d13bab4 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -63,7 +63,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20070126
+#define ACPI_CA_VERSION                 0x20070307
 
 /*
  * OS name, used for the _OS object.  The _OS object is essentially obsolete,
@@ -150,6 +150,17 @@
 #define ACPI_OBJ_NUM_OPERANDS           8
 #define ACPI_OBJ_MAX_OPERAND            7
 
+/* Number of elements in the Result Stack frame, can be an arbitrary value */
+
+#define ACPI_RESULTS_FRAME_OBJ_NUM      8
+
+/*
+ * Maximal number of elements the Result Stack can contain,
+ * it may be an arbitray value not exceeding the types of
+ * result_size and result_count (now u8).
+ */
+#define ACPI_RESULTS_OBJ_NUM_MAX        255
+
 /* Names within the namespace are 4 bytes long */
 
 #define ACPI_NAME_SIZE                  4
diff --git a/include/acpi/acdispat.h b/include/acpi/acdispat.h
index 7f690bb..70d649e 100644
--- a/include/acpi/acdispat.h
+++ b/include/acpi/acdispat.h
@@ -303,7 +303,7 @@ acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
 		      u32 aml_length,
 		      struct acpi_evaluate_info *info, u8 pass_number);
 
-acpi_status
+void
 acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 				 struct acpi_walk_state *walk_state);
 
@@ -316,21 +316,11 @@ void
 acpi_ds_push_walk_state(struct acpi_walk_state *walk_state,
 			struct acpi_thread_state *thread);
 
-acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state *walk_state);
-
-acpi_status acpi_ds_result_stack_push(struct acpi_walk_state *walk_state);
-
 acpi_status acpi_ds_result_stack_clear(struct acpi_walk_state *walk_state);
 
 struct acpi_walk_state *acpi_ds_get_current_walk_state(struct acpi_thread_state
 						       *thread);
 
-#ifdef ACPI_FUTURE_USAGE
-acpi_status
-acpi_ds_result_remove(union acpi_operand_object **object,
-		      u32 index, struct acpi_walk_state *walk_state);
-#endif
-
 acpi_status
 acpi_ds_result_pop(union acpi_operand_object **object,
 		   struct acpi_walk_state *walk_state);
@@ -339,8 +329,4 @@ acpi_status
 acpi_ds_result_push(union acpi_operand_object *object,
 		    struct acpi_walk_state *walk_state);
 
-acpi_status
-acpi_ds_result_pop_from_bottom(union acpi_operand_object **object,
-			       struct acpi_walk_state *walk_state);
-
 #endif				/* _ACDISPAT_H_ */
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 202cd42..0b7c9a9 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -522,9 +522,8 @@ struct acpi_thread_state {
  * AML arguments
  */
 struct acpi_result_values {
-	ACPI_STATE_COMMON u8 num_results;
-	u8 last_insert;
-	union acpi_operand_object *obj_desc[ACPI_OBJ_NUM_OPERANDS];
+	ACPI_STATE_COMMON
+	    union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
 };
 
 typedef
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index 8848265..19b838d 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -80,12 +80,15 @@ struct acpi_walk_state {
 	u16 opcode;		/* Current AML opcode */
 	u8 next_op_info;	/* Info about next_op */
 	u8 num_operands;	/* Stack pointer for Operands[] array */
+	u8 operand_index;	/* Index into operand stack, to be used by acpi_ds_obj_stack_push */
 	acpi_owner_id owner_id;	/* Owner of objects created during the walk */
 	u8 last_predicate;	/* Result of last predicate */
 	u8 current_result;
 	u8 return_used;
 	u8 scope_depth;
 	u8 pass_number;		/* Parse pass during table load */
+	u8 result_size;		/* Total elements for the result stack */
+	u8 result_count;	/* Current number of occupied elements of result stack */
 	u32 aml_offset;
 	u32 arg_types;
 	u32 method_breakpoint;	/* For single stepping */
-- 
1.5.5.29.g7134

