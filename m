From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 1/3] ACPICA: Utilities: Add deferred lock free contexts for deleting operand objects
Date: Fri, 11 Sep 2015 10:05:21 +0800
Message-ID: <7d9b30aa6939d23a9116439b39c93e131b4d8120.1441935832.git.lv.zheng@intel.com>
References: <cover.1441935832.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14210 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbbIKCF0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2015 22:05:26 -0400
In-Reply-To: <cover.1441935832.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Hanjun Guo <hanjun.guo@linaro.org>

When acpi_ut_delete_internal_obj() is invoked, reference count should be zero
which means this context is the only context remained referencing this
object.  Normally, we may just unlock namespace mutex (ACPI_MTX_NAMESPACE)
before invoking this function, but since this function is invoked from
different environment, doing this have side effects:
1. Other ACPI internal mutexes may be held orderly when this function is
   invoked. Without unlocking such locks, we still cannot achieve a lock
   free environment.
2. For some environment, it might not be safe to unlock the namespace
   mutex right in that context.
So we introduces a deferred unlocked environment for further cleanups.

There are two choices to convert this function into a lock free style:
1. Deferred work queue: this may not be performance friendly as in order to
   __delete__ the object, we __create__ a new OS object (work queue item)
   to achieve each deletion, which may lead to a failure when the memory
   resource is heavily used.
2. Garbage collection: the deleted objects are linked together and at each
   exit of such a deletion, a garbage cleaner function is invoked where
   this function is invoked in a lock free style.

This patch implements both choices:
1. OSL_GC_HANDLER: This is a deferred work item, it is used in case there
   link point available to link the object into the garbage;
2. OSL_GC_THREAD: The linked deleted objects are destructed in a thread.
Note that in the slow path, we still need to __create__ a new OS object in
order to __delete__ the operand object. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpica/acglobal.h |    5 ++
 drivers/acpi/acpica/utdelete.c |  155 +++++++++++++++++++++++++++++++++++++---
 include/acpi/acpiosxf.h        |    2 +
 3 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 09f37b5..e7f0f82 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -161,6 +161,11 @@ ACPI_GLOBAL(u32, acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS]);
 ACPI_GLOBAL(u8, acpi_gbl_last_owner_id_index);
 ACPI_GLOBAL(u8, acpi_gbl_next_owner_id_offset);
 
+/* Garbage collection support */
+
+ACPI_INIT_GLOBAL(union acpi_operand_object *, acpi_gbl_garbage_operands, NULL);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_gc_thread_created, FALSE);
+
 /* Initialization sequencing */
 
 ACPI_GLOBAL(u8, acpi_gbl_reg_methods_executed);
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 1638312..ea737f4 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -51,26 +51,46 @@
 ACPI_MODULE_NAME("utdelete")
 
 /* Local prototypes */
-static void acpi_ut_delete_internal_obj(union acpi_operand_object *object);
+static void ACPI_SYSTEM_XFACE acpi_ut_delete_object_deferred(void *context);
+
+static void ACPI_SYSTEM_XFACE acpi_ut_delete_object_thread(void *unused);
 
 static void
 acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_delete_internal_obj
+ * FUNCTION:    acpi_ut_delete_object_deferred
  *
- * PARAMETERS:  object         - Object to be deleted
+ * PARAMETERS:  context        - Execution info
  *
  * RETURN:      None
  *
  * DESCRIPTION: Low level object deletion, after reference counts have been
- *              updated (All reference counts, including sub-objects!)
+ *              updated to zero.
+ *              There are two design requirements for the deletion function:
+ *              1. Since multiple wait/lock code may be invoked for the
+ *                 destruction of the object, the deletion function should be
+ *                 implemented in a lock free style so that individual deletion
+ *                 code piece can wait/lock using different wait/lock semantics.
+ *                 Since this context here is the only context that is still
+ *                 referencing the object, we needn't worry about the race
+ *                 conditions occurred without locking the whole function
+ *                 around.
+ *              2. Since operand object may contain many sub-objects typed as
+ *                 operand objects, in order not to increase stack consumption
+ *                 beyond software control, we need to defer executing each
+ *                 deletion of each operand object.
+ * Using acpi_os_execute() may not be a performance friendly choice, but it is
+ * the simplest choice for now to meet the above requirements.
  *
  ******************************************************************************/
 
-static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
+static void ACPI_SYSTEM_XFACE acpi_ut_delete_object_deferred(void *context)
 {
+	acpi_status status;
+	union acpi_operand_object *object =
+	    ACPI_CAST_PTR(union acpi_operand_object, context);
 	void *obj_pointer = NULL;
 	union acpi_operand_object *handler_desc;
 	union acpi_operand_object *second_desc;
@@ -78,13 +98,22 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 	union acpi_operand_object *start_desc;
 	union acpi_operand_object **last_obj_ptr;
 
-	ACPI_FUNCTION_TRACE_PTR(ut_delete_internal_obj, object);
+	ACPI_FUNCTION_TRACE_PTR(ut_delete_object_deferred, object);
 
 	if (!object) {
 		return_VOID;
 	}
 
 	/*
+	 * Keep old logic where the namespace mutex is always locked for an
+	 * operand object deletion in order to be regression safe.
+	 */
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_VOID;
+	}
+
+	/*
 	 * Must delete or free any pointers within the object that are not
 	 * actual ACPI objects (for example, a raw buffer pointer).
 	 */
