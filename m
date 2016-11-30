From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/11] ACPICA: Tables: Allow FADT to be customized with virtual address
Date: Wed, 30 Nov 2016 15:21:49 +0800
Message-ID: <b08910f2bb009b36eee1b5a86c8c265a86c153b2.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:55949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756953AbcK3HV5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:21:57 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit d98de9ca14891130efc5dcdc871b97eb27b4b0f5

FADT parsing code requires FADT to be installed as
ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL, using new
acpi_tb_get_table()/acpi_tb_put_table(), other address types can also be allowed,
thus facilitates FADT customization with virtual address. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/d98de9ca
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 5fb838e..81473a4 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -311,6 +311,8 @@ void acpi_tb_parse_fadt(void)
 {
 	u32 length;
 	struct acpi_table_header *table;
+	struct acpi_table_desc *fadt_desc;
+	acpi_status status;
 
 	/*
 	 * The FADT has multiple versions with different lengths,
@@ -319,14 +321,12 @@ void acpi_tb_parse_fadt(void)
 	 * Get a local copy of the FADT and convert it to a common format
 	 * Map entire FADT, assumed to be smaller than one page.
 	 */
-	length = acpi_gbl_root_table_list.tables[acpi_gbl_fadt_index].length;
-
-	table =
-	    acpi_os_map_memory(acpi_gbl_root_table_list.
-			       tables[acpi_gbl_fadt_index].address, length);
-	if (!table) {
+	fadt_desc = &acpi_gbl_root_table_list.tables[acpi_gbl_fadt_index];
+	status = acpi_tb_get_table(fadt_desc, &table);
+	if (ACPI_FAILURE(status)) {
 		return;
 	}
+	length = fadt_desc->length;
 
 	/*
 	 * Validate the FADT checksum before we copy the table. Ignore
@@ -340,7 +340,7 @@ void acpi_tb_parse_fadt(void)
 
 	/* All done with the real FADT, unmap it */
 
-	acpi_os_unmap_memory(table, length);
+	acpi_tb_put_table(fadt_desc);
 
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
-- 
1.7.10

