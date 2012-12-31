From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/27] ACPICA: Update for non-configured ACPI_IS_DEBUG_ENABLED macro.
Date: Mon, 31 Dec 2012 08:06:50 +0800
Message-ID: <63df9ffff24b4a1cf7efd425b03037bec9fc3642.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11071 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAHG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:06 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Also add acoutput.h to the nsdump.c file.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsdump.c |    1 +
 include/acpi/acoutput.h      |    9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 3e04879..37b0e68 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -44,6 +44,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
+#include <acpi/acoutput.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsdump")
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index c13b351..23db272 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -266,6 +266,11 @@
 #define ACPI_DEBUG_PARAMETERS \
 	__LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
 
+/* Check if debug output is currently dynamically enabled */
+
+#define ACPI_IS_DEBUG_ENABLED(level, component) \
+	((level & acpi_dbg_level) && (component & acpi_dbg_layer))
+
 /*
  * Master debug print macros
  * Print message if and only if:
@@ -285,9 +290,6 @@
 
 /* Helper macros for DEBUG_PRINT */
 
-#define ACPI_IS_DEBUG_ENABLED(level, component) \
-	((level & acpi_dbg_level) && (component & acpi_dbg_layer))
-
 #define ACPI_DEBUG(function, level, line, filename, modulename, component, ...) \
 	if (ACPI_IS_DEBUG_ENABLED (level, component)) \
 	{ \
@@ -416,6 +418,7 @@
 #define ACPI_DUMP_BUFFER(a, b)
 #define ACPI_DEBUG_PRINT(pl)
 #define ACPI_DEBUG_PRINT_RAW(pl)
+#define ACPI_IS_DEBUG_ENABLED(level, component) 0
 
 /* Return macros must have a return statement at the minimum */
 
-- 
1.7.10

