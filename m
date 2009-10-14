From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20091013 linuxized patches
Date: Wed, 14 Oct 2009 08:59:03 +0800
Message-ID: <1255481943.20102.3.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-fqHEv3VPZa+FNTPGXcZd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42097 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbZJNBOb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Oct 2009 21:14:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-fqHEv3VPZa+FNTPGXcZd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA Release 20091013 linuxized patches attached.
Applied cleanly to linux-acpi-2.6/test branch.

[PATCH 1/4] ACPICA: Add repair for bad _BIF/_BIX packages
[PATCH 2/4] ACPICA: Add repair for bad _MAT buffers
[PATCH 3/4] ACPICA: Remove possibility of executing _REG methods twice
[PATCH 4/4] ACPICA: Fix possible memory leak for Scope ASL operator

Lin Ming

--=-fqHEv3VPZa+FNTPGXcZd
Content-Disposition: attachment; filename="acpica-v20091013.patch"
Content-Type: text/x-patch; name="acpica-v20091013.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From dfdef8feb985a917248d7a2557253e989d895735 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 13 Oct 2009 10:20:33 +0800
Subject: [PATCH 1/4] ACPICA: Add repair for bad _BIF/_BIX packages

Add a repair for the "Oem Information" field which is often
mistakenly returned as an integer. It should always be a string.
ACPICA BZ 807.

http://www.acpica.org/bugzilla/show_bug.cgi?id=807

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |   91 ++++++++++++++++++++++++++++-----------
 1 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index db2b2a9..dfa31c5 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -77,6 +77,11 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	union acpi_operand_object *new_object;
 	acpi_size length;
 
+	/*
+	 * At this point, we know that the type of the returned object was not
+	 * one of the expected types for this predefined name. Attempt to
+	 * repair the object. Only a limited number of repairs are possible.
+	 */
 	switch (return_object->common.type) {
 	case ACPI_TYPE_BUFFER:
 
@@ -111,43 +116,77 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 		 */
 		ACPI_MEMCPY(new_object->string.pointer,
 			    return_object->buffer.pointer, length);
+		break;
 
-		/*
-		 * If the original object is a package element, we need to:
-		 * 1. Set the reference count of the new object to match the
-		 *    reference count of the old object.
-		 * 2. Decrement the reference count of the original object.
-		 */
-		if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
-			new_object->common.reference_count =
-			    return_object->common.reference_count;
+	case ACPI_TYPE_INTEGER:
+
+		/* Does the method/object legally return a string? */
 
-			if (return_object->common.reference_count > 1) {
-				return_object->common.reference_count--;
+		if (expected_btypes & ACPI_RTYPE_STRING) {
+			/*
+			 * The only supported Integer-to-String conversion is to convert
+			 * an integer of value 0 to a NULL string. The last element of
+			 * _BIF and _BIX packages occasionally need this fix.
+			 */
+			if (return_object->integer.value != 0) {
+				return (AE_AML_OPERAND_TYPE);
 			}
 
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Converted Buffer to expected String at index %u",
-					      package_index));
+			/* Allocate a new NULL string object */
+
+			new_object = acpi_ut_create_string_object(0);
+			if (!new_object) {
+				return (AE_NO_MEMORY);
+			}
 		} else {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Converted Buffer to expected String"));
+			return (AE_AML_OPERAND_TYPE);
 		}
+		break;
 
-		/* Delete old object, install the new return object */
+	default:
 
-		acpi_ut_remove_reference(return_object);
-		*return_object_ptr = new_object;
-		data->flags |= ACPI_OBJECT_REPAIRED;
-		return (AE_OK);
+		/* We cannot repair this object */
 
