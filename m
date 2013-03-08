From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/21] ACPICA: Split object conversion functions to a new file
Date: Fri,  8 Mar 2013 17:23:16 +0800
Message-ID: <6abc10c394630d8c6f162749a7913ab3d63ba7c6.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16200 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3CHJX3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:23:29 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

New file, nsconvert.c, for return object conversion functions.
Created in preparation for new conversion functions forthcoming.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile    |    1 +
 drivers/acpi/acpica/acnamesp.h  |   15 ++
 drivers/acpi/acpica/nsconvert.c |  302 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsrepair.c  |  262 ---------------------------------
 4 files changed, 318 insertions(+), 262 deletions(-)
 create mode 100644 drivers/acpi/acpica/nsconvert.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index a1b9bf5..5a542c8 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -83,6 +83,7 @@ acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 acpi-y +=		\
 	nsaccess.o	\
 	nsalloc.o	\
+	nsconvert.o	\
 	nsdump.o	\
 	nseval.o	\
 	nsinit.o	\
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index dec6e9e..7156bc7 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -167,6 +167,21 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent);
 int acpi_ns_compare_names(char *name1, char *name2);
 
 /*
+ * nsconvert - Dynamic object conversion routines
+ */
+acpi_status
+acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object);
+
+acpi_status
+acpi_ns_convert_to_string(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object);
+
+acpi_status
+acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object);
+
+/*
  * nsdump - Namespace dump/print utilities
  */
 #ifdef	ACPI_FUTURE_USAGE
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
new file mode 100644
index 0000000..fcb7dfb
--- /dev/null
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -0,0 +1,302 @@
+/******************************************************************************
+ *
+ * Module Name: nsconvert - Object conversions for objects returned by
+ *                          predefined methods
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2013, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acinterp.h"
+#include "acpredef.h"
+#include "amlresrc.h"
+
+#define _COMPONENT          ACPI_NAMESPACE
+ACPI_MODULE_NAME("nsconvert")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_integer
+ *
+ * PARAMETERS:  original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful.
+ *
+ * DESCRIPTION: Attempt to convert a String/Buffer object to an Integer.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	acpi_status status;
+	u64 value = 0;
+	u32 i;
+
+	switch (original_object->common.type) {
+	case ACPI_TYPE_STRING:
+
+		/* String-to-Integer conversion */
+
+		status = acpi_ut_strtoul64(original_object->string.pointer,
+					   ACPI_ANY_BASE, &value);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		/* Buffer-to-Integer conversion. Max buffer size is 64 bits. */
+
+		if (original_object->buffer.length > 8) {
+			return (AE_AML_OPERAND_TYPE);
+		}
+
+		/* Extract each buffer byte to create the integer */
+
+		for (i = 0; i < original_object->buffer.length; i++) {
+			value |=
+			    ((u64)original_object->buffer.
+			     pointer[i] << (i * 8));
+		}
+		break;
+
+	default:
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	new_object = acpi_ut_create_integer_object(value);
+	if (!new_object) {
+		return (AE_NO_MEMORY);
+	}
+
+	*return_object = new_object;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_string
+ *
+ * PARAMETERS:  original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful.
+ *
+ * DESCRIPTION: Attempt to convert a Integer/Buffer object to a String.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_convert_to_string(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	acpi_size length;
+	acpi_status status;
+
+	switch (original_object->common.type) {
+	case ACPI_TYPE_INTEGER:
+		/*
+		 * Integer-to-String conversion. Commonly, convert
+		 * an integer of value 0 to a NULL string. The last element of
+		 * _BIF and _BIX packages occasionally need this fix.
+		 */
+		if (original_object->integer.value == 0) {
+
+			/* Allocate a new NULL string object */
+
+			new_object = acpi_ut_create_string_object(0);
+			if (!new_object) {
+				return (AE_NO_MEMORY);
+			}
+		} else {
+			status =
+			    acpi_ex_convert_to_string(original_object,
+						      &new_object,
+						      ACPI_IMPLICIT_CONVERT_HEX);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+		}
+		break;
+
+	case ACPI_TYPE_BUFFER:
+		/*
+		 * Buffer-to-String conversion. Use a to_string
+		 * conversion, no transform performed on the buffer data. The best
+		 * example of this is the _BIF method, where the string data from
+		 * the battery is often (incorrectly) returned as buffer object(s).
+		 */
+		length = 0;
+		while ((length < original_object->buffer.length) &&
+		       (original_object->buffer.pointer[length])) {
+			length++;
+		}
+
+		/* Allocate a new string object */
+
+		new_object = acpi_ut_create_string_object(length);
+		if (!new_object) {
+			return (AE_NO_MEMORY);
+		}
+
+		/*
+		 * Copy the raw buffer data with no transform. String is already NULL
+		 * terminated at Length+1.
+		 */
+		ACPI_MEMCPY(new_object->string.pointer,
+			    original_object->buffer.pointer, length);
+		break;
+
+	default:
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	*return_object = new_object;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_buffer
+ *
+ * PARAMETERS:  original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful.
+ *
+ * DESCRIPTION: Attempt to convert a Integer/String/Package object to a Buffer.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	acpi_status status;
+	union acpi_operand_object **elements;
+	u32 *dword_buffer;
+	u32 count;
+	u32 i;
+
+	switch (original_object->common.type) {
+	case ACPI_TYPE_INTEGER:
+		/*
+		 * Integer-to-Buffer conversion.
+		 * Convert the Integer to a packed-byte buffer. _MAT and other
+		 * objects need this sometimes, if a read has been performed on a
+		 * Field object that is less than or equal to the global integer
+		 * size (32 or 64 bits).
+		 */
+		status =
+		    acpi_ex_convert_to_buffer(original_object, &new_object);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		/* String-to-Buffer conversion. Simple data copy */
+
+		new_object =
+		    acpi_ut_create_buffer_object(original_object->string.
+						 length);
+		if (!new_object) {
+			return (AE_NO_MEMORY);
+		}
+
+		ACPI_MEMCPY(new_object->buffer.pointer,
+			    original_object->string.pointer,
+			    original_object->string.length);
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+		/*
+		 * This case is often seen for predefined names that must return a
+		 * Buffer object with multiple DWORD integers within. For example,
+		 * _FDE and _GTM. The Package can be converted to a Buffer.
+		 */
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
+			*dword_buffer = (u32)(*elements)->integer.value;
+			dword_buffer++;
+			elements++;
+		}
+		break;
+
+	default:
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	*return_object = new_object;
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index f9c9fd4..c5e828f 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -84,18 +84,6 @@ ACPI_MODULE_NAME("nsrepair")
  *
  ******************************************************************************/
 /* Local prototypes */
-static acpi_status
-acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
-			   union acpi_operand_object **return_object);
-
-static acpi_status
-acpi_ns_convert_to_string(union acpi_operand_object *original_object,
-			  union acpi_operand_object **return_object);
-
-static acpi_status
-acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
-			  union acpi_operand_object **return_object);
-
 static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
 									 acpi_namespace_node
 									 *node,
