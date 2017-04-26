From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/15] ACPICA: Cleanup AML opcode definitions, no functional change
Date: Wed, 26 Apr 2017 16:18:40 +0800
Message-ID: <ba1974e69c93d81722df41901e2013e2d3753313.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13671 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952816AbdDZISp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:45 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ec969d38fef3be95358e65f0dd071b5f2c045b6b

This change is a cleanup and further standardization of the AML
opcode defines in amlcode.h

Improves the readability and maintainability of the source code.

Link: https://github.com/acpica/acpica/commit/ec969d38
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/amlcode.h   | 97 ++++++++++++++++++-----------------------
 drivers/acpi/acpica/dbxface.c   |  2 +-
 drivers/acpi/acpica/dscontrol.c |  2 +-
 drivers/acpi/acpica/dsmthdat.c  |  3 +-
 drivers/acpi/acpica/dsobject.c  | 15 ++++---
 drivers/acpi/acpica/dsopcode.c  |  4 +-
 drivers/acpi/acpica/dsutils.c   |  8 ++--
 drivers/acpi/acpica/dswexec.c   |  2 +-
 drivers/acpi/acpica/dswload2.c  |  2 +-
 drivers/acpi/acpica/exmisc.c    | 16 +++----
 drivers/acpi/acpica/exnames.c   |  4 +-
 drivers/acpi/acpica/exoparg1.c  | 17 ++++----
 drivers/acpi/acpica/exoparg2.c  |  4 +-
 drivers/acpi/acpica/exoparg6.c  | 16 +++----
 drivers/acpi/acpica/exresolv.c  |  3 +-
 drivers/acpi/acpica/exstore.c   |  5 ++-
 drivers/acpi/acpica/exstoren.c  |  2 +-
 drivers/acpi/acpica/nsaccess.c  |  2 +-
 drivers/acpi/acpica/nsutils.c   |  6 +--
 drivers/acpi/acpica/psargs.c    |  6 +--
 drivers/acpi/acpica/psloop.c    |  2 +-
 drivers/acpi/acpica/psopcode.c  | 10 ++---
 drivers/acpi/acpica/psparse.c   |  6 +--
 drivers/acpi/acpica/pstree.c    |  2 +-
 24 files changed, 114 insertions(+), 122 deletions(-)

diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index b536fd4..7e2b369 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -48,11 +48,8 @@
 
 /* primary opcodes */
 
-#define AML_NULL_CHAR               (u16) 0x00
-
 #define AML_ZERO_OP                 (u16) 0x00
 #define AML_ONE_OP                  (u16) 0x01
-#define AML_UNASSIGNED              (u16) 0x02
 #define AML_ALIAS_OP                (u16) 0x06
 #define AML_NAME_OP                 (u16) 0x08
 #define AML_BYTE_OP                 (u16) 0x0a
@@ -63,17 +60,15 @@
 #define AML_SCOPE_OP                (u16) 0x10
 #define AML_BUFFER_OP               (u16) 0x11
 #define AML_PACKAGE_OP              (u16) 0x12
-#define AML_VAR_PACKAGE_OP          (u16) 0x13	/* ACPI 2.0 */
+#define AML_VARIABLE_PACKAGE_OP     (u16) 0x13	/* ACPI 2.0 */
 #define AML_METHOD_OP               (u16) 0x14
 #define AML_EXTERNAL_OP             (u16) 0x15	/* ACPI 6.0 */
 #define AML_DUAL_NAME_PREFIX        (u16) 0x2e
-#define AML_MULTI_NAME_PREFIX_OP    (u16) 0x2f
-#define AML_NAME_CHAR_SUBSEQ        (u16) 0x30
-#define AML_NAME_CHAR_FIRST         (u16) 0x41
-#define AML_EXTENDED_OP_PREFIX      (u16) 0x5b
+#define AML_MULTI_NAME_PREFIX       (u16) 0x2f
+#define AML_EXTENDED_PREFIX         (u16) 0x5b
 #define AML_ROOT_PREFIX             (u16) 0x5c
 #define AML_PARENT_PREFIX           (u16) 0x5e
-#define AML_LOCAL_OP                (u16) 0x60
+#define AML_FIRST_LOCAL_OP          (u16) 0x60	/* Used for Local op # calculations */
 #define AML_LOCAL0                  (u16) 0x60
 #define AML_LOCAL1                  (u16) 0x61
 #define AML_LOCAL2                  (u16) 0x62
@@ -82,7 +77,7 @@
 #define AML_LOCAL5                  (u16) 0x65
 #define AML_LOCAL6                  (u16) 0x66
 #define AML_LOCAL7                  (u16) 0x67
-#define AML_ARG_OP                  (u16) 0x68
+#define AML_FIRST_ARG_OP            (u16) 0x68	/* Used for Arg op # calculations */
 #define AML_ARG0                    (u16) 0x68
 #define AML_ARG1                    (u16) 0x69
 #define AML_ARG2                    (u16) 0x6a
