From: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/9] ACPICA: revert "acpi_serialize" changes
Date: Tue, 20 Mar 2007 11:27:06 -0400
Message-ID: <11744044341614-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com> <11744044333328-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9682 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933900AbXCTP1f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:35 -0400
In-Reply-To: <11744044333328-git-send-email-len.brown@intel.com>
Message-Id: <a8f4af6dc6600980885c594f52eecd60edd62013.1174404136.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

This reverts 977a6226feae3e2c10a4d8227625ff0f04b49239
and reverts 1ba753acb372c2955a4843302e92e49ce82e2fea
and updates acpi_ev_queue_notify_request()
to restore the previous implementation of the
"acpi_serialize" workaround.

http://bugzilla.kernel.org/show_bug.cgi?id=8171

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c      |    8 ++-
 drivers/acpi/events/evregion.c    |   15 ++++--
 drivers/acpi/events/evxface.c     |    6 ++-
 drivers/acpi/executer/excreate.c  |    5 ++-
 drivers/acpi/executer/exsystem.c  |   30 ++++++++---
 drivers/acpi/executer/exutils.c   |  104 +++++++------------------------------
 drivers/acpi/namespace/nseval.c   |   11 +++-
 drivers/acpi/namespace/nsinit.c   |    7 ++-
 drivers/acpi/namespace/nsxfeval.c |   11 +++--
 include/acpi/acinterp.h           |    6 +--
 10 files changed, 90 insertions(+), 113 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 3a799b9..cae786c 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -196,11 +196,15 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 		notify_info->notify.value = (u16) notify_value;
 		notify_info->notify.handler_obj = handler_obj;
 
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		acpi_ev_notify_dispatch(notify_info);
 
-		acpi_ex_reacquire_interpreter();
+		status = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
 	}
 
 	if (!handler_obj) {
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index e99f0c4..96b0e84 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -291,6 +291,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			       u32 bit_width, acpi_integer * value)
 {
 	acpi_status status;
+	acpi_status status2;
 	acpi_adr_space_handler handler;
 	acpi_adr_space_setup region_setup;
 	union acpi_operand_object *handler_desc;
@@ -344,7 +345,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		 * setup will potentially execute control methods
 		 * (e.g., _REG method for this region)
 		 */
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		status = region_setup(region_obj, ACPI_REGION_ACTIVATE,
 				      handler_desc->address_space.context,
@@ -352,7 +353,10 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 
 		/* Re-enter the interpreter */
 
-		acpi_ex_reacquire_interpreter();
+		status2 = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status2)) {
+			return_ACPI_STATUS(status2);
+		}
 
 		/* Check for failure of the Region Setup */
 
@@ -405,7 +409,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		 * exit the interpreter because the handler *might* block -- we don't
 		 * know what it will do, so we can't hold the lock on the intepreter.
 		 */
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 	}
 
 	/* Call the handler */
@@ -426,7 +430,10 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		 * We just returned from a non-default handler, we must re-enter the
 		 * interpreter
 		 */
-		acpi_ex_reacquire_interpreter();
+		status2 = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status2)) {
+			return_ACPI_STATUS(status2);
+		}
 	}
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 685a103..a3379ba 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -768,9 +768,11 @@ acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle)
 		return (AE_BAD_PARAMETER);
 	}
 
