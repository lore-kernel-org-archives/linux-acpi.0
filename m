From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/18] ACPICA: Update version to 20161222
Date: Wed, 28 Dec 2016 15:30:02 +0800
Message-ID: <8a1a3e3b952fc3e8a2832613cd265db254cee09e.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0d5a056877c2e37e0bfce8d262cec339dc8d55fd
ACPICA commit 5bea13a9e1eb2a0da99600d181afbc5fa075a9eb

Version 20161222

Link: https://github.com/acpica/acpica/commit/0d5a0568
Link: https://github.com/acpica/acpica/commit/5bea13a9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f5e10dd..12f4266 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20160930
+#define ACPI_CA_VERSION                 0x20161222
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.7.4
