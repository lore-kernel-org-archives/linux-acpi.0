From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH] ACPICA: AML Parser: fix parse loop to correctly skip erroneous extended opcodes
Date: Wed, 17 Oct 2018 14:20:51 -0700
Message-ID: <20181017212051.11171-1-erik.schmauss@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc: stable@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>
List-Id: linux-acpi@vger.kernel.org

AML opcodes come in two lengths: 1-byte opcodes and 2-byte, extended opcodes.
If an error occurs due to illegal opcodes during table load, the AML parser
needs to continue loading the table. In order to do this, it needs to skip
parsing of the offending opcode and operands associated with that opcode.

This change fixes the AML parse loop to correctly skip parsing of incorrect
extended opcodes. Previously, only the short opcodes were skipped correctly.

Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/psloop.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 34fc2f7476ed..b0789c483b0f 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -417,6 +417,7 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 	union acpi_parse_object *op = NULL;	/* current op */
 	struct acpi_parse_state *parser_state;
 	u8 *aml_op_start = NULL;
+	u8 opcode_length;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_parse_loop, walk_state);
 
@@ -540,8 +541,19 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 						    "Skip parsing opcode %s",
 						    acpi_ps_get_opcode_name
 						    (walk_state->opcode)));
+
+					/*
+					 * Determine the opcode length before skipping the opcode.
+					 * An opcode can be 1 byte or 2 bytes in length.
+					 */
+					opcode_length = 1;
+					if ((walk_state->opcode & 0xFF00) ==
+					    AML_EXTENDED_OPCODE) {
+						opcode_length = 2;
+					}
 					walk_state->parser_state.aml =
-					    walk_state->aml + 1;
+					    walk_state->aml + opcode_length;
+
 					walk_state->parser_state.aml =
 					    acpi_ps_get_next_package_end
 					    (&walk_state->parser_state);
-- 
2.17.1
