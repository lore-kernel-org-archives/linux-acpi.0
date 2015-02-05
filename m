From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/10] ACPICA: Events: Remove acpi_ev_valid_gpe_event() due to current restriction.
Date: Thu,  5 Feb 2015 15:20:01 +0800
Message-ID: <5cbb54b6ef18275802853688882fbec90f0c8cca.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 8823b44ff53859ab24ecfcfd3fba8cc56b17d223

Currently we rely on the logic that GPE blocks will never be deleted,
otherwise we can be broken by the race between acpi_ev_create_gpe_block(),
acpi_ev_delete_gpe_block() and acpi_ev_gpe_detect().
On the other hand, if we want to protect GPE block creation/deletion, we
need to use a different synchronization facility to protect the period
between acpi_ev_gpe_dispatch() and acpi_ev_asynch_enable_gpe(). Which leaves us
no choice but abandoning the ACPI_MTX_EVENTS used during this period.

This patch removes ACPI_MTX_EVENTS used during this period and the
acpi_ev_valid_gpe_event() to reflect current restriction. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/8823b44f
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acevents.h  |    2 --
 drivers/acpi/acpica/evgpe.c     |   62 ++++++++-------------------------------
 drivers/acpi/acpica/evgpeutil.c |   51 ++------------------------------
 3 files changed, 15 insertions(+), 100 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 7a7811a..38b94a1 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -143,8 +143,6 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 acpi_status
 acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback, void *context);
 
-u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info);
-
 acpi_status
 acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		       struct acpi_gpe_block_info *gpe_block, void *context);
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index b2e63e7..ddee967 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -474,51 +474,14 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info = context;
 	acpi_status status;
-	struct acpi_gpe_event_info *local_gpe_event_info;
 	struct acpi_evaluate_info *info;
 	struct acpi_gpe_notify_info *notify;
 
 	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
 
-	/* Allocate a local GPE block */
-
-	local_gpe_event_info =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_event_info));
-	if (!local_gpe_event_info) {
-		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "while handling a GPE"));
-		return_VOID;
-	}
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(local_gpe_event_info);
-		return_VOID;
-	}
-
-	/* Must revalidate the gpe_number/gpe_block */
-
-	if (!acpi_ev_valid_gpe_event(gpe_event_info)) {
-		status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-		ACPI_FREE(local_gpe_event_info);
-		return_VOID;
-	}
-
-	/*
-	 * Take a snapshot of the GPE info for this level - we copy the info to
-	 * prevent a race condition with remove_handler/remove_block.
-	 */
-	ACPI_MEMCPY(local_gpe_event_info, gpe_event_info,
-		    sizeof(struct acpi_gpe_event_info));
-
-	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(local_gpe_event_info);
-		return_VOID;
-	}
-
 	/* Do the correct dispatch - normal method or implicit notify */
 
-	switch (local_gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
+	switch (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
 	case ACPI_GPE_DISPATCH_NOTIFY:
 		/*
 		 * Implicit notify.
@@ -531,7 +494,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		 * June 2012: Expand implicit notify mechanism to support
 		 * notifies on multiple device objects.
 		 */
-		notify = local_gpe_event_info->dispatch.notify_list;
+		notify = gpe_event_info->dispatch.notify_list;
 		while (ACPI_SUCCESS(status) && notify) {
 			status =
 			    acpi_ev_queue_notify_request(notify->device_node,
@@ -555,7 +518,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			 * _Lxx/_Exx control method that corresponds to this GPE
 			 */
 			info->prefix_node =
-			    local_gpe_event_info->dispatch.method_node;
+			    gpe_event_info->dispatch.method_node;
 			info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 			status = acpi_ns_evaluate(info);
@@ -565,25 +528,27 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"while evaluating GPE method [%4.4s]",
-					acpi_ut_get_node_name
-					(local_gpe_event_info->dispatch.
-					 method_node)));
+					acpi_ut_get_node_name(gpe_event_info->
+							      dispatch.
+							      method_node)));
 		}
 		break;
 
 	default:
 
-		return_VOID;	/* Should never happen */
+		goto error_exit;	/* Should never happen */
 	}
 
 	/* Defer enabling of GPE until all notify handlers are done */
 
 	status = acpi_os_execute(OSL_NOTIFY_HANDLER,
-				 acpi_ev_asynch_enable_gpe,
-				 local_gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(local_gpe_event_info);
+				 acpi_ev_asynch_enable_gpe, gpe_event_info);
+	if (ACPI_SUCCESS(status)) {
+		return_VOID;
 	}
+
+error_exit:
+	acpi_ev_asynch_enable_gpe(gpe_event_info);
 	return_VOID;
 }
 
@@ -611,7 +576,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context)
 	(void)acpi_ev_finish_gpe(gpe_event_info);
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
-	ACPI_FREE(gpe_event_info);
 	return;
 }
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 9e2b94c..3f1c5aa 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -108,53 +108,6 @@ unlock_and_exit:
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_valid_gpe_event
- *
- * PARAMETERS:  gpe_event_info              - Info for this GPE
- *
- * RETURN:      TRUE if the gpe_event is valid
- *
- * DESCRIPTION: Validate a GPE event. DO NOT CALL FROM INTERRUPT LEVEL.
- *              Should be called only when the GPE lists are semaphore locked
- *              and not subject to change.
- *
- ******************************************************************************/
-
-u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
-{
-	struct acpi_gpe_xrupt_info *gpe_xrupt_block;
-	struct acpi_gpe_block_info *gpe_block;
-
-	ACPI_FUNCTION_ENTRY();
-
-	/* No need for spin lock since we are not changing any list elements */
-
-	/* Walk the GPE interrupt levels */
-
-	gpe_xrupt_block = acpi_gbl_gpe_xrupt_list_head;
-	while (gpe_xrupt_block) {
-		gpe_block = gpe_xrupt_block->gpe_block_list_head;
-
-		/* Walk the GPE blocks on this interrupt level */
-
-		while (gpe_block) {
-			if ((&gpe_block->event_info[0] <= gpe_event_info) &&
-			    (&gpe_block->event_info[gpe_block->gpe_count] >
-			     gpe_event_info)) {
-				return (TRUE);
-			}
-
-			gpe_block = gpe_block->next;
-		}
-
-		gpe_xrupt_block = gpe_xrupt_block->next;
-	}
-
-	return (FALSE);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ev_get_gpe_device
  *
  * PARAMETERS:  GPE_WALK_CALLBACK
@@ -167,8 +120,8 @@ u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
  ******************************************************************************/
 
 acpi_status
-acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-		       struct acpi_gpe_block_info * gpe_block, void *context)
+acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+		       struct acpi_gpe_block_info *gpe_block, void *context)
 {
 	struct acpi_gpe_device_info *info = context;
 
-- 
1.7.10
