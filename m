From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/22] ACPICA: Cleanup use of NEGATIVE and POSITIVE defines.
Date: Thu, 23 Jul 2015 12:53:57 +0800
Message-ID: <eaeaf4fdd3cdbdaaa589b47f2ad3812c05a768da.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f88814201e01043a4f8caa69a69b799af11c44a3

These were defined in two places. Changed to ACPI_SIGN* names
and define them once in acmacros.h

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/f8881420
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 19d40c6..e85366c 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -224,6 +224,11 @@
 
 #define ACPI_IS_ASCII(c)                ((c) < 0x80)
 
+/* Signed integers */
+
+#define ACPI_SIGN_POSITIVE              0
+#define ACPI_SIGN_NEGATIVE              1
+
 /*
  * Rounding macros (Power of two boundaries only)
  */
-- 
1.7.10
