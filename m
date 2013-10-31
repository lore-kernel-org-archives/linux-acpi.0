From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/15] ACPICA: Update acpidump related header file changes.
Date: Thu, 31 Oct 2013 09:31:12 +0800
Message-ID: <3e45249b7474ca5c65929018c23e68f8f104f24c.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4892 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:46 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch does not affect the generation of the Linux binary.
This patch decreases 70 lines of divergences.

This patch updates header files that are used by the acpidump to reduce the
source code differences between Linux and ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actypes.h        |    8 ++++++++
 include/acpi/platform/acenv.h |    5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 0e32b6c..809b1a0 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -315,6 +315,14 @@ typedef u32 acpi_physical_address;
 #define ACPI_EXPORT_SYMBOL(symbol)
 #endif
 
+/*
+ * Compiler/Clibrary-dependent debug initialization. Used for ACPICA
+ * utilities only.
+ */
+#ifndef ACPI_DEBUG_INITIALIZE
+#define ACPI_DEBUG_INITIALIZE()
+#endif
+
 /*******************************************************************************
  *
  * Configuration
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 9b3966c..974d3ef 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -96,10 +96,11 @@
 #endif
 
 /*
- * acpi_bin/acpi_help/acpi_src configuration. All single threaded, with
- * no debug output.
+ * acpi_bin/acpi_dump/acpi_src/acpi_xtract configuration. All single
+ * threaded, with no debug output.
  */
 #if (defined ACPI_BIN_APP)   || \
+	(defined ACPI_DUMP_APP)  || \
 	(defined ACPI_SRC_APP)   || \
 	(defined ACPI_XTRACT_APP)
 #define ACPI_APPLICATION
-- 
1.7.10

