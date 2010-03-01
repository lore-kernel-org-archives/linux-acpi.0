From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/9] ACPICA: Update for new gcc-4 warning options
Date: Mon, 01 Mar 2010 01:56:10 -0500
Message-ID: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:64815 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0CAG4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:23 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL000ESCNSX3B3@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:57:28 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added several new options for the gcc-4 generation, and updated
the source accordingly. This includes some code restructuring to
eliminate unreachable code, elimination of some gotos, elimination
of unused return values, and some additional casting.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exconfig.c  |   13 +++++--------
 drivers/acpi/acpica/hwgpe.c     |    6 ++----
 drivers/acpi/acpica/nspredef.c  |   24 +++++++++++-------------
 drivers/acpi/acpica/nsrepair2.c |   24 +++++++++---------------
 drivers/acpi/acpica/utmutex.c   |   16 +++-------------
 include/acpi/platform/acenv.h   |    4 ++--
 6 files changed, 32 insertions(+), 55 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 46adfa5..2ea8dac 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -490,7 +490,11 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 	status = acpi_tb_add_table(&table_desc, &table_index);
 	if (ACPI_FAILURE(status)) {
-		goto cleanup;
+
+		/* Delete allocated table buffer */
+
+		acpi_tb_delete_table(&table_desc);
+		return_ACPI_STATUS(status);
 	}
 
 	/*
@@ -533,13 +537,6 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 					     acpi_gbl_table_handler_context);
 	}
 
-      cleanup:
-	if (ACPI_FAILURE(status)) {
-
-		/* Delete allocated table buffer */
-
-		acpi_tb_delete_table(&table_desc);
-	}
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index c28c41b..55c4507 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -224,7 +224,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	status = acpi_hw_read(&in_byte, &gpe_register_info->status_address);
 	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
+		return (status);
 	}
 
 	if (register_bit & in_byte) {
@@ -234,9 +234,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 	/* Set return value */
 
 	(*event_status) = local_event_status;
-
-      unlock_and_exit:
-	return (status);
+	return (AE_OK);
 }
 
 /******************************************************************************
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index d34fa59..309586f 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -1000,27 +1000,25 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 
 	/* Is the object one of the expected types? */
 
-	if (!(return_btype & expected_btypes)) {
+	if (return_btype & expected_btypes) {
 
-		/* Type mismatch -- attempt repair of the returned object */
+		/* For reference objects, check that the reference type is correct */
 
-		status = acpi_ns_repair_object(data, expected_btypes,
-					       package_index,
-					       return_object_ptr);
-		if (ACPI_SUCCESS(status)) {
-			return (AE_OK);	/* Repair was successful */
+		if (return_object->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
+			status = acpi_ns_check_reference(data, return_object);
 		}
-		goto type_error_exit;
+
+		return (status);
 	}
 
-	/* For reference objects, check that the reference type is correct */
+	/* Type mismatch -- attempt repair of the returned object */
 
-	if (return_object->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
-		status = acpi_ns_check_reference(data, return_object);
+	status = acpi_ns_repair_object(data, expected_btypes,
+				       package_index, return_object_ptr);
+	if (ACPI_SUCCESS(status)) {
+		return (AE_OK);	/* Repair was successful */
 	}
 
-	return (status);
-
       type_error_exit:
 
 	/* Create a string with all expected types for this predefined object */
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index f13691c..6d69264 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -93,7 +93,7 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 			  u32 sort_index,
 			  u8 sort_direction, char *sort_key_name);
 
-static acpi_status
+static void
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction);
 
@@ -443,7 +443,6 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 	union acpi_operand_object *obj_desc;
 	u32 i;
 	u32 previous_value;
-	acpi_status status;
 
 	ACPI_FUNCTION_NAME(ns_check_sorted_list);
 
@@ -494,19 +493,15 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 
 		/*
 		 * The list must be sorted in the specified order. If we detect a
-		 * discrepancy, issue a warning and sort the entire list
+		 * discrepancy, sort the entire list.
 		 */
 		if (((sort_direction == ACPI_SORT_ASCENDING) &&
 		     (obj_desc->integer.value < previous_value)) ||
 		    ((sort_direction == ACPI_SORT_DESCENDING) &&
 		     (obj_desc->integer.value > previous_value))) {
-			status =
-			    acpi_ns_sort_list(return_object->package.elements,
-					      outer_element_count, sort_index,
-					      sort_direction);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
+			acpi_ns_sort_list(return_object->package.elements,
+					  outer_element_count, sort_index,
+					  sort_direction);
 
 			data->flags |= ACPI_OBJECT_REPAIRED;
 
@@ -615,15 +610,16 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
  *              Index               - Sort by which package element
  *              sort_direction      - Ascending or Descending sort
  *
- * RETURN:      Status
+ * RETURN:      None
  *
  * DESCRIPTION: Sort the objects that are in a package element list.
  *
- * NOTE: Assumes that all NULL elements have been removed from the package.
+ * NOTE: Assumes that all NULL elements have been removed from the package,
+ *       and that all elements have been verified to be of type Integer.
  *
  *****************************************************************************/
 
-static acpi_status
+static void
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction)
 {
@@ -652,6 +648,4 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			}
 		}
 	}