@@ -93,7 +88,7 @@
 #define AML_STORE_OP                (u16) 0x70
 #define AML_REF_OF_OP               (u16) 0x71
 #define AML_ADD_OP                  (u16) 0x72
-#define AML_CONCAT_OP               (u16) 0x73
+#define AML_CONCATENATE_OP          (u16) 0x73
 #define AML_SUBTRACT_OP             (u16) 0x74
 #define AML_INCREMENT_OP            (u16) 0x75
 #define AML_DECREMENT_OP            (u16) 0x76
@@ -110,7 +105,7 @@
 #define AML_FIND_SET_LEFT_BIT_OP    (u16) 0x81
 #define AML_FIND_SET_RIGHT_BIT_OP   (u16) 0x82
 #define AML_DEREF_OF_OP             (u16) 0x83
-#define AML_CONCAT_RES_OP           (u16) 0x84	/* ACPI 2.0 */
+#define AML_CONCATENATE_TEMPLATE_OP (u16) 0x84	/* ACPI 2.0 */
 #define AML_MOD_OP                  (u16) 0x85	/* ACPI 2.0 */
 #define AML_NOTIFY_OP               (u16) 0x86
 #define AML_SIZE_OF_OP              (u16) 0x87
@@ -122,18 +117,18 @@
 #define AML_CREATE_BIT_FIELD_OP     (u16) 0x8d
 #define AML_OBJECT_TYPE_OP          (u16) 0x8e
 #define AML_CREATE_QWORD_FIELD_OP   (u16) 0x8f	/* ACPI 2.0 */
-#define AML_LAND_OP                 (u16) 0x90
-#define AML_LOR_OP                  (u16) 0x91
-#define AML_LNOT_OP                 (u16) 0x92
-#define AML_LEQUAL_OP               (u16) 0x93
-#define AML_LGREATER_OP             (u16) 0x94
-#define AML_LLESS_OP                (u16) 0x95
+#define AML_LOGICAL_AND_OP          (u16) 0x90
+#define AML_LOGICAL_OR_OP           (u16) 0x91
+#define AML_LOGICAL_NOT_OP          (u16) 0x92
+#define AML_LOGICAL_EQUAL_OP        (u16) 0x93
+#define AML_LOGICAL_GREATER_OP      (u16) 0x94
+#define AML_LOGICAL_LESS_OP         (u16) 0x95
 #define AML_TO_BUFFER_OP            (u16) 0x96	/* ACPI 2.0 */
-#define AML_TO_DECSTRING_OP         (u16) 0x97	/* ACPI 2.0 */
-#define AML_TO_HEXSTRING_OP         (u16) 0x98	/* ACPI 2.0 */
+#define AML_TO_DECIMAL_STRING_OP    (u16) 0x97	/* ACPI 2.0 */
+#define AML_TO_HEX_STRING_OP        (u16) 0x98	/* ACPI 2.0 */
 #define AML_TO_INTEGER_OP           (u16) 0x99	/* ACPI 2.0 */
 #define AML_TO_STRING_OP            (u16) 0x9c	/* ACPI 2.0 */
-#define AML_COPY_OP                 (u16) 0x9d	/* ACPI 2.0 */
+#define AML_COPY_OBJECT_OP          (u16) 0x9d	/* ACPI 2.0 */
 #define AML_MID_OP                  (u16) 0x9e	/* ACPI 2.0 */
 #define AML_CONTINUE_OP             (u16) 0x9f	/* ACPI 2.0 */
 #define AML_IF_OP                   (u16) 0xa0
@@ -142,18 +137,26 @@
 #define AML_NOOP_OP                 (u16) 0xa3
 #define AML_RETURN_OP               (u16) 0xa4
 #define AML_BREAK_OP                (u16) 0xa5
-#define AML_BREAK_POINT_OP          (u16) 0xcc
+#define AML_BREAKPOINT_OP           (u16) 0xcc
 #define AML_ONES_OP                 (u16) 0xff
 
-/* prefixed opcodes */
+/*
+ * Combination opcodes (actually two one-byte opcodes)
+ * Used by the disassembler and iASL compiler
+ */
+#define AML_LOGICAL_GREATER_EQUAL_OP (u16) 0x9295	/* LNot (LLess) */
+#define AML_LOGICAL_LESS_EQUAL_OP    (u16) 0x9294	/* LNot (LGreater) */
+#define AML_LOGICAL_NOT_EQUAL_OP     (u16) 0x9293	/* LNot (LEqual) */
+
+/* Prefixed (2-byte) opcodes (with AML_EXTENDED_PREFIX) */
 
-#define AML_EXTENDED_OPCODE         (u16) 0x5b00	/* prefix for 2-byte opcodes */
+#define AML_EXTENDED_OPCODE         (u16) 0x5b00	/* Prefix for 2-byte opcodes */
 
 #define AML_MUTEX_OP                (u16) 0x5b01
 #define AML_EVENT_OP                (u16) 0x5b02
