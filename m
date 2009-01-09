From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/94] ACPICA: Add Buffer->String conversion for predefined
 methods
Date: Fri, 09 Jan 2009 04:26:35 -0500
Message-ID: <a647b5c34047560d7efe7e53e756c6692ce67dc7.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:62823 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbZAIJ2P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:15 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700M9I6AR9GY0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:04 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

For predefined methods (such as _BIF), add automatic conversion for
objects that are required to be a String, but a Buffer was found
instead. This can happen when reading string battery data from
an operation region, because it used to be difficult to convert
the data from buffer to string from within the ASL. Linux BZ 11822.

http://bugzilla.kernel.org/show_bug.cgi?id=11822

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nseval.c   |    3 +-
 drivers/acpi/namespace/nspredef.c |  150 ++++++++++++++++++++++++++++++-------
 include/acpi/acnamesp.h           |    2 +-
 3 files changed, 125 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 4cdf03a..738a451 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -282,8 +282,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 			 * the method on invalid return object.
 			 */
 			(void)acpi_ns_check_predefined_names(node,
-							     info->
-							     return_object);
+			     &info->return_object);
 		}
 
 		/* Mark the node as having been evaluated */
diff --git a/drivers/acpi/namespace/nspredef.c b/drivers/acpi/namespace/nspredef.c
index 0f17cf0..3df1752 100644
--- a/drivers/acpi/namespace/nspredef.c
+++ b/drivers/acpi/namespace/nspredef.c
@@ -72,7 +72,7 @@ ACPI_MODULE_NAME("nspredef")
 /* Local prototypes */
 static acpi_status
 acpi_ns_check_package(char *pathname,
-		      union acpi_operand_object *return_object,
+		      union acpi_operand_object **return_object_ptr,
 		      const union acpi_predefined_info *predefined);
 
 static acpi_status
