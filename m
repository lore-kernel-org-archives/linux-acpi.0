From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/8] ACPI: acpi_tb_install_table supports inactive tables
Date: Fri, 19 Dec 2008 15:57:44 +0800
Message-ID: <1229673464.562.135.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20490 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbYLSH7L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

acpi_tb_install_table supports inactive tables.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbutils.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbutils.c
+++ linux-2.6/drivers/acpi/tables/tbutils.c
@@ -295,6 +295,8 @@ acpi_tb_install_table(acpi_physical_addr
 		      u8 flags, char *signature, u32 table_index)
 {
 	struct acpi_table_header *table;
+	struct acpi_internal_rsdt *root_table_list =
+						get_root_table_list(flags);
 
 	if (!address) {
 		ACPI_ERROR((AE_INFO,
@@ -321,15 +323,16 @@ acpi_tb_install_table(acpi_physical_addr
 
 	/* Initialize the table entry */
 
-	acpi_gbl_root_table_list.tables[table_index].address = address;
-	acpi_gbl_root_table_list.tables[table_index].length = table->length;
-	acpi_gbl_root_table_list.tables[table_index].flags = flags;
+	root_table_list->tables[table_index].address = address;
+	root_table_list->tables[table_index].length = table->length;
+	root_table_list->tables[table_index].flags = flags;
 
 	ACPI_MOVE_32_TO_32(&
-			   (acpi_gbl_root_table_list.tables[table_index].
+			   (root_table_list->tables[table_index].
 			    signature), table->signature);
 
-	acpi_tb_print_table_header(address, table);
+	if (TABLE_IS_ACTIVE(flags))
+		acpi_tb_print_table_header(address, table);
 
 	if (table_index == ACPI_TABLE_INDEX_DSDT) {
 


