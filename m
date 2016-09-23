From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 4/5] ACPI 2.0 / AML: Improve module level execution by moving the If/Else/While execution to per-table basis
Date: Fri, 23 Sep 2016 11:26:55 +0800
Message-ID: <d64177f75f03dc05b0fe63cbb84ff352e15d4f11.1474600034.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1474600034.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37356 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934088AbcIWD1C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Sep 2016 23:27:02 -0400
In-Reply-To: <cover.1474600034.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This reverts commit 00c611def8748a0a1cf1d31842e49b42dfdb3de1.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c7b3a13..169ec81 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -192,7 +192,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
 /*
  * Optionally support group module level code.
  */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, FALSE);
 
 /*
  * Optionally support module level code by parsing the entire table as
-- 
1.7.10

