From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 7/7] ACPICA: Update version to 20130117
Date: Fri, 25 Jan 2013 13:41:28 +0800
Message-ID: <a4c137959a16c115b4577a296c467c28decb581c.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50387 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab3AYFlp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:41:45 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Version 20130117.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index bf3e129..03322dd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20121220
+#define ACPI_CA_VERSION                 0x20130117
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

