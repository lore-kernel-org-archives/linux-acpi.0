From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/65] ACPICA: New: AcpiInstallMethod - install a single
 control method
Date: Fri, 29 May 2009 21:42:06 -0400
Message-ID: <b2f7ddcfcb9c2436896cb339a7ff70245648f033.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZE3Bmx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:53 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00CP3ORH58M3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:54 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

This interface enables the override or creation of a single
control method. Useful to repair a bug or install a missing method.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    1 +
 drivers/acpi/acpica/amlcode.h  |    2 +-
 drivers/acpi/acpica/excreate.c |    2 +-
 drivers/acpi/acpica/exdump.c   |    6 +-
 drivers/acpi/acpica/nsobject.c |    9 +++
 drivers/acpi/acpica/nsxfname.c |  150 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    2 +
 7 files changed, 168 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 2ec394a..882b4b5 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -205,6 +205,7 @@ struct acpi_namespace_node {
 #define ANOBJ_METHOD_LOCAL              0x08	/* Node is a method local */
 #define ANOBJ_SUBTREE_HAS_INI           0x10	/* Used to optimize device initialization */
 #define ANOBJ_EVALUATED                 0x20	/* Set on first evaluation of node */
+#define ANOBJ_ALLOCATED_BUFFER          0x40	/* Method AML buffer is dynamic (install_method) */
 
 #define ANOBJ_IS_EXTERNAL               0x08	/* i_aSL only: This object created via External() */
 #define ANOBJ_METHOD_NO_RETVAL          0x10	/* i_aSL only: Method has no return value */
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index ff851c5..067f967 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -483,7 +483,7 @@ typedef enum {
 
 #define AML_METHOD_ARG_COUNT        0x07
 #define AML_METHOD_SERIALIZED       0x08
-#define AML_METHOD_SYNCH_LEVEL      0xF0
+#define AML_METHOD_SYNC_LEVEL       0xF0
 
 /* METHOD_FLAGS_ARG_COUNT is not used internally, define additional flags */
 
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index a57ad25..02b25d2 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -502,7 +502,7 @@ acpi_ex_create_method(u8 * aml_start,
 		 * ACPI 2.0: sync_level = sync_level in method declaration
 		 */
 		obj_desc->method.sync_level = (u8)
-		    ((method_flags & AML_METHOD_SYNCH_LEVEL) >> 4);
+		    ((method_flags & AML_METHOD_SYNC_LEVEL) >> 4);
 	}
 
 	/* Attach the new object to the method Node */
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 89d141f..ec52461 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -120,9 +120,11 @@ static struct acpi_exdump_info acpi_ex_dump_event[2] = {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(event.os_semaphore), "OsSemaphore"}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_method[8] = {
+static struct acpi_exdump_info acpi_ex_dump_method[9] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_method), NULL},
-	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.param_count), "ParamCount"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.method_flags), "Method Flags"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.param_count),
+	 "Parameter Count"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.sync_level), "Sync Level"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(method.mutex), "Mutex"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.owner_id), "Owner Id"},
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 3eb20bf..60f3af0 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -213,6 +213,15 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 		return_VOID;
 	}
 
