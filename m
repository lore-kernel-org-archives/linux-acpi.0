From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/9] ACPICA: Export acpi_tb_validate_rsdp().
Date: Thu,  8 Aug 2013 15:29:22 +0800
Message-ID: <48bd056f48568711e77a842c40325f94febae928.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54182 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab3HHH3g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:29:36 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This patch exports acpi_tb_validate_rsdp(), so that code duplication in
some ACPICA utilities can be reduced.
This patch also includes lint changes.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |    2 ++
 drivers/acpi/acpica/tbxfroot.c |    8 ++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 917315e..c54f42c 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -49,6 +49,8 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count);
 /*
  * tbxfroot - Root pointer utilities
  */
+acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp);
+
 u8 *acpi_tb_scan_memory_for_rsdp(u8 *start_address, u32 length);
 
 /*
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index e76ed0f..948c95e 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -48,9 +48,6 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbxfroot")
 
-/* Local prototypes */
-static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_validate_rsdp
@@ -62,8 +59,7 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp);
  * DESCRIPTION: Validate the RSDP (ptr)
  *
  ******************************************************************************/
-
-static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
+acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 {
 
 	/*
@@ -72,7 +68,7 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 	 * Note: Sometimes there exists more than one RSDP in memory; the valid
 	 * RSDP has a valid checksum, all others have an invalid checksum.
 	 */
-	if (ACPI_STRNCMP((char *)rsdp, ACPI_SIG_RSDP,
+	if (ACPI_STRNCMP((char *)rsdp->signature, ACPI_SIG_RSDP,
 			 sizeof(ACPI_SIG_RSDP) - 1) != 0) {
 
 		/* Nope, BAD Signature */
-- 
1.7.10

