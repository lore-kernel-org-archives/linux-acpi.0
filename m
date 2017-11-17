From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 02/11] ACPICA: Disassembler: reset parser_state's Aml pointer when parsing bad externals
Date: Fri, 17 Nov 2017 15:40:15 -0800
Message-ID: <20171117234024.833-3-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49402 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161767AbdKQXpP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:15 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit e7e25137471d7f75960fdb8caf757db0426245ca

Link: https://github.com/acpica/acpica/commit/e7e25137
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/psobject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 0bef6df71bba..8cbe36159376 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -382,6 +382,7 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 			     walk_state->aml -
 			     walk_state->parser_state.aml_start);
 			walk_state->aml = walk_state->parser_state.aml + 2;
+			walk_state->parser_state.aml = walk_state->aml;
 			return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 		}
 #endif
-- 
2.13.6

