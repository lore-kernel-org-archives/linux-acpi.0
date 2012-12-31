From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/27] ACPICA: Merge all debug output macros into a single file, acoutput.
Date: Mon, 31 Dec 2012 08:06:33 +0800
Message-ID: <f0334f21b06ee3e030f192ee4e4179894ba5eac8.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26787 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:49 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Moved the debug trace macros from acmacros.h into acoutput.h
where they belong.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |  126 ----------------------------------------
 include/acpi/acoutput.h        |  115 ++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 126 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 81f3cf7..2db0f10 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -388,132 +388,6 @@
 
 #endif				/* ACPI_NO_ERROR_MESSAGES */
 
-/*
- * Debug macros that are conditionally compiled
- */
-#ifdef ACPI_DEBUG_OUTPUT
-
-/*
- * Function entry tracing
- *
- * The name of the function is emitted as a local variable that is
- * intended to be used by both the entry trace and the exit trace.
- */
-
-/* Helper macro */
-
-#define ACPI_TRACE_ENTRY(name, function, cast, param) \
-	ACPI_FUNCTION_NAME (name) \
-	function (ACPI_DEBUG_PARAMETERS, cast (param))
-
-/* The actual entry trace macros */
-
-#define ACPI_FUNCTION_TRACE(name) \
-	ACPI_FUNCTION_NAME(name) \
-	acpi_ut_trace (ACPI_DEBUG_PARAMETERS)
-
-#define ACPI_FUNCTION_TRACE_PTR(name, pointer) \
-	ACPI_TRACE_ENTRY (name, acpi_ut_trace_ptr, (void *), pointer)
-
-#define ACPI_FUNCTION_TRACE_U32(name, value) \
-	ACPI_TRACE_ENTRY (name, acpi_ut_trace_u32, (u32), value)
-
-#define ACPI_FUNCTION_TRACE_STR(name, string) \
-	ACPI_TRACE_ENTRY (name, acpi_ut_trace_str, (char *), string)
-
-#define ACPI_FUNCTION_ENTRY() \
-	acpi_ut_track_stack_ptr()
-
-/*
- * Function exit tracing
- *
- * These macros include a return statement. This is usually considered
- * bad form, but having a separate exit macro before the actual return
- * is very ugly and difficult to maintain.
- *
- * One of the FUNCTION_TRACE macros above must be used in conjunction
- * with these macros so that "_AcpiFunctionName" is defined.
- *
- * Note: the DO_WHILE0 macro is used to prevent some compilers from
- * complaining about these constructs. On other compilers the do...while
- * adds some extra code, so this feature is optional.
- */
-#ifdef ACPI_USE_DO_WHILE_0
-#define ACPI_DO_WHILE0(a)               do a while(0)
-#else
-#define ACPI_DO_WHILE0(a)               a
-#endif
-
-/* Exit trace helper macro */
-
-#define ACPI_TRACE_EXIT(function, cast, param) \
-	ACPI_DO_WHILE0 ({ \
-		function (ACPI_DEBUG_PARAMETERS, cast (param)); \
-		return ((param)); \
-	})
-
-/* The actual exit macros */
-
-#define return_VOID \
-	ACPI_DO_WHILE0 ({ \
-		acpi_ut_exit (ACPI_DEBUG_PARAMETERS); \
-		return; \
-	})
-
-#define return_ACPI_STATUS(status) \
-	ACPI_TRACE_EXIT (acpi_ut_status_exit, (acpi_status), status)
-
-#define return_PTR(pointer) \
-	ACPI_TRACE_EXIT (acpi_ut_ptr_exit, (u8 *), pointer)
-
-#define return_VALUE(value) \
-	ACPI_TRACE_EXIT (acpi_ut_value_exit, (u64), value)
-
-/* Conditional execution */
-
-#define ACPI_DEBUG_EXEC(a)              a
-#define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
-#define _VERBOSE_STRUCTURES
-
-/* Various object display routines for debug */
-
-#define ACPI_DUMP_STACK_ENTRY(a)        acpi_ex_dump_operand((a), 0)
-#define ACPI_DUMP_OPERANDS(a, b ,c)     acpi_ex_dump_operands(a, b, c)
-#define ACPI_DUMP_ENTRY(a, b)           acpi_ns_dump_entry (a, b)
-#define ACPI_DUMP_PATHNAME(a, b, c, d)  acpi_ns_dump_pathname(a, b, c, d)
-#define ACPI_DUMP_BUFFER(a, b)          acpi_ut_debug_dump_buffer((u8 *) a, b, DB_BYTE_DISPLAY, _COMPONENT)
-
-#else
-/*
- * This is the non-debug case -- make everything go away,
- * leaving no executable debug code!
- */
-#define ACPI_DEBUG_EXEC(a)
-#define ACPI_DEBUG_ONLY_MEMBERS(a)
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a, b)
-#define ACPI_FUNCTION_TRACE_U32(a, b)
-#define ACPI_FUNCTION_TRACE_STR(a, b)
-#define ACPI_FUNCTION_EXIT
-#define ACPI_FUNCTION_STATUS_EXIT(s)
-#define ACPI_FUNCTION_VALUE_EXIT(s)
-#define ACPI_FUNCTION_ENTRY()
-#define ACPI_DUMP_STACK_ENTRY(a)
-#define ACPI_DUMP_OPERANDS(a, b, c)
-#define ACPI_DUMP_ENTRY(a, b)
-#define ACPI_DUMP_TABLES(a, b)
-#define ACPI_DUMP_PATHNAME(a, b, c, d)
-#define ACPI_DUMP_BUFFER(a, b)
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
-
-#define return_VOID                     return
-#define return_ACPI_STATUS(s)           return(s)
-#define return_VALUE(s)                 return(s)
-#define return_PTR(s)                   return(s)
-
-#endif				/* ACPI_DEBUG_OUTPUT */
-
 #if (!ACPI_REDUCED_HARDWARE)
 #define ACPI_HW_OPTIONAL_FUNCTION(addr)     addr
 #else
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 5ef4e57..c13b351 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -300,7 +300,97 @@
 #define ACPI_ACTUAL_DEBUG_RAW(level, line, filename, modulename, component, ...) \
 	ACPI_DEBUG (acpi_debug_print_raw, level, line, filename, modulename, component, __VA_ARGS__)
 
