From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/32] ACPICA: MSVC6: Fix build issue for variable argument macros.
Date: Fri, 19 Jun 2015 11:39:34 +0800
Message-ID: <d28af59fe3fb438a411d311ae106968193430304.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 72f5a358f28c5d154ed613c142c7dca03192c5ee

This patch intoduces generic variable macro detection support and fixes
build breakage issue with macros using __VA_ARGS__ feature defined in
C99.

This patch fixes this build issue. Lv Zheng.

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/72f5a358
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acoutput.h       |   13 +++++++++++--
 include/acpi/platform/acgcc.h |    4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index a8f3443..f56de8c 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -294,8 +294,12 @@
 
 /* DEBUG_PRINT functions */
 
-#define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
-#define ACPI_DEBUG_PRINT_RAW(plist)     ACPI_ACTUAL_DEBUG_RAW plist
+#ifndef COMPILER_VA_MACRO
+
+#define ACPI_DEBUG_PRINT(plist)         acpi_debug_print plist
+#define ACPI_DEBUG_PRINT_RAW(plist)     acpi_debug_print_raw plist
+
+#else
 
 /* Helper macros for DEBUG_PRINT */
 
@@ -315,6 +319,11 @@
 	ACPI_DO_DEBUG_PRINT (acpi_debug_print_raw, level, line, \
 		filename, modulename, component, __VA_ARGS__)
 
+#define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
+#define ACPI_DEBUG_PRINT_RAW(plist)     ACPI_ACTUAL_DEBUG_RAW plist
+
+#endif
+
 /*
  * Function entry tracing
  *
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index f54de0a..5457a06 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -75,4 +75,8 @@
 #undef strchr
 #endif
 
+/* GCC supports __VA_ARGS__ in macros */
+
+#define COMPILER_VA_MACRO               1
+
 #endif				/* __ACGCC_H__ */
-- 
1.7.10
