From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/6] ACPICA: Debug output: Do not emit function nesting level for kernel build.
Date: Thu, 21 Nov 2013 12:17:20 +0800
Message-ID: <285c468c3a0447234fc123e7fd9eaf761e19abc7.1384747397.git.lv.zheng@intel.com>
References: <cover.1384747396.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51769 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab3KUERi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 23:17:38 -0500
In-Reply-To: <cover.1384747396.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

The nesting level is really only useful during a single-thread execution.
Therefore, only enable this output for the AcpiExec utility.
Also, only emit the thread ID when executing under AcpiExec.
(Context switches are still detected and a message is emitted.)
ACPICA BZ 972.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdebug.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 1a67b39..03ae8af 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -185,6 +185,7 @@ acpi_debug_print(u32 requested_debug_level,
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
+		acpi_gbl_nesting_level = 0;
 	}
 
 	/*
@@ -193,13 +194,21 @@ acpi_debug_print(u32 requested_debug_level,
 	 */
 	acpi_os_printf("%9s-%04ld ", module_name, line_number);
 
+#ifdef ACPI_EXEC_APP
+	/*
+	 * For acpi_exec only, emit the thread ID and nesting level.
+	 * Note: nesting level is really only useful during a single-thread
+	 * execution. Otherwise, multiple threads will keep resetting the
+	 * level.
+	 */
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
 		acpi_os_printf("[%u] ", (u32)thread_id);
 	}
 
-	acpi_os_printf("[%02ld] %-22.22s: ",
-		       acpi_gbl_nesting_level,
-		       acpi_ut_trim_function_name(function_name));
+	acpi_os_printf("[%02ld] ", acpi_gbl_nesting_level);
+#endif
+
+	acpi_os_printf("%-22.22s: ", acpi_ut_trim_function_name(function_name));
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
@@ -420,7 +429,9 @@ acpi_ut_exit(u32 line_number,
 				 component_id, "%s\n", acpi_gbl_fn_exit_str);
 	}
 
-	acpi_gbl_nesting_level--;
+	if (acpi_gbl_nesting_level) {
+		acpi_gbl_nesting_level--;
+	}
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_exit)
@@ -467,7 +478,9 @@ acpi_ut_status_exit(u32 line_number,
 		}
 	}
 
-	acpi_gbl_nesting_level--;
+	if (acpi_gbl_nesting_level) {
+		acpi_gbl_nesting_level--;
+	}
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
@@ -504,7 +517,9 @@ acpi_ut_value_exit(u32 line_number,
 				 ACPI_FORMAT_UINT64(value));
 	}
 
-	acpi_gbl_nesting_level--;
+	if (acpi_gbl_nesting_level) {
+		acpi_gbl_nesting_level--;
+	}
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_value_exit)
@@ -540,7 +555,9 @@ acpi_ut_ptr_exit(u32 line_number,
 				 ptr);
 	}
 
-	acpi_gbl_nesting_level--;
+	if (acpi_gbl_nesting_level) {
+		acpi_gbl_nesting_level--;
+	}
 }
 
 #endif
-- 
1.7.10

