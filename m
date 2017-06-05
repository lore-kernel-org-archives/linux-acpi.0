From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 51/53] ACPICA: acpiexec: enhance local signal handler
Date: Mon,  5 Jun 2017 16:42:23 +0800
Message-ID: <a47ae976dbcfbc9b7906fcd8b39e6d518841d8a6.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63046 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdFEImZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:42:25 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ffef4ae9a1b6032ebadeab2c2b806f0e585f0006

Add support for SIGSEGV
Improve/cleanup SIGINT handling

Link: https://github.com/acpica/acpica/commit/ffef4ae9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbexec.c   | 12 ++++++++++++
 drivers/acpi/acpica/dsmethod.c | 12 ++++++++----
 drivers/acpi/acpica/psparse.c  | 14 +++++++++++---
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index b611cd9..3b30319 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -181,6 +181,18 @@ acpi_db_execute_method(struct acpi_db_method_info *info,
 	acpi_gbl_method_executing = FALSE;
 
 	if (ACPI_FAILURE(status)) {
+		if ((status == AE_ABORT_METHOD) || acpi_gbl_abort_method) {
+
+			/* Clear the abort and fall back to the debugger prompt */
+
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Aborting top-level method"));
+
+			acpi_gbl_abort_method = FALSE;
+			status = AE_OK;
+			goto cleanup;
+		}
+
 		ACPI_EXCEPTION((AE_INFO, status,
 				"while executing %s from debugger",
 				info->pathname));
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 31c9c7a..d7fc369 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -212,6 +212,7 @@ acpi_status
 acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 {
 	u32 aml_offset;
+	acpi_name name = 0;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -237,10 +238,13 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 						walk_state->parser_state.
 						aml_start);
 
-		status = acpi_gbl_exception_handler(status,
-						    walk_state->method_node ?
-						    walk_state->method_node->
-						    name.integer : 0,
+		if (walk_state->method_node) {
+			name = walk_state->method_node->name.integer;
+		} else if (walk_state->deferred_node) {
+			name = walk_state->deferred_node->name.integer;
+		}
+
+		status = acpi_gbl_exception_handler(status, name,
 						    walk_state->opcode,
 						    aml_offset, NULL);
 		acpi_ex_enter_interpreter();
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 8116a67..ac88319 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -56,6 +56,7 @@
 #include "acdispat.h"
 #include "amlcode.h"
 #include "acinterp.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psparse")
@@ -538,9 +539,16 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			/* Either the method parse or actual execution failed */
 
 			acpi_ex_exit_interpreter();
-			ACPI_ERROR_METHOD("Method parse/execution failed",
-					  walk_state->method_node, NULL,
-					  status);
+			if (status == AE_ABORT_METHOD) {
+				acpi_ns_print_node_pathname(walk_state->
+							    method_node,
+							    "Method aborted:");
+				acpi_os_printf("\n");
+			} else {
+				ACPI_ERROR_METHOD
+				    ("Method parse/execution failed",
+				     walk_state->method_node, NULL, status);
+			}
 			acpi_ex_enter_interpreter();
 
 			/* Check for possible multi-thread reentrancy problem */
-- 
2.7.4

