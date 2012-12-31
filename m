From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/27] ACPICA: DEBUG_PRINT macros: Update to improve performance.
Date: Mon, 31 Dec 2012 08:06:04 +0800
Message-ID: <7c20e79639fb5c23498b97035b9ece835c3bed9b.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63151 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:15 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Move check for "debug enable" to before the actual call to the
debug print routine. Improves time of ASLTS by about 15%.  Also,
remove "safe" exit macros since no complex expressions are ever
used in the return statements.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |  132 ++++++++++++++++++++--------------------
 include/acpi/acoutput.h        |   32 +++++++++-
 2 files changed, 96 insertions(+), 68 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index edfcbc8..cd96135 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -392,29 +392,51 @@
  * Debug macros that are conditionally compiled
  */
 #ifdef ACPI_DEBUG_OUTPUT
+
 /*
  * Function entry tracing
+ *
+ * The name of the function is emitted as a local variable that is
+ * intended to be used by both the entry trace and the exit trace.
  */
-#define ACPI_FUNCTION_TRACE(a)          ACPI_FUNCTION_NAME(a) \
-			  acpi_ut_trace(ACPI_DEBUG_PARAMETERS)
-#define ACPI_FUNCTION_TRACE_PTR(a, b)   ACPI_FUNCTION_NAME(a) \
-					   acpi_ut_trace_ptr(ACPI_DEBUG_PARAMETERS, (void *)b)
-#define ACPI_FUNCTION_TRACE_U32(a, b)   ACPI_FUNCTION_NAME(a) \
-							 acpi_ut_trace_u32(ACPI_DEBUG_PARAMETERS, (u32)b)
-#define ACPI_FUNCTION_TRACE_STR(a, b)   ACPI_FUNCTION_NAME(a) \
-									  acpi_ut_trace_str(ACPI_DEBUG_PARAMETERS, (char *)b)
 
-#define ACPI_FUNCTION_ENTRY()           acpi_ut_track_stack_ptr()
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
 
 /*
- * Function exit tracing.
- * WARNING: These macros include a return statement. This is usually considered
- * bad form, but having a separate exit macro is very ugly and difficult to maintain.
- * One of the FUNCTION_TRACE macros above must be used in conjunction with these macros
- * so that "_AcpiFunctionName" is defined.
+ * Function exit tracing
+ *
+ * These macros include a return statement. This is usually considered
+ * bad form, but having a separate exit macro before the actual return
+ * is very ugly and difficult to maintain.
+ *
+ * One of the FUNCTION_TRACE macros above must be used in conjunction
+ * with these macros so that "_AcpiFunctionName" is defined.
  *
- * Note: the DO_WHILE0 macro is used to prevent some compilers from complaining
- * about these constructs.
+ * Note: the DO_WHILE0 macro is used to prevent some compilers from
+ * complaining about these constructs. On other compilers the do...while
+ * adds some extra code, so this feature is optional.
  */
 #ifdef ACPI_USE_DO_WHILE_0
 #define ACPI_DO_WHILE0(a)               do a while(0)
@@ -422,55 +444,35 @@
 #define ACPI_DO_WHILE0(a)               a
 #endif
 
