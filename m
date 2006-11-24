From: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/65] ACPICA: Delete recursive feature of ACPI Global Lock
Date: Fri, 24 Nov 2006 02:18:14 -0500
Message-ID: <11643527591227-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757601AbWKXHPV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:21 -0500
In-Reply-To: <11643527582206-git-send-email-len.brown@intel.com>
Message-Id: <e555508044e355677130b49c67aa6acf9559e014.1164352285.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Completed a new design and implementation for
the ACPI Global Lock support. On the OS side, the global
lock is now treated as a standard AML mutex. Previously,
multiple OS threads could acquire the global lock
simultaneously, but this could cause the BIOS to be starved
by the lock in cases such as the Embedded Controller driver,
where there is a tight coupling between the OS and the BIOS.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c      |  113 +++++++++++++++++++------------------
 drivers/acpi/executer/exmutex.c   |   84 ++++++++++++++++------------
 drivers/acpi/executer/exsystem.c  |   78 +-------------------------
 drivers/acpi/namespace/nsaccess.c |   36 +++++-------
 drivers/acpi/utilities/utdelete.c |   14 +++--
 drivers/acpi/utilities/utglobal.c |    2 +-
 include/acpi/acglobal.h           |    2 +-
 include/acpi/acinterp.h           |    6 --
 include/acpi/aclocal.h            |    1 -
 9 files changed, 135 insertions(+), 201 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index ee2a10b..60c7fbd 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -298,19 +298,13 @@ static void ACPI_SYSTEM_XFACE acpi_ev_gl
 {
 	acpi_status status;
 
-	/* Signal threads that are waiting for the lock */
+	/* Signal the thread that is waiting for the lock */
 
-	if (acpi_gbl_global_lock_thread_count) {
+	/* Send a unit to the semaphore */
 
-		/* Send sufficient units to the semaphore */
-
-		status =
-		    acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore,
-					     acpi_gbl_global_lock_thread_count);
-		if (ACPI_FAILURE(status)) {
-			ACPI_ERROR((AE_INFO,
-				    "Could not signal Global Lock semaphore"));
-		}
+	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not signal Global Lock semaphore"));
 	}
 }
 
@@ -334,7 +328,8 @@ static u32 acpi_ev_global_lock_handler(v
 	acpi_status status;
 
 	/*
-	 * Attempt to get the lock
+	 * Attempt to get the lock.
+	 *
 	 * If we don't get it now, it will be marked pending and we will
 	 * take another interrupt when it becomes free.
 	 */
@@ -342,6 +337,7 @@ static u32 acpi_ev_global_lock_handler(v
 	if (acquired) {
 
 		/* Got the lock, now wake all threads waiting for it */
+
 		acpi_gbl_global_lock_acquired = TRUE;
 		acpi_ev_global_lock_thread(context);
 	}
@@ -400,6 +396,16 @@ acpi_status acpi_ev_init_global_lock_han
  *
  * DESCRIPTION: Attempt to gain ownership of the Global Lock.
  *
+ * MUTEX:       Interpreter must be locked
+ *
+ * Note: The original implementation allowed multiple threads to "acquire" the
+ * Global Lock, and the OS would hold the lock until the last thread had
+ * released it. However, this could potentially starve the BIOS out of the
+ * lock, especially in the case where there is a tight handshake between the
+ * Embedded Controller driver and the BIOS. Therefore, this implementation
+ * allows only one thread to acquire the HW Global Lock at a time, and makes
+ * the global lock appear as a standard mutex on the OS side.
+ *
  *****************************************************************************/
 
 acpi_status acpi_ev_acquire_global_lock(u16 timeout)
@@ -409,27 +415,25 @@ acpi_status acpi_ev_acquire_global_lock(
 
 	ACPI_FUNCTION_TRACE(ev_acquire_global_lock);
 
-#ifndef ACPI_APPLICATION
-	/* Make sure that we actually have a global lock */
-
-	if (!acpi_gbl_global_lock_present) {
-		return_ACPI_STATUS(AE_NO_GLOBAL_LOCK);
+	/*
+	 * Only one thread can acquire the GL at a time, the global_lock_mutex
+	 * enforces this. This interface releases the interpreter if we must wait.
+	 */
+	status = acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex, timeout);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
 	}
-#endif
-
-	/* One more thread wants the global lock */
-
-	acpi_gbl_global_lock_thread_count++;
 
 	/*
-	 * If we (OS side vs. BIOS side) have the hardware lock already,
-	 * we are done
+	 * Make sure that a global lock actually exists. If not, just treat
+	 * the lock as a standard mutex.
 	 */
-	if (acpi_gbl_global_lock_acquired) {
+	if (!acpi_gbl_global_lock_present) {
+		acpi_gbl_global_lock_acquired = TRUE;
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* We must acquire the actual hardware lock */
+	/* Attempt to acquire the actual hardware lock */
 
 	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_common_fACS.global_lock, acquired);
 	if (acquired) {
@@ -437,25 +441,24 @@ acpi_status acpi_ev_acquire_global_lock(
 		/* We got the lock */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Acquired the HW Global Lock\n"));
+				  "Acquired hardware Global Lock\n"));
 
 		acpi_gbl_global_lock_acquired = TRUE;
 		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
-	 * Did not get the lock.  The pending bit was set above, and we must now
+	 * Did not get the lock. The pending bit was set above, and we must now
 	 * wait until we get the global lock released interrupt.
 	 */
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Waiting for the HW Global Lock\n"));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Waiting for hardware Global Lock\n"));
 
 	/*
-	 * Acquire the global lock semaphore first.
-	 * Since this wait will block, we must release the interpreter
+	 * Wait for handshake with the global lock interrupt handler.
+	 * This interface releases the interpreter if we must wait.
 	 */
-	status =
-	    acpi_ex_system_wait_semaphore(acpi_gbl_global_lock_semaphore,
-					  timeout);
+	status = acpi_ex_system_wait_semaphore(acpi_gbl_global_lock_semaphore,
+					       ACPI_WAIT_FOREVER);
 	return_ACPI_STATUS(status);
 }
 
