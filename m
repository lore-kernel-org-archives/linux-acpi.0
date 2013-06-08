From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined name
Date: Sat,  8 Jun 2013 09:01:07 +0800
Message-ID: <b2c18e07f4c9e59179c273d051924417053cd774.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56309 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445Ab3FHBBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:01:30 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

Sort list based on the C-state, remove invalid/zero entries.
ACPICA BZ 890. Lv Zheng.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=890
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nspredef.c  |    5 +-
 drivers/acpi/acpica/nsrepair2.c |  170 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 163 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 8d59ac2..24b71a0 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -159,9 +159,10 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 		status = acpi_ns_check_package(info, return_object_ptr);
 		if (ACPI_FAILURE(status)) {
 
-			/* We might be able to fix an operand type error (_PRT) */
+			/* We might be able to fix some errors */
 
-			if (status != AE_AML_OPERAND_TYPE) {
+			if ((status != AE_AML_OPERAND_TYPE) &&
+			    (status != AE_AML_OPERAND_VALUE)) {
 				goto exit;
 			}
 		}
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index aca9bdf..029816e 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -79,6 +79,10 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_CST(struct acpi_evaluate_info *info,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_FDE(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
@@ -101,19 +105,23 @@ acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
 static acpi_status
 acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 			  union acpi_operand_object *return_object,
+			  u32 start_index,
 			  u32 expected_count,
 			  u32 sort_index,
 			  u8 sort_direction, char *sort_key_name);
 
-static void
-acpi_ns_sort_list(union acpi_operand_object **elements,
-		  u32 count, u32 index, u8 sort_direction);
-
 /* Values for sort_direction above */
 
 #define ACPI_SORT_ASCENDING     0
 #define ACPI_SORT_DESCENDING    1
 
+static void
+acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index);
+
+static void
+acpi_ns_sort_list(union acpi_operand_object **elements,
+		  u32 count, u32 index, u8 sort_direction);
+
 /*
  * This table contains the names of the predefined methods for which we can
  * perform more complex repairs.
@@ -122,6 +130,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  *
  * _ALR: Sort the list ascending by ambient_illuminance
  * _CID: Strings: uppercase all, remove any leading asterisk
+ * _CST: Sort the list ascending by C state type
  * _FDE: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _HID: Strings: uppercase all, remove any leading asterisk
@@ -139,6 +148,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_ALR", acpi_ns_repair_ALR},
 	{"_CID", acpi_ns_repair_CID},
+	{"_CST", acpi_ns_repair_CST},
 	{"_FDE", acpi_ns_repair_FDE},
 	{"_GTM", acpi_ns_repair_FDE},	/* _GTM has same repair as _FDE */
 	{"_HID", acpi_ns_repair_HID},
@@ -243,7 +253,7 @@ acpi_ns_repair_ALR(struct acpi_evaluate_info *info,
 	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status;
 
-	status = acpi_ns_check_sorted_list(info, return_object, 2, 1,
+	status = acpi_ns_check_sorted_list(info, return_object, 0, 2, 1,
 					   ACPI_SORT_ASCENDING,
 					   "AmbientIlluminance");
 
@@ -411,6 +421,92 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_ns_repair_CST
+ *
+ * PARAMETERS:  info                - Method execution information block
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _CST object:
+ *              1. Sort the list ascending by C state type
+ *              2. Ensure type cannot be zero
+ *              3. A sub-package count of zero means _CST is meaningless
+ *              4. Count must match the number of C state sub-packages
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_CST(struct acpi_evaluate_info *info,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object **outer_elements;
+	u32 outer_element_count;
+	union acpi_operand_object *obj_desc;
+	acpi_status status;
+	u8 removing;
+	u32 i;
+
+	ACPI_FUNCTION_NAME(ns_repair_CST);
+
+	/*
+	 * Entries (subpackages) in the _CST Package must be sorted by the
+	 * C-state type, in ascending order.
+	 */
+	status = acpi_ns_check_sorted_list(info, return_object, 1, 4, 1,
+					   ACPI_SORT_ASCENDING, "C-State Type");
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/*
+	 * We now know the list is correctly sorted by C-state type. Check if
+	 * the C-state type values are proportional.
+	 */
+	outer_element_count = return_object->package.count - 1;
+	i = 0;
+	while (i < outer_element_count) {
+		outer_elements = &return_object->package.elements[i + 1];
+		removing = FALSE;
+
+		if ((*outer_elements)->package.count == 0) {
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      info->node_flags,
+					      "SubPackage[%u] - removing entry due to zero count",
+					      i));
+			removing = TRUE;
+			goto remove_element;
+		}
+
+		obj_desc = (*outer_elements)->package.elements[1];	/* Index1 = Type */
+		if ((u32)obj_desc->integer.value == 0) {
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      info->node_flags,
+					      "SubPackage[%u] - removing entry due to invalid Type(0)",
+					      i));
+			removing = TRUE;
+		}
+
+	      remove_element:
+		if (removing) {
+			acpi_ns_remove_element(return_object, i + 1);
+			outer_element_count--;
+		} else {
+			i++;
+		}
+	}
+
+	/* Update top-level package count, Type "Integer" checked elsewhere */
+
+	obj_desc = return_object->package.elements[0];
+	obj_desc->integer.value = outer_element_count;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_ns_repair_HID
  *
  * PARAMETERS:  info                - Method execution information block