+/*
+ * Function entry tracing
+ *
+ * The name of the function is emitted as a local variable that is
+ * intended to be used by both the entry trace and the exit trace.
+ */
+
+/* Helper macro */
+
+#define ACPI_TRACE_ENTRY(name, function, cast, param) \
+	ACPI_FUNCTION_NAME (name) \
+	function (ACPI_DEBUG_PARAMETERS, cast (param))
+
+/* The actual entry trace macros */
+
+#define ACPI_FUNCTION_TRACE(name) \
+	ACPI_FUNCTION_NAME(name) \
+	acpi_ut_trace (ACPI_DEBUG_PARAMETERS)
+
+#define ACPI_FUNCTION_TRACE_PTR(name, pointer) \
+	ACPI_TRACE_ENTRY (name, acpi_ut_trace_ptr, (void *), pointer)
+
+#define ACPI_FUNCTION_TRACE_U32(name, value) \
+	ACPI_TRACE_ENTRY (name, acpi_ut_trace_u32, (u32), value)
+
+#define ACPI_FUNCTION_TRACE_STR(name, string) \
+	ACPI_TRACE_ENTRY (name, acpi_ut_trace_str, (char *), string)
+
+#define ACPI_FUNCTION_ENTRY() \
+	acpi_ut_track_stack_ptr()
+
+/*
+ * Function exit tracing
+ *
+ * These macros include a return statement. This is usually considered
+ * bad form, but having a separate exit macro before the actual return
+ * is very ugly and difficult to maintain.
+ *
+ * One of the FUNCTION_TRACE macros above must be used in conjunction
+ * with these macros so that "_AcpiFunctionName" is defined.
+ *
+ * Note: the DO_WHILE0 macro is used to prevent some compilers from
+ * complaining about these constructs. On other compilers the do...while
+ * adds some extra code, so this feature is optional.
+ */
+#ifdef ACPI_USE_DO_WHILE_0
+#define ACPI_DO_WHILE0(a)               do a while(0)
 #else
