From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/7] ACPICA: Add BIOS error interface for predefined name validation support
Date: Wed, 29 May 2013 10:09:08 +0800
Message-ID: <9a68bc2fc901de929d993d8f0b853e836b72cdd2.1367913046.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37511 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:17 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

BIOS error message for errors found in predefined names.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h  |   10 +++++---
 drivers/acpi/acpica/acutils.h   |    6 +++++
 drivers/acpi/acpica/utxferror.c |   51 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 53666bd..530a2f8 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -374,10 +374,11 @@
  * the plist contains a set of parens to allow variable-length lists.
  * These macros are used for both the debug and non-debug versions of the code.
  */
-#define ACPI_ERROR_NAMESPACE(s, e)      acpi_ut_namespace_error (AE_INFO, s, e);
-#define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ut_method_error (AE_INFO, s, n, p, e);
-#define ACPI_WARN_PREDEFINED(plist)     acpi_ut_predefined_warning plist
-#define ACPI_INFO_PREDEFINED(plist)     acpi_ut_predefined_info plist
+#define ACPI_ERROR_NAMESPACE(s, e)          acpi_ut_namespace_error (AE_INFO, s, e);
+#define ACPI_ERROR_METHOD(s, n, p, e)       acpi_ut_method_error (AE_INFO, s, n, p, e);
+#define ACPI_WARN_PREDEFINED(plist)         acpi_ut_predefined_warning plist
+#define ACPI_INFO_PREDEFINED(plist)         acpi_ut_predefined_info plist
+#define ACPI_BIOS_ERROR_PREDEFINED(plist)   acpi_ut_predefined_bios_error plist
 
 #else
 
@@ -387,6 +388,7 @@
 #define ACPI_ERROR_METHOD(s, n, p, e)
 #define ACPI_WARN_PREDEFINED(plist)
 #define ACPI_INFO_PREDEFINED(plist)
+#define ACPI_BIOS_ERROR_PREDEFINED(plist)
 
 #endif				/* ACPI_NO_ERROR_MESSAGES */
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 202f4f1..19e5cf7 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -670,6 +670,12 @@ acpi_ut_predefined_info(const char *module_name,
 			u32 line_number,
 			char *pathname, u8 node_flags, const char *format, ...);
 
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_bios_error(const char *module_name,
+			      u32 line_number,
+			      char *pathname,
+			      u8 node_flags, const char *format, ...);
+
 void
 acpi_ut_namespace_error(const char *module_name,
 			u32 line_number,
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 976b6c7..61a2c17 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -82,8 +82,8 @@ extern FILE *acpi_gbl_output_file;
 #define ACPI_MSG_EXCEPTION      "ACPI Exception: "
 #define ACPI_MSG_WARNING        "ACPI Warning: "
 #define ACPI_MSG_INFO           "ACPI: "
-#define ACPI_MSG_BIOS_ERROR     "ACPI BIOS Bug: Error: "
-#define ACPI_MSG_BIOS_WARNING   "ACPI BIOS Bug: Warning: "
+#define ACPI_MSG_BIOS_ERROR     "ACPI BIOS Error (bug): "
+#define ACPI_MSG_BIOS_WARNING   "ACPI BIOS Warning (bug): "
 /*
  * Common message suffix
  */
@@ -325,7 +325,7 @@ acpi_ut_predefined_warning(const char *module_name,
 		return;
 	}
 
-	acpi_os_printf(ACPI_MSG_WARNING "For %s: ", pathname);
+	acpi_os_printf(ACPI_MSG_WARNING "%s: ", pathname);
 
 	va_start(arg_list, format);
 	acpi_os_vprintf(format, arg_list);
@@ -367,7 +367,50 @@ acpi_ut_predefined_info(const char *module_name,
 		return;
 	}
 
-	acpi_os_printf(ACPI_MSG_INFO "For %s: ", pathname);
+	acpi_os_printf(ACPI_MSG_INFO "%s: ", pathname);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_bios_error
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: BIOS error message for predefined names. Messages
+ *              are only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_bios_error(const char *module_name,
+			      u32 line_number,
+			      char *pathname,
+			      u8 node_flags, const char *format, ...)
+{
+	va_list arg_list;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf(ACPI_MSG_BIOS_ERROR "%s: ", pathname);
 
 	va_start(arg_list, format);
 	acpi_os_vprintf(format, arg_list);
-- 
1.7.10

