From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/16] ACPICA: Move _PRT repair into the standard complex repair module
Date: Sat,  8 Jun 2013 09:01:01 +0800
Message-ID: <f2c59ef61be4cf02903c633ad38592121db86419.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab3FHBBT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:01:19 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

Moved this longstanding repair to the relatively new predefined
name repair module. ACPICA BZ 783. Lv Zheng.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=783
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nspredef.c  |    7 ++-
 drivers/acpi/acpica/nsrepair2.c |  114 ++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/rscalc.c    |    5 +-
 drivers/acpi/acpica/rscreate.c  |   27 ----------
 4 files changed, 99 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 600268d..8d59ac2 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -158,7 +158,12 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 		info->parent_package = *return_object_ptr;
 		status = acpi_ns_check_package(info, return_object_ptr);
 		if (ACPI_FAILURE(status)) {
-			goto exit;
+
+			/* We might be able to fix an operand type error (_PRT) */
+
+			if (status != AE_AML_OPERAND_TYPE) {
+				goto exit;
+			}
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index daac8da..aca9bdf 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -87,6 +87,10 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_PRT(struct acpi_evaluate_info *info,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
@@ -121,6 +125,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * _FDE: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _HID: Strings: uppercase all, remove any leading asterisk
+ * _PRT: Fix reversed source_name and source_index
  * _PSS: Sort the list descending by Power
  * _TSS: Sort the list descending by Power
  *
@@ -137,6 +142,7 @@ static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_FDE", acpi_ns_repair_FDE},
 	{"_GTM", acpi_ns_repair_FDE},	/* _GTM has same repair as _FDE */
 	{"_HID", acpi_ns_repair_HID},
+	{"_PRT", acpi_ns_repair_PRT},
 	{"_PSS", acpi_ns_repair_PSS},
 	{"_TSS", acpi_ns_repair_TSS},
 	{{0, 0, 0, 0}, NULL}	/* Table terminator */
@@ -488,7 +494,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_ns_repair_TSS
+ * FUNCTION:    acpi_ns_repair_PRT
  *
  * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
@@ -496,38 +502,54 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
  *
  * RETURN:      Status. AE_OK if object is OK or was repaired successfully
  *
- * DESCRIPTION: Repair for the _TSS object. If necessary, sort the object list
- *              descending by the power dissipation values.
+ * DESCRIPTION: Repair for the _PRT object. If necessary, fix reversed
+ *              source_name and source_index field, a common BIOS bug.
  *
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
+acpi_ns_repair_PRT(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
-	union acpi_operand_object *return_object = *return_object_ptr;
-	acpi_status status;
-	struct acpi_namespace_node *node;
+	union acpi_operand_object *package_object = *return_object_ptr;
+	union acpi_operand_object **top_object_list;
+	union acpi_operand_object **sub_object_list;
+	union acpi_operand_object *obj_desc;
+	u32 element_count;
+	u32 index;
 
-	/*
-	 * We can only sort the _TSS return package if there is no _PSS in the
-	 * same scope. This is because if _PSS is present, the ACPI specification
-	 * dictates that the _TSS Power Dissipation field is to be ignored, and
-	 * therefore some BIOSs leave garbage values in the _TSS Power field(s).
-	 * In this case, it is best to just return the _TSS package as-is.
-	 * (May, 2011)
-	 */
-	status = acpi_ns_get_node(info->node, "^_PSS",
-				  ACPI_NS_NO_UPSEARCH, &node);
-	if (ACPI_SUCCESS(status)) {
-		return (AE_OK);
-	}
+	/* Each element in the _PRT package is a subpackage */
 
-	status = acpi_ns_check_sorted_list(info, return_object, 5, 1,
-					   ACPI_SORT_DESCENDING,
-					   "PowerDissipation");
+	top_object_list = package_object->package.elements;
+	element_count = package_object->package.count;
 
-	return (status);
+	for (index = 0; index < element_count; index++) {
+		sub_object_list = (*top_object_list)->package.elements;
+
+		/*
+		 * If the BIOS has erroneously reversed the _PRT source_name (index 2)
+		 * and the source_index (index 3), fix it. _PRT is important enough to
+		 * workaround this BIOS error. This also provides compatibility with
+		 * other ACPI implementations.
+		 */
+		obj_desc = sub_object_list[3];
+		if (!obj_desc || (obj_desc->common.type != ACPI_TYPE_INTEGER)) {
+			sub_object_list[3] = sub_object_list[2];
+			sub_object_list[2] = obj_desc;
+			info->return_flags |= ACPI_OBJECT_REPAIRED;
+
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      info->node_flags,
+					      "PRT[%X]: Fixed reversed SourceName and SourceIndex",
+					      index));
+		}
+
+		/* Point to the next union acpi_operand_object in the top level package */
+
+		top_object_list++;
+	}
+
+	return (AE_OK);
 }
 
 /******************************************************************************
@@ -601,6 +623,50 @@ acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_ns_repair_TSS
+ *
+ * PARAMETERS:  info                - Method execution information block
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _TSS object. If necessary, sort the object list
+ *              descending by the power dissipation values.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	acpi_status status;
+	struct acpi_namespace_node *node;
+
+	/*
+	 * We can only sort the _TSS return package if there is no _PSS in the
+	 * same scope. This is because if _PSS is present, the ACPI specification
+	 * dictates that the _TSS Power Dissipation field is to be ignored, and
+	 * therefore some BIOSs leave garbage values in the _TSS Power field(s).
+	 * In this case, it is best to just return the _TSS package as-is.
+	 * (May, 2011)
+	 */
+	status = acpi_ns_get_node(info->node, "^_PSS",
+				  ACPI_NS_NO_UPSEARCH, &node);
+	if (ACPI_SUCCESS(status)) {
+		return (AE_OK);
+	}
+
+	status = acpi_ns_check_sorted_list(info, return_object, 5, 1,
+					   ACPI_SORT_DESCENDING,
+					   "PowerDissipation");
+
+	return (status);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_ns_check_sorted_list
  *
  * PARAMETERS:  info                - Method execution information block
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 608ebb5..b62a0f4 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -652,8 +652,9 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 
 		name_found = FALSE;
 