-	/* Must lock interpreter to prevent race conditions */
+	status = acpi_ex_enter_interpreter();
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
-	acpi_ex_enter_interpreter();
 	status = acpi_ev_acquire_global_lock(timeout);
 	acpi_ex_exit_interpreter();
 
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index 7c38528..ae97812 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -583,7 +583,10 @@ acpi_ex_create_method(u8 * aml_start,
 	 * Get the sync_level. If method is serialized, a mutex will be
 	 * created for this method when it is parsed.
 	 */
-	if (method_flags & AML_METHOD_SERIALIZED) {
+	if (acpi_gbl_all_methods_serialized) {
+		obj_desc->method.sync_level = 0;
+		obj_desc->method.method_flags |= AML_METHOD_SERIALIZED;
+	} else if (method_flags & AML_METHOD_SERIALIZED) {
 		/*
 		 * ACPI 1.0: sync_level = 0
 		 * ACPI 2.0: sync_level = sync_level in method declaration
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index 9460baf..b2edf62 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -66,6 +66,7 @@ ACPI_MODULE_NAME("exsystem")
 acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 {
 	acpi_status status;
+	acpi_status status2;
 
 	ACPI_FUNCTION_TRACE(ex_system_wait_semaphore);
 
@@ -78,7 +79,7 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 
 		/* We must wait, so unlock the interpreter */
 
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		status = acpi_os_wait_semaphore(semaphore, 1, timeout);
 
@@ -88,7 +89,13 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 
 		/* Reacquire the interpreter */
 
-		acpi_ex_reacquire_interpreter();
+		status2 = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status2)) {
+
+			/* Report fatal error, could not acquire interpreter */
+
+			return_ACPI_STATUS(status2);
+		}
 	}
 
 	return_ACPI_STATUS(status);
@@ -112,6 +119,7 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 {
 	acpi_status status;
+	acpi_status status2;
 
 	ACPI_FUNCTION_TRACE(ex_system_wait_mutex);
 
@@ -124,7 +132,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 
 		/* We must wait, so unlock the interpreter */
 
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		status = acpi_os_acquire_mutex(mutex, timeout);
 
@@ -134,7 +142,13 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 
 		/* Reacquire the interpreter */
 
-		acpi_ex_reacquire_interpreter();
+		status2 = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status2)) {
+
+			/* Report fatal error, could not acquire interpreter */
+
+			return_ACPI_STATUS(status2);
+		}
 	}
 
 	return_ACPI_STATUS(status);
@@ -195,18 +209,20 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
 
 acpi_status acpi_ex_system_do_suspend(acpi_integer how_long)
 {
+	acpi_status status;
+
 	ACPI_FUNCTION_ENTRY();
 
 	/* Since this thread will sleep, we must release the interpreter */
 
-	acpi_ex_relinquish_interpreter();
+	acpi_ex_exit_interpreter();
 
 	acpi_os_sleep(how_long);
 
 	/* And now we must get the interpreter again */
 
-	acpi_ex_reacquire_interpreter();
-	return (AE_OK);
+	status = acpi_ex_enter_interpreter();
+	return (status);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index 6b0aecc..aea461f 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -76,15 +76,14 @@ static u32 acpi_ex_digits_needed(acpi_integer value, u32 base);
  *
  * PARAMETERS:  None
  *
- * RETURN:      None
+ * RETURN:      Status
  *
- * DESCRIPTION: Enter the interpreter execution region. Failure to enter
- *              the interpreter region is a fatal system error. Used in
- *              conjunction with exit_interpreter.
+ * DESCRIPTION: Enter the interpreter execution region.  Failure to enter
+ *              the interpreter region is a fatal system error
  *
  ******************************************************************************/
 
-void acpi_ex_enter_interpreter(void)
+acpi_status acpi_ex_enter_interpreter(void)
 {
 	acpi_status status;
 
@@ -92,42 +91,10 @@ void acpi_ex_enter_interpreter(void)
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO,
-			    "Could not acquire AML Interpreter mutex"));
+		ACPI_ERROR((AE_INFO, "Could not acquire interpreter mutex"));
 	}
 
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
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
@@ -138,9 +105,17 @@ void acpi_ex_reacquire_interpreter(void)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Exit the interpreter execution region. This is the top level
- *              routine used to exit the interpreter when all processing has
- *              been completed.
+ * DESCRIPTION: Exit the interpreter execution region
+ *
+ * Cases where the interpreter is unlocked:
+ *      1) Completion of the execution of a control method
+ *      2) Method blocked on a Sleep() AML opcode
+ *      3) Method blocked on an Acquire() AML opcode
+ *      4) Method blocked on a Wait() AML opcode
+ *      5) Method blocked to acquire the global lock
+ *      6) Method blocked to execute a serialized control method that is
+ *          already executing
+ *      7) About to invoke a user-installed opregion handler
  *
  ******************************************************************************/
 