-#define return_VOID                     ACPI_DO_WHILE0 ({ \
-											acpi_ut_exit (ACPI_DEBUG_PARAMETERS); \
-											return;})
-/*
- * There are two versions of most of the return macros. The default version is
- * safer, since it avoids side-effects by guaranteeing that the argument will
- * not be evaluated twice.
- *
- * A less-safe version of the macros is provided for optional use if the
- * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
- */
-#ifndef ACPI_SIMPLE_RETURN_MACROS
-
-#define return_ACPI_STATUS(s)           ACPI_DO_WHILE0 ({ \
-											register acpi_status _s = (s); \
-											acpi_ut_status_exit (ACPI_DEBUG_PARAMETERS, _s); \
-											return (_s); })
-#define return_PTR(s)                   ACPI_DO_WHILE0 ({ \
-											register void *_s = (void *) (s); \
-											acpi_ut_ptr_exit (ACPI_DEBUG_PARAMETERS, (u8 *) _s); \
-											return (_s); })
-#define return_VALUE(s)                 ACPI_DO_WHILE0 ({ \
-											register u64 _s = (s); \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, _s); \
-											return (_s); })
-#define return_UINT8(s)                 ACPI_DO_WHILE0 ({ \
-											register u8 _s = (u8) (s); \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (u64) _s); \
-											return (_s); })
-#define return_UINT32(s)                ACPI_DO_WHILE0 ({ \
-											register u32 _s = (u32) (s); \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (u64) _s); \
-											return (_s); })
-#else				/* Use original less-safe macros */
-
-#define return_ACPI_STATUS(s)           ACPI_DO_WHILE0 ({ \
-											acpi_ut_status_exit (ACPI_DEBUG_PARAMETERS, (s)); \
-											return((s)); })
-#define return_PTR(s)                   ACPI_DO_WHILE0 ({ \
-											acpi_ut_ptr_exit (ACPI_DEBUG_PARAMETERS, (u8 *) (s)); \
-											return((s)); })
-#define return_VALUE(s)                 ACPI_DO_WHILE0 ({ \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (u64) (s)); \
-											return((s)); })
-#define return_UINT8(s)                 return_VALUE(s)
-#define return_UINT32(s)                return_VALUE(s)
-
-#endif				/* ACPI_SIMPLE_RETURN_MACROS */
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
+/* These exit macros are superfluous and should be removed entirely */
+
+#define return_UINT8        return_VALUE
+#define return_UINT32       return_VALUE
 
 /* Conditional execution */
 
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 38e1be0..be014bf 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -263,16 +263,42 @@
  * Common parameters used for debug output functions:
  * line number, function name, module(file) name, component ID
  */
-#define ACPI_DEBUG_PARAMETERS           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
+#define ACPI_DEBUG_PARAMETERS \
+	__LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
 
 /*
  * Master debug print macros
  * Print message if and only if:
  *    1) Debug print for the current component is enabled
  *    2) Debug error level or trace level for the print statement is enabled
+ *
+ * November 2012: Moved the runtime check for whether to actually emit the
+ * debug message outside of the print function itself. This improves overall
+ * performance at a relatively small code cost. Implementation involves the
+ * use of variadic macros supported by C99.
  */
-#define ACPI_DEBUG_PRINT(plist)         acpi_debug_print plist
-#define ACPI_DEBUG_PRINT_RAW(plist)     acpi_debug_print_raw plist
+
+/* DEBUG_PRINT functions */
+
+#define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
+#define ACPI_DEBUG_PRINT_RAW(plist)     ACPI_ACTUAL_DEBUG_RAW plist
+
+/* Helper macros for DEBUG_PRINT */
+
+#define ACPI_IS_DEBUG_ENABLED(level, component) \
+	(level & acpi_dbg_level) && (component & acpi_dbg_layer)
+
+#define ACPI_DEBUG(function, level, line, filename, modulename, component, ...) \
+	if (ACPI_IS_DEBUG_ENABLED (level, component)) \
+	{ \
+		function (level, line, filename, modulename, component, __VA_ARGS__); \
+	}
+
+#define ACPI_ACTUAL_DEBUG(level, line, filename, modulename, component, ...) \
+	ACPI_DEBUG (acpi_debug_print, level, line, filename, modulename, component, __VA_ARGS__)
+
+#define ACPI_ACTUAL_DEBUG_RAW(level, line, filename, modulename, component, ...) \
+	ACPI_DEBUG (acpi_debug_print_raw, level, line, filename, modulename, component, __VA_ARGS__)
 
 #else
 /*
-- 
1.7.10

