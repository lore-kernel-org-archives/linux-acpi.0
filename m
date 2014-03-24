From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/5] ACPICA: Ignore sync_level for methods that have been auto-serialized.
Date: Mon, 24 Mar 2014 14:49:13 +0800
Message-ID: <f7153a2d2e2ef83d54c0095d99607b5aaab23d34.1395638745.git.lv.zheng@intel.com>
References: <cover.1395638745.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64124 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaCXGt0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2014 02:49:26 -0400
In-Reply-To: <cover.1395638745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Cannot use a sync_level for methods that have been serialized at load-time
or runtime because this may interfere with any existing use of sync_levels
within the ASL code. So, we simply ignore the sync_level for these methods,
thus preserving any existing sync_level priorities. Note, the use of
sync_levels is actually rather rare within BIOS ASL code.

References: http://www.spinics.net/lists/linux-acpi/msg49496.html
Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Reported-by: Sabrina Dubroka <sd@queasysnail.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acobject.h |    3 ++-
 drivers/acpi/acpica/dsmethod.c |   24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 1a4d618..22fb644 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -193,7 +193,8 @@ struct acpi_object_method {
 #define ACPI_METHOD_INTERNAL_ONLY       0x02	/* Method is implemented internally (_OSI) */
 #define ACPI_METHOD_SERIALIZED          0x04	/* Method is serialized */
 #define ACPI_METHOD_SERIALIZED_PENDING  0x08	/* Method is to be marked serialized */
-#define ACPI_METHOD_MODIFIED_NAMESPACE  0x10	/* Method modified the namespace */
+#define ACPI_METHOD_IGNORE_SYNC_LEVEL   0x10	/* Method was auto-serialized at table load time */
+#define ACPI_METHOD_MODIFIED_NAMESPACE  0x20	/* Method modified the namespace */
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 73764c7..3c7f737 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -175,8 +175,15 @@ acpi_ds_detect_named_opcodes(struct acpi_walk_state *walk_state,
 	 * At this point, we know we have a Named object opcode.
 	 * Mark the method as serialized. Later code will create a mutex for
 	 * this method to enforce serialization.
+	 *
+	 * Note, ACPI_METHOD_IGNORE_SYNC_LEVEL flag means that we will ignore the
+	 * Sync Level mechanism for this method, even though it is now serialized.
+	 * Otherwise, there can be conflicts with existing ASL code that actually
+	 * uses sync levels.
 	 */
-	walk_state->method_desc->method.info_flags |= ACPI_METHOD_SERIALIZED;
+	walk_state->method_desc->method.sync_level = 0;
+	walk_state->method_desc->method.info_flags |=
+	    (ACPI_METHOD_SERIALIZED | ACPI_METHOD_IGNORE_SYNC_LEVEL);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Method serialized [%4.4s] %p - [%s] (%4.4X)\n",
@@ -349,13 +356,19 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 		/*
 		 * The current_sync_level (per-thread) must be less than or equal to
 		 * the sync level of the method. This mechanism provides some
-		 * deadlock prevention
+		 * deadlock prevention.
+		 *
+		 * If the method was auto-serialized, we just ignore the sync level
+		 * mechanism, because auto-serialization of methods can interfere
+		 * with ASL code that actually uses sync levels.
 		 *
 		 * Top-level method invocation has no walk state at this point
 		 */
 		if (walk_state &&
-		    (walk_state->thread->current_sync_level >
-		     obj_desc->method.mutex->mutex.sync_level)) {
+		    (!(obj_desc->method.
+		       info_flags & ACPI_METHOD_IGNORE_SYNC_LEVEL))
+		    && (walk_state->thread->current_sync_level >
+			obj_desc->method.mutex->mutex.sync_level)) {
 			ACPI_ERROR((AE_INFO,
 				    "Cannot acquire Mutex for method [%4.4s], current SyncLevel is too large (%u)",
 				    acpi_ut_get_node_name(method_node),
@@ -800,7 +813,8 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 			method_desc->method.info_flags &=
 			    ~ACPI_METHOD_SERIALIZED_PENDING;
 			method_desc->method.info_flags |=
-			    ACPI_METHOD_SERIALIZED;
+			    (ACPI_METHOD_SERIALIZED |
+			     ACPI_METHOD_IGNORE_SYNC_LEVEL);
 			method_desc->method.sync_level = 0;
 		}
 
-- 
1.7.10

