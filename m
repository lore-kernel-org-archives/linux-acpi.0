From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/28] ACPICA: Update use of acpi_os_wait_events_complete interface.
Date: Fri,  4 Apr 2014 12:37:51 +0800
Message-ID: <25dd8253cb9d5279f58b7919e40f52b21ddc65e6.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbaDDEhz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:55 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch cleans up all of the acpi_os_wait_events_complete() invocations to
make it to be invoked inside of ACPICA in the way to accommodate Linux's
work queue implementation.

According to the report, current Linux kernel code is facing a boot time
race issue in the acpi_remove_notify_handler(). This is because:
Linux is using work queues to implement a deferred handler call environment
while ACPICA expects OSPM to implement acpi_os_wait_events_complete() using
wait queues.  The position to invoke a "waiter" is not suitable for a
"flusher" as new invocations can be scheduled after this position and
before the deletion of the handler from its management container.

Since the following commit has deleted acpi_os_wait_events_complete()
parameters, it thus might not be possible for OSPM to achieve a safe
removal using wait queues.  This requires ACPICA to be changed accordingly
to "flush" handlers rather than "wait" them to be drain up:

  Commit: 5ff986a2a9db11858247b71fe242fe17617229aa
  Date: Wed, 16 May 2012 13:36:07 -0700
  Subject: Introduce acpi_os_wait_events_complete interface.

  This interface will block until asynchronous events like notifies
  and GPEs are complete. Within ACPICA, it is called before a notify or GPE
  handler is removed. ACPICA BZ 868.

This patch fixes this issue by invoking acpi_os_wait_events_complete() in the
way to "flush" things - it thus should be put to the position after handler
is removed from its management container but before it is destructed.

The technical concerns are:
1. MTX_NAMESPACE is used to protect things that acpi_os_wait_events_complete()
   might be waiting for, thus MTX_NAMESPACE must be unlocked before
   invoking acpi_os_wait_events_complete().
2. MTX_NAMESPACE is also used to implement the serialization of
   acpi_install_notify_handler() and acpi_remove_notify_handler(). This patch
   changes this logic, thus if there are many
   acpi_install/remove_notify_handler() invoked in parallel, the
   acpi_os_wait_events_complete() might face the races which could cause it
   never running to an end.  Normally this will require additional code to
   implement a separate locking facility which is not implemented due to 3.
3. Given ACPICA users will always invoke acpi_install_notify_handler() once
   during Linux module/device initialization and invoke
   acpi_remove_notify_handler() once during module/device finalization,
   problem stated in 2 will not happen in Linux environment due to the
   mutual exclusive module/device existence, this fix thus is sufficient.
Same concerns can apply to acpi_install/remove_gpe_handler(). Reported and
tested: Ronald Vink.  Fixed: Lv Zheng.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=60583
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reported-and-Tested-by: Ronald Vink <ronald.vink@boskalis.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxface.c |   55 +++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index a41a0e7..11e5803 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -239,7 +239,7 @@ acpi_remove_notify_handler(acpi_handle device,
 	union acpi_operand_object *obj_desc;
 	union acpi_operand_object *handler_obj;
 	union acpi_operand_object *previous_handler_obj;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(acpi_remove_notify_handler);
@@ -251,20 +251,17 @@ acpi_remove_notify_handler(acpi_handle device,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Make sure all deferred notify tasks are completed */
-
-	acpi_os_wait_events_complete();
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Root Object. Global handlers are removed here */
 
 	if (device == ACPI_ROOT_OBJECT) {
 		for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
 			if (handler_type & (i + 1)) {
+				status =
+				    acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+
 				if (!acpi_gbl_global_notify[i].handler ||
 				    (acpi_gbl_global_notify[i].handler !=
 				     handler)) {
@@ -277,31 +274,40 @@ acpi_remove_notify_handler(acpi_handle device,
 
 				acpi_gbl_global_notify[i].handler = NULL;
 				acpi_gbl_global_notify[i].context = NULL;
+
+				(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+				/* Make sure all deferred notify tasks are completed */
+
+				acpi_os_wait_events_complete();
 			}
 		}
 
-		goto unlock_and_exit;
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* All other objects: Are Notifies allowed on this object? */
 
 	if (!acpi_ev_is_notify_object(node)) {
-		status = AE_TYPE;
-		goto unlock_and_exit;
+		return_ACPI_STATUS(AE_TYPE);
 	}
 
 	/* Must have an existing internal object */
 
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (!obj_desc) {
-		status = AE_NOT_EXIST;
-		goto unlock_and_exit;
+		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
 	/* Internal object exists. Find the handler and remove it */
 
 	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
 		if (handler_type & (i + 1)) {
+			status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
+
 			handler_obj = obj_desc->common_notify.notify_list[i];
 			previous_handler_obj = NULL;
 
@@ -329,10 +335,17 @@ acpi_remove_notify_handler(acpi_handle device,
 				    handler_obj->notify.next[i];
 			}
 
+			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+			/* Make sure all deferred notify tasks are completed */
+
+			acpi_os_wait_events_complete();
 			acpi_ut_remove_reference(handler_obj);
 		}
 	}
 
+	return_ACPI_STATUS(status);
+
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
@@ -842,10 +855,6 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Make sure all deferred GPE tasks are completed */
-
-	acpi_os_wait_events_complete();
-
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -897,9 +906,17 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 		(void)acpi_ev_add_gpe_reference(gpe_event_info);
 	}
 
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	/* Make sure all deferred GPE tasks are completed */
+
+	acpi_os_wait_events_complete();
+
 	/* Now we can free the handler object */
 
 	ACPI_FREE(handler);
+	return_ACPI_STATUS(status);
 
 unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-- 
1.7.10