+#define ACPI_DO_WHILE0(a)               a
+#endif
+
+/* Exit trace helper macro */
+
+#define ACPI_TRACE_EXIT(function, cast, param) \
+	ACPI_DO_WHILE0 ({ \
+		function (ACPI_DEBUG_PARAMETERS, cast (param)); \
+		return ((param)); \
+	})
+
+/* The actual exit macros */
+
+#define return_VOID \
+	ACPI_DO_WHILE0 ({ \
+		acpi_ut_exit (ACPI_DEBUG_PARAMETERS); \
+		return; \
+	})
+
+#define return_ACPI_STATUS(status) \
+	ACPI_TRACE_EXIT (acpi_ut_status_exit, (acpi_status), status)
+
+#define return_PTR(pointer) \
+	ACPI_TRACE_EXIT (acpi_ut_ptr_exit, (u8 *), pointer)
+
+#define return_VALUE(value) \
+	ACPI_TRACE_EXIT (acpi_ut_value_exit, (u64), value)
+
+/* Conditional execution */
+
+#define ACPI_DEBUG_EXEC(a)              a
+#define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
+#define _VERBOSE_STRUCTURES
+
+/* Various object display routines for debug */
+
+#define ACPI_DUMP_STACK_ENTRY(a)        acpi_ex_dump_operand((a), 0)
+#define ACPI_DUMP_OPERANDS(a, b ,c)     acpi_ex_dump_operands(a, b, c)
+#define ACPI_DUMP_ENTRY(a, b)           acpi_ns_dump_entry (a, b)
+#define ACPI_DUMP_PATHNAME(a, b, c, d)  acpi_ns_dump_pathname(a, b, c, d)
+#define ACPI_DUMP_BUFFER(a, b)          acpi_ut_debug_dump_buffer((u8 *) a, b, DB_BYTE_DISPLAY, _COMPONENT)
+
+#else				/* ACPI_DEBUG_OUTPUT */
 /*
  * This is the non-debug case -- make everything go away,
  * leaving no executable debug code!
@@ -308,6 +398,31 @@
 #define ACPI_FUNCTION_NAME(a)
 #define ACPI_DEBUG_PRINT(pl)
 #define ACPI_DEBUG_PRINT_RAW(pl)
+#define ACPI_DEBUG_EXEC(a)
+#define ACPI_DEBUG_ONLY_MEMBERS(a)
+#define ACPI_FUNCTION_TRACE(a)
+#define ACPI_FUNCTION_TRACE_PTR(a, b)
+#define ACPI_FUNCTION_TRACE_U32(a, b)
+#define ACPI_FUNCTION_TRACE_STR(a, b)
+#define ACPI_FUNCTION_EXIT
+#define ACPI_FUNCTION_STATUS_EXIT(s)
+#define ACPI_FUNCTION_VALUE_EXIT(s)
+#define ACPI_FUNCTION_ENTRY()
+#define ACPI_DUMP_STACK_ENTRY(a)
+#define ACPI_DUMP_OPERANDS(a, b, c)
+#define ACPI_DUMP_ENTRY(a, b)
+#define ACPI_DUMP_TABLES(a, b)
+#define ACPI_DUMP_PATHNAME(a, b, c, d)
+#define ACPI_DUMP_BUFFER(a, b)
+#define ACPI_DEBUG_PRINT(pl)
+#define ACPI_DEBUG_PRINT_RAW(pl)
+
+/* Return macros must have a return statement at the minimum */
+
+#define return_VOID                     return
+#define return_ACPI_STATUS(s)           return(s)
+#define return_VALUE(s)                 return(s)
+#define return_PTR(s)                   return(s)
 
 #endif				/* ACPI_DEBUG_OUTPUT */
 
-- 
1.7.10