@@ -152,46 +127,7 @@ void acpi_ex_exit_interpreter(void)
 
 	status = acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	if (ACPI_FAILURE(status)) {
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
+		ACPI_ERROR((AE_INFO, "Could not release interpreter mutex"));
 	}
 
 	return_VOID;
@@ -205,8 +141,8 @@ void acpi_ex_relinquish_interpreter(void)
  *
  * RETURN:      none
  *
- * DESCRIPTION: Truncate an ACPI Integer to 32 bits if the execution mode is
- *              32-bit, as determined by the revision of the DSDT.
+ * DESCRIPTION: Truncate a number to 32-bits if the currently executing method
+ *              belongs to a 32-bit ACPI table.
  *
  ******************************************************************************/
 
diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index aa6370c..26fd0dd 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -154,7 +154,11 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 		 * Execute the method via the interpreter. The interpreter is locked
 		 * here before calling into the AML parser
 		 */
-		acpi_ex_enter_interpreter();
+		status = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
 		status = acpi_ps_execute_method(info);
 		acpi_ex_exit_interpreter();
 	} else {
@@ -178,7 +182,10 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 		 * resolution, we must lock it because we could access an opregion.
 		 * The opregion access code assumes that the interpreter is locked.
 		 */
-		acpi_ex_enter_interpreter();
+		status = acpi_ex_enter_interpreter();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 
 		/* Function has a strange interface */
 
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
index 33db224..c4ab615 100644
--- a/drivers/acpi/namespace/nsinit.c
+++ b/drivers/acpi/namespace/nsinit.c
@@ -214,7 +214,7 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value)
 {
 	acpi_object_type type;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	struct acpi_init_walk_info *info =
 	    (struct acpi_init_walk_info *)context;
 	struct acpi_namespace_node *node =
@@ -268,7 +268,10 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 	/*
 	 * Must lock the interpreter before executing AML code
 	 */
-	acpi_ex_enter_interpreter();
+	status = acpi_ex_enter_interpreter();
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
 	/*
 	 * Each of these types can contain executable AML code within the
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index 7ac6ace..8904d0f 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -170,6 +170,7 @@ acpi_evaluate_object(acpi_handle handle,
 		     struct acpi_buffer *return_buffer)
 {
 	acpi_status status;
+	acpi_status status2;
 	struct acpi_evaluate_info *info;
 	acpi_size buffer_space_needed;
 	u32 i;
@@ -328,12 +329,14 @@ acpi_evaluate_object(acpi_handle handle,
 		 * Delete the internal return object. NOTE: Interpreter must be
 		 * locked to avoid race condition.
 		 */
-		acpi_ex_enter_interpreter();
+		status2 = acpi_ex_enter_interpreter();
+		if (ACPI_SUCCESS(status2)) {
 
-		/* Remove one reference on the return object (should delete it) */
+			/* Remove one reference on the return object (should delete it) */
 
-		acpi_ut_remove_reference(info->return_object);
-		acpi_ex_exit_interpreter();
+			acpi_ut_remove_reference(info->return_object);
+			acpi_ex_exit_interpreter();
+		}
 	}
 
       cleanup:
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index 73967c8..4409830 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -446,14 +446,10 @@ acpi_ex_copy_integer_to_buffer_field(union acpi_operand_object *source_desc,
 /*
  * exutils - interpreter/scanner utilities
  */
-void acpi_ex_enter_interpreter(void);
+acpi_status acpi_ex_enter_interpreter(void);
 
 void acpi_ex_exit_interpreter(void);
 
-void acpi_ex_reacquire_interpreter(void);
-
-void acpi_ex_relinquish_interpreter(void);
-
 void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
 
 u8 acpi_ex_acquire_global_lock(u32 rule);
-- 
1.5.0.3.382.g34572
