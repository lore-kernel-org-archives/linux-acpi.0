From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/73] ACPICA: Update for mutiple global lock acquisitions by same thread
Date: Sat, 12 Apr 2008 00:24:46 -0400
Message-ID: <ad0aec6ee6e68a02f4a2bbdc1d8b033f73947992.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752110AbYDLE14 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:56 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Allows AcpiAcquireGlobalLock external interface to be called
multiple times by the
 same thread. Allows use of AML fields that require the global
 lock while the running AML is already holding the global lock.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |   12 +-
 drivers/acpi/events/evmisc.c       |   11 +-
 drivers/acpi/events/evxface.c      |   26 ++++-
 drivers/acpi/executer/exfield.c    |   24 ++---
 drivers/acpi/executer/exmutex.c    |  194 +++++++++++++++++++++++-------------
 drivers/acpi/executer/exutils.c    |   58 +++++------
 drivers/acpi/namespace/nsaccess.c  |    3 +-
 drivers/acpi/utilities/utdelete.c  |    2 +-
 include/acpi/acglobal.h            |   20 ++--
 include/acpi/acinterp.h            |   11 ++-
 include/acpi/acobject.h            |    3 +-
 11 files changed, 219 insertions(+), 145 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 1cbe619..c50c0cd 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -232,9 +232,9 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 		 * recursive call.
 		 */
 		if (!walk_state ||
-		    !obj_desc->method.mutex->mutex.owner_thread ||
-		    (walk_state->thread !=
-		     obj_desc->method.mutex->mutex.owner_thread)) {
+		    !obj_desc->method.mutex->mutex.thread_id ||
+		    (walk_state->thread->thread_id !=
+		     obj_desc->method.mutex->mutex.thread_id)) {
 			/*
 			 * Acquire the method mutex. This releases the interpreter if we
 			 * block (and reacquires it before it returns)
@@ -254,8 +254,8 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 				    original_sync_level =
 				    walk_state->thread->current_sync_level;
 
-				obj_desc->method.mutex->mutex.owner_thread =
-				    walk_state->thread;
+				obj_desc->method.mutex->mutex.thread_id =
+				    walk_state->thread->thread_id;
 				walk_state->thread->current_sync_level =
 				    obj_desc->method.sync_level;
 			} else {
@@ -569,7 +569,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 
 			acpi_os_release_mutex(method_desc->method.mutex->mutex.
 					      os_mutex);
-			method_desc->method.mutex->mutex.owner_thread = NULL;
+			method_desc->method.mutex->mutex.thread_id = 0;
 		}
 	}
 
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 21cb749..2d34663 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -439,7 +439,8 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	 * Only one thread can acquire the GL at a time, the global_lock_mutex
 	 * enforces this. This interface releases the interpreter if we must wait.
 	 */
-	status = acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex, 0);
+	status = acpi_ex_system_wait_mutex(
+			acpi_gbl_global_lock_mutex->mutex.os_mutex, 0);
 	if (status == AE_TIME) {
 		if (acpi_ev_global_lock_thread_id == acpi_os_get_thread_id()) {
 			acpi_ev_global_lock_acquired++;
@@ -448,9 +449,9 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	}
 
 	if (ACPI_FAILURE(status)) {
-		status =
-		    acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex,
-					      timeout);
+		status = acpi_ex_system_wait_mutex(
+				acpi_gbl_global_lock_mutex->mutex.os_mutex,
+				timeout);
 	}
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -555,7 +556,7 @@ acpi_status acpi_ev_release_global_lock(void)
 	/* Release the local GL mutex */
 	acpi_ev_global_lock_thread_id = NULL;
 	acpi_ev_global_lock_acquired = 0;
-	acpi_os_release_mutex(acpi_gbl_global_lock_mutex);
+	acpi_os_release_mutex(acpi_gbl_global_lock_mutex->mutex.os_mutex);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 6d866a0..dbf34a5 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -758,6 +758,12 @@ ACPI_EXPORT_SYMBOL(acpi_remove_gpe_handler)
  *
  * DESCRIPTION: Acquire the ACPI Global Lock
  *
