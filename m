From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/65] ACPICA: Fix allowable release order for ASL mutex objects
Date: Fri, 29 May 2009 21:42:00 -0400
Message-ID: <315c728887f198d12eb6ec7ef9d88483018c11cb.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51313 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683AbZE3Bmv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:51 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00A03ORGUKB5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:53 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The ACPI 4.0 specification has been changed to make the SyncLevel
for mutex objects more useful. When releasing a mutex, the
synclevel of the mutex must now be the same as the current sync
level. This makes more sense. This change updates the code to
match the spec.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 77a592a..2f01142 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -402,10 +402,14 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	}
 
 	/*
-	 * The sync level of the mutex must be less than or equal to the current
-	 * sync level
+	 * The sync level of the mutex must be equal to the current sync level. In
+	 * other words, the current level means that at least one mutex at that
+	 * level is currently being held. Attempting to release a mutex of a
+	 * different level can only mean that the mutex ordering rule is being
+	 * violated. This behavior is clarified in ACPI 4.0 specification.
 	 */
-	if (obj_desc->mutex.sync_level > walk_state->thread->current_sync_level) {
+	if (obj_desc->mutex.sync_level !=
+	    walk_state->thread->current_sync_level) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: mutex %d current %d",
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
@@ -423,10 +427,13 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	    walk_state->thread->acquired_mutex_list->mutex.original_sync_level;
 
 	status = acpi_ex_release_mutex_object(obj_desc);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	if (obj_desc->mutex.acquisition_depth == 0) {
 
-		/* Restore the original sync_level */
+		/* Restore the previous sync_level */
 
 		walk_state->thread->current_sync_level = previous_sync_level;
 	}
-- 
1.6.0.6

