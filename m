From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/21] ACPICA: Return object repair: Add resource template repairs
Date: Fri,  8 Mar 2013 17:23:32 +0800
Message-ID: <e8a887c3a9573605d7ffa98013346a8b2df49b0a.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56722 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3CHJXn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:23:43 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Fixes several possible problems with resource templates returned
by _CRS/_PRS/_DMA predefined names. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h  |    4 ++
 drivers/acpi/acpica/nsconvert.c |   77 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsrepair.c  |   18 +++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index b6ee519..6475962 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -185,6 +185,10 @@ acpi_status
 acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
 			   union acpi_operand_object **return_object);
 
+acpi_status
+acpi_ns_convert_to_resource(union acpi_operand_object *original_object,
+			    union acpi_operand_object **return_object);
+
 /*
  * nsdump - Namespace dump/print utilities
  */
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index 84f6699..8f79a9d 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -364,3 +364,80 @@ acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
 	*return_object = new_object;
 	return (AE_OK);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_resource
+ *
+ * PARAMETERS:  original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful
+ *
+ * DESCRIPTION: Attempt to convert a Integer object to a resource_template
+ *              Buffer.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_convert_to_resource(union acpi_operand_object *original_object,
+			    union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	u8 *buffer;
+
+	/*
+	 * We can fix the following cases for an expected resource template:
+	 * 1. No return value (interpreter slack mode is disabled)
+	 * 2. A "Return (Zero)" statement
+	 * 3. A "Return empty buffer" statement
+	 *
+	 * We will return a buffer containing a single end_tag
+	 * resource descriptor.
+	 */
+	if (original_object) {
+		switch (original_object->common.type) {
+		case ACPI_TYPE_INTEGER:
+
+			/* We can only repair an Integer==0 */
+
+			if (original_object->integer.value) {
+				return (AE_AML_OPERAND_TYPE);
+			}
+			break;
+
+		case ACPI_TYPE_BUFFER:
+
+			if (original_object->buffer.length) {
+
+				/* Additional checks can be added in the future */
+
+				*return_object = NULL;
+				return (AE_OK);
+			}
+			break;
+
+		case ACPI_TYPE_STRING:
+		default:
+
+			return (AE_AML_OPERAND_TYPE);
+		}
+	}
+
+	/* Create the new buffer object for the resource descriptor */
+
+	new_object = acpi_ut_create_buffer_object(2);
+	if (!new_object) {
+		return (AE_NO_MEMORY);
+	}
+
+	buffer = ACPI_CAST_PTR(u8, new_object->buffer.pointer);
+
+	/* Initialize the Buffer with a single end_tag descriptor */
+
+	buffer[0] = (ACPI_RESOURCE_NAME_END_TAG | ASL_RDESC_END_TAG_SIZE);
+	buffer[1] = 0x00;
+
+	*return_object = new_object;
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index a1918fd..18f02e4 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -98,6 +98,24 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
  * 2nd argument: Unexpected types that can be repaired
  */
 static const struct acpi_simple_repair_info acpi_object_repair_info[] = {
+	/* Resource descriptor conversions */
+
+	{"_CRS",
+	 ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER |
+	 ACPI_RTYPE_NONE,
+	 ACPI_NOT_PACKAGE_ELEMENT,
+	 acpi_ns_convert_to_resource},
+	{"_DMA",
+	 ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER |
+	 ACPI_RTYPE_NONE,
+	 ACPI_NOT_PACKAGE_ELEMENT,
+	 acpi_ns_convert_to_resource},
+	{"_PRS",
+	 ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER |
+	 ACPI_RTYPE_NONE,
+	 ACPI_NOT_PACKAGE_ELEMENT,
+	 acpi_ns_convert_to_resource},
+
 	/* Unicode conversions */
 
 	{"_MLS", ACPI_RTYPE_STRING, 1,
-- 
1.7.10

