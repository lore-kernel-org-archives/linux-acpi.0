From: Len Brown <lenb@kernel.org>
Subject: [PATCH 066/103] ACPICA: Add more conversions to predefined name repair
 module
Date: Wed, 16 Dec 2009 03:36:17 -0500
Message-ID: <47e11d54d2a516461d89cbb3f2fb87084056af72.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759667AbZLPMF6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:05:58 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:53 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change enhances the automatic repairs/conversions for
predefined name return values to make Integers, Strings, and
Buffers fully interchangeable. Also, a Buffer can be converted
to a Package of Integers if necessary. The nsrepair.c module was
completely restructured.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |  403 ++++++++++++++++++++++++++++++++--------
 1 files changed, 327 insertions(+), 76 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index d563f1a..10629fa 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -45,13 +45,52 @@
 #include "accommon.h"
 #include "acnamesp.h"
 #include "acinterp.h"
-#include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsrepair")
 
 /*******************************************************************************
  *
+ * This module attempts to repair or convert objects returned by the
+ * predefined methods to an object type that is expected, as per the ACPI
+ * specification. The need for this code is dictated by the many machines that
+ * return incorrect types for the standard predefined methods. Performing these
+ * conversions here, in one place, eliminates the need for individual ACPI
+ * device drivers to do the same. Note: Most of these conversions are different
+ * than the internal object conversion routines used for implicit object
+ * conversion.
+ *
+ * The following conversions can be performed as necessary:
+ *
+ * Integer -> String
+ * Integer -> Buffer
+ * String  -> Integer
+ * String  -> Buffer
+ * Buffer  -> Integer
+ * Buffer  -> String
+ * Buffer  -> Package of Integers
+ * Package -> Package of one Package
+ *
+ ******************************************************************************/
+/* Local prototypes */
+static acpi_status
+acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object);
+
+static acpi_status
+acpi_ns_convert_to_string(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object);
+
+static acpi_status
+acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object);
+
+static acpi_status
+acpi_ns_convert_to_package(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object);
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ns_repair_object
  *
  * PARAMETERS:  Data                - Pointer to validation data structure
@@ -68,6 +107,7 @@ ACPI_MODULE_NAME("nsrepair")
  *              not expected.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ns_repair_object(struct acpi_predefined_data *data,
 		      u32 expected_btypes,
@@ -76,32 +116,205 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
 	union acpi_operand_object *new_object;
-	acpi_size length;
 	acpi_status status;
 
 	/*
 	 * At this point, we know that the type of the returned object was not
 	 * one of the expected types for this predefined name. Attempt to
-	 * repair the object. Only a limited number of repairs are possible.
+	 * repair the object by converting it to one of the expected object
+	 * types for this predefined name.
+	 */
+	if (expected_btypes & ACPI_RTYPE_INTEGER) {
+		status = acpi_ns_convert_to_integer(return_object, &new_object);
+		if (ACPI_SUCCESS(status)) {
+			goto object_repaired;
+		}
+	}
+	if (expected_btypes & ACPI_RTYPE_STRING) {
+		status = acpi_ns_convert_to_string(return_object, &new_object);
+		if (ACPI_SUCCESS(status)) {
+			goto object_repaired;
+		}
+	}
+	if (expected_btypes & ACPI_RTYPE_BUFFER) {
+		status = acpi_ns_convert_to_buffer(return_object, &new_object);
+		if (ACPI_SUCCESS(status)) {
+			goto object_repaired;
+		}
+	}
+	if (expected_btypes & ACPI_RTYPE_PACKAGE) {
+		status = acpi_ns_convert_to_package(return_object, &new_object);
+		if (ACPI_SUCCESS(status)) {
+			goto object_repaired;
+		}
+	}
+
+	/* We cannot repair this object */
+
+	return (AE_AML_OPERAND_TYPE);
+
+      object_repaired:
+
+	/* Object was successfully repaired */
+
+	/*
+	 * If the original object is a package element, we need to:
+	 * 1. Set the reference count of the new object to match the
+	 *    reference count of the old object.
+	 * 2. Decrement the reference count of the original object.
 	 */
-	switch (return_object->common.type) {
+	if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
+		new_object->common.reference_count =
+		    return_object->common.reference_count;
+
+		if (return_object->common.reference_count > 1) {
+			return_object->common.reference_count--;
+		}
+
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted %s to expected %s at index %u",
+				      acpi_ut_get_object_type_name
+				      (return_object),
+				      acpi_ut_get_object_type_name(new_object),
+				      package_index));
+	} else {
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted %s to expected %s",
+				      acpi_ut_get_object_type_name
+				      (return_object),
+				      acpi_ut_get_object_type_name
+				      (new_object)));
+	}
+
+	/* Delete old object, install the new return object */
+
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = new_object;
+	data->flags |= ACPI_OBJECT_REPAIRED;
+	return (AE_OK);
+}
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
+
+static acpi_status
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
 	case ACPI_TYPE_BUFFER:
 
-		/* Does the method/object legally return a string? */
+		/* Buffer-to-Integer conversion. Max buffer size is 64 bits. */
 
