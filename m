From: akpm@linux-foundation.org
Subject: [patch 11/11] revert "ACPICA: Fixes for Unload and DDBHandles"
Date: Wed, 14 May 2008 16:09:22 -0700
Message-ID: <200805142309.m4EN9NSE026007@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48988 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756644AbYENXTm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 19:19:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, astarikovskiy@suse.de, len.brown@intel.com, ming.m.lin@intel.com, penberg@cs.helsinki.fi, robert.moore@intel.com, vegard.nossum@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

Revert

commit bc7a36ab74e09da7bb63e2477b0740ac992b290e
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Thu Apr 10 19:06:42 2008 +0400

    ACPICA: Fixes for Unload and DDBHandles
    
    Implemented support for the use of DDBHandles as an Indexed
    Reference, as per the ACPI spec.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=486.
    
    Implemented support for UserTerm (Method invocation) for the Unload operator
    as per the ACPI spec.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=580
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

Due to a use-after-free identified with kmemcheck.


Cc: "Vegard Nossum" <vegard.nossum@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Lin Ming" <ming.m.lin@intel.com>
Cc: "Bob Moore" <robert.moore@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/executer/exdump.c   |   27 ++++++---------------
 drivers/acpi/executer/exresolv.c |   13 +++-------
 drivers/acpi/executer/exstore.c  |   23 +++---------------
 drivers/acpi/parser/psargs.c     |   37 ++---------------------------
 drivers/acpi/utilities/utcopy.c  |    8 ------
 5 files changed, 20 insertions(+), 88 deletions(-)

