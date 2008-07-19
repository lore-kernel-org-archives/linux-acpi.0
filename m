From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 2/3] acpi: semaphore removal
Date: Sat, 19 Jul 2008 11:16:53 -0700
Message-ID: <1216491411-24080-3-git-send-email-dwalker@mvista.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:29137 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbYGSSRD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 14:17:03 -0400
In-Reply-To: <1216491411-24080-2-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, ak@linux.intel.com, Dave Chinner <david@fromorbit.com>

The semaphore is used pretty extensively in acpi, but the actual
usage model is really more like completions. The ASL functions
getting implemented here are signals which follow a "wait for",
signaled, or rest format.

This implements the ACPI signaling methods with the Linux
completion API, instead of using semaphores.

completion_done() taken from Dave Chinner.

Cc: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/acpi/events/evmisc.c      |   12 ++++----
 drivers/acpi/executer/excreate.c  |   10 +++---
 drivers/acpi/executer/exdump.c    |    2 +-
 drivers/acpi/executer/exsystem.c  |   22 +++++++-------
 drivers/acpi/namespace/nsaccess.c |    4 +-
 drivers/acpi/osl.c                |   60 ++++++++++++++++++------------------
 drivers/acpi/utilities/utdelete.c |   12 ++++----
 drivers/acpi/utilities/utglobal.c |    2 +-
 include/acpi/acglobal.h           |    4 +-
 include/acpi/acinterp.h           |    2 +-
 include/acpi/acobject.h           |    2 +-
 include/acpi/acpiosxf.h           |   10 +++---
 include/acpi/actypes.h            |    2 +-
 include/linux/completion.h        |   19 +++++++++++
 14 files changed, 91 insertions(+), 72 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 1d5670b..b0bd8f7 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -283,7 +283,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
  *              release interrupt occurs. Attempt to acquire the global lock,
  *              if successful, signal the thread waiting for the lock.
  *
- * NOTE: Assumes that the semaphore can be signaled from interrupt level. If
+ * NOTE: Assumes that the completion can be signaled from interrupt level. If
  * this is not possible for some reason, a separate thread will have to be
  * scheduled to do this.
  *
@@ -305,13 +305,13 @@ static u32 acpi_ev_global_lock_handler(void *context)
 		/* Got the lock, now wake all threads waiting for it */
 
 		acpi_gbl_global_lock_acquired = TRUE;
-		/* Send a unit to the semaphore */
+		/* Send a unit to the completion */
 
 		if (ACPI_FAILURE
-		    (acpi_os_signal_semaphore
-		     (acpi_gbl_global_lock_semaphore, 1))) {
+		    (acpi_os_signal_complete
+		     (acpi_gbl_global_lock_completion, 1))) {
 			ACPI_ERROR((AE_INFO,
-				    "Could not signal Global Lock semaphore"));
+				    "Could not signal Global Lock completion"));
 		}
 	}
 
@@ -494,7 +494,7 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	 * Wait for handshake with the global lock interrupt handler.
 	 * This interface releases the interpreter if we must wait.
 	 */
-	status = acpi_ex_system_wait_semaphore(acpi_gbl_global_lock_semaphore,
+	status = acpi_ex_system_wait_semaphore(acpi_gbl_global_lock_completion,
 					       ACPI_WAIT_FOREVER);
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index ad09696..625be14 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -180,11 +180,11 @@ acpi_status acpi_ex_create_event(struct acpi_walk_state *walk_state)
 	}
 
 	/*
-	 * Create the actual OS semaphore, with zero initial units -- meaning
+	 * Create the actual OS completion, with zero initial units -- meaning
 	 * that the event is created in an unsignalled state
 	 */
-	status = acpi_os_create_semaphore(ACPI_NO_UNIT_LIMIT, 0,
-					  &obj_desc->event.os_semaphore);
+	status = acpi_os_create_completion(ACPI_NO_UNIT_LIMIT, 0,
+					  &obj_desc->event.os_completion);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
@@ -198,7 +198,7 @@ acpi_status acpi_ex_create_event(struct acpi_walk_state *walk_state)
       cleanup:
 	/*
 	 * Remove local reference to the object (on error, will cause deletion
-	 * of both object and semaphore if present.)
+	 * of both object and completion if present.)
 	 */
 	acpi_ut_remove_reference(obj_desc);
 	return_ACPI_STATUS(status);
