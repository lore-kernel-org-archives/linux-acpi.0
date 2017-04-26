From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/15] ACPICA: Update version to 20170303
Date: Wed, 26 Apr 2017 16:20:17 +0800
Message-ID: <6fcd80356e2a79f390e38b7269fc4b4b0127b2f6.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29706 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1953247AbdDZIUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:20:22 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit db13f9ffbdf16c0b4fb92d051c14c7b96f379f3f
ACPICA commit c55bb526ac9233fe4abc5ea923e136354ce7779c

Version 20170224.
Version 20170303.

Link: https://github.com/acpica/acpica/commit/db13f9ff
Link: https://github.com/acpica/acpica/commit/c55bb526
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3795386..15c86ce 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20170119
+#define ACPI_CA_VERSION                 0x20170303
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.7.4