-		for (table_index = 0; table_index < 4 && !name_found;
-		     table_index++) {
+		for (table_index = 0;
+		     table_index < package_element->package.count
+		     && !name_found; table_index++) {
 			if (*sub_object_list &&	/* Null object allowed */
 			    ((ACPI_TYPE_STRING ==
 			      (*sub_object_list)->common.type) ||
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index f8b55b4..65f3e1c 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -273,17 +273,6 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		 */
 		user_prt->length = (sizeof(struct acpi_pci_routing_table) - 4);
 
-		/* Each element of the top-level package must also be a package */
-
-		if ((*top_object_list)->common.type != ACPI_TYPE_PACKAGE) {
-			ACPI_ERROR((AE_INFO,
-				    "(PRT[%u]) Need sub-package, found %s",
-				    index,
-				    acpi_ut_get_object_type_name
-				    (*top_object_list)));
-			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
-		}
-
 		/* Each sub-package must be of length 4 */
 
 		if ((*top_object_list)->package.count != 4) {
@@ -327,22 +316,6 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		user_prt->pin = (u32) obj_desc->integer.value;
 
 		/*
-		 * If the BIOS has erroneously reversed the _PRT source_name (index 2)
-		 * and the source_index (index 3), fix it. _PRT is important enough to
-		 * workaround this BIOS error. This also provides compatibility with
-		 * other ACPI implementations.
-		 */
-		obj_desc = sub_object_list[3];
-		if (!obj_desc || (obj_desc->common.type != ACPI_TYPE_INTEGER)) {
-			sub_object_list[3] = sub_object_list[2];
-			sub_object_list[2] = obj_desc;
-
-			ACPI_WARNING((AE_INFO,
-				      "(PRT[%X].Source) SourceName and SourceIndex are reversed, fixed",
-				      index));
-		}
-
-		/*
 		 * 3) Third subobject: Dereference the PRT.source_name
 		 * The name may be unresolved (slack mode), so allow a null object
 		 */
-- 
1.7.10

