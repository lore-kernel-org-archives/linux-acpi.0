From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 03/11] ACPICA: disassembler: getting rid of error message
Date: Fri, 17 Nov 2017 15:40:16 -0800
Message-ID: <20171117234024.833-4-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49402 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbdKQXpR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:17 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit 7d542c6f97e27f7d0e90be1afd98097c3840e007

This error message tends to clutter up the disassembled ASL
file with information that is unnecessary.

Link: https://github.com/acpica/acpica/commit/7d542c6f
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/psobject.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 8cbe36159376..c0b179883ff2 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -372,15 +372,8 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 			 * external declaration opcode. Setting walk_state->Aml to
 			 * walk_state->parser_state.Aml + 2 moves increments the
 			 * walk_state->Aml past the object type and the paramcount of the
-			 * external opcode. For the error message, only print the AML
-			 * offset. We could attempt to print the name but this may cause
-			 * a segmentation fault when printing the namepath because the
-			 * AML may be incorrect.
+			 * external opcode.
 			 */
-			acpi_os_printf
-			    ("// Invalid external declaration at AML offset 0x%x.\n",
-			     walk_state->aml -
-			     walk_state->parser_state.aml_start);
 			walk_state->aml = walk_state->parser_state.aml + 2;
 			walk_state->parser_state.aml = walk_state->aml;
 			return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
-- 
2.13.6