-
-	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 80bb651..1f58a88 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -50,7 +50,7 @@ ACPI_MODULE_NAME("utmutex")
 /* Local prototypes */
 static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id);
 
-static acpi_status acpi_ut_delete_mutex(acpi_mutex_handle mutex_id);
+static void acpi_ut_delete_mutex(acpi_mutex_handle mutex_id);
 
 /*******************************************************************************
  *
@@ -114,7 +114,7 @@ void acpi_ut_mutex_terminate(void)
 	/* Delete each predefined mutex object */
 
 	for (i = 0; i < ACPI_NUM_MUTEX; i++) {
-		(void)acpi_ut_delete_mutex(i);
+		acpi_ut_delete_mutex(i);
 	}
 
 	/* Delete the spinlocks */
@@ -146,10 +146,6 @@ static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id)
 
 	ACPI_FUNCTION_TRACE_U32(ut_create_mutex, mutex_id);
 
-	if (mutex_id > ACPI_MAX_MUTEX) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	if (!acpi_gbl_mutex_info[mutex_id].mutex) {
 		status =
 		    acpi_os_create_mutex(&acpi_gbl_mutex_info[mutex_id].mutex);
@@ -173,21 +169,15 @@ static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id)
  *
  ******************************************************************************/
 
-static acpi_status acpi_ut_delete_mutex(acpi_mutex_handle mutex_id)
+static void acpi_ut_delete_mutex(acpi_mutex_handle mutex_id)
 {
 
 	ACPI_FUNCTION_TRACE_U32(ut_delete_mutex, mutex_id);
 
-	if (mutex_id > ACPI_MAX_MUTEX) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	acpi_os_delete_mutex(acpi_gbl_mutex_info[mutex_id].mutex);
 
 	acpi_gbl_mutex_info[mutex_id].mutex = NULL;
 	acpi_gbl_mutex_info[mutex_id].thread_id = ACPI_MUTEX_NOT_ACQUIRED;
-
-	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index e62f10d..fa7689a 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -311,8 +311,8 @@ typedef char *va_list;
 #define ACPI_MEMCMP(s1,s2,n)    acpi_ut_memcmp((const char *)(s1), (const char *)(s2), (acpi_size)(n))
 #define ACPI_MEMCPY(d,s,n)      (void) acpi_ut_memcpy ((d), (s), (acpi_size)(n))
 #define ACPI_MEMSET(d,v,n)      (void) acpi_ut_memset ((d), (v), (acpi_size)(n))
-#define ACPI_TOUPPER            acpi_ut_to_upper
-#define ACPI_TOLOWER            acpi_ut_to_lower
+#define ACPI_TOUPPER(c)         acpi_ut_to_upper ((int) (c))
+#define ACPI_TOLOWER(c)         acpi_ut_to_lower ((int) (c))
 
 #endif				/* ACPI_USE_SYSTEM_CLIBRARY */
 
-- 
1.6.0.6

