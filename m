From: Len Brown <lenb@kernel.org>
Subject: [PATCH 106/122] ACPICA: Cleanup for internal Reference Object
Date: Thu, 23 Oct 2008 02:39:20 -0400
Message-ID: <1044f1f65b7df2aae979e397904c4985eeb99ba2.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbYJWGoV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:21 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:16 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fix some sloppiness in the Reference object. No longer use AML
opcodes to differentiate the types, introduce new reference
Class. Cleanup the debug output code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmthdat.c |   83 ++++++++++++++++++-----------------
 drivers/acpi/dispatcher/dsobject.c |   56 +++++++++++++++---------
 drivers/acpi/dispatcher/dsopcode.c |    2 +-
 drivers/acpi/dispatcher/dswexec.c  |    8 ++--
 drivers/acpi/executer/exconfig.c   |    3 +-
 drivers/acpi/executer/exdump.c     |   74 +++++++++++++++-----------------
 drivers/acpi/executer/exmisc.c     |   14 +++---
 drivers/acpi/executer/exoparg1.c   |   26 ++++++------
 drivers/acpi/executer/exoparg2.c   |    4 +-
 drivers/acpi/executer/exresnte.c   |   16 +++----
 drivers/acpi/executer/exresolv.c   |   60 ++++++++++++-------------
 drivers/acpi/executer/exresop.c    |   50 +++++++++------------
 drivers/acpi/executer/exstore.c    |   57 +++++++++++++------------
 drivers/acpi/executer/exstoren.c   |    3 +-
 drivers/acpi/namespace/nsdump.c    |    5 +--
 drivers/acpi/namespace/nsxfeval.c  |    7 +--
 drivers/acpi/resources/rscalc.c    |    5 +-
 drivers/acpi/resources/rscreate.c  |   10 ++---
 drivers/acpi/utilities/utcopy.c    |   29 +++++++------
 drivers/acpi/utilities/utdelete.c  |    5 +-
 drivers/acpi/utilities/utglobal.c  |   35 +++++++++------
 drivers/acpi/utilities/utobject.c  |    9 ++--
 include/acpi/acdebug.h             |    4 ++
 include/acpi/acdispat.h            |    6 +-
 include/acpi/acobject.h            |   31 ++++++++++---
 25 files changed, 310 insertions(+), 292 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmthdat.c b/drivers/acpi/dispatcher/dsmthdat.c
index 13c43ea..d03f81b 100644
--- a/drivers/acpi/dispatcher/dsmthdat.c
+++ b/drivers/acpi/dispatcher/dsmthdat.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acdispat.h>
-#include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acinterp.h>
 
@@ -52,11 +51,11 @@ ACPI_MODULE_NAME("dsmthdat")
 
 /* Local prototypes */
 static void