+ * Note: Allows callers with the same thread ID to acquire the global lock
+ * multiple times. In other words, externally, the behavior of the global lock
+ * is identical to an AML mutex. On the first acquire, a new handle is
+ * returned. On any subsequent calls to acquire by the same thread, the same
+ * handle is returned.
+ *
  ******************************************************************************/
 acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle)
 {
@@ -770,14 +776,26 @@ acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle)
 	/* Must lock interpreter to prevent race conditions */
 
 	acpi_ex_enter_interpreter();
-	status = acpi_ev_acquire_global_lock(timeout);
-	acpi_ex_exit_interpreter();
+
+	status = acpi_ex_acquire_mutex_object(timeout,
+					      acpi_gbl_global_lock_mutex,
+					      acpi_os_get_thread_id());
 
 	if (ACPI_SUCCESS(status)) {
-		acpi_gbl_global_lock_handle++;
+		/*
+		 * If this was the first acquisition of the Global Lock by this thread,
+		 * create a new handle. Otherwise, return the existing handle.
+		 */
+		if (acpi_gbl_global_lock_mutex->mutex.acquisition_depth == 1) {
+			acpi_gbl_global_lock_handle++;
+		}
+
+		/* Return the global lock handle */
+
 		*handle = acpi_gbl_global_lock_handle;
 	}
 
+	acpi_ex_exit_interpreter();
 	return (status);
 }
 
@@ -802,7 +820,7 @@ acpi_status acpi_release_global_lock(u32 handle)
 		return (AE_NOT_ACQUIRED);
 	}
 
-	status = acpi_ev_release_global_lock();
+	status = acpi_ex_release_mutex_object(acpi_gbl_global_lock_mutex);
 	return (status);
 }
 
diff --git a/drivers/acpi/executer/exfield.c b/drivers/acpi/executer/exfield.c
index 2d88a3d..e66b367 100644
--- a/drivers/acpi/executer/exfield.c
+++ b/drivers/acpi/executer/exfield.c
@@ -71,7 +71,6 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	union acpi_operand_object *buffer_desc;
 	acpi_size length;
 	void *buffer;
-	u8 locked;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_read_data_from_field, obj_desc);
 
@@ -111,9 +110,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 
 		/* Lock entire transaction if requested */
 
-		locked =
-		    acpi_ex_acquire_global_lock(obj_desc->common_field.
-						field_flags);
+		acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
 
 		/*
 		 * Perform the read.
@@ -125,7 +122,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 							     buffer.pointer),
 					       ACPI_READ | (obj_desc->field.
 							    attribute << 16));
-		acpi_ex_release_global_lock(locked);
+		acpi_ex_release_global_lock();
 		goto exit;
 	}
 
@@ -175,13 +172,12 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 
 	/* Lock entire transaction if requested */
 
-	locked =
-	    acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
+	acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
 
 	/* Read from the field */
 
 	status = acpi_ex_extract_from_field(obj_desc, buffer, (u32) length);
-	acpi_ex_release_global_lock(locked);
+	acpi_ex_release_global_lock();
 
       exit:
 	if (ACPI_FAILURE(status)) {
@@ -217,7 +213,6 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 	u32 required_length;
 	void *buffer;
 	void *new_buffer;
-	u8 locked;
 	union acpi_operand_object *buffer_desc;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_write_data_to_field, obj_desc);
@@ -278,9 +273,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 		/* Lock entire transaction if requested */
 
-		locked =
-		    acpi_ex_acquire_global_lock(obj_desc->common_field.
-						field_flags);
+		acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
 
 		/*
 		 * Perform the write (returns status and perhaps data in the
@@ -291,7 +284,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 					       (acpi_integer *) buffer,
 					       ACPI_WRITE | (obj_desc->field.
 							     attribute << 16));
-		acpi_ex_release_global_lock(locked);
+		acpi_ex_release_global_lock();
 
 		*result_desc = buffer_desc;
 		return_ACPI_STATUS(status);
@@ -366,13 +359,12 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 	/* Lock entire transaction if requested */
 
-	locked =
-	    acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
+	acpi_ex_acquire_global_lock(obj_desc->common_field.field_flags);
 
 	/* Write to the field */
 
 	status = acpi_ex_insert_into_field(obj_desc, buffer, length);
