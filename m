From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/19] ACPICA: Update version to 20150515.
Date: Thu, 21 May 2015 10:32:05 +0800
Message-ID: <95e30cf5fbb85f9b0191f36ada9d9ea99a99d4b1.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ed4de2e8b0a5dd6fc17773a055590bff0e995588

Version 20150515.

Link: https://github.com/acpica/acpica/commit/ed4de2e8
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 08ef57b..d68f1cd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20150410
+#define ACPI_CA_VERSION                 0x20150515
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10