-	default:
-		break;
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	/* Object was successfully repaired */
+
+	/*
+	 * If the original object is a package element, we need to:
+	 * 1. Set the reference count of the new object to match the
+	 *    reference count of the old object.
+	 * 2. Decrement the reference count of the original object.
+	 */
+	if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
+		new_object->common.reference_count =
+		    return_object->common.reference_count;
+
+		if (return_object->common.reference_count > 1) {
+			return_object->common.reference_count--;
+		}
+
+		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted %s to expected %s at index %u",
+				      acpi_ut_get_object_type_name
+				      (return_object),
+				      acpi_ut_get_object_type_name(new_object),
+				      package_index));
+	} else {
+		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted %s to expected %s",
+				      acpi_ut_get_object_type_name
+				      (return_object),
+				      acpi_ut_get_object_type_name
+				      (new_object)));
 	}
 
-	return (AE_AML_OPERAND_TYPE);
+	/* Delete old object, install the new return object */
+
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = new_object;
+	data->flags |= ACPI_OBJECT_REPAIRED;
+	return (AE_OK);
 }
 
 /*******************************************************************************

>From 953b94cee310120af1db235b272f2fa03b00a3c2 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Tue, 13 Oct 2009 10:23:20 +0800
Subject: [PATCH 2/4] ACPICA: Add repair for bad _MAT buffers

_MAT can inadvertently return an Integer instead of a Buffer
if the return value has been read from a Field whose width is
less than or equal to the global integer width (32 or 64 bits).
ACPICA BZ 810.

http://www.acpica.org/bugzilla/show_bug.cgi?id=810

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index dfa31c5..f2f5269 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -44,6 +44,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
+#include "acinterp.h"
 #include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
@@ -76,6 +77,7 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	union acpi_operand_object *return_object = *return_object_ptr;
 	union acpi_operand_object *new_object;
 	acpi_size length;
+	acpi_status status;
 
 	/*
 	 * At this point, we know that the type of the returned object was not
@@ -120,9 +122,26 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 
 	case ACPI_TYPE_INTEGER:
 
-		/* Does the method/object legally return a string? */
+		/* 1) Does the method/object legally return a buffer? */
+
+		if (expected_btypes & ACPI_RTYPE_BUFFER) {
+			/*
+			 * Convert the Integer to a packed-byte buffer. _MAT needs
+			 * this sometimes, if a read has been performed on a Field
+			 * object that is less than or equal to the global integer
+			 * size (32 or 64 bits).
+			 */
+			status =
+			    acpi_ex_convert_to_buffer(return_object,
+						      &new_object);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+		}
+
+		/* 2) Does the method/object legally return a string? */
 