@@ -254,7 +254,7 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
       cleanup:
 	/*
 	 * Remove local reference to the object (on error, will cause deletion
-	 * of both object and semaphore if present.)
+	 * of both object and completion if present.)
 	 */
 	acpi_ut_remove_reference(obj_desc);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 2be2e2b..9182ae4 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -117,7 +117,7 @@ static struct acpi_exdump_info acpi_ex_dump_device[4] = {
 
 static struct acpi_exdump_info acpi_ex_dump_event[2] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_event), NULL},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(event.os_semaphore), "OsSemaphore"}
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(event.os_completion), "OsSemaphore"}
 };
 
 static struct acpi_exdump_info acpi_ex_dump_method[8] = {
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index 68990f1..f35508a 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -62,13 +62,13 @@ ACPI_MODULE_NAME("exsystem")
  *              interpreter is released before waiting.
  *
  ******************************************************************************/
-acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
+acpi_status acpi_ex_system_wait_semaphore(acpi_completion comp, u16 timeout)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(ex_system_wait_semaphore);
+	ACPI_FUNCTION_TRACE(ex_system_wait_for_completion);
 
-	status = acpi_os_wait_semaphore(semaphore, 1, ACPI_DO_NOT_WAIT);
+	status = acpi_os_wait_for_completion(comp, 1, ACPI_DO_NOT_WAIT);
 	if (ACPI_SUCCESS(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -79,7 +79,7 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 
 		acpi_ex_relinquish_interpreter();
 
-		status = acpi_os_wait_semaphore(semaphore, 1, timeout);
+		status = acpi_os_wait_for_completion(comp, 1, timeout);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "*** Thread awake after blocking, %s\n",
@@ -229,7 +229,7 @@ acpi_status acpi_ex_system_signal_event(union acpi_operand_object * obj_desc)
 
 	if (obj_desc) {
 		status =
-		    acpi_os_signal_semaphore(obj_desc->event.os_semaphore, 1);
+		    acpi_os_signal_complete(obj_desc->event.os_completion, 1);
 	}
 
 	return_ACPI_STATUS(status);
@@ -260,7 +260,7 @@ acpi_ex_system_wait_event(union acpi_operand_object *time_desc,
 
 	if (obj_desc) {
 		status =
-		    acpi_ex_system_wait_semaphore(obj_desc->event.os_semaphore,
+		    acpi_ex_system_wait_semaphore(obj_desc->event.os_completion,
 						  (u16) time_desc->integer.
 						  value);
 	}
@@ -283,19 +283,19 @@ acpi_ex_system_wait_event(union acpi_operand_object *time_desc,
 acpi_status acpi_ex_system_reset_event(union acpi_operand_object *obj_desc)
 {
 	acpi_status status = AE_OK;
-	acpi_semaphore temp_semaphore;
+	acpi_completion temp_completion;
 
 	ACPI_FUNCTION_ENTRY();
 
 	/*
-	 * We are going to simply delete the existing semaphore and
+	 * We are going to simply delete the existing completion and
 	 * create a new one!
 	 */
 	status =
-	    acpi_os_create_semaphore(ACPI_NO_UNIT_LIMIT, 0, &temp_semaphore);
+	    acpi_os_create_completion(ACPI_NO_UNIT_LIMIT, 0, &temp_completion);
 	if (ACPI_SUCCESS(status)) {
-		(void)acpi_os_delete_semaphore(obj_desc->event.os_semaphore);
-		obj_desc->event.os_semaphore = temp_semaphore;
+		(void)acpi_os_delete_completion(obj_desc->event.os_completion);
+		obj_desc->event.os_completion = temp_completion;
 	}
 
 	return (status);
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index c39a7f6..fc54f45 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -213,8 +213,8 @@ acpi_status acpi_ns_root_initialize(void)
 					/* Create additional counting semaphore for global lock */
 
 					status =
-					    acpi_os_create_semaphore(1, 0,
-								     &acpi_gbl_global_lock_semaphore);
+					    acpi_os_create_completion(1, 0,
+								     &acpi_gbl_global_lock_completion);
 					if (ACPI_FAILURE(status)) {
 						acpi_ut_remove_reference
 						    (obj_desc);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8546f59..3cb9b89 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -43,7 +43,7 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/jiffies.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -766,44 +766,44 @@ void acpi_os_delete_lock(acpi_spinlock handle)
 }
 
 acpi_status
-acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
+acpi_os_create_completion(u32 max_units, u32 initial_units, acpi_handle * handle)
 {
-	struct semaphore *sem = NULL;
+	struct completion *comp = NULL;
 
-	sem = acpi_os_allocate(sizeof(struct semaphore));
-	if (!sem)
+	comp = acpi_os_allocate(sizeof(struct completion));
+	if (!comp)
 		return AE_NO_MEMORY;
-	memset(sem, 0, sizeof(struct semaphore));
+	memset(comp, 0, sizeof(struct completion));
 
-	sema_init(sem, initial_units);
+	init_completion(comp);
 
-	*handle = (acpi_handle *) sem;
+	*handle = (acpi_handle *) comp;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating semaphore[%p|%d].\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating completion[%p|%d].\n",
 			  *handle, initial_units));
 
 	return AE_OK;
 }
 
 /*
- * TODO: A better way to delete semaphores?  Linux doesn't have a
- * 'delete_semaphore()' function -- may result in an invalid
+ * TODO: A better way to delete completions?  Linux doesn't have a
+ * 'delete_completions()' function -- may result in an invalid
  * pointer dereference for non-synchronized consumers.	Should
  * we at least check for blocked threads and signal/cancel them?
  */
 
-acpi_status acpi_os_delete_semaphore(acpi_handle handle)
+acpi_status acpi_os_delete_completion(acpi_handle handle)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct completion *comp = (struct completion *)handle;
 
-	if (!sem)
+	if (!comp)
 		return AE_BAD_PARAMETER;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting semaphore[%p].\n", handle));
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting completion[%p].\n", handle));
 
-	BUG_ON(!list_empty(&sem->wait_list));
-	kfree(sem);
-	sem = NULL;
+	BUG_ON(!completion_done(comp));
+	kfree(comp);
+	comp = NULL;
 
 	return AE_OK;
 }
@@ -811,20 +811,20 @@ acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 /*
  * TODO: Support for units > 1?
  */
-acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
+acpi_status acpi_os_wait_for_completion(acpi_handle handle, u32 units, u16 timeout)
 {
 	acpi_status status = AE_OK;
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct completion *comp = (struct completion *)handle;
 	long jiffies;
 	int ret = 0;
 
-	if (!sem || (units < 1))
+	if (!comp || (units < 1))
 		return AE_BAD_PARAMETER;
 
 	if (units > 1)
 		return AE_SUPPORT;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for completion[%p|%d|%d]\n",
 			  handle, units, timeout));
 
 	if (timeout == ACPI_WAIT_FOREVER)
@@ -832,18 +832,18 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 	else
 		jiffies = msecs_to_jiffies(timeout);
 	
-	ret = down_timeout(sem, jiffies);
+	ret = wait_for_completion_timeout(comp, jiffies);
 	if (ret)
 		status = AE_TIME;
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Failed to acquire semaphore[%p|%d|%d], %s",
+				  "Failed to acquire completion[%p|%d|%d], %s",
 				  handle, units, timeout,
 				  acpi_format_exception(status)));
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Acquired semaphore[%p|%d|%d]", handle,
+				  "Acquired completion[%p|%d|%d]", handle,
 				  units, timeout));
 	}
 
