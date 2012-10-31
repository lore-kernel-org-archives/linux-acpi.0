From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/26] ACPICA: Enhance error reporting for invalid opcodes and bad ACPI_NAMEs
Date: Wed, 31 Oct 2012 10:27:48 +0800
Message-ID: <96c06b771923148645d17c972432fecf382a50c6.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24901 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaC1y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:54 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

For disassembler, dump the 48 bytes surrounding the invalid
opcode.  Fix incorrect table offset reported for invalid opcodes.
Report original 32-bit value for bad ACPI_NAMEs.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsutils.c   |    9 ++++---
 drivers/acpi/acpica/psloop.c    |   51 ++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/utmisc.c    |    3 +++
 drivers/acpi/acpica/utxferror.c |    2 +-
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 16b3da8..0d3d481 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -557,10 +557,11 @@ acpi_ns_externalize_name(u32 internal_name_length,
 				(*converted_name)[j++] = '.';
 			}
 
-			(*converted_name)[j++] = internal_name[names_index++];
-			(*converted_name)[j++] = internal_name[names_index++];
-			(*converted_name)[j++] = internal_name[names_index++];
-			(*converted_name)[j++] = internal_name[names_index++];
+			ACPI_MOVE_NAME(*converted_name, internal_name);
+			acpi_ut_repair_name(*converted_name);
+
+			j += ACPI_NAME_SIZE;
+			names_index += ACPI_NAME_SIZE;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 799162c..faed180 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -135,16 +135,38 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 
 		/* The opcode is unrecognized. Just skip unknown opcodes */
 
-		ACPI_ERROR((AE_INFO,
-			    "Found unknown opcode 0x%X at AML address %p offset 0x%X, ignoring",
-			    walk_state->opcode, walk_state->parser_state.aml,
-			    walk_state->aml_offset));
+		if (walk_state->pass_number == 2) {
+			ACPI_ERROR((AE_INFO,
+				    "Unknown opcode 0x%.2X at table offset 0x%.4X, ignoring",
+				    walk_state->opcode,
+				    walk_state->aml_offset +
+				    sizeof(struct acpi_table_header)));
 
-		ACPI_DUMP_BUFFER(walk_state->parser_state.aml, 128);
+			ACPI_DUMP_BUFFER(walk_state->parser_state.aml, 128);
 
-		/* Assume one-byte bad opcode */
+#ifdef ACPI_ASL_COMPILER
+
+			acpi_os_printf
+			    ("/*\nError: Unknown opcode 0x%.2X at table offset 0x%.4X, context:\n",
+			     walk_state->opcode,
+			     walk_state->aml_offset +
+			     sizeof(struct acpi_table_header));
+
+			/* TBD: Pass current offset to dump_buffer */
+
+			acpi_ut_dump_buffer2(((u8 *)walk_state->parser_state.
+					      aml - 16), 48, DB_BYTE_DISPLAY);
+			acpi_os_printf(" */\n");
+#endif
+		}
+
+		/* Increment past one or two-byte opcode */
 
 		walk_state->parser_state.aml++;
+		if (walk_state->opcode > 0xFF) {
+			walk_state->parser_state.aml++;
+		}
+
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 
 	default:
@@ -519,11 +541,18 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 					if ((op_info->class ==
 					     AML_CLASS_EXECUTE) && (!arg)) {
 						ACPI_WARNING((AE_INFO,
-							      "Detected an unsupported executable opcode "
-							      "at module-level: [0x%.4X] at table offset 0x%.4X",
-							      op->common.aml_opcode,
-							      (u32)((aml_op_start - walk_state->parser_state.aml_start)
-								+ sizeof(struct acpi_table_header))));
+							      "Unsupported module-level executable opcode "
+							      "0x%.2X at table offset 0x%.4X",
+							      op->common.
+							      aml_opcode,
+							      (u32)
+							      (ACPI_PTR_DIFF
+							       (aml_op_start,
+								walk_state->
+								parser_state.
+								aml_start) +
+							       sizeof(struct
+								      acpi_table_header))));
 					}
 				}
 				break;
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index fba6eba..0405c0f 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -720,9 +720,12 @@ void acpi_ut_repair_name(char *name)
 {
 	u32 i;
 	u8 found_bad_char = FALSE;
+	u32 original_name;
 
 	ACPI_FUNCTION_NAME(ut_repair_name);
 
+	ACPI_MOVE_NAME(&original_name, name);
+
 	/* Check each character in the name */
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 6d63cc3..d4d3826 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -408,7 +408,7 @@ acpi_ut_namespace_error(const char *module_name,
 
 		ACPI_MOVE_32_TO_32(&bad_name,
 				   ACPI_CAST_PTR(u32, internal_name));
-		acpi_os_printf("[0x%4.4X] (NON-ASCII)", bad_name);
+		acpi_os_printf("[0x%.8X] (NON-ASCII)", bad_name);
 	} else {
 		/* Convert path to external format */
 
-- 
1.7.10

