From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 26/32] ACPICA: Clib: Correct memset() declarations.
Date: Fri, 19 Jun 2015 11:41:07 +0800
Message-ID: <7817ef2db27d33bc5a7d5dd39c7bea25dae7c9bf.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 00f0dc83f5cfca53b27a3213ae0d7719b88c2d6b

Gcc complains memset() prototype used in the ACPICA even when the nostdinc
is specified:
  ../../../source/include/acutils.h:418:1: error: conflicting types for built-in function 'memset' [-Werror]

This patch corrects the declarations of memset(). Lv Zheng.

Link: https://github.com/acpica/acpica/commit/00f0dc83
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 8f62703..6372a6b 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -234,7 +234,7 @@ int memcmp(void *buffer1, void *buffer2, acpi_size count);
 
 void *memcpy(void *dest, const void *src, acpi_size count);
 
-void *memset(void *dest, u8 value, acpi_size count);
+void *memset(void *dest, int value, acpi_size count);
 
 int toupper(int c);
 
-- 
1.7.10
