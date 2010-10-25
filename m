From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/60] ACPICA: Add repair for _HID and _CID strings
Date: Mon, 25 Oct 2010 02:20:20 -0400
Message-ID: <77b23f712bc40a65160e7d02b045f1562bb43ff1.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38309 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab0JYJLF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:05 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This dynamic repair will fix these problems:
1) Remove a leading asterisk in the string
2) Uppercase the entire string

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |  163 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 4009498..4ef9f43 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -74,10 +74,18 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_CID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
+acpi_ns_repair_HID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
 acpi_ns_repair_PSS(struct acpi_predefined_data *data,
 		   union acpi_operand_object **return_object_ptr);
 
@@ -108,8 +116,10 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * As necessary:
  *
  * _ALR: Sort the list ascending by ambient_illuminance
+ * _CID: Strings: uppercase all, remove any leading asterisk
  * _FDE: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
+ * _HID: Strings: uppercase all, remove any leading asterisk
  * _PSS: Sort the list descending by Power
  * _TSS: Sort the list descending by Power
  *
@@ -122,8 +132,10 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  */
 static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_ALR", acpi_ns_repair_ALR},
+	{"_CID", acpi_ns_repair_CID},
 	{"_FDE", acpi_ns_repair_FDE},
 	{"_GTM", acpi_ns_repair_FDE},	/* _GTM has same repair as _FDE */
+	{"_HID", acpi_ns_repair_HID},
 	{"_PSS", acpi_ns_repair_PSS},
 	{"_TSS", acpi_ns_repair_TSS},
 	{{0, 0, 0, 0}, NULL}	/* Table terminator */
@@ -321,6 +333,157 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_ns_repair_CID
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _CID object. If a string, ensure that all
+ *              letters are uppercase and that there is no leading asterisk.
+ *              If a Package, ensure same for all string elements.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_CID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	acpi_status status;
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object **element_ptr;
+	union acpi_operand_object *original_element;
+	u16 original_ref_count;
+	u32 i;
+
+	/* Check for _CID as a simple string */
+
+	if (return_object->common.type == ACPI_TYPE_STRING) {
+		status = acpi_ns_repair_HID(data, return_object_ptr);
+		return (status);
+	}
+
+	/* Exit if not a Package */
+
+	if (return_object->common.type != ACPI_TYPE_PACKAGE) {
+		return (AE_OK);
+	}
+
+	/* Examine each element of the _CID package */
+
+	element_ptr = return_object->package.elements;
+	for (i = 0; i < return_object->package.count; i++) {
+		original_element = *element_ptr;
+		original_ref_count = original_element->common.reference_count;
+
+		status = acpi_ns_repair_HID(data, element_ptr);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/* Take care with reference counts */
+
+		if (original_element != *element_ptr) {
+
+			/* Element was replaced */
+
+			(*element_ptr)->common.reference_count =
+			    original_ref_count;
+
+			acpi_ut_remove_reference(original_element);
+		}
+
+		element_ptr++;
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_HID
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _HID object. If a string, ensure that all
+ *              letters are uppercase and that there is no leading asterisk.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_HID(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object *new_string;
+	char *source;
+	char *dest;
+
+	ACPI_FUNCTION_NAME(ns_repair_HID);
+
+	/* We only care about string _HID objects (not integers) */
+
+	if (return_object->common.type != ACPI_TYPE_STRING) {
+		return (AE_OK);
+	}
+
+	if (return_object->string.length == 0) {
+		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Invalid zero-length _HID or _CID string"));
+
+		/* Return AE_OK anyway, let driver handle it */
+
+		data->flags |= ACPI_OBJECT_REPAIRED;
+		return (AE_OK);
+	}
+
+	/* It is simplest to always create a new string object */
+
+	new_string = acpi_ut_create_string_object(return_object->string.length);
+	if (!new_string) {
+		return (AE_NO_MEMORY);
+	}
+
+	/*
+	 * Remove a leading asterisk if present. For some unknown reason, there
+	 * are many machines in the field that contains IDs like this.
+	 *
+	 * Examples: "*PNP0C03", "*ACPI0003"
+	 */
+	source = return_object->string.pointer;
+	if (*source == '*') {
+		source++;
+		new_string->string.length--;
+
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Removed invalid leading asterisk\n",
+				  data->pathname));
+	}
+
+	/*
+	 * Copy and uppercase the string. From the ACPI specification:
+	 *
+	 * A valid PNP ID must be of the form "AAA####" where A is an uppercase
+	 * letter and # is a hex digit. A valid ACPI ID must be of the form
+	 * "ACPI####" where # is a hex digit.
+	 */
+	for (dest = new_string->string.pointer; *source; dest++, source++) {
+		*dest = (char)ACPI_TOUPPER(*source);
+	}
+
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = new_string;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_ns_repair_TSS
  *
  * PARAMETERS:  Data                - Pointer to validation data structure
-- 
1.7.3.2.90.gd4c43

