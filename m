From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/9] ACPICA: Predefined name repair: fix NULL package elements
Date: Mon, 01 Mar 2010 01:56:13 -0500
Message-ID: <091f4d718620a79698e1c8ca3e9acbf78eb62da3.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:64815 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab0CAG4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:25 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL000EYCNTX3B3@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:57:29 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

For the predefined methods that return fixed-length packages
(or subpackages), attempt repair for a NULL element. Create an
Integer of value 0, a NULL String, or a zero-length buffer as
appropriate.

http://www.acpica.org/bugzilla/show_bug.cgi?id=818

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |    1 +
 drivers/acpi/acpica/acnamesp.h  |   16 +++-
 drivers/acpi/acpica/nspredef.c  |   27 ++++++-
 drivers/acpi/acpica/nsrepair.c  |  173 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsrepair2.c |   84 -------------------
 5 files changed, 209 insertions(+), 92 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 2caf141..681205c 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -374,6 +374,7 @@ union acpi_predefined_info {
 struct acpi_predefined_data {
 	char *pathname;
 	const union acpi_predefined_info *predefined;
+	union acpi_operand_object *parent_package;
 	u32 flags;
 	u8 node_flags;
 };
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 73f9b0c..258159c 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -286,6 +286,17 @@ acpi_status
 acpi_ns_repair_package_list(struct acpi_predefined_data *data,
 			    union acpi_operand_object **obj_desc_ptr);
 
+acpi_status
+acpi_ns_repair_null_element(struct acpi_predefined_data *data,
+			    u32 expected_btypes,
+			    u32 package_index,
+			    union acpi_operand_object **return_object_ptr);
+
+void
+acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
+			     u8 package_type,
+			     union acpi_operand_object *obj_desc);
+
 /*
  * nsrepair2 - Return object repair for specific
  * predefined methods/objects
@@ -296,11 +307,6 @@ acpi_ns_complex_repairs(struct acpi_predefined_data *data,
 			acpi_status validate_status,
 			union acpi_operand_object **return_object_ptr);
 
-void
-acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
-			     u8 package_type,
-			     union acpi_operand_object *obj_desc);
-
 /*
  * nssearch - Namespace searching and entry
  */
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index ba1072f..7096bcd 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -231,6 +231,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * Note: Package may have been newly created by call above.
 	 */
 	if ((*return_object_ptr)->common.type == ACPI_TYPE_PACKAGE) {
+		data->parent_package = *return_object_ptr;
 		status = acpi_ns_check_package(data, return_object_ptr);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
@@ -710,6 +711,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	for (i = 0; i < count; i++) {
 		sub_package = *elements;
 		sub_elements = sub_package->package.elements;
+		data->parent_package = sub_package;
 
 		/* Each sub-object must be of type Package */
 
@@ -721,6 +723,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 
 		/* Examine the different types of expected sub-packages */
 
+		data->parent_package = sub_package;
 		switch (package->ret_info.type) {
 		case ACPI_PTYPE2:
 		case ACPI_PTYPE2_PKG_COUNT:
@@ -800,7 +803,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 
 			/*
 			 * First element is the (Integer) count of elements, including
-			 * the count field.
+			 * the count field (the ACPI name is num_elements)
 			 */
 			status = acpi_ns_check_object_type(data, sub_elements,
 							   ACPI_RTYPE_INTEGER,
@@ -822,6 +825,16 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 				expected_count = package->ret_info.count1;
 				goto package_too_small;
 			}
+			if (expected_count == 0) {
+				/*
+				 * Either the num_entries element was originally zero or it was
+				 * a NULL element and repaired to an Integer of value zero.
+				 * In either case, repair it by setting num_entries to be the
+				 * actual size of the subpackage.
+				 */
+				expected_count = sub_package->package.count;
+				(*sub_elements)->integer.value = expected_count;
+			}
 
 			/* Check the type of each sub-package element */
 
@@ -945,10 +958,18 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 	char type_buffer[48];	/* Room for 5 types */
 
 	/*
-	 * If we get a NULL return_object here, it is a NULL package element,
-	 * and this is always an error.
+	 * If we get a NULL return_object here, it is a NULL package element.
+	 * Since all extraneous NULL package elements were removed earlier by a
+	 * call to acpi_ns_remove_null_elements, this is an unexpected NULL element.
+	 * We will attempt to repair it.
 	 */
 	if (!return_object) {
+		status = acpi_ns_repair_null_element(data, expected_btypes,
+						     package_index,
+						     return_object_ptr);
+		if (ACPI_SUCCESS(status)) {
+			return (AE_OK);	/* Repair was successful */
+		}
 		goto type_error_exit;
 	}
 
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index c82060f..d4be377 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acnamesp.h"
 #include "acinterp.h"
+#include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsrepair")
@@ -71,6 +72,12 @@ ACPI_MODULE_NAME("nsrepair")
  * Buffer  -> Package of Integers
  * Package -> Package of one Package
  *
+ * Additional possible repairs:
+ *
+ * Optional/unnecessary NULL package elements removed
+ * Required package elements that are NULL replaced by Integer/String/Buffer
+ * Incorrect standalone package wrapped with required outer package
+ *
  ******************************************************************************/
 /* Local prototypes */
 static acpi_status
@@ -506,6 +513,172 @@ acpi_ns_convert_to_package(union acpi_operand_object *original_object,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ns_repair_null_element
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              expected_btypes     - Object types expected
+ *              package_index       - Index of object within parent package (if
+ *                                    applicable - ACPI_NOT_PACKAGE_ELEMENT
+ *                                    otherwise)
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if repair was successful.
+ *
+ * DESCRIPTION: Attempt to repair a NULL element of a returned Package object.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_repair_null_element(struct acpi_predefined_data *data,
+			    u32 expected_btypes,
+			    u32 package_index,
+			    union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object *new_object;
+
+	ACPI_FUNCTION_NAME(ns_repair_null_element);
+
+	/* No repair needed if return object is non-NULL */
+
+	if (return_object) {
+		return (AE_OK);
+	}
+
+	/*
+	 * Attempt to repair a NULL element of a Package object. This applies to
+	 * predefined names that return a fixed-length package and each element
+	 * is required. It does not apply to variable-length packages where NULL
+	 * elements are allowed, especially at the end of the package.
+	 */
+	if (expected_btypes & ACPI_RTYPE_INTEGER) {
+
+		/* Need an Integer - create a zero-value integer */
+
+		new_object = acpi_ut_create_integer_object(0);
+	} else if (expected_btypes & ACPI_RTYPE_STRING) {
+
+		/* Need a String - create a NULL string */
+
+		new_object = acpi_ut_create_string_object(0);
+	} else if (expected_btypes & ACPI_RTYPE_BUFFER) {
+
+		/* Need a Buffer - create a zero-length buffer */
+
+		new_object = acpi_ut_create_buffer_object(0);
+	} else {
+		/* Error for all other expected types */
+
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	if (!new_object) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Set the reference count according to the parent Package object */
+
+	new_object->common.reference_count =
+	    data->parent_package->common.reference_count;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+			  "%s: Converted NULL package element to expected %s at index %u\n",
+			  data->pathname,
+			  acpi_ut_get_object_type_name(new_object),
+			  package_index));
+
+	*return_object_ptr = new_object;
+	data->flags |= ACPI_OBJECT_REPAIRED;
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_remove_null_elements
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              package_type        - An acpi_return_package_types value
+ *              obj_desc            - A Package object
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Remove all NULL package elements from packages that contain
+ *              a variable number of sub-packages. For these types of
+ *              packages, NULL elements can be safely removed.
+ *
+ *****************************************************************************/
+
+void
+acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
+			     u8 package_type,
+			     union acpi_operand_object *obj_desc)
+{
+	union acpi_operand_object **source;
+	union acpi_operand_object **dest;
+	u32 count;
+	u32 new_count;
+	u32 i;
+
+	ACPI_FUNCTION_NAME(ns_remove_null_elements);
+
+	/*
+	 * PTYPE1 packages contain no subpackages.
+	 * PTYPE2 packages contain a variable number of sub-packages. We can
+	 * safely remove all NULL elements from the PTYPE2 packages.
+	 */
+	switch (package_type) {
+	case ACPI_PTYPE1_FIXED:
+	case ACPI_PTYPE1_VAR:
+	case ACPI_PTYPE1_OPTION:
+		return;
+
+	case ACPI_PTYPE2:
+	case ACPI_PTYPE2_COUNT:
+	case ACPI_PTYPE2_PKG_COUNT:
+	case ACPI_PTYPE2_FIXED:
+	case ACPI_PTYPE2_MIN:
+	case ACPI_PTYPE2_REV_FIXED:
+		break;
+
+	default:
+		return;
+	}
+
+	count = obj_desc->package.count;
+	new_count = count;
+
+	source = obj_desc->package.elements;
+	dest = source;
+
+	/* Examine all elements of the package object, remove nulls */
+
+	for (i = 0; i < count; i++) {
+		if (!*source) {
+			new_count--;
+		} else {
+			*dest = *source;
+			dest++;
+		}
+		source++;
+	}
+
+	/* Update parent package if any null elements were removed */
+
+	if (new_count < count) {
+		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
+				  "%s: Found and removed %u NULL elements\n",
+				  data->pathname, (count - new_count)));
+
+		/* NULL terminate list and update the package count */
+
+		*dest = NULL;
+		obj_desc->package.count = new_count;
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ns_repair_package_list
  *
  * PARAMETERS:  Data                - Pointer to validation data structure
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 29ff5d1..61bd0f6 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -45,7 +45,6 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
-#include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsrepair2")
@@ -520,89 +519,6 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_ns_remove_null_elements
- *
- * PARAMETERS:  Data                - Pointer to validation data structure
- *              package_type        - An acpi_return_package_types value
- *              obj_desc            - A Package object
- *
- * RETURN:      None.
- *
- * DESCRIPTION: Remove all NULL package elements from packages that contain
- *              a variable number of sub-packages.
- *
- *****************************************************************************/
-
-void
-acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
-			     u8 package_type,
-			     union acpi_operand_object *obj_desc)
-{
-	union acpi_operand_object **source;
-	union acpi_operand_object **dest;
-	u32 count;
-	u32 new_count;
-	u32 i;
-
-	ACPI_FUNCTION_NAME(ns_remove_null_elements);
-
-	/*
-	 * PTYPE1 packages contain no subpackages.
-	 * PTYPE2 packages contain a variable number of sub-packages. We can
-	 * safely remove all NULL elements from the PTYPE2 packages.
-	 */
-	switch (package_type) {
-	case ACPI_PTYPE1_FIXED:
-	case ACPI_PTYPE1_VAR:
-	case ACPI_PTYPE1_OPTION:
-		return;
-
-	case ACPI_PTYPE2:
-	case ACPI_PTYPE2_COUNT:
-	case ACPI_PTYPE2_PKG_COUNT:
-	case ACPI_PTYPE2_FIXED:
-	case ACPI_PTYPE2_MIN:
-	case ACPI_PTYPE2_REV_FIXED:
-		break;
-
-	default:
-		return;
-	}
-
-	count = obj_desc->package.count;
-	new_count = count;
-
-	source = obj_desc->package.elements;
-	dest = source;
-
-	/* Examine all elements of the package object, remove nulls */
-
-	for (i = 0; i < count; i++) {
-		if (!*source) {
-			new_count--;
-		} else {
-			*dest = *source;
-			dest++;
-		}
-		source++;
-	}
-
-	/* Update parent package if any null elements were removed */
-
-	if (new_count < count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
-				  "%s: Found and removed %u NULL elements\n",
-				  data->pathname, (count - new_count)));
-
-		/* NULL terminate list and update the package count */
-
-		*dest = NULL;
-		obj_desc->package.count = new_count;
-	}
-}
-
-/******************************************************************************
- *
  * FUNCTION:    acpi_ns_sort_list
  *
  * PARAMETERS:  Elements            - Package object element list
-- 
1.6.0.6

