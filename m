From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/15] ACPICA: Performance: Remove function tracing from critical allocation functions.
Date: Wed, 21 Nov 2012 18:07:58 +0800
Message-ID: <036f73447eb2a6f55b93e6f2daabf18d9018e9cb.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6593 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127Ab2KUKID (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:08:03 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Tracing is no longer needed for many of the low-level function.
Removing the trace mechanism from these functions improves
performance a small amount, also simplifies the debug trace output.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsutils.c  |    8 ++++----
 drivers/acpi/acpica/utdelete.c |   26 +++++++++++++-------------
 drivers/acpi/acpica/uteval.c   |    2 +-
 drivers/acpi/acpica/utstate.c  |   40 ++++++++++++++++++----------------------
 drivers/acpi/acpica/uttrack.c  |   16 ++++++++--------
 5 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 7e8bd2a..4479654 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -663,17 +663,17 @@ void acpi_ns_terminate(void)
 
 u32 acpi_ns_opens_scope(acpi_object_type type)
 {
-	ACPI_FUNCTION_TRACE_STR(ns_opens_scope, acpi_ut_get_type_name(type));
+	ACPI_FUNCTION_ENTRY();
 
-	if (!acpi_ut_valid_object_type(type)) {
+	if (type > ACPI_TYPE_LOCAL_MAX) {
 
 		/* type code out of range  */
 
 		ACPI_WARNING((AE_INFO, "Invalid Object Type 0x%X", type));
-		return_UINT32(ACPI_NS_NORMAL);
+		return (ACPI_NS_NORMAL);
 	}
 
-	return_UINT32(((u32)acpi_gbl_ns_properties[type]) & ACPI_NS_NEWSCOPE);
+	return (((u32)acpi_gbl_ns_properties[type]) & ACPI_NS_NEWSCOPE);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index e806fb0..53e6af8 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -340,7 +340,7 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list)
 {
 	union acpi_operand_object **internal_obj;
 
-	ACPI_FUNCTION_TRACE(ut_delete_internal_object_list);
+	ACPI_FUNCTION_NAME(ut_delete_internal_object_list);
 
 	/* Walk the null-terminated internal list */
 
@@ -351,7 +351,7 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list)
 	/* Free the combined parameter pointer list and object array */
 
 	ACPI_FREE(obj_list);
-	return_VOID;
+	return;
 }
 
 /*******************************************************************************
@@ -484,7 +484,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 	union acpi_generic_state *state;
 	u32 i;
 
-	ACPI_FUNCTION_TRACE_PTR(ut_update_object_reference, object);
+	ACPI_FUNCTION_NAME(ut_update_object_reference);
 
 	while (object) {
 
@@ -493,7 +493,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		if (ACPI_GET_DESCRIPTOR_TYPE(object) == ACPI_DESC_TYPE_NAMED) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 					  "Object %p is NS handle\n", object));
-			return_ACPI_STATUS(AE_OK);
+			return (AE_OK);
 		}
 
 		/*
@@ -643,7 +643,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		}
 	}
 
-	return_ACPI_STATUS(AE_OK);
+	return (AE_OK);
 
       error_exit:
 
@@ -657,7 +657,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		acpi_ut_delete_generic_state(state);
 	}
 
-	return_ACPI_STATUS(status);
+	return (status);
 }
 
 /*******************************************************************************
@@ -676,12 +676,12 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 void acpi_ut_add_reference(union acpi_operand_object *object)
 {
 
-	ACPI_FUNCTION_TRACE_PTR(ut_add_reference, object);
+	ACPI_FUNCTION_NAME(ut_add_reference);
 
 	/* Ensure that we have a valid object */
 
 	if (!acpi_ut_valid_internal_object(object)) {
-		return_VOID;
+		return;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
@@ -691,7 +691,7 @@ void acpi_ut_add_reference(union acpi_operand_object *object)
 	/* Increment the reference count */
 
 	(void)acpi_ut_update_object_reference(object, REF_INCREMENT);
-	return_VOID;
+	return;
 }
 
 /*******************************************************************************
@@ -709,7 +709,7 @@ void acpi_ut_add_reference(union acpi_operand_object *object)
 void acpi_ut_remove_reference(union acpi_operand_object *object)
 {
 
-	ACPI_FUNCTION_TRACE_PTR(ut_remove_reference, object);
+	ACPI_FUNCTION_NAME(ut_remove_reference);
 
 	/*
 	 * Allow a NULL pointer to be passed in, just ignore it. This saves
@@ -718,13 +718,13 @@ void acpi_ut_remove_reference(union acpi_operand_object *object)
 	 */
 	if (!object ||
 	    (ACPI_GET_DESCRIPTOR_TYPE(object) == ACPI_DESC_TYPE_NAMED)) {
-		return_VOID;
+		return;
 	}
 
 	/* Ensure that we have a valid object */
 
 	if (!acpi_ut_valid_internal_object(object)) {
-		return_VOID;
+		return;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
@@ -737,5 +737,5 @@ void acpi_ut_remove_reference(union acpi_operand_object *object)
 	 * of all subobjects!)
 	 */
 	(void)acpi_ut_update_object_reference(object, REF_DECREMENT);
-	return_VOID;
+	return;
 }
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index a9c65fb..45cddb8 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -68,7 +68,7 @@ ACPI_MODULE_NAME("uteval")
  ******************************************************************************/
 
 acpi_status
-acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
+acpi_ut_evaluate_object(struct acpi_namespace_node * prefix_node,
 			char *path,
 			u32 expected_return_btypes,
 			union acpi_operand_object **return_desc)
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index cee0473..26a0c23 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -97,14 +97,13 @@ void
 acpi_ut_push_generic_state(union acpi_generic_state **list_head,
 			   union acpi_generic_state *state)
 {
-	ACPI_FUNCTION_TRACE(ut_push_generic_state);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Push the state object onto the front of the list (stack) */
 
 	state->common.next = *list_head;
 	*list_head = state;
-
-	return_VOID;
+	return;
 }
 
 /*******************************************************************************
@@ -124,7 +123,7 @@ union acpi_generic_state *acpi_ut_pop_generic_state(union acpi_generic_state
 {
 	union acpi_generic_state *state;
 
-	ACPI_FUNCTION_TRACE(ut_pop_generic_state);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Remove the state object at the head of the list (stack) */
 
@@ -136,7 +135,7 @@ union acpi_generic_state *acpi_ut_pop_generic_state(union acpi_generic_state
 		*list_head = state->common.next;
 	}
 
-	return_PTR(state);
+	return (state);
 }
 
 /*******************************************************************************
@@ -186,13 +185,13 @@ struct acpi_thread_state *acpi_ut_create_thread_state(void)
 {
 	union acpi_generic_state *state;
 
-	ACPI_FUNCTION_TRACE(ut_create_thread_state);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Create the generic state object */
 
 	state = acpi_ut_create_generic_state();
 	if (!state) {
-		return_PTR(NULL);
+		return (NULL);
 	}
 
 	/* Init fields specific to the update struct */
@@ -207,7 +206,7 @@ struct acpi_thread_state *acpi_ut_create_thread_state(void)
 		state->thread.thread_id = (acpi_thread_id) 1;
 	}
 
-	return_PTR((struct acpi_thread_state *)state);
+	return ((struct acpi_thread_state *)state);
 }
 
 /*******************************************************************************
@@ -230,13 +229,13 @@ union acpi_generic_state *acpi_ut_create_update_state(union acpi_operand_object
 {
 	union acpi_generic_state *state;
 
-	ACPI_FUNCTION_TRACE_PTR(ut_create_update_state, object);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Create the generic state object */
 
 	state = acpi_ut_create_generic_state();
 	if (!state) {
-		return_PTR(NULL);
+		return (NULL);
 	}
 
 	/* Init fields specific to the update struct */
