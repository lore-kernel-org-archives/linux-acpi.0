From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 8/8] ACPICA: Update version to 20170831
Date: Fri, 15 Sep 2017 12:44:55 +0800
Message-ID: <9c622daa0b6ee1d71ba4ecc4383982ec5469153a.1505377451.git.lv.zheng@intel.com>
References: <cover.1505377451.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9965 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdIOEpA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Sep 2017 00:45:00 -0400
In-Reply-To: <cover.1505377451.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit faa9fdfbd035a14347e6a875be2a0cddb3e6fc00

Version 20170831.

Link: https://github.com/acpica/acpica/commit/faa9fdfbd035
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 53c5e2f..e1dd1a8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20170728
+#define ACPI_CA_VERSION                 0x20170831
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.7.4

