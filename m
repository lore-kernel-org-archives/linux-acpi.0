From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/21] ACPICA: Update version to 20131218.
Date: Wed,  8 Jan 2014 13:45:11 +0800
Message-ID: <3ff07d419f8a7a0310a8e0e77191fa96ac4a46a7.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58294 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbaAHFpU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:45:20 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Version 20131218.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index cfe929b..d2f16f1 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20131115
+#define ACPI_CA_VERSION                 0x20131218
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