@@ -335,11 +364,61 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			  object, acpi_ut_get_object_type_name(object)));
 
 	acpi_ut_delete_object_desc(object);
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_VOID;
 }
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_delete_object_thread
+ *
+ * PARAMETERS:  unused         - Execution info (unused)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: This thread iterates garbage operand list and destroy operands
+ *              linked in the list.
+ *
+ ******************************************************************************/
+
+static void ACPI_SYSTEM_XFACE acpi_ut_delete_object_thread(void *context)
+{
+	acpi_cpu_flags lock_flags;
+	union acpi_operand_object *gc_obj;
+
+	ACPI_FUNCTION_ENTRY();
+
+	lock_flags = acpi_os_acquire_lock(acpi_gbl_reference_count_lock);
+	while (acpi_gbl_gc_thread_created) {
+		while (acpi_gbl_garbage_operands) {
+			gc_obj =
+			    ACPI_CAST_PTR(union acpi_operand_object,
+					  acpi_gbl_garbage_operands);
+			acpi_gbl_garbage_operands = gc_obj->common.next_object;
+			gc_obj->common.next_object = NULL;
+
+			/* Delete the object in a lock free environment */
+
+			acpi_os_release_lock(acpi_gbl_reference_count_lock,
+					     lock_flags);
+			acpi_ut_delete_object_deferred(gc_obj);
+			lock_flags =
+			    acpi_os_acquire_lock(acpi_gbl_reference_count_lock);
+		}
+
+		/* Sleep until more garbage operands are detected */
+
+		acpi_os_release_lock(acpi_gbl_reference_count_lock, lock_flags);
+		acpi_os_sleep(50);
+		lock_flags =
+		    acpi_os_acquire_lock(acpi_gbl_reference_count_lock);
+	}
+	acpi_os_release_lock(acpi_gbl_reference_count_lock, lock_flags);
+	return;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_delete_internal_object_list
  *
  * PARAMETERS:  obj_list        - Pointer to the list to be deleted
@@ -388,6 +467,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 	u16 original_count;
 	u16 new_count = 0;
 	acpi_cpu_flags lock_flags;
+	acpi_status status;
 
 	ACPI_FUNCTION_NAME(ut_update_ref_count);
 
@@ -445,10 +525,67 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 				  "Obj %p Type %.2X Refs %.2X [Decremented]\n",
 				  object, object->common.type, new_count));
 
-		/* Actually delete the object on a reference count of zero */
-
+		/*
+		 * Actually delete the object on a reference count of zero. As some
+		 * synchronizations may be required for destructing sub-objects,
+		 * defer executing the deletion to a lock free environment.
+		 */
 		if (new_count == 0) {
-			acpi_ut_delete_internal_obj(object);
+			if (object->common.next_object) {
+
+				/* Slow path: create a work queue to free the object */
+
+				status = acpi_os_execute(OSL_GC_HANDLER,
+							 acpi_ut_delete_object_deferred,
+							 object);
+				if (ACPI_FAILURE(status)) {
+					acpi_ut_delete_object_deferred(object);
+				}
+			} else {
+				/* Acquire reference count lock for GC variables */
+
+				lock_flags =
+				    acpi_os_acquire_lock
+				    (acpi_gbl_reference_count_lock);
+
+				/* Fast path: link the object into a garbage list */
+
+				object->common.next_object =
+				    acpi_gbl_garbage_operands;
+				acpi_gbl_garbage_operands = object;
+
+				/*
+				 * Synchronize here to create the garbage collection thread
+				 * when memory is not low.
+				 */
+				if (!acpi_gbl_gc_thread_created) {
+					acpi_gbl_gc_thread_created = TRUE;
+					acpi_os_release_lock
+					    (acpi_gbl_reference_count_lock,
+					     lock_flags);
+
+					/*
+					 * Some hosts require this to be done in a non atomic
+					 * environment.
+					 */
+					status = acpi_os_execute(OSL_GC_THREAD,
+								 acpi_ut_delete_object_thread,
+								 NULL);
+
+					lock_flags =
+					    acpi_os_acquire_lock
+					    (acpi_gbl_reference_count_lock);
+					if (ACPI_FAILURE(status)) {
+						acpi_gbl_gc_thread_created =
+						    FALSE;
+					}
+				}
+
+				/* Release reference count lock for GC variables */
+
+				acpi_os_release_lock
+				    (acpi_gbl_reference_count_lock, lock_flags);
+			}
 		}
 		break;
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index a54ad1c..6a8f6c3 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -55,6 +55,8 @@ typedef enum {
 	OSL_GLOBAL_LOCK_HANDLER,
 	OSL_NOTIFY_HANDLER,
 	OSL_GPE_HANDLER,
+	OSL_GC_THREAD,
+	OSL_GC_HANDLER,
 	OSL_DEBUGGER_THREAD,
 	OSL_EC_POLL_HANDLER,
 	OSL_EC_BURST_HANDLER
-- 
1.7.10

