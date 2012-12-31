From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/27] ACPICA: FUNCTION_TRACE macros: Check if debug is enabled up-front.
Date: Mon, 31 Dec 2012 08:06:10 +0800
Message-ID: <1e8de0b0176865126039df6a21b169bb95a9c73f.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37420 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:21 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

In the functions that implement the macros, check if debug
is enabled up-front before the call to the lower debug print
function. This provides a small performance improvement.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdebug.c |  118 +++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 5d95166..47857c4 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -166,11 +166,9 @@ acpi_debug_print(u32 requested_debug_level,
 	acpi_thread_id thread_id;
 	va_list args;
 
-	/*
-	 * Stay silent if the debug level or component ID is disabled
-	 */
-	if (!(requested_debug_level & acpi_dbg_level) ||
-	    !(component_id & acpi_dbg_layer)) {
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(requested_debug_level, component_id)) {
 		return;
 	}
 
@@ -236,8 +234,9 @@ acpi_debug_print_raw(u32 requested_debug_level,
 {
 	va_list args;
 
-	if (!(requested_debug_level & acpi_dbg_level) ||
-	    !(component_id & acpi_dbg_layer)) {
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(requested_debug_level, component_id)) {
 		return;
 	}
 
@@ -272,9 +271,13 @@ acpi_ut_trace(u32 line_number,
 	acpi_gbl_nesting_level++;
 	acpi_ut_track_stack_ptr();
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s\n", acpi_gbl_fn_entry_str);
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s\n", acpi_gbl_fn_entry_str);
+	}
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_trace)
@@ -304,9 +307,14 @@ acpi_ut_trace_ptr(u32 line_number,
 	acpi_gbl_nesting_level++;
 	acpi_ut_track_stack_ptr();
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s %p\n", acpi_gbl_fn_entry_str, pointer);
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s %p\n", acpi_gbl_fn_entry_str,
+				 pointer);
+	}
 }
 
 /*******************************************************************************
@@ -335,9 +343,14 @@ acpi_ut_trace_str(u32 line_number,
 	acpi_gbl_nesting_level++;
 	acpi_ut_track_stack_ptr();
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s %s\n", acpi_gbl_fn_entry_str, string);
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s %s\n", acpi_gbl_fn_entry_str,
+				 string);
+	}
 }
 
 /*******************************************************************************
@@ -366,9 +379,14 @@ acpi_ut_trace_u32(u32 line_number,
 	acpi_gbl_nesting_level++;
 	acpi_ut_track_stack_ptr();
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s %08X\n", acpi_gbl_fn_entry_str, integer);
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s %08X\n",
+				 acpi_gbl_fn_entry_str, integer);
+	}
 }
 
 /*******************************************************************************
@@ -393,9 +411,13 @@ acpi_ut_exit(u32 line_number,
 	     const char *module_name, u32 component_id)
 {
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s\n", acpi_gbl_fn_exit_str);
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s\n", acpi_gbl_fn_exit_str);
+	}
 
 	acpi_gbl_nesting_level--;
 }
@@ -425,17 +447,23 @@ acpi_ut_status_exit(u32 line_number,
 		    u32 component_id, acpi_status status)
 {
 
-	if (ACPI_SUCCESS(status)) {
-		acpi_debug_print(ACPI_LV_FUNCTIONS,
-				 line_number, function_name, module_name,
-				 component_id, "%s %s\n", acpi_gbl_fn_exit_str,
-				 acpi_format_exception(status));
-	} else {
-		acpi_debug_print(ACPI_LV_FUNCTIONS,
-				 line_number, function_name, module_name,
-				 component_id, "%s ****Exception****: %s\n",
-				 acpi_gbl_fn_exit_str,
-				 acpi_format_exception(status));
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		if (ACPI_SUCCESS(status)) {
+			acpi_debug_print(ACPI_LV_FUNCTIONS,
+					 line_number, function_name,
+					 module_name, component_id, "%s %s\n",
+					 acpi_gbl_fn_exit_str,
+					 acpi_format_exception(status));
+		} else {
+			acpi_debug_print(ACPI_LV_FUNCTIONS,
+					 line_number, function_name,
+					 module_name, component_id,
+					 "%s ****Exception****: %s\n",
+					 acpi_gbl_fn_exit_str,
+					 acpi_format_exception(status));
+		}
 	}
 
 	acpi_gbl_nesting_level--;
@@ -465,10 +493,15 @@ acpi_ut_value_exit(u32 line_number,
 		   const char *module_name, u32 component_id, u64 value)
 {
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s %8.8X%8.8X\n", acpi_gbl_fn_exit_str,
-			 ACPI_FORMAT_UINT64(value));
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s %8.8X%8.8X\n",
+				 acpi_gbl_fn_exit_str,
+				 ACPI_FORMAT_UINT64(value));
+	}
 
 	acpi_gbl_nesting_level--;
 }
@@ -497,9 +530,14 @@ acpi_ut_ptr_exit(u32 line_number,
 		 const char *module_name, u32 component_id, u8 *ptr)
 {
 
-	acpi_debug_print(ACPI_LV_FUNCTIONS,
-			 line_number, function_name, module_name, component_id,
-			 "%s %p\n", acpi_gbl_fn_exit_str, ptr);
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s %p\n", acpi_gbl_fn_exit_str,
+				 ptr);
+	}
 
 	acpi_gbl_nesting_level--;
 }
-- 
1.7.10

