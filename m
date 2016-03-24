From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/30] ACPICA: Intepreter: Add object extensions to Concatenate operand
Date: Thu, 24 Mar 2016 09:39:51 +0800
Message-ID: <de431e17e1c0d6dc12cb7cfac2c3a118105cc035.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 60d9cfd403a9824199b971597c930f6f563e5c71

Allows all object types to be used with Concatenate. Objects
other than Int/Str/Buf are convert to a string that contains
the type of the object. Improves the utility of the Printf
and Fprintf macros.

Adds a new file, exconcat.c

Link: https://github.com/acpica/acpica/commit/60d9cfd4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile   |    1 +
 drivers/acpi/acpica/exconcat.c |  439 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/exmisc.c   |  290 --------------------------
 3 files changed, 440 insertions(+), 290 deletions(-)
 create mode 100644 drivers/acpi/acpica/exconcat.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index f682374..188597f 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -43,6 +43,7 @@ acpi-y +=		\
 	evxfregn.o
 
 acpi-y +=		\
+	exconcat.o	\
 	exconfig.o	\
 	exconvrt.o	\
 	excreate.o	\
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
new file mode 100644
index 0000000..553e014
--- /dev/null
+++ b/drivers/acpi/acpica/exconcat.c
@@ -0,0 +1,439 @@
+/******************************************************************************
+ *
+ * Module Name: exconcat - Concatenate-type AML operators
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2016, Intel Corp.
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
+#include "acinterp.h"
+#include "amlresrc.h"
+
+#define _COMPONENT          ACPI_EXECUTER
+ACPI_MODULE_NAME("exconcat")
+
+/* Local Prototypes */
+static acpi_status
+acpi_ex_convert_to_object_type_string(union acpi_operand_object *obj_desc,
+				      union acpi_operand_object **result_desc);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_do_concatenate
+ *
+ * PARAMETERS:  operand0            - First source object
+ *              operand1            - Second source object
+ *              actual_return_desc  - Where to place the return object
+ *              walk_state          - Current walk state
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Concatenate two objects with the ACPI-defined conversion
+ *              rules as necessary.
+ * NOTE:
+ * Per the ACPI spec (up to 6.1), Concatenate only supports Integer,
+ * String, and Buffer objects. However, we support all objects here
+ * as an extension. This improves the usefulness of both Concatenate
+ * and the Printf/Fprintf macros. The extension returns a string
+ * describing the object type for the other objects.
+ * 02/2016.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ex_do_concatenate(union acpi_operand_object *operand0,
+		       union acpi_operand_object *operand1,
+		       union acpi_operand_object **actual_return_desc,
+		       struct acpi_walk_state *walk_state)
+{
+	union acpi_operand_object *local_operand0 = operand0;
+	union acpi_operand_object *local_operand1 = operand1;
+	union acpi_operand_object *temp_operand1 = NULL;
+	union acpi_operand_object *return_desc;
+	char *buffer;
+	acpi_object_type operand0_type;
+	acpi_object_type operand1_type;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ex_do_concatenate);
+
+	/* Operand 0 preprocessing */
+
+	switch (operand0->common.type) {
+	case ACPI_TYPE_INTEGER:
+	case ACPI_TYPE_STRING:
+	case ACPI_TYPE_BUFFER:
+
+		operand0_type = operand0->common.type;
+		break;
+
+	default:
+
+		/* For all other types, get the "object type" string */
+
+		status =
+		    acpi_ex_convert_to_object_type_string(operand0,
+							  &local_operand0);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
+		operand0_type = ACPI_TYPE_STRING;
+		break;
+	}
+
+	/* Operand 1 preprocessing */
+
+	switch (operand1->common.type) {
+	case ACPI_TYPE_INTEGER:
+	case ACPI_TYPE_STRING:
+	case ACPI_TYPE_BUFFER:
+
+		operand1_type = operand1->common.type;
+		break;
+
+	default:
+
+		/* For all other types, get the "object type" string */
+
+		status =
+		    acpi_ex_convert_to_object_type_string(operand1,
+							  &local_operand1);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
+		operand1_type = ACPI_TYPE_STRING;
+		break;
+	}
+
+	/*
+	 * Convert the second operand if necessary. The first operand (0)
+	 * determines the type of the second operand (1) (See the Data Types
+	 * section of the ACPI specification). Both object types are
+	 * guaranteed to be either Integer/String/Buffer by the operand
+	 * resolution mechanism.
+	 */
+	switch (operand0_type) {
+	case ACPI_TYPE_INTEGER:
+
+		status =
+		    acpi_ex_convert_to_integer(local_operand1, &temp_operand1,
+					       16);
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		status =
+		    acpi_ex_convert_to_buffer(local_operand1, &temp_operand1);
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		switch (operand1_type) {
+		case ACPI_TYPE_INTEGER:
+		case ACPI_TYPE_STRING:
+		case ACPI_TYPE_BUFFER:
+
+			/* Other types have already been converted to string */
+
+			status =
+			    acpi_ex_convert_to_string(local_operand1,
+						      &temp_operand1,
+						      ACPI_IMPLICIT_CONVERT_HEX);
+			break;
+
+		default:
+
+			status = AE_OK;
+			break;
+		}
+		break;
+
+	default:
+
+		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
+			    operand0->common.type));
+		status = AE_AML_INTERNAL;
+	}
+
+	if (ACPI_FAILURE(status)) {
+		goto cleanup;
+	}
+
+	/* Take care with any newly created operand objects */
+
+	if ((local_operand1 != operand1) && (local_operand1 != temp_operand1)) {
+		acpi_ut_remove_reference(local_operand1);
+	}
+
+	local_operand1 = temp_operand1;
+
+	/*
+	 * Both operands are now known to be the same object type
+	 * (Both are Integer, String, or Buffer), and we can now perform
+	 * the concatenation.
+	 *
+	 * There are three cases to handle, as per the ACPI spec:
+	 *
+	 * 1) Two Integers concatenated to produce a new Buffer
+	 * 2) Two Strings concatenated to produce a new String
+	 * 3) Two Buffers concatenated to produce a new Buffer
+	 */
+	switch (operand0_type) {
+	case ACPI_TYPE_INTEGER:
+
+		/* Result of two Integers is a Buffer */
+		/* Need enough buffer space for two integers */
+
+		return_desc = acpi_ut_create_buffer_object((acpi_size)
+							   ACPI_MUL_2
+							   (acpi_gbl_integer_byte_width));
+		if (!return_desc) {
+			status = AE_NO_MEMORY;
+			goto cleanup;
+		}
+
+		buffer = (char *)return_desc->buffer.pointer;
+
+		/* Copy the first integer, LSB first */
+
+		memcpy(buffer, &operand0->integer.value,
+		       acpi_gbl_integer_byte_width);
+
+		/* Copy the second integer (LSB first) after the first */
+
+		memcpy(buffer + acpi_gbl_integer_byte_width,
+		       &local_operand1->integer.value,
+		       acpi_gbl_integer_byte_width);
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		/* Result of two Strings is a String */
+
+		return_desc = acpi_ut_create_string_object(((acpi_size)
+							    local_operand0->
+							    string.length +
+							    local_operand1->
+							    string.length));
+		if (!return_desc) {
+			status = AE_NO_MEMORY;
+			goto cleanup;
+		}
+
+		buffer = return_desc->string.pointer;
+
+		/* Concatenate the strings */
+
+		strcpy(buffer, local_operand0->string.pointer);
+		strcat(buffer, local_operand1->string.pointer);
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		/* Result of two Buffers is a Buffer */
+
+		return_desc = acpi_ut_create_buffer_object(((acpi_size)
+							    operand0->buffer.
+							    length +
+							    local_operand1->
+							    buffer.length));
+		if (!return_desc) {
+			status = AE_NO_MEMORY;
+			goto cleanup;
+		}
+
+		buffer = (char *)return_desc->buffer.pointer;
+
+		/* Concatenate the buffers */
+
+		memcpy(buffer, operand0->buffer.pointer,
+		       operand0->buffer.length);
+		memcpy(buffer + operand0->buffer.length,
+		       local_operand1->buffer.pointer,
+		       local_operand1->buffer.length);
+		break;
+
+	default:
+
+		/* Invalid object type, should not happen here */
+
+		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
+			    operand0->common.type));
+		status = AE_AML_INTERNAL;
+		goto cleanup;
+	}
+
+	*actual_return_desc = return_desc;
+
+cleanup:
+	if (local_operand0 != operand0) {
+		acpi_ut_remove_reference(local_operand0);
+	}
+
+	if (local_operand1 != operand1) {
+		acpi_ut_remove_reference(local_operand1);
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_convert_to_object_type_string
+ *
+ * PARAMETERS:  obj_desc            - Object to be converted
+ *              return_desc         - Where to place the return object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert an object of arbitrary type to a string object that
+ *              contains the namestring for the object. Used for the
+ *              concatenate operator.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ex_convert_to_object_type_string(union acpi_operand_object *obj_desc,
+				      union acpi_operand_object **result_desc)
+{
+	union acpi_operand_object *return_desc;
+	const char *type_string;
+
+	type_string = acpi_ut_get_type_name(obj_desc->common.type);
+
+	return_desc = acpi_ut_create_string_object(((acpi_size) strlen(type_string) + 9));	/* 9 For "[ Object]" */
+	if (!return_desc) {
+		return (AE_NO_MEMORY);
+	}
+
+	strcpy(return_desc->string.pointer, "[");
+	strcat(return_desc->string.pointer, type_string);
+	strcat(return_desc->string.pointer, " Object]");
+
+	*result_desc = return_desc;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_concat_template
+ *
+ * PARAMETERS:  operand0            - First source object
+ *              operand1            - Second source object
+ *              actual_return_desc  - Where to place the return object
+ *              walk_state          - Current walk state
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Concatenate two resource templates
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ex_concat_template(union acpi_operand_object *operand0,
+			union acpi_operand_object *operand1,
+			union acpi_operand_object **actual_return_desc,
+			struct acpi_walk_state * walk_state)
+{
+	acpi_status status;
+	union acpi_operand_object *return_desc;
+	u8 *new_buf;
+	u8 *end_tag;
+	acpi_size length0;
+	acpi_size length1;
+	acpi_size new_length;
+
+	ACPI_FUNCTION_TRACE(ex_concat_template);
+
+	/*
+	 * Find the end_tag descriptor in each resource template.
+	 * Note1: returned pointers point TO the end_tag, not past it.
+	 * Note2: zero-length buffers are allowed; treated like one end_tag
+	 */
+
+	/* Get the length of the first resource template */
+
+	status = acpi_ut_get_resource_end_tag(operand0, &end_tag);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	length0 = ACPI_PTR_DIFF(end_tag, operand0->buffer.pointer);
+
+	/* Get the length of the second resource template */
+
+	status = acpi_ut_get_resource_end_tag(operand1, &end_tag);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	length1 = ACPI_PTR_DIFF(end_tag, operand1->buffer.pointer);
+
+	/* Combine both lengths, minimum size will be 2 for end_tag */
+
+	new_length = length0 + length1 + sizeof(struct aml_resource_end_tag);
+
+	/* Create a new buffer object for the result (with one end_tag) */
+
+	return_desc = acpi_ut_create_buffer_object(new_length);
+	if (!return_desc) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	/*
+	 * Copy the templates to the new buffer, 0 first, then 1 follows. One
+	 * end_tag descriptor is copied from Operand1.
+	 */
+	new_buf = return_desc->buffer.pointer;
+	memcpy(new_buf, operand0->buffer.pointer, length0);
+	memcpy(new_buf + length0, operand1->buffer.pointer, length1);
+
+	/* Insert end_tag and set the checksum to zero, means "ignore checksum" */
+
+	new_buf[new_length - 1] = 0;
+	new_buf[new_length - 2] = ACPI_RESOURCE_NAME_END_TAG | 1;
+
+	/* Return the completed resource template */
+
+	*actual_return_desc = return_desc;
+	return_ACPI_STATUS(AE_OK);
+}
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index db30ae4..4f7e667 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -45,7 +45,6 @@
 #include "accommon.h"
 #include "acinterp.h"
 #include "amlcode.h"
-#include "amlresrc.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exmisc")
@@ -140,295 +139,6 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_concat_template
- *
- * PARAMETERS:  operand0            - First source object
- *              operand1            - Second source object
- *              actual_return_desc  - Where to place the return object
- *              walk_state          - Current walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Concatenate two resource templates
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ex_concat_template(union acpi_operand_object *operand0,
-			union acpi_operand_object *operand1,
-			union acpi_operand_object **actual_return_desc,
-			struct acpi_walk_state *walk_state)
-{
-	acpi_status status;
-	union acpi_operand_object *return_desc;
-	u8 *new_buf;
-	u8 *end_tag;
-	acpi_size length0;
-	acpi_size length1;
-	acpi_size new_length;
-
-	ACPI_FUNCTION_TRACE(ex_concat_template);
-
-	/*
-	 * Find the end_tag descriptor in each resource template.
-	 * Note1: returned pointers point TO the end_tag, not past it.
-	 * Note2: zero-length buffers are allowed; treated like one end_tag
-	 */
-
-	/* Get the length of the first resource template */
-
-	status = acpi_ut_get_resource_end_tag(operand0, &end_tag);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	length0 = ACPI_PTR_DIFF(end_tag, operand0->buffer.pointer);
-
-	/* Get the length of the second resource template */
-
-	status = acpi_ut_get_resource_end_tag(operand1, &end_tag);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	length1 = ACPI_PTR_DIFF(end_tag, operand1->buffer.pointer);
-
-	/* Combine both lengths, minimum size will be 2 for end_tag */
-
-	new_length = length0 + length1 + sizeof(struct aml_resource_end_tag);
-
-	/* Create a new buffer object for the result (with one end_tag) */
-
-	return_desc = acpi_ut_create_buffer_object(new_length);
-	if (!return_desc) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	/*
-	 * Copy the templates to the new buffer, 0 first, then 1 follows. One
-	 * end_tag descriptor is copied from Operand1.
-	 */
-	new_buf = return_desc->buffer.pointer;
-	memcpy(new_buf, operand0->buffer.pointer, length0);
-	memcpy(new_buf + length0, operand1->buffer.pointer, length1);
-
-	/* Insert end_tag and set the checksum to zero, means "ignore checksum" */
-
-	new_buf[new_length - 1] = 0;
-	new_buf[new_length - 2] = ACPI_RESOURCE_NAME_END_TAG | 1;
-
-	/* Return the completed resource template */
-
-	*actual_return_desc = return_desc;
-	return_ACPI_STATUS(AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ex_do_concatenate
- *
- * PARAMETERS:  operand0            - First source object
- *              operand1            - Second source object
- *              actual_return_desc  - Where to place the return object
- *              walk_state          - Current walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Concatenate two objects OF THE SAME TYPE.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ex_do_concatenate(union acpi_operand_object *operand0,
-		       union acpi_operand_object *operand1,
-		       union acpi_operand_object **actual_return_desc,
-		       struct acpi_walk_state *walk_state)
-{
-	union acpi_operand_object *local_operand1 = operand1;
-	union acpi_operand_object *return_desc;
-	char *new_buf;
-	const char *type_string;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ex_do_concatenate);
-
-	/*
-	 * Convert the second operand if necessary. The first operand
-	 * determines the type of the second operand, (See the Data Types
-	 * section of the ACPI specification.)  Both object types are
-	 * guaranteed to be either Integer/String/Buffer by the operand
-	 * resolution mechanism.
-	 */
-	switch (operand0->common.type) {
-	case ACPI_TYPE_INTEGER:
-
-		status =
-		    acpi_ex_convert_to_integer(operand1, &local_operand1, 16);
-		break;
-
-	case ACPI_TYPE_STRING:
-		/*
-		 * Per the ACPI spec, Concatenate only supports int/str/buf.
-		 * However, we support all objects here as an extension.
-		 * This improves the usefulness of the Printf() macro.
-		 * 12/2015.
-		 */
-		switch (operand1->common.type) {
-		case ACPI_TYPE_INTEGER:
-		case ACPI_TYPE_STRING:
-		case ACPI_TYPE_BUFFER:
-
-			status =
-			    acpi_ex_convert_to_string(operand1, &local_operand1,
-						      ACPI_IMPLICIT_CONVERT_HEX);
-			break;
-
-		default:
-			/*
-			 * Just emit a string containing the object type.
-			 */
-			type_string =
-			    acpi_ut_get_type_name(operand1->common.type);
-
-			local_operand1 = acpi_ut_create_string_object(((acpi_size) strlen(type_string) + 9));	/* 9 For "[Object]" */
-			if (!local_operand1) {
-				status = AE_NO_MEMORY;
-				goto cleanup;
-			}
-
-			strcpy(local_operand1->string.pointer, "[");
-			strcat(local_operand1->string.pointer, type_string);
-			strcat(local_operand1->string.pointer, " Object]");
-			status = AE_OK;
-			break;
-		}
-		break;
-
-	case ACPI_TYPE_BUFFER:
-
-		status = acpi_ex_convert_to_buffer(operand1, &local_operand1);
-		break;
-
-	default:
-
-		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
-			    operand0->common.type));
-		status = AE_AML_INTERNAL;
-	}
-
-	if (ACPI_FAILURE(status)) {
-		goto cleanup;
-	}
-
-	/*
-	 * Both operands are now known to be the same object type
-	 * (Both are Integer, String, or Buffer), and we can now perform the
-	 * concatenation.
-	 */
-
-	/*
-	 * There are three cases to handle:
-	 *
-	 * 1) Two Integers concatenated to produce a new Buffer
-	 * 2) Two Strings concatenated to produce a new String
-	 * 3) Two Buffers concatenated to produce a new Buffer
-	 */
-	switch (operand0->common.type) {
-	case ACPI_TYPE_INTEGER:
-
-		/* Result of two Integers is a Buffer */
-		/* Need enough buffer space for two integers */
-
-		return_desc = acpi_ut_create_buffer_object((acpi_size)
-							   ACPI_MUL_2
-							   (acpi_gbl_integer_byte_width));
-		if (!return_desc) {
-			status = AE_NO_MEMORY;
-			goto cleanup;
-		}
-
-		new_buf = (char *)return_desc->buffer.pointer;
-
-		/* Copy the first integer, LSB first */
-
-		memcpy(new_buf, &operand0->integer.value,
-		       acpi_gbl_integer_byte_width);
-
-		/* Copy the second integer (LSB first) after the first */
-
-		memcpy(new_buf + acpi_gbl_integer_byte_width,
-		       &local_operand1->integer.value,
-		       acpi_gbl_integer_byte_width);
-		break;
-
-	case ACPI_TYPE_STRING:
-
-		/* Result of two Strings is a String */
-
-		return_desc = acpi_ut_create_string_object(((acpi_size)
-							    operand0->string.
-							    length +
-							    local_operand1->
-							    string.length));
-		if (!return_desc) {
-			status = AE_NO_MEMORY;
-			goto cleanup;
-		}
-
-		new_buf = return_desc->string.pointer;
-
-		/* Concatenate the strings */
-
-		strcpy(new_buf, operand0->string.pointer);
-		strcat(new_buf, local_operand1->string.pointer);
-		break;
-
-	case ACPI_TYPE_BUFFER:
-
-		/* Result of two Buffers is a Buffer */
-
-		return_desc = acpi_ut_create_buffer_object(((acpi_size)
-							    operand0->buffer.
-							    length +
-							    local_operand1->
-							    buffer.length));
-		if (!return_desc) {
-			status = AE_NO_MEMORY;
-			goto cleanup;
-		}
-
-		new_buf = (char *)return_desc->buffer.pointer;
-
-		/* Concatenate the buffers */
-
-		memcpy(new_buf, operand0->buffer.pointer,
-		       operand0->buffer.length);
-		memcpy(new_buf + operand0->buffer.length,
-		       local_operand1->buffer.pointer,
-		       local_operand1->buffer.length);
-		break;
-
-	default:
-
-		/* Invalid object type, should not happen here */
-
-		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
-			    operand0->common.type));
-		status = AE_AML_INTERNAL;
-		goto cleanup;
-	}
-
-	*actual_return_desc = return_desc;
-
-cleanup:
-	if (local_operand1 != operand1) {
-		acpi_ut_remove_reference(local_operand1);
-	}
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_do_math_op
  *
  * PARAMETERS:  opcode              - AML opcode
-- 
1.7.10
