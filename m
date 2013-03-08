From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/21] ACPICA: Add mechanism for early object repairs on a per-name basis
Date: Fri,  8 Mar 2013 17:23:03 +0800
Message-ID: <e6fb8b94625d50980dd25cb7f247ef4053a0c591.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15656 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3CHJXU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:23:20 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Adds the framework to allow object repairs very early in the
return object analysis. Enables repairs like string->unicode,
etc. Bob Moore, Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |   15 +++++
 drivers/acpi/acpica/acnamesp.h  |    2 +-
 drivers/acpi/acpica/nspredef.c  |  141 +++++++++++++++++++--------------------
 drivers/acpi/acpica/nsrepair.c  |  134 +++++++++++++++++++++++++++++++++++--
 drivers/acpi/acpica/nsrepair2.c |   16 ++---
 5 files changed, 221 insertions(+), 87 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 805f419..9d45f97 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -363,6 +363,7 @@ struct acpi_predefined_data {
 	union acpi_operand_object *parent_package;
 	struct acpi_namespace_node *node;
 	u32 flags;
+	u32 return_btype;
 	u8 node_flags;
 };
 
@@ -371,6 +372,20 @@ struct acpi_predefined_data {
 #define ACPI_OBJECT_REPAIRED    1
 #define ACPI_OBJECT_WRAPPED     2
 
+/* Return object auto-repair info */
+
+typedef acpi_status(*acpi_object_converter) (union acpi_operand_object
+					     *original_object,
+					     union acpi_operand_object
+					     **converted_object);
+
+struct acpi_simple_repair_info {
+	char name[ACPI_NAME_SIZE];
+	u32 unexpected_btypes;
+	u32 package_index;
+	acpi_object_converter object_converter;
+};
+
 /*
  * Bitmapped return value types
  * Note: the actual data types must be contiguous, a loop in nspredef.c
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 02cd548..dec6e9e 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -289,7 +289,7 @@ acpi_ns_get_attached_data(struct acpi_namespace_node *node,
  * predefined methods/objects
  */
 acpi_status
-acpi_ns_repair_object(struct acpi_predefined_data *data,
+acpi_ns_simple_repair(struct acpi_predefined_data *data,
 		      u32 expected_btypes,
 		      u32 package_index,
 		      union acpi_operand_object **return_object_ptr);
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 224c300..36f7240 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -78,6 +78,8 @@ acpi_ns_check_reference(struct acpi_predefined_data *data,
 
 static void acpi_ns_get_expected_types(char *buffer, u32 expected_btypes);
 
+static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object);
+
 /*
  * Names for the types that can be returned by the predefined objects.
  * Used for warning messages. Must be in the same order as the ACPI_RTYPEs
@@ -112,7 +114,6 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 			       acpi_status return_status,
 			       union acpi_operand_object **return_object_ptr)
 {
-	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
 	const union acpi_predefined_info *predefined;
 	char *pathname;
@@ -152,25 +153,6 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
 	/*
-	 * If there is no return value, check if we require a return value for
-	 * this predefined name. Either one return value is expected, or none,
-	 * for both methods and other objects.
-	 *
-	 * Exit now if there is no return object. Warning if one was expected.
-	 */
-	if (!return_object) {
-		if ((predefined->info.expected_btypes) &&
-		    (!(predefined->info.expected_btypes & ACPI_RTYPE_NONE))) {
-			ACPI_WARN_PREDEFINED((AE_INFO, pathname,
-					      ACPI_WARN_ALWAYS,
-					      "Missing expected return value"));
-
-			status = AE_AML_NO_RETURN_VALUE;
-		}
-		goto cleanup;
-	}
-
-	/*
 	 * Return value validation and possible repair.
 	 *
 	 * 1) Don't perform return value validation/repair if this feature
@@ -410,28 +392,12 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
-	u32 return_btype;
 	char type_buffer[48];	/* Room for 5 types */
 
-	/*
-	 * If we get a NULL return_object here, it is a NULL package element.
-	 * Since all extraneous NULL package elements were removed earlier by a
-	 * call to acpi_ns_remove_null_elements, this is an unexpected NULL element.
-	 * We will attempt to repair it.
-	 */
-	if (!return_object) {
-		status = acpi_ns_repair_null_element(data, expected_btypes,
-						     package_index,
-						     return_object_ptr);
-		if (ACPI_SUCCESS(status)) {
-			return (AE_OK);	/* Repair was successful */
-		}
-		goto type_error_exit;
-	}
-
 	/* A Namespace node should not get here, but make sure */
 
-	if (ACPI_GET_DESCRIPTOR_TYPE(return_object) == ACPI_DESC_TYPE_NAMED) {
+	if (return_object &&
+	    ACPI_GET_DESCRIPTOR_TYPE(return_object) == ACPI_DESC_TYPE_NAMED) {
 		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
 				      "Invalid return type - Found a Namespace node [%4.4s] type %s",
 				      return_object->node.name.ascii,
@@ -448,53 +414,25 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 	 * from all of the predefined names (including elements of returned
 	 * packages)
 	 */
-	switch (return_object->common.type) {
-	case ACPI_TYPE_INTEGER:
-		return_btype = ACPI_RTYPE_INTEGER;
-		break;
-
-	case ACPI_TYPE_BUFFER:
-		return_btype = ACPI_RTYPE_BUFFER;
-		break;
-
-	case ACPI_TYPE_STRING:
-		return_btype = ACPI_RTYPE_STRING;
-		break;
+	data->return_btype = acpi_ns_get_bitmapped_type(return_object);
+	if (data->return_btype == ACPI_RTYPE_ANY) {
 
-	case ACPI_TYPE_PACKAGE:
-		return_btype = ACPI_RTYPE_PACKAGE;
-		break;
-
-	case ACPI_TYPE_LOCAL_REFERENCE:
-		return_btype = ACPI_RTYPE_REFERENCE;
-		break;
-
-	default:
 		/* Not one of the supported objects, must be incorrect */
-
 		goto type_error_exit;
 	}
 
-	/* Is the object one of the expected types? */
-
-	if (return_btype & expected_btypes) {
-
-		/* For reference objects, check that the reference type is correct */
-
-		if (return_object->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
-			status = acpi_ns_check_reference(data, return_object);
-		}
+	/* For reference objects, check that the reference type is correct */
 
+	if ((data->return_btype & expected_btypes) == ACPI_RTYPE_REFERENCE) {
+		status = acpi_ns_check_reference(data, return_object);
 		return (status);
 	}
 
-	/* Type mismatch -- attempt repair of the returned object */
+	/* Attempt simple repair of the returned object if necessary */
 
-	status = acpi_ns_repair_object(data, expected_btypes,
+	status = acpi_ns_simple_repair(data, expected_btypes,
 				       package_index, return_object_ptr);
-	if (ACPI_SUCCESS(status)) {
-		return (AE_OK);	/* Repair was successful */
-	}
+	return (status);
 
       type_error_exit:
 
@@ -558,6 +496,61 @@ acpi_ns_check_reference(struct acpi_predefined_data *data,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ns_get_bitmapped_type
+ *
+ * PARAMETERS:  return_object   - Object returned from method/obj evaluation
+ *
+ * RETURN:      Object return type. ACPI_RTYPE_ANY indicates that the object
+ *              type is not supported. ACPI_RTYPE_NONE indicates that no
+ *              object was returned (return_object is NULL).
+ *
+ * DESCRIPTION: Convert object type into a bitmapped object return type.
+ *
+ ******************************************************************************/
+
+static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object)
+{
+	u32 return_btype;
+
+	if (!return_object) {
+		return (ACPI_RTYPE_NONE);
+	}
+
+	/* Map acpi_object_type to internal bitmapped type */
+
+	switch (return_object->common.type) {
+	case ACPI_TYPE_INTEGER:
+		return_btype = ACPI_RTYPE_INTEGER;
+		break;
+
+	case ACPI_TYPE_BUFFER:
+		return_btype = ACPI_RTYPE_BUFFER;
+		break;
+
+	case ACPI_TYPE_STRING:
+		return_btype = ACPI_RTYPE_STRING;
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+		return_btype = ACPI_RTYPE_PACKAGE;
+		break;
+
+	case ACPI_TYPE_LOCAL_REFERENCE:
+		return_btype = ACPI_RTYPE_REFERENCE;
+		break;
+
+	default:
+		/* Not one of the supported objects, must be incorrect */
+
+		return_btype = ACPI_RTYPE_ANY;
+		break;
+	}
+
+	return (return_btype);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ns_get_expected_types
  *
  * PARAMETERS:  buffer          - Pointer to where the string is returned
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 9e83335..f9c9fd4 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -46,6 +46,7 @@
 #include "acnamesp.h"
 #include "acinterp.h"
 #include "acpredef.h"
+#include "amlresrc.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsrepair")
@@ -71,6 +72,11 @@ ACPI_MODULE_NAME("nsrepair")
  * Buffer  -> String
  * Buffer  -> Package of Integers
  * Package -> Package of one Package
+ *
+ * Additional conversions that are available:
+ *  Convert a null return or zero return value to an end_tag descriptor
+ *  Convert an ASCII string to a Unicode buffer
+ *
  * An incorrect standalone object is wrapped with required outer package
  *
  * Additional possible repairs:
@@ -90,9 +96,26 @@ static acpi_status
 acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 			  union acpi_operand_object **return_object);
 
+static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
+									 acpi_namespace_node
+									 *node,
+									 u32
+									 return_btype,
+									 u32
+									 package_index);
+
+/*
+ * Special but simple repairs for some names.
+ *
+ * 2nd argument: Unexpected types that can be repaired
+ */
+static const struct acpi_simple_repair_info acpi_object_repair_info[] = {
+	{{0, 0, 0, 0}, 0, 0, NULL}	/* Table terminator */
+};
+
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_repair_object
+ * FUNCTION:    acpi_ns_simple_repair
  *
  * PARAMETERS:  data                - Pointer to validation data structure
  *              expected_btypes     - Object types expected
@@ -110,16 +133,54 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_repair_object(struct acpi_predefined_data *data,
+acpi_ns_simple_repair(struct acpi_predefined_data *data,
 		      u32 expected_btypes,
 		      u32 package_index,
 		      union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
-	union acpi_operand_object *new_object;
+	union acpi_operand_object *new_object = NULL;
 	acpi_status status;
+	const struct acpi_simple_repair_info *predefined;
 
-	ACPI_FUNCTION_NAME(ns_repair_object);
+	ACPI_FUNCTION_NAME(ns_simple_repair);
+
+	/*
+	 * Special repairs for certain names that are in the repair table.
+	 * Check if this name is in the list of repairable names.
+	 */
+	predefined = acpi_ns_match_simple_repair(data->node,
+						 data->return_btype,
+						 package_index);
+	if (predefined) {
+		if (!return_object) {
+			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Missing expected return value"));
+		}
+
+		status =
+		    predefined->object_converter(return_object, &new_object);
+		if (ACPI_FAILURE(status)) {
+
+			/* A fatal error occurred during a conversion */
+
+			ACPI_EXCEPTION((AE_INFO, status,
+					"During return object analysis"));
+			return (status);
+		}
+		if (new_object) {
+			goto object_repaired;
+		}
+	}
+
+	/*
+	 * Do not perform simple object repair unless the return type is not
+	 * expected.
+	 */
+	if (data->return_btype & expected_btypes) {
+		return (AE_OK);
+	}
 
 	/*
 	 * At this point, we know that the type of the returned object was not
@@ -127,6 +188,24 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	 * repair the object by converting it to one of the expected object
 	 * types for this predefined name.
 	 */
+
+	/*
+	 * If there is no return value, check if we require a return value for
+	 * this predefined name. Either one return value is expected, or none,
+	 * for both methods and other objects.
+	 *
+	 * Exit now if there is no return object. Warning if one was expected.
+	 */
+	if (!return_object) {
+		if (expected_btypes && (!(expected_btypes & ACPI_RTYPE_NONE))) {
+			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Missing expected return value"));
+
+			return (AE_AML_NO_RETURN_VALUE);
+		}
+	}
+
 	if (expected_btypes & ACPI_RTYPE_INTEGER) {
 		status = acpi_ns_convert_to_integer(return_object, &new_object);
 		if (ACPI_SUCCESS(status)) {
@@ -216,6 +295,53 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	return (AE_OK);
 }
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_match_simple_repair
+ *
+ * PARAMETERS:  node                - Namespace node for the method/object
+ *              return_btype        - Object type that was returned
+ *              package_index       - Index of object within parent package (if
+ *                                    applicable - ACPI_NOT_PACKAGE_ELEMENT
+ *                                    otherwise)
+ *
+ * RETURN:      Pointer to entry in repair table. NULL indicates not found.
+ *
+ * DESCRIPTION: Check an object name against the repairable object list.
+ *
+ *****************************************************************************/
+
+static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
+									 acpi_namespace_node
+									 *node,
+									 u32
+									 return_btype,
+									 u32
+									 package_index)
+{
+	const struct acpi_simple_repair_info *this_name;
+
+	/* Search info table for a repairable predefined method/object name */
+
+	this_name = acpi_object_repair_info;
+	while (this_name->object_converter) {
+		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->name)) {
+
+			/* Check if we can actually repair this name/type combination */
+
+			if ((return_btype & this_name->unexpected_btypes) &&
+			    (package_index == this_name->package_index)) {
+				return (this_name);
+			}
+
+			return (NULL);
+		}
+		this_name++;
+	}
+
+	return (NULL);		/* Name was not found in the repair table */
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_convert_to_integer
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index ba4d982..149e9b9 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -66,9 +66,9 @@ typedef struct acpi_repair_info {
 
 /* Local prototypes */
 
-static const struct acpi_repair_info *acpi_ns_match_repairable_name(struct
-								    acpi_namespace_node
-								    *node);
+static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
+								   acpi_namespace_node
+								   *node);
 
 static acpi_status
 acpi_ns_repair_ALR(struct acpi_predefined_data *data,
@@ -175,7 +175,7 @@ acpi_ns_complex_repairs(struct acpi_predefined_data *data,
 
 	/* Check if this name is in the list of repairable names */
 
-	predefined = acpi_ns_match_repairable_name(node);
+	predefined = acpi_ns_match_complex_repair(node);
 	if (!predefined) {
 		return (validate_status);
 	}
@@ -186,7 +186,7 @@ acpi_ns_complex_repairs(struct acpi_predefined_data *data,
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_ns_match_repairable_name
+ * FUNCTION:    acpi_ns_match_complex_repair
  *
  * PARAMETERS:  node                - Namespace node for the method/object
  *
@@ -196,9 +196,9 @@ acpi_ns_complex_repairs(struct acpi_predefined_data *data,
  *
  *****************************************************************************/
 
-static const struct acpi_repair_info *acpi_ns_match_repairable_name(struct
-								    acpi_namespace_node
-								    *node)
+static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
+								   acpi_namespace_node
+								   *node)
 {
 	const struct acpi_repair_info *this_name;
 
-- 
1.7.10