-#define AML_SHIFT_RIGHT_BIT_OP      (u16) 0x5b10
-#define AML_SHIFT_LEFT_BIT_OP       (u16) 0x5b11
-#define AML_COND_REF_OF_OP          (u16) 0x5b12
+#define AML_SHIFT_RIGHT_BIT_OP      (u16) 0x5b10	/* Obsolete, not in ACPI spec */
+#define AML_SHIFT_LEFT_BIT_OP       (u16) 0x5b11	/* Obsolete, not in ACPI spec */
+#define AML_CONDITIONAL_REF_OF_OP   (u16) 0x5b12
 #define AML_CREATE_FIELD_OP         (u16) 0x5b13
 #define AML_LOAD_TABLE_OP           (u16) 0x5b1f	/* ACPI 2.0 */
 #define AML_LOAD_OP                 (u16) 0x5b20
@@ -175,21 +178,13 @@
 #define AML_FIELD_OP                (u16) 0x5b81
 #define AML_DEVICE_OP               (u16) 0x5b82
 #define AML_PROCESSOR_OP            (u16) 0x5b83
-#define AML_POWER_RES_OP            (u16) 0x5b84
+#define AML_POWER_RESOURCE_OP       (u16) 0x5b84
 #define AML_THERMAL_ZONE_OP         (u16) 0x5b85
 #define AML_INDEX_FIELD_OP          (u16) 0x5b86
 #define AML_BANK_FIELD_OP           (u16) 0x5b87
 #define AML_DATA_REGION_OP          (u16) 0x5b88	/* ACPI 2.0 */
 
 /*
- * Combination opcodes (actually two one-byte opcodes)
- * Used by the disassembler and iASL compiler
- */
-#define AML_LGREATEREQUAL_OP        (u16) 0x9295
-#define AML_LLESSEQUAL_OP           (u16) 0x9294
-#define AML_LNOTEQUAL_OP            (u16) 0x9293
-
-/*
  * Opcodes for "Field" operators
  */
 #define AML_FIELD_OFFSET_OP         (u8) 0x00
@@ -308,24 +303,19 @@
 #define ARGI_INVALID_OPCODE         0xFFFFFFFF
 
 /*
- * hash offsets
- */
-#define AML_EXTOP_HASH_OFFSET       22
-#define AML_LNOT_HASH_OFFSET        19
-
-/*
- * opcode groups and types
+ * Some of the flags and types below are of the form:
+ *
+ * AML_FLAGS_EXEC_#A_#T,#R, or
+ * AML_TYPE_EXEC_#A_#T,#R where:
+ *
+ *      #A is the number of required arguments
+ *      #T is the number of target operands
+ *      #R indicates whether there is a return value
  */
-#define OPGRP_NAMED                 0x01
-#define OPGRP_FIELD                 0x02
-#define OPGRP_BYTELIST              0x04
 
 /*
- * Opcode information
+ * Opcode information flags
  */
-
-/* Opcode flags */
-
 #define AML_LOGICAL                 0x0001
 #define AML_LOGICAL_NUMERIC         0x0002
 #define AML_MATH                    0x0004
@@ -342,7 +332,7 @@
 #define AML_CONSTANT                0x2000
 #define AML_NO_OPERAND_RESOLVE      0x4000
 
-/* Convenient flag groupings */
+/* Convenient flag groupings of the flags above */
 
 #define AML_FLAGS_EXEC_0A_0T_1R                                     AML_HAS_RETVAL
 #define AML_FLAGS_EXEC_1A_0T_0R     AML_HAS_ARGS	/* Monadic1  */
@@ -359,7 +349,7 @@
 
 /*
  * The opcode Type is used in a dispatch table, do not change
- * without updating the table.
+ * or add anything new without updating the table.
  */
 #define AML_TYPE_EXEC_0A_0T_1R      0x00
 #define AML_TYPE_EXEC_1A_0T_0R      0x01	/* Monadic1  */
@@ -385,7 +375,7 @@
 
 #define AML_TYPE_METHOD_CALL        0x10
 
-/* Misc */
+/* Miscellaneous types */
 
 #define AML_TYPE_CREATE_FIELD       0x11
 #define AML_TYPE_CREATE_OBJECT      0x12
@@ -395,7 +385,6 @@
 #define AML_TYPE_NAMED_SIMPLE       0x16
 #define AML_TYPE_NAMED_COMPLEX      0x17
 #define AML_TYPE_RETURN             0x18