-	acpi_ex_release_global_lock(locked);
+	acpi_ex_release_global_lock();
 
 	/* Free temporary buffer if we used one */
 
diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index 6748e3e..0bebe75 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -126,6 +126,66 @@ acpi_ex_link_mutex(union acpi_operand_object *obj_desc,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ex_acquire_mutex_object
+ *
+ * PARAMETERS:  time_desc           - Timeout in milliseconds
+ *              obj_desc            - Mutex object
+ *              Thread              - Current thread state
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Acquire an AML mutex, low-level interface
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ex_acquire_mutex_object(u16 timeout,
+			     union acpi_operand_object *obj_desc,
+			     acpi_thread_id thread_id)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ex_acquire_mutex_object, obj_desc);
+
+	/* Support for multiple acquires by the owning thread */
+
+	if (obj_desc->mutex.thread_id == thread_id) {
+		/*
+		 * The mutex is already owned by this thread, just increment the
+		 * acquisition depth
+		 */
+		obj_desc->mutex.acquisition_depth++;
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Acquire the mutex, wait if necessary. Special case for Global Lock */
+
+	if (obj_desc == acpi_gbl_global_lock_mutex) {
+		status = acpi_ev_acquire_global_lock(timeout);
+	} else {
+		status = acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
+						   timeout);
+	}
+
+	if (ACPI_FAILURE(status)) {
+
+		/* Includes failure from a timeout on time_desc */
+
+		return_ACPI_STATUS(status);
+	}
+
+	/* Have the mutex: update mutex and save the sync_level */
+
+	obj_desc->mutex.thread_id = thread_id;
+	obj_desc->mutex.acquisition_depth = 1;
+	obj_desc->mutex.original_sync_level = 0;
+	obj_desc->mutex.owner_thread = NULL;	/* Used only for AML Acquire() */
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ex_acquire_mutex
  *
  * PARAMETERS:  time_desc           - Timeout integer
@@ -161,7 +221,7 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 	}
 
 	/*
-	 * Current Sync must be less than or equal to the sync level of the
+	 * Current Sync level must be less than or equal to the sync level of the
 	 * mutex. This mechanism provides some deadlock prevention
 	 */
 	if (walk_state->thread->current_sync_level > obj_desc->mutex.sync_level) {
@@ -172,51 +232,70 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_ORDER);
 	}
 
-	/* Support for multiple acquires by the owning thread */
+	status = acpi_ex_acquire_mutex_object((u16) time_desc->integer.value,
+					      obj_desc,
+					      walk_state->thread->thread_id);
+	if (ACPI_SUCCESS(status) && obj_desc->mutex.acquisition_depth == 1) {
+		obj_desc->mutex.owner_thread = walk_state->thread;
+		obj_desc->mutex.original_sync_level =
+		    walk_state->thread->current_sync_level;
+		walk_state->thread->current_sync_level =
+		    obj_desc->mutex.sync_level;
 
-	if (obj_desc->mutex.owner_thread) {
-		if (obj_desc->mutex.owner_thread->thread_id ==
-		    walk_state->thread->thread_id) {
-			/*
-			 * The mutex is already owned by this thread, just increment the
-			 * acquisition depth
-			 */
-			obj_desc->mutex.acquisition_depth++;
-			return_ACPI_STATUS(AE_OK);
-		}
+		/* Link the mutex to the current thread for force-unlock at method exit */
+
+		acpi_ex_link_mutex(obj_desc, walk_state->thread);
 	}
 
-	/* Acquire the mutex, wait if necessary. Special case for Global Lock */
+	return_ACPI_STATUS(status);
+}
 
-	if (obj_desc->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
-		status =
-		    acpi_ev_acquire_global_lock((u16) time_desc->integer.value);
-	} else {
-		status = acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
-						   (u16) time_desc->integer.
-						   value);
-	}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_release_mutex_object
+ *
+ * PARAMETERS:  obj_desc            - The object descriptor for this op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Release a previously acquired Mutex, low level interface.
+ *
+ ******************************************************************************/
 
