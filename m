From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/11] ACPICA: Add a lock to the internal object reference count mechanism
Date: Fri, 12 Apr 2013 08:25:41 +0800
Message-ID: <ffb03a1ab4d4c0c64359b4ff3167b885406affc5.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55693 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3DLAZ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:59 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Andriy Gapon <avg@FreeBSD.org>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Certain external interfaces need to update object references
without holding the interpreter or namespace mutex objects. To
prevent race conditions, add a spinlock around the increment
and decrement of the reference counts for internal ACPI
objects. Reported by Andriy Gapon (avg@FreeBSD.org).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Andriy Gapon <avg@FreeBSD.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/utdelete.c |   82 +++++++++++++++++++++++-----------------
 drivers/acpi/acpica/utmutex.c  |    9 ++++-
 3 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 833fbc5..0716092 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -224,6 +224,7 @@ ACPI_EXTERN u8 acpi_gbl_global_lock_pending;
  */
 ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
 ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
+ACPI_EXTERN acpi_spinlock acpi_gbl_reference_count_lock;
 
 /* Mutex for _OSI support */
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index fc11ad1..29b9302 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -359,19 +359,20 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list)
  * FUNCTION:    acpi_ut_update_ref_count
  *
  * PARAMETERS:  object          - Object whose ref count is to be updated
- *              action          - What to do
+ *              action          - What to do (REF_INCREMENT or REF_DECREMENT)
  *
- * RETURN:      New ref count
+ * RETURN:      None. Sets new reference count within the object
  *
- * DESCRIPTION: Modify the ref count and return it.
+ * DESCRIPTION: Modify the reference count for an internal acpi object
  *
  ******************************************************************************/
 
 static void
 acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 {
-	u16 count;
-	u16 new_count;
+	u16 original_count;
+	u16 new_count = 0;
+	acpi_cpu_flags lock_flags;
 
 	ACPI_FUNCTION_NAME(ut_update_ref_count);
 
@@ -379,46 +380,58 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 		return;
 	}
 
-	count = object->common.reference_count;
-	new_count = count;
-
 	/*
-	 * Perform the reference count action (increment, decrement, force delete)
+	 * Always get the reference count lock. Note: Interpreter and/or
+	 * Namespace is not always locked when this function is called.
 	 */
+	lock_flags = acpi_os_acquire_lock(acpi_gbl_reference_count_lock);
+	original_count = object->common.reference_count;
+
+	/* Perform the reference count action (increment, decrement) */
+
 	switch (action) {
 	case REF_INCREMENT:
 
-		new_count++;
+		new_count = original_count + 1;
 		object->common.reference_count = new_count;
+		acpi_os_release_lock(acpi_gbl_reference_count_lock, lock_flags);
+
+		/* The current reference count should never be zero here */
+
+		if (!original_count) {
+			ACPI_WARNING((AE_INFO,
+				      "Obj %p, Reference Count was zero before increment\n",
+				      object));
+		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-				  "Obj %p Refs=%X, [Incremented]\n",
-				  object, new_count));
+				  "Obj %p Type %.2X Refs %.2X [Incremented]\n",
+				  object, object->common.type, new_count));
 		break;
 
 	case REF_DECREMENT:
 
-		if (count < 1) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-					  "Obj %p Refs=%X, can't decrement! (Set to 0)\n",
-					  object, new_count));
-
-			new_count = 0;
-		} else {
-			new_count--;
+		/* The current reference count must be non-zero */
 
-			ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-					  "Obj %p Refs=%X, [Decremented]\n",
-					  object, new_count));
+		if (original_count) {
+			new_count = original_count - 1;
+			object->common.reference_count = new_count;
 		}
 
-		if (object->common.type == ACPI_TYPE_METHOD) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-					  "Method Obj %p Refs=%X, [Decremented]\n",
-					  object, new_count));
+		acpi_os_release_lock(acpi_gbl_reference_count_lock, lock_flags);
+
+		if (!original_count) {
+			ACPI_WARNING((AE_INFO,
+				      "Obj %p, Reference Count is already zero, cannot decrement\n",
+				      object));
 		}
 
-		object->common.reference_count = new_count;
+		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
+				  "Obj %p Type %.2X Refs %.2X [Decremented]\n",
+				  object, object->common.type, new_count));
+
+		/* Actually delete the object on a reference count of zero */
+
 		if (new_count == 0) {
 			acpi_ut_delete_internal_obj(object);
 		}
@@ -426,18 +439,20 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown action (0x%X)", action));
-		break;
+		acpi_os_release_lock(acpi_gbl_reference_count_lock, lock_flags);
+		ACPI_ERROR((AE_INFO, "Unknown Reference Count action (0x%X)",
+			    action));
+		return;
 	}
 
 	/*
 	 * Sanity check the reference count, for debug purposes only.
 	 * (A deleted object will have a huge reference count)
 	 */
-	if (count > ACPI_MAX_REFERENCE_COUNT) {
+	if (new_count > ACPI_MAX_REFERENCE_COUNT) {
 		ACPI_WARNING((AE_INFO,
-			      "Large Reference Count (0x%X) in object %p",
-			      count, object));
+			      "Large Reference Count (0x%X) in object %p, Type=0x%.2X",
+			      new_count, object, object->common.type));
 	}
 }
 
@@ -702,7 +717,6 @@ void acpi_ut_remove_reference(union acpi_operand_object *object)
 	/*
 	 * Allow a NULL pointer to be passed in, just ignore it. This saves
 	 * each caller from having to check. Also, ignore NS nodes.
-	 *
 	 */
 	if (!object ||
 	    (ACPI_GET_DESCRIPTOR_TYPE(object) == ACPI_DESC_TYPE_NAMED)) {
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 22feb99..08c3232 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -81,7 +81,7 @@ acpi_status acpi_ut_mutex_initialize(void)
 		}
 	}
 
-	/* Create the spinlocks for use at interrupt level */
+	/* Create the spinlocks for use at interrupt level or for speed */
 
 	status = acpi_os_create_lock (&acpi_gbl_gpe_lock);
 	if (ACPI_FAILURE (status)) {
@@ -93,7 +93,13 @@ acpi_status acpi_ut_mutex_initialize(void)
 		return_ACPI_STATUS (status);
 	}
 
+	status = acpi_os_create_lock(&acpi_gbl_reference_count_lock);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	/* Mutex for _OSI support */
+
 	status = acpi_os_create_mutex(&acpi_gbl_osi_mutex);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -136,6 +142,7 @@ void acpi_ut_mutex_terminate(void)
 
 	acpi_os_delete_lock(acpi_gbl_gpe_lock);
 	acpi_os_delete_lock(acpi_gbl_hardware_lock);
+	acpi_os_delete_lock(acpi_gbl_reference_count_lock);
 
 	/* Delete the reader/writer lock */
 
-- 
1.7.10