-
 #define AML_TYPE_UNDEFINED          0x19
 #define AML_TYPE_BOGUS              0x1A
 
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 9b91cea..8f665d9 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -126,7 +126,7 @@ acpi_db_start_command(struct acpi_walk_state *walk_state,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Called for AML_BREAK_POINT_OP
+ * DESCRIPTION: Called for AML_BREAKPOINT_OP
  *
  ******************************************************************************/
 
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index d31b49f..f470e81 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -347,7 +347,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
 
 		break;
 
-	case AML_BREAK_POINT_OP:
+	case AML_BREAKPOINT_OP:
 
 		acpi_db_signal_break_point(walk_state);
 
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index adcc72c..27a7de9 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -672,7 +672,8 @@ acpi_ds_store_object_to_local(u8 type,
  *
  * FUNCTION:    acpi_ds_method_data_get_type
  *
- * PARAMETERS:  opcode              - Either AML_LOCAL_OP or AML_ARG_OP
+ * PARAMETERS:  opcode              - Either AML_FIRST LOCAL_OP or
+ *                                    AML_FIRST_ARG_OP
  *              index               - Which Local or Arg whose type to get
  *              walk_state          - Current walk state object
  *
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 8deaa16..7df3152 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -114,7 +114,7 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 				    ((op->common.parent->common.aml_opcode ==
 				      AML_PACKAGE_OP)
 				     || (op->common.parent->common.aml_opcode ==
-					 AML_VAR_PACKAGE_OP))) {
+					 AML_VARIABLE_PACKAGE_OP))) {
 					/*
 					 * We didn't find the target and we are populating elements
 					 * of a package - ignore if slack enabled. Some ASL code
@@ -144,7 +144,7 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 
 		if ((op->common.parent->common.aml_opcode == AML_PACKAGE_OP) ||
 		    (op->common.parent->common.aml_opcode ==
-		     AML_VAR_PACKAGE_OP)) {
+		     AML_VARIABLE_PACKAGE_OP)) {
 			/*
 			 * Attempt to resolve the node to a value before we insert it into
 			 * the package. If this is a reference to a common data type,
@@ -398,7 +398,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 
 	parent = op->common.parent;
 	while ((parent->common.aml_opcode == AML_PACKAGE_OP) ||
-	       (parent->common.aml_opcode == AML_VAR_PACKAGE_OP)) {
+	       (parent->common.aml_opcode == AML_VARIABLE_PACKAGE_OP)) {
 		parent = parent->common.parent;
 	}
 
@@ -769,10 +769,10 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 		switch (op_info->type) {
 		case AML_TYPE_LOCAL_VARIABLE:
 
-			/* Local ID (0-7) is (AML opcode - base AML_LOCAL_OP) */
+			/* Local ID (0-7) is (AML opcode - base AML_FIRST_LOCAL_OP) */
 
 			obj_desc->reference.value =
-			    ((u32)opcode) - AML_LOCAL_OP;
+			    ((u32)opcode) - AML_FIRST_LOCAL_OP;
 			obj_desc->reference.class = ACPI_REFCLASS_LOCAL;
 
 #ifndef ACPI_NO_METHOD_EXECUTION
@@ -790,9 +790,10 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 		case AML_TYPE_METHOD_ARGUMENT:
 
-			/* Arg ID (0-6) is (AML opcode - base AML_ARG_OP) */
+			/* Arg ID (0-6) is (AML opcode - base AML_FIRST_ARG_OP) */
 
-			obj_desc->reference.value = ((u32)opcode) - AML_ARG_OP;
+			obj_desc->reference.value =
+			    ((u32)opcode) - AML_FIRST_ARG_OP;
 			obj_desc->reference.class = ACPI_REFCLASS_ARG;
 
 #ifndef ACPI_NO_METHOD_EXECUTION
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 1485232..9a8f8a9 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -639,7 +639,7 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 		break;
 
 	case AML_PACKAGE_OP:
-	case AML_VAR_PACKAGE_OP:
+	case AML_VARIABLE_PACKAGE_OP:
 
 		status =
 		    acpi_ds_build_internal_package_obj(walk_state, op, length,
@@ -660,7 +660,7 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 		if ((!op->common.parent) ||
 		    ((op->common.parent->common.aml_opcode != AML_PACKAGE_OP) &&
 		     (op->common.parent->common.aml_opcode !=
-		      AML_VAR_PACKAGE_OP)
+		      AML_VARIABLE_PACKAGE_OP)
 		     && (op->common.parent->common.aml_opcode !=
 			 AML_NAME_OP))) {
 			walk_state->result_obj = obj_desc;
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 049fbab..406edec 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -275,10 +275,10 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 		if ((op->common.parent->common.aml_opcode == AML_REGION_OP) ||
 		    (op->common.parent->common.aml_opcode == AML_DATA_REGION_OP)
 		    || (op->common.parent->common.aml_opcode == AML_PACKAGE_OP)
-		    || (op->common.parent->common.aml_opcode ==
-			AML_VAR_PACKAGE_OP)
 		    || (op->common.parent->common.aml_opcode == AML_BUFFER_OP)
 		    || (op->common.parent->common.aml_opcode ==
+			AML_VARIABLE_PACKAGE_OP)
+		    || (op->common.parent->common.aml_opcode ==
 			AML_INT_EVAL_SUBTREE_OP)
 		    || (op->common.parent->common.aml_opcode ==
 			AML_BANK_FIELD_OP)) {
@@ -551,7 +551,7 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			 */
 			if (status == AE_NOT_FOUND) {
 				if (parent_op->common.aml_opcode ==
-				    AML_COND_REF_OF_OP) {
+				    AML_CONDITIONAL_REF_OF_OP) {
 					/*
 					 * For the Conditional Reference op, it's OK if
 					 * the name is not found;  We just need a way to
@@ -806,7 +806,7 @@ acpi_status acpi_ds_evaluate_name_path(struct acpi_walk_state *walk_state)
 	}
 
 	if ((op->common.parent->common.aml_opcode == AML_PACKAGE_OP) ||
-	    (op->common.parent->common.aml_opcode == AML_VAR_PACKAGE_OP) ||
+	    (op->common.parent->common.aml_opcode == AML_VARIABLE_PACKAGE_OP) ||
 	    (op->common.parent->common.aml_opcode == AML_REF_OF_OP)) {
 
 		/* TBD: Should we specify this feature as a bit of op_info->Flags of these opcodes? */
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 78f8e6a..a2ff8ad 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -497,7 +497,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 			if ((op->asl.parent) &&
 			    ((op->asl.parent->asl.aml_opcode == AML_PACKAGE_OP)
 			     || (op->asl.parent->asl.aml_opcode ==
-				 AML_VAR_PACKAGE_OP))) {
+				 AML_VARIABLE_PACKAGE_OP))) {
 				ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 						  "Method Reference in a Package, Op=%p\n",
 						  op));
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 44d4553..8d510c7 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -528,7 +528,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 			status = acpi_ex_create_processor(walk_state);
 			break;
 
-		case AML_POWER_RES_OP:
+		case AML_POWER_RESOURCE_OP:
 
 			status = acpi_ex_create_power_resource(walk_state);
 			break;
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 1a6f590..f222a80 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -249,14 +249,14 @@ acpi_ex_do_logical_numeric_op(u16 opcode,
 	ACPI_FUNCTION_TRACE(ex_do_logical_numeric_op);
 
 	switch (opcode) {
-	case AML_LAND_OP:	/* LAnd (Integer0, Integer1) */
+	case AML_LOGICAL_AND_OP:	/* LAnd (Integer0, Integer1) */
 
 		if (integer0 && integer1) {
 			local_result = TRUE;
 		}
 		break;
 
-	case AML_LOR_OP:	/* LOr (Integer0, Integer1) */
+	case AML_LOGICAL_OR_OP:	/* LOr (Integer0, Integer1) */
 
 		if (integer0 || integer1) {
 			local_result = TRUE;
@@ -365,21 +365,21 @@ acpi_ex_do_logical_op(u16 opcode,
 		integer1 = local_operand1->integer.value;
 
 		switch (opcode) {
-		case AML_LEQUAL_OP:	/* LEqual (Operand0, Operand1) */
+		case AML_LOGICAL_EQUAL_OP:	/* LEqual (Operand0, Operand1) */
 
 			if (integer0 == integer1) {
 				local_result = TRUE;
 			}
 			break;
 
-		case AML_LGREATER_OP:	/* LGreater (Operand0, Operand1) */
+		case AML_LOGICAL_GREATER_OP:	/* LGreater (Operand0, Operand1) */
 
 			if (integer0 > integer1) {
 				local_result = TRUE;
 			}
 			break;
 
-		case AML_LLESS_OP:	/* LLess (Operand0, Operand1) */
+		case AML_LOGICAL_LESS_OP:	/* LLess (Operand0, Operand1) */
 
 			if (integer0 < integer1) {
 				local_result = TRUE;
@@ -408,7 +408,7 @@ acpi_ex_do_logical_op(u16 opcode,
 				 (length0 > length1) ? length1 : length0);
 
 		switch (opcode) {
-		case AML_LEQUAL_OP:	/* LEqual (Operand0, Operand1) */
+		case AML_LOGICAL_EQUAL_OP:	/* LEqual (Operand0, Operand1) */
 
 			/* Length and all bytes must be equal */
 
@@ -420,7 +420,7 @@ acpi_ex_do_logical_op(u16 opcode,
 			}
 			break;
 
-		case AML_LGREATER_OP:	/* LGreater (Operand0, Operand1) */
+		case AML_LOGICAL_GREATER_OP:	/* LGreater (Operand0, Operand1) */
 
 			if (compare > 0) {
 				local_result = TRUE;
@@ -437,7 +437,7 @@ acpi_ex_do_logical_op(u16 opcode,
 			}
 			break;
 
-		case AML_LLESS_OP:	/* LLess (Operand0, Operand1) */
+		case AML_LOGICAL_LESS_OP:	/* LLess (Operand0, Operand1) */
 
 			if (compare > 0) {
 				goto cleanup;	/* FALSE */
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index ee7b62a..caa5ed1 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -122,7 +122,7 @@ static char *acpi_ex_allocate_name_string(u32 prefix_count, u32 num_name_segs)
 
 		/* Set up multi prefixes   */
 
-		*temp_ptr++ = AML_MULTI_NAME_PREFIX_OP;
+		*temp_ptr++ = AML_MULTI_NAME_PREFIX;
 		*temp_ptr++ = (char)num_name_segs;
 	} else if (2 == num_name_segs) {
 
@@ -342,7 +342,7 @@ acpi_ex_get_name_string(acpi_object_type data_type,
 			}
 			break;
 
-		case AML_MULTI_NAME_PREFIX_OP:
+		case AML_MULTI_NAME_PREFIX:
 
 			ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
 					  "MultiNamePrefix at %p\n",
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index af73fcd..e327349 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -274,7 +274,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 	case AML_FIND_SET_RIGHT_BIT_OP:
 	case AML_FROM_BCD_OP:
 	case AML_TO_BCD_OP:
-	case AML_COND_REF_OF_OP:
+	case AML_CONDITIONAL_REF_OF_OP:
 
 		/* Create a return object of type Integer for these opcodes */
 
@@ -405,7 +405,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 			}
 			break;
 
-		case AML_COND_REF_OF_OP:	/* cond_ref_of (source_object, Result) */
+		case AML_CONDITIONAL_REF_OF_OP:	/* cond_ref_of (source_object, Result) */
 			/*
 			 * This op is a little strange because the internal return value is
 			 * different than the return value stored in the result descriptor
@@ -475,14 +475,14 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 		/*
 		 * ACPI 2.0 Opcodes
 		 */
-	case AML_COPY_OP:	/* Copy (Source, Target) */
+	case AML_COPY_OBJECT_OP:	/* copy_object (Source, Target) */
 
 		status =
 		    acpi_ut_copy_iobject_to_iobject(operand[0], &return_desc,
 						    walk_state);
 		break;
 
-	case AML_TO_DECSTRING_OP:	/* to_decimal_string (Data, Result) */
+	case AML_TO_DECIMAL_STRING_OP:	/* to_decimal_string (Data, Result) */
 
 		status =
 		    acpi_ex_convert_to_string(operand[0], &return_desc,
@@ -495,7 +495,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 		}
 		break;
 
-	case AML_TO_HEXSTRING_OP:	/* to_hex_string (Data, Result) */
+	case AML_TO_HEX_STRING_OP:	/* to_hex_string (Data, Result) */
 
 		status =
 		    acpi_ex_convert_to_string(operand[0], &return_desc,
@@ -603,7 +603,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 	/* Examine the AML opcode */
 
 	switch (walk_state->opcode) {
-	case AML_LNOT_OP:	/* LNot (Operand) */
+	case AML_LOGICAL_NOT_OP:	/* LNot (Operand) */
 
 		return_desc = acpi_ut_create_integer_object((u64) 0);
 		if (!return_desc) {
@@ -652,9 +652,8 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		 * NOTE:  We use LNOT_OP here in order to force resolution of the
 		 * reference operand to an actual integer.
 		 */
-		status =
-		    acpi_ex_resolve_operands(AML_LNOT_OP, &temp_desc,
-					     walk_state);
+		status = acpi_ex_resolve_operands(AML_LOGICAL_NOT_OP,
+						  &temp_desc, walk_state);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"While resolving operands for [%s]",
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 44ecba5..eecb3bf 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -298,7 +298,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 					NULL, &return_desc->integer.value);
 		break;
 
-	case AML_CONCAT_OP:	/* Concatenate (Data1, Data2, Result) */
+	case AML_CONCATENATE_OP:	/* Concatenate (Data1, Data2, Result) */
 
 		status =
 		    acpi_ex_do_concatenate(operand[0], operand[1], &return_desc,
@@ -343,7 +343,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		       operand[0]->buffer.pointer, length);
 		break;
 
-	case AML_CONCAT_RES_OP:
+	case AML_CONCATENATE_TEMPLATE_OP:
 
 		/* concatenate_res_template (Buffer, Buffer, Result) (ACPI 2.0) */
 
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 31e4df9..688032b 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -124,8 +124,8 @@ acpi_ex_do_match(u32 match_op,
 		 * Change to:     (M == P[i])
 		 */
 		status =
-		    acpi_ex_do_logical_op(AML_LEQUAL_OP, match_obj, package_obj,
-					  &logical_result);
+		    acpi_ex_do_logical_op(AML_LOGICAL_EQUAL_OP, match_obj,
+					  package_obj, &logical_result);
 		if (ACPI_FAILURE(status)) {
 			return (FALSE);
 		}
@@ -137,8 +137,8 @@ acpi_ex_do_match(u32 match_op,
 		 * Change to:                  (M >= P[i]) (M not_less than P[i])
 		 */
 		status =
-		    acpi_ex_do_logical_op(AML_LLESS_OP, match_obj, package_obj,
-					  &logical_result);
+		    acpi_ex_do_logical_op(AML_LOGICAL_LESS_OP, match_obj,
+					  package_obj, &logical_result);
 		if (ACPI_FAILURE(status)) {
 			return (FALSE);
 		}
@@ -151,7 +151,7 @@ acpi_ex_do_match(u32 match_op,
 		 * Change to:         (M > P[i])
 		 */
 		status =
-		    acpi_ex_do_logical_op(AML_LGREATER_OP, match_obj,
+		    acpi_ex_do_logical_op(AML_LOGICAL_GREATER_OP, match_obj,
 					  package_obj, &logical_result);
 		if (ACPI_FAILURE(status)) {
 			return (FALSE);
@@ -164,7 +164,7 @@ acpi_ex_do_match(u32 match_op,
 		 * Change to:                     (M <= P[i]) (M not_greater than P[i])
 		 */
 		status =
-		    acpi_ex_do_logical_op(AML_LGREATER_OP, match_obj,
+		    acpi_ex_do_logical_op(AML_LOGICAL_GREATER_OP, match_obj,
 					  package_obj, &logical_result);
 		if (ACPI_FAILURE(status)) {
 			return (FALSE);
@@ -178,8 +178,8 @@ acpi_ex_do_match(u32 match_op,
 		 * Change to:            (M < P[i])
 		 */
 		status =
-		    acpi_ex_do_logical_op(AML_LLESS_OP, match_obj, package_obj,
-					  &logical_result);
+		    acpi_ex_do_logical_op(AML_LOGICAL_LESS_OP, match_obj,
+					  package_obj, &logical_result);
 		if (ACPI_FAILURE(status)) {
 			return (FALSE);
 		}
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 7fecefc..aa8c6fd 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -196,7 +196,8 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 
 				if ((walk_state->opcode ==
 				     AML_INT_METHODCALL_OP)
-				    || (walk_state->opcode == AML_COPY_OP)) {
+				    || (walk_state->opcode ==
+					AML_COPY_OBJECT_OP)) {
 					break;
 				}
 
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index a2f8001..bdd43cd 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -416,7 +416,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 
 	/* Only limited target types possible for everything except copy_object */
 
-	if (walk_state->opcode != AML_COPY_OP) {
+	if (walk_state->opcode != AML_COPY_OBJECT_OP) {
 		/*
 		 * Only copy_object allows all object types to be overwritten. For
 		 * target_ref(s), there are restrictions on the object types that
@@ -499,7 +499,8 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 	case ACPI_TYPE_STRING:
 	case ACPI_TYPE_BUFFER:
 
-		if ((walk_state->opcode == AML_COPY_OP) || !implicit_conversion) {
+		if ((walk_state->opcode == AML_COPY_OBJECT_OP) ||
+		    !implicit_conversion) {
 			/*
 			 * However, copy_object and Stores to arg_x do not perform
 			 * an implicit conversion, as per the ACPI specification.
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 85db471..56f59cf 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -107,7 +107,7 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 
 		/* For copy_object, no further validation necessary */
 
-		if (walk_state->opcode == AML_COPY_OP) {
+		if (walk_state->opcode == AML_COPY_OBJECT_OP) {
 			break;
 		}
 
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 498bb8f..fb265b57 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -485,7 +485,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 					  flags));
 			break;
 
-		case AML_MULTI_NAME_PREFIX_OP:
+		case AML_MULTI_NAME_PREFIX:
 
 			/* More than one name_seg, search rules do not apply */
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index b5a2914..2fe87d0 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -252,7 +252,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 			internal_name[1] = AML_DUAL_NAME_PREFIX;
 			result = &internal_name[2];
 		} else {
-			internal_name[1] = AML_MULTI_NAME_PREFIX_OP;
+			internal_name[1] = AML_MULTI_NAME_PREFIX;
 			internal_name[2] = (char)num_segments;
 			result = &internal_name[3];
 		}
@@ -274,7 +274,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 			internal_name[i] = AML_DUAL_NAME_PREFIX;
 			result = &internal_name[(acpi_size)i + 1];
 		} else {
-			internal_name[i] = AML_MULTI_NAME_PREFIX_OP;
+			internal_name[i] = AML_MULTI_NAME_PREFIX;
 			internal_name[(acpi_size)i + 1] = (char)num_segments;
 			result = &internal_name[(acpi_size)i + 2];
 		}
@@ -450,7 +450,7 @@ acpi_ns_externalize_name(u32 internal_name_length,
 	 */
 	if (prefix_length < internal_name_length) {
 		switch (internal_name[prefix_length]) {
-		case AML_MULTI_NAME_PREFIX_OP:
+		case AML_MULTI_NAME_PREFIX:
 
 			/* <count> 4-byte names */
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 05b62ad..cda1e15 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -186,7 +186,7 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 		end += 1 + (2 * ACPI_NAME_SIZE);
 		break;
 
-	case AML_MULTI_NAME_PREFIX_OP:
+	case AML_MULTI_NAME_PREFIX:
 
 		/* Multiple name segments, 4 chars each, count in next byte */
 
@@ -339,7 +339,7 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 		/* 2) not_found during a cond_ref_of(x) is ok by definition */
 
 		else if (walk_state->op->common.aml_opcode ==
-			 AML_COND_REF_OF_OP) {
+			 AML_CONDITIONAL_REF_OF_OP) {
 			status = AE_OK;
 		}
 
@@ -352,7 +352,7 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 			 ((arg->common.parent->common.aml_opcode ==
 			   AML_PACKAGE_OP)
 			  || (arg->common.parent->common.aml_opcode ==
-			      AML_VAR_PACKAGE_OP))) {
+			      AML_VARIABLE_PACKAGE_OP))) {
 			status = AE_OK;
 		}
 	}
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 14d6896..b7da881 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -254,7 +254,7 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 
 		case AML_BUFFER_OP:
 		case AML_PACKAGE_OP:
-		case AML_VAR_PACKAGE_OP:
+		case AML_VARIABLE_PACKAGE_OP:
 
 			if ((op->common.parent) &&
 			    (op->common.parent->common.aml_opcode ==
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 451b672..b8f0617 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -69,7 +69,7 @@ ACPI_MODULE_NAME("psopcode")
 	AML_DEVICE_OP
 	AML_THERMAL_ZONE_OP
 	AML_METHOD_OP
-	AML_POWER_RES_OP
+	AML_POWER_RESOURCE_OP
 	AML_PROCESSOR_OP
 	AML_FIELD_OP
 	AML_INDEX_FIELD_OP
@@ -95,7 +95,7 @@ ACPI_MODULE_NAME("psopcode")
 	AML_DEVICE_OP
 	AML_THERMAL_ZONE_OP
 	AML_METHOD_OP
-	AML_POWER_RES_OP
+	AML_POWER_RESOURCE_OP
 	AML_PROCESSOR_OP
 	AML_FIELD_OP
 	AML_INDEX_FIELD_OP
@@ -113,7 +113,7 @@ ACPI_MODULE_NAME("psopcode")
 	AML_DEVICE_OP
 	AML_THERMAL_ZONE_OP
 	AML_METHOD_OP
-	AML_POWER_RES_OP
+	AML_POWER_RESOURCE_OP
 	AML_PROCESSOR_OP
 	AML_NAME_OP
 	AML_ALIAS_OP
@@ -136,7 +136,7 @@ ACPI_MODULE_NAME("psopcode")
 	AML_DEVICE_OP
 	AML_THERMAL_ZONE_OP
 	AML_METHOD_OP
-	AML_POWER_RES_OP
+	AML_POWER_RESOURCE_OP
 	AML_PROCESSOR_OP
 	AML_NAME_OP
 	AML_ALIAS_OP
@@ -149,7 +149,7 @@ ACPI_MODULE_NAME("psopcode")
   must be deferred until needed
 
 	AML_METHOD_OP
-	AML_VAR_PACKAGE_OP
+	AML_VARIABLE_PACKAGE_OP
 	AML_CREATE_FIELD_OP
 	AML_CREATE_BIT_FIELD_OP
 	AML_CREATE_BYTE_FIELD_OP
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index a813bbb..8116a67 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -105,7 +105,7 @@ u16 acpi_ps_peek_opcode(struct acpi_parse_state * parser_state)
 	aml = parser_state->aml;
 	opcode = (u16) ACPI_GET8(aml);
 
-	if (opcode == AML_EXTENDED_OP_PREFIX) {
+	if (opcode == AML_EXTENDED_PREFIX) {
 
 		/* Extended opcode, get the second opcode byte */
 
@@ -210,7 +210,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
 			    || (op->common.parent->common.aml_opcode ==
 				AML_BANK_FIELD_OP)
 			    || (op->common.parent->common.aml_opcode ==
-				AML_VAR_PACKAGE_OP)) {
+				AML_VARIABLE_PACKAGE_OP)) {
 				replacement_op =
 				    acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP,
 						     op->common.aml);
@@ -225,7 +225,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
 				if ((op->common.aml_opcode == AML_BUFFER_OP)
 				    || (op->common.aml_opcode == AML_PACKAGE_OP)
 				    || (op->common.aml_opcode ==
-					AML_VAR_PACKAGE_OP)) {
+					AML_VARIABLE_PACKAGE_OP)) {
 					replacement_op =
 					    acpi_ps_alloc_op(op->common.
 							     aml_opcode,
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 9677fff..a11d475 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -296,7 +296,7 @@ union acpi_parse_object *acpi_ps_get_child(union acpi_parse_object *op)
 		child = acpi_ps_get_arg(op, 1);
 		break;
 
-	case AML_POWER_RES_OP:
+	case AML_POWER_RESOURCE_OP:
 	case AML_INDEX_FIELD_OP:
 
 		child = acpi_ps_get_arg(op, 2);
-- 
2.7.4

