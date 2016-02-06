From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/14] ACPICA: Events: Fix an issue that _REG association can happen before namespace is initialized
Date: Sat,  6 Feb 2016 11:53:14 +0800
Message-ID: <c217f843a5c0e8d328bffa6d4f913fb8a64a0a5f.1454730660.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Current code flow cannot ensure _REG association can happen after the
namespace is initialized, so we move _REG association to where _REG was
about to run to fix this issue.

This issue is detected when acpi_ev_initialize_region() is invoked during
the table loading. And this is one of the most important the root cause why
ACPICA table loading is split into 2 load passes. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acevents.h |    2 --
 drivers/acpi/acpica/evregion.c |   71 ++++++++++++++--------------------------
 drivers/acpi/acpica/evrgnini.c |    1 -
 3 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 010cf81..17f2217 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -198,8 +198,6 @@ void
 acpi_ev_detach_region(union acpi_operand_object *region_obj,
 		      u8 acpi_ns_is_locked);
 
-void acpi_ev_associate_reg_method(union acpi_operand_object *region_obj);
-
 void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id, u32 function);
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 63924d1..72f553c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -526,81 +526,58 @@ acpi_ev_attach_region(union acpi_operand_object *handler_obj,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_associate_reg_method
+ * FUNCTION:    acpi_ev_execute_reg_method
  *
  * PARAMETERS:  region_obj          - Region object
+ *              function            - Passed to _REG: On (1) or Off (0)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Find and associate _REG method to a region
+ * DESCRIPTION: Execute _REG method for a region
  *
  ******************************************************************************/
 
-void acpi_ev_associate_reg_method(union acpi_operand_object *region_obj)
+acpi_status
+acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 {
+	struct acpi_evaluate_info *info;
+	union acpi_operand_object *args[3];
+	union acpi_operand_object *region_obj2;
 	acpi_name *reg_name_ptr = (acpi_name *) METHOD_NAME__REG;
 	struct acpi_namespace_node *method_node;
 	struct acpi_namespace_node *node;
-	union acpi_operand_object *region_obj2;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(ev_associate_reg_method);
+	ACPI_FUNCTION_TRACE(ev_execute_reg_method);
+
+	if (!acpi_gbl_namespace_initialized ||
+	    region_obj->region.handler == NULL) {
+		return_ACPI_STATUS(AE_OK);
+	}
 
 	region_obj2 = acpi_ns_get_secondary_object(region_obj);
 	if (!region_obj2) {
-		return_VOID;
+		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
+	/*
+	 * Find any "_REG" method associated with this region definition.
+	 * The method should always be updated as this function may be
+	 * invoked after a namespace change.
+	 */
 	node = region_obj->region.node->parent;
-
-	/* Find any "_REG" method associated with this region definition */
-
 	status =
 	    acpi_ns_search_one_scope(*reg_name_ptr, node, ACPI_TYPE_METHOD,
 				     &method_node);
 	if (ACPI_SUCCESS(status)) {
 		/*
-		 * The _REG method is optional and there can be only one per region
-		 * definition. This will be executed when the handler is attached
-		 * or removed
+		 * The _REG method is optional and there can be only one per
+		 * region definition. This will be executed when the handler is
+		 * attached or removed.
 		 */
 		region_obj2->extra.method_REG = method_node;
 	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_execute_reg_method
- *
- * PARAMETERS:  region_obj          - Region object
- *              function            - Passed to _REG: On (1) or Off (0)
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Execute _REG method for a region
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
-{
-	struct acpi_evaluate_info *info;
-	union acpi_operand_object *args[3];
-	union acpi_operand_object *region_obj2;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_execute_reg_method);
-
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
-
-	if (region_obj2->extra.method_REG == NULL ||
-	    region_obj->region.handler == NULL ||
-	    !acpi_gbl_namespace_initialized) {
+	if (region_obj2->extra.method_REG == NULL) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index fda869c..6972ab4 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -518,7 +518,6 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	acpi_ev_associate_reg_method(region_obj);
 	region_obj->common.flags |= AOPOBJ_OBJECT_INITIALIZED;
 
 	node = region_obj->region.node->parent;
-- 
1.7.10
