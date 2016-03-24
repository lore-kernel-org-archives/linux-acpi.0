From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/30] ACPICA: Headers: Update generation of the ACPICA library
Date: Thu, 24 Mar 2016 09:40:19 +0800
Message-ID: <5c8ba15e76c83fcb1de235e9f38e9bbb4e17ca27.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0af0f9092dcc3db6c05875eae68965fda333ad7f

For windows only, ensure that debug output is disabled for
the "release" (non-debug) case.

Link: https://github.com/acpica/acpica/commit/0af0f909
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 7c0595b..72f85b4 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -66,17 +66,28 @@
  *
  *****************************************************************************/
 
+/* Common application configuration. All single threaded except for acpi_exec. */
+
+#if (defined ACPI_ASL_COMPILER) || \
+	(defined ACPI_BIN_APP)      || \
+	(defined ACPI_DUMP_APP)     || \
+	(defined ACPI_HELP_APP)     || \
+	(defined ACPI_NAMES_APP)    || \
+	(defined ACPI_SRC_APP)      || \
+	(defined ACPI_XTRACT_APP)   || \
+	(defined ACPI_EXAMPLE_APP)
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#endif
+
 /* iASL configuration */
 
 #ifdef ACPI_ASL_COMPILER
-#define ACPI_APPLICATION
 #define ACPI_DEBUG_OUTPUT
 #define ACPI_CONSTANT_EVAL_ONLY
 #define ACPI_LARGE_NAMESPACE_NODE
 #define ACPI_DATA_TABLE_DISASSEMBLY
-#define ACPI_SINGLE_THREADED
 #define ACPI_32BIT_PHYSICAL_ADDRESS
-
 #define ACPI_DISASSEMBLER 1
 #endif
 
@@ -89,21 +100,6 @@
 #define ACPI_DBG_TRACK_ALLOCATIONS
 #endif
 
-/*
- * acpi_bin/acpi_dump/acpi_help/acpi_names/acpi_src/acpi_xtract/Example
- * configuration. All single threaded.
- */
-#if (defined ACPI_BIN_APP)      || \
-	(defined ACPI_DUMP_APP)     || \
-	(defined ACPI_HELP_APP)     || \
-	(defined ACPI_NAMES_APP)    || \
-	(defined ACPI_SRC_APP)      || \
-	(defined ACPI_XTRACT_APP)   || \
-	(defined ACPI_EXAMPLE_APP)
-#define ACPI_APPLICATION
-#define ACPI_SINGLE_THREADED
-#endif
-
 /* acpi_help configuration. Error messages disabled. */
 
 #ifdef ACPI_HELP_APP
@@ -138,11 +134,16 @@
 #define ACPI_REDUCED_HARDWARE 1
 #endif
 
-/* Linkable ACPICA library */
+/* Linkable ACPICA library. Two versions, one with full debug. */
 
 #ifdef ACPI_LIBRARY
 #define ACPI_USE_LOCAL_CACHE
-#define ACPI_FULL_DEBUG
+#define ACPI_DEBUGGER 1
+#define ACPI_DISASSEMBLER 1
+
+#ifdef _DEBUG
+#define ACPI_DEBUG_OUTPUT
+#endif
 #endif
 
 /* Common for all ACPICA applications */
-- 
1.7.10
