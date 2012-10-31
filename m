From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/26] ACPICA: Update for 64-bit generation of recent error message changes
Date: Wed, 31 Oct 2012 10:28:27 +0800
Message-ID: <95dcf40e4f9b74b28cc6d6729e2d9d54bce70a1b.1351649952.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40057 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab2JaC2r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:28:47 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fix for errors on printf changes on 64-bit platforms and gcc.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psloop.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 27f5007..03ddb7a 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -139,8 +139,8 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 			ACPI_ERROR((AE_INFO,
 				    "Unknown opcode 0x%.2X at table offset 0x%.4X, ignoring",
 				    walk_state->opcode,
-				    walk_state->aml_offset +
-				    sizeof(struct acpi_table_header)));
+				    (u32)(walk_state->aml_offset +
+					  sizeof(struct acpi_table_header))));
 
 			ACPI_DUMP_BUFFER(walk_state->parser_state.aml - 16, 48);
 
@@ -152,8 +152,8 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 			acpi_os_printf
 			    ("/*\nError: Unknown opcode 0x%.2X at table offset 0x%.4X, context:\n",
 			     walk_state->opcode,
-			     walk_state->aml_offset +
-			     sizeof(struct acpi_table_header));
+			     (u32)(walk_state->aml_offset +
+				   sizeof(struct acpi_table_header)));
 
 			/* Dump the context surrounding the invalid opcode */
 
-- 
1.7.10

