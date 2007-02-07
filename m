From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/140] ACPICA: Handle case NumElements > Package length
Date: Wed,  7 Feb 2007 13:50:58 -0500
Message-ID: <11708744322360-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:31152 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422769AbXBGSyB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:01 -0500
In-Reply-To: <11708744311281-git-send-email-lenb@kernel.org>
Message-Id: <8f9337c88335846b01801b1047a4caf10527a320.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Additional update for NumElements fix. Must handle
case where NumElements > Package list length, pad package
with null elements.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   87 +++++++++++++++++-------------------
 1 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index aaeb9f9..f9f6862 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -260,7 +260,7 @@ acpi_ds_build_internal_buffer_obj(struct acpi_walk_state *walk_state,
 	}
 
 	obj_desc->buffer.flags |= AOPOBJ_DATA_VALID;
-	op->common.node = (struct acpi_namespace_node *)obj_desc;
+	op->common.node = ACPI_CAST_PTR(struct acpi_namespace_node, obj_desc);
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -270,7 +270,8 @@ acpi_ds_build_internal_buffer_obj(struct acpi_walk_state *walk_state,
  *
  * PARAMETERS:  walk_state      - Current walk state
  *              Op              - Parser object to be translated
- *              package_length  - Number of elements in the package
+ *              element_count   - Number of elements in the package - this is
+ *                                the num_elements argument to Package()
  *              obj_desc_ptr    - Where the ACPI internal object is returned
  *
  * RETURN:      Status
@@ -278,18 +279,29 @@ acpi_ds_build_internal_buffer_obj(struct acpi_walk_state *walk_state,
  * DESCRIPTION: Translate a parser Op package object to the equivalent
  *              namespace object
  *
+ * NOTE: The number of elements in the package will be always be the num_elements
+ * count, regardless of the number of elements in the package list. If
+ * num_elements is smaller, only that many package list elements are used.
+ * if num_elements is larger, the Package object is padded out with
+ * objects of type Uninitialized (as per ACPI spec.)
+ *
+ * Even though the ASL compilers do not allow num_elements to be smaller
+ * than the Package list length (for the fixed length package opcode), some
+ * BIOS code modifies the AML on the fly to adjust the num_elements, and
+ * this code compensates for that. This also provides compatibility with
+ * other AML interpreters.
+ *
  ******************************************************************************/
 
 acpi_status
 acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 				   union acpi_parse_object *op,
-				   u32 package_length,
+				   u32 element_count,
 				   union acpi_operand_object **obj_desc_ptr)
 {
 	union acpi_parse_object *arg;
 	union acpi_parse_object *parent;
 	union acpi_operand_object *obj_desc = NULL;
-	u32 package_list_length;
 	acpi_status status = AE_OK;
 	acpi_native_uint i;
 
@@ -318,43 +330,13 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		obj_desc->package.node = parent->common.node;
 	}
 
-	/* Count the *actual* number of items in the package list */
-
-	arg = op->common.value.arg;
-	arg = arg->common.next;
-	for (package_list_length = 0; arg; package_list_length++) {
-		arg = arg->common.next;
-	}
-
-	/*
-	 * The number of elements in the package will be the lesser of the
-	 * specified element count and the length of the initializer list.
-	 *
-	 * Even though the ASL compilers do not allow this to happen (for the
-	 * fixed length package opcode), some BIOS code modifies the AML on the
-	 * fly to adjust the package length, and this code compensates for that.
-	 * This also provides compatibility with other AML interpreters.
-	 */
-	obj_desc->package.count = package_length;
-
-	if (package_list_length != package_length) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Package length mismatch, using lesser of %X(Length Arg) and %X(AML Length)\n",
-				  package_length, package_list_length));
-
-		if (package_list_length < package_length) {
-			obj_desc->package.count = package_list_length;
-		}
-	}
-
 	/*
-	 * Allocate the pointer array (array of pointers to the
-	 * individual objects). Add an extra pointer slot so
-	 * that the list is always null terminated.
+	 * Allocate the element array (array of pointers to the individual
+	 * objects) based on the num_elements parameter. Add an extra pointer slot
+	 * so that the list is always null terminated.
 	 */
 	obj_desc->package.elements = ACPI_ALLOCATE_ZEROED(((acpi_size)
-							   obj_desc->package.
-							   count +
+							   element_count +
 							   1) * sizeof(void *));
 
 	if (!obj_desc->package.elements) {
@@ -362,15 +344,20 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
+	obj_desc->package.count = element_count;
+
 	/*
-	 * Initialize all elements of the package
+	 * Initialize the elements of the package, up to the num_elements count.
+	 * Package is automatically padded with uninitialized (NULL) elements
+	 * if num_elements is greater than the package list length. Likewise,
+	 * Package is truncated if num_elements is less than the list length.
 	 */
 	arg = op->common.value.arg;
 	arg = arg->common.next;
-	for (i = 0; i < obj_desc->package.count; i++) {
+	for (i = 0; arg && (i < element_count); i++) {
 		if (arg->common.aml_opcode == AML_INT_RETURN_VALUE_OP) {
 
-			/* Object (package or buffer) is already built */
+			/* This package element is already built, just get it */
 
 			obj_desc->package.elements[i] =
 			    ACPI_CAST_PTR(union acpi_operand_object,
@@ -384,8 +371,14 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		arg = arg->common.next;
 	}
 
+	if (!arg) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Package List length larger than NumElements count (%X), truncated\n",
+				  element_count));
+	}
+
 	obj_desc->package.flags |= AOPOBJ_DATA_VALID;
-	op->common.node = (struct acpi_namespace_node *)obj_desc;
+	op->common.node = ACPI_CAST_PTR(struct acpi_namespace_node, obj_desc);
 	return_ACPI_STATUS(status);
 }
 
@@ -499,8 +492,9 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 		/*
 		 * Defer evaluation of Buffer term_arg operand
 		 */
-		obj_desc->buffer.node = (struct acpi_namespace_node *)
-		    walk_state->operands[0];
+		obj_desc->buffer.node =
+		    ACPI_CAST_PTR(struct acpi_namespace_node,
+				  walk_state->operands[0]);
 		obj_desc->buffer.aml_start = op->named.data;
 		obj_desc->buffer.aml_length = op->named.length;
 		break;
@@ -510,8 +504,9 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 		/*
 		 * Defer evaluation of Package term_arg operand
 		 */
-		obj_desc->package.node = (struct acpi_namespace_node *)
-		    walk_state->operands[0];
+		obj_desc->package.node =
+		    ACPI_CAST_PTR(struct acpi_namespace_node,
+				  walk_state->operands[0]);
 		obj_desc->package.aml_start = op->named.data;
 		obj_desc->package.aml_length = op->named.length;
 		break;
-- 
1.5.0.rc3.39.gec804
