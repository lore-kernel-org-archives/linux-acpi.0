From: Len Brown <lenb@kernel.org>
Subject: [PATCH 104/122] ACPICA: Update for Reference ACPI_OPERAND_OBJECT
Date: Thu, 23 Oct 2008 02:39:18 -0400
Message-ID: <57e664cfd968ec8e4b0bfd80a5e8f903307e598b.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbYJWGoO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:14 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:11 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

1) Add new field for use by DdbHandle (Value)
2) Use ACPI_CAST_INDIRECT_PTR to eliminate strict type warnings
3) Cleanup debug output

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   16 ++++++++++------
 drivers/acpi/executer/exconfig.c   |    6 +++---
 drivers/acpi/executer/exdump.c     |   29 ++++++++++++++---------------
 drivers/acpi/executer/exstore.c    |    4 ++--
 include/acpi/acobject.h            |    1 +
 5 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 0f28058..09af39f 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -741,10 +741,12 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 							      obj_desc->
 							      reference.offset,
 							      walk_state,
+							      ACPI_CAST_INDIRECT_PTR
 							      (struct
-							       acpi_namespace_node
-							       **)&obj_desc->
-							      reference.object);
+							       acpi_namespace_node,
+							       &obj_desc->
+							       reference.
+							       object));
 #endif
 			break;
 
@@ -760,10 +762,12 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 							      obj_desc->
 							      reference.offset,
 							      walk_state,
+							      ACPI_CAST_INDIRECT_PTR
 							      (struct
-							       acpi_namespace_node
-							       **)&obj_desc->
-							      reference.object);
+							       acpi_namespace_node,
+							       &obj_desc->
+							       reference.
+							       object));
 #endif
 			break;
 
diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 4c512c2..5f2b1eb 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -96,7 +96,7 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Install the new table into the local data structures */
 
-	obj_desc->reference.object = ACPI_TO_POINTER(table_index);
+	obj_desc->reference.value = table_index;
 
 	/* Add the table to the namespace */
 
@@ -505,9 +505,9 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the table index from the ddb_handle (acpi_size for 64-bit case) */
+	/* Get the table index from the ddb_handle */
 
-	table_index = (u32) (acpi_size) table_desc->reference.object;
+	table_index = table_desc->reference.value;
 
 	/* Invoke table handler if present */
 
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 2be2e2b..7d41232 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -214,10 +214,11 @@ static struct acpi_exdump_info acpi_ex_dump_index_field[5] = {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(index_field.data_obj), "Data Object"}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_reference[7] = {
+static struct acpi_exdump_info acpi_ex_dump_reference[8] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_reference), NULL},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(reference.target_type), "Target Type"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(reference.offset), "Offset"},
+	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(reference.value), "Value"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.object), "Object Desc"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.node), "Node"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.where), "Where"},
@@ -497,24 +498,24 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 		switch (obj_desc->reference.opcode) {
 		case AML_DEBUG_OP:
 
-			acpi_os_printf("Reference: Debug\n");
+			acpi_os_printf("Reference: [Debug]\n");
 			break;
 
 		case AML_INDEX_OP:
 
-			acpi_os_printf("Reference: Index %p\n",
+			acpi_os_printf("Reference: [Index] %p\n",
 				       obj_desc->reference.object);
 			break;
 
 		case AML_LOAD_OP:
 
-			acpi_os_printf("Reference: [DdbHandle] TableIndex %p\n",
-				       obj_desc->reference.object);
+			acpi_os_printf("Reference: [DdbHandle] TableIndex %X\n",
+				       obj_desc->reference.value);
 			break;
 
 		case AML_REF_OF_OP:
 
-			acpi_os_printf("Reference: (RefOf) %p [%s]\n",
+			acpi_os_printf("Reference: [RefOf] %p [%s]\n",
 				       obj_desc->reference.object,
 				       acpi_ut_get_type_name(((union
 							       acpi_operand_object
@@ -526,7 +527,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		case AML_ARG_OP:
 
-			acpi_os_printf("Reference: Arg%d",
+			acpi_os_printf("Reference: [Arg%d]",
 				       obj_desc->reference.offset);
 
 			if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
@@ -544,7 +545,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		case AML_LOCAL_OP:
 
-			acpi_os_printf("Reference: Local%d",
+			acpi_os_printf("Reference: [Local%d]",
 				       obj_desc->reference.offset);
 
 			if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
@@ -562,7 +563,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		case AML_INT_NAMEPATH_OP:
 
-			acpi_os_printf("Reference: Namepath %X [%4.4s]\n",
+			acpi_os_printf("Reference: [Namepath] %X [%4.4s]\n",
 				       obj_desc->reference.node->name.integer,
 				       obj_desc->reference.node->name.ascii);
 			break;
@@ -883,13 +884,11 @@ static void acpi_ex_dump_reference_obj(union acpi_operand_object *obj_desc)
 			acpi_os_printf(" Target: %p",
 				       obj_desc->reference.object);
 			if (obj_desc->reference.opcode == AML_LOAD_OP) {
-				/*
-				 * For DDBHandle reference,
-				 * obj_desc->Reference.Object is the table index
-				 */
-				acpi_os_printf(" [DDBHandle]\n");
+				acpi_os_printf(" [DDBHandle] Table Index: %X\n",
+					       obj_desc->reference.value);
 			} else {
-				acpi_os_printf(" [%s]\n",
+				acpi_os_printf(" Target: %p [%s]\n",
+					       obj_desc->reference.object,
 					       acpi_ut_get_type_name(((union
 								       acpi_operand_object
 								       *)
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 09e9684..20b4893 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -193,8 +193,8 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 		if (source_desc->reference.opcode == AML_LOAD_OP) {	/* Load and load_table */
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      " Table OwnerId %p\n",
-					      source_desc->reference.object));
+					      " Table Index %X\n",
+					      source_desc->reference.value));
 			break;
 		}
 
diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index 0ca3926..7a8a652 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -318,6 +318,7 @@ struct acpi_object_reference {
 	struct acpi_namespace_node *node;
 	union acpi_operand_object **where;
 	u32 offset;		/* Used for arg_op, local_op, and index_op */
+	u32 value;		/* Used for ddb_handle */
 };
 
 /*
-- 
1.5.5.1

