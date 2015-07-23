From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/22] ACPICA: Executer: Add option to bypass opcode tracing.
Date: Thu, 23 Jul 2015 12:53:15 +0800
Message-ID: <96198f468045ae692e2e07f86d0a65ebcc06ea90.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 61e9e20aadfaa03184d0959fbdc1fa5cdfea2551

This patch adds option to bypass opcode tracing. The option can be used to
reduce the trace message output. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/61e9e20a
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exdebug.c |    6 ++++--
 include/acpi/acoutput.h       |    5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 708b2ae..de92458 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -598,7 +598,8 @@ acpi_ex_start_trace_opcode(union acpi_parse_object *op,
 
 	ACPI_FUNCTION_NAME(ex_start_trace_opcode);
 
-	if (acpi_ex_interpreter_trace_enabled(NULL)) {
+	if (acpi_ex_interpreter_trace_enabled(NULL) &&
+	    (acpi_gbl_trace_flags & ACPI_TRACE_OPCODE)) {
 		ACPI_TRACE_POINT(ACPI_TRACE_AML_OPCODE, TRUE,
 				 op->common.aml, op->common.aml_op_name);
 	}
@@ -625,7 +626,8 @@ acpi_ex_stop_trace_opcode(union acpi_parse_object *op,
 
 	ACPI_FUNCTION_NAME(ex_stop_trace_opcode);
 
-	if (acpi_ex_interpreter_trace_enabled(NULL)) {
+	if (acpi_ex_interpreter_trace_enabled(NULL) &&
+	    (acpi_gbl_trace_flags & ACPI_TRACE_OPCODE)) {
 		ACPI_TRACE_POINT(ACPI_TRACE_AML_OPCODE, FALSE,
 				 op->common.aml, op->common.aml_op_name);
 	}
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index c3f0ac1..908d4f9 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -187,8 +187,9 @@
 /*
  * Global trace flags
  */
-#define ACPI_TRACE_ENABLED          ((u32) 2)
-#define ACPI_TRACE_ONESHOT          ((u32) 1)
+#define ACPI_TRACE_ENABLED          ((u32) 4)
+#define ACPI_TRACE_ONESHOT          ((u32) 2)
+#define ACPI_TRACE_OPCODE           ((u32) 1)
 
 /* Defaults for trace debugging level/layer */
 
-- 
1.7.10