@@ -478,38 +481,40 @@ acpi_status acpi_ev_release_global_lock(
 
 	ACPI_FUNCTION_TRACE(ev_release_global_lock);
 
-	if (!acpi_gbl_global_lock_thread_count) {
+	/* Lock must be acquired */
+
+	if (!acpi_gbl_global_lock_acquired) {
 		ACPI_WARNING((AE_INFO,
-			      "Cannot release HW Global Lock, it has not been acquired"));
+			      "Cannot release the ACPI Global Lock, it has not been acquired"));
 		return_ACPI_STATUS(AE_NOT_ACQUIRED);
 	}
 
-	/* One fewer thread has the global lock */
+	if (acpi_gbl_global_lock_present) {
 
-	acpi_gbl_global_lock_thread_count--;
-	if (acpi_gbl_global_lock_thread_count) {
+		/* Allow any thread to release the lock */
 
-		/* There are still some threads holding the lock, cannot release */
+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_common_fACS.global_lock,
+					 pending);
 
-		return_ACPI_STATUS(AE_OK);
+		/*
+		 * If the pending bit was set, we must write GBL_RLS to the control
+		 * register
+		 */
+		if (pending) {
+			status =
+			    acpi_set_register(ACPI_BITREG_GLOBAL_LOCK_RELEASE,
+					      1, ACPI_MTX_LOCK);
+		}
+
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Released hardware Global Lock\n"));
 	}
 
-	/*
-	 * No more threads holding lock, we can do the actual hardware
-	 * release
-	 */
-	ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_common_fACS.global_lock, pending);
 	acpi_gbl_global_lock_acquired = FALSE;
 
-	/*
-	 * If the pending bit was set, we must write GBL_RLS to the control
-	 * register
-	 */
-	if (pending) {
-		status = acpi_set_register(ACPI_BITREG_GLOBAL_LOCK_RELEASE,
-					   1, ACPI_MTX_LOCK);
-	}
+	/* Release the local GL mutex */
 
