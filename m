From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/14] ACPI 2.0 / AML: Improve module level execution by moving the If/Else/While execution to per-table basis
Date: Sat,  6 Feb 2016 11:54:05 +0800
Message-ID: <c1c82566e237cc53347e3ba4f8d7f2f80dce4aa2.1454730660.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This experiment moves module level If/Else/While executions to per-table
basis.

If regressions are found against the enabling of this improvement, this
patch is the only one should get bisected. Please report the regressions
to the kernel bugzilla for further root causing.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c96621e..a98455c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -192,7 +192,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
 /*
  * Optionally support group module level code.
  */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, FALSE);
 
 /*
  * Optionally use 32-bit FADT addresses if and when there is a conflict
-- 
1.7.10