-	if (ACPI_FAILURE(status)) {
+acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
+{
+	acpi_status status = AE_OK;
 
-		/* Includes failure from a timeout on time_desc */
+	ACPI_FUNCTION_TRACE(ex_release_mutex_object);
 
-		return_ACPI_STATUS(status);
+	/* Match multiple Acquires with multiple Releases */
+
+	obj_desc->mutex.acquisition_depth--;
+	if (obj_desc->mutex.acquisition_depth != 0) {
+
+		/* Just decrement the depth and return */
+
+		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* Have the mutex: update mutex and walk info and save the sync_level */
+	if (obj_desc->mutex.owner_thread) {
 
-	obj_desc->mutex.owner_thread = walk_state->thread;
-	obj_desc->mutex.acquisition_depth = 1;
-	obj_desc->mutex.original_sync_level =
-	    walk_state->thread->current_sync_level;
+		/* Unlink the mutex from the owner's list */
+
+		acpi_ex_unlink_mutex(obj_desc);
+		obj_desc->mutex.owner_thread = NULL;
+	}
 
-	walk_state->thread->current_sync_level = obj_desc->mutex.sync_level;
+	/* Release the mutex, special case for Global Lock */
 
-	/* Link the mutex to the current thread for force-unlock at method exit */
+	if (obj_desc == acpi_gbl_global_lock_mutex) {
+		status = acpi_ev_release_global_lock();
+	} else {
+		acpi_os_release_mutex(obj_desc->mutex.os_mutex);
+	}
 
-	acpi_ex_link_mutex(obj_desc, walk_state->thread);
-	return_ACPI_STATUS(AE_OK);
+	obj_desc->mutex.thread_id = 0;
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
@@ -253,22 +332,13 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 
-	/* Sanity check: we must have a valid thread ID */
-
-	if (!walk_state->thread) {
-		ACPI_ERROR((AE_INFO,
-			    "Cannot release Mutex [%4.4s], null thread info",
-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
-		return_ACPI_STATUS(AE_AML_INTERNAL);
-	}
-
 	/*
 	 * The Mutex is owned, but this thread must be the owner.
 	 * Special case for Global Lock, any thread can release
 	 */
 	if ((obj_desc->mutex.owner_thread->thread_id !=
 	     walk_state->thread->thread_id)
-	    && (obj_desc->mutex.os_mutex != acpi_gbl_global_lock_mutex)) {
+	    && (obj_desc != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
 			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
 			    (unsigned long)walk_state->thread->thread_id,
@@ -278,6 +348,15 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
+	/* Sanity check: we must have a valid thread ID */
+
+	if (!walk_state->thread) {
+		ACPI_ERROR((AE_INFO,
+			    "Cannot release Mutex [%4.4s], null thread info",
+			    acpi_ut_get_node_name(obj_desc->mutex.node)));
+		return_ACPI_STATUS(AE_AML_INTERNAL);
+	}
+
 	/*
 	 * The sync level of the mutex must be less than or equal to the current
 	 * sync level
@@ -289,34 +368,12 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_ORDER);
 	}
 
-	/* Match multiple Acquires with multiple Releases */
-
-	obj_desc->mutex.acquisition_depth--;
-	if (obj_desc->mutex.acquisition_depth != 0) {
-
-		/* Just decrement the depth and return */
-
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Unlink the mutex from the owner's list */
+	status = acpi_ex_release_mutex_object(obj_desc);
 
-	acpi_ex_unlink_mutex(obj_desc);
-
-	/* Release the mutex, special case for Global Lock */
+	/* Restore sync_level */
 
-	if (obj_desc->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
-		status = acpi_ev_release_global_lock();
-	} else {
-		acpi_os_release_mutex(obj_desc->mutex.os_mutex);
-	}
-
-	/* Update the mutex and restore sync_level */
-
-	obj_desc->mutex.owner_thread = NULL;
 	walk_state->thread->current_sync_level =
 	    obj_desc->mutex.original_sync_level;
-
 	return_ACPI_STATUS(status);
 }
 
@@ -357,7 +414,7 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 
 		/* Release the mutex, special case for Global Lock */
 
-		if (obj_desc->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
+		if (obj_desc == acpi_gbl_global_lock_mutex) {
 
 			/* Ignore errors */
 
@@ -369,6 +426,7 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 		/* Mark mutex unowned */
 
 		obj_desc->mutex.owner_thread = NULL;
+		obj_desc->mutex.thread_id = 0;
 
 		/* Update Thread sync_level (Last mutex is the important one) */
 
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index 6b0aecc..c0837af 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -240,72 +240,66 @@ void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
  * PARAMETERS:  field_flags           - Flags with Lock rule:
  *                                      always_lock or never_lock
  *
- * RETURN:      TRUE/FALSE indicating whether the lock was actually acquired
+ * RETURN:      None
  *
- * DESCRIPTION: Obtain the global lock and keep track of this fact via two
- *              methods.  A global variable keeps the state of the lock, and
- *              the state is returned to the caller.
+ * DESCRIPTION: Obtain the ACPI hardware Global Lock, only if the field
+ *              flags specifiy that it is to be obtained before field access.
  *
  ******************************************************************************/
 
-u8 acpi_ex_acquire_global_lock(u32 field_flags)
+void acpi_ex_acquire_global_lock(u32 field_flags)
 {
-	u8 locked = FALSE;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_acquire_global_lock);
 
-	/* Only attempt lock if the always_lock bit is set */
+	/* Only use the lock if the always_lock bit is set */
+
+	if (!(field_flags & AML_FIELD_LOCK_RULE_MASK)) {
+		return_VOID;
+	}
 
-	if (field_flags & AML_FIELD_LOCK_RULE_MASK) {
+	/* Attempt to get the global lock, wait forever */
 
-		/* We should attempt to get the lock, wait forever */
+	status = acpi_ex_acquire_mutex_object(ACPI_WAIT_FOREVER,
+					      acpi_gbl_global_lock_mutex,
+					      acpi_os_get_thread_id());
 
-		status = acpi_ev_acquire_global_lock(ACPI_WAIT_FOREVER);
-		if (ACPI_SUCCESS(status)) {
-			locked = TRUE;
-		} else {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Could not acquire Global Lock"));
-		}
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Could not acquire Global Lock"));
 	}
 
-	return_UINT8(locked);
+	return_VOID;
 }
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_release_global_lock
  *
- * PARAMETERS:  locked_by_me    - Return value from corresponding call to
- *                                acquire_global_lock.
+ * PARAMETERS:  None
  *
  * RETURN:      None
  *
- * DESCRIPTION: Release the global lock if it is locked.
+ * DESCRIPTION: Release the ACPI hardware Global Lock
  *
  ******************************************************************************/
 
-void acpi_ex_release_global_lock(u8 locked_by_me)
+void acpi_ex_release_global_lock(void)
 {
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_release_global_lock);
 
-	/* Only attempt unlock if the caller locked it */
-
-	if (locked_by_me) {
+	/* Release the global lock */
 
-		/* OK, now release the lock */
-
-		status = acpi_ev_release_global_lock();
-		if (ACPI_FAILURE(status)) {
+	status = acpi_ex_release_mutex_object(acpi_gbl_global_lock_mutex);
+	if (ACPI_FAILURE(status)) {
 
-			/* Report the error, but there isn't much else we can do */
+		/* Report the error, but there isn't much else we can do */
 
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Could not release ACPI Global Lock"));
-		}
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Could not release Global Lock"));
 	}
 
 	return_VOID;
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index 57faf59..32a0167 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -208,8 +208,7 @@ acpi_status acpi_ns_root_initialize(void)
 				/* Special case for ACPI Global Lock */
 
 				if (ACPI_STRCMP(init_val->name, "_GL_") == 0) {
-					acpi_gbl_global_lock_mutex =
-					    obj_desc->mutex.os_mutex;
+					acpi_gbl_global_lock_mutex = obj_desc;
 
 					/* Create additional counting semaphore for global lock */
 
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index f777ceb..dcb34f8 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -158,7 +158,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 				  "***** Mutex %p, OS Mutex %p\n",
 				  object, object->mutex.os_mutex));
 
-		if (object->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
+		if (object == acpi_gbl_global_lock_mutex) {
 
 			/* Global Lock has extra semaphore */
 
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 47a1fd8..e91008e 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -170,10 +170,14 @@ ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
 ACPI_EXTERN struct acpi_mutex_info acpi_gbl_mutex_info[ACPI_NUM_MUTEX];
 
 /*
- * Global lock semaphore works in conjunction with the actual HW global lock
+ * Global lock mutex is an actual AML mutex object
+ * Global lock semaphore works in conjunction with the HW global lock
  */
-ACPI_EXTERN acpi_mutex acpi_gbl_global_lock_mutex;
+ACPI_EXTERN union acpi_operand_object *acpi_gbl_global_lock_mutex;
 ACPI_EXTERN acpi_semaphore acpi_gbl_global_lock_semaphore;
+ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
+ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
+ACPI_EXTERN u8 acpi_gbl_global_lock_present;
 
 /*
  * Spinlocks are used for interfaces that can be possibly called at
@@ -215,22 +219,22 @@ ACPI_EXTERN acpi_exception_handler acpi_gbl_exception_handler;
 ACPI_EXTERN acpi_init_handler acpi_gbl_init_handler;
 ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
 
+/* Owner ID support */
+
+ACPI_EXTERN u32 acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS];
+ACPI_EXTERN u8 acpi_gbl_last_owner_id_index;
+ACPI_EXTERN u8 acpi_gbl_next_owner_id_offset;
+
 /* Misc */
 
 ACPI_EXTERN u32 acpi_gbl_original_mode;
 ACPI_EXTERN u32 acpi_gbl_rsdp_original_location;
 ACPI_EXTERN u32 acpi_gbl_ns_lookup_count;
 ACPI_EXTERN u32 acpi_gbl_ps_find_count;
-ACPI_EXTERN u32 acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS];
 ACPI_EXTERN u16 acpi_gbl_pm1_enable_register_save;
-ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
-ACPI_EXTERN u8 acpi_gbl_last_owner_id_index;
-ACPI_EXTERN u8 acpi_gbl_next_owner_id_offset;
 ACPI_EXTERN u8 acpi_gbl_debugger_configuration;
-ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
 ACPI_EXTERN u8 acpi_gbl_step_to_next_call;
 ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
-ACPI_EXTERN u8 acpi_gbl_global_lock_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
 ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index ce7c9d6..2386388 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -248,9 +248,16 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 		      struct acpi_walk_state *walk_state);
 
 acpi_status
+acpi_ex_acquire_mutex_object(u16 timeout,
+			     union acpi_operand_object *obj_desc,
+			     acpi_thread_id thread_id);
+
+acpi_status
 acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		      struct acpi_walk_state *walk_state);
 
+acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc);
+
 void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread);
 
 void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc);
@@ -455,9 +462,9 @@ void acpi_ex_relinquish_interpreter(void);
 
 void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
 
-u8 acpi_ex_acquire_global_lock(u32 rule);
+void acpi_ex_acquire_global_lock(u32 rule);
 
-void acpi_ex_release_global_lock(u8 locked);
+void acpi_ex_release_global_lock(void);
 
 void acpi_ex_eisa_id_to_string(u32 numeric_id, char *out_string);
 
diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index 7e1211a..2461bb9 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -155,8 +155,9 @@ struct acpi_object_event {
 struct acpi_object_mutex {
 	ACPI_OBJECT_COMMON_HEADER u8 sync_level;	/* 0-15, specified in Mutex() call */
 	u16 acquisition_depth;	/* Allow multiple Acquires, same thread */
-	struct acpi_thread_state *owner_thread;	/* Current owner of the mutex */
 	acpi_mutex os_mutex;	/* Actual OS synchronization object */
+	acpi_thread_id thread_id;	/* Current owner of the mutex */
+	struct acpi_thread_state *owner_thread;	/* Current owner of the mutex */
 	union acpi_operand_object *prev;	/* Link for list of acquired mutexes */
 	union acpi_operand_object *next;	/* Link for list of acquired mutexes */
 	struct acpi_namespace_node *node;	/* Containing namespace node */
-- 
1.5.5.29.g7134

