From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/70] ACPICA: Cleanup debug operand dump mechanism
Date: Fri, 20 Jun 2008 03:43:29 -0400
Message-ID: <37a97e8b804f4de52fcdf30dc20d60261da4bf5b.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62806 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbYFTHoz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:55 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00AKF4698DE2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:34 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Eliminated unnecessary operands; eliminated use of negative index
in loop.  Operands now displayed in correct order, not backwards.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |   20 +---------
 drivers/acpi/dispatcher/dswexec.c  |    8 ----
 drivers/acpi/executer/exdump.c     |   68 ++++++++++++++----------------------
 drivers/acpi/executer/exresop.c    |    4 ++
 drivers/acpi/executer/exstore.c    |    6 ---
 drivers/acpi/namespace/nsdump.c    |    4 +-
 include/acpi/acinterp.h            |    6 +---
 include/acpi/acmacros.h            |    4 +-
 8 files changed, 37 insertions(+), 83 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index ac0bfb1..6a81c44 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -691,12 +691,6 @@ acpi_ds_eval_buffer_field_operands(struct acpi_walk_state *walk_state,
 
 	status = acpi_ex_resolve_operands(op->common.aml_opcode,
 					  ACPI_WALK_OPERANDS, walk_state);
-
-	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS, ACPI_IMODE_EXECUTE,
-			   acpi_ps_get_opcode_name(op->common.aml_opcode),
-			   walk_state->num_operands,
-			   "after AcpiExResolveOperands");
-
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "(%s) bad operand(s) (%X)",
 			    acpi_ps_get_opcode_name(op->common.aml_opcode),
@@ -785,10 +779,6 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(status);
 	}
 
-	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS, ACPI_IMODE_EXECUTE,
-			   acpi_ps_get_opcode_name(op->common.aml_opcode),
-			   1, "after AcpiExResolveOperands");
-
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (!obj_desc) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
@@ -882,10 +872,6 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(status);
 	}
 
-	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS, ACPI_IMODE_EXECUTE,
-			   acpi_ps_get_opcode_name(op->common.aml_opcode),
-			   1, "after AcpiExResolveOperands");
-
 	operand = &walk_state->operands[0];
 
 	/* Find the ACPI table */
@@ -1091,10 +1077,8 @@ acpi_ds_eval_bank_field_operands(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(status);
 	}
 
-	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS, ACPI_IMODE_EXECUTE,
-			   acpi_ps_get_opcode_name(op->common.aml_opcode),
-			   1, "after AcpiExResolveOperands");
-
+	ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS,
+			   acpi_ps_get_opcode_name(op->common.aml_opcode), 1);
 	/*
 	 * Get the bank_value operand and save it
 	 * (at Top of stack)
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index b246b96..b5072fa 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -408,14 +408,6 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 							    [walk_state->
 							     num_operands - 1]),
 							  walk_state);
-			if (ACPI_SUCCESS(status)) {
-				ACPI_DUMP_OPERANDS(ACPI_WALK_OPERANDS,
-						   ACPI_IMODE_EXECUTE,
-						   acpi_ps_get_opcode_name
-						   (walk_state->opcode),
-						   walk_state->num_operands,
-						   "after ExResolveOperands");
-			}
 		}
 
 		if (ACPI_SUCCESS(status)) {
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index f337c3f..3d10604 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -580,25 +580,22 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 	case ACPI_TYPE_BUFFER:
 
-		acpi_os_printf("Buffer len %X @ %p\n",
+		acpi_os_printf("Buffer length %.2X @ %p\n",
 			       obj_desc->buffer.length,
 			       obj_desc->buffer.pointer);
 
-		length = obj_desc->buffer.length;
-		if (length > 64) {
-			length = 64;
-		}
-
 		/* Debug only -- dump the buffer contents */
 
 		if (obj_desc->buffer.pointer) {
-			acpi_os_printf("Buffer Contents: ");
-
-			for (index = 0; index < length; index++) {
-				acpi_os_printf(" %02x",
-					       obj_desc->buffer.pointer[index]);
+			length = obj_desc->buffer.length;
+			if (length > 128) {
+				length = 128;
 			}
-			acpi_os_printf("\n");
+
+			acpi_os_printf
+			    ("Buffer Contents: (displaying length 0x%.2X)\n",
+			     length);
+			ACPI_DUMP_BUFFER(obj_desc->buffer.pointer, length);
 		}
 		break;
 
@@ -756,55 +753,42 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
  *
  * FUNCTION:    acpi_ex_dump_operands
  *
- * PARAMETERS:  Operands            - Operand list
- *              interpreter_mode    - Load or Exec
- *              Ident               - Identification
- *              num_levels          - # of stack entries to dump above line
- *              Note                - Output notation
- *              module_name         - Caller's module name
- *              line_number         - Caller's invocation line number
+ * PARAMETERS:  Operands            - A list of Operand objects
+ *              opcode_name         - AML opcode name
+ *              num_operands        - Operand count for this opcode
  *
- * DESCRIPTION: Dump the object stack
+ * DESCRIPTION: Dump the operands associated with the opcode
  *
  ******************************************************************************/
 
 void
 acpi_ex_dump_operands(union acpi_operand_object **operands,
-		      acpi_interpreter_mode interpreter_mode,
-		      const char *ident,
-		      u32 num_levels,
-		      const char *note,
-		      const char *module_name, u32 line_number)
+		      const char *opcode_name, u32 num_operands)
 {
-	s32 i;
-
 	ACPI_FUNCTION_NAME(ex_dump_operands);
 
-	if (!ident) {
-		ident = "?";
-	}
-
-	if (!note) {
-		note = "?";
+	if (!opcode_name) {
+		opcode_name = "UNKNOWN";
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "************* Operand Stack Contents (Opcode [%s], %d Operands)\n",
-			  ident, num_levels));
+			  "**** Start operand dump for opcode [%s], %d operands\n",
+			  opcode_name, num_operands));
 
