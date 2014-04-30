From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/27] ACPICA: Back port of improvements on exception code.
Date: Wed, 30 Apr 2014 10:05:34 +0800
Message-ID: <b7fe634868f694d9081a8a4a2178e4a1013ab819.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This is the linuxize result of the following commit:
  Subject: ACPICA: Improve handling of exception code blocks.
  Split exception codes into three distinct blocks; for the main
  ASL compiler, Table compiler, and the preprocessor. This allows
  easy addition of new codes into each block without disturbing
  the others. Adds one new file, aslmessages.c

The iASL changes are not in this patch as iASL currently is not
shipped in the kernel.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ac04985..2d074ba 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -207,7 +207,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_ssdt_table_install, FALSE);
 
 /*
  * We keep track of the latest version of Windows that has been requested by
- * the BIOS.  ACPI 5.0.
+ * the BIOS. ACPI 5.0.
  */
 ACPI_INIT_GLOBAL(u8, acpi_gbl_osi_data, 0);
 
-- 
1.7.10
