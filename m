From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/7] ACPICA: Remove unused macros, no functional change
Date: Wed, 29 May 2013 10:09:25 +0800
Message-ID: <e883d4763f18f3ece60dd33c291c81766a028591.1367913047.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34684 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:33 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

Remove several unused/duplicated macros in acoutput.h Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acoutput.h |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 4f52ea7..4607b02 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -428,27 +428,21 @@
  * This is the non-debug case -- make everything go away,
  * leaving no executable debug code!
  */
-#define ACPI_FUNCTION_NAME(a)
 #define ACPI_DEBUG_PRINT(pl)
 #define ACPI_DEBUG_PRINT_RAW(pl)
 #define ACPI_DEBUG_EXEC(a)
 #define ACPI_DEBUG_ONLY_MEMBERS(a)
+#define ACPI_FUNCTION_NAME(a)
 #define ACPI_FUNCTION_TRACE(a)
 #define ACPI_FUNCTION_TRACE_PTR(a, b)
 #define ACPI_FUNCTION_TRACE_U32(a, b)
 #define ACPI_FUNCTION_TRACE_STR(a, b)
-#define ACPI_FUNCTION_EXIT
-#define ACPI_FUNCTION_STATUS_EXIT(s)
-#define ACPI_FUNCTION_VALUE_EXIT(s)
 #define ACPI_FUNCTION_ENTRY()
 #define ACPI_DUMP_STACK_ENTRY(a)
 #define ACPI_DUMP_OPERANDS(a, b, c)
 #define ACPI_DUMP_ENTRY(a, b)
-#define ACPI_DUMP_TABLES(a, b)
 #define ACPI_DUMP_PATHNAME(a, b, c, d)
 #define ACPI_DUMP_BUFFER(a, b)
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
 #define ACPI_IS_DEBUG_ENABLED(level, component) 0
 
 /* Return macros must have a return statement at the minimum */
-- 
1.7.10