@@ -853,20 +853,20 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 /*
  * TODO: Support for units > 1?
  */
-acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
+acpi_status acpi_os_signal_complete(acpi_handle handle, u32 units)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct completion *comp = (struct completion *)handle;
 
-	if (!sem || (units < 1))
+	if (!comp || (units < 1))
 		return AE_BAD_PARAMETER;
 
 	if (units > 1)
 		return AE_SUPPORT;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling semaphore[%p|%d]\n", handle,
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling completion[%p|%d]\n", handle,
 			  units));
 
-	up(sem);
+	complete(comp);
 
 	return AE_OK;
 }
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index c5c791a..95d557e 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -163,9 +163,9 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			/* Global Lock has extra semaphore */
 
 			(void)
-			    acpi_os_delete_semaphore
-			    (acpi_gbl_global_lock_semaphore);
-			acpi_gbl_global_lock_semaphore = NULL;
+			    acpi_os_delete_completion
+			    (acpi_gbl_global_lock_completion);
+			acpi_gbl_global_lock_completion = NULL;
 
 			acpi_os_delete_mutex(object->mutex.os_mutex);
 			acpi_gbl_global_lock_mutex = NULL;
@@ -179,10 +179,10 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 				  "***** Event %p, OS Semaphore %p\n",
-				  object, object->event.os_semaphore));
+				  object, object->event.os_completion));
 