@@ -344,256 +332,6 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_convert_to_integer
- *
- * PARAMETERS:  original_object     - Object to be converted
- *              return_object       - Where the new converted object is returned
- *
- * RETURN:      Status. AE_OK if conversion was successful.
- *
- * DESCRIPTION: Attempt to convert a String/Buffer object to an Integer.
- *
- ******************************************************************************/
-
-static acpi_status
-acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
-			   union acpi_operand_object **return_object)
-{
-	union acpi_operand_object *new_object;
-	acpi_status status;
-	u64 value = 0;
-	u32 i;
-
-	switch (original_object->common.type) {
-	case ACPI_TYPE_STRING:
-
-		/* String-to-Integer conversion */
-
-		status = acpi_ut_strtoul64(original_object->string.pointer,
-					   ACPI_ANY_BASE, &value);
-		if (ACPI_FAILURE(status)) {
-			return (status);
-		}
-		break;
-
-	case ACPI_TYPE_BUFFER:
-
-		/* Buffer-to-Integer conversion. Max buffer size is 64 bits. */
-
-		if (original_object->buffer.length > 8) {
-			return (AE_AML_OPERAND_TYPE);
-		}
-
-		/* Extract each buffer byte to create the integer */
-
-		for (i = 0; i < original_object->buffer.length; i++) {
-			value |=
-			    ((u64) original_object->buffer.
-			     pointer[i] << (i * 8));
-		}
-		break;
-
-	default:
-		return (AE_AML_OPERAND_TYPE);
-	}
-
-	new_object = acpi_ut_create_integer_object(value);
-	if (!new_object) {
-		return (AE_NO_MEMORY);
-	}
-
-	*return_object = new_object;
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_convert_to_string
- *
- * PARAMETERS:  original_object     - Object to be converted
- *              return_object       - Where the new converted object is returned
- *
- * RETURN:      Status. AE_OK if conversion was successful.
- *
- * DESCRIPTION: Attempt to convert a Integer/Buffer object to a String.
- *
- ******************************************************************************/
-
-static acpi_status
-acpi_ns_convert_to_string(union acpi_operand_object *original_object,
-			  union acpi_operand_object **return_object)
-{
-	union acpi_operand_object *new_object;
-	acpi_size length;
-	acpi_status status;
-
-	switch (original_object->common.type) {
-	case ACPI_TYPE_INTEGER:
-		/*
-		 * Integer-to-String conversion. Commonly, convert
-		 * an integer of value 0 to a NULL string. The last element of
-		 * _BIF and _BIX packages occasionally need this fix.
-		 */
-		if (original_object->integer.value == 0) {
-
-			/* Allocate a new NULL string object */
-
-			new_object = acpi_ut_create_string_object(0);
-			if (!new_object) {
-				return (AE_NO_MEMORY);
-			}
-		} else {
-			status =
-			    acpi_ex_convert_to_string(original_object,
-						      &new_object,
-						      ACPI_IMPLICIT_CONVERT_HEX);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
-		}
-		break;
-
-	case ACPI_TYPE_BUFFER:
-		/*
-		 * Buffer-to-String conversion. Use a to_string
-		 * conversion, no transform performed on the buffer data. The best
-		 * example of this is the _BIF method, where the string data from
-		 * the battery is often (incorrectly) returned as buffer object(s).
-		 */
-		length = 0;
-		while ((length < original_object->buffer.length) &&
-		       (original_object->buffer.pointer[length])) {
-			length++;
-		}
-
-		/* Allocate a new string object */
-
-		new_object = acpi_ut_create_string_object(length);
-		if (!new_object) {
-			return (AE_NO_MEMORY);
-		}
-
-		/*
-		 * Copy the raw buffer data with no transform. String is already NULL
-		 * terminated at Length+1.
-		 */
-		ACPI_MEMCPY(new_object->string.pointer,
-			    original_object->buffer.pointer, length);
-		break;
-
-	default:
-		return (AE_AML_OPERAND_TYPE);
-	}
-
-	*return_object = new_object;
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_convert_to_buffer
- *
- * PARAMETERS:  original_object     - Object to be converted
- *              return_object       - Where the new converted object is returned
- *
- * RETURN:      Status. AE_OK if conversion was successful.
- *
- * DESCRIPTION: Attempt to convert a Integer/String/Package object to a Buffer.
- *
- ******************************************************************************/
-
-static acpi_status
-acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
-			  union acpi_operand_object **return_object)
-{
-	union acpi_operand_object *new_object;
-	acpi_status status;
-	union acpi_operand_object **elements;
-	u32 *dword_buffer;
-	u32 count;
-	u32 i;
-
-	switch (original_object->common.type) {
-	case ACPI_TYPE_INTEGER:
-		/*
-		 * Integer-to-Buffer conversion.
-		 * Convert the Integer to a packed-byte buffer. _MAT and other
-		 * objects need this sometimes, if a read has been performed on a
-		 * Field object that is less than or equal to the global integer
-		 * size (32 or 64 bits).
-		 */
-		status =
-		    acpi_ex_convert_to_buffer(original_object, &new_object);
-		if (ACPI_FAILURE(status)) {
-			return (status);
-		}
-		break;
-
-	case ACPI_TYPE_STRING:
-
-		/* String-to-Buffer conversion. Simple data copy */
-
-		new_object =
-		    acpi_ut_create_buffer_object(original_object->string.
-						 length);
-		if (!new_object) {
-			return (AE_NO_MEMORY);
-		}
-
-		ACPI_MEMCPY(new_object->buffer.pointer,
-			    original_object->string.pointer,
-			    original_object->string.length);
-		break;
-
-	case ACPI_TYPE_PACKAGE:
-		/*
-		 * This case is often seen for predefined names that must return a
-		 * Buffer object with multiple DWORD integers within. For example,
-		 * _FDE and _GTM. The Package can be converted to a Buffer.
-		 */
-
-		/* All elements of the Package must be integers */
-
-		elements = original_object->package.elements;
-		count = original_object->package.count;
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
-		new_object = acpi_ut_create_buffer_object(ACPI_MUL_4(count));
-		if (!new_object) {
-			return (AE_NO_MEMORY);
-		}
-
-		/* Copy the package elements (integers) to the buffer as DWORDs */
-
-		elements = original_object->package.elements;
-		dword_buffer = ACPI_CAST_PTR(u32, new_object->buffer.pointer);
-
-		for (i = 0; i < count; i++) {
-			*dword_buffer = (u32) (*elements)->integer.value;
-			dword_buffer++;
-			elements++;
-		}
-		break;
-
-	default:
-		return (AE_AML_OPERAND_TYPE);
-	}
-
-	*return_object = new_object;
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_repair_null_element
  *
  * PARAMETERS:  data                - Pointer to validation data structure
-- 
1.7.10

