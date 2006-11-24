From: Len Brown <len.brown@intel.com>
Subject: [PATCH 26/65] ACPICA: Re-implement interpreters' "serialized mode"
Date: Fri, 24 Nov 2006 02:18:36 -0500
Message-ID: <1164352787694-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934471AbWKXHPu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:50 -0500
In-Reply-To: <11643527871558-git-send-email-len.brown@intel.com>
Message-Id: <1ed5347751418ace666b50cc4c48ccb6949607c8.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Enhanced the implementation of the interpreters'
serialized mode (boot with "acpi_serialize" to set
acpi_glb_all_methods_serialized flag.)
When this mode is specified, instead of creating a serialization
semaphore per control method, the interpreter lock is
simply no longer released before a blocking operation
during control method execution. This effectively makes
the AML Interpreter single-threaded. The overhead of a
semaphore per-method is eliminated.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evregion.c    |   15 ++----
 drivers/acpi/events/evxface.c     |    6 +--
 drivers/acpi/executer/excreate.c  |    5 +--
 drivers/acpi/executer/exsystem.c  |   30 +++--------
 drivers/acpi/executer/exutils.c   |  108 +++++++++++++++++++++++++++++-------
 drivers/acpi/namespace/nseval.c   |   11 +---
 drivers/acpi/namespace/nsinit.c   |    7 +--
 drivers/acpi/namespace/nsxfeval.c |   11 ++---
 include/acpi/acinterp.h           |    6 ++-
 9 files changed, 114 insertions(+), 85 deletions(-)

diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 21caae0..ef45971 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -291,7 +291,6 @@ acpi_ev_address_space_dispatch(union acp
 			       u32 bit_width, acpi_integer * value)
 {
 	acpi_status status;
-	acpi_status status2;
 	acpi_adr_space_handler handler;
 	acpi_adr_space_setup region_setup;
 	union acpi_operand_object *handler_desc;
@@ -345,7 +344,7 @@ acpi_ev_address_space_dispatch(union acp
 		 * setup will potentially execute control methods
 		 * (e.g., _REG method for this region)
 		 */
-		acpi_ex_exit_interpreter();
+		acpi_ex_relinquish_interpreter();
 
 		status = region_setup(region_obj, ACPI_REGION_ACTIVATE,
 				      handler_desc->address_space.context,
@@ -353,10 +352,7 @@ acpi_ev_address_space_dispatch(union acp
 
 		/* Re-enter the interpreter */
 
-		status2 = acpi_ex_enter_interpreter();
-		if (ACPI_FAILURE(status2)) {
-			return_ACPI_STATUS(status2);
-		}
+		acpi_ex_reacquire_interpreter();
 
 		/* Check for failure of the Region Setup */
 
@@ -409,7 +405,7 @@ acpi_ev_address_space_dispatch(union acp
 		 * exit the interpreter because the handler *might* block -- we don't
 		 * know what it will do, so we can't hold the lock on the intepreter.
 		 */
-		acpi_ex_exit_interpreter();
+		acpi_ex_relinquish_interpreter();
 	}
 
 	/* Call the handler */
@@ -430,10 +426,7 @@ acpi_ev_address_space_dispatch(union acp
 		 * We just returned from a non-default handler, we must re-enter the
 		 * interpreter
 		 */
-		status2 = acpi_ex_enter_interpreter();
-		if (ACPI_FAILURE(status2)) {
-			return_ACPI_STATUS(status2);
-		}
+		acpi_ex_reacquire_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 923fd2b..a2af48e 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -768,11 +768,9 @@ acpi_status acpi_acquire_global_lock(u16
 		return (AE_BAD_PARAMETER);
 	}
 
-	status = acpi_ex_enter_interpreter();
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+	/* Must lock interpreter to prevent race conditions */
 
+	acpi_ex_enter_interpreter();
 	status = acpi_ev_acquire_global_lock(timeout);
 	acpi_ex_exit_interpreter();
 
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index a4d29b2..c665aa7 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -583,10 +583,7 @@ acpi_ex_create_method(u8 * aml_start,
 	 * Get the sync_level. If method is serialized, a mutex will be
 	 * created for this method when it is parsed.
 	 */
-	if (acpi_gbl_all_methods_serialized) {
-		obj_desc->method.sync_level = 0;
-		obj_desc->method.method_flags |= AML_METHOD_SERIALIZED;
-	} else if (method_flags & AML_METHOD_SERIALIZED) {
+	if (method_flags & AML_METHOD_SERIALIZED) {
 		/*
 		 * ACPI 1.0: sync_level = 0
 		 * ACPI 2.0: sync_level = sync_level in method declaration
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index 3b9736a..7e5aeb1 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -66,7 +66,6 @@ ACPI_MODULE_NAME("exsystem")
 acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 {
 	acpi_status status;
-	acpi_status status2;
 
 	ACPI_FUNCTION_TRACE(ex_system_wait_semaphore);
 
@@ -79,7 +78,7 @@ acpi_status acpi_ex_system_wait_semaphor
 
 		/* We must wait, so unlock the interpreter */
 
-		acpi_ex_exit_interpreter();
+		acpi_ex_relinquish_interpreter();
 
 		status = acpi_os_wait_semaphore(semaphore, 1, timeout);
 
@@ -89,13 +88,7 @@ acpi_status acpi_ex_system_wait_semaphor
 
 		/* Reacquire the interpreter */
 
-		status2 = acpi_ex_enter_interpreter();
-		if (ACPI_FAILURE(status2)) {
-
-			/* Report fatal error, could not acquire interpreter */
-
-			return_ACPI_STATUS(status2);
-		}
+		acpi_ex_reacquire_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
@@ -119,7 +112,6 @@ acpi_status acpi_ex_system_wait_semaphor
 acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 {
 	acpi_status status;
-	acpi_status status2;
 
 	ACPI_FUNCTION_TRACE(ex_system_wait_mutex);
 
@@ -132,7 +124,7 @@ acpi_status acpi_ex_system_wait_mutex(ac
 
 		/* We must wait, so unlock the interpreter */
 
-		acpi_ex_exit_interpreter();
+		acpi_ex_relinquish_interpreter();
 
 		status = acpi_os_acquire_mutex(mutex, timeout);
 
@@ -142,13 +134,7 @@ acpi_status acpi_ex_system_wait_mutex(ac
 
 		/* Reacquire the interpreter */
 
-		status2 = acpi_ex_enter_interpreter();
-		if (ACPI_FAILURE(status2)) {
-
-			/* Report fatal error, could not acquire interpreter */
-
-			return_ACPI_STATUS(status2);
-		}
+		acpi_ex_reacquire_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
@@ -209,20 +195,18 @@ acpi_status acpi_ex_system_do_stall(u32
 
 acpi_status acpi_ex_system_do_suspend(acpi_integer how_long)
 {
-	acpi_status status;
-
 	ACPI_FUNCTION_ENTRY();
 
 	/* Since this thread will sleep, we must release the interpreter */
 
-	acpi_ex_exit_interpreter();
+	acpi_ex_relinquish_interpreter();
 
 	acpi_os_sleep(how_long);
 
 	/* And now we must get the interpreter again */
 
-	status = acpi_ex_enter_interpreter();
-	return (status);
+	acpi_ex_reacquire_interpreter();
+	return (AE_OK);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index 982c8b6..72adcf4 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -76,46 +76,72 @@ static u32 acpi_ex_digits_needed(acpi_in
  *
  * PARAMETERS:  None
  *
- * RETURN:      Status
+ * RETURN:      None
  *
- * DESCRIPTION: Enter the interpreter execution region.  Failure to enter
- *              the interpreter region is a fatal system error
+ * DESCRIPTION: Enter the interpreter execution region. Failure to enter
+ *              the interpreter region is a fatal system error. Used in
+ *              conjunction with exit_interpreter.
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_enter_interpreter(void)
+void acpi_ex_enter_interpreter(void)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(ex_enter_interpreter);
+	ACPI_FUNCTION_TRACE(ex_reacquire_interpreter);
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Could not acquire interpreter mutex"));
+		ACPI_ERROR((AE_INFO,
+			    "Could not acquire AML Interpreter mutex"));
 	}
 
-	return_ACPI_STATUS(status);
+	return_VOID;
 }
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_exit_interpreter
+ * FUNCTION:    acpi_ex_reacquire_interpreter
  *
  * PARAMETERS:  None
  *
  * RETURN:      None
  *
- * DESCRIPTION: Exit the interpreter execution region
+ * DESCRIPTION: Reacquire the interpreter execution region from within the
+ *              interpreter code. Failure to enter the interpreter region is a
+ *              fatal system error. Used in  conjuction with
+ *              relinquish_interpreter
+ *
+ ******************************************************************************/
+
+void acpi_ex_reacquire_interpreter(void)
+{
+
+	ACPI_FUNCTION_TRACE(ex_reacquire_interpreter);
+
+	/*
+	 * If the global serialized flag is set, do not release the interpreter,
+	 * since it was not actually released by acpi_ex_relinquish_interpreter.
+	 * This forces the interpreter to be single threaded.
+	 */
+	if (!acpi_gbl_all_methods_serialized) {
+		acpi_ex_enter_interpreter();
+	}
+
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_exit_interpreter
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
  *
- * Cases where the interpreter is unlocked:
- *      1) Completion of the execution of a control method
- *      2) Method blocked on a Sleep() AML opcode
- *      3) Method blocked on an Acquire() AML opcode
- *      4) Method blocked on a Wait() AML opcode
- *      5) Method blocked to acquire the global lock
- *      6) Method blocked to execute a serialized control method that is
- *          already executing
- *      7) About to invoke a user-installed opregion handler
+ * DESCRIPTION: Exit the interpreter execution region. This is the top level
+ *              routine used to exit the interpreter when all processing has
+ *              been completed.
  *
  ******************************************************************************/
 
@@ -127,7 +153,47 @@ void acpi_ex_exit_interpreter(void)
 
 	status = acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Could not release interpreter mutex"));
+		ACPI_ERROR((AE_INFO,
+			    "Could not release AML Interpreter mutex"));
+	}
+
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_relinquish_interpreter
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Exit the interpreter execution region, from within the
+ *              interpreter - before attempting an operation that will possibly
+ *              block the running thread.
+ *
+ * Cases where the interpreter is unlocked internally
+ *      1) Method to be blocked on a Sleep() AML opcode
+ *      2) Method to be blocked on an Acquire() AML opcode
+ *      3) Method to be blocked on a Wait() AML opcode
+ *      4) Method to be blocked to acquire the global lock
+ *      5) Method to be blocked waiting to execute a serialized control method
+ *          that is currently executing
+ *      6) About to invoke a user-installed opregion handler
+ *
+ ******************************************************************************/
+
+void acpi_ex_relinquish_interpreter(void)
+{
+
+	ACPI_FUNCTION_TRACE(ex_relinquish_interpreter);
+
+	/*
+	 * If the global serialized flag is set, do not release the interpreter.
+	 * This forces the interpreter to be single threaded.
+	 */
+	if (!acpi_gbl_all_methods_serialized) {
+		acpi_ex_exit_interpreter();
 	}
 
 	return_VOID;
@@ -141,8 +207,8 @@ void acpi_ex_exit_interpreter(void)
  *
  * RETURN:      none
  *
- * DESCRIPTION: Truncate a number to 32-bits if the currently executing method
- *              belongs to a 32-bit ACPI table.
+ * DESCRIPTION: Truncate an ACPI Integer to 32 bits if the execution mode is
+ *              32-bit, as determined by the revision of the DSDT.
  *
  ******************************************************************************/
 
diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 4b0a4a8..7156616 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -154,11 +154,7 @@ acpi_status acpi_ns_evaluate(struct acpi
 		 * Execute the method via the interpreter. The interpreter is locked
 		 * here before calling into the AML parser
 		 */
-		status = acpi_ex_enter_interpreter();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-
+		acpi_ex_enter_interpreter();
 		status = acpi_ps_execute_method(info);
 		acpi_ex_exit_interpreter();
 	} else {
@@ -182,10 +178,7 @@ acpi_status acpi_ns_evaluate(struct acpi
 		 * resolution, we must lock it because we could access an opregion.
 		 * The opregion access code assumes that the interpreter is locked.
 		 */
-		status = acpi_ex_enter_interpreter();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
+		acpi_ex_enter_interpreter();
 
 		/* Function has a strange interface */
 
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
index aec8488..0d3a42b 100644
--- a/drivers/acpi/namespace/nsinit.c
+++ b/drivers/acpi/namespace/nsinit.c
@@ -213,7 +213,7 @@ acpi_ns_init_one_object(acpi_handle obj_
 			u32 level, void *context, void **return_value)
 {
 	acpi_object_type type;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	struct acpi_init_walk_info *info =
 	    (struct acpi_init_walk_info *)context;
 	struct acpi_namespace_node *node =
@@ -267,10 +267,7 @@ acpi_ns_init_one_object(acpi_handle obj_
 	/*
 	 * Must lock the interpreter before executing AML code
 	 */
-	status = acpi_ex_enter_interpreter();
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+	acpi_ex_enter_interpreter();
 
 	/*
 	 * Each of these types can contain executable AML code within the
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index dca6799..6a0a46e 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -170,7 +170,6 @@ acpi_evaluate_object(acpi_handle handle,
 		     struct acpi_buffer *return_buffer)
 {
 	acpi_status status;
-	acpi_status status2;
 	struct acpi_evaluate_info *info;
 	acpi_size buffer_space_needed;
 	u32 i;
@@ -329,14 +328,12 @@ acpi_evaluate_object(acpi_handle handle,
 		 * Delete the internal return object. NOTE: Interpreter must be
 		 * locked to avoid race condition.
 		 */
-		status2 = acpi_ex_enter_interpreter();
-		if (ACPI_SUCCESS(status2)) {
+		acpi_ex_enter_interpreter();
 
-			/* Remove one reference on the return object (should delete it) */
+		/* Remove one reference on the return object (should delete it) */
 
-			acpi_ut_remove_reference(info->return_object);
-			acpi_ex_exit_interpreter();
-		}
+		acpi_ut_remove_reference(info->return_object);
+		acpi_ex_exit_interpreter();
 	}
 
       cleanup:
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index f266b38..8aebe57 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -445,10 +445,14 @@ acpi_ex_copy_integer_to_buffer_field(uni
 /*
  * exutils - interpreter/scanner utilities
  */
-acpi_status acpi_ex_enter_interpreter(void);
+void acpi_ex_enter_interpreter(void);
 
 void acpi_ex_exit_interpreter(void);
 
+void acpi_ex_reacquire_interpreter(void);
+
+void acpi_ex_relinquish_interpreter(void);
+
 void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
 
 u8 acpi_ex_acquire_global_lock(u32 rule);
-- 
1.4.4.1