-		if (expected_btypes & ACPI_RTYPE_STRING) {
+		else if (expected_btypes & ACPI_RTYPE_STRING) {
 			/*
 			 * The only supported Integer-to-String conversion is to convert
 			 * an integer of value 0 to a NULL string. The last element of

>From 7084f212b1c51eb4e43267abce678c9a89b3c5af Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Tue, 13 Oct 2009 10:29:30 +0800
Subject: [PATCH 3/4] ACPICA: Remove possibility of executing _REG methods twice

If a custom address space handler is installed by the host
before the "initialize operation regions" phase of the ACPICA
initialization, any _REG methods for that address space could
be executed twice. This change fixes the problem.
ACPICA BZ 427.

http://www.acpica.org/bugzilla/show_bug.cgi?id=427

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evregion.c |   64 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 98c7f9c..c9fa040 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -51,6 +51,10 @@
 ACPI_MODULE_NAME("evregion")
 
 /* Local prototypes */
+static u8
+acpi_ev_has_default_handler(struct acpi_namespace_node *node,
+			    acpi_adr_space_type space_id);
+
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -142,6 +146,50 @@ acpi_status acpi_ev_install_region_handlers(void)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_has_default_handler
+ *
+ * PARAMETERS:  Node                - Namespace node for the device
+ *              space_id            - The address space ID
+ *
+ * RETURN:      TRUE if default handler is installed, FALSE otherwise
+ *
+ * DESCRIPTION: Check if the default handler is installed for the requested
+ *              space ID.
+ *
+ ******************************************************************************/
+
+static u8
+acpi_ev_has_default_handler(struct acpi_namespace_node *node,
+			    acpi_adr_space_type space_id)
+{
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *handler_obj;
+
+	/* Must have an existing internal object */
+
+	obj_desc = acpi_ns_get_attached_object(node);
+	if (obj_desc) {
+		handler_obj = obj_desc->device.handler;
+
+		/* Walk the linked list of handlers for this object */
+
+		while (handler_obj) {
+			if (handler_obj->address_space.space_id == space_id) {
+				if (handler_obj->address_space.handler_flags &
+				    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
+					return (TRUE);
+				}
+			}
+
+			handler_obj = handler_obj->address_space.next;
+		}
+	}
+
+	return (FALSE);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_initialize_op_regions
  *
  * PARAMETERS:  None
@@ -169,12 +217,18 @@ acpi_status acpi_ev_initialize_op_regions(void)
 
 	for (i = 0; i < ACPI_NUM_DEFAULT_SPACES; i++) {
 		/*
-		 * TBD: Make sure handler is the DEFAULT handler, otherwise
-		 * _REG will have already been run.
+		 * Make sure the installed handler is the DEFAULT handler. If not the
+		 * default, the _REG methods will have already been run (when the
+		 * handler was installed)
 		 */
-		status = acpi_ev_execute_reg_methods(acpi_gbl_root_node,
-						     acpi_gbl_default_address_spaces
-						     [i]);
+		if (acpi_ev_has_default_handler(acpi_gbl_root_node,
+						acpi_gbl_default_address_spaces
+						[i])) {
+			status =
+			    acpi_ev_execute_reg_methods(acpi_gbl_root_node,
+							acpi_gbl_default_address_spaces
+							[i]);
+		}
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);

>From 2d3b7803e3f82fc35dacc4267f0b24e190b60504 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Tue, 13 Oct 2009 10:34:56 +0800
Subject: [PATCH 4/4] ACPICA: Fix possible memory leak for Scope ASL operator

Using Scope(\) to change the scope to the root could cause a
single object memory leak.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dswload.c |   50 +++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 6de3a99..10fc785 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -639,26 +639,42 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		break;
 
 	case AML_SCOPE_OP:
-		/*
-		 * The Path is an object reference to an existing object.
-		 * Don't enter the name into the namespace, but look it up
-		 * for use later.
-		 */
-		status =
-		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
-				   object_type, ACPI_IMODE_EXECUTE,
-				   ACPI_NS_SEARCH_PARENT, walk_state, &(node));
-		if (ACPI_FAILURE(status)) {
-#ifdef ACPI_ASL_COMPILER
-			if (status == AE_NOT_FOUND) {
-				status = AE_OK;
-			} else {
-				ACPI_ERROR_NAMESPACE(buffer_ptr, status);
+
+		/* Special case for Scope(\) -> refers to the Root node */
+
+		if (op && (op->named.node == acpi_gbl_root_node)) {
+			node = op->named.node;
+
+			status =
+			    acpi_ds_scope_stack_push(node, object_type,
+						     walk_state);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
 			}
+		} else {
+			/*
+			 * The Path is an object reference to an existing object.
+			 * Don't enter the name into the namespace, but look it up
+			 * for use later.
+			 */
+			status =
+			    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
+					   object_type, ACPI_IMODE_EXECUTE,
+					   ACPI_NS_SEARCH_PARENT, walk_state,
+					   &(node));
+			if (ACPI_FAILURE(status)) {
+#ifdef ACPI_ASL_COMPILER
+				if (status == AE_NOT_FOUND) {
+					status = AE_OK;
+				} else {
+					ACPI_ERROR_NAMESPACE(buffer_ptr,
+							     status);
+				}
 #else
-			ACPI_ERROR_NAMESPACE(buffer_ptr, status);
+				ACPI_ERROR_NAMESPACE(buffer_ptr, status);
 #endif
-			return_ACPI_STATUS(status);
+				return_ACPI_STATUS(status);
+			}
 		}
 
 		/*


--=-fqHEv3VPZa+FNTPGXcZd--

