From: Len Brown <lenb@kernel.org>
Subject: [PATCH 54/73] ACPICA: Fixes for Unload and DDBHandles
Date: Sat, 12 Apr 2008 00:25:37 -0400
Message-ID: <961d6e54f73757113d744e39c84cdc05602ec977.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753485AbYDLE2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:11 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented support for the use of DDBHandles as an Indexed
Reference, as per the ACPI spec. (Lin Ming) BZ 486. Implemented
support for UserTerm (Method invocation) for the Unload operator
as per the ACPI spec. (Lin Ming) BZ 580

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c   |   27 +++++++++++++++++++--------
 drivers/acpi/executer/exresolv.c |   13 +++++++++----
 drivers/acpi/executer/exstore.c  |   23 ++++++++++++++++++-----
 drivers/acpi/parser/psargs.c     |   37 ++++++++++++++++++++++++++++++++++---
 drivers/acpi/utilities/utcopy.c  |    8 ++++++++
 5 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 251d84b..ed560e6 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -895,14 +895,25 @@ static void acpi_ex_dump_reference_obj(union acpi_operand_object *obj_desc)
 	} else if (obj_desc->reference.object) {
 		if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) ==
 		    ACPI_DESC_TYPE_OPERAND) {
-			acpi_os_printf(" Target: %p [%s]\n",
-				       obj_desc->reference.object,
-				       acpi_ut_get_type_name(((union
-							       acpi_operand_object
-							       *)obj_desc->
-							      reference.
-							      object)->common.
-							     type));
+			acpi_os_printf(" Target: %p",
+				       obj_desc->reference.object);
+			if (obj_desc->reference.opcode == AML_LOAD_OP) {
+				/*
+				 * For DDBHandle reference,
+				 * obj_desc->Reference.Object is the table index
+				 */
+				acpi_os_printf(" [DDBHandle]\n");
+			} else {
+				acpi_os_printf(" [%s]\n",
+					       acpi_ut_get_type_name(((union
+								       acpi_operand_object
+								       *)
+								      obj_desc->
+								      reference.
+								      object)->
+								     common.
+								     type));
+			}
 		} else {
 			acpi_os_printf(" Target: %p\n",
 				       obj_desc->reference.object);
diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/executer/exresolv.c
index 9c3cdf6..5b5b2ff 100644
--- a/drivers/acpi/executer/exresolv.c
+++ b/drivers/acpi/executer/exresolv.c
@@ -382,10 +382,10 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 	}
 
 	/*
-	 * For reference objects created via the ref_of or Index operators,
-	 * we need to get to the base object (as per the ACPI specification
-	 * of the object_type and size_of operators). This means traversing
-	 * the list of possibly many nested references.
+	 * For reference objects created via the ref_of, Index, or Load/load_table
+	 * operators, we need to get to the base object (as per the ACPI
+	 * specification of the object_type and size_of operators). This means
+	 * traversing the list of possibly many nested references.
 	 */
 	while (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_REFERENCE) {
 		switch (obj_desc->reference.opcode) {
@@ -455,6 +455,11 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 			}
 			break;
 
+		case AML_LOAD_OP:
+
+			type = ACPI_TYPE_DDB_HANDLE;
+			goto exit;
+
 		case AML_LOCAL_OP:
 		case AML_ARG_OP:
 
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 2408122..725614e 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -434,11 +434,24 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 		 */
 		obj_desc = *(index_desc->reference.where);
 
-		status =
-		    acpi_ut_copy_iobject_to_iobject(source_desc, &new_desc,
-						    walk_state);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+		if (ACPI_GET_OBJECT_TYPE(source_desc) ==
+		    ACPI_TYPE_LOCAL_REFERENCE
+		    && source_desc->reference.opcode == AML_LOAD_OP) {
+
+			/* This is a DDBHandle, just add a reference to it */
+
+			acpi_ut_add_reference(source_desc);
+			new_desc = source_desc;
+		} else {
+			/* Normal object, copy it */
+
+			status =
+			    acpi_ut_copy_iobject_to_iobject(source_desc,
+							    &new_desc,
+							    walk_state);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
 		}
 
 		if (obj_desc) {
diff --git a/drivers/acpi/parser/psargs.c b/drivers/acpi/parser/psargs.c
index 442880f..2a3a948 100644
--- a/drivers/acpi/parser/psargs.c
+++ b/drivers/acpi/parser/psargs.c
@@ -235,6 +235,7 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	union acpi_parse_object *name_op;
 	union acpi_operand_object *method_desc;
 	struct acpi_namespace_node *node;
+	u8 *start = parser_state->aml;
 
 	ACPI_FUNCTION_TRACE(ps_get_next_namepath);
 
@@ -267,6 +268,16 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
+		if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
+			/*
+			 * acpi_ps_get_next_namestring has increased the AML pointer,
+			 * so we need to restore the saved AML pointer for method call.
+			 */
+			walk_state->parser_state.aml = start;
+			walk_state->arg_count = 1;
+			acpi_ps_init_op(arg, AML_INT_METHODCALL_OP);
+			return_ACPI_STATUS(AE_OK);
+		}
 
 		/* This name is actually a control method invocation */
 
@@ -678,9 +689,29 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			status =
-			    acpi_ps_get_next_namepath(walk_state, parser_state,
-						      arg, 0);
+			/* To support super_name arg of Unload */
+
+			if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
+				status =
+				    acpi_ps_get_next_namepath(walk_state,
+							      parser_state, arg,
+							      1);
+
+				/*
+				 * If the super_name arg of Unload is a method call,
+				 * we have restored the AML pointer, just free this Arg
+				 */
+				if (arg->common.aml_opcode ==
+				    AML_INT_METHODCALL_OP) {
+					acpi_ps_free_op(arg);
+					arg = NULL;
+				}
+			} else {
+				status =
+				    acpi_ps_get_next_namepath(walk_state,
+							      parser_state, arg,
+							      0);
+			}
 		} else {
 			/* Single complex argument, nothing returned */
 
diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index b56953d..ba89971 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -709,7 +709,15 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 		/*
 		 * We copied the reference object, so we now must add a reference
 		 * to the object pointed to by the reference
+		 *
+		 * DDBHandle reference (from Load/load_table is a special reference,
+		 * it's Reference.Object is the table index, so does not need to
+		 * increase the reference count
 		 */
+		if (source_desc->reference.opcode == AML_LOAD_OP) {
+			break;
+		}
+
 		acpi_ut_add_reference(source_desc->reference.object);
 		break;
 
-- 
1.5.5.29.g7134