-		(void)acpi_os_delete_semaphore(object->event.os_semaphore);
-		object->event.os_semaphore = NULL;
+		(void)acpi_os_delete_completion(object->event.os_completion);
+		object->event.os_completion = NULL;
 		break;
 
 	case ACPI_TYPE_METHOD:
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index a6e71b8..a0ef412 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -727,7 +727,7 @@ void acpi_ut_init_globals(void)
 
 	/* Global Lock support */
 
-	acpi_gbl_global_lock_semaphore = NULL;
+	acpi_gbl_global_lock_completion = NULL;
 	acpi_gbl_global_lock_mutex = NULL;
 	acpi_gbl_global_lock_acquired = FALSE;
 	acpi_gbl_global_lock_handle = 0;
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 15dda46..50f520f 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -171,10 +171,10 @@ ACPI_EXTERN struct acpi_mutex_info acpi_gbl_mutex_info[ACPI_NUM_MUTEX];
 
 /*
  * Global lock mutex is an actual AML mutex object
- * Global lock semaphore works in conjunction with the HW global lock
+ * System Global lock works in conjunction with the HW global lock
  */
 ACPI_EXTERN union acpi_operand_object *acpi_gbl_global_lock_mutex;
-ACPI_EXTERN acpi_semaphore acpi_gbl_global_lock_semaphore;
+ACPI_EXTERN acpi_completion acpi_gbl_global_lock_completion;
 ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
 ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
 ACPI_EXTERN u8 acpi_gbl_global_lock_present;
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index e8db7a3..daaa478 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -291,7 +291,7 @@ acpi_ex_system_wait_event(union acpi_operand_object *time,
 acpi_status acpi_ex_system_reset_event(union acpi_operand_object *obj_desc);
 
 acpi_status
-acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout);
+acpi_ex_system_wait_semaphore(acpi_completion semaphore, u16 timeout);
 
 acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout);
 
diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index e9657da..f63117d 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -149,7 +149,7 @@ struct acpi_object_package {
  *****************************************************************************/
 
 struct acpi_object_event {
-	ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;	/* Actual OS synchronization object */
+	ACPI_OBJECT_COMMON_HEADER acpi_completion os_completion;	/* Actual OS synchronization object */
 };
 
 struct acpi_object_mutex {
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 9032ec3..140e078 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -110,15 +110,15 @@ void acpi_os_release_lock(acpi_spinlock handle, acpi_cpu_flags flags);
  * Semaphore primitives
  */
 acpi_status
-acpi_os_create_semaphore(u32 max_units,
-			 u32 initial_units, acpi_semaphore * out_handle);
+acpi_os_create_completion(u32 max_units,
+			 u32 initial_units, acpi_completion * out_handle);
 
-acpi_status acpi_os_delete_semaphore(acpi_semaphore handle);
+acpi_status acpi_os_delete_completion(acpi_completion handle);
 
 acpi_status
-acpi_os_wait_semaphore(acpi_semaphore handle, u32 units, u16 timeout);
+acpi_os_wait_for_completion(acpi_completion handle, u32 units, u16 timeout);
 
-acpi_status acpi_os_signal_semaphore(acpi_semaphore handle, u32 units);
+acpi_status acpi_os_signal_complete(acpi_completion handle, u32 units);
 
 /*
  * Mutex primitives
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4ea4f40..f580f12 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -316,7 +316,7 @@ struct uint32_struct {
 /* Synchronization objects */
 
 #define acpi_mutex                      void *
-#define acpi_semaphore                  void *
+#define acpi_completion                 void *
 
 /*
  * Acpi integer width. In ACPI version 1, integers are 32 bits.  In ACPI
diff --git a/include/linux/completion.h b/include/linux/completion.h
index d2961b6..00b1288 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -36,6 +36,25 @@ struct completion {
 # define DECLARE_COMPLETION_ONSTACK(work) DECLARE_COMPLETION(work)
 #endif
 
+/**
+ *	completion_done - Test to see if a completion has any waiters
+ *	@x:	completion structure
+ *
+ *	Returns: 0 if there are waiters (wait_for_completion() in progress)
+ *		 1 if there are no waiters.
+ *
+ */
+static inline bool completion_done(struct completion *x)
+{
+	int ret = 1;
+
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done)
+		ret = 0;
+	spin_unlock_irq(&x->wait.lock);
+	return ret;
+}
+
 static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
-- 
1.5.5.1.32.gba7d2


