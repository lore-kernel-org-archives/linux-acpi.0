From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/73] ACPICA: Misc fixes for recent global lock code update
Date: Sat, 12 Apr 2008 00:24:53 -0400
Message-ID: <9b286fa8c80995cb7f81b0a5b8874eb18ec2ead1.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45175 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752764AbYDLE2D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:03 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes as a result of running full validation test suite.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evxface.c   |    2 +-
 drivers/acpi/executer/exfield.c |    8 ++++----
 drivers/acpi/executer/exmutex.c |   23 ++++++++++++++++++-----
 drivers/acpi/executer/exutils.c |   11 +++++++++--
 include/acpi/acinterp.h         |    2 +-
 5 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index dbf34a5..e210aa2 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -816,7 +816,7 @@ acpi_status acpi_release_global_lock(u32 handle)
 {
 	acpi_status status;
 
-	if (handle != acpi_gbl_global_lock_handle) {
+	if (!handle || (handle != acpi_gbl_global_lock_handle)) {
 		return (AE_NOT_ACQUIRED);
 	}
 
diff --git a/drivers/acpi/executer/exfield.c b/drivers/acpi/executer/exfield.c
index e66b367..da772cb 100644
--- a/drivers/acpi/executer/exfield.c
+++ b/drivers/acpi/executer/exfield.c
@@ -122,7 +122,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 							     buffer.pointer),
 					       ACPI_READ | (obj_desc->field.
 							    attribute << 16));
-		acpi_ex_release_global_lock();
+		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 		goto exit;
 	}
 
@@ -177,7 +177,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	/* Read from the field */
 
 	status = acpi_ex_extract_from_field(obj_desc, buffer, (u32) length);
-	acpi_ex_release_global_lock();
+	acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
       exit:
 	if (ACPI_FAILURE(status)) {
@@ -284,7 +284,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 					       (acpi_integer *) buffer,
 					       ACPI_WRITE | (obj_desc->field.
 							     attribute << 16));
-		acpi_ex_release_global_lock();
+		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
 		*result_desc = buffer_desc;
 		return_ACPI_STATUS(status);
@@ -364,7 +364,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 	/* Write to the field */
 
 	status = acpi_ex_insert_into_field(obj_desc, buffer, length);
-	acpi_ex_release_global_lock();
+	acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
 	/* Free temporary buffer if we used one */
 
diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index 32f24a8..b8d035c 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -156,6 +156,10 @@ acpi_ex_acquire_mutex_object(u16 timeout,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_acquire_mutex_object, obj_desc);
 
+	if (!obj_desc) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
 	/* Support for multiple acquires by the owning thread */
 
 	if (obj_desc->mutex.thread_id == thread_id) {
@@ -290,6 +294,10 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 
 	ACPI_FUNCTION_TRACE(ex_release_mutex_object);
 
+	if (obj_desc->mutex.acquisition_depth == 0) {
+		return (AE_NOT_ACQUIRED);
+	}
+
 	/* Match multiple Acquires with multiple Releases */
 
 	obj_desc->mutex.acquisition_depth--;
@@ -387,17 +395,22 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	 */
 	if (obj_desc->mutex.sync_level > walk_state->thread->current_sync_level) {
 		ACPI_ERROR((AE_INFO,
-			    "Cannot release Mutex [%4.4s], incorrect SyncLevel",
-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
+			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: mutex %d current %d",
+			    acpi_ut_get_node_name(obj_desc->mutex.node),
+			    obj_desc->mutex.sync_level,
+			    walk_state->thread->current_sync_level));
 		return_ACPI_STATUS(AE_AML_MUTEX_ORDER);
 	}
 
 	status = acpi_ex_release_mutex_object(obj_desc);
 
-	/* Restore the original sync_level */
+	if (obj_desc->mutex.acquisition_depth == 0) {
+
+		/* Restore the original sync_level */
 
-	walk_state->thread->current_sync_level =
-	    obj_desc->mutex.original_sync_level;
+		walk_state->thread->current_sync_level =
+		    obj_desc->mutex.original_sync_level;
+	}
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/executer/exutils.c
index c40b191..fd543ee 100644
--- a/drivers/acpi/executer/exutils.c
+++ b/drivers/acpi/executer/exutils.c
@@ -278,7 +278,8 @@ void acpi_ex_acquire_global_lock(u32 field_flags)
  *
  * FUNCTION:    acpi_ex_release_global_lock
  *
- * PARAMETERS:  None
+ * PARAMETERS:  field_flags           - Flags with Lock rule:
+ *                                      always_lock or never_lock
  *
  * RETURN:      None
  *
@@ -286,12 +287,18 @@ void acpi_ex_acquire_global_lock(u32 field_flags)
  *
  ******************************************************************************/
 
-void acpi_ex_release_global_lock(void)
+void acpi_ex_release_global_lock(u32 field_flags)
 {
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_release_global_lock);
 
+	/* Only use the lock if the always_lock bit is set */
+
+	if (!(field_flags & AML_FIELD_LOCK_RULE_MASK)) {
+		return_VOID;
+	}
+
 	/* Release the global lock */
 
 	status = acpi_ex_release_mutex_object(acpi_gbl_global_lock_mutex);
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index 2386388..92eb014 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -464,7 +464,7 @@ void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
 
 void acpi_ex_acquire_global_lock(u32 rule);
 
-void acpi_ex_release_global_lock(void);
+void acpi_ex_release_global_lock(u32 rule);
 
 void acpi_ex_eisa_id_to_string(u32 numeric_id, char *out_string);
 
-- 
1.5.5.29.g7134

