From: Len Brown <len.brown@intel.com>
Subject: [PATCH 8/8] ACPICA: Support for external package objects as method arguments
Date: Sat,  2 Jun 2007 01:15:44 -0400
Message-ID: <1180761350860-git-send-email-len.brown@intel.com>
References: <1180761344795-git-send-email-len.brown@intel.com>
 <11807613453368-git-send-email-len.brown@intel.com>
 <11807613463371-git-send-email-len.brown@intel.com>
 <1180761346136-git-send-email-len.brown@intel.com>
 <11807613471928-git-send-email-len.brown@intel.com>
 <11807613483187-git-send-email-len.brown@intel.com>
 <1180761348487-git-send-email-len.brown@intel.com>
 <11807613492873-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2142 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754337AbXFBFPv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 01:15:51 -0400
In-Reply-To: <11807613492873-git-send-email-len.brown@intel.com>
Message-Id: <6287ee32952b502c23d54f12895c3895ddbe5013.1180761191.git.len.brown@intel.com>
In-Reply-To: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
References: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented support to allow Package objects to be passed as
method arguments to the acpi_evaluate_object interface. Previously,
this would return an AE_NOT_IMPLEMENTED exception.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utcopy.c   |  120 +++++++++++++++---------------------
 drivers/acpi/utilities/utobject.c |   42 +++++++++++++
 include/acpi/acutils.h            |    2 +
 3 files changed, 94 insertions(+), 70 deletions(-)

diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 4c1e008..879eaa1 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -68,6 +68,10 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *user_obj,
 				union acpi_operand_object **return_obj);
 
 static acpi_status
+acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
+				  union acpi_operand_object **internal_object);
+
+static acpi_status
 acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 			   union acpi_operand_object *dest_desc);
 
@@ -518,77 +522,73 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 	return_ACPI_STATUS(AE_NO_MEMORY);
 }
 
-#ifdef ACPI_FUTURE_IMPLEMENTATION
-/* Code to convert packages that are parameters to control methods */
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_copy_epackage_to_ipackage
  *
- * PARAMETERS:  *internal_object   - Pointer to the object we are returning
- *              *Buffer            - Where the object is returned
- *              *space_used        - Where the length of the object is returned
+ * PARAMETERS:  external_object     - The external object to be converted
+ *              internal_object     - Where the internal object is returned
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to place a package object in a user
- *              buffer.  A package object by definition contains other objects.
- *
- *              The buffer is assumed to have sufficient space for the object.
- *              The caller must have verified the buffer length needed using the
- *              acpi_ut_get_object_size function before calling this function.
+ * DESCRIPTION: Copy an external package object to an internal package.
+ *              Handles nested packages.
  *
  ******************************************************************************/
 
 static acpi_status
-acpi_ut_copy_epackage_to_ipackage(union acpi_operand_object *internal_object,
-				  u8 * buffer, u32 * space_used)
+acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
+				  union acpi_operand_object **internal_object)
 {
-	u8 *free_space;
-	union acpi_object *external_object;
-	u32 length = 0;
-	u32 this_index;
-	u32 object_space = 0;
-	union acpi_operand_object *this_internal_obj;
-	union acpi_object *this_external_obj;
+	acpi_status status = AE_OK;
+	union acpi_operand_object *package_object;
+	union acpi_operand_object **package_elements;
+	acpi_native_uint i;
 
 	ACPI_FUNCTION_TRACE(ut_copy_epackage_to_ipackage);
 
-	/*
-	 * First package at head of the buffer
-	 */
-	external_object = (union acpi_object *)buffer;
+	/* Create the package object */
 
-	/*
-	 * Free space begins right after the first package
-	 */
-	free_space = buffer + sizeof(union acpi_object);
+	package_object =
+	    acpi_ut_create_package_object(external_object->package.count);
+	if (!package_object) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
 
-	external_object->type = ACPI_GET_OBJECT_TYPE(internal_object);
-	external_object->package.count = internal_object->package.count;
-	external_object->package.elements = (union acpi_object *)free_space;
+	package_elements = package_object->package.elements;
 
 	/*
-	 * Build an array of ACPI_OBJECTS in the buffer
-	 * and move the free space past it
+	 * Recursive implementation. Probably ok, since nested external packages
+	 * as parameters should be very rare.
 	 */
-	free_space +=
-	    external_object->package.count * sizeof(union acpi_object);
+	for (i = 0; i < external_object->package.count; i++) {
+		status =
+		    acpi_ut_copy_eobject_to_iobject(&external_object->package.
+						    elements[i],
+						    &package_elements[i]);
+		if (ACPI_FAILURE(status)) {
 
-	/* Call walk_package */
+			/* Truncate package and delete it */
 
-}
+			package_object->package.count = i;
+			package_elements[i] = NULL;
+			acpi_ut_remove_reference(package_object);
+			return_ACPI_STATUS(status);
+		}
+	}
 
