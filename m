From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 31/31] ACPICA: Update version to 20150410.
Date: Mon, 13 Apr 2015 11:51:29 +0800
Message-ID: <a5e8cfcd0b77112e2cd7d93ad24a2abdacfd2281.1428893939.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 06198cfd96ef271f554a50f1830a5975468c39ac
ACPICA commit 8a3c1df1edb5f9fc5c940500c598c0107d30df71

Version 20150410.

Link: https://github.com/acpica/acpica/commit/06198cfd
Link: https://github.com/acpica/acpica/commit/8a3c1df1
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 65aa4fa..08ef57b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20150204
+#define ACPI_CA_VERSION                 0x20150410
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10
