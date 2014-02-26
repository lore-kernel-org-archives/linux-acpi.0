From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/18] ACPICA: Comment update - no functional change.
Date: Wed, 26 Feb 2014 10:31:18 +0800
Message-ID: <4ea8abcd07237824cc3f0f32d35fbe548e502178.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2672 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbaBZCb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:31:28 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Change all instances of "sub-package" to "subpackage" for
consistency.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h  |    8 ++++----
 drivers/acpi/acpica/nsprepkg.c  |   40 +++++++++++++++++++--------------------
 drivers/acpi/acpica/nsrepair.c  |    4 ++--
 drivers/acpi/acpica/nsrepair2.c |   16 ++++++++--------
 drivers/acpi/acpica/rscalc.c    |    2 +-
 drivers/acpi/acpica/rscreate.c  |    4 ++--
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 393826b..c99bc04 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -50,7 +50,7 @@
  *
  * Return Package types
  *
- * 1) PTYPE1 packages do not contain sub-packages.
+ * 1) PTYPE1 packages do not contain subpackages.
  *
  * ACPI_PTYPE1_FIXED: Fixed-length length, 1 or 2 object types:
  *      object type
@@ -65,8 +65,8 @@
  *      (Used for _PRW)
  *
  *
- * 2) PTYPE2 packages contain a Variable-length number of sub-packages. Each
- *    of the different types describe the contents of each of the sub-packages.
+ * 2) PTYPE2 packages contain a Variable-length number of subpackages. Each
+ *    of the different types describe the contents of each of the subpackages.
  *
  * ACPI_PTYPE2: Each subpackage contains 1 or 2 object types. Zero-length
  *      parent package is allowed:
@@ -562,7 +562,7 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 
 	/*
 	 * For _HPX, a single package is returned, containing a variable-length number
-	 * of sub-packages. Each sub-package contains a PCI record setting.
+	 * of subpackages. Each subpackage contains a PCI record setting.
 	 * There are several different type of record settings, of different
 	 * lengths, but all elements of all settings are Integers.
 	 */
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 61faf77..68f7258 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -132,12 +132,12 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	 * Decode the type of the expected package contents
 	 *
 	 * PTYPE1 packages contain no subpackages