@@ -244,8 +243,7 @@ union acpi_generic_state *acpi_ut_create_update_state(union acpi_operand_object
 	state->common.descriptor_type = ACPI_DESC_TYPE_STATE_UPDATE;
 	state->update.object = object;
 	state->update.value = action;
-
-	return_PTR(state);
+	return (state);
 }
 
 /*******************************************************************************
@@ -267,13 +265,13 @@ union acpi_generic_state *acpi_ut_create_pkg_state(void *internal_object,
 {
 	union acpi_generic_state *state;
 
-	ACPI_FUNCTION_TRACE_PTR(ut_create_pkg_state, internal_object);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Create the generic state object */
 
 	state = acpi_ut_create_generic_state();
 	if (!state) {
-		return_PTR(NULL);
+		return (NULL);
 	}
 
 	/* Init fields specific to the update struct */
@@ -283,8 +281,7 @@ union acpi_generic_state *acpi_ut_create_pkg_state(void *internal_object,
 	state->pkg.dest_object = external_object;
 	state->pkg.index = index;
 	state->pkg.num_packages = 1;
-
-	return_PTR(state);
+	return (state);
 }
 
 /*******************************************************************************
@@ -304,21 +301,20 @@ union acpi_generic_state *acpi_ut_create_control_state(void)
 {
 	union acpi_generic_state *state;
 
-	ACPI_FUNCTION_TRACE(ut_create_control_state);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Create the generic state object */
 
 	state = acpi_ut_create_generic_state();
 	if (!state) {
-		return_PTR(NULL);
+		return (NULL);
 	}
 
 	/* Init fields specific to the control struct */
 
 	state->common.descriptor_type = ACPI_DESC_TYPE_STATE_CONTROL;
 	state->common.state = ACPI_CONTROL_CONDITIONAL_EXECUTING;
-
-	return_PTR(state);
+	return (state);
 }
 
 /*******************************************************************************
@@ -336,12 +332,12 @@ union acpi_generic_state *acpi_ut_create_control_state(void)
 
 void acpi_ut_delete_generic_state(union acpi_generic_state *state)
 {
-	ACPI_FUNCTION_TRACE(ut_delete_generic_state);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Ignore null state */
 
 	if (state) {
 		(void)acpi_os_release_object(acpi_gbl_state_cache, state);
 	}
-	return_VOID;
+	return;
 }
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index a424a9e..866f96e 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -436,10 +436,10 @@ acpi_ut_remove_allocation(struct acpi_debug_mem_block *allocation,
 	struct acpi_memory_list *mem_list;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(ut_remove_allocation);
+	ACPI_FUNCTION_NAME(ut_remove_allocation);
 
 	if (acpi_gbl_disable_mem_tracking) {
-		return_ACPI_STATUS(AE_OK);
+		return (AE_OK);
 	}
 
 	mem_list = acpi_gbl_global_list;
@@ -450,12 +450,12 @@ acpi_ut_remove_allocation(struct acpi_debug_mem_block *allocation,
 		ACPI_ERROR((module, line,
 			    "Empty allocation list, nothing to free!"));
 
-		return_ACPI_STATUS(AE_OK);
+		return (AE_OK);
 	}
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_MEMORY);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		return (status);
 	}
 
 	/* Unlink */
@@ -470,15 +470,15 @@ acpi_ut_remove_allocation(struct acpi_debug_mem_block *allocation,
 		(allocation->next)->previous = allocation->previous;
 	}
 
+	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "Freeing %p, size 0%X\n",
+			  &allocation->user_space, allocation->size));
+
 	/* Mark the segment as deleted */
 
 	ACPI_MEMSET(&allocation->user_space, 0xEA, allocation->size);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "Freeing size 0%X\n",
-			  allocation->size));
-
 	status = acpi_ut_release_mutex(ACPI_MTX_MEMORY);
-	return_ACPI_STATUS(status);
+	return (status);
 }
 
 /*******************************************************************************
-- 
1.7.10