-	if (num_levels == 0) {
-		num_levels = 1;
+	if (num_operands == 0) {
+		num_operands = 1;
 	}
 
-	/* Dump the operand stack starting at the top */
+	/* Dump the individual operands */
 
-	for (i = 0; num_levels > 0; i--, num_levels--) {
-		acpi_ex_dump_operand(operands[i], 0);
+	while (num_operands) {
+		acpi_ex_dump_operand(*operands, 0);
+		operands++;
+		num_operands--;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "************* Operand Stack dump from %s(%d), %s\n",
-			  module_name, line_number, note));
+			  "**** End operand dump for [%s]\n", opcode_name));
 	return;
 }
 
diff --git a/drivers/acpi/executer/exresop.c b/drivers/acpi/executer/exresop.c
index 73e29e5..54085f1 100644
--- a/drivers/acpi/executer/exresop.c
+++ b/drivers/acpi/executer/exresop.c
@@ -698,5 +698,9 @@ acpi_ex_resolve_operands(u16 opcode,
 		}
 	}
 
+	ACPI_DUMP_OPERANDS(walk_state->operands,
+			   acpi_ps_get_opcode_name(opcode),
+			   walk_state->num_operands);
+
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 76c875b..38b55e3 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -343,12 +343,6 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 			    acpi_ut_get_object_type_name(dest_desc),
 			    dest_desc));
 
-		ACPI_DUMP_STACK_ENTRY(source_desc);
-		ACPI_DUMP_STACK_ENTRY(dest_desc);
-		ACPI_DUMP_OPERANDS(&dest_desc, ACPI_IMODE_EXECUTE, "ExStore",
-				   2,
-				   "Target is not a Reference or Constant object");
-
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/namespace/nsdump.c
index 904f951..0ab2200 100644
--- a/drivers/acpi/namespace/nsdump.c
+++ b/drivers/acpi/namespace/nsdump.c
@@ -515,12 +515,12 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 
 			if (obj_type > ACPI_TYPE_LOCAL_MAX) {
 				acpi_os_printf
-				    ("(Ptr to ACPI Object type %X [UNKNOWN])\n",
+				    ("(Pointer to ACPI Object type %.2X [UNKNOWN])\n",
 				     obj_type);
 				bytes_to_dump = 32;
 			} else {
 				acpi_os_printf
-				    ("(Ptr to ACPI Object type %X [%s])\n",
+				    ("(Pointer to ACPI Object type %.2X [%s])\n",
 				     obj_type, acpi_ut_get_type_name(obj_type));
 				bytes_to_dump =
 				    sizeof(union acpi_operand_object);
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index accd120..e8db7a3 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -366,11 +366,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth);
 
 void
 acpi_ex_dump_operands(union acpi_operand_object **operands,
-		      acpi_interpreter_mode interpreter_mode,
-		      const char *ident,
-		      u32 num_levels,
-		      const char *note,
-		      const char *module_name, u32 line_number);
+		      const char *opcode_name, u32 num_opcodes);
 
 #ifdef	ACPI_FUTURE_USAGE
 void
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index fcdf709..6d18cd9 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -597,7 +597,7 @@ struct acpi_integer_overlay {
 /* Stack and buffer dumping */
 
 #define ACPI_DUMP_STACK_ENTRY(a)        acpi_ex_dump_operand((a),0)
-#define ACPI_DUMP_OPERANDS(a,b,c,d,e)   acpi_ex_dump_operands(a,b,c,d,e,_acpi_module_name,__LINE__)
+#define ACPI_DUMP_OPERANDS(a,b,c)       acpi_ex_dump_operands(a,b,c)
 
 #define ACPI_DUMP_ENTRY(a,b)            acpi_ns_dump_entry (a,b)
 #define ACPI_DUMP_PATHNAME(a,b,c,d)     acpi_ns_dump_pathname(a,b,c,d)
@@ -633,7 +633,7 @@ struct acpi_integer_overlay {
 #define ACPI_FUNCTION_VALUE_EXIT(s)	do { } while(0)
 #define ACPI_FUNCTION_ENTRY()		do { } while(0)
 #define ACPI_DUMP_STACK_ENTRY(a)	do { } while(0)
-#define ACPI_DUMP_OPERANDS(a,b,c,d,e)	do { } while(0)
+#define ACPI_DUMP_OPERANDS(a,b,c)      do { } while(0)
 #define ACPI_DUMP_ENTRY(a,b)		do { } while(0)
 #define ACPI_DUMP_TABLES(a,b)		do { } while(0)
 #define ACPI_DUMP_PATHNAME(a,b,c,d)	do { } while(0)
-- 
1.5.6