-acpi_ds_method_data_delete_value(u16 opcode,
+acpi_ds_method_data_delete_value(u8 type,
 				 u32 index, struct acpi_walk_state *walk_state);
 
 static acpi_status
-acpi_ds_method_data_set_value(u16 opcode,
+acpi_ds_method_data_set_value(u8 type,
 			      u32 index,
 			      union acpi_operand_object *object,
 			      struct acpi_walk_state *walk_state);
@@ -216,7 +215,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 		 * Store the argument in the method/walk descriptor.
 		 * Do not copy the arg in order to implement call by reference
 		 */
-		status = acpi_ds_method_data_set_value(AML_ARG_OP, index,
+		status = acpi_ds_method_data_set_value(ACPI_REFCLASS_ARG, index,
 						       params[index],
 						       walk_state);
 		if (ACPI_FAILURE(status)) {
@@ -234,7 +233,8 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
  *
  * FUNCTION:    acpi_ds_method_data_get_node
  *
- * PARAMETERS:  Opcode              - Either AML_LOCAL_OP or AML_ARG_OP
+ * PARAMETERS:  Type                - Either ACPI_REFCLASS_LOCAL or
+ *                                    ACPI_REFCLASS_ARG
  *              Index               - Which Local or Arg whose type to get
  *              walk_state          - Current walk state object
  *              Node                - Where the node is returned.
@@ -246,7 +246,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_method_data_get_node(u16 opcode,
+acpi_ds_method_data_get_node(u8 type,
 			     u32 index,
 			     struct acpi_walk_state *walk_state,
 			     struct acpi_namespace_node **node)
@@ -256,8 +256,8 @@ acpi_ds_method_data_get_node(u16 opcode,
 	/*
 	 * Method Locals and Arguments are supported
 	 */
-	switch (opcode) {
-	case AML_LOCAL_OP:
+	switch (type) {
+	case ACPI_REFCLASS_LOCAL:
 
 		if (index > ACPI_METHOD_MAX_LOCAL) {
 			ACPI_ERROR((AE_INFO,
@@ -271,7 +271,7 @@ acpi_ds_method_data_get_node(u16 opcode,
 		*node = &walk_state->local_variables[index];
 		break;
 
-	case AML_ARG_OP:
+	case ACPI_REFCLASS_ARG:
 
 		if (index > ACPI_METHOD_MAX_ARG) {
 			ACPI_ERROR((AE_INFO,
@@ -286,8 +286,8 @@ acpi_ds_method_data_get_node(u16 opcode,
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Opcode %d is invalid", opcode));
-		return_ACPI_STATUS(AE_AML_BAD_OPCODE);
+		ACPI_ERROR((AE_INFO, "Type %d is invalid", type));
+		return_ACPI_STATUS(AE_TYPE);
 	}
 
 	return_ACPI_STATUS(AE_OK);
@@ -297,7 +297,8 @@ acpi_ds_method_data_get_node(u16 opcode,
  *
  * FUNCTION:    acpi_ds_method_data_set_value
  *
- * PARAMETERS:  Opcode              - Either AML_LOCAL_OP or AML_ARG_OP
+ * PARAMETERS:  Type                - Either ACPI_REFCLASS_LOCAL or
+ *                                    ACPI_REFCLASS_ARG
  *              Index               - Which Local or Arg to get
  *              Object              - Object to be inserted into the stack entry
  *              walk_state          - Current walk state object
@@ -310,7 +311,7 @@ acpi_ds_method_data_get_node(u16 opcode,
  ******************************************************************************/
 
 static acpi_status
-acpi_ds_method_data_set_value(u16 opcode,
+acpi_ds_method_data_set_value(u8 type,
 			      u32 index,
 			      union acpi_operand_object *object,
 			      struct acpi_walk_state *walk_state)
@@ -321,13 +322,13 @@ acpi_ds_method_data_set_value(u16 opcode,
 	ACPI_FUNCTION_TRACE(ds_method_data_set_value);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "NewObj %p Opcode %X, Refs=%d [%s]\n", object,
-			  opcode, object->common.reference_count,
+			  "NewObj %p Type %2.2X, Refs=%d [%s]\n", object,
+			  type, object->common.reference_count,
 			  acpi_ut_get_type_name(object->common.type)));
 
 	/* Get the namespace node for the arg/local */
 
-	status = acpi_ds_method_data_get_node(opcode, index, walk_state, &node);
+	status = acpi_ds_method_data_get_node(type, index, walk_state, &node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -350,7 +351,8 @@ acpi_ds_method_data_set_value(u16 opcode,
  *
  * FUNCTION:    acpi_ds_method_data_get_value
  *
- * PARAMETERS:  Opcode              - Either AML_LOCAL_OP or AML_ARG_OP
+ * PARAMETERS:  Type                - Either ACPI_REFCLASS_LOCAL or
+ *                                    ACPI_REFCLASS_ARG
  *              Index               - Which local_var or argument to get
  *              walk_state          - Current walk state object
  *              dest_desc           - Where Arg or Local value is returned
@@ -363,7 +365,7 @@ acpi_ds_method_data_set_value(u16 opcode,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_method_data_get_value(u16 opcode,
+acpi_ds_method_data_get_value(u8 type,
 			      u32 index,
 			      struct acpi_walk_state *walk_state,
 			      union acpi_operand_object **dest_desc)
@@ -383,7 +385,7 @@ acpi_ds_method_data_get_value(u16 opcode,
 
 	/* Get the namespace node for the arg/local */
 
-	status = acpi_ds_method_data_get_node(opcode, index, walk_state, &node);
+	status = acpi_ds_method_data_get_node(type, index, walk_state, &node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -419,8 +421,8 @@ acpi_ds_method_data_get_value(u16 opcode,
 		/* Otherwise, return the error */
 
 		else
-			switch (opcode) {
-			case AML_ARG_OP:
+			switch (type) {
+			case ACPI_REFCLASS_ARG:
 
 				ACPI_ERROR((AE_INFO,
 					    "Uninitialized Arg[%d] at node %p",
@@ -428,7 +430,7 @@ acpi_ds_method_data_get_value(u16 opcode,
 
 				return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
 
-			case AML_LOCAL_OP:
+			case ACPI_REFCLASS_LOCAL:
 
 				ACPI_ERROR((AE_INFO,
 					    "Uninitialized Local[%d] at node %p",
@@ -437,9 +439,10 @@ acpi_ds_method_data_get_value(u16 opcode,
 				return_ACPI_STATUS(AE_AML_UNINITIALIZED_LOCAL);
 
 			default:
+
 				ACPI_ERROR((AE_INFO,
 					    "Not a Arg/Local opcode: %X",
-					    opcode));
+					    type));
 				return_ACPI_STATUS(AE_AML_INTERNAL);
 			}
 	}
@@ -458,7 +461,8 @@ acpi_ds_method_data_get_value(u16 opcode,
  *
  * FUNCTION:    acpi_ds_method_data_delete_value
  *
- * PARAMETERS:  Opcode              - Either AML_LOCAL_OP or AML_ARG_OP
+ * PARAMETERS:  Type                - Either ACPI_REFCLASS_LOCAL or
+ *                                    ACPI_REFCLASS_ARG
  *              Index               - Which local_var or argument to delete
  *              walk_state          - Current walk state object
  *
@@ -470,7 +474,7 @@ acpi_ds_method_data_get_value(u16 opcode,
  ******************************************************************************/
 
 static void
-acpi_ds_method_data_delete_value(u16 opcode,
+acpi_ds_method_data_delete_value(u8 type,
 				 u32 index, struct acpi_walk_state *walk_state)
 {
 	acpi_status status;
@@ -481,7 +485,7 @@ acpi_ds_method_data_delete_value(u16 opcode,
 
 	/* Get the namespace node for the arg/local */
 
-	status = acpi_ds_method_data_get_node(opcode, index, walk_state, &node);
+	status = acpi_ds_method_data_get_node(type, index, walk_state, &node);
 	if (ACPI_FAILURE(status)) {
 		return_VOID;
 	}
@@ -514,7 +518,8 @@ acpi_ds_method_data_delete_value(u16 opcode,
  *
  * FUNCTION:    acpi_ds_store_object_to_local
  *
- * PARAMETERS:  Opcode              - Either AML_LOCAL_OP or AML_ARG_OP
+ * PARAMETERS:  Type                - Either ACPI_REFCLASS_LOCAL or
+ *                                    ACPI_REFCLASS_ARG
  *              Index               - Which Local or Arg to set
  *              obj_desc            - Value to be stored
  *              walk_state          - Current walk state
@@ -528,7 +533,7 @@ acpi_ds_method_data_delete_value(u16 opcode,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_store_object_to_local(u16 opcode,
+acpi_ds_store_object_to_local(u8 type,
 			      u32 index,
 			      union acpi_operand_object *obj_desc,
 			      struct acpi_walk_state *walk_state)
@@ -539,8 +544,8 @@ acpi_ds_store_object_to_local(u16 opcode,
 	union acpi_operand_object *new_obj_desc;
 
 	ACPI_FUNCTION_TRACE(ds_store_object_to_local);
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Opcode=%X Index=%d Obj=%p\n",
-			  opcode, index, obj_desc));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Type=%2.2X Index=%d Obj=%p\n",
+			  type, index, obj_desc));
 
 	/* Parameter validation */
 
@@ -550,7 +555,7 @@ acpi_ds_store_object_to_local(u16 opcode,
 
 	/* Get the namespace node for the arg/local */
 
-	status = acpi_ds_method_data_get_node(opcode, index, walk_state, &node);
+	status = acpi_ds_method_data_get_node(type, index, walk_state, &node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -602,7 +607,7 @@ acpi_ds_store_object_to_local(u16 opcode,
 		 *
 		 * Weird, but true.
 		 */
-		if (opcode == AML_ARG_OP) {
+		if (type == ACPI_REFCLASS_ARG) {
 			/*
 			 * If we have a valid reference object that came from ref_of(),
 			 * do the indirect store
@@ -611,8 +616,8 @@ acpi_ds_store_object_to_local(u16 opcode,
 			     ACPI_DESC_TYPE_OPERAND)
 			    && (current_obj_desc->common.type ==
 				ACPI_TYPE_LOCAL_REFERENCE)
-			    && (current_obj_desc->reference.opcode ==
-				AML_REF_OF_OP)) {
+			    && (current_obj_desc->reference.class ==
+				ACPI_REFCLASS_REFOF)) {
 				ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 						  "Arg (%p) is an ObjRef(Node), storing in node %p\n",
 						  new_obj_desc,
@@ -640,11 +645,9 @@ acpi_ds_store_object_to_local(u16 opcode,
 			}
 		}
 
-		/*
-		 * Delete the existing object
-		 * before storing the new one
-		 */
-		acpi_ds_method_data_delete_value(opcode, index, walk_state);
+		/* Delete the existing object before storing the new one */
+
+		acpi_ds_method_data_delete_value(type, index, walk_state);
 	}
 
 	/*
@@ -653,7 +656,7 @@ acpi_ds_store_object_to_local(u16 opcode,
 	 * (increments the object reference count by one)
 	 */
 	status =
-	    acpi_ds_method_data_set_value(opcode, index, new_obj_desc,
+	    acpi_ds_method_data_set_value(type, index, new_obj_desc,
 					  walk_state);
 
 	/* Remove local reference if we copied the object above */
diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 09af39f..4f08e59 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -731,36 +731,35 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 		switch (op_info->type) {
 		case AML_TYPE_LOCAL_VARIABLE:
 
-			/* Split the opcode into a base opcode + offset */
+			/* Local ID (0-7) is (AML opcode - base AML_LOCAL_OP) */
 
-			obj_desc->reference.opcode = AML_LOCAL_OP;
-			obj_desc->reference.offset = opcode - AML_LOCAL_OP;
+			obj_desc->reference.value = opcode - AML_LOCAL_OP;
+			obj_desc->reference.class = ACPI_REFCLASS_LOCAL;
 
 #ifndef ACPI_NO_METHOD_EXECUTION
-			status = acpi_ds_method_data_get_node(AML_LOCAL_OP,
-							      obj_desc->
-							      reference.offset,
-							      walk_state,
-							      ACPI_CAST_INDIRECT_PTR
-							      (struct
-							       acpi_namespace_node,
-							       &obj_desc->
-							       reference.
-							       object));
+			status =
+			    acpi_ds_method_data_get_node(ACPI_REFCLASS_LOCAL,
+							 obj_desc->reference.
+							 value, walk_state,
+							 ACPI_CAST_INDIRECT_PTR
+							 (struct
+							  acpi_namespace_node,
+							  &obj_desc->reference.
+							  object));
 #endif
 			break;
 
 		case AML_TYPE_METHOD_ARGUMENT:
 
-			/* Split the opcode into a base opcode + offset */
+			/* Arg ID (0-6) is (AML opcode - base AML_ARG_OP) */
 
-			obj_desc->reference.opcode = AML_ARG_OP;
-			obj_desc->reference.offset = opcode - AML_ARG_OP;
+			obj_desc->reference.value = opcode - AML_ARG_OP;
+			obj_desc->reference.class = ACPI_REFCLASS_ARG;
 
 #ifndef ACPI_NO_METHOD_EXECUTION
-			status = acpi_ds_method_data_get_node(AML_ARG_OP,
+			status = acpi_ds_method_data_get_node(ACPI_REFCLASS_ARG,
 							      obj_desc->
-							      reference.offset,
+							      reference.value,
 							      walk_state,
 							      ACPI_CAST_INDIRECT_PTR
 							      (struct
@@ -771,18 +770,31 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 #endif
 			break;
 
-		default:	/* Other literals, etc.. */
+		default:	/* Object name or Debug object */
 
-			if (op->common.aml_opcode == AML_INT_NAMEPATH_OP) {
+			switch (op->common.aml_opcode) {
+			case AML_INT_NAMEPATH_OP:
 
 				/* Node was saved in Op */
 
 				obj_desc->reference.node = op->common.node;
 				obj_desc->reference.object =
 				    op->common.node->object;
-			}
+				obj_desc->reference.class = ACPI_REFCLASS_NAME;
+				break;
+
+			case AML_DEBUG_OP:
 
-			obj_desc->reference.opcode = opcode;
+				obj_desc->reference.class = ACPI_REFCLASS_DEBUG;
+				break;
+
+			default:
+
+				ACPI_ERROR((AE_INFO,
+					    "Unimplemented reference type for AML opcode: %4.4X",
+					    opcode));
+				return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+			}
 			break;
 		}
 		break;
diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 6a81c44..69fae59 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1330,7 +1330,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 			     (walk_state->results->results.obj_desc[0]) ==
 			     ACPI_TYPE_LOCAL_REFERENCE)
 			    && ((walk_state->results->results.obj_desc[0])->
-				reference.opcode != AML_INDEX_OP)) {
+				reference.class != ACPI_REFCLASS_INDEX)) {
 				status =
 				    acpi_ex_resolve_to_value(&walk_state->
 							     results->results.
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index b5072fa..5b24191 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -429,10 +429,10 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 			     ACPI_TYPE_LOCAL_REFERENCE)
 			    && (walk_state->operands[1]->common.type ==
 				ACPI_TYPE_LOCAL_REFERENCE)
-			    && (walk_state->operands[0]->reference.opcode ==
-				walk_state->operands[1]->reference.opcode)
-			    && (walk_state->operands[0]->reference.offset ==
-				walk_state->operands[1]->reference.offset)) {
+			    && (walk_state->operands[0]->reference.class ==
+				walk_state->operands[1]->reference.class)
+			    && (walk_state->operands[0]->reference.value ==
+				walk_state->operands[1]->reference.value)) {
 				status = AE_OK;
 			} else {
 				ACPI_EXCEPTION((AE_INFO, status,
diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 5f2b1eb..74da6fa 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
 #include <acpi/actables.h>
 #include <acpi/acdispat.h>
@@ -91,7 +90,7 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Init the table handle */
 
-	obj_desc->reference.opcode = AML_LOAD_OP;
+	obj_desc->reference.class = ACPI_REFCLASS_TABLE;
 	*ddb_handle = obj_desc;
 
 	/* Install the new table into the local data structures */
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 7d41232..d087a7d 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -45,7 +45,6 @@
 #include <acpi/acinterp.h>
 #include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exdump")
@@ -216,8 +215,8 @@ static struct acpi_exdump_info acpi_ex_dump_index_field[5] = {
 
 static struct acpi_exdump_info acpi_ex_dump_reference[8] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_reference), NULL},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(reference.class), "Class"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(reference.target_type), "Target Type"},
-	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(reference.offset), "Offset"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(reference.value), "Value"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.object), "Object Desc"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.node), "Node"},
@@ -414,10 +413,10 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 
 		case ACPI_EXD_REFERENCE:
 
-			acpi_ex_out_string("Opcode",
-					   (acpi_ps_get_opcode_info
-					    (obj_desc->reference.opcode))->
-					   name);
+			acpi_ex_out_string("Class Name",
+					   (char *)
+					   acpi_ut_get_reference_name
+					   (obj_desc));
 			acpi_ex_dump_reference_obj(obj_desc);
 			break;
 
@@ -495,40 +494,41 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		switch (obj_desc->reference.opcode) {
-		case AML_DEBUG_OP:
+		acpi_os_printf("Reference: [%s] ",
+			       acpi_ut_get_reference_name(obj_desc));
+
+		switch (obj_desc->reference.class) {
+		case ACPI_REFCLASS_DEBUG:
 
-			acpi_os_printf("Reference: [Debug]\n");
+			acpi_os_printf("\n");
 			break;
 
-		case AML_INDEX_OP:
+		case ACPI_REFCLASS_INDEX:
 
-			acpi_os_printf("Reference: [Index] %p\n",
-				       obj_desc->reference.object);
+			acpi_os_printf("%p\n", obj_desc->reference.object);
 			break;
 
-		case AML_LOAD_OP:
+		case ACPI_REFCLASS_TABLE:
 
-			acpi_os_printf("Reference: [DdbHandle] TableIndex %X\n",
+			acpi_os_printf("Table Index %X\n",
 				       obj_desc->reference.value);
 			break;
 
-		case AML_REF_OF_OP:
+		case ACPI_REFCLASS_REFOF:
 
-			acpi_os_printf("Reference: [RefOf] %p [%s]\n",
-				       obj_desc->reference.object,
+			acpi_os_printf("%p [%s]\n", obj_desc->reference.object,
 				       acpi_ut_get_type_name(((union
 							       acpi_operand_object
-							       *)obj_desc->
+							       *)
+							      obj_desc->
 							      reference.
 							      object)->common.
 							     type));
 			break;
 
-		case AML_ARG_OP:
+		case ACPI_REFCLASS_ARG:
 
-			acpi_os_printf("Reference: [Arg%d]",
-				       obj_desc->reference.offset);
+			acpi_os_printf("%X", obj_desc->reference.value);
 
 			if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
 
@@ -543,10 +543,9 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 			acpi_os_printf("\n");
 			break;
 
-		case AML_LOCAL_OP:
+		case ACPI_REFCLASS_LOCAL:
 
-			acpi_os_printf("Reference: [Local%d]",
-				       obj_desc->reference.offset);
+			acpi_os_printf("%X", obj_desc->reference.value);
 
 			if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
 
@@ -561,21 +560,16 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 			acpi_os_printf("\n");
 			break;
 
-		case AML_INT_NAMEPATH_OP:
+		case ACPI_REFCLASS_NAME:
 
-			acpi_os_printf("Reference: [Namepath] %X [%4.4s]\n",
-				       obj_desc->reference.node->name.integer,
+			acpi_os_printf("- [%4.4s]\n",
 				       obj_desc->reference.node->name.ascii);
 			break;
 
-		default:
-
-			/* Unknown opcode */
+		default:	/* Unknown reference class */
 
-			acpi_os_printf("Unknown Reference opcode=%X\n",
-				       obj_desc->reference.opcode);
+			acpi_os_printf("%2.2X\n", obj_desc->reference.class);
 			break;
-
 		}
 		break;
 
@@ -866,8 +860,8 @@ static void acpi_ex_dump_reference_obj(union acpi_operand_object *obj_desc)
 
 	ret_buf.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 
-	if (obj_desc->reference.opcode == AML_INT_NAMEPATH_OP) {
-		acpi_os_printf(" Named Object %p ", obj_desc->reference.node);
+	if (obj_desc->reference.class == ACPI_REFCLASS_NAME) {
+		acpi_os_printf(" %p ", obj_desc->reference.node);
 
 		status =
 		    acpi_ns_handle_to_pathname(obj_desc->reference.node,
@@ -883,8 +877,8 @@ static void acpi_ex_dump_reference_obj(union acpi_operand_object *obj_desc)
 		    ACPI_DESC_TYPE_OPERAND) {
 			acpi_os_printf(" Target: %p",
 				       obj_desc->reference.object);
-			if (obj_desc->reference.opcode == AML_LOAD_OP) {
-				acpi_os_printf(" [DDBHandle] Table Index: %X\n",
+			if (obj_desc->reference.class == ACPI_REFCLASS_TABLE) {
+				acpi_os_printf(" Table Index: %X\n",
 					       obj_desc->reference.value);
 			} else {
 				acpi_os_printf(" Target: %p [%s]\n",
@@ -987,9 +981,9 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		acpi_os_printf("[Object Reference] %s",
-			       (acpi_ps_get_opcode_info
-				(obj_desc->reference.opcode))->name);
+		acpi_os_printf("[Object Reference] Type [%s] %2.2X",
+			       acpi_ut_get_reference_name(obj_desc),
+			       obj_desc->reference.class);
 		acpi_ex_dump_reference_obj(obj_desc);
 		break;
 
diff --git a/drivers/acpi/executer/exmisc.c b/drivers/acpi/executer/exmisc.c
index 731414a..efb1913 100644
--- a/drivers/acpi/executer/exmisc.c
+++ b/drivers/acpi/executer/exmisc.c
@@ -86,10 +86,10 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 		/*
 		 * Must be a reference to a Local or Arg
 		 */
-		switch (obj_desc->reference.opcode) {
-		case AML_LOCAL_OP:
-		case AML_ARG_OP:
-		case AML_DEBUG_OP:
+		switch (obj_desc->reference.class) {
+		case ACPI_REFCLASS_LOCAL:
+		case ACPI_REFCLASS_ARG:
+		case ACPI_REFCLASS_DEBUG:
 
 			/* The referenced object is the pseudo-node for the local/arg */
 
@@ -98,8 +98,8 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 
 		default:
 
-			ACPI_ERROR((AE_INFO, "Unknown Reference opcode %X",
-				    obj_desc->reference.opcode));
+			ACPI_ERROR((AE_INFO, "Unknown Reference Class %2.2X",
+				    obj_desc->reference.class));
 			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
 		break;
@@ -127,7 +127,7 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	reference_obj->reference.opcode = AML_REF_OF_OP;
+	reference_obj->reference.class = ACPI_REFCLASS_REFOF;
 	reference_obj->reference.object = referenced_obj;
 	*return_desc = reference_obj;
 
diff --git a/drivers/acpi/executer/exoparg1.c b/drivers/acpi/executer/exoparg1.c
index 7c3bea5..f622f9e 100644
--- a/drivers/acpi/executer/exoparg1.c
+++ b/drivers/acpi/executer/exoparg1.c
@@ -825,16 +825,16 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				 *
 				 * Must resolve/dereference the local/arg reference first
 				 */
-				switch (operand[0]->reference.opcode) {
-				case AML_LOCAL_OP:
-				case AML_ARG_OP:
+				switch (operand[0]->reference.class) {
+				case ACPI_REFCLASS_LOCAL:
+				case ACPI_REFCLASS_ARG:
 
 					/* Set Operand[0] to the value of the local/arg */
 
 					status =
 					    acpi_ds_method_data_get_value
-					    (operand[0]->reference.opcode,
-					     operand[0]->reference.offset,
+					    (operand[0]->reference.class,
+					     operand[0]->reference.value,
 					     walk_state, &temp_desc);
 					if (ACPI_FAILURE(status)) {
 						goto cleanup;
@@ -848,7 +848,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					operand[0] = temp_desc;
 					break;
 
-				case AML_REF_OF_OP:
+				case ACPI_REFCLASS_REFOF:
 
 					/* Get the object to which the reference refers */
 
@@ -928,8 +928,8 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 			 * This must be a reference object produced by either the
 			 * Index() or ref_of() operator
 			 */
-			switch (operand[0]->reference.opcode) {
-			case AML_INDEX_OP:
+			switch (operand[0]->reference.class) {
+			case ACPI_REFCLASS_INDEX:
 
 				/*
 				 * The target type for the Index operator must be
@@ -965,7 +965,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					return_desc->integer.value =
 					    temp_desc->buffer.
 					    pointer[operand[0]->reference.
-						    offset];
+						    value];
 					break;
 
 				case ACPI_TYPE_PACKAGE:
@@ -985,7 +985,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				default:
 
 					ACPI_ERROR((AE_INFO,
-						    "Unknown Index TargetType %X in obj %p",
+						    "Unknown Index TargetType %X in reference object %p",
 						    operand[0]->reference.
 						    target_type, operand[0]));
 					status = AE_AML_OPERAND_TYPE;
@@ -993,7 +993,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				}
 				break;
 
-			case AML_REF_OF_OP:
+			case ACPI_REFCLASS_REFOF:
 
 				return_desc = operand[0]->reference.object;
 
@@ -1013,9 +1013,9 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 			default:
 				ACPI_ERROR((AE_INFO,
-					    "Unknown opcode in reference(%p) - %X",
+					    "Unknown class in reference(%p) - %2.2X",
 					    operand[0],
-					    operand[0]->reference.opcode));
+					    operand[0]->reference.class));
 
 				status = AE_TYPE;
 				goto cleanup;
diff --git a/drivers/acpi/executer/exoparg2.c b/drivers/acpi/executer/exoparg2.c
index 8e8bbb6..368def5 100644
--- a/drivers/acpi/executer/exoparg2.c
+++ b/drivers/acpi/executer/exoparg2.c
@@ -391,8 +391,8 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		/* Initialize the Index reference object */
 
 		index = operand[1]->integer.value;
-		return_desc->reference.offset = (u32) index;
-		return_desc->reference.opcode = AML_INDEX_OP;
+		return_desc->reference.value = (u32) index;
+		return_desc->reference.class = ACPI_REFCLASS_INDEX;
 
 		/*
 		 * At this point, the Source operand is a String, Buffer, or Package.
diff --git a/drivers/acpi/executer/exresnte.c b/drivers/acpi/executer/exresnte.c
index 5596f42..423ad36 100644
--- a/drivers/acpi/executer/exresnte.c
+++ b/drivers/acpi/executer/exresnte.c
@@ -46,8 +46,6 @@
 #include <acpi/acdispat.h>
 #include <acpi/acinterp.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exresnte")
@@ -238,10 +236,10 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		switch (source_desc->reference.opcode) {
-		case AML_LOAD_OP:	/* This is a ddb_handle */
-		case AML_REF_OF_OP:
-		case AML_INDEX_OP:
+		switch (source_desc->reference.class) {
+		case ACPI_REFCLASS_TABLE:	/* This is a ddb_handle */
+		case ACPI_REFCLASS_REFOF:
+		case ACPI_REFCLASS_INDEX:
 
 			/* Return an additional reference to the object */
 
@@ -253,10 +251,8 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 			/* No named references are allowed here */
 
 			ACPI_ERROR((AE_INFO,
-				    "Unsupported Reference opcode %X (%s)",
-				    source_desc->reference.opcode,
-				    acpi_ps_get_opcode_name(source_desc->
-							    reference.opcode)));
+				    "Unsupported Reference type %X",
+				    source_desc->reference.class));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/executer/exresolv.c
index b35f7c8..89571b9 100644
--- a/drivers/acpi/executer/exresolv.c
+++ b/drivers/acpi/executer/exresolv.c
@@ -47,7 +47,6 @@
 #include <acpi/acdispat.h>
 #include <acpi/acinterp.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exresolv")
@@ -141,7 +140,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 	acpi_status status = AE_OK;
 	union acpi_operand_object *stack_desc;
 	union acpi_operand_object *obj_desc = NULL;
-	u16 opcode;
+	u8 ref_type;
 
 	ACPI_FUNCTION_TRACE(ex_resolve_object_to_value);
 
@@ -152,19 +151,19 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 	switch (ACPI_GET_OBJECT_TYPE(stack_desc)) {
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		opcode = stack_desc->reference.opcode;
+		ref_type = stack_desc->reference.class;
 
-		switch (opcode) {
-		case AML_LOCAL_OP:
-		case AML_ARG_OP:
+		switch (ref_type) {
+		case ACPI_REFCLASS_LOCAL:
+		case ACPI_REFCLASS_ARG:
 
 			/*
 			 * Get the local from the method's state info
 			 * Note: this increments the local's object reference count
 			 */
-			status = acpi_ds_method_data_get_value(opcode,
+			status = acpi_ds_method_data_get_value(ref_type,
 							       stack_desc->
-							       reference.offset,
+							       reference.value,
 							       walk_state,
 							       &obj_desc);
 			if (ACPI_FAILURE(status)) {
@@ -173,7 +172,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 					  "[Arg/Local %X] ValueObj is %p\n",
-					  stack_desc->reference.offset,
+					  stack_desc->reference.value,
 					  obj_desc));
 
 			/*
@@ -184,7 +183,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 			*stack_ptr = obj_desc;
 			break;
 
-		case AML_INDEX_OP:
+		case ACPI_REFCLASS_INDEX:
 
 			switch (stack_desc->reference.target_type) {
 			case ACPI_TYPE_BUFFER_FIELD:
@@ -239,15 +238,15 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 			}
 			break;
 
-		case AML_REF_OF_OP:
-		case AML_DEBUG_OP:
-		case AML_LOAD_OP:
+		case ACPI_REFCLASS_REFOF:
+		case ACPI_REFCLASS_DEBUG:
+		case ACPI_REFCLASS_TABLE:
 
 			/* Just leave the object as-is, do not dereference */
 
 			break;
 
-		case AML_INT_NAMEPATH_OP:	/* Reference to a named object */
+		case ACPI_REFCLASS_NAME:	/* Reference to a named object */
 
 			/* Dereference the name */
 
@@ -273,8 +272,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unknown Reference opcode %X (%s) in %p",
-				    opcode, acpi_ps_get_opcode_name(opcode),
+				    "Unknown Reference type %X in %p", ref_type,
 				    stack_desc));
 			status = AE_AML_INTERNAL;
 			break;
@@ -388,13 +386,13 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 	 * traversing the list of possibly many nested references.
 	 */
 	while (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_REFERENCE) {
-		switch (obj_desc->reference.opcode) {
-		case AML_REF_OF_OP:
-		case AML_INT_NAMEPATH_OP:
+		switch (obj_desc->reference.class) {
+		case ACPI_REFCLASS_REFOF:
+		case ACPI_REFCLASS_NAME:
 
 			/* Dereference the reference pointer */
 
-			if (obj_desc->reference.opcode == AML_REF_OF_OP) {
+			if (obj_desc->reference.class == ACPI_REFCLASS_REFOF) {
 				node = obj_desc->reference.object;
 			} else {	/* AML_INT_NAMEPATH_OP */
 
@@ -429,7 +427,7 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 			}
 			break;
 
-		case AML_INDEX_OP:
+		case ACPI_REFCLASS_INDEX:
 
 			/* Get the type of this reference (index into another object) */
 
@@ -455,22 +453,22 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 			}
 			break;
 
-		case AML_LOAD_OP:
+		case ACPI_REFCLASS_TABLE:
 
 			type = ACPI_TYPE_DDB_HANDLE;
 			goto exit;
 
-		case AML_LOCAL_OP:
-		case AML_ARG_OP:
+		case ACPI_REFCLASS_LOCAL:
+		case ACPI_REFCLASS_ARG:
 
 			if (return_desc) {
 				status =
 				    acpi_ds_method_data_get_value(obj_desc->
 								  reference.
-								  opcode,
+								  class,
 								  obj_desc->
 								  reference.
-								  offset,
+								  value,
 								  walk_state,
 								  &obj_desc);
 				if (ACPI_FAILURE(status)) {
@@ -481,10 +479,10 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 				status =
 				    acpi_ds_method_data_get_node(obj_desc->
 								 reference.
-								 opcode,
+								 class,
 								 obj_desc->
 								 reference.
-								 offset,
+								 value,
 								 walk_state,
 								 &node);
 				if (ACPI_FAILURE(status)) {
@@ -499,7 +497,7 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 			}
 			break;
 
-		case AML_DEBUG_OP:
+		case ACPI_REFCLASS_DEBUG:
 
 			/* The Debug Object is of type "DebugObject" */
 
@@ -509,8 +507,8 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unknown Reference subtype %X",
-				    obj_desc->reference.opcode));
+				    "Unknown Reference Class %2.2X",
+				    obj_desc->reference.class));
 			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
 	}
diff --git a/drivers/acpi/executer/exresop.c b/drivers/acpi/executer/exresop.c
index 54085f1..0bb8259 100644
--- a/drivers/acpi/executer/exresop.c
+++ b/drivers/acpi/executer/exresop.c
@@ -225,41 +225,36 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			if (object_type == (u8) ACPI_TYPE_LOCAL_REFERENCE) {
 
-				/* Decode the Reference */
+				/* Validate the Reference */
 
-				op_info = acpi_ps_get_opcode_info(opcode);
-				if (op_info->class == AML_CLASS_UNKNOWN) {
-					return_ACPI_STATUS(AE_AML_BAD_OPCODE);
-				}
+				switch (obj_desc->reference.class) {
+				case ACPI_REFCLASS_DEBUG:
 
-				switch (obj_desc->reference.opcode) {
-				case AML_DEBUG_OP:
 					target_op = AML_DEBUG_OP;
 
 					/*lint -fallthrough */
 
-				case AML_INDEX_OP:
-				case AML_REF_OF_OP:
-				case AML_ARG_OP:
-				case AML_LOCAL_OP:
-				case AML_LOAD_OP:	/* ddb_handle from LOAD_OP or LOAD_TABLE_OP */
-				case AML_INT_NAMEPATH_OP:	/* Reference to a named object */
-
-					ACPI_DEBUG_ONLY_MEMBERS(ACPI_DEBUG_PRINT
-								((ACPI_DB_EXEC,
-								  "Operand is a Reference, RefOpcode [%s]\n",
-								  (acpi_ps_get_opcode_info
-								   (obj_desc->
-								    reference.
-								    opcode))->
-								  name)));
+				case ACPI_REFCLASS_ARG:
+				case ACPI_REFCLASS_LOCAL:
+				case ACPI_REFCLASS_INDEX:
+				case ACPI_REFCLASS_REFOF:
+				case ACPI_REFCLASS_TABLE:	/* ddb_handle from LOAD_OP or LOAD_TABLE_OP */
+				case ACPI_REFCLASS_NAME:	/* Reference to a named object */
+
+					ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+							  "Operand is a Reference, Class [%s] %2.2X\n",
+							  acpi_ut_get_reference_name
+							  (obj_desc),
+							  obj_desc->reference.
+							  class));
 					break;
 
 				default:
+
 					ACPI_ERROR((AE_INFO,
-						    "Operand is a Reference, Unknown Reference Opcode: %X",
-						    obj_desc->reference.
-						    opcode));
+						    "Unknown Reference Class %2.2X in %p",
+						    obj_desc->reference.class,
+						    obj_desc));
 
 					return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 				}
@@ -270,8 +265,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* Invalid descriptor */
 
-			ACPI_ERROR((AE_INFO,
-				    "Invalid descriptor %p [%s]",
+			ACPI_ERROR((AE_INFO, "Invalid descriptor %p [%s]",
 				    obj_desc,
 				    acpi_ut_get_descriptor_name(obj_desc)));
 
@@ -343,7 +337,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			if ((opcode == AML_STORE_OP) &&
 			    (ACPI_GET_OBJECT_TYPE(*stack_ptr) ==
 			     ACPI_TYPE_LOCAL_REFERENCE)
-			    && ((*stack_ptr)->reference.opcode == AML_INDEX_OP)) {
+			    && ((*stack_ptr)->reference.class == ACPI_REFCLASS_INDEX)) {
 				goto next_operand;
 			}
 			break;
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 20b4893..3318df4 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -47,7 +47,6 @@
 #include <acpi/acinterp.h>
 #include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exstore")
@@ -179,23 +178,27 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		if (source_desc->reference.opcode == AML_INDEX_OP) {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      "[%s, 0x%X]\n",
-					      acpi_ps_get_opcode_name
-					      (source_desc->reference.opcode),
-					      source_desc->reference.offset));
-		} else {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[%s]",
-					      acpi_ps_get_opcode_name
-					      (source_desc->reference.opcode)));
-		}
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[%s] ",
+				      acpi_ut_get_reference_name(source_desc)));
+
+		/* Decode the reference */
+
+		switch (source_desc->reference.class) {
+		case ACPI_REFCLASS_INDEX:
+
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "0x%X\n",
+					      source_desc->reference.value));
+			break;
+
+		case ACPI_REFCLASS_TABLE:
 
-		if (source_desc->reference.opcode == AML_LOAD_OP) {	/* Load and load_table */
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      " Table Index %X\n",
+					      "Table Index 0x%X\n",
 					      source_desc->reference.value));
 			break;
+
+		default:
+			break;
 		}
 
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "  "));
@@ -347,15 +350,15 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 	}
 
 	/*
-	 * Examine the Reference opcode.  These cases are handled:
+	 * Examine the Reference class. These cases are handled:
 	 *
 	 * 1) Store to Name (Change the object associated with a name)
 	 * 2) Store to an indexed area of a Buffer or Package
 	 * 3) Store to a Method Local or Arg
 	 * 4) Store to the debug object
 	 */
-	switch (ref_desc->reference.opcode) {
-	case AML_REF_OF_OP:
+	switch (ref_desc->reference.class) {
+	case ACPI_REFCLASS_REFOF:
 
 		/* Storing an object into a Name "container" */
 
@@ -365,7 +368,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 						      ACPI_IMPLICIT_CONVERSION);
 		break;
 
-	case AML_INDEX_OP:
+	case ACPI_REFCLASS_INDEX:
 
 		/* Storing to an Index (pointer into a packager or buffer) */
 
@@ -374,18 +377,18 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 						  walk_state);
 		break;
 
-	case AML_LOCAL_OP:
-	case AML_ARG_OP:
+	case ACPI_REFCLASS_LOCAL:
+	case ACPI_REFCLASS_ARG:
 
 		/* Store to a method local/arg  */
 
 		status =
-		    acpi_ds_store_object_to_local(ref_desc->reference.opcode,
-						  ref_desc->reference.offset,
+		    acpi_ds_store_object_to_local(ref_desc->reference.class,
+						  ref_desc->reference.value,
 						  source_desc, walk_state);
 		break;
 
-	case AML_DEBUG_OP:
+	case ACPI_REFCLASS_DEBUG:
 
 		/*
 		 * Storing to the Debug object causes the value stored to be
@@ -401,8 +404,8 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown Reference opcode %X",
-			    ref_desc->reference.opcode));
+		ACPI_ERROR((AE_INFO, "Unknown Reference Class %2.2X",
+			    ref_desc->reference.class));
 		ACPI_DUMP_ENTRY(ref_desc, ACPI_LV_INFO);
 
 		status = AE_AML_INTERNAL;
@@ -458,7 +461,7 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 
 		if (ACPI_GET_OBJECT_TYPE(source_desc) ==
 		    ACPI_TYPE_LOCAL_REFERENCE
-		    && source_desc->reference.opcode == AML_LOAD_OP) {
+		    && source_desc->reference.class == ACPI_REFCLASS_TABLE) {
 
 			/* This is a DDBHandle, just add a reference to it */
 
@@ -553,7 +556,7 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 
 		/* Store the source value into the target buffer byte */
 
-		obj_desc->buffer.pointer[index_desc->reference.offset] = value;
+		obj_desc->buffer.pointer[index_desc->reference.value] = value;
 		break;
 
 	default:
diff --git a/drivers/acpi/executer/exstoren.c b/drivers/acpi/executer/exstoren.c
index a6d2168..eef61a0 100644
--- a/drivers/acpi/executer/exstoren.c
+++ b/drivers/acpi/executer/exstoren.c
@@ -121,7 +121,8 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 		    (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_STRING) &&
 		    !((ACPI_GET_OBJECT_TYPE(source_desc) ==
 		       ACPI_TYPE_LOCAL_REFERENCE)
-		      && (source_desc->reference.opcode == AML_LOAD_OP))) {
+		      && (source_desc->reference.class ==
+			  ACPI_REFCLASS_TABLE))) {
 
 			/* Conversion successful but still not a valid type */
 
diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/namespace/nsdump.c
index 0ab2200..cc0ae39 100644
--- a/drivers/acpi/namespace/nsdump.c
+++ b/drivers/acpi/namespace/nsdump.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsdump")
@@ -334,9 +333,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		case ACPI_TYPE_LOCAL_REFERENCE:
 
 			acpi_os_printf("[%s]\n",
-				       acpi_ps_get_opcode_name(obj_desc->
-							       reference.
-							       opcode));
+				       acpi_ut_get_reference_name(obj_desc));
 			break;
 
 		case ACPI_TYPE_BUFFER_FIELD:
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index f3cc376..a085cc3 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -45,7 +45,6 @@
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
@@ -399,13 +398,13 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
 	 * (AML_LOAD_OP) cannot be dereferenced, nor can it be converted to
 	 * an union acpi_object.
 	 */
-	switch (info->return_object->reference.opcode) {
-	case AML_INDEX_OP:
+	switch (info->return_object->reference.class) {
+	case ACPI_REFCLASS_INDEX:
 
 		obj_desc = *(info->return_object->reference.where);
 		break;
 
-	case AML_REF_OF_OP:
+	case ACPI_REFCLASS_REFOF:
 
 		node = info->return_object->reference.object;
 		if (node) {
diff --git a/drivers/acpi/resources/rscalc.c b/drivers/acpi/resources/rscalc.c
index d9063ea..8eaaecf 100644
--- a/drivers/acpi/resources/rscalc.c
+++ b/drivers/acpi/resources/rscalc.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acresrc.h>
-#include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
 
 #define _COMPONENT          ACPI_RESOURCES
@@ -560,8 +559,8 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 			      ACPI_GET_OBJECT_TYPE(*sub_object_list)) ||
 			     ((ACPI_TYPE_LOCAL_REFERENCE ==
 			       ACPI_GET_OBJECT_TYPE(*sub_object_list)) &&
-			      ((*sub_object_list)->reference.opcode ==
-			       AML_INT_NAMEPATH_OP)))) {
+			      ((*sub_object_list)->reference.class ==
+			       ACPI_REFCLASS_NAME)))) {
 				name_found = TRUE;
 			} else {
 				/* Look at the next element */
diff --git a/drivers/acpi/resources/rscreate.c b/drivers/acpi/resources/rscreate.c
index 7804a8c..c0bbfa2 100644
--- a/drivers/acpi/resources/rscreate.c
+++ b/drivers/acpi/resources/rscreate.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acresrc.h>
-#include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
 
 #define _COMPONENT          ACPI_RESOURCES
@@ -310,13 +309,12 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 			case ACPI_TYPE_LOCAL_REFERENCE:
 
-				if (obj_desc->reference.opcode !=
-				    AML_INT_NAMEPATH_OP) {
+				if (obj_desc->reference.class !=
+				    ACPI_REFCLASS_NAME) {
 					ACPI_ERROR((AE_INFO,
-						    "(PRT[%X].Source) Need name, found reference op %X",
+						    "(PRT[%X].Source) Need name, found Reference Class %X",
 						    index,
-						    obj_desc->reference.
-						    opcode));
+						    obj_desc->reference.class));
 					return_ACPI_STATUS(AE_BAD_DATA);
 				}
 
diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 53499ac..5b2f7c2 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -42,7 +42,6 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
 
 
@@ -176,20 +175,24 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 
 		/* This is an object reference. */
 
-		switch (internal_object->reference.opcode) {
-		case AML_INT_NAMEPATH_OP:
-
-			/* For namepath, return the object handle ("reference") */
-
-		default:
-
-			/* We are referring to the namespace node */
+		switch (internal_object->reference.class) {
+		case ACPI_REFCLASS_NAME:
 
+			/*
+			 * For namepath, return the object handle ("reference")
+			 * We are referring to the namespace node
+			 */
 			external_object->reference.handle =
 			    internal_object->reference.node;
 			external_object->reference.actual_type =
 			    acpi_ns_get_type(internal_object->reference.node);
 			break;
+
+		default:
+
+			/* All other reference types are unsupported */
+
+			return_ACPI_STATUS(AE_TYPE);
 		}
 		break;
 
@@ -533,7 +536,7 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 
 		/* TBD: should validate incoming handle */
 
-		internal_object->reference.opcode = AML_INT_NAMEPATH_OP;
+		internal_object->reference.class = ACPI_REFCLASS_NAME;
 		internal_object->reference.node =
 		    external_object->reference.handle;
 		break;
@@ -743,11 +746,11 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 		 * We copied the reference object, so we now must add a reference
 		 * to the object pointed to by the reference
 		 *
-		 * DDBHandle reference (from Load/load_table is a special reference,
-		 * it's Reference.Object is the table index, so does not need to
+		 * DDBHandle reference (from Load/load_table) is a special reference,
+		 * it does not have a Reference.Object, so does not need to
 		 * increase the reference count
 		 */
-		if (source_desc->reference.opcode == AML_LOAD_OP) {
+		if (source_desc->reference.class == ACPI_REFCLASS_TABLE) {
 			break;
 		}
 
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index 42609d3..5c21975 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -45,7 +45,6 @@
 #include <acpi/acinterp.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acevents.h>
-#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utdelete")
@@ -548,8 +547,8 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 			 * reference must track changes to the ref count of the index or
 			 * target object.
 			 */
-			if ((object->reference.opcode == AML_INDEX_OP) ||
-			    (object->reference.opcode == AML_INT_NAMEPATH_OP)) {
+			if ((object->reference.class == ACPI_REFCLASS_INDEX) ||
+			    (object->reference.class == ACPI_REFCLASS_NAME)) {
 				next_object = object->reference.object;
 			}
 			break;
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index bcace57..0b1e493 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -45,7 +45,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
-#include <acpi/amlcode.h>
 
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 #define _COMPONENT          ACPI_UTILITIES
@@ -590,25 +589,31 @@ char *acpi_ut_get_descriptor_name(void *object)
 
 /* Printable names of reference object sub-types */
 
+static const char *acpi_gbl_ref_class_names[] = {
+	/* 00 */ "Local",
+	/* 01 */ "Argument",
+	/* 02 */ "RefOf",
+	/* 03 */ "Index",
+	/* 04 */ "DdbHandle",
+	/* 05 */ "Named Object",
+	/* 06 */ "Debug"
+};
+
 const char *acpi_ut_get_reference_name(union acpi_operand_object *object)
 {
+	if (!object)
+		return "NULL Object";
 
-	switch (object->reference.opcode) {
-	case AML_INT_NAMEPATH_OP:
-		return "Name";
+	if (ACPI_GET_DESCRIPTOR_TYPE(object) != ACPI_DESC_TYPE_OPERAND)
+		return "Not an Operand object";
 
-	case AML_LOAD_OP:
-		return "DDB-Handle";
+	if (object->common.type != ACPI_TYPE_LOCAL_REFERENCE)
+		return "Not a Reference object";
 
-	case AML_REF_OF_OP:
-		return "RefOf";
+	if (object->reference.class > ACPI_REFCLASS_MAX)
+		return "Unknown Reference class";
 
-	case AML_INDEX_OP:
-		return "Index";
-
-	default:
-		return "Unknown";
-	}
+	return acpi_gbl_ref_class_names[object->reference.class];
 }
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
@@ -812,4 +817,4 @@ acpi_status acpi_ut_init_globals(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
-    ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index 924d05a..c354e7a 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
-#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utobject")
@@ -478,8 +477,8 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		switch (internal_object->reference.opcode) {
-		case AML_INT_NAMEPATH_OP:
+		switch (internal_object->reference.class) {
+		case ACPI_REFCLASS_NAME:
 
 			/*
 			 * Get the actual length of the full pathname to this object.
@@ -504,9 +503,9 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 			 */
 			ACPI_ERROR((AE_INFO,
 				    "Cannot convert to external object - "
-				    "unsupported Reference type [%s] %X in object %p",
+				    "unsupported Reference Class [%s] %X in object %p",
 				    acpi_ut_get_reference_name(internal_object),
-				    internal_object->reference.opcode,
+				    internal_object->reference.class,
 				    internal_object));
 			status = AE_TYPE;
 			break;
diff --git a/include/acpi/acdebug.h b/include/acpi/acdebug.h
index c5a1b50..a4fb001 100644
--- a/include/acpi/acdebug.h
+++ b/include/acpi/acdebug.h
@@ -123,6 +123,10 @@ void acpi_db_check_integrity(void);
 
 void acpi_db_generate_gpe(char *gpe_arg, char *block_arg);
 
+void acpi_db_check_predefined_names(void);
+
+void acpi_db_batch_execute(void);
+
 /*
  * dbdisply - debug display commands
  */
diff --git a/include/acpi/acdispat.h b/include/acpi/acdispat.h
index 21a73a1..6291904 100644
--- a/include/acpi/acdispat.h
+++ b/include/acpi/acdispat.h
@@ -157,7 +157,7 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number);
  * dsmthdat - method data (locals/args)
  */
 acpi_status
-acpi_ds_store_object_to_local(u16 opcode,
+acpi_ds_store_object_to_local(u8 type,
 			      u32 index,
 			      union acpi_operand_object *src_desc,
 			      struct acpi_walk_state *walk_state);
@@ -173,7 +173,7 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state);
 u8 acpi_ds_is_method_value(union acpi_operand_object *obj_desc);
 
 acpi_status
-acpi_ds_method_data_get_value(u16 opcode,
+acpi_ds_method_data_get_value(u8 type,
 			      u32 index,
 			      struct acpi_walk_state *walk_state,
 			      union acpi_operand_object **dest_desc);
@@ -184,7 +184,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 			      struct acpi_walk_state *walk_state);
 
 acpi_status
-acpi_ds_method_data_get_node(u16 opcode,
+acpi_ds_method_data_get_node(u8 type,
 			     u32 index,
 			     struct acpi_walk_state *walk_state,
 			     struct acpi_namespace_node **node);
diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index 7a8a652..eb6f038 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -308,19 +308,34 @@ struct acpi_object_addr_handler {
  *****************************************************************************/
 
 /*
- * The Reference object type is used for these opcodes:
- * Arg[0-6], Local[0-7], index_op, name_op, zero_op, one_op, ones_op, debug_op
+ * The Reference object is used for these opcodes:
+ * Arg[0-6], Local[0-7], index_op, name_op, ref_of_op, load_op, load_table_op, debug_op
+ * The Reference.Class differentiates these types.
  */
 struct acpi_object_reference {
-	ACPI_OBJECT_COMMON_HEADER u8 target_type;	/* Used for index_op */
-	u16 opcode;
+	ACPI_OBJECT_COMMON_HEADER u8 class;	/* Reference Class */
+	u8 target_type;		/* Used for Index Op */
+	u8 reserved;
 	void *object;		/* name_op=>HANDLE to obj, index_op=>union acpi_operand_object */
-	struct acpi_namespace_node *node;
-	union acpi_operand_object **where;
-	u32 offset;		/* Used for arg_op, local_op, and index_op */
-	u32 value;		/* Used for ddb_handle */
+	struct acpi_namespace_node *node;	/* ref_of or Namepath */
+	union acpi_operand_object **where;	/* Target of Index */
+	u32 value;		/* Used for Local/Arg/Index/ddb_handle */
 };
 
+/* Values for Reference.Class above */
+
+typedef enum {
+	ACPI_REFCLASS_LOCAL = 0,	/* Method local */
+	ACPI_REFCLASS_ARG = 1,	/* Method argument */
+	ACPI_REFCLASS_REFOF = 2,	/* Result of ref_of() TBD: Split to Ref/Node and Ref/operand_obj? */
+	ACPI_REFCLASS_INDEX = 3,	/* Result of Index() */
+	ACPI_REFCLASS_TABLE = 4,	/* ddb_handle - Load(), load_table() */
+	ACPI_REFCLASS_NAME = 5,	/* Reference to a named object */
+	ACPI_REFCLASS_DEBUG = 6,	/* Debug object */
+
+	ACPI_REFCLASS_MAX = 6
+} ACPI_REFERENCE_CLASSES;
+
 /*
  * Extra object is used as additional storage for types that
  * have AML code in their declarations (term_args) that must be
-- 
1.5.5.1

