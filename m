From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/30] ACPICA: Utilities: Add ACPI_IS_POWER_OF_TWO()
Date: Thu, 24 Mar 2016 09:40:56 +0800
Message-ID: <0d359d3512fbb03c4a1f5a61c68f20d9eeb3e2dd.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit cbcb77565c5032dd48e19b3a8a8b8704c5f29faf

This patch adds a macro ACPI_IS_POWER_OF_TWO, which can be used to
detect if a number is a power of two. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/cbcb7756
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 411c18b..b461f55 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -260,6 +260,10 @@
 
 #define ACPI_IS_MISALIGNED(value)           (((acpi_size) value) & (sizeof(acpi_size)-1))
 
+/* Generic (power-of-two) rounding */
+
+#define ACPI_IS_POWER_OF_TWO(a)             (((a) & ((a) - 1)) == 0)
+
 /*
  * Bitmask creation
  * Bit positions start at zero.
-- 
1.7.10
