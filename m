From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 05/15] ACPICA: OSL: Add configurability to error message functions.
Date: Wed, 18 Dec 2013 17:06:19 +0800
Message-ID: <652a818d1980548c6cabb9d00ebc510eee2e2f5c.1387336613.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch extends ACPI_HW_DEPENDENT_x mechanism to all error message
related functions so that the OSPMs can have full control to configure
them into stub functions.
This patch also includes code for Linux to use this new mechanism for
the code that is built without CONFIG_ACPI enabled.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utxferror.c |    2 ++
 include/acpi/acpixf.h           |   75 +++++++++++++++++++++++++--------------
 include/acpi/platform/aclinux.h |    4 +++
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index f7edb88..44e36d7 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -53,6 +53,7 @@ ACPI_MODULE_NAME("utxferror")
  * This module is used for the in-kernel ACPICA as well as the ACPICA
  * tools/applications.
  */
+#ifndef ACPI_NO_ERROR_MESSAGES	/* Entire module */
 /*******************************************************************************
  *
  * FUNCTION:    acpi_error
@@ -249,3 +250,4 @@ acpi_bios_warning(const char *module_name,
 }
 
 ACPI_EXPORT_SYMBOL(acpi_bios_warning)
+#endif				/* ACPI_NO_ERROR_MESSAGES */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2fc2094..6c8619d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -229,6 +229,18 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_no_resource_disassembly, FALSE)
 	static ACPI_INLINE prototype {return;}
 #endif				/* !ACPI_REDUCED_HARDWARE */
 /*
+ * Error-message prototypes. All interfaces that use these macros will
+ * be configured out of the ACPICA build if the ACPI_NO_ERROR_MESSAGE flag
+ * is defined.
+ */
+#ifndef ACPI_NO_ERROR_MESSAGES
+#define ACPI_MSG_DEPENDENT_RETURN_VOID(prototype) \
+	prototype;
+#else
+#define ACPI_MSG_DEPENDENT_RETURN_VOID(prototype) \
+	static ACPI_INLINE prototype {return;}
+#endif				/* ACPI_NO_ERROR_MESSAGES */
+/*
  * Initialization
  */
 acpi_status __init
@@ -661,38 +673,47 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 /*
  * Error/Warning output
  */
-ACPI_PRINTF_LIKE(3)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_error(const char *module_name, u32 line_number, const char *format, ...);
-
-ACPI_PRINTF_LIKE(4)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_exception(const char *module_name,
-	       u32 line_number, acpi_status status, const char *format, ...);
-
-ACPI_PRINTF_LIKE(3)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_warning(const char *module_name, u32 line_number, const char *format, ...);
-
-ACPI_PRINTF_LIKE(3)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_info(const char *module_name, u32 line_number, const char *format, ...);
-
-ACPI_PRINTF_LIKE(3)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_bios_error(const char *module_name,
-		u32 line_number, const char *format, ...);
-
-ACPI_PRINTF_LIKE(3)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_bios_warning(const char *module_name,
-		  u32 line_number, const char *format, ...);
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+			       void ACPI_INTERNAL_VAR_XFACE
+			       acpi_error(const char *module_name,
+					  u32 line_number,
+					  const char *format, ...))
+
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(4)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_exception(const char *module_name,
+					       u32 line_number,
+					       acpi_status status,
+					       const char *format, ...))
+
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_warning(const char *module_name,
+					     u32 line_number,
+					     const char *format, ...))
+
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_info(const char *module_name,
+					  u32 line_number,
+					  const char *format, ...))
+
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_bios_error(const char *module_name,
+						u32 line_number,
+						const char *format, ...))
+
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_bios_warning(const char *module_name,
+						  u32 line_number,
+						  const char *format, ...))
 
 /*
  * Debug output
  */
 #ifdef ACPI_DEBUG_OUTPUT
-
 ACPI_PRINTF_LIKE(6)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_debug_print(u32 requested_debug_level,
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index fce521d..c38929b 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -62,6 +62,10 @@
 
 #define ACPI_NO_MEM_ALLOCATIONS
 
+/* Generating stubs for configurable ACPICA functions */
+
+#define ACPI_NO_ERROR_MESSAGES
+
 #endif
 
 #include <linux/string.h>
-- 
1.7.10.4
