From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 1/5] ACPICA: Namespace: Fix a regression that MLC support triggers dead lock in dynamic table loading
Date: Tue, 21 Jun 2016 12:34:15 +0800
Message-ID: <6cce63a111c40ca70552b003ef5a70eb239afd6f.1466479787.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1466479787.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52289 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbcFUEe3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jun 2016 00:34:29 -0400
In-Reply-To: <cover.1466479787.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

The new MLC approach invokes MLC per-table basis. But the dynamic loading
support of this is incorrect because of the lock order:
 acpi_ns_evaluate
   acpi_ex_enter_intperter
     acpi_ns_load_table (triggered by Load opcode)
       acpi_ns_exec_module_code_list
         acpi_ex_enter_intperter
The regression is introduced by the following commit:
  Commit: 2785ce8d0da1cac9d8f78615e116cf929e9a9123
  ACPICA Commit: 071eff738c59eda1792ac24b3b688b61691d7e7c
  Subject: ACPICA: Add per-table execution of module-level code
This patch fixes this regression by unlocking the interpreter lock before
invoking MLC. However the unlocking is done to the acpi_ns_load_table(), in
which, the interpreter lock should be locked by acpi_ns_parse_table() but
wasn't. Reported by Mika Westerberg. Fixed by Lv Zheng.

Fixes: 2785ce8d0da1 ("ACPICA: Add per-table execution of module-level code")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    2 ++
 drivers/acpi/acpica/nsparse.c  |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index a1d177d..21932d6 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -108,7 +108,9 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Add the table to the namespace */
 
+	acpi_ex_exit_interpreter();
 	status = acpi_ns_load_table(table_index, parent_node);
+	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 		acpi_ut_remove_reference(obj_desc);
 		*ddb_handle = NULL;
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index f631a47..1783cd7 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -47,6 +47,7 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsparse")
@@ -170,6 +171,8 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 
 	ACPI_FUNCTION_TRACE(ns_parse_table);
 
+	acpi_ex_enter_interpreter();
+
 	/*
 	 * AML Parse, pass 1
 	 *
@@ -185,7 +188,7 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
 					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto error_exit;
 	}
 
 	/*
@@ -201,8 +204,10 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
 					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto error_exit;
 	}
 
+error_exit:
+	acpi_ex_exit_interpreter();
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10

