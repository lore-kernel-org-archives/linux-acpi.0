From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 07/13] ACPICA: Utilities: Add ACPI_IS_ALIGNED() macro
Date: Thu,  5 May 2016 12:58:32 +0800
Message-ID: <0a2b4ac18114ee2f813483b9a1a536c93c6a24b9.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch introduces ACPI_IS_ALIGNED() macro. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 73f6653..ecbaaba 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -262,7 +262,8 @@
 
 /* Generic (power-of-two) rounding */
 
-#define ACPI_IS_POWER_OF_TWO(a)             (((a) & ((a) - 1)) == 0)
+#define ACPI_IS_ALIGNED(a, s)               (((a) & ((s) - 1)) == 0)
+#define ACPI_IS_POWER_OF_TWO(a)             ACPI_IS_ALIGNED(a, a)
 
 /*
  * Bitmask creation
-- 
1.7.10
