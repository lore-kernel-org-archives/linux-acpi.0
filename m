From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 4/5] acpi: remove interpreter lock
Date: Thu,  7 Aug 2008 07:59:42 -0700
Message-ID: <1218121178-13779-5-git-send-email-dwalker@mvista.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:55558 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYHGO7r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 10:59:47 -0400
In-Reply-To: <1218121178-13779-4-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

Lockdep has identified this lock as a source of potential deadlock in
acpi. After reviewing the lock it's not clear what it's protecting. I
invite anyone who might know what the point of the lock is to describe it.

In the mean time I removed the lock completely which, so far, hasn't had
any ill effects on my test machines.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    5 --
 drivers/acpi/events/evregion.c     |   30 ---------
 drivers/acpi/events/evxface.c      |    5 --
 drivers/acpi/executer/exsystem.c   |   21 ------
 drivers/acpi/executer/exutils.c    |  127 ------------------------------------
 drivers/acpi/namespace/nseval.c    |    6 --
 drivers/acpi/namespace/nsinit.c    |    6 --
 drivers/acpi/namespace/nsxfeval.c  |    5 +-
 8 files changed, 1 insertions(+), 204 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index a3cf3d4..0b8af17 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -86,10 +86,6 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 
 	if (acpi_gbl_exception_handler) {
 
-		/* Exit the interpreter, allow handler to execute methods */
-
-		acpi_ex_exit_interpreter();
-
 		/*
 		 * Handler can map the exception code to anything it wants, including
 		 * AE_OK, in which case the executing method will not be aborted.
@@ -101,7 +97,6 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 						    walk_state->opcode,
 						    walk_state->aml_offset,
 						    NULL);
-		acpi_ex_enter_interpreter();
 	}
 #ifdef ACPI_DISASSEMBLER
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 236fbd1..4eb4c30 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -338,21 +338,10 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
-		/*
-		 * We must exit the interpreter because the region
-		 * setup will potentially execute control methods
-		 * (e.g., _REG method for this region)
-		 */
-		acpi_ex_exit_interpreter();
-
 		status = region_setup(region_obj, ACPI_REGION_ACTIVATE,
 				      handler_desc->address_space.context,
 				      &region_context);
 
-		/* Re-enter the interpreter */
-
-		acpi_ex_enter_interpreter();
-
 		/* Check for failure of the Region Setup */
 
 		if (ACPI_FAILURE(status)) {
@@ -397,16 +386,6 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			  acpi_ut_get_region_name(region_obj->region.
 						  space_id)));
 
-	if (!(handler_desc->address_space.handler_flags &
-	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
-		/*
-		 * For handlers other than the default (supplied) handlers, we must
-		 * exit the interpreter because the handler *might* block -- we don't
-		 * know what it will do, so we can't hold the lock on the intepreter.
-		 */
-		acpi_ex_exit_interpreter();
-	}
-
 	/* Call the handler */
 
 	status = handler(function, address, bit_width, value,
@@ -419,15 +398,6 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 							space_id)));
 	}
 
-	if (!(handler_desc->address_space.handler_flags &
-	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
-		/*
-		 * We just returned from a non-default handler, we must re-enter the
-		 * interpreter
-		 */
-		acpi_ex_enter_interpreter();
-	}
-
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 94a6efe..4e4bd7a 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -773,10 +773,6 @@ acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle)
 		return (AE_BAD_PARAMETER);
 	}
 
-	/* Must lock interpreter to prevent race conditions */
-
-	acpi_ex_enter_interpreter();
-
 	status = acpi_ex_acquire_mutex_object(timeout,
 					      acpi_gbl_global_lock_mutex,
 					      acpi_os_get_thread_id());
@@ -788,7 +784,6 @@ acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle)
 		*handle = acpi_gbl_global_lock_handle;
 	}
 
-	acpi_ex_exit_interpreter();
 	return (status);
 }
 
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index 1a4aa5e..6c82143 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -75,19 +75,12 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 
 	if (status == AE_TIME) {
 
-		/* We must wait, so unlock the interpreter */
-
-		acpi_ex_relinquish_interpreter();
-
 		status = acpi_os_wait_semaphore(semaphore, 1, timeout);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "*** Thread awake after blocking, %s\n",
 				  acpi_format_exception(status)));
 
-		/* Reacquire the interpreter */
-
-		acpi_ex_reacquire_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
@@ -122,19 +115,12 @@ acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 
 	if (status == AE_TIME) {
 
-		/* We must wait, so unlock the interpreter */
-
-		acpi_ex_relinquish_interpreter();
-
 		status = acpi_os_acquire_mutex(mutex, timeout);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "*** Thread awake after blocking, %s\n",
 				  acpi_format_exception(status)));
 
