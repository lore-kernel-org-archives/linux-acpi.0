From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 34/53] ACPICA: Disassembler: Abort on an invalid/unknown AML opcode
Date: Mon,  5 Jun 2017 16:40:34 +0800
Message-ID: <cb6e67c861e21517cddfc6eb5a4a9cc5f1659c9f.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:44128 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbdFEIkh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:37 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ed0389cb11a61e63c568ac1f67948fc6a7bd1aeb

An invalid opcode indicates something seriously wrong with the
input AML file. The AML parser is immediately confused and lost,
causing the resulting parse tree to be ill-formed. The actual
disassembly can then cause numerous unrelated errors and faults.

This change aborts the disassembly upon discovery of such an
opcode during the AML parse phase.

Link: https://github.com/acpica/acpica/commit/ed0389cb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psobject.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 5bcb618..ef6384e 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -122,6 +122,9 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 			     (u32)(aml_offset +
 				   sizeof(struct acpi_table_header)));
 
+			ACPI_ERROR((AE_INFO,
+				    "Aborting disassembly, AML byte code is corrupt"));
+
 			/* Dump the context surrounding the invalid opcode */
 
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
@@ -130,6 +133,14 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 					     sizeof(struct acpi_table_header) -
 					     16));
 			acpi_os_printf(" */\n");
+
+			/*
+			 * Just abort the disassembly, cannot continue because the
+			 * parser is essentially lost. The disassembler can then
+			 * randomly fail because an ill-constructed parse tree
+			 * can result.
+			 */
+			return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 #endif
 		}
 
@@ -331,6 +342,9 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 	if (status == AE_CTRL_PARSE_CONTINUE) {
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	/* Create Op structure and append to parent's argument list */
 
-- 
2.7.4

