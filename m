From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/25] ACPICA: OSL: Update environments to improve portability.
Date: Tue,  8 Jul 2014 10:06:31 +0800
Message-ID: <408ca239e297d10cbe0e28d7ad9ba3adc48ea976.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64740 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbaGHCGf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:06:35 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch is only useful for ACPICA applications, most of which are not
shipped in the kernel.
This patch contains some environment updates that will be used by acpidump
because:
1. The follow-up commits will release osunixxf.c to the Linux kernel for
   acpidump to link, and
2. Such environment settings will be used to avoid linkage issues.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h |   48 ++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index e863dd5..b6429e4 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -87,20 +87,14 @@
 #define ACPI_DBG_TRACK_ALLOCATIONS
 #endif
 
-/* acpi_names configuration. Single threaded with debugger output enabled. */
-
-#ifdef ACPI_NAMES_APP
-#define ACPI_DEBUGGER
-#define ACPI_APPLICATION
-#define ACPI_SINGLE_THREADED
-#endif
-
 /*
- * acpi_bin/acpi_dump/acpi_src/acpi_xtract/Example configuration. All single
- * threaded, with no debug output.
+ * acpi_bin/acpi_dump/acpi_help/acpi_names/acpi_src/acpi_xtract/Example configuration.
+ * All single threaded.
  */
 #if (defined ACPI_BIN_APP)      || \
 	(defined ACPI_DUMP_APP)     || \
+	(defined ACPI_HELP_APP)     || \
+	(defined ACPI_NAMES_APP)    || \
 	(defined ACPI_SRC_APP)      || \
 	(defined ACPI_XTRACT_APP)   || \
 	(defined ACPI_EXAMPLE_APP)
@@ -108,12 +102,39 @@
 #define ACPI_SINGLE_THREADED
 #endif
 
+/* acpi_help configuration. Error messages disabled. */
+
 #ifdef ACPI_HELP_APP
-#define ACPI_APPLICATION
-#define ACPI_SINGLE_THREADED
 #define ACPI_NO_ERROR_MESSAGES
 #endif
 
+/* acpi_names configuration. Debug output enabled. */
+
+#ifdef ACPI_NAMES_APP
+#define ACPI_DEBUG_OUTPUT
+#endif
+
+/* acpi_exec/acpi_names/Example configuration. Native RSDP used. */
+
+#if (defined ACPI_EXEC_APP)     || \
+	(defined ACPI_EXAMPLE_APP)  || \
+	(defined ACPI_NAMES_APP)
+#define ACPI_USE_NATIVE_RSDP_POINTER
+#endif
+
+/* acpi_dump configuration. Native mapping used if provied by OSPMs */
+
+#ifdef ACPI_DUMP_APP
+#define ACPI_USE_NATIVE_MEMORY_MAPPING
+#endif
+
+/* acpi_names/Example configuration. Hardware disabled */
+
+#if (defined ACPI_EXAMPLE_APP)  || \
+	(defined ACPI_NAMES_APP)
+#define ACPI_REDUCED_HARDWARE 1
+#endif
+
 /* Linkable ACPICA library */
 
 #ifdef ACPI_LIBRARY
@@ -185,6 +206,9 @@
 #elif defined(_AED_EFI)
 #include "acefi.h"
 
+#elif defined(_GNU_EFI)
+#include "acefi.h"
+
 #elif defined(__HAIKU__)
 #include "achaiku.h"
 
-- 
1.7.10