-	 * PTYPE2 packages contain sub-packages
+	 * PTYPE2 packages contain subpackages
 	 */
 	switch (package->ret_info.type) {
 	case ACPI_PTYPE1_FIXED:
 		/*
-		 * The package count is fixed and there are no sub-packages
+		 * The package count is fixed and there are no subpackages
 		 *
 		 * If package is too small, exit.
 		 * If package is larger than expected, issue warning but continue
@@ -169,7 +169,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 
 	case ACPI_PTYPE1_VAR:
 		/*
-		 * The package count is variable, there are no sub-packages, and all
+		 * The package count is variable, there are no subpackages, and all
 		 * elements must be of the same type
 		 */
 		for (i = 0; i < count; i++) {
@@ -185,7 +185,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 
 	case ACPI_PTYPE1_OPTION:
 		/*
-		 * The package count is variable, there are no sub-packages. There are
+		 * The package count is variable, there are no subpackages. There are
 		 * a fixed number of required elements, and a variable number of
 		 * optional elements.
 		 *
@@ -242,7 +242,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 		elements++;
 		count--;
 
-		/* Examine the sub-packages */
+		/* Examine the subpackages */
 
 		status =
 		    acpi_ns_check_package_list(info, package, elements, count);
@@ -250,7 +250,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 
 	case ACPI_PTYPE2_PKG_COUNT:
 
-		/* First element is the (Integer) count of sub-packages to follow */
+		/* First element is the (Integer) count of subpackages to follow */
 
 		status = acpi_ns_check_object_type(info, elements,
 						   ACPI_RTYPE_INTEGER, 0);
@@ -270,7 +270,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 		count = expected_count;
 		elements++;
 
-		/* Examine the sub-packages */
+		/* Examine the subpackages */
 
 		status =
 		    acpi_ns_check_package_list(info, package, elements, count);
@@ -283,9 +283,9 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	case ACPI_PTYPE2_FIX_VAR:
 		/*
 		 * These types all return a single Package that consists of a
-		 * variable number of sub-Packages.
+		 * variable number of subpackages.
 		 *
-		 * First, ensure that the first element is a sub-Package. If not,
+		 * First, ensure that the first element is a subpackage. If not,
 		 * the BIOS may have incorrectly returned the object as a single
 		 * package instead of a Package of Packages (a common error if
 		 * there is only one entry). We may be able to repair this by
@@ -310,7 +310,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 			count = 1;
 		}
 
-		/* Examine the sub-packages */
+		/* Examine the subpackages */
 
 		status =
 		    acpi_ns_check_package_list(info, package, elements, count);
@@ -370,9 +370,9 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 	u32 j;
 
 	/*
-	 * Validate each sub-Package in the parent Package
+	 * Validate each subpackage in the parent Package
 	 *
-	 * NOTE: assumes list of sub-packages contains no NULL elements.
+	 * NOTE: assumes list of subpackages contains no NULL elements.
 	 * Any NULL elements should have been removed by earlier call
 	 * to acpi_ns_remove_null_elements.
 	 */
@@ -389,7 +389,7 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 			return (status);
 		}
 
-		/* Examine the different types of expected sub-packages */
+		/* Examine the different types of expected subpackages */
 
 		info->parent_package = sub_package;
 		switch (package->ret_info.type) {
@@ -450,14 +450,14 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 
 		case ACPI_PTYPE2_FIXED:
 
-			/* Each sub-package has a fixed length */
+			/* Each subpackage has a fixed length */
 
 			expected_count = package->ret_info2.count;
 			if (sub_package->package.count < expected_count) {
 				goto package_too_small;
 			}
 
-			/* Check the type of each sub-package element */
+			/* Check the type of each subpackage element */
 
 			for (j = 0; j < expected_count; j++) {
 				status =
@@ -475,14 +475,14 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 
 		case ACPI_PTYPE2_MIN:
 
-			/* Each sub-package has a variable but minimum length */
+			/* Each subpackage has a variable but minimum length */
 
 			expected_count = package->ret_info.count1;
 			if (sub_package->package.count < expected_count) {
 				goto package_too_small;
 			}
 
-			/* Check the type of each sub-package element */
+			/* Check the type of each subpackage element */
 
 			status =
 			    acpi_ns_check_package_elements(info, sub_elements,
@@ -531,7 +531,7 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 				(*sub_elements)->integer.value = expected_count;
 			}
 
-			/* Check the type of each sub-package element */
+			/* Check the type of each subpackage element */
 
 			status =
 			    acpi_ns_check_package_elements(info,
@@ -557,10 +557,10 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 
 package_too_small:
 
-	/* The sub-package count was smaller than required */
+	/* The subpackage count was smaller than required */
 
 	ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname, info->node_flags,
-			      "Return Sub-Package[%u] is too small - found %u elements, expected %u",
+			      "Return SubPackage[%u] is too small - found %u elements, expected %u",
 			      i, sub_package->package.count, expected_count));
 
 	return (AE_AML_OPERAND_VALUE);
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 21b6402..7e417aa 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -465,7 +465,7 @@ acpi_ns_repair_null_element(struct acpi_evaluate_info * info,
  * RETURN:      None.
  *
  * DESCRIPTION: Remove all NULL package elements from packages that contain
- *              a variable number of sub-packages. For these types of
+ *              a variable number of subpackages. For these types of
  *              packages, NULL elements can be safely removed.
  *
  *****************************************************************************/
@@ -486,7 +486,7 @@ acpi_ns_remove_null_elements(struct acpi_evaluate_info *info,
 	/*
 	 * We can safely remove all NULL elements from these package types:
 	 * PTYPE1_VAR packages contain a variable number of simple data types.
-	 * PTYPE2 packages contain a variable number of sub-packages.
+	 * PTYPE2 packages contain a variable number of subpackages.
 	 */
 	switch (package_type) {
 	case ACPI_PTYPE1_VAR:
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1801214..b09e6be 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -432,8 +432,8 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
  * DESCRIPTION: Repair for the _CST object:
  *              1. Sort the list ascending by C state type
  *              2. Ensure type cannot be zero
- *              3. A sub-package count of zero means _CST is meaningless
- *              4. Count must match the number of C state sub-packages
+ *              3. A subpackage count of zero means _CST is meaningless
+ *              4. Count must match the number of C state subpackages
  *
  *****************************************************************************/
 
@@ -686,7 +686,7 @@ acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 	u32 i;
 
 	/*
-	 * Entries (sub-packages) in the _PSS Package must be sorted by power
+	 * Entries (subpackages) in the _PSS Package must be sorted by power
 	 * dissipation, in descending order. If it appears that the list is
 	 * incorrectly sorted, sort it. We sort by cpu_frequency, since this
 	 * should be proportional to the power.
@@ -774,9 +774,9 @@ acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
  *
  * PARAMETERS:  info                - Method execution information block
  *              return_object       - Pointer to the top-level returned object
- *              start_index         - Index of the first sub-package
- *              expected_count      - Minimum length of each sub-package
- *              sort_index          - Sub-package entry to sort on
+ *              start_index         - Index of the first subpackage
+ *              expected_count      - Minimum length of each subpackage
+ *              sort_index          - Subpackage entry to sort on
  *              sort_direction      - Ascending or descending
  *              sort_key_name       - Name of the sort_index field
  *
@@ -812,7 +812,7 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 	}
 
 	/*
-	 * NOTE: assumes list of sub-packages contains no NULL elements.
+	 * NOTE: assumes list of subpackages contains no NULL elements.
 	 * Any NULL elements should have been removed by earlier call
 	 * to acpi_ns_remove_null_elements.
 	 */
@@ -839,7 +839,7 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 			return (AE_AML_OPERAND_TYPE);
 		}
 
-		/* Each sub-package must have the minimum length */
+		/* Each subpackage must have the minimum length */
 
 		if ((*outer_elements)->package.count < expected_count) {
 			return (AE_AML_PACKAGE_LIMIT);
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index ae9a9cf..6895567 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -636,7 +636,7 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 
 	for (index = 0; index < number_of_elements; index++) {
 
-		/* Dereference the sub-package */
+		/* Dereference the subpackage */
 
 		package_element = *top_object_list;
 
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index f4cd6ca..75d3690 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -273,7 +273,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		 */
 		user_prt->length = (sizeof(struct acpi_pci_routing_table) - 4);
 
-		/* Each sub-package must be of length 4 */
+		/* Each subpackage must be of length 4 */
 
 		if ((*top_object_list)->package.count != 4) {
 			ACPI_ERROR((AE_INFO,
@@ -283,7 +283,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		}
 
 		/*
-		 * Dereference the sub-package.
+		 * Dereference the subpackage.
 		 * The sub_object_list will now point to an array of the four IRQ
 		 * elements: [Address, Pin, Source, source_index]
 		 */
-- 
1.7.10

