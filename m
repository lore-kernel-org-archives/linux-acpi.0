From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 14/14] ACPICA: Update version to 20150930
Date: Mon, 19 Oct 2015 10:26:08 +0800
Message-ID: <c4e76eeac8cdf418ed5a95c6cbb045ba3e1259ab.1445221165.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1445221164.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445221164.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e9c75ca267262326e80d49a290e8387a5963e2d2

Version 20150930.

Link: https://github.com/acpica/acpica/commit/e9c75ca2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ded9fa3..3aaaa86 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20150818
+#define ACPI_CA_VERSION                 0x20150930
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10
