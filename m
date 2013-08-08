From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 9/9] ACPICA: Update version to 20130725.
Date: Thu,  8 Aug 2013 15:30:11 +0800
Message-ID: <10e0278c49fce3c252b23b4a43e2983374e5d186.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35581 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933825Ab3HHHaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:30:30 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Version 20130725.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e53f16a..85bfdbe 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20130626
+#define ACPI_CA_VERSION                 0x20130725
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

