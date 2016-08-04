From: Lv Zheng <lv.zheng@intel.com>
Subject: [UPDATE PATCH 01/30] ACPICA: Fix deconstification warnings (-Wcast-qual) with function traces.
Date: Thu,  4 Aug 2016 16:42:19 +0800
Message-ID: <3faa428e2bebdc04db07e61580c80212e34f434e.1470299678.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com> <3faa428e2bebdc04db07e61580c80212e34f434e.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46329 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcHDImg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:42:36 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>, Bob Moore <robert.moore@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

(update due to email address wrongly converted by acpisrc)

ACPICA commit f722da0372261331b74d3ac67645bba912a21643

Link: https://github.com/acpica/acpica/commit/f722da03
Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    5 +++++
 drivers/acpi/acpica/utdebug.c  |   37 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utdecode.c |    2 +-
 include/acpi/acoutput.h        |    6 +++++-
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index a7dbb2b..0bb6325 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -318,6 +318,11 @@ acpi_ut_ptr_exit(u32 line_number,
 		 const char *module_name, u32 component_id, u8 *ptr);
 
 void
+acpi_ut_str_exit(u32 line_number,
+		 const char *function_name,
+		 const char *module_name, u32 component_id, const char *string);
+
+void
 acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id);
 
 void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 offset);
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 5744222..84c0853 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -562,6 +562,43 @@ acpi_ut_ptr_exit(u32 line_number,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_str_exit
+ *
+ * PARAMETERS:  line_number         - Caller's line number
+ *              function_name       - Caller's procedure name
+ *              module_name         - Caller's module name
+ *              component_id        - Caller's component ID
+ *              string              - String to display
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Function exit trace. Prints only if TRACE_FUNCTIONS bit is
+ *              set in debug_level. Prints exit value also.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_str_exit(u32 line_number,
+		 const char *function_name,
+		 const char *module_name, u32 component_id, const char *string)
+{
+
+	/* Check if enabled up-front for performance */
+
+	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
+		acpi_debug_print(ACPI_LV_FUNCTIONS,
+				 line_number, function_name, module_name,
+				 component_id, "%s %s\n",
+				 acpi_gbl_function_exit_prefix, string);
+	}
+
+	if (acpi_gbl_nesting_level) {
+		acpi_gbl_nesting_level--;
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_trace_point
  *
  * PARAMETERS:  type                - Trace event type
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index efd7988..15728ad 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -253,7 +253,7 @@ const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 		return_PTR("Invalid object");
 	}
 
-	return_PTR(acpi_ut_get_type_name(obj_desc->common.type));
+	return_STR(acpi_ut_get_type_name(obj_desc->common.type));
 }
 
 /*******************************************************************************
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 34f601e..48eb4dd 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -366,7 +366,7 @@
 	ACPI_TRACE_ENTRY (name, acpi_ut_trace_u32, u32, value)
 
 #define ACPI_FUNCTION_TRACE_STR(name, string) \
-	ACPI_TRACE_ENTRY (name, acpi_ut_trace_str, char *, string)
+	ACPI_TRACE_ENTRY (name, acpi_ut_trace_str, const char *, string)
 
 #define ACPI_FUNCTION_ENTRY() \
 	acpi_ut_track_stack_ptr()
@@ -425,6 +425,9 @@
 #define return_PTR(pointer) \
 	ACPI_TRACE_EXIT (acpi_ut_ptr_exit, void *, pointer)
 
+#define return_STR(string) \
+	ACPI_TRACE_EXIT (acpi_ut_str_exit, const char *, string)
+
 #define return_VALUE(value) \
 	ACPI_TRACE_EXIT (acpi_ut_value_exit, u64, value)
 
@@ -478,6 +481,7 @@
 #define return_VOID                     return
 #define return_ACPI_STATUS(s)           return(s)
 #define return_PTR(s)                   return(s)
+#define return_STR(s)                   return(s)
 #define return_VALUE(s)                 return(s)
 #define return_UINT8(s)                 return(s)
 #define return_UINT32(s)                return(s)
-- 
1.7.10

