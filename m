From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/27] ACPICA: Lint changes, no functional change.
Date: Mon, 31 Dec 2012 08:05:39 +0800
Message-ID: <d112e5266ea48e852334af76abc495275b835cec.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41113 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAFt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:05:49 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some changes from lint.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psloop.c   |    9 +++++----
 drivers/acpi/acpica/utdelete.c |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 5607805..a6f8592 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -142,7 +142,8 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 				    (u32)(walk_state->aml_offset +
 					  sizeof(struct acpi_table_header))));
 
-			ACPI_DUMP_BUFFER(walk_state->parser_state.aml - 16, 48);
+			ACPI_DUMP_BUFFER((walk_state->parser_state.aml - 16),
+					 48);
 
 #ifdef ACPI_ASL_COMPILER
 			/*
@@ -159,9 +160,9 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
 					     aml - 16), 48, DB_BYTE_DISPLAY,
-					    walk_state->aml_offset +
-					    sizeof(struct acpi_table_header) -
-					    16);
+					    (walk_state->aml_offset +
+					     sizeof(struct acpi_table_header) -
+					     16));
 			acpi_os_printf(" */\n");
 #endif
 		}
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 53e6af8..c8bf44f 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -340,7 +340,7 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list)
 {
 	union acpi_operand_object **internal_obj;
 
-	ACPI_FUNCTION_NAME(ut_delete_internal_object_list);
+	ACPI_FUNCTION_ENTRY();
 
 	/* Walk the null-terminated internal list */
 
-- 
1.7.10

