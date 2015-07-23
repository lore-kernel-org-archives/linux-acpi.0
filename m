From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/22] ACPICA: Parser: Remove redundant opcode execution debugging output.
Date: Thu, 23 Jul 2015 12:53:22 +0800
Message-ID: <d2192ad9279b05155bb145da1d00e66f0f43cd0e.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12739 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbbGWEx3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:53:29 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit c832b0a9263c560b3ae3ae31d7298ef33988f8d5

This patch removes one redundant debugging output of opcode execution which
has already been covered by acpi_ex_start_trace_opcode(). Lv Zheng.

Link: https://github.com/acpica/acpica/commit/c832b0a9
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/psloop.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index a7de52e..6b11fd7 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -491,14 +491,6 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 				continue;
 			}
 
-			if (walk_state->op_info) {
-				ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-						  "Opcode %4.4X [%s] Op %p Aml %p\n",
-						  (u32)op->common.aml_opcode,
-						  walk_state->op_info->name, op,
-						  op->common.aml));
-			}
-
 			acpi_ex_start_trace_opcode(op, walk_state);
 		}
 
-- 
1.7.10

