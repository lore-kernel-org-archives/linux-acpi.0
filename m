From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/26] ACPICA: Add starting offset parameter to common dump buffer routine
Date: Wed, 31 Oct 2012 10:28:11 +0800
Message-ID: <c0a2ca7988a9c5d0fccc8958102eae888b4a6b53.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41603 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338Ab2JaCiU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:38:20 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Rename the dump buffer routines. Offset parameter can specify the
buffer starting offset that is used when displaying each line of
the buffer.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    2 +-
 drivers/acpi/acpica/acutils.h  |    5 +++--
 drivers/acpi/acpica/exdebug.c  |    8 ++++----
 drivers/acpi/acpica/exdump.c   |    9 +++++----
 drivers/acpi/acpica/psloop.c   |   22 ++++++++++++++--------
 drivers/acpi/acpica/utdebug.c  |   13 +++++++------
 6 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index da8062d..5efad99 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -460,7 +460,7 @@
 #define ACPI_DUMP_OPERANDS(a, b ,c)     acpi_ex_dump_operands(a, b, c)
 #define ACPI_DUMP_ENTRY(a, b)           acpi_ns_dump_entry (a, b)
 #define ACPI_DUMP_PATHNAME(a, b, c, d)  acpi_ns_dump_pathname(a, b, c, d)
-#define ACPI_DUMP_BUFFER(a, b)          acpi_ut_dump_buffer((u8 *) a, b, DB_BYTE_DISPLAY, _COMPONENT)
+#define ACPI_DUMP_BUFFER(a, b)          acpi_ut_debug_dump_buffer((u8 *) a, b, DB_BYTE_DISPLAY, _COMPONENT)
 
 #else
 /*
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index d94b417..5a6aa58 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -305,9 +305,10 @@ acpi_ut_ptr_exit(u32 line_number,
 		 const char *function_name,
 		 const char *module_name, u32 component_id, u8 *ptr);
 
-void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id);
+void
+acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id);
 
-void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display);
+void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 offset);
 
 void acpi_ut_report_error(char *module_name, u32 line_number);
 
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index e0c9050..d7c9f51 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -145,10 +145,10 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 	case ACPI_TYPE_BUFFER:
 
 		acpi_os_printf("[0x%.2X]\n", (u32)source_desc->buffer.length);
-		acpi_ut_dump_buffer2(source_desc->buffer.pointer,
-				     (source_desc->buffer.length < 256) ?
-				     source_desc->buffer.length : 256,
-				     DB_BYTE_DISPLAY);
+		acpi_ut_dump_buffer(source_desc->buffer.pointer,
+				    (source_desc->buffer.length < 256) ?
+				    source_desc->buffer.length : 256,
+				    DB_BYTE_DISPLAY, 0);
 		break;
 
 	case ACPI_TYPE_STRING:
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 3157f3b..858b43a 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -942,10 +942,11 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 		acpi_os_printf("[Buffer] Length %.2X = ",
 			       obj_desc->buffer.length);
 		if (obj_desc->buffer.length) {
-			acpi_ut_dump_buffer(ACPI_CAST_PTR
-					    (u8, obj_desc->buffer.pointer),
-					    obj_desc->buffer.length,
-					    DB_DWORD_DISPLAY, _COMPONENT);
+			acpi_ut_debug_dump_buffer(ACPI_CAST_PTR
+						  (u8,
+						   obj_desc->buffer.pointer),
+						  obj_desc->buffer.length,
+						  DB_DWORD_DISPLAY, _COMPONENT);
 		} else {
 			acpi_os_printf("\n");
 		}
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index faed180..27f5007 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -133,7 +133,7 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 
 	case AML_CLASS_UNKNOWN:
 
-		/* The opcode is unrecognized. Just skip unknown opcodes */
+		/* The opcode is unrecognized. Complain and skip unknown opcodes */
 
 		if (walk_state->pass_number == 2) {
 			ACPI_ERROR((AE_INFO,
@@ -142,28 +142,34 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 				    walk_state->aml_offset +
 				    sizeof(struct acpi_table_header)));
 
-			ACPI_DUMP_BUFFER(walk_state->parser_state.aml, 128);
+			ACPI_DUMP_BUFFER(walk_state->parser_state.aml - 16, 48);
 
 #ifdef ACPI_ASL_COMPILER
-
+			/*
+			 * This is executed for the disassembler only. Output goes
+			 * to the disassembled ASL output file.
+			 */
 			acpi_os_printf
 			    ("/*\nError: Unknown opcode 0x%.2X at table offset 0x%.4X, context:\n",
 			     walk_state->opcode,
 			     walk_state->aml_offset +
 			     sizeof(struct acpi_table_header));
 
-			/* TBD: Pass current offset to dump_buffer */
+			/* Dump the context surrounding the invalid opcode */
 
-			acpi_ut_dump_buffer2(((u8 *)walk_state->parser_state.
-					      aml - 16), 48, DB_BYTE_DISPLAY);
+			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
+					     aml - 16), 48, DB_BYTE_DISPLAY,
+					    walk_state->aml_offset +
+					    sizeof(struct acpi_table_header) -
+					    16);
 			acpi_os_printf(" */\n");
 #endif
 		}
 
-		/* Increment past one or two-byte opcode */
+		/* Increment past one-byte or two-byte opcode */
 
 		walk_state->parser_state.aml++;
-		if (walk_state->opcode > 0xFF) {
+		if (walk_state->opcode > 0xFF) {	/* Can only happen if first byte is 0x5B */
 			walk_state->parser_state.aml++;
 		}
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 7a33270..5d95166 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -513,7 +513,7 @@ acpi_ut_ptr_exit(u32 line_number,
  * PARAMETERS:  buffer              - Buffer to dump
  *              count               - Amount to dump, in bytes
  *              display             - BYTE, WORD, DWORD, or QWORD display
- *              component_ID        - Caller's component ID
+ *              offset              - Beginning buffer offset (display only)
  *
  * RETURN:      None
  *
@@ -521,7 +521,7 @@ acpi_ut_ptr_exit(u32 line_number,
  *
  ******************************************************************************/
 
-void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display)
+void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 {
 	u32 i = 0;
 	u32 j;
@@ -543,7 +543,7 @@ void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display)
 
 		/* Print current offset */
 
-		acpi_os_printf("%6.4X: ", i);
+		acpi_os_printf("%6.4X: ", (base_offset + i));
 
 		/* Print 16 hex chars */
 
@@ -625,7 +625,7 @@ void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_dump_buffer
+ * FUNCTION:    acpi_ut_debug_dump_buffer
  *
  * PARAMETERS:  buffer              - Buffer to dump
  *              count               - Amount to dump, in bytes
@@ -638,7 +638,8 @@ void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display)
  *
  ******************************************************************************/
 
-void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
+void
+acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
 {
 
 	/* Only dump the buffer if tracing is enabled */
@@ -648,5 +649,5 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
 		return;
 	}
 
-	acpi_ut_dump_buffer2(buffer, count, display);
+	acpi_ut_dump_buffer(buffer, count, display, 0);
 }
-- 
1.7.10

