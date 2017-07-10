From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/16] ACPICA: Disassembler: skip parsing of incorrect external declarations
Date: Mon, 10 Jul 2017 15:24:09 +0800
Message-ID: <f82247189958a27961f9a76fec772c2b6579d984.1499671182.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11974 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdGJHYN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:24:13 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit ed25461901d34120067b07ec280af30abc0458f1

Link: https://github.com/acpica/acpica/commit/ed254619
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psobject.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index ef6384e..0bef6df 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -359,6 +359,32 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 		    acpi_ps_build_named_op(walk_state, aml_op_start, op,
 					   &named_op);
 		acpi_ps_free_op(op);
+
+#ifdef ACPI_ASL_COMPILER
+		if (acpi_gbl_disasm_flag
+		    && walk_state->opcode == AML_EXTERNAL_OP
+		    && status == AE_NOT_FOUND) {
+			/*
+			 * If parsing of AML_EXTERNAL_OP's name path fails, then skip
+			 * past this opcode and keep parsing. This is a much better
+			 * alternative than to abort the entire disassembler. At this
+			 * point, the parser_state is at the end of the namepath of the
+			 * external declaration opcode. Setting walk_state->Aml to
+			 * walk_state->parser_state.Aml + 2 moves increments the
+			 * walk_state->Aml past the object type and the paramcount of the
+			 * external opcode. For the error message, only print the AML
+			 * offset. We could attempt to print the name but this may cause
+			 * a segmentation fault when printing the namepath because the
+			 * AML may be incorrect.
+			 */
+			acpi_os_printf
+			    ("// Invalid external declaration at AML offset 0x%x.\n",
+			     walk_state->aml -
+			     walk_state->parser_state.aml_start);
+			walk_state->aml = walk_state->parser_state.aml + 2;
+			return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
+		}
+#endif
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
-- 
2.7.4

