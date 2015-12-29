From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 37/42] ACPICA: Events: Split acpi_ev_associate_reg_method() from region initialization code
Date: Tue, 29 Dec 2015 14:02:58 +0800
Message-ID: <8066e7e9e7cb78b88eceb4d64a69b70d5b27c150.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 87c85610250ff7141a84507f68dbc1e00f2936db

This patch introduces a new region initialization function
acpi_ev_associate_reg_method(), which is invoked to associate the _REG method
to its related region object.

Region object's default value assignments are also sorted by cleaning up
the code using this new function. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/87c85610
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acevents.h |    2 ++
 drivers/acpi/acpica/evregion.c |   46 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evrgnini.c |   30 ++------------------------
 drivers/acpi/acpica/excreate.c |    6 +++++-
 4 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 42975ab..772ee3c 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -198,6 +198,8 @@ void
 acpi_ev_detach_region(union acpi_operand_object *region_obj,
 		      u8 acpi_ns_is_locked);
 
+void acpi_ev_associate_reg_method(union acpi_operand_object *region_obj);
+
 acpi_status
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id);
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 19a4e69..432b810 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -529,6 +529,52 @@ acpi_ev_attach_region(union acpi_operand_object *handler_obj,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_associate_reg_method
+ *
+ * PARAMETERS:  region_obj          - Region object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Find and associate _REG method to a region
+ *
+ ******************************************************************************/
+
+void acpi_ev_associate_reg_method(union acpi_operand_object *region_obj)
+{
+	acpi_name *reg_name_ptr = (acpi_name *) METHOD_NAME__REG;
+	struct acpi_namespace_node *method_node;
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *region_obj2;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ev_associate_reg_method);
+
+	region_obj2 = acpi_ns_get_secondary_object(region_obj);
+	if (!region_obj2) {
+		return_VOID;
+	}
+
+	node = region_obj->region.node->parent;
+
+	/* Find any "_REG" method associated with this region definition */
+
+	status =
+	    acpi_ns_search_one_scope(*reg_name_ptr, node, ACPI_TYPE_METHOD,
+				     &method_node);
+	if (ACPI_SUCCESS(status)) {
+		/*
+		 * The _REG method is optional and there can be only one per region
+		 * definition. This will be executed when the handler is attached
+		 * or removed
+		 */
+		region_obj2->extra.method_REG = method_node;
+	}
+
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_execute_reg_method
  *
  * PARAMETERS:  region_obj          - Region object
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 024689d..bb2e529 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -507,9 +507,6 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 	acpi_adr_space_type space_id;
 	struct acpi_namespace_node *node;
 	acpi_status status;
-	struct acpi_namespace_node *method_node;
-	acpi_name *reg_name_ptr = (acpi_name *) METHOD_NAME__REG;
-	union acpi_operand_object *region_obj2;
 
 	ACPI_FUNCTION_TRACE_U32(ev_initialize_region, acpi_ns_locked);
 
@@ -521,35 +518,12 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
+	acpi_ev_associate_reg_method(region_obj);
+	region_obj->common.flags |= AOPOBJ_OBJECT_INITIALIZED;
 
 	node = region_obj->region.node->parent;
 	space_id = region_obj->region.space_id;
 
-	/* Setup defaults */
-
-	region_obj->region.handler = NULL;
-	region_obj2->extra.method_REG = NULL;
-	region_obj->common.flags &= ~(AOPOBJ_SETUP_COMPLETE);
-	region_obj->common.flags |= AOPOBJ_OBJECT_INITIALIZED;
-
-	/* Find any "_REG" method associated with this region definition */
-
-	status =
-	    acpi_ns_search_one_scope(*reg_name_ptr, node, ACPI_TYPE_METHOD,
-				     &method_node);
-	if (ACPI_SUCCESS(status)) {
-		/*
-		 * The _REG method is optional and there can be only one per region
-		 * definition. This will be executed when the handler is attached
-		 * or removed
-		 */
-		region_obj2->extra.method_REG = method_node;
-	}
-
 	/*
 	 * The following loop depends upon the root Node having no parent
 	 * ie: acpi_gbl_root_node->Parent being set to NULL
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 0f34446..6a1396e 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -326,9 +326,10 @@ acpi_ex_create_region(u8 * aml_start,
 	 * Remember location in AML stream of address & length
 	 * operands since they need to be evaluated at run time.
 	 */
-	region_obj2 = obj_desc->common.next_object;
+	region_obj2 = acpi_ns_get_secondary_object(obj_desc);
 	region_obj2->extra.aml_start = aml_start;
 	region_obj2->extra.aml_length = aml_length;
+	region_obj2->extra.method_REG = NULL;
 	if (walk_state->scope_info) {
 		region_obj2->extra.scope_node =
 		    walk_state->scope_info->scope.node;
@@ -342,6 +343,9 @@ acpi_ex_create_region(u8 * aml_start,
 	obj_desc->region.address = 0;
 	obj_desc->region.length = 0;
 	obj_desc->region.node = node;
+	obj_desc->region.handler = NULL;
+	obj_desc->common.flags &=
+	    ~(AOPOBJ_SETUP_COMPLETE | AOPOBJ_OBJECT_INITIALIZED);
 
 	/* Install the new region object in the parent Node */
 
-- 
1.7.10