@@ -588,7 +684,7 @@ acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 	 * incorrectly sorted, sort it. We sort by cpu_frequency, since this
 	 * should be proportional to the power.
 	 */
-	status = acpi_ns_check_sorted_list(info, return_object, 6, 0,
+	status = acpi_ns_check_sorted_list(info, return_object, 0, 6, 0,
 					   ACPI_SORT_DESCENDING,
 					   "CpuFrequency");
 	if (ACPI_FAILURE(status)) {
@@ -658,7 +754,7 @@ acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
 		return (AE_OK);
 	}
 
-	status = acpi_ns_check_sorted_list(info, return_object, 5, 1,
+	status = acpi_ns_check_sorted_list(info, return_object, 0, 5, 1,
 					   ACPI_SORT_DESCENDING,
 					   "PowerDissipation");
 
@@ -671,6 +767,7 @@ acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
  *
  * PARAMETERS:  info                - Method execution information block
  *              return_object       - Pointer to the top-level returned object
+ *              start_index         - Index of the first sub-package
  *              expected_count      - Minimum length of each sub-package
  *              sort_index          - Sub-package entry to sort on
  *              sort_direction      - Ascending or descending
@@ -687,6 +784,7 @@ acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
 static acpi_status
 acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 			  union acpi_operand_object *return_object,
+			  u32 start_index,
 			  u32 expected_count,
 			  u32 sort_index,
 			  u8 sort_direction, char *sort_key_name)
@@ -711,12 +809,14 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 	 * Any NULL elements should have been removed by earlier call
 	 * to acpi_ns_remove_null_elements.
 	 */
-	outer_elements = return_object->package.elements;
 	outer_element_count = return_object->package.count;
-	if (!outer_element_count) {
+	if (!outer_element_count || start_index >= outer_element_count) {
 		return (AE_AML_PACKAGE_LIMIT);
 	}
 
+	outer_elements = &return_object->package.elements[start_index];
+	outer_element_count -= start_index;
+
 	previous_value = 0;
 	if (sort_direction == ACPI_SORT_DESCENDING) {
 		previous_value = ACPI_UINT32_MAX;
@@ -753,7 +853,8 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 		     (obj_desc->integer.value < previous_value)) ||
 		    ((sort_direction == ACPI_SORT_DESCENDING) &&
 		     (obj_desc->integer.value > previous_value))) {
-			acpi_ns_sort_list(return_object->package.elements,
+			acpi_ns_sort_list(&return_object->package.
+					  elements[start_index],
 					  outer_element_count, sort_index,
 					  sort_direction);
 
@@ -820,3 +921,52 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 		}
 	}
 }
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_remove_element
+ *
+ * PARAMETERS:  obj_desc            - Package object element list
+ *              index               - Index of element to remove
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Remove the requested element of a package and delete it.
+ *
+ *****************************************************************************/
+
+static void
+acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index)
+{
+	union acpi_operand_object **source;
+	union acpi_operand_object **dest;
+	u32 count;
+	u32 new_count;
+	u32 i;
+
+	ACPI_FUNCTION_NAME(ns_remove_element);
+
+	count = obj_desc->package.count;
+	new_count = count - 1;
+
+	source = obj_desc->package.elements;
+	dest = source;
+
+	/* Examine all elements of the package object, remove matched index */
+
+	for (i = 0; i < count; i++) {
+		if (i == index) {
+			acpi_ut_remove_reference(*source);	/* Remove one ref for being in pkg */
+			acpi_ut_remove_reference(*source);
+		} else {
+			*dest = *source;
+			dest++;
+		}
+		source++;
+	}
+
+	/* NULL terminate list and update the package count */
+
+	*dest = NULL;
+	obj_desc->package.count = new_count;
+}
-- 
1.7.10

