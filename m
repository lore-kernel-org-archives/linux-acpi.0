From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/8] ACPI: acpi_tb_parse_fadt supports inactive tables
Date: Fri, 19 Dec 2008 15:57:46 +0800
Message-ID: <1229673466.562.136.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60600 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752949AbYLSH7O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

support parsing inactive fadt table in acpi_tb_parse_fadt.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbfadt.c |   59 +++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/acpi/tables/tbfadt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbfadt.c
+++ linux-2.6/drivers/acpi/tables/tbfadt.c
@@ -159,6 +159,9 @@ void acpi_tb_parse_fadt(u32 table_index,
 {
 	u32 length;
 	struct acpi_table_header *table;
+	struct acpi_table_fadt *fadt;
+	acpi_physical_address dsdt_address, facs_address, facs2_address;
+	struct acpi_internal_rsdt *root_table_list = get_root_table_list(flags);
 	acpi_status status;
 
 	/*
@@ -168,10 +171,10 @@ void acpi_tb_parse_fadt(u32 table_index,
 	 * Get a local copy of the FADT and convert it to a common format
 	 * Map entire FADT, assumed to be smaller than one page.
 	 */
-	length = acpi_gbl_root_table_list.tables[table_index].length;
+	length = root_table_list->tables[table_index].length;
 
 	table =
-	    acpi_os_map_memory(acpi_gbl_root_table_list.tables[table_index].
+	    acpi_os_map_memory(root_table_list->tables[table_index].
 			       address, length);
 	if (!table) {
 		return;
@@ -183,37 +186,55 @@ void acpi_tb_parse_fadt(u32 table_index,
 	 */
 	(void)acpi_tb_verify_checksum(table, length);
 
-	/* Obtain a local copy of the FADT in common ACPI 2.0+ format */
-
-	acpi_tb_create_local_fadt(table, length);
+	if (TABLE_IS_ACTIVE(flags)) {
+		/* Obtain a local copy of the FADT in common ACPI 2.0+ format */
+		acpi_tb_create_local_fadt(table, length);
+		fadt = &acpi_gbl_FADT;
+		dsdt_address = (acpi_physical_address) acpi_gbl_FADT.Xdsdt;
+		facs_address = (acpi_physical_address) acpi_gbl_FADT.Xfacs;
+		facs2_address = (acpi_physical_address) acpi_gbl_FADT.facs;
+	} else {
+		fadt = (struct acpi_table_fadt *)table;
+		if (fadt->header.length == sizeof(struct acpi_table_fadt)) {
+			dsdt_address = (acpi_physical_address) fadt->Xdsdt;
+			facs_address = (acpi_physical_address) fadt->Xfacs;
+			facs2_address = (acpi_physical_address) fadt->facs;
+		} else {
+			dsdt_address = (acpi_physical_address) fadt->dsdt;
+			facs_address = (acpi_physical_address) fadt->facs;
+			facs2_address = 0;
+		}
+	}
 
 	/* All done with the real FADT, unmap it */
-
 	acpi_os_unmap_memory(table, length);
 
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
-			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
+	acpi_tb_install_table(dsdt_address, flags, ACPI_SIG_DSDT,
+						ACPI_TABLE_INDEX_DSDT);
 
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
-			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
+	acpi_tb_install_table(facs_address, flags, ACPI_SIG_FACS,
+						ACPI_TABLE_INDEX_FACS);
 
 	/*
-	 * install the acpi_gbl_FADT.facs if it's not null
-	 * and it's different from acpi_gbl_FADT.Xfacs
+	 * install the 32 bit Facs if it's not null
+	 * and it's different from 64 bit Facs table
 	 */
-	if (!acpi_gbl_FADT.facs || acpi_gbl_FADT.facs == acpi_gbl_FADT.Xfacs)
+	if (!facs2_address || facs2_address == facs_address)
 		return;
 
-	if (acpi_gbl_root_table_list.count >= acpi_gbl_root_table_list.size) {
-		status = acpi_tb_resize_root_table_list();
-		if (ACPI_FAILURE(status))
+	if (root_table_list->count >= root_table_list->size) {
+		if (TABLE_IS_ACTIVE(flags)) {
+			status = acpi_tb_resize_root_table_list();
+			if (ACPI_FAILURE(status))
+				return;
+		} else
 			return;
 	}
-	acpi_tb_install_table((acpi_physical_address)acpi_gbl_FADT.facs, flags,
-				ACPI_SIG_FACS, acpi_gbl_root_table_list.count);
-	acpi_gbl_root_table_list.count++;
+	acpi_tb_install_table(facs2_address, flags, ACPI_SIG_FACS,
+				root_table_list->count);
+	root_table_list->count++;
 }
 
 /*******************************************************************************


