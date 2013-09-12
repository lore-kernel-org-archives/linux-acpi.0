From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/14] ACPICA: Debug output: small formatting update, no functional change.
Date: Thu, 12 Sep 2013 16:54:38 +0800
Message-ID: <8d64e02b1a6fa1d2fbfe4f137a2207531fb11cef.1377844863.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3720 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab3ILIyo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 04:54:44 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Allow for longer filenames in the module name output during
trace operations.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdebug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 5796e11..ffd0db5 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -190,7 +190,7 @@ acpi_debug_print(u32 requested_debug_level,
 	 * Display the module name, current line number, thread ID (if requested),
 	 * current procedure nesting level, and the current procedure name
 	 */
-	acpi_os_printf("%8s-%04ld ", module_name, line_number);
+	acpi_os_printf("%9s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
 		acpi_os_printf("[%u] ", (u32)thread_id);
-- 
1.7.10

