From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/15] ACPICA: Utilities: Add ACPI_IS_ALIGNED() macro
Date: Wed,  4 May 2016 13:49:03 +0800
Message-ID: <1626ef6e4fdb43c7bb4816793f619d77633a70e0.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
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
