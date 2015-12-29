From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/42] ACPICA: exmutex: General cleanup, restructured some code
Date: Tue, 29 Dec 2015 13:54:28 +0800
Message-ID: <798cc19435f035eb4d207ce465ee76b0d38c2ffc.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c2a7d000b6be34313b1c50c8a718df16113f0f32

Should be no functional change.

Link: https://github.com/acpica/acpica/commit/c2a7d000
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   80 ++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index a97f520..843c60a 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -185,8 +185,9 @@ acpi_ex_acquire_mutex_object(u16 timeout,
 	if (obj_desc == acpi_gbl_global_lock_mutex) {
 		status = acpi_ev_acquire_global_lock(timeout);
 	} else {
-		status = acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
-						   timeout);
+		status =
+		    acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
+					      timeout);
 	}
 
 	if (ACPI_FAILURE(status)) {
@@ -243,20 +244,30 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 	}
 
 	/*
-	 * Current sync level must be less than or equal to the sync level of the
-	 * mutex. This mechanism provides some deadlock prevention
+	 * Current sync level must be less than or equal to the sync level
+	 * of the mutex. This mechanism provides some deadlock prevention.
 	 */
 	if (walk_state->thread->current_sync_level > obj_desc->mutex.sync_level) {
 		ACPI_ERROR((AE_INFO,
-			    "Cannot acquire Mutex [%4.4s], current SyncLevel is too large (%u)",
+			    "Cannot acquire Mutex [%4.4s], "
+			    "current SyncLevel is too large (%u)",
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
 			    walk_state->thread->current_sync_level));
 		return_ACPI_STATUS(AE_AML_MUTEX_ORDER);
 	}
 
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Acquiring: Mutex SyncLevel %u, Thread SyncLevel %u, "
+			  "Depth %u TID %p\n",
+			  obj_desc->mutex.sync_level,
+			  walk_state->thread->current_sync_level,
+			  obj_desc->mutex.acquisition_depth,
+			  walk_state->thread));
+
 	status = acpi_ex_acquire_mutex_object((u16)time_desc->integer.value,
 					      obj_desc,
 					      walk_state->thread->thread_id);
+
 	if (ACPI_SUCCESS(status) && obj_desc->mutex.acquisition_depth == 1) {
 
 		/* Save Thread object, original/current sync levels */
@@ -272,6 +283,12 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 		acpi_ex_link_mutex(obj_desc, walk_state->thread);
 	}
 
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Acquired: Mutex SyncLevel %u, Thread SyncLevel %u, Depth %u\n",
+			  obj_desc->mutex.sync_level,
+			  walk_state->thread->current_sync_level,
+			  obj_desc->mutex.acquisition_depth));
+
 	return_ACPI_STATUS(status);
 }
 
@@ -356,9 +373,9 @@ acpi_status
 acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		      struct acpi_walk_state *walk_state)
 {
-	acpi_status status = AE_OK;
 	u8 previous_sync_level;
 	struct acpi_thread_state *owner_thread;
+	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE(ex_release_mutex);
 
@@ -409,7 +426,8 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	 */
 	if (obj_desc->mutex.sync_level != owner_thread->current_sync_level) {
 		ACPI_ERROR((AE_INFO,
-			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: mutex %u current %u",
+			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: "
+			    "mutex %u current %u",
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
 			    obj_desc->mutex.sync_level,
 			    walk_state->thread->current_sync_level));
@@ -424,6 +442,15 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	previous_sync_level =
 	    owner_thread->acquired_mutex_list->mutex.original_sync_level;
 
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Releasing: Object SyncLevel %u, Thread SyncLevel %u, "
+			  "Prev SyncLevel %u, Depth %u TID %p\n",
+			  obj_desc->mutex.sync_level,
+			  walk_state->thread->current_sync_level,
+			  previous_sync_level,
+			  obj_desc->mutex.acquisition_depth,
+			  walk_state->thread));
+
 	status = acpi_ex_release_mutex_object(obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -436,6 +463,14 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		owner_thread->current_sync_level = previous_sync_level;
 	}
 
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Released: Object SyncLevel %u, Thread SyncLevel, %u, "
+			  "Prev SyncLevel %u, Depth %u\n",
+			  obj_desc->mutex.sync_level,
+			  walk_state->thread->current_sync_level,
+			  previous_sync_level,
+			  obj_desc->mutex.acquisition_depth));
+
 	return_ACPI_STATUS(status);
 }
 
@@ -462,21 +497,17 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 	union acpi_operand_object *next = thread->acquired_mutex_list;
 	union acpi_operand_object *obj_desc;
 
-	ACPI_FUNCTION_NAME(ex_release_all_mutexes);
+	ACPI_FUNCTION_TRACE(ex_release_all_mutexes);
 
 	/* Traverse the list of owned mutexes, releasing each one */
 
 	while (next) {
 		obj_desc = next;
-		next = obj_desc->mutex.next;
-
-		obj_desc->mutex.prev = NULL;
-		obj_desc->mutex.next = NULL;
-		obj_desc->mutex.acquisition_depth = 0;
-
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Force-releasing held mutex: %p\n",
-				  obj_desc));
+				  "Mutex [%4.4s] force-release, SyncLevel %u Depth %u\n",
+				  obj_desc->mutex.node->name.ascii,
+				  obj_desc->mutex.sync_level,
+				  obj_desc->mutex.acquisition_depth));
 
 		/* Release the mutex, special case for Global Lock */
 
@@ -489,14 +520,21 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 			acpi_os_release_mutex(obj_desc->mutex.os_mutex);
 		}
 
-		/* Mark mutex unowned */
-
-		obj_desc->mutex.owner_thread = NULL;
-		obj_desc->mutex.thread_id = 0;
-
 		/* Update Thread sync_level (Last mutex is the important one) */
 
 		thread->current_sync_level =
 		    obj_desc->mutex.original_sync_level;
+
+		/* Mark mutex unowned */
+
+		next = obj_desc->mutex.next;
+
+		obj_desc->mutex.prev = NULL;
+		obj_desc->mutex.next = NULL;
+		obj_desc->mutex.acquisition_depth = 0;
+		obj_desc->mutex.owner_thread = NULL;
+		obj_desc->mutex.thread_id = 0;
 	}
+
+	return_VOID;
 }
-- 
1.7.10