-		if (!(expected_btypes & ACPI_RTYPE_STRING)) {
+		if (original_object->buffer.length > 8) {
 			return (AE_AML_OPERAND_TYPE);
 		}
 
+		/* Extract each buffer byte to create the integer */
+
+		for (i = 0; i < original_object->buffer.length; i++) {
+			value |=
+			    ((u64) original_object->buffer.
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
+static acpi_status
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
 		/*
-		 * Have a Buffer, expected a String, convert. Use a to_string
+		 * Buffer-to-String conversion. Use a to_string
 		 * conversion, no transform performed on the buffer data. The best
 		 * example of this is the _BIF method, where the string data from
 		 * the battery is often (incorrectly) returned as buffer object(s).
 		 */
 		length = 0;
-		while ((length < return_object->buffer.length) &&
-		       (return_object->buffer.pointer[length])) {
+		while ((length < original_object->buffer.length) &&
+		       (original_object->buffer.pointer[length])) {
 			length++;
 		}
 
@@ -117,94 +330,132 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 		 * terminated at Length+1.
 		 */
 		ACPI_MEMCPY(new_object->string.pointer,
-			    return_object->buffer.pointer, length);
+			    original_object->buffer.pointer, length);
 		break;
 
-	case ACPI_TYPE_INTEGER:
+	default:
+		return (AE_AML_OPERAND_TYPE);
+	}
 
-		/* 1) Does the method/object legally return a buffer? */
+	*return_object = new_object;
+	return (AE_OK);
+}
 
-		if (expected_btypes & ACPI_RTYPE_BUFFER) {
-			/*
-			 * Convert the Integer to a packed-byte buffer. _MAT needs
-			 * this sometimes, if a read has been performed on a Field
-			 * object that is less than or equal to the global integer
-			 * size (32 or 64 bits).
-			 */
-			status =
-			    acpi_ex_convert_to_buffer(return_object,
-						      &new_object);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
-		}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_buffer
+ *
+ * PARAMETERS:  original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful.
+ *
+ * DESCRIPTION: Attempt to convert a Integer/String object to a Buffer.
+ *
+ ******************************************************************************/
 
-		/* 2) Does the method/object legally return a string? */
+static acpi_status
+acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
+			  union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	acpi_status status;
 
-		else if (expected_btypes & ACPI_RTYPE_STRING) {
-			/*
-			 * The only supported Integer-to-String conversion is to convert
-			 * an integer of value 0 to a NULL string. The last element of
-			 * _BIF and _BIX packages occasionally need this fix.
-			 */
-			if (return_object->integer.value != 0) {
-				return (AE_AML_OPERAND_TYPE);
-			}
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
 
-			/* Allocate a new NULL string object */
+	case ACPI_TYPE_STRING:
 
-			new_object = acpi_ut_create_string_object(0);
-			if (!new_object) {
-				return (AE_NO_MEMORY);
-			}
-		} else {
-			return (AE_AML_OPERAND_TYPE);
+		/* String-to-Buffer conversion. Simple data copy */
+
+		new_object =
+		    acpi_ut_create_buffer_object(original_object->string.
+						 length);
+		if (!new_object) {
+			return (AE_NO_MEMORY);
 		}
+
+		ACPI_MEMCPY(new_object->buffer.pointer,
+			    original_object->string.pointer,
+			    original_object->string.length);
 		break;
 
 	default:
-
-		/* We cannot repair this object */
-
 		return (AE_AML_OPERAND_TYPE);
 	}
 
-	/* Object was successfully repaired */
+	*return_object = new_object;
+	return (AE_OK);
+}
 
-	/*
-	 * If the original object is a package element, we need to:
-	 * 1. Set the reference count of the new object to match the
-	 *    reference count of the old object.
-	 * 2. Decrement the reference count of the original object.
-	 */
-	if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
-		new_object->common.reference_count =
-		    return_object->common.reference_count;
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_package
+ *
+ * PARAMETERS:  original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful.
+ *
+ * DESCRIPTION: Attempt to convert a Buffer object to a Package. Each byte of
+ *              the buffer is converted to a single integer package element.
+ *
+ ******************************************************************************/
 
-		if (return_object->common.reference_count > 1) {
-			return_object->common.reference_count--;
+static acpi_status
+acpi_ns_convert_to_package(union acpi_operand_object *original_object,
+			   union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object;
+	union acpi_operand_object **elements;
+	u32 length;
+	u8 *buffer;
+
+	switch (original_object->common.type) {
+	case ACPI_TYPE_BUFFER:
+
+		/* Buffer-to-Package conversion */
+
+		length = original_object->buffer.length;
+		new_object = acpi_ut_create_package_object(length);
+		if (!new_object) {
+			return (AE_NO_MEMORY);
 		}
 
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "Converted %s to expected %s at index %u",
-				      acpi_ut_get_object_type_name
-				      (return_object),
-				      acpi_ut_get_object_type_name(new_object),
-				      package_index));
-	} else {
-		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-				      "Converted %s to expected %s",
-				      acpi_ut_get_object_type_name
-				      (return_object),
-				      acpi_ut_get_object_type_name
-				      (new_object)));
-	}
+		/* Convert each buffer byte to an integer package element */
 
-	/* Delete old object, install the new return object */
+		elements = new_object->package.elements;
+		buffer = original_object->buffer.pointer;
 
-	acpi_ut_remove_reference(return_object);
-	*return_object_ptr = new_object;
-	data->flags |= ACPI_OBJECT_REPAIRED;
+		while (length--) {
+			*elements = acpi_ut_create_integer_object(*buffer);
+			if (!*elements) {
+				acpi_ut_remove_reference(new_object);
+				return (AE_NO_MEMORY);
+			}
+			elements++;
+			buffer++;
+		}
+		break;
+
+	default:
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	*return_object = new_object;
 	return (AE_OK);
 }
 
-- 
1.6.0.6

