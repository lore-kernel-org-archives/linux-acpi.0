From: Len Brown <lenb@kernel.org>
Subject: [PATCH 070/103] ACPICA: Remove messages if predefined repair(s) are
 successful
Date: Wed, 16 Dec 2009 03:36:21 -0500
Message-ID: <3a58176e4fa47d8232e04131b023f3f2ecd7084b.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760671AbZLPMFv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:05:51 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:50 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Repair mechanism was considered too wordy. Now, messages are only
unconditionally emitted if the return object cannot be repaired.
Existing messages for successful repairs were converted to
ACPI_DEBUG_PRINT messages for now. ACPICA BZ 827.

http://www.acpica.org/bugzilla/show_bug.cgi?id=827

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c  |   10 +++++-----
 drivers/acpi/acpica/nsrepair.c  |   32 ++++++++++++++++++--------------
 drivers/acpi/acpica/nsrepair2.c |   21 +++++++++++++--------
 include/acpi/acoutput.h         |    8 +++++---
 4 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index c6297f5..e352467 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -462,11 +462,11 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		if (count < expected_count) {
 			goto package_too_small;
 		} else if (count > expected_count) {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Return Package is larger than needed - "
-					      "found %u, expected %u", count,
-					      expected_count));
+			ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+					  "%s: Return Package is larger than needed - "
+					  "found %u, expected %u\n",
+					  data->pathname, count,
+					  expected_count));
 		}
 
 		/* Validate all elements of the returned package */
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 062a016..907f60c 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -118,6 +118,8 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	union acpi_operand_object *new_object;
 	acpi_status status;
 
+	ACPI_FUNCTION_NAME(ns_repair_object);
+
 	/*
 	 * At this point, we know that the type of the returned object was not
 	 * one of the expected types for this predefined name. Attempt to
@@ -171,19 +173,18 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 			return_object->common.reference_count--;
 		}
 
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "Converted %s to expected %s at index %u",
-				      acpi_ut_get_object_type_name
-				      (return_object),
-				      acpi_ut_get_object_type_name(new_object),
-				      package_index));
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Converted %s to expected %s at index %u\n",
+				  data->pathname,
+				  acpi_ut_get_object_type_name(return_object),
+				  acpi_ut_get_object_type_name(new_object),
+				  package_index));
 	} else {
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "Converted %s to expected %s",
-				      acpi_ut_get_object_type_name
-				      (return_object),
-				      acpi_ut_get_object_type_name
-				      (new_object)));
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Converted %s to expected %s\n",
+				  data->pathname,
+				  acpi_ut_get_object_type_name(return_object),
+				  acpi_ut_get_object_type_name(new_object)));
 	}
 
 	/* Delete old object, install the new return object */
@@ -528,6 +529,8 @@ acpi_ns_repair_package_list(struct acpi_predefined_data *data,
 {
 	union acpi_operand_object *pkg_obj_desc;
 
+	ACPI_FUNCTION_NAME(ns_repair_package_list);
+
 	/*
 	 * Create the new outer package and populate it. The new package will
 	 * have a single element, the lone subpackage.
@@ -544,8 +547,9 @@ acpi_ns_repair_package_list(struct acpi_predefined_data *data,
 	*obj_desc_ptr = pkg_obj_desc;
 	data->flags |= ACPI_OBJECT_REPAIRED;
 
-	ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-			      "Repaired Incorrectly formed Package"));
+	ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+			  "%s: Repaired incorrectly formed Package\n",
+			  data->pathname));
 
 	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 846df70..1993338 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -255,6 +255,8 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 	u32 *dword_buffer;
 	u32 i;
 
+	ACPI_FUNCTION_NAME(ns_repair_FDE);
+
 	switch (return_object->common.type) {
 	case ACPI_TYPE_BUFFER:
 
@@ -296,8 +298,9 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 			byte_buffer++;
 		}
 
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "Expanded Byte Buffer to expected DWord Buffer"));
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s Expanded Byte Buffer to expected DWord Buffer\n",
+				  data->pathname));
 		break;
 
 	default:
@@ -445,6 +448,8 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 	u32 previous_value;
 	acpi_status status;
 
+	ACPI_FUNCTION_NAME(ns_check_sorted_list);
+
 	/* The top-level object must be a package */
 
 	if (return_object->common.type != ACPI_TYPE_PACKAGE) {
@@ -460,8 +465,9 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 	 */
 	status = acpi_ns_remove_null_elements(return_object);
 	if (status == AE_NULL_ENTRY) {
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "NULL elements removed from package"));
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: NULL elements removed from package\n",
+				  data->pathname));
 
 		/* Exit if package is now zero length */
 
@@ -522,10 +528,9 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 
 			data->flags |= ACPI_OBJECT_REPAIRED;
 
-			ACPI_INFO_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Repaired unsorted list - now sorted by %s",
-					      sort_key_name));
+			ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+					  "%s: Repaired unsorted list - now sorted by %s\n",
+					  data->pathname, sort_key_name));
 			return (AE_OK);
 		}
 
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 5c823d5..d814da4 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -85,7 +85,8 @@
 #define ACPI_LV_INIT                0x00000001
 #define ACPI_LV_DEBUG_OBJECT        0x00000002
 #define ACPI_LV_INFO                0x00000004
-#define ACPI_LV_ALL_EXCEPTIONS      0x00000007
+#define ACPI_LV_REPAIR              0x00000008
+#define ACPI_LV_ALL_EXCEPTIONS      0x0000000F
 
 /* Trace verbosity level 1 [Standard Trace Level] */
 
@@ -143,6 +144,7 @@
 #define ACPI_DB_INIT                ACPI_DEBUG_LEVEL (ACPI_LV_INIT)
 #define ACPI_DB_DEBUG_OBJECT        ACPI_DEBUG_LEVEL (ACPI_LV_DEBUG_OBJECT)
 #define ACPI_DB_INFO                ACPI_DEBUG_LEVEL (ACPI_LV_INFO)
+#define ACPI_DB_REPAIR              ACPI_DEBUG_LEVEL (ACPI_LV_REPAIR)
 #define ACPI_DB_ALL_EXCEPTIONS      ACPI_DEBUG_LEVEL (ACPI_LV_ALL_EXCEPTIONS)
 
 /* Trace level -- also used in the global "DebugLevel" */
@@ -174,8 +176,8 @@
 
 /* Defaults for debug_level, debug and normal */
 
-#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INFO)
-#define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
+#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INFO | ACPI_LV_REPAIR)
+#define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT | ACPI_LV_REPAIR)
 #define ACPI_DEBUG_ALL              (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
 
 #if defined (ACPI_DEBUG_OUTPUT) || !defined (ACPI_NO_ERROR_MESSAGES)
-- 
1.6.0.6

