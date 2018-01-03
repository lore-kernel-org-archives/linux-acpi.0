From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 02/12] ACPICA: Update for a few debug output statements
Date: Wed,  3 Jan 2018 15:06:21 -0800
Message-ID: <20180103230631.15939-3-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43375 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeACXHl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:41 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 900e96a9c6c6d67c2e18e8c2576dc4742221fc71

Implement a very small indent for trace output.

Link: https://github.com/acpica/acpica/commit/900e96a9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/exdump.c  |  4 ++--
 drivers/acpi/acpica/utdebug.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 83398dc4b7c2..ccdd2a417aa1 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -904,7 +904,7 @@ void
 acpi_ex_dump_operands(union acpi_operand_object **operands,
 		      const char *opcode_name, u32 num_operands)
 {
-	ACPI_FUNCTION_NAME(ex_dump_operands);
+	ACPI_FUNCTION_TRACE(ex_dump_operands);
 
 	if (!opcode_name) {
 		opcode_name = "UNKNOWN";
@@ -928,7 +928,7 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "**** End operand dump for [%s]\n", opcode_name));
-	return;
+	return_VOID;
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 615a885e2ca3..77d8c9054b8e 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -163,6 +163,7 @@ acpi_debug_print(u32 requested_debug_level,
 {
 	acpi_thread_id thread_id;
 	va_list args;
+	int fill_count;
 
 	/* Check if debug output enabled */
 
@@ -202,10 +203,21 @@ acpi_debug_print(u32 requested_debug_level,
 		acpi_os_printf("[%u] ", (u32)thread_id);
 	}
 
-	acpi_os_printf("[%02ld] ", acpi_gbl_nesting_level);
-#endif
+	fill_count = 48 - acpi_gbl_nesting_level -
+	    strlen(acpi_ut_trim_function_name(function_name));
+	if (fill_count < 0) {
+		fill_count = 0;
+	}
 
+	acpi_os_printf("[%02ld] %*s",
+		       acpi_gbl_nesting_level, acpi_gbl_nesting_level, " ");
+	acpi_os_printf("%s%*s: ",
+		       acpi_ut_trim_function_name(function_name), fill_count,
+		       " ");
+
+#else
 	acpi_os_printf("%-22.22s: ", acpi_ut_trim_function_name(function_name));
+#endif
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
-- 
2.14.3

