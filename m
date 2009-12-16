From: Len Brown <lenb@kernel.org>
Subject: [PATCH 074/103] ACPICA: Predefined name repair: automatically remove
 null package elements
Date: Wed, 16 Dec 2009 03:36:25 -0500
Message-ID: <d4085a3ffee8828f7f1bae7fa3cf5e58f59ba627.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759409AbZLPMF4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:05:56 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:51 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change will automatically remove embedded and trailing NULL
package elements from returned package objects that are defined
to containe a variable number of sub-packages. The driver is then
presented with a package with no null elements to deal with.
ACPICA BZ 819.

http://www.acpica.org/bugzilla/show_bug.cgi?id=819

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acnamesp.h  |    5 ++
 drivers/acpi/acpica/nspredef.c  |   59 +++++++----------------------
 drivers/acpi/acpica/nsrepair2.c |   79 ++++++++++++++++++++++----------------
 3 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 14cef45..61edb15 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -296,6 +296,11 @@ acpi_ns_complex_repairs(struct acpi_predefined_data *data,
 			acpi_status validate_status,
 			union acpi_operand_object **return_object_ptr);
 
+void
+acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
+			     u8 package_type,
+			     union acpi_operand_object *obj_desc);
+
 /*
  * nssearch - Namespace searching and entry
  */
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 239fa2f..d34fa59 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -231,9 +231,6 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * Note: Package may have been newly created by call above.
 	 */
 	if ((*return_object_ptr)->common.type == ACPI_TYPE_PACKAGE) {
-
-		/* TBD: For variable-length Packages, remove NULL elements here */
-
 		status = acpi_ns_check_package(data, return_object_ptr);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
@@ -439,6 +436,13 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 			  data->pathname, package->ret_info.type,
 			  return_object->package.count));
 
+	/*
+	 * For variable-length Packages, we can safely remove all embedded
+	 * and trailing NULL package elements
+	 */
+	acpi_ns_remove_null_elements(data, package->ret_info.type,
+				     return_object);
+
 	/* Extract package count and elements array */
 
 	elements = return_object->package.elements;
@@ -692,53 +696,18 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	union acpi_operand_object *sub_package;
 	union acpi_operand_object **sub_elements;
 	acpi_status status;
-	u8 non_trailing_null = FALSE;
 	u32 expected_count;
 	u32 i;
 	u32 j;
 
-	/* Validate each sub-Package in the parent Package */
-
+	/*
+	 * Validate each sub-Package in the parent Package
+	 *
+	 * NOTE: assumes list of sub-packages contains no NULL elements.
+	 * Any NULL elements should have been removed by earlier call
+	 * to acpi_ns_remove_null_elements.
+	 */
 	for (i = 0; i < count; i++) {
-		/*
-		 * Handling for NULL package elements. For now, we will simply allow
-		 * a parent package with trailing NULL elements. This can happen if
-		 * the package was defined to be longer than the initializer list.
-		 * This is legal as per the ACPI specification. It is often used
-		 * to allow for dynamic initialization of a Package.
-		 *
-		 * A future enhancement may be to simply truncate the package to
-		 * remove the trailing NULL elements.
-		 */
-		if (!(*elements)) {
-			if (!non_trailing_null) {
-
-				/* Ensure the remaining elements are all NULL */
-
-				for (j = 1; j < (count - i + 1); j++) {
-					if (elements[j]) {
-						non_trailing_null = TRUE;
-					}
-				}
-
-				if (!non_trailing_null) {
-
-					/* Ignore the trailing NULL elements */
-
-					return (AE_OK);
-				}
-			}
-
-			/* There are trailing non-null elements, issue warning */
-
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Found NULL element at package index %u",
-					      i));
-			elements++;
-			continue;
-		}
-
 		sub_package = *elements;
 		sub_elements = sub_package->package.elements;
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index e7373eb..f13691c 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -45,6 +45,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
+#include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsrepair2")
@@ -93,9 +94,6 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 			  u8 sort_direction, char *sort_key_name);
 
 static acpi_status
