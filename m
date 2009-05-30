From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/65] ACPICA: Fix possible warnings for ACPI_THREAD_ID on
 64-bit build
Date: Fri, 29 May 2009 21:41:50 -0400
Message-ID: <10b6575b5d84d21e2eab01df2284288e5fdf7887.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:59990 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZE3Bms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:48 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF005RQORERRK0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:51 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Warnings can be generated for printf-like statements that output
the ACPI_THREAD_ID on 64-bit builds, since this type can expand
to 64-bits depending on how it is defined. Use the %p format
specifier to allow the output to automatically expand to 64 bits.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |    9 +++++----
 drivers/acpi/acpica/utdebug.c |    8 ++++----
 drivers/acpi/acpica/utmutex.c |   26 +++++++++++++-------------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index d301c1f..d7cb030 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -373,11 +373,12 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	     walk_state->thread->thread_id)
 	    && (obj_desc != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
-			    (unsigned long)walk_state->thread->thread_id,
+			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
+			    ACPI_CAST_PTR(void, walk_state->thread->thread_id),
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (unsigned long)obj_desc->mutex.owner_thread->
-			    thread_id));
+			    ACPI_CAST_PTR(void,
+					  obj_desc->mutex.owner_thread->
+					  thread_id)));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 38821f5..527d729 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -179,9 +179,9 @@ acpi_debug_print(u32 requested_debug_level,
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %lX to TID %lX ****\n\n",
-			     (unsigned long)acpi_gbl_prev_thread_id,
-			     (unsigned long)thread_id);
+			    ("\n**** Context Switch from TID %p to TID %p ****\n\n",
+			     ACPI_CAST_PTR(void, acpi_gbl_prev_thread_id),
+			     ACPI_CAST_PTR(void, thread_id));
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
@@ -194,7 +194,7 @@ acpi_debug_print(u32 requested_debug_level,
 	acpi_os_printf("%8s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
-		acpi_os_printf("[%04lX] ", (unsigned long)thread_id);
+		acpi_os_printf("[%p] ", ACPI_CAST_PTR(void, thread_id));
 	}
 
 	acpi_os_printf("[%02ld] %-22.22s: ",
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 26c93a7..80bb651 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -230,17 +230,18 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
 				if (i == mutex_id) {
 					ACPI_ERROR((AE_INFO,
-						    "Mutex [%s] already acquired by this thread [%X]",
+						    "Mutex [%s] already acquired by this thread [%p]",
 						    acpi_ut_get_mutex_name
 						    (mutex_id),
-						    this_thread_id));
+						    ACPI_CAST_PTR(void,
+								  this_thread_id)));
 
 					return (AE_ALREADY_ACQUIRED);
 				}
 
 				ACPI_ERROR((AE_INFO,
-					    "Invalid acquire order: Thread %X owns [%s], wants [%s]",
-					    this_thread_id,
+					    "Invalid acquire order: Thread %p owns [%s], wants [%s]",
+					    ACPI_CAST_PTR(void, this_thread_id),
 					    acpi_ut_get_mutex_name(i),
 					    acpi_ut_get_mutex_name(mutex_id)));
 
@@ -251,24 +252,24 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %lX attempting to acquire Mutex [%s]\n",
-			  (unsigned long)this_thread_id,
+			  "Thread %p attempting to acquire Mutex [%s]\n",
+			  ACPI_CAST_PTR(void, this_thread_id),
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %lX acquired Mutex [%s]\n",
-				  (unsigned long)this_thread_id,
+				  "Thread %p acquired Mutex [%s]\n",
+				  ACPI_CAST_PTR(void, this_thread_id),
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %lX could not acquire Mutex [%X]",
-				(unsigned long)this_thread_id, mutex_id));
+				"Thread %p could not acquire Mutex [%X]",
+				ACPI_CAST_PTR(void, this_thread_id), mutex_id));
 	}
 
 	return (status);
@@ -293,9 +294,8 @@ acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 	ACPI_FUNCTION_NAME(ut_release_mutex);
 
 	this_thread_id = acpi_os_get_thread_id();
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %lX releasing Mutex [%s]\n",
-			  (unsigned long)this_thread_id,
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %p releasing Mutex [%s]\n",
+			  ACPI_CAST_PTR(void, this_thread_id),
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
-- 
1.6.0.6

