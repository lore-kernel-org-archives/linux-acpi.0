From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/6] ACPICA: TableManager: Export acpi_tb_scan_memory_for_rsdp()
Date: Wed, 17 Jul 2013 09:48:27 +0800
Message-ID: <a602567ec92215598c764a89703fe2c1ea2a45a7.1374025121.git.lv.zheng@intel.com>
References: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40469 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab3GQBsk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:48:40 -0400
In-Reply-To: <cover.1374025121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This patch exports this function to be used by other ACPICA utilities.
Chao Guan, Bob Moore.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/actables.h |    5 +++++
 drivers/acpi/acpica/tbxfroot.c |    4 +---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 7755e91..917315e 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -47,6 +47,11 @@
 acpi_status acpi_allocate_root_table(u32 initial_table_count);
 
 /*
+ * tbxfroot - Root pointer utilities
+ */
+u8 *acpi_tb_scan_memory_for_rsdp(u8 *start_address, u32 length);
+
+/*
  * tbfadt - FADT parse/convert/validate
  */
 void acpi_tb_parse_fadt(u32 table_index);
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 7c2ecfb..e76ed0f 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -49,8 +49,6 @@
 ACPI_MODULE_NAME("tbxfroot")
 
 /* Local prototypes */
-static u8 *acpi_tb_scan_memory_for_rsdp(u8 * start_address, u32 length);
-
 static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp);
 
 /*******************************************************************************
@@ -231,7 +229,7 @@ acpi_status acpi_find_root_pointer(acpi_size *table_address)
  * DESCRIPTION: Search a block of memory for the RSDP signature
  *
  ******************************************************************************/
-static u8 *acpi_tb_scan_memory_for_rsdp(u8 * start_address, u32 length)
+u8 *acpi_tb_scan_memory_for_rsdp(u8 *start_address, u32 length)
 {
 	acpi_status status;
 	u8 *mem_rover;
-- 
1.7.10

