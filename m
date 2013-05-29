From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 7/7] ACPICA: Update version to 20130418
Date: Wed, 29 May 2013 10:09:38 +0800
Message-ID: <e3cc0fe73014403430094e1c86b39952cd4b66b1.1367913047.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62265 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:47 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Version 20130418.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 454881e..1561264 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20130328
+#define ACPI_CA_VERSION                 0x20130418
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