-acpi_ns_remove_null_elements(union acpi_operand_object *package);
-
-static acpi_status
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction);
 
@@ -456,25 +454,10 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 	}
 
 	/*
-	 * Detect any NULL package elements and remove them from the
-	 * package.
-	 *
-	 * TBD: We may want to do this for all predefined names that
-	 * return a variable-length package of packages.
+	 * NOTE: assumes list of sub-packages contains no NULL elements.
+	 * Any NULL elements should have been removed by earlier call
+	 * to acpi_ns_remove_null_elements.
 	 */
-	status = acpi_ns_remove_null_elements(return_object);
-	if (status == AE_NULL_ENTRY) {
-		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
-				  "%s: NULL elements removed from package\n",
-				  data->pathname));
-
-		/* Exit if package is now zero length */
-
-		if (!return_object->package.count) {
-			return (AE_NULL_ENTRY);
-		}
-	}
-
 	outer_elements = return_object->package.elements;
 	outer_element_count = return_object->package.count;
 	if (!outer_element_count) {
@@ -544,36 +527,63 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_remove_null_elements
  *
- * PARAMETERS:  obj_desc            - A Package object
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              package_type        - An acpi_return_package_types value
+ *              obj_desc            - A Package object
  *
- * RETURN:      Status. AE_NULL_ENTRY means that one or more elements were
- *              removed.
+ * RETURN:      None.
  *
- * DESCRIPTION: Remove all NULL package elements and update the package count.
+ * DESCRIPTION: Remove all NULL package elements from packages that contain
+ *              a variable number of sub-packages.
  *
  *****************************************************************************/
 
-static acpi_status
-acpi_ns_remove_null_elements(union acpi_operand_object *obj_desc)
+void
+acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
+			     u8 package_type,
+			     union acpi_operand_object *obj_desc)
 {
 	union acpi_operand_object **source;
 	union acpi_operand_object **dest;
-	acpi_status status = AE_OK;
 	u32 count;
 	u32 new_count;
 	u32 i;
 
+	ACPI_FUNCTION_NAME(ns_remove_null_elements);
+
+	/*
+	 * PTYPE1 packages contain no subpackages.
+	 * PTYPE2 packages contain a variable number of sub-packages. We can
+	 * safely remove all NULL elements from the PTYPE2 packages.
+	 */
+	switch (package_type) {
+	case ACPI_PTYPE1_FIXED:
+	case ACPI_PTYPE1_VAR:
+	case ACPI_PTYPE1_OPTION:
+		return;
+
+	case ACPI_PTYPE2:
+	case ACPI_PTYPE2_COUNT:
+	case ACPI_PTYPE2_PKG_COUNT:
+	case ACPI_PTYPE2_FIXED:
+	case ACPI_PTYPE2_MIN:
+	case ACPI_PTYPE2_REV_FIXED:
+		break;
+
+	default:
+		return;
+	}
+
 	count = obj_desc->package.count;
 	new_count = count;
 
 	source = obj_desc->package.elements;
 	dest = source;
 
-	/* Examine all elements of the package object */
+	/* Examine all elements of the package object, remove nulls */
 
 	for (i = 0; i < count; i++) {
 		if (!*source) {
-			status = AE_NULL_ENTRY;
 			new_count--;
 		} else {
 			*dest = *source;
@@ -582,15 +592,18 @@ acpi_ns_remove_null_elements(union acpi_operand_object *obj_desc)
 		source++;
 	}
 
-	if (status == AE_NULL_ENTRY) {
+	/* Update parent package if any null elements were removed */
+
+	if (new_count < count) {
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Found and removed %u NULL elements\n",
+				  data->pathname, (count - new_count)));
 
 		/* NULL terminate list and update the package count */
 
 		*dest = NULL;
 		obj_desc->package.count = new_count;
 	}
-
-	return (status);
 }
 
 /******************************************************************************
-- 
1.6.0.6

