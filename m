From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/10] ACPICA: Update version to 20150204.
Date: Thu,  5 Feb 2015 15:20:54 +0800
Message-ID: <020959e4079956d85d267abb9b8266492d7128a2.1423119575.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit e06b1624b02dc8317d144e9a6fe9d684c5fa2f90

Version 20150204.

Link: https://github.com/acpica/acpica/commit/e06b1624
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f81e530..96e4ef3 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20141107
+#define ACPI_CA_VERSION                 0x20150204
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10