+	acpi_os_release_mutex(acpi_gbl_global_lock_mutex);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index 3a39c2e..e30cc53 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -44,6 +44,7 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acinterp.h>
+#include <acpi/acevents.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exmutex")
@@ -150,7 +151,7 @@ acpi_ex_acquire_mutex(union acpi_operand
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Sanity check -- we must have a valid thread ID */
+	/* Sanity check: we must have a valid thread ID */
 
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
@@ -174,24 +175,28 @@ acpi_ex_acquire_mutex(union acpi_operand
 	/* Support for multiple acquires by the owning thread */
 
 	if (obj_desc->mutex.owner_thread) {
-
-		/* Special case for Global Lock, allow all threads */
-
-		if ((obj_desc->mutex.owner_thread->thread_id ==
-		     walk_state->thread->thread_id) ||
-		    (obj_desc->mutex.os_mutex == ACPI_GLOBAL_LOCK)) {
+		if (obj_desc->mutex.owner_thread->thread_id ==
+		    walk_state->thread->thread_id) {
 			/*
-			 * The mutex is already owned by this thread,
-			 * just increment the acquisition depth
+			 * The mutex is already owned by this thread, just increment the
+			 * acquisition depth
 			 */
 			obj_desc->mutex.acquisition_depth++;
 			return_ACPI_STATUS(AE_OK);
 		}
 	}
 
-	/* Acquire the mutex, wait if necessary */
+	/* Acquire the mutex, wait if necessary. Special case for Global Lock */
+
+	if (obj_desc->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
+		status =
+		    acpi_ev_acquire_global_lock((u16) time_desc->integer.value);
+	} else {
+		status = acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
+						   (u16) time_desc->integer.
+						   value);
+	}
 
-	status = acpi_ex_system_acquire_mutex(time_desc, obj_desc);
 	if (ACPI_FAILURE(status)) {
 
 		/* Includes failure from a timeout on time_desc */
@@ -211,7 +216,6 @@ acpi_ex_acquire_mutex(union acpi_operand
 	/* Link the mutex to the current thread for force-unlock at method exit */
 
 	acpi_ex_link_mutex(obj_desc, walk_state->thread);
-
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -232,7 +236,7 @@ acpi_status
 acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		      struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE(ex_release_mutex);
 
@@ -249,7 +253,7 @@ acpi_ex_release_mutex(union acpi_operand
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 
-	/* Sanity check -- we must have a valid thread ID */
+	/* Sanity check: we must have a valid thread ID */
 
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
@@ -264,18 +268,18 @@ acpi_ex_release_mutex(union acpi_operand
 	 */
 	if ((obj_desc->mutex.owner_thread->thread_id !=
 	     walk_state->thread->thread_id)
-	    && (obj_desc->mutex.os_mutex != ACPI_GLOBAL_LOCK)) {
+	    && (obj_desc->mutex.os_mutex != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    (u32) walk_state->thread->thread_id,
+			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
+			    (unsigned long) walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (u32) obj_desc->mutex.owner_thread->thread_id));
+			    (unsigned long) obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
 	/*
-	 * The sync level of the mutex must be less than or
-	 * equal to the current sync level
+	 * The sync level of the mutex must be less than or equal to the current
+	 * sync level
 	 */
 	if (obj_desc->mutex.sync_level > walk_state->thread->current_sync_level) {
 		ACPI_ERROR((AE_INFO,
@@ -298,11 +302,15 @@ acpi_ex_release_mutex(union acpi_operand
 
 	acpi_ex_unlink_mutex(obj_desc);
 
-	/* Release the mutex */
+	/* Release the mutex, special case for Global Lock */
 
-	status = acpi_ex_system_release_mutex(obj_desc);
+	if (obj_desc->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
+		status = acpi_ev_release_global_lock();
+	} else {
+		acpi_os_release_mutex(obj_desc->mutex.os_mutex);
+	}
 
-	/* Update the mutex and walk state, restore sync_level before acquire */
+	/* Update the mutex and restore sync_level */
 
 	obj_desc->mutex.owner_thread = NULL;
 	walk_state->thread->current_sync_level =
@@ -326,34 +334,38 @@ acpi_ex_release_mutex(union acpi_operand
 void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 {
 	union acpi_operand_object *next = thread->acquired_mutex_list;
-	union acpi_operand_object *this;
-	acpi_status status;
+	union acpi_operand_object *obj_desc;
 
 	ACPI_FUNCTION_ENTRY();
 
 	/* Traverse the list of owned mutexes, releasing each one */
 
 	while (next) {
-		this = next;
-		next = this->mutex.next;
+		obj_desc = next;
+		next = obj_desc->mutex.next;
+
+		obj_desc->mutex.prev = NULL;
+		obj_desc->mutex.next = NULL;
+		obj_desc->mutex.acquisition_depth = 1;
+
+		/* Release the mutex, special case for Global Lock */
 
-		this->mutex.acquisition_depth = 1;
-		this->mutex.prev = NULL;
-		this->mutex.next = NULL;
+		if (obj_desc->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
 
-		/* Release the mutex */
+			/* Ignore errors */
 
-		status = acpi_ex_system_release_mutex(this);
-		if (ACPI_FAILURE(status)) {
-			continue;
+			(void)acpi_ev_release_global_lock();
+		} else {
+			acpi_os_release_mutex(obj_desc->mutex.os_mutex);
 		}
 
 		/* Mark mutex unowned */
 
-		this->mutex.owner_thread = NULL;
+		obj_desc->mutex.owner_thread = NULL;
 
 		/* Update Thread sync_level (Last mutex is the important one) */
 
-		thread->current_sync_level = this->mutex.original_sync_level;
+		thread->current_sync_level =
+		    obj_desc->mutex.original_sync_level;
 	}
 }
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index 28aef3e..3b9736a 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -227,82 +227,6 @@ acpi_status acpi_ex_system_do_suspend(ac
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_system_acquire_mutex
- *
- * PARAMETERS:  time_desc       - Maximum time to wait for the mutex
- *              obj_desc        - The object descriptor for this op
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Provides an access point to perform synchronization operations
- *              within the AML.  This function will cause a lock to be generated
- *              for the Mutex pointed to by obj_desc.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ex_system_acquire_mutex(union acpi_operand_object * time_desc,
-			     union acpi_operand_object * obj_desc)
-{
-	acpi_status status = AE_OK;
-
-	ACPI_FUNCTION_TRACE_PTR(ex_system_acquire_mutex, obj_desc);
-
-	if (!obj_desc) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	/* Support for the _GL_ Mutex object -- go get the global lock */
-
-	if (obj_desc->mutex.os_mutex == ACPI_GLOBAL_LOCK) {
-		status =
-		    acpi_ev_acquire_global_lock((u16) time_desc->integer.value);
-		return_ACPI_STATUS(status);
-	}
-
-	status = acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
-					   (u16) time_desc->integer.value);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ex_system_release_mutex
- *
- * PARAMETERS:  obj_desc        - The object descriptor for this op
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Provides an access point to perform synchronization operations
- *              within the AML.  This operation is a request to release a
- *              previously acquired Mutex.  If the Mutex variable is set then
- *              it will be decremented.
- *
- ******************************************************************************/
-
-acpi_status acpi_ex_system_release_mutex(union acpi_operand_object *obj_desc)
-{
-	acpi_status status = AE_OK;
-
-	ACPI_FUNCTION_TRACE(ex_system_release_mutex);
-
-	if (!obj_desc) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	/* Support for the _GL_ Mutex object -- release the global lock */
-
-	if (obj_desc->mutex.os_mutex == ACPI_GLOBAL_LOCK) {
-		status = acpi_ev_release_global_lock();
-		return_ACPI_STATUS(status);
-	}
-
-	acpi_os_release_mutex(obj_desc->mutex.os_mutex);
-	return_ACPI_STATUS(AE_OK);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_system_signal_event
  *
  * PARAMETERS:  obj_desc        - The object descriptor for this op
@@ -314,7 +238,7 @@ acpi_status acpi_ex_system_release_mutex
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_signal_event(union acpi_operand_object *obj_desc)
+acpi_status acpi_ex_system_signal_event(union acpi_operand_object * obj_desc)
 {
 	acpi_status status = AE_OK;
 
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index c1c6c23..b2ef673 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -195,31 +195,27 @@ acpi_status acpi_ns_root_initialize(void
 				obj_desc->mutex.sync_level =
 				    (u8) (ACPI_TO_INTEGER(val) - 1);
 
-				if (ACPI_STRCMP(init_val->name, "_GL_") == 0) {
-
-					/* Create a counting semaphore for the global lock */
+				/* Create a mutex */
+
+				status =
+				    acpi_os_create_mutex(&obj_desc->mutex.
+							 os_mutex);
+				if (ACPI_FAILURE(status)) {
+					acpi_ut_remove_reference(obj_desc);
+					goto unlock_and_exit;
+				}
 
-					status =
-					    acpi_os_create_semaphore
-					    (ACPI_NO_UNIT_LIMIT, 1,
-					     &acpi_gbl_global_lock_semaphore);
-					if (ACPI_FAILURE(status)) {
-						acpi_ut_remove_reference
-						    (obj_desc);
-						goto unlock_and_exit;
-					}
+				/* Special case for ACPI Global Lock */
 
-					/* Mark this mutex as very special */
+				if (ACPI_STRCMP(init_val->name, "_GL_") == 0) {
+					acpi_gbl_global_lock_mutex =
+					    obj_desc->mutex.os_mutex;
 
-					obj_desc->mutex.os_mutex =
-					    ACPI_GLOBAL_LOCK;
-				} else {
-					/* Create a mutex */
+					/* Create additional counting semaphore for global lock */
 
 					status =
-					    acpi_os_create_mutex(&obj_desc->
-								 mutex.
-								 os_mutex);
+					    acpi_os_create_semaphore(1, 1,
+								     &acpi_gbl_global_lock_semaphore);
 					if (ACPI_FAILURE(status)) {
 						acpi_ut_remove_reference
 						    (obj_desc);
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index 9d3f114..af8e65f 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -158,16 +158,20 @@ static void acpi_ut_delete_internal_obj(
 				  "***** Mutex %p, OS Mutex %p\n",
 				  object, object->mutex.os_mutex));
 
-		if (object->mutex.os_mutex != ACPI_GLOBAL_LOCK) {
-			acpi_ex_unlink_mutex(object);
-			acpi_os_delete_mutex(object->mutex.os_mutex);
-		} else {
-			/* Global Lock "mutex" is actually a counting semaphore */
+		if (object->mutex.os_mutex == acpi_gbl_global_lock_mutex) {
+
+			/* Global Lock has extra semaphore */
 
 			(void)
 			    acpi_os_delete_semaphore
 			    (acpi_gbl_global_lock_semaphore);
 			acpi_gbl_global_lock_semaphore = NULL;
+
+			acpi_os_delete_mutex(object->mutex.os_mutex);
+			acpi_gbl_global_lock_mutex = NULL;
+		} else {
+			acpi_ex_unlink_mutex(object);
+			acpi_os_delete_mutex(object->mutex.os_mutex);
 		}
 		break;
 
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 014030a..1038452 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -795,8 +795,8 @@ void acpi_ut_init_globals(void)
 	/* Global Lock support */
 
 	acpi_gbl_global_lock_semaphore = NULL;
+	acpi_gbl_global_lock_mutex = NULL;
 	acpi_gbl_global_lock_acquired = FALSE;
-	acpi_gbl_global_lock_thread_count = 0;
 	acpi_gbl_global_lock_handle = 0;
 
 	/* Miscellaneous variables */
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 06972e6..bf43184 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -197,6 +197,7 @@ ACPI_EXTERN struct acpi_mutex_info acpi_
 /*
  * Global lock semaphore works in conjunction with the actual HW global lock
  */
+ACPI_EXTERN acpi_mutex acpi_gbl_global_lock_mutex;
 ACPI_EXTERN acpi_semaphore acpi_gbl_global_lock_semaphore;
 
 /*
@@ -240,7 +241,6 @@ ACPI_EXTERN struct acpi_walk_state *acpi
 
 /* Misc */
 
-ACPI_EXTERN u32 acpi_gbl_global_lock_thread_count;
 ACPI_EXTERN u32 acpi_gbl_original_mode;
 ACPI_EXTERN u32 acpi_gbl_rsdp_original_location;
 ACPI_EXTERN u32 acpi_gbl_ns_lookup_count;
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index 91586d0..f266b38 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -277,12 +277,6 @@ acpi_status acpi_ex_system_do_suspend(ac
 
 acpi_status acpi_ex_system_do_stall(u32 time);
 
-acpi_status
-acpi_ex_system_acquire_mutex(union acpi_operand_object *time,
-			     union acpi_operand_object *obj_desc);
-
-acpi_status acpi_ex_system_release_mutex(union acpi_operand_object *obj_desc);
-
 acpi_status acpi_ex_system_signal_event(union acpi_operand_object *obj_desc);
 
 acpi_status
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 063c4b5..d542140 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -51,7 +51,6 @@
 #define ACPI_SERIALIZED                 0xFF
 
 typedef u32 acpi_mutex_handle;
-#define ACPI_GLOBAL_LOCK                (acpi_semaphore) (-1)
 
 /* Total number of aml opcodes defined */
 
-- 
1.4.4.1
