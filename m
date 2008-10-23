From: Len Brown <lenb@kernel.org>
Subject: [PATCH 088/122] ACPICA: Add function to dereference returned reference
 objects
Date: Thu, 23 Oct 2008 02:39:02 -0400
Message-ID: <bbc241340681557a16982f4d1840f00963bc05b4.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbYJWGk0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600K2DIJ3SB62@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:15 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Examines the return object from a call to acpi_evaluate_object.
Any Index or RefOf references are automatically dereferenced in
an attempt to return something useful (these reference types
cannot be converted into an external ACPI_OBJECT.)
Lin Ming, Bob Moore.

http://bugzilla.kernel.org/show_bug.cgi?id=11105

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsxfeval.c |   79 +++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index 38be586..f3cc376 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -45,9 +45,14 @@
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acinterp.h>
+#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
+
+/* Local prototypes */
+static void acpi_ns_resolve_references(struct acpi_evaluate_info *info);
+
 #ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
@@ -69,6 +74,7 @@ ACPI_MODULE_NAME("nsxfeval")
  *              be valid (non-null)
  *
  ******************************************************************************/
+
 acpi_status
 acpi_evaluate_object_typed(acpi_handle handle,
 			   acpi_string pathname,
@@ -283,6 +289,10 @@ acpi_evaluate_object(acpi_handle handle,
 
 			if (ACPI_SUCCESS(status)) {
 
+				/* Dereference Index and ref_of references */
+
+				acpi_ns_resolve_references(info);
+
 				/* Get the size of the returned object */
 
 				status =
@@ -352,6 +362,74 @@ ACPI_EXPORT_SYMBOL(acpi_evaluate_object)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ns_resolve_references
+ *
+ * PARAMETERS:  Info                    - Evaluation info block
+ *
+ * RETURN:      Info->return_object is replaced with the dereferenced object
+ *
+ * DESCRIPTION: Dereference certain reference objects. Called before an
+ *              internal return object is converted to an external union acpi_object.
+ *
+ * Performs an automatic dereference of Index and ref_of reference objects.
+ * These reference objects are not supported by the union acpi_object, so this is a
+ * last resort effort to return something useful. Also, provides compatibility
+ * with other ACPI implementations.
+ *
+ * NOTE: does not handle references within returned package objects or nested
+ * references, but this support could be added later if found to be necessary.
+ *
+ ******************************************************************************/
+static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
+{
+	union acpi_operand_object *obj_desc = NULL;
+	struct acpi_namespace_node *node;
+
+	/* We are interested in reference objects only */
+
+	if (ACPI_GET_OBJECT_TYPE(info->return_object) !=
+	    ACPI_TYPE_LOCAL_REFERENCE) {
+		return;
+	}
+
+	/*
+	 * Two types of references are supported - those created by Index and
+	 * ref_of operators. A name reference (AML_NAMEPATH_OP) can be converted
+	 * to an union acpi_object, so it is not dereferenced here. A ddb_handle
+	 * (AML_LOAD_OP) cannot be dereferenced, nor can it be converted to
+	 * an union acpi_object.
+	 */
+	switch (info->return_object->reference.opcode) {
+	case AML_INDEX_OP:
+
+		obj_desc = *(info->return_object->reference.where);
+		break;
+
+	case AML_REF_OF_OP:
+
+		node = info->return_object->reference.object;
+		if (node) {
+			obj_desc = node->object;
+		}
+		break;
+
+	default:
+		return;
+	}
+
+	/* Replace the existing reference object */
+
+	if (obj_desc) {
+		acpi_ut_add_reference(obj_desc);
+		acpi_ut_remove_reference(info->return_object);
+		info->return_object = obj_desc;
+	}
+
+	return;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_walk_namespace
  *
  * PARAMETERS:  Type                - acpi_object_type to search for
@@ -379,6 +457,7 @@ ACPI_EXPORT_SYMBOL(acpi_evaluate_object)
  *              function, etc.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
-- 
1.5.5.1

