From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/73] ACPICA: Fixed a memory leak when Device or Thermal objects referenced in packages
Date: Sat, 12 Apr 2008 00:25:12 -0400
Message-ID: <9c11bc265aa3f8cbe78723da76e61683cfed78b8.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752859AbYDLE2G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:06 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Problem introduced in fix for Package references.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   38 +++++++++++++++++++----------------
 drivers/acpi/utilities/utdelete.c  |    8 ++++--
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index fe28b9a..7556d91 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -172,7 +172,19 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 			switch (op->common.node->type) {
 				/*
 				 * For these types, we need the actual node, not the subobject.
-				 * However, the subobject got an extra reference count above.
+				 * However, the subobject did not get an extra reference count above.
+				 *
+				 * TBD: should ex_resolve_node_to_value be changed to fix this?
+				 */
+			case ACPI_TYPE_DEVICE:
+			case ACPI_TYPE_THERMAL:
+
+				acpi_ut_add_reference(op->common.node->object);
+
+				/*lint -fallthrough */
+				/*
+				 * For these types, we need the actual node, not the subobject.
+				 * The subobject got an extra reference count in ex_resolve_node_to_value.
 				 */
 			case ACPI_TYPE_MUTEX:
 			case ACPI_TYPE_METHOD:
@@ -180,25 +192,15 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 			case ACPI_TYPE_PROCESSOR:
 			case ACPI_TYPE_EVENT:
 			case ACPI_TYPE_REGION:
-			case ACPI_TYPE_DEVICE:
-			case ACPI_TYPE_THERMAL:
 
-				obj_desc =
-				    (union acpi_operand_object *)op->common.
-				    node;
+				/* We will create a reference object for these types below */
 				break;
 
 			default:
-				break;
-			}
-
-			/*
-			 * If above resolved to an operand object, we are done. Otherwise,
-			 * we have a NS node, we must create the package entry as a named
-			 * reference.
-			 */
-			if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) !=
-			    ACPI_DESC_TYPE_NAMED) {
+				/*
+				 * All other types - the node was resolved to an actual
+				 * object, we are done.
+				 */
 				goto exit;
 			}
 		}
@@ -223,7 +225,7 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 
       exit:
 	*obj_desc_ptr = obj_desc;
-	return_ACPI_STATUS(AE_OK);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
@@ -743,6 +745,8 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 				/* Node was saved in Op */
 
 				obj_desc->reference.node = op->common.node;
+				obj_desc->reference.object =
+				    op->common.node->object;
 			}
 
 			obj_desc->reference.opcode = opcode;
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index dcb34f8..6a763cd 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -524,10 +524,12 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 
 		case ACPI_TYPE_LOCAL_REFERENCE:
 			/*
-			 * The target of an Index (a package, string, or buffer) must track
-			 * changes to the ref count of the index.
+			 * The target of an Index (a package, string, or buffer) or a named
+			 * reference must track changes to the ref count of the index or
+			 * target object.
 			 */
-			if (object->reference.opcode == AML_INDEX_OP) {
+			if ((object->reference.opcode == AML_INDEX_OP) ||
+			    (object->reference.opcode == AML_INT_NAMEPATH_OP)) {
 				next_object = object->reference.object;
 			}
 			break;
-- 
1.5.5.29.g7134

