From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/21] ACPICA: Update ACPI example code to make it an actual working program.
Date: Wed,  8 Jan 2014 13:44:45 +0800
Message-ID: <9f4e4d90225fa18c9ef54b356f51e83972e066e3.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56462 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbaAHFoz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:55 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Linux kernel behaviour is not affected as the change only applies
to the ACPICA userspace utilities which are not shipped in the
kernel currently.

Previously, the example code (tools/examples) showed the ACPICA
init code, but was not an actual working program. Added ACPI tables
to make it actually function.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 974d3ef..9c90313 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -96,13 +96,14 @@
 #endif
 
 /*
- * acpi_bin/acpi_dump/acpi_src/acpi_xtract configuration. All single
+ * acpi_bin/acpi_dump/acpi_src/acpi_xtract/Example configuration. All single
  * threaded, with no debug output.
  */
-#if (defined ACPI_BIN_APP)   || \
-	(defined ACPI_DUMP_APP)  || \
-	(defined ACPI_SRC_APP)   || \
-	(defined ACPI_XTRACT_APP)
+#if (defined ACPI_BIN_APP)      || \
+	(defined ACPI_DUMP_APP)     || \
+	(defined ACPI_SRC_APP)      || \
+	(defined ACPI_XTRACT_APP)   || \
+	(defined ACPI_EXAMPLE_APP)
 #define ACPI_APPLICATION
 #define ACPI_SINGLE_THREADED
 #endif
-- 
1.7.10

