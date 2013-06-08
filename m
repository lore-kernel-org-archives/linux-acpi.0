From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get system ACPI tables)
Date: Sat,  8 Jun 2013 08:59:31 +0800
Message-ID: <de987440373d946b6c672cd796aedc93f9390059.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3505 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3FHA7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:59:54 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This utility dumps the system ACPI tables in an ascii format
suitable for extraction via the acpixtract utility.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpiosxf.h       |   18 ++++++++++++++++++
 include/acpi/actypes.h        |    8 ++++++++
 include/acpi/platform/acenv.h |    5 +++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 64b8c76..315dd62 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -262,6 +262,24 @@ u32 acpi_os_get_line(char *buffer);
 #endif
 
 /*
+ * Obtain ACPI table(s)
+ */
+acpi_status
+acpi_os_get_table_by_name(char *signature,
+			  u32 instance,
+			  struct acpi_table_header **table,
+			  acpi_physical_address * address);
+
+acpi_status
+acpi_os_get_table_by_index(u32 index,
+			   struct acpi_table_header **table,
+			   acpi_physical_address * address);
+
+acpi_status
+acpi_os_get_table_by_address(acpi_physical_address address,
+			     struct acpi_table_header **table);
+
+/*
  * Directory manipulation
  */
 void *acpi_os_open_directory(char *pathname,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a64adcc..fa50b1f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -306,6 +306,14 @@ typedef u32 acpi_physical_address;
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
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index ef04b36..2c2a0a8 100644
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