diff -puN drivers/acpi/executer/exdump.c~revert-acpica-fixes-for-unload-and-ddbhandles drivers/acpi/executer/exdump.c
--- a/drivers/acpi/executer/exdump.c~revert-acpica-fixes-for-unload-and-ddbhandles
+++ a/drivers/acpi/executer/exdump.c
@@ -895,25 +895,14 @@ static void acpi_ex_dump_reference_obj(u
 	} else if (obj_desc->reference.object) {
 		if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) ==
 		    ACPI_DESC_TYPE_OPERAND) {
-			acpi_os_printf(" Target: %p",
-				       obj_desc->reference.object);
-			if (obj_desc->reference.opcode == AML_LOAD_OP) {
-				/*
-				 * For DDBHandle reference,
-				 * obj_desc->Reference.Object is the table index
-				 */
-				acpi_os_printf(" [DDBHandle]\n");
-			} else {
-				acpi_os_printf(" [%s]\n",
-					       acpi_ut_get_type_name(((union
-								       acpi_operand_object
-								       *)
-								      obj_desc->
-								      reference.
-								      object)->
-								     common.
-								     type));
-			}
+			acpi_os_printf(" Target: %p [%s]\n",
+				       obj_desc->reference.object,
+				       acpi_ut_get_type_name(((union
+							       acpi_operand_object
+							       *)obj_desc->
+							      reference.
+							      object)->common.
+							     type));
 		} else {
 			acpi_os_printf(" Target: %p\n",
 				       obj_desc->reference.object);
diff -puN drivers/acpi/executer/exresolv.c~revert-acpica-fixes-for-unload-and-ddbhandles drivers/acpi/executer/exresolv.c
--- a/drivers/acpi/executer/exresolv.c~revert-acpica-fixes-for-unload-and-ddbhandles
+++ a/drivers/acpi/executer/exresolv.c
@@ -382,10 +382,10 @@ acpi_ex_resolve_multiple(struct acpi_wal
 	}
 
 	/*
-	 * For reference objects created via the ref_of, Index, or Load/load_table
-	 * operators, we need to get to the base object (as per the ACPI
-	 * specification of the object_type and size_of operators). This means
-	 * traversing the list of possibly many nested references.
+	 * For reference objects created via the ref_of or Index operators,
+	 * we need to get to the base object (as per the ACPI specification
+	 * of the object_type and size_of operators). This means traversing
+	 * the list of possibly many nested references.
 	 */
 	while (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_REFERENCE) {
 		switch (obj_desc->reference.opcode) {
@@ -455,11 +455,6 @@ acpi_ex_resolve_multiple(struct acpi_wal
 			}
 			break;
 
-		case AML_LOAD_OP:
-
-			type = ACPI_TYPE_DDB_HANDLE;
-			goto exit;
-
 		case AML_LOCAL_OP:
 		case AML_ARG_OP:
 
diff -puN drivers/acpi/executer/exstore.c~revert-acpica-fixes-for-unload-and-ddbhandles drivers/acpi/executer/exstore.c
--- a/drivers/acpi/executer/exstore.c~revert-acpica-fixes-for-unload-and-ddbhandles
+++ a/drivers/acpi/executer/exstore.c
@@ -462,24 +462,11 @@ acpi_ex_store_object_to_index(union acpi
 		 */
 		obj_desc = *(index_desc->reference.where);
 
-		if (ACPI_GET_OBJECT_TYPE(source_desc) ==
-		    ACPI_TYPE_LOCAL_REFERENCE
-		    && source_desc->reference.opcode == AML_LOAD_OP) {
-
-			/* This is a DDBHandle, just add a reference to it */
-
-			acpi_ut_add_reference(source_desc);
-			new_desc = source_desc;
-		} else {
-			/* Normal object, copy it */
-
-			status =
-			    acpi_ut_copy_iobject_to_iobject(source_desc,
-							    &new_desc,
-							    walk_state);
-			if (ACPI_FAILURE(status)) {
-				return_ACPI_STATUS(status);
-			}
+		status =
+		    acpi_ut_copy_iobject_to_iobject(source_desc, &new_desc,
+						    walk_state);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
 		}
 
 		if (obj_desc) {
diff -puN drivers/acpi/parser/psargs.c~revert-acpica-fixes-for-unload-and-ddbhandles drivers/acpi/parser/psargs.c
--- a/drivers/acpi/parser/psargs.c~revert-acpica-fixes-for-unload-and-ddbhandles
+++ a/drivers/acpi/parser/psargs.c
@@ -235,7 +235,6 @@ acpi_ps_get_next_namepath(struct acpi_wa
 	union acpi_parse_object *name_op;
 	union acpi_operand_object *method_desc;
 	struct acpi_namespace_node *node;
-	u8 *start = parser_state->aml;
 
 	ACPI_FUNCTION_TRACE(ps_get_next_namepath);
 
@@ -268,16 +267,6 @@ acpi_ps_get_next_namepath(struct acpi_wa
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
-		if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
-			/*
-			 * acpi_ps_get_next_namestring has increased the AML pointer,
-			 * so we need to restore the saved AML pointer for method call.
-			 */
-			walk_state->parser_state.aml = start;
-			walk_state->arg_count = 1;
-			acpi_ps_init_op(arg, AML_INT_METHODCALL_OP);
-			return_ACPI_STATUS(AE_OK);
-		}
 
 		/* This name is actually a control method invocation */
 
@@ -689,29 +678,9 @@ acpi_ps_get_next_arg(struct acpi_walk_st
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			/* To support super_name arg of Unload */
-
-			if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
-				status =
-				    acpi_ps_get_next_namepath(walk_state,
-							      parser_state, arg,
-							      1);
-
-				/*
-				 * If the super_name arg of Unload is a method call,
-				 * we have restored the AML pointer, just free this Arg
-				 */
-				if (arg->common.aml_opcode ==
-				    AML_INT_METHODCALL_OP) {
-					acpi_ps_free_op(arg);
-					arg = NULL;
-				}
-			} else {
-				status =
-				    acpi_ps_get_next_namepath(walk_state,
-							      parser_state, arg,
-							      0);
-			}
+			status =
+			    acpi_ps_get_next_namepath(walk_state, parser_state,
+						      arg, 0);
 		} else {
 			/* Single complex argument, nothing returned */
 
diff -puN drivers/acpi/utilities/utcopy.c~revert-acpica-fixes-for-unload-and-ddbhandles drivers/acpi/utilities/utcopy.c
--- a/drivers/acpi/utilities/utcopy.c~revert-acpica-fixes-for-unload-and-ddbhandles
+++ a/drivers/acpi/utilities/utcopy.c
@@ -742,15 +742,7 @@ acpi_ut_copy_simple_object(union acpi_op
 		/*
 		 * We copied the reference object, so we now must add a reference
 		 * to the object pointed to by the reference
-		 *
-		 * DDBHandle reference (from Load/load_table is a special reference,
-		 * it's Reference.Object is the table index, so does not need to
-		 * increase the reference count
 		 */
-		if (source_desc->reference.opcode == AML_LOAD_OP) {
-			break;
-		}
-
 		acpi_ut_add_reference(source_desc->reference.object);
 		break;
 
_
