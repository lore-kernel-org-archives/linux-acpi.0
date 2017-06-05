From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 32/53] ACPICA: Debugger/acpiexec: Cleanup error messages
Date: Mon,  5 Jun 2017 16:40:21 +0800
Message-ID: <06bfcb3cfeb3456e21668db08a89133a837f074d.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23127 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbdFEIkX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:23 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0d792c25d3bcaa857920ec009b732ec7c8942cfa

Clarify some of the error messages when a method failure happens.

Link: https://github.com/acpica/acpica/commit/0d792c25
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbobject.c | 6 +++---
 drivers/acpi/acpica/dsdebug.c  | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
index f2252b1..e7b415c 100644
--- a/drivers/acpi/acpica/dbobject.c
+++ b/drivers/acpi/acpica/dbobject.c
@@ -448,7 +448,7 @@ void acpi_db_decode_locals(struct acpi_walk_state *walk_state)
 
 	if (display_locals) {
 		acpi_os_printf
-		    ("\nInitialized Local Variables for method [%4.4s]:\n",
+		    ("\nInitialized Local Variables for Method [%4.4s]:\n",
 		     acpi_ut_get_node_name(node));
 
 		for (i = 0; i < ACPI_METHOD_NUM_LOCALS; i++) {
@@ -461,7 +461,7 @@ void acpi_db_decode_locals(struct acpi_walk_state *walk_state)
 		}
 	} else {
 		acpi_os_printf
-		    ("No Local Variables are initialized for method [%4.4s]\n",
+		    ("No Local Variables are initialized for Method [%4.4s]\n",
 		     acpi_ut_get_node_name(node));
 	}
 }
@@ -515,7 +515,7 @@ void acpi_db_decode_arguments(struct acpi_walk_state *walk_state)
 		acpi_os_printf("Initialized Arguments for Method [%4.4s]:  "
 			       "(%X arguments defined for method invocation)\n",
 			       acpi_ut_get_node_name(node),
-			       obj_desc->method.param_count);
+			       node->object->method.param_count);
 
 		for (i = 0; i < ACPI_METHOD_NUM_ARGS; i++) {
 			obj_desc = walk_state->arguments[i].object;
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 4d885eb..d1f457e 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -196,6 +196,7 @@ acpi_ds_dump_method_stack(acpi_status status,
 				op->common.next = NULL;
 
 #ifdef ACPI_DISASSEMBLER
+				acpi_os_printf("Failed at ");
 				acpi_dm_disassemble(next_walk_state, op,
 						    ACPI_UINT32_MAX);
 #endif
-- 
2.7.4

