From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/22] ACPICA: Fix for possible fault in acpi_ex_release_mutex
Date: Thu, 20 May 2010 01:18:32 -0400
Message-ID: <e0f40281d52161dddeb1bc12879425266a53f26f.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64217 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0ETFTh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:37 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P00FK8DFH3F9M@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:18:54 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fixed a problem with the AML Mutex handling function
acpi_ex_release_mutex where the function could fault under the very
rare condition when the interpreter has blocked, the interpreter
lock is released, the interpreter is then reentered via the
same thread, and attempts to acquire a mutex that was previously
acquired. FreeBSD report 140979.

http://www.freebsd.org/cgi/query-pr.cgi?pr=140979

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 2b0d722..bb2efcf 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -359,6 +359,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 {
 	acpi_status status = AE_OK;
 	u8 previous_sync_level;
+	struct acpi_thread_state *owner_thread;
 
 	ACPI_FUNCTION_TRACE(ex_release_mutex);
 
@@ -366,9 +367,11 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	owner_thread = obj_desc->mutex.owner_thread;
+
 	/* The mutex must have been previously acquired in order to release it */
 
-	if (!obj_desc->mutex.owner_thread) {
+	if (!owner_thread) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], not acquired",
 			    acpi_ut_get_node_name(obj_desc->mutex.node)));
@@ -387,16 +390,13 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	 * The Mutex is owned, but this thread must be the owner.
 	 * Special case for Global Lock, any thread can release
 	 */
-	if ((obj_desc->mutex.owner_thread->thread_id !=
-	     walk_state->thread->thread_id)
-	    && (obj_desc != acpi_gbl_global_lock_mutex)) {
+	if ((owner_thread->thread_id != walk_state->thread->thread_id) &&
+	    (obj_desc != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
 			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
 			    ACPI_CAST_PTR(void, walk_state->thread->thread_id),
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    ACPI_CAST_PTR(void,
-					  obj_desc->mutex.owner_thread->
-					  thread_id)));
+			    ACPI_CAST_PTR(void, owner_thread->thread_id)));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
@@ -407,8 +407,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	 * different level can only mean that the mutex ordering rule is being
 	 * violated. This behavior is clarified in ACPI 4.0 specification.
 	 */
-	if (obj_desc->mutex.sync_level !=
-	    walk_state->thread->current_sync_level) {
+	if (obj_desc->mutex.sync_level != owner_thread->current_sync_level) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: mutex %u current %u",
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
@@ -423,7 +422,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	 * acquired, but are not released in reverse order.
 	 */
 	previous_sync_level =
-	    walk_state->thread->acquired_mutex_list->mutex.original_sync_level;
+	    owner_thread->acquired_mutex_list->mutex.original_sync_level;
 
 	status = acpi_ex_release_mutex_object(obj_desc);
 	if (ACPI_FAILURE(status)) {
@@ -434,7 +433,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 
 		/* Restore the previous sync_level */
 
-		walk_state->thread->current_sync_level = previous_sync_level;
+		owner_thread->current_sync_level = previous_sync_level;
 	}
 	return_ACPI_STATUS(status);
 }
-- 
1.6.0.6

