From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/3] ACPICA: Events: Fix reference counting code for per-object notify handlers
Date: Fri, 11 Sep 2015 10:05:33 +0800
Message-ID: <b248e43797f57159b0c7f6be8cae192098059bf0.1441935832.git.lv.zheng@intel.com>
References: <cover.1441935832.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8602 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbbIKCFi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2015 22:05:38 -0400
In-Reply-To: <cover.1441935832.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Hanjun Guo <hanjun.guo@linaro.org>

The reference counting code of Notify handler object is abnormal. It
doesn't follow the coding rule that the reference increment should/must
only happen to a pointer reference and the reference decrement should /must
only happen to a pointer dereference.

This patch fixes per-object notify handler reference counting. The global
notify handlers are not covered by this patch. Lv Zheng.

Reference: https://bugs.acpica.org/show_bug.cgi?id=1115
Reported-by: Lee, Chun-Yi <jlee@suse.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpica/acevents.h |    4 ++
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/evmisc.c   |  134 +++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/evxface.c  |   66 +++-----------------
 drivers/acpi/acpica/utdelete.c |   36 +++++------
 drivers/acpi/acpica/utstate.c  |   22 ++++++-
 6 files changed, 178 insertions(+), 86 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 228704b7..dc0b19e 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -64,6 +64,10 @@ acpi_status
 acpi_ev_queue_notify_request(struct acpi_namespace_node *node,
 			     u32 notify_value);
 
