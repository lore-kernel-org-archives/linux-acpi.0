From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 4/8] ACPICA: Tables: Cleanup acpi_tb_copy_dsdt()
Date: Thu, 24 Mar 2016 16:30:50 +0800
Message-ID: <02604efe12bccfdebcc159ce0110b1ad39795694.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24994 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCXIax (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:30:53 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch cleans up acpi_tb_copy_dsdt(), removing a useless parameter.
No functional change. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |    2 +-
 drivers/acpi/acpica/tbutils.c  |    9 ++++-----
 drivers/acpi/acpica/tbxfload.c |    2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 9310cb4..6f08c9c 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -149,7 +149,7 @@ acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
 void acpi_tb_check_dsdt_header(void);
 
-struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
+struct acpi_table_header *acpi_tb_copy_dsdt(void);
 
 void
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index b64fbe3..ec6ce69 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -141,7 +141,7 @@ void acpi_tb_check_dsdt_header(void)
  *
  * FUNCTION:    acpi_tb_copy_dsdt
  *
- * PARAMETERS:  table_desc          - Installed table to copy
+ * PARAMETERS:  None
  *
  * RETURN:      None
  *
@@ -151,12 +151,12 @@ void acpi_tb_check_dsdt_header(void)
  *
  ******************************************************************************/
 
-struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
+struct acpi_table_header *acpi_tb_copy_dsdt(void)
 {
 	struct acpi_table_header *new_table;
 	struct acpi_table_desc *table_desc;
 
-	table_desc = &acpi_gbl_root_table_list.tables[table_index];
+	table_desc = &acpi_gbl_root_table_list.tables[acpi_gbl_dsdt_index];
 
 	new_table = ACPI_ALLOCATE(table_desc->length);
 	if (!new_table) {
@@ -168,8 +168,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 	memcpy(new_table, table_desc->pointer, table_desc->length);
 	acpi_tb_uninstall_table(table_desc);
 
-	acpi_tb_init_table_descriptor(&acpi_gbl_root_table_list.
-				      tables[acpi_gbl_dsdt_index],
+	acpi_tb_init_table_descriptor(table_desc,
 				      ACPI_PTR_TO_PHYSADDR(new_table),
 				      ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
 				      new_table);
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index ac71abc..9d3cf30 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -175,7 +175,7 @@ acpi_status acpi_tb_load_namespace(void)
 	 * the DSDT.
 	 */
 	if (acpi_gbl_copy_dsdt_locally) {
-		new_dsdt = acpi_tb_copy_dsdt(acpi_gbl_dsdt_index);
+		new_dsdt = acpi_tb_copy_dsdt();
 		if (new_dsdt) {
 			acpi_gbl_DSDT = new_dsdt;
 		}
-- 
1.7.10

