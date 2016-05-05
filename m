From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 04/13] ACPICA: ACPI 6.0: Update _BIX support for new package element
Date: Thu,  5 May 2016 12:58:12 +0800
Message-ID: <fdc291ae85d29c5bcb9ce6e067058f4ad6013bf1.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 3451e6d49d37919c13ec2c0019a31534b0dfc0c0

One integer was added at the end of the _BIX method, and the
version number was incremented.

Link: https://github.com/acpica/acpica/commit/3451e6d4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    5 ++-
 drivers/acpi/acpica/nsprepkg.c |   86 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 4ca426b..888440b 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -129,7 +129,8 @@ enum acpi_return_package_types {
 	ACPI_PTYPE2_REV_FIXED = 9,
 	ACPI_PTYPE2_FIX_VAR = 10,
 	ACPI_PTYPE2_VAR_VAR = 11,
-	ACPI_PTYPE2_UUID_PAIR = 12
+	ACPI_PTYPE2_UUID_PAIR = 12,
+	ACPI_PTYPE_CUSTOM = 13
 };
 
 /* Support macros for users of the predefined info table */
@@ -340,7 +341,7 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 
 	{{"_BIX", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (16 Int),(4 Str) */
-	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16,
+	PACKAGE_INFO(ACPI_PTYPE_CUSTOM, ACPI_RTYPE_INTEGER, 16,
 		     ACPI_RTYPE_STRING, 4, 0),
 
 	{{"_BLT",
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index fde5a09..fbedc6e 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -62,6 +62,10 @@ acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 			       u32 count1,
 			       u8 type2, u32 count2, u32 start_index);
 
+static acpi_status
+acpi_ns_custom_package(struct acpi_evaluate_info *info,
+		       union acpi_operand_object **elements, u32 count);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_check_package
@@ -135,6 +139,11 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	 * PTYPE2 packages contain subpackages
 	 */
 	switch (package->ret_info.type) {
+	case ACPI_PTYPE_CUSTOM:
+
+		status = acpi_ns_custom_package(info, elements, count);
+		break;
+
 	case ACPI_PTYPE1_FIXED:
 		/*
 		 * The package count is fixed and there are no subpackages
@@ -626,6 +635,83 @@ package_too_small:
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ns_custom_package
+ *
+ * PARAMETERS:  info                - Method execution information block
+ *              elements            - Pointer to the package elements array
+ *              count               - Element count for the package
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check a returned package object for the correct count and
+ *              correct type of all sub-objects.
+ *
+ * NOTE: Currently used for the _BIX method only. When needed for two or more
+ * methods, probably a detect/dispatch mechanism will be required.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_custom_package(struct acpi_evaluate_info *info,
+		       union acpi_operand_object **elements, u32 count)
+{
+	u32 expected_count;
+	u32 version;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_NAME(ns_custom_package);
+
+	/* Get version number, must be Integer */
+
+	if ((*elements)->common.type != ACPI_TYPE_INTEGER) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Return Package has invalid object type for version number"));
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
+	version = (u32)(*elements)->integer.value;
+	expected_count = 21;	/* Version 1 */
+
+	if (version == 0) {
+		expected_count = 20;	/* Version 0 */
+	}
+
+	if (count < expected_count) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Return Package is too small - found %u elements, expected %u",
+				      count, expected_count));
+		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
+	} else if (count > expected_count) {
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Return Package is larger than needed - "
+				  "found %u, expected %u\n",
+				  info->full_pathname, count, expected_count));
+	}
+
+	/* Validate all elements of the returned package */
+
+	status = acpi_ns_check_package_elements(info, elements,
+						ACPI_RTYPE_INTEGER, 16,
+						ACPI_RTYPE_STRING, 4, 0);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Version 1 has a single trailing integer */
+
+	if (version > 0) {
+		status = acpi_ns_check_package_elements(info, elements + 20,
+							ACPI_RTYPE_INTEGER, 1,
+							0, 0, 20);
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ns_check_package_elements
  *
  * PARAMETERS:  info            - Method execution information block
-- 
1.7.10
