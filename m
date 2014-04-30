From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/27] ACPICA: OSL: Add configurability for error message functions.
Date: Wed, 30 Apr 2014 10:04:48 +0800
Message-ID: <93af1f58b161fbc3810f33f3b8cf616cd793690f.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch extends ACPI_HW_DEPENDENT_x mechanism to all error message
related functions so that the OSPMs can have full control to configure them
into stub functions.

This patch doesn't include code for Linux to use this new mechanism, thus
no functional change.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utxferror.c |    2 ++
 include/acpi/acpixf.h           |   73 ++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index edd8611..88ef77f 100644
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
index 8255689..39f432e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -241,6 +241,21 @@ ACPI_GLOBAL(u8, acpi_gbl_system_awake_and_running);
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
 /*
+ * Error-message prototypes. All interfaces that use these macros will
+ * be configured out of the ACPICA build if the ACPI_NO_ERROR_MESSAGE flag
+ * is defined.
+ */
+#ifndef ACPI_NO_ERROR_MESSAGES
+#define ACPI_MSG_DEPENDENT_RETURN_VOID(prototype) \
+	prototype;
+
+#else
+#define ACPI_MSG_DEPENDENT_RETURN_VOID(prototype) \
+	static ACPI_INLINE prototype {return;}
+
+#endif				/* ACPI_NO_ERROR_MESSAGES */
+
+/*
  * Initialization
  */
 acpi_status __init
@@ -666,38 +681,42 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
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
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(4)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_exception(const char *module_name,
+					       u32 line_number,
+					       acpi_status status,
+					       const char *format, ...))
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_warning(const char *module_name,
+					     u32 line_number,
+					     const char *format, ...))
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_info(const char *module_name,
+					  u32 line_number,
+					  const char *format, ...))
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_bios_error(const char *module_name,
+						u32 line_number,
+						const char *format, ...))
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
-- 
1.7.10
