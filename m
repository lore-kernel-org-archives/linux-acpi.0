From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 6/6] ACPICA: Update version to 20130626
Date: Wed, 17 Jul 2013 09:49:08 +0800
Message-ID: <21ddb0590ec5fc99e6ab6c72ca46eefe9ff2b3a3.1374025121.git.lv.zheng@intel.com>
References: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51340 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab3GQBuF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:50:05 -0400
In-Reply-To: <cover.1374025121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Version 20130626.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1b09300..60b583f 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20130517
+#define ACPI_CA_VERSION                 0x20130626
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