-#endif				/* Future implementation */
+	*internal_object = package_object;
+	return_ACPI_STATUS(status);
+}
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_copy_eobject_to_iobject
  *
- * PARAMETERS:  *internal_object   - The external object to be converted
- *              *buffer_ptr     - Where the internal object is returned
+ * PARAMETERS:  external_object     - The external object to be converted
+ *              internal_object     - Where the internal object is returned
  *
- * RETURN:      Status          - the status of the call
+ * RETURN:      Status              - the status of the call
  *
  * DESCRIPTION: Converts an external object to an internal object.
  *
@@ -603,16 +603,10 @@ acpi_ut_copy_eobject_to_iobject(union acpi_object *external_object,
 	ACPI_FUNCTION_TRACE(ut_copy_eobject_to_iobject);
 
 	if (external_object->type == ACPI_TYPE_PACKAGE) {
-		/*
-		 * Packages as external input to control methods are not supported,
-		 */
-		ACPI_ERROR((AE_INFO,
-			    "Packages as parameters not implemented!"));
-
-		return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
-	}
-
-	else {
+		status =
+		    acpi_ut_copy_epackage_to_ipackage(external_object,
+						      internal_object);
+	} else {
 		/*
 		 * Build a simple object (no nested objects)
 		 */
@@ -803,33 +797,19 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
 		 * Create and build the package object
 		 */
 		target_object =
-		    acpi_ut_create_internal_object(ACPI_TYPE_PACKAGE);
+		    acpi_ut_create_package_object(source_object->package.count);
 		if (!target_object) {
 			return (AE_NO_MEMORY);
 		}
 
-		target_object->package.count = source_object->package.count;
 		target_object->common.flags = source_object->common.flags;
 
-		/*
-		 * Create the object array
-		 */
-		target_object->package.elements =
-		    ACPI_ALLOCATE_ZEROED(((acpi_size) source_object->package.
-					  count + 1) * sizeof(void *));
-		if (!target_object->package.elements) {
-			status = AE_NO_MEMORY;
-			goto error_exit;
-		}
+		/* Pass the new package object back to the package walk routine */
 
-		/*
-		 * Pass the new package object back to the package walk routine
-		 */
 		state->pkg.this_target_obj = target_object;
 
-		/*
-		 * Store the object pointer in the parent package object
-		 */
+		/* Store the object pointer in the parent package object */
+
 		*this_target_ptr = target_object;
 		break;
 
diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index 4696124..db0b9ba 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -146,6 +146,48 @@ union acpi_operand_object *acpi_ut_create_internal_object_dbg(char *module_name,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_create_package_object
+ *
+ * PARAMETERS:  Count               - Number of package elements
+ *
+ * RETURN:      Pointer to a new Package object, null on failure
+ *
+ * DESCRIPTION: Create a fully initialized package object
+ *
+ ******************************************************************************/
+
+union acpi_operand_object *acpi_ut_create_package_object(u32 count)
+{
+	union acpi_operand_object *package_desc;
+	union acpi_operand_object **package_elements;
+
+	ACPI_FUNCTION_TRACE_U32(ut_create_package_object, count);
+
+	/* Create a new Package object */
+
+	package_desc = acpi_ut_create_internal_object(ACPI_TYPE_PACKAGE);
+	if (!package_desc) {
+		return_PTR(NULL);
+	}
+
+	/*
+	 * Create the element array. Count+1 allows the array to be null
+	 * terminated.
+	 */
+	package_elements = ACPI_ALLOCATE_ZEROED((acpi_size)
+						(count + 1) * sizeof(void *));
+	if (!package_elements) {
+		ACPI_FREE(package_desc);
+		return_PTR(NULL);
+	}
+
+	package_desc->package.count = count;
+	package_desc->package.elements = package_elements;
+	return_PTR(package_desc);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_create_buffer_object
  *
  * PARAMETERS:  buffer_size            - Size of buffer to be created
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index 15a8388..a87ef1c 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -390,6 +390,8 @@ void acpi_ut_delete_object_desc(union acpi_operand_object *object);
 
 u8 acpi_ut_valid_internal_object(void *object);
 
+union acpi_operand_object *acpi_ut_create_package_object(u32 count);
+
 union acpi_operand_object *acpi_ut_create_buffer_object(acpi_size buffer_size);
 
 union acpi_operand_object *acpi_ut_create_string_object(acpi_size string_size);
-- 
1.5.2.146.gb75c6
