From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/42] ACPICA: Namespace: Add String -> ObjectReference conversion support
Date: Tue, 29 Dec 2015 13:58:02 +0800
Message-ID: <df8691b1dcf18baf9ac7110370d036571415f10c.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43459 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbbL2F6G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:58:06 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 80e60d72959bb51c5d08c8500d978607a42ed81d

BIOS developers may accidently put the quotes around the name strings,
which converts the object references in the packages indicated by the name
strings into the data objects (strings). Such kind of error has been seen
in _DEP control methods on some platforms. This patch implements a
workaround to correct it. Reported by Bastien Nocera. Fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/80e60d72
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=106231
Reported-and-tested-by: Bastien Nocera <bugzilla@hadess.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h  |    6 ++++
 drivers/acpi/acpica/nsconvert.c |   75 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsrepair.c  |    9 ++++-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 1f42c3c..d082e62 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -77,6 +77,7 @@
 /* Object is not a package element */
 
 #define ACPI_NOT_PACKAGE_ELEMENT    ACPI_UINT32_MAX
+#define ACPI_ALL_PACKAGE_ELEMENTS   (ACPI_UINT32_MAX-1)
 
 /* Always emit warning message, not dependent on node flags */
 
@@ -192,6 +193,11 @@ acpi_ns_convert_to_resource(struct acpi_namespace_node *scope,
 			    union acpi_operand_object *original_object,
 			    union acpi_operand_object **return_object);
 
+acpi_status
+acpi_ns_convert_to_reference(struct acpi_namespace_node *scope,
+			     union acpi_operand_object *original_object,
+			     union acpi_operand_object **return_object);
+
 /*
  * nsdump - Namespace dump/print utilities
  */
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index ab47a50..f21568b 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -446,3 +446,78 @@ acpi_ns_convert_to_resource(struct acpi_namespace_node * scope,
 	*return_object = new_object;
 	return (AE_OK);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_convert_to_reference
+ *
+ * PARAMETERS:  scope               - Namespace node for the method/object
+ *              original_object     - Object to be converted
+ *              return_object       - Where the new converted object is returned
+ *
+ * RETURN:      Status. AE_OK if conversion was successful
+ *
+ * DESCRIPTION: Attempt to convert a Integer object to a object_reference.
+ *              Buffer.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_convert_to_reference(struct acpi_namespace_node * scope,
+			     union acpi_operand_object *original_object,
+			     union acpi_operand_object **return_object)
+{
+	union acpi_operand_object *new_object = NULL;
+	acpi_status status;
+	struct acpi_namespace_node *node;
+	union acpi_generic_state scope_info;
+	char *name;
+
+	ACPI_FUNCTION_NAME(ns_convert_to_reference);
+
+	/* Convert path into internal presentation */
+
+	status =
+	    acpi_ns_internalize_name(original_object->string.pointer, &name);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Find the namespace node */
+
+	scope_info.scope.node =
+	    ACPI_CAST_PTR(struct acpi_namespace_node, scope);
+	status =
+	    acpi_ns_lookup(&scope_info, name, ACPI_TYPE_ANY, ACPI_IMODE_EXECUTE,
+			   ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
+			   NULL, &node);
+	if (ACPI_FAILURE(status)) {
+
+		/* Check if we are resolving a named reference within a package */
+
+		ACPI_ERROR_NAMESPACE(original_object->string.pointer, status);
+		goto error_exit;
+	}
+
+	/* Create and init a new internal ACPI object */
+
+	new_object = acpi_ut_create_internal_object(ACPI_TYPE_LOCAL_REFERENCE);
+	if (!new_object) {
+		status = AE_NO_MEMORY;
+		goto error_exit;
+	}
+	new_object->reference.node = node;
+	new_object->reference.object = node->object;
+	new_object->reference.class = ACPI_REFCLASS_NAME;
+
+	/*
+	 * Increase reference of the object if needed (the object is likely a
+	 * null for device nodes).
+	 */
+	acpi_ut_add_reference(node->object);
+
+error_exit:
+	ACPI_FREE(name);
+	*return_object = new_object;
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 4b7dbff..6418863 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -116,6 +116,11 @@ static const struct acpi_simple_repair_info acpi_object_repair_info[] = {
 	 ACPI_NOT_PACKAGE_ELEMENT,
 	 acpi_ns_convert_to_resource},
 
+	/* Object reference conversions */
+
+	{"_DEP", ACPI_RTYPE_STRING, ACPI_ALL_PACKAGE_ELEMENTS,
+	 acpi_ns_convert_to_reference},
+
 	/* Unicode conversions */
 
 	{"_MLS", ACPI_RTYPE_STRING, 1,
@@ -360,7 +365,9 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
 			/* Check if we can actually repair this name/type combination */
 
 			if ((return_btype & this_name->unexpected_btypes) &&
-			    (package_index == this_name->package_index)) {
+			    (this_name->package_index ==
+			     ACPI_ALL_PACKAGE_ELEMENTS
+			     || package_index == this_name->package_index)) {
 				return (this_name);
 			}
 
-- 
1.7.10

