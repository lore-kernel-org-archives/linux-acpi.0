From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 48/53] ACPICA: Improvements for debug output only
Date: Mon,  5 Jun 2017 16:42:02 +0800
Message-ID: <cabf6f461cd34925533d55a20219eb2d85362a9c.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbdFEImE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:42:04 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c3f798b7b0e4f2403d3ce0cc1107ab0932efe1e3

Changes to debug print and debug function tracing.

Link: https://github.com/acpica/acpica/commit/c3f798b7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsargs.c  |  5 +++--
 drivers/acpi/acpica/dswexec.c |  4 ++--
 drivers/acpi/acpica/exdump.c  | 30 ++++++++++++++++++++----------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 287b3fd..2873455 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -82,7 +82,7 @@ acpi_ds_execute_arguments(struct acpi_namespace_node *node,
 	union acpi_parse_object *op;
 	struct acpi_walk_state *walk_state;
 
-	ACPI_FUNCTION_TRACE(ds_execute_arguments);
+	ACPI_FUNCTION_TRACE_PTR(ds_execute_arguments, aml_start);
 
 	/* Allocate a new parser op to be the root of the parsed tree */
 
@@ -338,7 +338,8 @@ acpi_status acpi_ds_get_package_arguments(union acpi_operand_object *obj_desc)
 		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Package Arg Init\n"));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Package Argument Init, AML Ptr: %p\n",
+			  obj_desc->package.aml_start));
 
 	/* Execute the AML code for the term_arg arguments */
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index a2ff8ad..20d7744 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -576,8 +576,8 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 		case AML_TYPE_CREATE_OBJECT:
 
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-					  "Executing CreateObject (Buffer/Package) Op=%p\n",
-					  op));
+					  "Executing CreateObject (Buffer/Package) Op=%p AMLPtr=%p\n",
+					  op, op->named.data));
 
 			switch (op->common.parent->common.aml_opcode) {
 			case AML_NAME_OP:
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 970dc6c..44092f7 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -645,10 +645,12 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 	/* obj_desc is a valid object */
 
 	if (depth > 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%*s[%u] %p ",
-				  depth, " ", depth, obj_desc));
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%*s[%u] %p Refs=%u ",
+				  depth, " ", depth, obj_desc,
+				  obj_desc->common.reference_count));
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%p ", obj_desc));
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%p Refs=%u ",
+				  obj_desc, obj_desc->common.reference_count));
 	}
 
 	/* Decode object type */
@@ -690,8 +692,11 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		case ACPI_REFCLASS_NAME:
 
-			acpi_os_printf("- [%4.4s]\n",
-				       obj_desc->reference.node->name.ascii);
+			acpi_ut_repair_name(obj_desc->reference.node->name.
+					    ascii);
+			acpi_os_printf("- [%4.4s] (Node %p)\n",
+				       obj_desc->reference.node->name.ascii,
+				       obj_desc->reference.node);
 			break;
 
 		case ACPI_REFCLASS_ARG:
@@ -999,9 +1004,15 @@ static void acpi_ex_dump_reference_obj(union acpi_operand_object *obj_desc)
 		status = acpi_ns_handle_to_pathname(obj_desc->reference.node,
 						    &ret_buf, TRUE);
 		if (ACPI_FAILURE(status)) {
-			acpi_os_printf(" Could not convert name to pathname\n");
+			acpi_os_printf
+			    (" Could not convert name to pathname: %s\n",
+			     acpi_format_exception(status));
 		} else {
-			acpi_os_printf("%s\n", (char *)ret_buf.pointer);
+			acpi_os_printf("%s: %s\n",
+				       acpi_ut_get_type_name(obj_desc->
+							     reference.node->
+							     type),
+				       (char *)ret_buf.pointer);
 			ACPI_FREE(ret_buf.pointer);
 		}
 	} else if (obj_desc->reference.object) {
@@ -1111,9 +1122,8 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		acpi_os_printf("[Object Reference] Type [%s] %2.2X",
-			       acpi_ut_get_reference_name(obj_desc),
-			       obj_desc->reference.class);
+		acpi_os_printf("[Object Reference] Class [%s]",
+			       acpi_ut_get_reference_name(obj_desc));
 		acpi_ex_dump_reference_obj(obj_desc);
 		break;
 
-- 
2.7.4

