From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/15] ACPICA: Update version to 20160212
Date: Fri, 19 Feb 2016 14:17:50 +0800
Message-ID: <f99bf4d7ba041ba521b4edd60dd96a84ebb9629a.1455857586.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 6b06645ea778cc054f48b03dd1842260a1606532

Version 20160212

Link: https://github.com/acpica/acpica/commit/6b06645e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1755697..c5078aa 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20160108
+#define ACPI_CA_VERSION                 0x20160212
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10