-		/* Reacquire the interpreter */
-
-		acpi_ex_reacquire_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
@@ -197,15 +183,8 @@ acpi_status acpi_ex_system_do_suspend(acpi_integer how_long)
 {
 	ACPI_FUNCTION_ENTRY();
 
-	/* Since this thread will sleep, we must release the interpreter */
-
-	acpi_ex_relinquish_interpreter();
-
 	acpi_os_sleep(how_long);
 
-	/* And now we must get the interpreter again */
-
-	acpi_ex_reacquire_interpreter();
 	return (AE_OK);
 }
 
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index 86c0388..815defd 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -71,133 +71,6 @@ static u32 acpi_ex_digits_needed(acpi_integer value, u32 base);
 #ifndef ACPI_NO_METHOD_EXECUTION
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_enter_interpreter
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Enter the interpreter execution region. Failure to enter
- *              the interpreter region is a fatal system error. Used in
- *              conjunction with exit_interpreter.
- *
- ******************************************************************************/
-
-void acpi_ex_enter_interpreter(void)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ex_enter_interpreter);
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO,
-			    "Could not acquire AML Interpreter mutex"));
-	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ex_reacquire_interpreter
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Reacquire the interpreter execution region from within the
- *              interpreter code. Failure to enter the interpreter region is a
- *              fatal system error. Used in  conjuction with
- *              relinquish_interpreter
- *
- ******************************************************************************/
-
-void acpi_ex_reacquire_interpreter(void)
-{
-	ACPI_FUNCTION_TRACE(ex_reacquire_interpreter);
-
-	/*
-	 * If the global serialized flag is set, do not release the interpreter,
-	 * since it was not actually released by acpi_ex_relinquish_interpreter.
-	 * This forces the interpreter to be single threaded.
-	 */
-	if (!acpi_gbl_all_methods_serialized) {
-		acpi_ex_enter_interpreter();
-	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ex_exit_interpreter
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Exit the interpreter execution region. This is the top level
- *              routine used to exit the interpreter when all processing has
- *              been completed.
- *
- ******************************************************************************/
-
-void acpi_ex_exit_interpreter(void)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ex_exit_interpreter);
-
-	status = acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO,
-			    "Could not release AML Interpreter mutex"));
-	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ex_relinquish_interpreter
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Exit the interpreter execution region, from within the
- *              interpreter - before attempting an operation that will possibly
- *              block the running thread.
- *
- * Cases where the interpreter is unlocked internally
- *      1) Method to be blocked on a Sleep() AML opcode
- *      2) Method to be blocked on an Acquire() AML opcode
- *      3) Method to be blocked on a Wait() AML opcode
- *      4) Method to be blocked to acquire the global lock
- *      5) Method to be blocked waiting to execute a serialized control method
- *          that is currently executing
- *      6) About to invoke a user-installed opregion handler
- *
- ******************************************************************************/
-
-void acpi_ex_relinquish_interpreter(void)
-{
-	ACPI_FUNCTION_TRACE(ex_relinquish_interpreter);
-
-	/*
-	 * If the global serialized flag is set, do not release the interpreter.
-	 * This forces the interpreter to be single threaded.
-	 */
-	if (!acpi_gbl_all_methods_serialized) {
-		acpi_ex_exit_interpreter();
-	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_truncate_for32bit_table
  *
  * PARAMETERS:  obj_desc        - Object to be truncated
diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index d369164..2a98cc7 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -72,8 +72,6 @@ ACPI_MODULE_NAME("nseval")
  * DESCRIPTION: Execute a control method or return the current value of an
  *              ACPI namespace object.
  *
- * MUTEX:       Locks interpreter
- *
  ******************************************************************************/
 acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 {
@@ -189,9 +187,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		 * Execute the method via the interpreter. The interpreter is locked
 		 * here before calling into the AML parser
 		 */
-		acpi_ex_enter_interpreter();
 		status = acpi_ps_execute_method(info);
-		acpi_ex_exit_interpreter();
 	} else {
 		/*
 		 * 2) Object is not a method, return its current value
@@ -213,13 +209,11 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		 * resolution, we must lock it because we could access an opregion.
 		 * The opregion access code assumes that the interpreter is locked.
 		 */
-		acpi_ex_enter_interpreter();
 
 		/* Function has a strange interface */
 
 		status =
 		    acpi_ex_resolve_node_to_value(&info->resolved_node, NULL);
-		acpi_ex_exit_interpreter();
 
 		/*
 		 * If acpi_ex_resolve_node_to_value() succeeded, the return value was placed
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
index e4c5751..e6c93d4 100644
--- a/drivers/acpi/namespace/nsinit.c
+++ b/drivers/acpi/namespace/nsinit.c
@@ -270,11 +270,6 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 	}
 
 	/*
-	 * Must lock the interpreter before executing AML code
-	 */
-	acpi_ex_enter_interpreter();
-
-	/*
 	 * Each of these types can contain executable AML code within the
 	 * declaration.
 	 */
@@ -333,7 +328,6 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 	 * We ignore errors from above, and always return OK, since we don't want
 	 * to abort the walk on any single error.
 	 */
-	acpi_ex_exit_interpreter();
 	return (AE_OK);
 }
 
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index 38be586..64c63f0 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -322,15 +322,12 @@ acpi_evaluate_object(acpi_handle handle,
 
 	if (info->return_object) {
 		/*
-		 * Delete the internal return object. NOTE: Interpreter must be
-		 * locked to avoid race condition.
+		 * Delete the internal return object.
 		 */
-		acpi_ex_enter_interpreter();
 
 		/* Remove one reference on the return object (should delete it) */
 
 		acpi_ut_remove_reference(info->return_object);
-		acpi_ex_exit_interpreter();
 	}
 
       cleanup:
-- 
1.5.5.1.32.gba7d2


