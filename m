From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/27] ACPICA: Update ACPI_IS_DEBUG_ENABLED macro.
Date: Mon, 31 Dec 2012 08:06:21 +0800
Message-ID: <eb767e5d1b292276f72c303d9bdf0cc4947c9171.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31505 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:31 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add extra parens to allow use of !ACPI_IS_DEBUG_ENABLED.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acoutput.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index be014bf..5ef4e57 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -286,7 +286,7 @@
 /* Helper macros for DEBUG_PRINT */
 
 #define ACPI_IS_DEBUG_ENABLED(level, component) \
-	(level & acpi_dbg_level) && (component & acpi_dbg_layer)
+	((level & acpi_dbg_level) && (component & acpi_dbg_layer))
 
 #define ACPI_DEBUG(function, level, line, filename, modulename, component, ...) \
 	if (ACPI_IS_DEBUG_ENABLED (level, component)) \
-- 
1.7.10

