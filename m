From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/65] ACPICA: Mutex support: Fix release ordering issue and
 current sync level
Date: Fri, 29 May 2009 21:41:59 -0400
Message-ID: <10a3b461a258f52b17fb8e35edf3625726eca9a8.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45536 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbZE3Bmu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:50 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF0053TORG2B32@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:52 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes a problem where if multiple mutexes of the same sync level
are acquired but then not released in strict opposite order, the
current sync level becomes confused and can cause errors.
ACPICA BZ 471.

http://acpica.org/bugzilla/show_bug.cgi?id=471

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index d7cb030..77a592a 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -83,6 +83,15 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
 
 	if (obj_desc->mutex.prev) {
 		(obj_desc->mutex.prev)->mutex.next = obj_desc->mutex.next;
+
+		/*
+		 * Migrate the previous sync level associated with this mutex to the
+		 * previous mutex on the list so that it may be preserved. This handles
+		 * the case where several mutexes have been acquired at the same level,
+		 * but are not released in opposite order.
+		 */
+		(obj_desc->mutex.prev)->mutex.original_sync_level =
+		    obj_desc->mutex.original_sync_level;
 	} else {
 		thread->acquired_mutex_list = obj_desc->mutex.next;
 	}
@@ -349,6 +358,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		      struct acpi_walk_state *walk_state)
 {
 	acpi_status status = AE_OK;
+	u8 previous_sync_level;
 
 	ACPI_FUNCTION_TRACE(ex_release_mutex);
 
@@ -404,14 +414,21 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_ORDER);
 	}
 
+	/*
+	 * Get the previous sync_level from the head of the acquired mutex list.
+	 * This handles the case where several mutexes at the same level have been
+	 * acquired, but are not released in reverse order.
+	 */
+	previous_sync_level =
+	    walk_state->thread->acquired_mutex_list->mutex.original_sync_level;
+
 	status = acpi_ex_release_mutex_object(obj_desc);
 
 	if (obj_desc->mutex.acquisition_depth == 0) {
 
 		/* Restore the original sync_level */
 
-		walk_state->thread->current_sync_level =
-		    obj_desc->mutex.original_sync_level;
+		walk_state->thread->current_sync_level = previous_sync_level;
 	}
 	return_ACPI_STATUS(status);
 }
-- 
1.6.0.6

