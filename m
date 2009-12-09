From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/14] ACPICA: Add additional module-level code support
Date: Wed, 09 Dec 2009 12:22:14 -0500
Message-ID: <9a884ab64a4d092b4c3bf24fd9a30f7fbd4591e7.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57852 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316AbZLIR6R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:58:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUE007Q3CKWILQ0@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:58:21 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

This change will execute module-level code that is not at the
root of the namespace (under a Device object, etc.).
ACPICA BZ 762.

http://www.acpica.org/bugzilla/show_bug.cgi?id=762

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nseval.c |   50 +++++++++++++++++++++++++++++------------
 drivers/acpi/acpica/psloop.c |   32 +++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 846d113..f771e97 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -366,33 +366,49 @@ static void
 acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 			 struct acpi_evaluate_info *info)
 {
-	union acpi_operand_object *root_obj;
+	union acpi_operand_object *parent_obj;
+	struct acpi_namespace_node *parent_node;
+	acpi_object_type type;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ns_exec_module_code);
 
+	/*
+	 * Get the parent node. We cheat by using the next_object field
+	 * of the method object descriptor.
+	 */
+	parent_node = ACPI_CAST_PTR(struct acpi_namespace_node,
+				    method_obj->method.next_object);
+	type = acpi_ns_get_type(parent_node);
+
+	/* Must clear next_object (acpi_ns_attach_object needs the field) */
+
+	method_obj->method.next_object = NULL;
+
 	/* Initialize the evaluation information block */
 
 	ACPI_MEMSET(info, 0, sizeof(struct acpi_evaluate_info));
-	info->prefix_node = acpi_gbl_root_node;
+	info->prefix_node = parent_node;
 
 	/*
-	 * Get the currently attached root object. Add a reference, because the
+	 * Get the currently attached parent object. Add a reference, because the
 	 * ref count will be decreased when the method object is installed to
-	 * the root node.
+	 * the parent node.
 	 */
-	root_obj = acpi_ns_get_attached_object(acpi_gbl_root_node);
-	acpi_ut_add_reference(root_obj);
+	parent_obj = acpi_ns_get_attached_object(parent_node);
+	if (parent_obj) {
+		acpi_ut_add_reference(parent_obj);
+	}
 
-	/* Install the method (module-level code) in the root node */
+	/* Install the method (module-level code) in the parent node */
 
-	status = acpi_ns_attach_object(acpi_gbl_root_node, method_obj,
+	status = acpi_ns_attach_object(parent_node, method_obj,
 				       ACPI_TYPE_METHOD);
 	if (ACPI_FAILURE(status)) {
 		goto exit;
 	}
 
-	/* Execute the root node as a control method */
+	/* Execute the parent node as a control method */
 
 	status = acpi_ns_evaluate(info);
 
@@ -401,15 +417,19 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 
 	/* Detach the temporary method object */
 
-	acpi_ns_detach_object(acpi_gbl_root_node);
+	acpi_ns_detach_object(parent_node);
 
-	/* Restore the original root object */
+	/* Restore the original parent object */
 
-	status =
-	    acpi_ns_attach_object(acpi_gbl_root_node, root_obj,
-				  ACPI_TYPE_DEVICE);
+	if (parent_obj) {
+		status = acpi_ns_attach_object(parent_node, parent_obj, type);
+	} else {
+		parent_node->type = (u8)type;
+	}
 
       exit:
-	acpi_ut_remove_reference(root_obj);
+	if (parent_obj) {
+		acpi_ut_remove_reference(parent_obj);
+	}
 	return_VOID;
 }
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index cd7995b..0988e4a 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -87,7 +87,8 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status);
 
 static void
-acpi_ps_link_module_code(u8 *aml_start, u32 aml_length, acpi_owner_id owner_id);
+acpi_ps_link_module_code(union acpi_parse_object *parent_op,
+			 u8 *aml_start, u32 aml_length, acpi_owner_id owner_id);
 
 /*******************************************************************************
  *
@@ -479,11 +480,14 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 				 */
 				if (walk_state->pass_number ==
 				    ACPI_IMODE_LOAD_PASS1) {
-					acpi_ps_link_module_code(aml_op_start,
-								 walk_state->
+					acpi_ps_link_module_code(op->common.
+								 parent,
+								 aml_op_start,
+								 (u32)
+								 (walk_state->
 								 parser_state.
 								 pkg_end -
-								 aml_op_start,
+								 aml_op_start),
 								 walk_state->
 								 owner_id);
 				}
@@ -598,7 +602,8 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
  *
  * FUNCTION:    acpi_ps_link_module_code
  *
- * PARAMETERS:  aml_start           - Pointer to the AML
+ * PARAMETERS:  parent_op           - Parent parser op
+ *              aml_start           - Pointer to the AML
  *              aml_length          - Length of executable AML
  *              owner_id            - owner_id of module level code
  *
@@ -611,11 +616,13 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
  ******************************************************************************/
 
 static void
-acpi_ps_link_module_code(u8 *aml_start, u32 aml_length, acpi_owner_id owner_id)
+acpi_ps_link_module_code(union acpi_parse_object *parent_op,
+			 u8 *aml_start, u32 aml_length, acpi_owner_id owner_id)
 {
 	union acpi_operand_object *prev;
 	union acpi_operand_object *next;
 	union acpi_operand_object *method_obj;
+	struct acpi_namespace_node *parent_node;
 
 	/* Get the tail of the list */
 
@@ -639,11 +646,24 @@ acpi_ps_link_module_code(u8 *aml_start, u32 aml_length, acpi_owner_id owner_id)
 			return;
 		}
 
+		if (parent_op->common.node) {
+			parent_node = parent_op->common.node;
+		} else {
+			parent_node = acpi_gbl_root_node;
+		}
+
 		method_obj->method.aml_start = aml_start;
 		method_obj->method.aml_length = aml_length;
 		method_obj->method.owner_id = owner_id;
 		method_obj->method.flags |= AOPOBJ_MODULE_LEVEL;
 
+		/*
+		 * Save the parent node in next_object. This is cheating, but we
+		 * don't want to expand the method object.
+		 */
+		method_obj->method.next_object =
+		    ACPI_CAST_PTR(union acpi_operand_object, parent_node);
+
 		if (!prev) {
 			acpi_gbl_module_code_list = method_obj;
 		} else {
-- 
1.6.0.6

