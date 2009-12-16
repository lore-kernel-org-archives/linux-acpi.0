From: Len Brown <lenb@kernel.org>
Subject: [PATCH 069/103] ACPICA: Move Package-to-Buffer repair code into common
 ToBuffer function
Date: Wed, 16 Dec 2009 03:36:20 -0500
Message-ID: <ea7c5ec148044776d5e134e52a3e1aca8d662dbe.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61720 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314AbZLPMFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:05:50 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:49 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Move code specific to _FDE and _GTM into the generic repair code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c  |   11 ++++++---
 drivers/acpi/acpica/nsrepair.c  |   43 +++++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/nsrepair2.c |   43 ---------------------------------------
 3 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 1782c3d..c6297f5 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -215,6 +215,8 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	data->node_flags = node->flags;
 	data->pathname = pathname;
 
+	/* TBD: For variable-length Packages, remove NULL elements here */
+
 	/*
 	 * Check that the type of the return object is what is expected for
 	 * this predefined name
@@ -223,10 +225,11 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 					   predefined->info.expected_btypes,
 					   ACPI_NOT_PACKAGE_ELEMENT);
 	if (ACPI_SUCCESS(status)) {
-
-		/* For returned Package objects, check the type of all sub-objects */
-
-		if (return_object->common.type == ACPI_TYPE_PACKAGE) {
+		/*
+		 * For returned Package objects, check the type of all sub-objects.
+		 * Note: Package may have been created by call above.
+		 */
+		if ((*return_object_ptr)->common.type == ACPI_TYPE_PACKAGE) {
 			status = acpi_ns_check_package(data, return_object_ptr);
 		}
 	}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 10629fa..062a016 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -350,7 +350,7 @@ acpi_ns_convert_to_string(union acpi_operand_object *original_object,
  *
  * RETURN:      Status. AE_OK if conversion was successful.
  *
- * DESCRIPTION: Attempt to convert a Integer/String object to a Buffer.
+ * DESCRIPTION: Attempt to convert a Integer/String/Package object to a Buffer.
  *
  ******************************************************************************/
 
@@ -360,6 +360,10 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 {
 	union acpi_operand_object *new_object;
 	acpi_status status;
+	union acpi_operand_object **elements;
+	u32 *dword_buffer;
+	u32 count;
+	u32 i;
 
 	switch (original_object->common.type) {
 	case ACPI_TYPE_INTEGER:
@@ -393,6 +397,40 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 			    original_object->string.length);
 		break;
 
+	case ACPI_TYPE_PACKAGE:
+
+		/* All elements of the Package must be integers */
+
+		elements = original_object->package.elements;
+		count = original_object->package.count;
+
+		for (i = 0; i < count; i++) {
+			if ((!*elements) ||
+			    ((*elements)->common.type != ACPI_TYPE_INTEGER)) {
+				return (AE_AML_OPERAND_TYPE);
+			}
+			elements++;
+		}
+
+		/* Create the new buffer object to replace the Package */
+
+		new_object = acpi_ut_create_buffer_object(ACPI_MUL_4(count));
+		if (!new_object) {
+			return (AE_NO_MEMORY);
+		}
+
+		/* Copy the package elements (integers) to the buffer as DWORDs */
+
+		elements = original_object->package.elements;
+		dword_buffer = ACPI_CAST_PTR(u32, new_object->buffer.pointer);
+
+		for (i = 0; i < count; i++) {
+			*dword_buffer = (u32) (*elements)->integer.value;
+			dword_buffer++;
+			elements++;
+		}
+		break;
+
 	default:
 		return (AE_AML_OPERAND_TYPE);
 	}
@@ -441,7 +479,8 @@ acpi_ns_convert_to_package(union acpi_operand_object *original_object,
 		buffer = original_object->buffer.pointer;
 
 		while (length--) {
-			*elements = acpi_ut_create_integer_object(*buffer);
+			*elements =
+			    acpi_ut_create_integer_object((u64) *buffer);
 			if (!*elements) {
 				acpi_ut_remove_reference(new_object);
 				return (AE_NO_MEMORY);
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 6c35b57..846df70 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -250,11 +250,9 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
-	union acpi_operand_object **elements;
 	union acpi_operand_object *buffer_object;
 	u8 *byte_buffer;
 	u32 *dword_buffer;
-	u32 count;
 	u32 i;
 
 	switch (return_object->common.type) {
@@ -302,47 +300,6 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 				      "Expanded Byte Buffer to expected DWord Buffer"));
 		break;
 
-	case ACPI_TYPE_PACKAGE:
-
-		/* All elements of the Package must be integers */
-
-		elements = return_object->package.elements;
-		count =
-		    ACPI_MIN(ACPI_FDE_FIELD_COUNT,
-			     return_object->package.count);
-
-		for (i = 0; i < count; i++) {
-			if ((!*elements) ||
-			    ((*elements)->common.type != ACPI_TYPE_INTEGER)) {
-				return (AE_AML_OPERAND_TYPE);
-			}
-			elements++;
-		}
-
-		/* Create the new buffer object to replace the Package */
-
-		buffer_object =
-		    acpi_ut_create_buffer_object(ACPI_FDE_DWORD_BUFFER_SIZE);
-		if (!buffer_object) {
-			return (AE_NO_MEMORY);
-		}
-
-		/* Copy the package elements (integers) to the buffer */
-
-		elements = return_object->package.elements;
-		dword_buffer =
-		    ACPI_CAST_PTR(u32, buffer_object->buffer.pointer);
-
-		for (i = 0; i < count; i++) {
-			*dword_buffer = (u32) (*elements)->integer.value;
-			dword_buffer++;
-			elements++;
-		}
-
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "Converted Package to expected Buffer"));
-		break;
-
 	default:
 		return (AE_AML_OPERAND_TYPE);
 	}
-- 
1.6.0.6