@@ -82,13 +82,18 @@ acpi_ns_check_package_elements(char *pathname,
 
 static acpi_status
 acpi_ns_check_object_type(char *pathname,
-			  union acpi_operand_object *return_object,
+			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index);
 
 static acpi_status
 acpi_ns_check_reference(char *pathname,
 			union acpi_operand_object *return_object);
 
+static acpi_status
+acpi_ns_repair_object(u32 expected_btypes,
+		      u32 package_index,
+		      union acpi_operand_object **return_object_ptr);
+
 /*
  * Names for the types that can be returned by the predefined objects.
  * Used for warning messages. Must be in the same order as the ACPI_RTYPEs
@@ -108,8 +113,8 @@ static const char *acpi_rtype_names[] = {
  * FUNCTION:    acpi_ns_check_predefined_names
  *
  * PARAMETERS:  Node            - Namespace node for the method/object
- *              return_object   - Object returned from the evaluation of this
- *                                method/object
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
  *
  * RETURN:      Status
  *
@@ -119,8 +124,9 @@ static const char *acpi_rtype_names[] = {
 
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
-			       union acpi_operand_object *return_object)
+			       union acpi_operand_object **return_object_ptr)
 {
+	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
 	const union acpi_predefined_info *predefined;
 	char *pathname;
@@ -182,7 +188,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * Check that the type of the return object is what is expected for
 	 * this predefined name
 	 */
-	status = acpi_ns_check_object_type(pathname, return_object,
+	status = acpi_ns_check_object_type(pathname, return_object_ptr,
 					   predefined->info.expected_btypes,
 					   ACPI_NOT_PACKAGE);
 	if (ACPI_FAILURE(status)) {
@@ -193,7 +199,8 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 
 	if (ACPI_GET_OBJECT_TYPE(return_object) == ACPI_TYPE_PACKAGE) {
 		status =
-		    acpi_ns_check_package(pathname, return_object, predefined);
+		    acpi_ns_check_package(pathname, return_object_ptr,
+					  predefined);
 	}
 
       exit:
@@ -307,8 +314,8 @@ const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
  * FUNCTION:    acpi_ns_check_package
  *
  * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
- *              return_object   - Object returned from the evaluation of a
- *                                method or object
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
  *              Predefined      - Pointer to entry in predefined name table
  *
  * RETURN:      Status
@@ -320,9 +327,10 @@ const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
 
 static acpi_status
 acpi_ns_check_package(char *pathname,
-		      union acpi_operand_object *return_object,
+		      union acpi_operand_object **return_object_ptr,
 		      const union acpi_predefined_info *predefined)
 {
+	union acpi_operand_object *return_object = *return_object_ptr;
 	const union acpi_predefined_info *package;
 	union acpi_operand_object *sub_package;
 	union acpi_operand_object **elements;
@@ -408,7 +416,7 @@ acpi_ns_check_package(char *pathname,
 		 * elements must be of the same type
 		 */
 		for (i = 0; i < count; i++) {
-			status = acpi_ns_check_object_type(pathname, *elements,
+			status = acpi_ns_check_object_type(pathname, elements,
 							   package->ret_info.
 							   object_type1, i);
 			if (ACPI_FAILURE(status)) {
@@ -441,7 +449,7 @@ acpi_ns_check_package(char *pathname,
 
 				status =
 				    acpi_ns_check_object_type(pathname,
-							      *elements,
+							      elements,
 							      package->
 							      ret_info3.
 							      object_type[i],
@@ -454,7 +462,7 @@ acpi_ns_check_package(char *pathname,
 
 				status =
 				    acpi_ns_check_object_type(pathname,
-							      *elements,
+							      elements,
 							      package->
 							      ret_info3.
 							      tail_object_type,
@@ -471,7 +479,7 @@ acpi_ns_check_package(char *pathname,
 
 		/* First element is the (Integer) count of sub-packages to follow */
 
-		status = acpi_ns_check_object_type(pathname, *elements,
+		status = acpi_ns_check_object_type(pathname, elements,
 						   ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -509,7 +517,7 @@ acpi_ns_check_package(char *pathname,
 			/* Each sub-object must be of type Package */
 
 			status =
-			    acpi_ns_check_object_type(pathname, sub_package,
+			    acpi_ns_check_object_type(pathname, &sub_package,
 						      ACPI_RTYPE_PACKAGE, i);
 			if (ACPI_FAILURE(status)) {
 				return (status);
@@ -567,12 +575,8 @@ acpi_ns_check_package(char *pathname,
 				for (j = 0; j < expected_count; j++) {
 					status =
 					    acpi_ns_check_object_type(pathname,
-								      sub_elements
-								      [j],
-								      package->
-								      ret_info2.
-								      object_type
-								      [j], j);
+						&sub_elements[j],
+						package->ret_info2.object_type[j], j);
 					if (ACPI_FAILURE(status)) {
 						return (status);
 					}
@@ -611,7 +615,7 @@ acpi_ns_check_package(char *pathname,
 
 				status =
 				    acpi_ns_check_object_type(pathname,
-							      *sub_elements,
+							      sub_elements,
 							      ACPI_RTYPE_INTEGER,
 							      0);
 				if (ACPI_FAILURE(status)) {
@@ -708,7 +712,7 @@ acpi_ns_check_package_elements(char *pathname,
 	 * The second group can have a count of zero.
 	 */
 	for (i = 0; i < count1; i++) {
-		status = acpi_ns_check_object_type(pathname, *this_element,
+		status = acpi_ns_check_object_type(pathname, this_element,
 						   type1, i);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -717,7 +721,7 @@ acpi_ns_check_package_elements(char *pathname,
 	}
 
 	for (i = 0; i < count2; i++) {
-		status = acpi_ns_check_object_type(pathname, *this_element,
+		status = acpi_ns_check_object_type(pathname, this_element,
 						   type2, (i + count1));
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -733,8 +737,8 @@ acpi_ns_check_package_elements(char *pathname,
  * FUNCTION:    acpi_ns_check_object_type
  *
  * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
- *              return_object   - Object return from the execution of this
- *                                method/object
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
  *              expected_btypes - Bitmap of expected return type(s)
  *              package_index   - Index of object within parent package (if
  *                                applicable - ACPI_NOT_PACKAGE otherwise)
@@ -748,9 +752,10 @@ acpi_ns_check_package_elements(char *pathname,
 
 static acpi_status
 acpi_ns_check_object_type(char *pathname,
-			  union acpi_operand_object *return_object,
+			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index)
 {
+	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
 	u32 return_btype;
 	char type_buffer[48];	/* Room for 5 types */
@@ -814,6 +819,14 @@ acpi_ns_check_object_type(char *pathname,
 	/* Is the object one of the expected types? */
 
 	if (!(return_btype & expected_btypes)) {
+
+		/* Type mismatch -- attempt repair of the returned object */
+
+		status = acpi_ns_repair_object(expected_btypes, package_index,
+					       return_object_ptr);
+		if (ACPI_SUCCESS(status)) {
+			return (status);
+		}
 		goto type_error_exit;
 	}
 
@@ -898,3 +911,86 @@ acpi_ns_check_reference(char *pathname,
 
 	return (AE_AML_OPERAND_TYPE);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_object
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              package_index   - Used to determine if target is in a package
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if repair was successful.
+ *
+ * DESCRIPTION: Attempt to repair/convert a return object of a type that was
+ *              not expected.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_repair_object(u32 expected_btypes,
+		      u32 package_index,
+		      union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object *new_object;
+	acpi_size length;
+
+	switch (ACPI_GET_OBJECT_TYPE(return_object)) {
+	case ACPI_TYPE_BUFFER:
+
+		if (!(expected_btypes & ACPI_RTYPE_STRING)) {
+			return (AE_AML_OPERAND_TYPE);
+		}
+
+		/*
+		 * Have a Buffer, expected a String, convert. Use a to_string
+		 * conversion, no transform performed on the buffer data. The best
+		 * example of this is the _BIF method, where the string data from
+		 * the battery is often (incorrectly) returned as buffer object(s).
+		 */
+		length = 0;
+		while ((length < return_object->buffer.length) &&
+		       (return_object->buffer.pointer[length])) {
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
+			    return_object->buffer.pointer, length);
+
+		/* Install the new return object */
+
+		acpi_ut_remove_reference(return_object);
+		*return_object_ptr = new_object;
+
+		/*
+		 * If the object is a package element, we need to:
+		 * 1. Decrement the reference count of the orignal object, it was
+		 *    incremented when building the package
+		 * 2. Increment the reference count of the new object, it will be
+		 *    decremented when releasing the package
+		 */
+		if (package_index != ACPI_NOT_PACKAGE) {
+			acpi_ut_remove_reference(return_object);
+			acpi_ut_add_reference(new_object);
+		}
+		return (AE_OK);
+
+	default:
+		break;
+	}
+
+	return (AE_AML_OPERAND_TYPE);
+}
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index db4e6f6..db1e290 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -182,7 +182,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
  */
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
-			       union acpi_operand_object *return_object);
+			       union acpi_operand_object **return_object);
 
 const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
 								    acpi_namespace_node
-- 
1.5.6.6

