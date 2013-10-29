From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/20] ACPICA: Prevent possible build issues for use of ACPI_PRINTF_LIKE macro
Date: Tue, 29 Oct 2013 09:30:16 +0800
Message-ID: <57d26fce3fbeaf0f7a45e1e522dee2bd40447fba.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1260 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2BaZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:25 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The following build error:
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CC      arch/x86/kernel/setup.o
 In file included from include/acpi/acpi.h:64:0,
                  from include/linux/iscsi_ibft.h:24,
                  from arch/x86/kernel/setup.c:43:
 include/acpi/acpixf.h:543:1: error: expected ',' or ';' before '{' token
 include/acpi/acpixf.h:540:1: warning: 'acpi_error' declared 'static' but never defined [-Wunused-function]
 make[2]: *** [arch/x86/kernel/setup.o] Error 1
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
can be triggerred by the following stub function (if implemented):
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 static inline void ACPI_INTERNAL_VAR_XFACE
 acpi_error(const char *module_name,
 	   u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3)
 {
 }
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This patch changes the position of ACPI_PRINTF_LIKE(x) to follow the
style of __printf(x, x+1) used in Linux to prevent such issues from
happening.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpixf.h |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ddde61b..9759bd5 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -530,50 +530,53 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 /*
  * Error/Warning output
  */
+ACPI_PRINTF_LIKE(3)
 void ACPI_INTERNAL_VAR_XFACE
-acpi_error(const char *module_name,
-	   u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+acpi_error(const char *module_name, u32 line_number, const char *format, ...);
 
+ACPI_PRINTF_LIKE(4)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_exception(const char *module_name,
-	       u32 line_number,
-	       acpi_status status, const char *format, ...) ACPI_PRINTF_LIKE(4);
+	       u32 line_number, acpi_status status, const char *format, ...);
 
+ACPI_PRINTF_LIKE(3)
 void ACPI_INTERNAL_VAR_XFACE
-acpi_warning(const char *module_name,
-	     u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+acpi_warning(const char *module_name, u32 line_number, const char *format, ...);
 
+ACPI_PRINTF_LIKE(3)
 void ACPI_INTERNAL_VAR_XFACE
-acpi_info(const char *module_name,
-	  u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+acpi_info(const char *module_name, u32 line_number, const char *format, ...);
 
+ACPI_PRINTF_LIKE(3)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_bios_error(const char *module_name,
-		u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+		u32 line_number, const char *format, ...);
 
+ACPI_PRINTF_LIKE(3)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_bios_warning(const char *module_name,
-		  u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+		  u32 line_number, const char *format, ...);
 
 /*
  * Debug output
  */
 #ifdef ACPI_DEBUG_OUTPUT
 
+ACPI_PRINTF_LIKE(6)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_debug_print(u32 requested_debug_level,
 		 u32 line_number,
 		 const char *function_name,
 		 const char *module_name,
-		 u32 component_id, const char *format, ...) ACPI_PRINTF_LIKE(6);
+		 u32 component_id, const char *format, ...);
 
+ACPI_PRINTF_LIKE(6)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_debug_print_raw(u32 requested_debug_level,
 		     u32 line_number,
 		     const char *function_name,
 		     const char *module_name,
-		     u32 component_id,
-		     const char *format, ...) ACPI_PRINTF_LIKE(6);
+		     u32 component_id, const char *format, ...);
 #endif
 
 #endif				/* __ACXFACE_H__ */
-- 
1.7.10