+acpi_status
+acpi_ev_delete_notify_handlers(union acpi_operand_object *object,
+			       u32 handler_type, acpi_notify_handler handler);
+
 /*
  * evglock - Global Lock support
  */
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 0bd02c4..35625ec 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -207,7 +207,7 @@ struct acpi_object_method {
  * Common fields for objects that support ASL notifications
  */
 #define ACPI_COMMON_NOTIFY_INFO \
-	union acpi_operand_object       *notify_list[2];    /* Handlers for system/device notifies */\
+	union acpi_operand_object       *notify_list[ACPI_NUM_NOTIFY_TYPES]; /* Handlers for system/device notifies */\
 	union acpi_operand_object       *handler;	/* Handler for Address space */
 
 struct acpi_object_notify_common {	/* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index f7c9dfe..10ab07c 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -161,6 +161,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 	info->notify.value = (u16)notify_value;
 	info->notify.handler_list_id = handler_list_id;
 	info->notify.handler_list_head = handler_list_head;
+	acpi_ut_add_reference(handler_list_head);
 	info->notify.global = &acpi_gbl_global_notify[handler_list_id];
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -196,6 +197,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 {
 	union acpi_generic_state *info = (union acpi_generic_state *)context;
 	union acpi_operand_object *handler_obj;
+	union acpi_operand_object *next_obj;
+	acpi_status status;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -209,21 +212,148 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 
 	/* Now invoke the local notify handler(s) if any are installed */
 
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
 	handler_obj = info->notify.handler_list_head;
+	acpi_ut_add_reference(handler_obj);
 	while (handler_obj) {
+		next_obj =
+		    handler_obj->notify.next[info->notify.handler_list_id];
+		acpi_ut_add_reference(next_obj);
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
 		handler_obj->notify.handler(info->notify.node,
 					    info->notify.value,
 					    handler_obj->notify.context);
+		acpi_ut_remove_reference(handler_obj);
 
-		handler_obj =
-		    handler_obj->notify.next[info->notify.handler_list_id];
+		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(status)) {
+			return;
+		}
+		handler_obj = next_obj;
 	}
 
 	/* All done with the info object */
 
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+error_exit:
 	acpi_ut_delete_generic_state(info);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_delete_notify_handlers
+ *
+ * PARAMETERS:  object          - The object for which notifies will be handled
+ *              handler_type    - The type of handler:
+ *                                  ACPI_SYSTEM_NOTIFY: System Handler (00-7F)
+ *                                  ACPI_DEVICE_NOTIFY: Device Handler (80-FF)
+ *                                  ACPI_ALL_NOTIFY:    Both System and Device
+ *              handler         - Address of the handler
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove matched handlers for notifications on the operand object
+ *              which should have just been detached from an ACPI Device,
+ *              thermal_zone, or Processor namespace node.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ev_delete_notify_handlers(union acpi_operand_object *object,
+			       u32 handler_type, acpi_notify_handler handler)
+{
+	union acpi_operand_object *handler_obj;
+	union acpi_operand_object *previous_handler_obj;
+	acpi_status status = AE_OK;
+	u32 i;
+	union acpi_operand_object *dead_handler_list = NULL;
+	union acpi_operand_object *dead_handler_obj = NULL;
+	u8 dead_handler_duplicated;
+
+	ACPI_FUNCTION_TRACE(ev_delete_notify_handlers);
+
+	/* Internal object exists. Find the handler and remove it */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
+		if (handler_type & (i + 1)) {
+			handler_obj = object->common_notify.notify_list[i];
+			previous_handler_obj = NULL;
+
+			/* Attempt to find the handler in the handler list */
+
+			if (handler) {
+				while (handler_obj &&
+				       (handler_obj->notify.handler !=
+					handler)) {
+					previous_handler_obj = handler_obj;
+					handler_obj =
+					    handler_obj->notify.next[i];
+				}
+			}
+
+			if (!handler_obj) {
+				continue;
+			}
+
+			/* Remove the handler object from the list */
+
+			if (previous_handler_obj) {	/* Handler is not at the list head */
+				previous_handler_obj->notify.next[i] =
+				    handler_obj->notify.next[i];
+			} else {	/* Handler is at the list head */
+
+				object->common_notify.notify_list[i] =
+				    handler_obj->notify.next[i];
+			}
+			acpi_ut_remove_reference(handler_obj);
+
+			/* Store removed handler object if it is not duplicated */
+
+			dead_handler_duplicated = FALSE;
+			dead_handler_obj = dead_handler_list;
+			while (dead_handler_obj) {
+				if (dead_handler_obj == handler_obj) {
+					dead_handler_duplicated = TRUE;
+					break;
+				}
+				dead_handler_obj =
+				    dead_handler_obj->notify.next[0];
+			}
+			if (!dead_handler_duplicated) {
+				handler_obj->notify.next[0] = dead_handler_list;
+				dead_handler_list = handler_obj;
+			}
+		}
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+	/* Make sure all deferred notify tasks are completed */
+
+	acpi_os_wait_events_complete();
+
+	/* Destroy removed handler objects */
+
+	handler_obj = dead_handler_list;
+	while (handler_obj) {
+		dead_handler_list = handler_obj->notify.next[0];
+		acpi_ut_remove_reference(handler_obj);
+		handler_obj = dead_handler_list;
+	}
+
+	return_ACPI_STATUS(status);
+}
+
 #if (!ACPI_REDUCED_HARDWARE)
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 81f2d9e..34a78b0 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -208,16 +208,11 @@ acpi_install_notify_handler(acpi_handle device,
 			handler_obj->notify.next[i] =
 			    obj_desc->common_notify.notify_list[i];
 
+			acpi_ut_add_reference(handler_obj);
 			obj_desc->common_notify.notify_list[i] = handler_obj;
 		}
 	}
 
