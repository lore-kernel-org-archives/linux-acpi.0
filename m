From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/4] ACPI 2.0 / AML: Improve module level execution by moving the If/Else/While execution to per-table basis
Date: Thu, 24 Mar 2016 10:43:08 +0800
Message-ID: <046ae35c93c690ff86ae174d1facd905e106124f.1458786874.git.lv.zheng@intel.com>
References: <c87e72bebfbfbb35c4f14100c0a0a5e19a6ec5ed> <cover.1458786874.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458786874.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This experiment moves module level If/Else/While executions to per-table
basis.

If regressions are found against the enabling of this experimental
improvement, this patch is the only one that should get bisected out.
Please report the regressions to the kernel bugzilla for further root
causing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=112911
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 83583a2..cef1223 100644
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