+	if (node->flags & ANOBJ_ALLOCATED_BUFFER) {
+
+		/* Free the dynamic aml buffer */
+
+		if (obj_desc->common.type == ACPI_TYPE_METHOD) {
+			ACPI_FREE(obj_desc->method.aml_start);
+		}
+	}
+
 	/* Clear the entry in all cases */
 
 	node->object = NULL;
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 9589fea..f23593d 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -45,6 +45,8 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
+#include "acparser.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfname")
@@ -358,3 +360,151 @@ acpi_get_object_info(acpi_handle handle, struct acpi_buffer * buffer)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_object_info)
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_install_method
+ *
+ * PARAMETERS:  Buffer         - An ACPI table containing one control method
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a control method into the namespace. If the method
+ *              name already exists in the namespace, it is overwritten. The
+ *              input buffer must contain a valid DSDT or SSDT containing a
+ *              single control method.
+ *
+ ******************************************************************************/
+acpi_status acpi_install_method(u8 *buffer)
+{
+	struct acpi_table_header *table =
+	    ACPI_CAST_PTR(struct acpi_table_header, buffer);
+	u8 *aml_buffer;
+	u8 *aml_start;
+	char *path;
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *method_obj;
+	struct acpi_parse_state parser_state;
+	u32 aml_length;
+	u16 opcode;
+	u8 method_flags;
+	acpi_status status;
+
+	/* Parameter validation */
+
+	if (!buffer) {
+		return AE_BAD_PARAMETER;
+	}
+
+	/* Table must be a DSDT or SSDT */
+
+	if (!ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) &&
+	    !ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT)) {
+		return AE_BAD_HEADER;
+	}
+
+	/* First AML opcode in the table must be a control method */
+
+	parser_state.aml = buffer + sizeof(struct acpi_table_header);
+	opcode = acpi_ps_peek_opcode(&parser_state);
+	if (opcode != AML_METHOD_OP) {
+		return AE_BAD_PARAMETER;
+	}
+
+	/* Extract method information from the raw AML */
+
+	parser_state.aml += acpi_ps_get_opcode_size(opcode);
+	parser_state.pkg_end = acpi_ps_get_next_package_end(&parser_state);
+	path = acpi_ps_get_next_namestring(&parser_state);
+	method_flags = *parser_state.aml++;
+	aml_start = parser_state.aml;
+	aml_length = ACPI_PTR_DIFF(parser_state.pkg_end, aml_start);
+
+	/*
+	 * Allocate resources up-front. We don't want to have to delete a new
+	 * node from the namespace if we cannot allocate memory.
+	 */
+	aml_buffer = ACPI_ALLOCATE(aml_length);
+	if (!aml_buffer) {
+		return AE_NO_MEMORY;
+	}
+
+	method_obj = acpi_ut_create_internal_object(ACPI_TYPE_METHOD);
+	if (!method_obj) {
+		ACPI_FREE(aml_buffer);
+		return AE_NO_MEMORY;
+	}
+
+	/* Lock namespace for acpi_ns_lookup, we may be creating a new node */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
+	/* The lookup either returns an existing node or creates a new one */
+
+	status =
+	    acpi_ns_lookup(NULL, path, ACPI_TYPE_METHOD, ACPI_IMODE_LOAD_PASS1,
+			   ACPI_NS_DONT_OPEN_SCOPE | ACPI_NS_ERROR_IF_FOUND,
+			   NULL, &node);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+	if (ACPI_FAILURE(status)) {	/* ns_lookup */
+		if (status != AE_ALREADY_EXISTS) {
+			goto error_exit;
+		}
+
+		/* Node existed previously, make sure it is a method node */
+
+		if (node->type != ACPI_TYPE_METHOD) {
+			status = AE_TYPE;
+			goto error_exit;
+		}
+	}
+
+	/* Copy the method AML to the local buffer */
+
+	ACPI_MEMCPY(aml_buffer, aml_start, aml_length);
+
+	/* Initialize the method object with the new method's information */
+
+	method_obj->method.aml_start = aml_buffer;
+	method_obj->method.aml_length = aml_length;
+
+	method_obj->method.param_count = (u8)
+	    (method_flags & AML_METHOD_ARG_COUNT);
+
+	method_obj->method.method_flags = (u8)
+	    (method_flags & ~AML_METHOD_ARG_COUNT);
+
+	if (method_flags & AML_METHOD_SERIALIZED) {
+		method_obj->method.sync_level = (u8)
+		    ((method_flags & AML_METHOD_SYNC_LEVEL) >> 4);
+	}
+
+	/*
+	 * Now that it is complete, we can attach the new method object to
+	 * the method Node (detaches/deletes any existing object)
+	 */
+	status = acpi_ns_attach_object(node, method_obj, ACPI_TYPE_METHOD);
+
+	/*
+	 * Flag indicates AML buffer is dynamic, must be deleted later.
+	 * Must be set only after attach above.
+	 */
+	node->flags |= ANOBJ_ALLOCATED_BUFFER;
+
+	/* Remove local reference to the method object */
+
+	acpi_ut_remove_reference(method_obj);
+	return status;
+
+error_exit:
+
+	ACPI_FREE(aml_buffer);
+	ACPI_FREE(method_obj);
+	return status;
+}
+ACPI_EXPORT_SYMBOL(acpi_install_method)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 60b76a3..c3b08d3 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -201,6 +201,8 @@ acpi_evaluate_object_typed(acpi_handle object,
 acpi_status
 acpi_get_object_info(acpi_handle handle, struct acpi_buffer *return_buffer);
 
+acpi_status acpi_install_method(u8 *buffer);
+
 acpi_status
 acpi_get_next_object(acpi_object_type type,
 		     acpi_handle parent,
-- 
1.6.0.6

