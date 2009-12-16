From: Len Brown <lenb@kernel.org>
Subject: [PATCH 064/103] ACPICA: Add repair for bad _FDE/_GTM buffers
Date: Wed, 16 Dec 2009 03:36:15 -0500
Message-ID: <34c39c755347c1ca3d06284bad2273c6a9c3108a.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760782AbZLPMFw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:05:52 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:51 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The expected return value for both names is a Buffer of 5 DWORDS.
This repair fixes two possible problems (both seen in the field):
A package of integers is returned, or a buffer of BYTEs is returned.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c  |   14 ++--
 drivers/acpi/acpica/nsrepair2.c |  149 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index b05f429..1782c3d 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -222,23 +222,21 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	status = acpi_ns_check_object_type(data, return_object_ptr,
 					   predefined->info.expected_btypes,
 					   ACPI_NOT_PACKAGE_ELEMENT);
-	if (ACPI_FAILURE(status)) {
-		goto check_validation_status;
-	}
+	if (ACPI_SUCCESS(status)) {
 
-	/* For returned Package objects, check the type of all sub-objects */
+		/* For returned Package objects, check the type of all sub-objects */
 
-	if (return_object->common.type == ACPI_TYPE_PACKAGE) {
-		status = acpi_ns_check_package(data, return_object_ptr);
+		if (return_object->common.type == ACPI_TYPE_PACKAGE) {
+			status = acpi_ns_check_package(data, return_object_ptr);
+		}
 	}
 
 	/*
 	 * Perform additional, more complicated repairs on a per-name
-	 * basis.
+	 * basis. Do this regardless of the status from above.
 	 */
 	status = acpi_ns_complex_repairs(data, node, status, return_object_ptr);
 
-check_validation_status:
 	/*
 	 * If the object validation failed or if we successfully repaired one
 	 * or more objects, mark the parent node to suppress further warning
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index d07b686..6c35b57 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -74,6 +74,10 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_FDE(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_PSS(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
@@ -104,17 +108,27 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * This table contains the names of the predefined methods for which we can
  * perform more complex repairs.
  *
- * _ALR: Sort the list ascending by ambient_illuminance if necessary
- * _PSS: Sort the list descending by Power if necessary
- * _TSS: Sort the list descending by Power if necessary
+ * As necessary:
+ *
+ * _ALR: Sort the list ascending by ambient_illuminance
+ * _FDE: Convert a Package or Buffer of BYTEs to a Buffer of DWORDs
+ * _GTM: Convert a Package or Buffer of BYTEs to a Buffer of DWORDs
+ * _PSS: Sort the list descending by Power
+ * _TSS: Sort the list descending by Power
  */
 static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_ALR", acpi_ns_repair_ALR},
+	{"_FDE", acpi_ns_repair_FDE},
+	{"_GTM", acpi_ns_repair_FDE},	/* _GTM has same repair as _FDE */
 	{"_PSS", acpi_ns_repair_PSS},
 	{"_TSS", acpi_ns_repair_TSS},
 	{{0, 0, 0, 0}, NULL}	/* Table terminator */
 };
 
+#define ACPI_FDE_FIELD_COUNT        5
+#define ACPI_FDE_BYTE_BUFFER_SIZE   5
+#define ACPI_FDE_DWORD_BUFFER_SIZE  (ACPI_FDE_FIELD_COUNT * sizeof (u32))
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_ns_complex_repairs
@@ -215,6 +229,135 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_ns_repair_FDE
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _FDE and _GTM objects. The expected return
+ *              value is a Buffer of 5 DWORDs. This function repairs two
+ *              possible problems:
+ *              1) The return value is a Buffer of BYTEs, not DWORDs
+ *              2) The return value is a Package of Integer objects
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_FDE(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object **elements;
+	union acpi_operand_object *buffer_object;
+	u8 *byte_buffer;
+	u32 *dword_buffer;
+	u32 count;
+	u32 i;
+
+	switch (return_object->common.type) {
+	case ACPI_TYPE_BUFFER:
+
+		/* This is the expected type. Length should be (at least) 5 DWORDs */
+
+		if (return_object->buffer.length >= ACPI_FDE_DWORD_BUFFER_SIZE) {
+			return (AE_OK);
+		}
+
+		/* We can only repair if we have exactly 5 BYTEs */
+
+		if (return_object->buffer.length != ACPI_FDE_BYTE_BUFFER_SIZE) {
+			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+					      data->node_flags,
+					      "Incorrect return buffer length %u, expected %u",
+					      return_object->buffer.length,
+					      ACPI_FDE_DWORD_BUFFER_SIZE));
+
+			return (AE_AML_OPERAND_TYPE);
+		}
+
+		/* Create the new (larger) buffer object */
+
+		buffer_object =
+		    acpi_ut_create_buffer_object(ACPI_FDE_DWORD_BUFFER_SIZE);
+		if (!buffer_object) {
+			return (AE_NO_MEMORY);
+		}
+
+		/* Expand each byte to a DWORD */
+
+		byte_buffer = return_object->buffer.pointer;
+		dword_buffer =
+		    ACPI_CAST_PTR(u32, buffer_object->buffer.pointer);
+
+		for (i = 0; i < ACPI_FDE_FIELD_COUNT; i++) {
+			*dword_buffer = (u32) *byte_buffer;
+			dword_buffer++;
+			byte_buffer++;
+		}
+
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Expanded Byte Buffer to expected DWord Buffer"));
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+
+		/* All elements of the Package must be integers */
+
+		elements = return_object->package.elements;
+		count =
+		    ACPI_MIN(ACPI_FDE_FIELD_COUNT,
+			     return_object->package.count);
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
+		buffer_object =
+		    acpi_ut_create_buffer_object(ACPI_FDE_DWORD_BUFFER_SIZE);
+		if (!buffer_object) {
+			return (AE_NO_MEMORY);
+		}
+
+		/* Copy the package elements (integers) to the buffer */
+
+		elements = return_object->package.elements;
+		dword_buffer =
+		    ACPI_CAST_PTR(u32, buffer_object->buffer.pointer);
+
+		for (i = 0; i < count; i++) {
+			*dword_buffer = (u32) (*elements)->integer.value;
+			dword_buffer++;
+			elements++;
+		}
+
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted Package to expected Buffer"));
+		break;
+
+	default:
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	/* Delete the original return object, return the new buffer object */
+
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = buffer_object;
+
+	data->flags |= ACPI_OBJECT_REPAIRED;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_ns_repair_TSS
  *
  * PARAMETERS:  Data                - Pointer to validation data structure
-- 
1.6.0.6

