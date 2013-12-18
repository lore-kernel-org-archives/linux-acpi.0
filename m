From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 06/15] ACPICA: OSL: Add configurability to debug output functions.
Date: Wed, 18 Dec 2013 17:06:26 +0800
Message-ID: <d8900a43f3e8a778ed0a2e46254086833876c126.1387336613.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch extends ACPI_HW_DEPENDENT_x mechanism to all debugging output
related functions so that the OSPMs can have full control to configure
them into stub functions.
This patch also includes code for Linux to use this new mechanism for
the code that is built without CONFIG_ACPI enabled.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h           |   45 ++++++++++++++++++++++++---------------
 include/acpi/platform/aclinux.h |    1 +
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 6c8619d..08a1fdb 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -241,6 +241,18 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_no_resource_disassembly, FALSE)
 	static ACPI_INLINE prototype {return;}
 #endif				/* ACPI_NO_ERROR_MESSAGES */
 /*
+ * Debugging-output prototypes. All interfaces that use these macros will
+ * be configured out of the ACPICA build if the ACPI_DEBUG_OUTPUT flag is
+ * not defined.
+ */
+#ifdef ACPI_DEBUG_OUTPUT
+#define ACPI_DBG_DEPENDENT_RETURN_VOID(prototype) \
+	prototype;
+#else
+#define ACPI_DBG_DEPENDENT_RETURN_VOID(prototype) \
+	static ACPI_INLINE prototype {return;}
+#endif				/* ACPI_DEBUG_OUTPUT */
+/*
  * Initialization
  */
 acpi_status __init
@@ -713,22 +725,21 @@ ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
 /*
  * Debug output
  */
-#ifdef ACPI_DEBUG_OUTPUT
-ACPI_PRINTF_LIKE(6)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_debug_print(u32 requested_debug_level,
-		 u32 line_number,
-		 const char *function_name,
-		 const char *module_name,
-		 u32 component_id, const char *format, ...);
-
-ACPI_PRINTF_LIKE(6)
-void ACPI_INTERNAL_VAR_XFACE
-acpi_debug_print_raw(u32 requested_debug_level,
-		     u32 line_number,
-		     const char *function_name,
-		     const char *module_name,
-		     u32 component_id, const char *format, ...);
-#endif
+ACPI_DBG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(6)
+			       void ACPI_INTERNAL_VAR_XFACE
+			       acpi_debug_print(u32 requested_debug_level,
+						u32 line_number,
+						const char *function_name,
+						const char *module_name,
+						u32 component_id,
+						const char *format, ...))
 
+ACPI_DBG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(6)
+				void ACPI_INTERNAL_VAR_XFACE
+				acpi_debug_print_raw(u32 requested_debug_level,
+						     u32 line_number,
+						     const char *function_name,
+						     const char *module_name,
+						     u32 component_id,
+						     const char *format, ...))
 #endif				/* __ACXFACE_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index c38929b..45df524 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -65,6 +65,7 @@
 /* Generating stubs for configurable ACPICA functions */
 
 #define ACPI_NO_ERROR_MESSAGES
+#undef ACPI_DEBUG_OUTPUT
 
 #endif
 
-- 
1.7.10.4
