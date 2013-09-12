From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/14] ACPICA: Debugger: Prevent possible command line buffer overflow.
Date: Thu, 12 Sep 2013 16:54:52 +0800
Message-ID: <31cb81fe6434a1cbb35360798d3f8f8579350e5d.1377844863.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63165 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab3ILIy5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 04:54:57 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Increase the size of a couple of the debugger line buffers.
ACPICA BZ 1037.

Buglink: http://bugs.acpica.org/show_bug.cgi?id=1037
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 90e846f..c9ad2e1 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -445,13 +445,6 @@ ACPI_EXTERN u8 acpi_gbl_db_opt_tables;
 ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
 ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
 ACPI_EXTERN u8 acpi_gbl_db_opt_no_region_support;
-
-ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
-ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
-ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
-ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
-ACPI_EXTERN char acpi_gbl_db_scope_buf[80];
-ACPI_EXTERN char acpi_gbl_db_debug_filename[80];
 ACPI_EXTERN u8 acpi_gbl_db_output_to_file;
 ACPI_EXTERN char *acpi_gbl_db_buffer;
 ACPI_EXTERN char *acpi_gbl_db_filename;
@@ -459,6 +452,16 @@ ACPI_EXTERN u32 acpi_gbl_db_debug_level;
 ACPI_EXTERN u32 acpi_gbl_db_console_debug_level;
 ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_db_scope_node;
 
+ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
+ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
+
+/* These buffers should all be the same size */
+
+ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
+ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
+ACPI_EXTERN char acpi_gbl_db_scope_buf[ACPI_DB_LINE_BUFFER_SIZE];
+ACPI_EXTERN char acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE];
+
 /*
  * Statistic globals
  */
-- 
1.7.10

