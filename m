From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/31] ACPICA: Update AML Debugger global variables.
Date: Mon, 13 Apr 2015 11:50:14 +0800
Message-ID: <268064d547608a06190b132e48a3ff426041ef8f.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18776 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630AbbDMDuS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:50:18 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f65d0e5b880860a6da0c336b7c48139d1469f5b4

- Remove unused variables
- Update to use standard naming/capitalization convention.

Linux kernel is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/f65d0e5b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index a165d25..8a99dcb 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -321,9 +321,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_db_terminate_threads, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_abort_method, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_method_executing, FALSE);
 
-ACPI_GLOBAL(u8, acpi_gbl_db_opt_tables);
-ACPI_GLOBAL(u8, acpi_gbl_db_opt_stats);
-ACPI_GLOBAL(u8, acpi_gbl_db_opt_ini_methods);
+ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_ini_methods);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_region_support);
 ACPI_GLOBAL(u8, acpi_gbl_db_output_to_file);
 ACPI_GLOBAL(char *, acpi_gbl_db_buffer);
-- 
1.7.10

