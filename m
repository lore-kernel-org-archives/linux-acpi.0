From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 30/30] ACPICA: Update version to 20160318
Date: Thu, 24 Mar 2016 09:42:01 +0800
Message-ID: <c87e72bebfbfbb35c4f14100c0a0a5e19a6ec5ed.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e714615fda31cce3df9cfd95ee03c1f2c74b2b5e

Version 20160318.

Link: https://github.com/acpica/acpica/commit/e714615f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1755697..83583a2 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20160108
+#define ACPI_CA_VERSION                 0x20160318
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10