-	/* Add an extra reference if handler was installed in both lists */
-
-	if (handler_type == ACPI_ALL_NOTIFY) {
-		acpi_ut_add_reference(handler_obj);
-	}
-
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
@@ -248,8 +243,6 @@ acpi_remove_notify_handler(acpi_handle device,
 	struct acpi_namespace_node *node =
 	    ACPI_CAST_PTR(struct acpi_namespace_node, device);
 	union acpi_operand_object *obj_desc;
-	union acpi_operand_object *handler_obj;
-	union acpi_operand_object *previous_handler_obj;
 	acpi_status status = AE_OK;
 	u32 i;
 
@@ -276,8 +269,10 @@ acpi_remove_notify_handler(acpi_handle device,
 				if (!acpi_gbl_global_notify[i].handler ||
 				    (acpi_gbl_global_notify[i].handler !=
 				     handler)) {
-					status = AE_NOT_EXIST;
-					goto unlock_and_exit;
+					(void)
+					    acpi_ut_release_mutex
+					    (ACPI_MTX_NAMESPACE);
+					return_ACPI_STATUS(status);
 				}
 
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -310,55 +305,8 @@ acpi_remove_notify_handler(acpi_handle device,
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	/* Internal object exists. Find the handler and remove it */
-
-	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
-		if (handler_type & (i + 1)) {
-			status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-			if (ACPI_FAILURE(status)) {
-				return_ACPI_STATUS(status);
-			}
-
-			handler_obj = obj_desc->common_notify.notify_list[i];
-			previous_handler_obj = NULL;
-
-			/* Attempt to find the handler in the handler list */
-
-			while (handler_obj &&
-			       (handler_obj->notify.handler != handler)) {
-				previous_handler_obj = handler_obj;
-				handler_obj = handler_obj->notify.next[i];
-			}
-
-			if (!handler_obj) {
-				status = AE_NOT_EXIST;
-				goto unlock_and_exit;
-			}
-
-			/* Remove the handler object from the list */
-
-			if (previous_handler_obj) {	/* Handler is not at the list head */
-				previous_handler_obj->notify.next[i] =
-				    handler_obj->notify.next[i];
-			} else {	/* Handler is at the list head */
-
-				obj_desc->common_notify.notify_list[i] =
-				    handler_obj->notify.next[i];
-			}
-
-			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-
-			/* Make sure all deferred notify tasks are completed */
-
-			acpi_os_wait_events_complete();
-			acpi_ut_remove_reference(handler_obj);
-		}
-	}
-
-	return_ACPI_STATUS(status);
-
-unlock_and_exit:
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	status =
+	    acpi_ev_delete_notify_handlers(obj_desc, handler_type, handler);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index ea737f4..619ab54 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -190,6 +190,20 @@ static void ACPI_SYSTEM_XFACE acpi_ut_delete_object_deferred(void *context)
 			acpi_ut_remove_reference(handler_desc);
 			handler_desc = next_desc;
 		}
+
+		/*lint -fallthrough */
+
+	case ACPI_TYPE_POWER:
+		/*
+		 * Update the notify objects for these types (if present)
+		 * Two lists, system and device notify handlers.
+		 */
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		acpi_ev_delete_notify_handlers(object, ACPI_ALL_NOTIFY, NULL);
+		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(status)) {
+			return_VOID;
+		}
 		break;
 
 	case ACPI_TYPE_MUTEX:
@@ -635,7 +649,6 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 	acpi_status status = AE_OK;
 	union acpi_generic_state *state_list = NULL;
 	union acpi_operand_object *next_object = NULL;
-	union acpi_operand_object *prev_object;
 	union acpi_generic_state *state;
 	u32 i;
 
@@ -656,27 +669,6 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		 * Different object types have different subobjects.
 		 */
 		switch (object->common.type) {
-		case ACPI_TYPE_DEVICE:
-		case ACPI_TYPE_PROCESSOR:
-		case ACPI_TYPE_POWER:
-		case ACPI_TYPE_THERMAL:
-			/*
-			 * Update the notify objects for these types (if present)
-			 * Two lists, system and device notify handlers.
-			 */
-			for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
-				prev_object =
-				    object->common_notify.notify_list[i];
-				while (prev_object) {
-					next_object =
-					    prev_object->notify.next[i];
-					acpi_ut_update_ref_count(prev_object,
-								 action);
-					prev_object = next_object;
-				}
-			}
-			break;
-
 		case ACPI_TYPE_PACKAGE:
 			/*
 			 * We must update all the sub-objects of the package,
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index f201171..a959b3f 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -297,12 +297,30 @@ union acpi_generic_state *acpi_ut_create_control_state(void)
 
 void acpi_ut_delete_generic_state(union acpi_generic_state *state)
 {
+	union acpi_operand_object *handler_list_head;
+
 	ACPI_FUNCTION_ENTRY();
 
 	/* Ignore null state */
 
-	if (state) {
-		(void)acpi_os_release_object(acpi_gbl_state_cache, state);
+	if (!state) {
+		return;
+	}
+
+	switch (state->common.descriptor_type) {
+	case ACPI_DESC_TYPE_STATE_NOTIFY:
+
+		if (state->notify.handler_list_head) {
+			handler_list_head = state->notify.handler_list_head;
+			state->notify.handler_list_head = NULL;
+			acpi_ut_remove_reference(handler_list_head);
+		}
+		break;
+
+	default:
+
+		break;
 	}
+	(void)acpi_os_release_object(acpi_gbl_state_cache, state);
 	return;
 }
-- 
1.7.10

