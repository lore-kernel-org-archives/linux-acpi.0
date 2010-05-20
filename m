From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/22] ACPICA: Update comments/headers, no functional change
Date: Thu, 20 May 2010 01:18:34 -0400
Message-ID: <a7499bc84eabb200f9dc23770a46d9a31b1e763a.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64217 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab0ETFTh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:37 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P00FKBDFI3F9M@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:18:55 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Also split some long lines.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index bb2efcf..f73be97 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -85,10 +85,10 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
 		(obj_desc->mutex.prev)->mutex.next = obj_desc->mutex.next;
 
 		/*
-		 * Migrate the previous sync level associated with this mutex to the
-		 * previous mutex on the list so that it may be preserved. This handles
-		 * the case where several mutexes have been acquired at the same level,
-		 * but are not released in opposite order.
+		 * Migrate the previous sync level associated with this mutex to
+		 * the previous mutex on the list so that it may be preserved.
+		 * This handles the case where several mutexes have been acquired
+		 * at the same level, but are not released in opposite order.
 		 */
 		(obj_desc->mutex.prev)->mutex.original_sync_level =
 		    obj_desc->mutex.original_sync_level;
@@ -101,8 +101,8 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
  *
  * FUNCTION:    acpi_ex_link_mutex
  *
- * PARAMETERS:  obj_desc        - The mutex to be linked
- *              Thread          - Current executing thread object
+ * PARAMETERS:  obj_desc            - The mutex to be linked
+ *              Thread              - Current executing thread object
  *
  * RETURN:      None
  *
@@ -138,9 +138,9 @@ acpi_ex_link_mutex(union acpi_operand_object *obj_desc,
  *
  * FUNCTION:    acpi_ex_acquire_mutex_object
  *
- * PARAMETERS:  time_desc           - Timeout in milliseconds
+ * PARAMETERS:  Timeout             - Timeout in milliseconds
  *              obj_desc            - Mutex object
- *              Thread              - Current thread state
+ *              thread_id           - Current thread state
  *
  * RETURN:      Status
  *
@@ -234,7 +234,7 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Must have a valid thread ID */
+	/* Must have a valid thread state struct */
 
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
@@ -435,6 +435,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 
 		owner_thread->current_sync_level = previous_sync_level;
 	}
+
 	return_ACPI_STATUS(status);
 }
 
@@ -442,7 +443,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
  *
  * FUNCTION:    acpi_ex_release_all_mutexes
  *
- * PARAMETERS:  Thread          - Current executing thread object
+ * PARAMETERS:  Thread              - Current executing thread object
  *
  * RETURN:      Status
  *
-- 
1.6.0.6

