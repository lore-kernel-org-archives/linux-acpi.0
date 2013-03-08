From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/21] ACPICA: Return object repair: Add string-to-unicode conversion
Date: Fri,  8 Mar 2013 17:23:24 +0800
Message-ID: <47f1722a61300041dac957e0a8b0149330e00801.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60772 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3CHJXf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:23:35 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Used for the _STR and _MLS predefined names.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h  |    4 +++
 drivers/acpi/acpica/nsconvert.c |   64 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsrepair.c  |    7 +++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 7156bc7..b6ee519 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -181,6 +181,10 @@ acpi_status
 acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 			  union acpi_operand_object **return_object);
 
+acpi_status
+acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object);
+
 /*
  * nsdump - Namespace dump/print utilities
  */
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index fcb7dfb..84f6699 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -300,3 +300,67 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 	*return_object = new_object;
 	return (AE_OK);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_unicode
+ *
+ * PARAMETERS:  original_object     - ASCII String Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful.
+ *
+ * DESCRIPTION: Attempt to convert a String object to a Unicode string Buffer.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	char *ascii_string;
+	u16 *unicode_buffer;
+	u32 unicode_length;
+	u32 i;
+
+	if (!original_object) {
+		return (AE_OK);
+	}
+
+	/* If a Buffer was returned, it must be at least two bytes long */
+
+	if (original_object->common.type == ACPI_TYPE_BUFFER) {
+		if (original_object->buffer.length < 2) {
+			return (AE_AML_OPERAND_VALUE);
+		}
+
+		*return_object = NULL;
+		return (AE_OK);
+	}
+
+	/*
+	 * The original object is an ASCII string. Convert this string to
+	 * a unicode buffer.
+	 */
+	ascii_string = original_object->string.pointer;
+	unicode_length = (original_object->string.length * 2) + 2;
+
+	/* Create a new buffer object for the Unicode data */
+
+	new_object = acpi_ut_create_buffer_object(unicode_length);
+	if (!new_object) {
+		return (AE_NO_MEMORY);
+	}
+
+	unicode_buffer = ACPI_CAST_PTR(u16, new_object->buffer.pointer);
+
+	/* Convert ASCII to Unicode */
+
+	for (i = 0; i < original_object->string.length; i++) {
+		unicode_buffer[i] = (u16)ascii_string[i];
+	}
+
+	*return_object = new_object;
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index c5e828f..a1918fd 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -98,6 +98,13 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
  * 2nd argument: Unexpected types that can be repaired
  */
 static const struct acpi_simple_repair_info acpi_object_repair_info[] = {
+	/* Unicode conversions */
+
+	{"_MLS", ACPI_RTYPE_STRING, 1,
+	 acpi_ns_convert_to_unicode},
+	{"_STR", ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER,
+	 ACPI_NOT_PACKAGE_ELEMENT,
+	 acpi_ns_convert_to_unicode},
 	{{0, 0, 0, 0}, 0, 0, NULL}	/* Table terminator */
 };
 
-- 
1.7.10

