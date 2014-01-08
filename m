From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/21] ACPICA: Utilities: Cleanup declarations of the acpi_gbl_debug_file global.
Date: Wed,  8 Jan 2014 13:45:02 +0800
Message-ID: <4f695962e867ae00319495f2e609c74a3f91053d.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1414 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbaAHFpP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:45:15 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Linux kernel behaviour is not affected as the changes only applies to the
ACPICA userspace utilities which are not shipped in the kernel currently.

This global is acting as an OSL global variable, implemented in the
oswinxf.c and osunixxf.c.
This patch cleans up the definition of this variable so that new utilities
do not need to define it in order to link.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |   12 ++++++++++++
 include/acpi/platform/acenv.h  |    9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 2686998..24db8e1 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -502,6 +502,18 @@ ACPI_EXTERN u32 acpi_gbl_size_of_acpi_objects;
 
 /*****************************************************************************
  *
+ * Application globals
+ *
+ ****************************************************************************/
+
+#ifdef ACPI_APPLICATION
+
+ACPI_FILE ACPI_INIT_GLOBAL(acpi_gbl_debug_file, NULL);
+
+#endif				/* ACPI_APPLICATION */
+
+/*****************************************************************************
+ *
  * Info/help support
  *
  ****************************************************************************/
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 9c90313..b402eb6 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -395,4 +395,13 @@ typedef char *va_list;
 
 #endif				/* ACPI_USE_SYSTEM_CLIBRARY */
 
+#ifndef ACPI_FILE
+#ifdef ACPI_APPLICATION
+#include <stdio.h>
+#define ACPI_FILE              FILE *
+#else
+#define ACPI_FILE              void *
+#endif				/* ACPI_APPLICATION */
+#endif				/* ACPI_FILE */
+
 #endif				/* __ACENV_H__ */
-- 
1.7.10

