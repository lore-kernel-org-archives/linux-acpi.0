From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/73] ACPICA: Update comments for acquire/release mutex interfaces
Date: Sat, 12 Apr 2008 00:24:50 -0400
Message-ID: <45bbee56e1e461802ed99f884369ba7a2d0fe136.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60403 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbYDLE2A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:00 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

pdate comments for acquire/release mutex interfaces

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exmutex.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index 0bebe75..32f24a8 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -134,7 +134,16 @@ acpi_ex_link_mutex(union acpi_operand_object *obj_desc,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Acquire an AML mutex, low-level interface
+ * DESCRIPTION: Acquire an AML mutex, low-level interface. Provides a common
+ *              path that supports multiple acquires by the same thread.
+ *
+ * MUTEX:       Interpreter must be locked
+ *
+ * NOTE: This interface is called from three places:
+ * 1) From acpi_ex_acquire_mutex, via an AML Acquire() operator
+ * 2) From acpi_ex_acquire_global_lock when an AML Field access requires the
+ *    global lock
+ * 3) From the external interface, acpi_acquire_global_lock
  *
  ******************************************************************************/
 
@@ -174,7 +183,7 @@ acpi_ex_acquire_mutex_object(u16 timeout,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Have the mutex: update mutex and save the sync_level */
+	/* Acquired the mutex: update mutex object */
 
 	obj_desc->mutex.thread_id = thread_id;
 	obj_desc->mutex.acquisition_depth = 1;
@@ -211,7 +220,7 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Sanity check: we must have a valid thread ID */
+	/* Must have a valid thread ID */
 
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
@@ -221,7 +230,7 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 	}
 
 	/*
-	 * Current Sync level must be less than or equal to the sync level of the
+	 * Current sync level must be less than or equal to the sync level of the
 	 * mutex. This mechanism provides some deadlock prevention
 	 */
 	if (walk_state->thread->current_sync_level > obj_desc->mutex.sync_level) {
@@ -236,6 +245,9 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 					      obj_desc,
 					      walk_state->thread->thread_id);
 	if (ACPI_SUCCESS(status) && obj_desc->mutex.acquisition_depth == 1) {
+
+		/* Save Thread object, original/current sync levels */
+
 		obj_desc->mutex.owner_thread = walk_state->thread;
 		obj_desc->mutex.original_sync_level =
 		    walk_state->thread->current_sync_level;
@@ -259,6 +271,16 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
  * RETURN:      Status
  *
  * DESCRIPTION: Release a previously acquired Mutex, low level interface.
+ *              Provides a common path that supports multiple releases (after
+ *              previous multiple acquires) by the same thread.
+ *
+ * MUTEX:       Interpreter must be locked
+ *
+ * NOTE: This interface is called from three places:
+ * 1) From acpi_ex_release_mutex, via an AML Acquire() operator
+ * 2) From acpi_ex_release_global_lock when an AML Field access requires the
+ *    global lock
+ * 3) From the external interface, acpi_release_global_lock
  *
  ******************************************************************************/
 
@@ -294,6 +316,8 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 		acpi_os_release_mutex(obj_desc->mutex.os_mutex);
 	}
 
+	/* Clear mutex info */
+
 	obj_desc->mutex.thread_id = 0;
 	return_ACPI_STATUS(status);
 }
@@ -348,7 +372,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
-	/* Sanity check: we must have a valid thread ID */
+	/* Must have a valid thread ID */
 
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
@@ -370,7 +394,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 
 	status = acpi_ex_release_mutex_object(obj_desc);
 
-	/* Restore sync_level */
+	/* Restore the original sync_level */
 
 	walk_state->thread->current_sync_level =
 	    obj_desc->mutex.original_sync_level;
-- 
1.5.5.29.g7134

