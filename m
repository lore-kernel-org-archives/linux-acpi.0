From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Tables: Fix FADT dependency regression
Date: Wed, 14 Oct 2015 13:53:57 +0800
Message-ID: <418f30545e189dc5bf3c033979af04f0772a1e27.1444802010.git.lv.zheng@intel.com>
References: <alpine.LRH.2.20.1510010927010.10113@math.ut.ee>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1510010927010.10113@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Some logics actually relying on the existence of FADT, currently relies on
the number of loaded tables. This false dependency can easily trigger
regressions. The reported regression can be seen on the following commit:
  Commit: 8ec3f459073e67e5c6d78507dec693064b3040a2
  Subject: ACPICA: Tables: Fix global table list issues by removing fixed table
The commit changing the fixed table indexes results in the change of FADT
table index, originally, it was 3 (thus the installed table count should be
greater than 4), while currently it is 0 (and the installed table count may
be 3).

This patch fixes this regression by cleaning up the code. Lv Zheng.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=105351
Reported-and-tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/actables.h |    4 +---
 drivers/acpi/acpica/evxfevnt.c |    2 +-
 drivers/acpi/acpica/tbfadt.c   |   10 +++++-----
 drivers/acpi/acpica/tbutils.c  |   26 ++------------------------
 5 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 09f37b5..4dde37c 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -61,6 +61,7 @@ ACPI_GLOBAL(struct acpi_table_header, acpi_gbl_original_dsdt_header);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX);
+ACPI_INIT_GLOBAL(u32, acpi_gbl_fadt_index, ACPI_INVALID_TABLE_INDEX);
 
 #if (!ACPI_REDUCED_HARDWARE)
 ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index f7731f2..591ea95 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -85,7 +85,7 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded);
 /*
  * tbfadt - FADT parse/convert/validate
  */
-void acpi_tb_parse_fadt(u32 table_index);
+void acpi_tb_parse_fadt(void);
 
 void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
 
@@ -138,8 +138,6 @@ acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id);
  */
 acpi_status acpi_tb_initialize_facs(void);
 
-u8 acpi_tb_tables_loaded(void);
-
 void
 acpi_tb_print_table_header(acpi_physical_address address,
 			   struct acpi_table_header *header);
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index faad911..10ce48e 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -71,7 +71,7 @@ acpi_status acpi_enable(void)
 
 	/* ACPI tables must be present */
 
-	if (!acpi_tb_tables_loaded()) {
+	if (acpi_gbl_fadt_index == ACPI_INVALID_TABLE_INDEX) {
 		return_ACPI_STATUS(AE_NO_ACPI_TABLES);
 	}
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 455a070..a6454f4 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -298,7 +298,7 @@ acpi_tb_select_address(char *register_name, u32 address32, u64 address64)
  *
  * FUNCTION:    acpi_tb_parse_fadt
  *
- * PARAMETERS:  table_index         - Index for the FADT
+ * PARAMETERS:  None
  *
  * RETURN:      None
  *
@@ -307,7 +307,7 @@ acpi_tb_select_address(char *register_name, u32 address32, u64 address64)
  *
  ******************************************************************************/
 
-void acpi_tb_parse_fadt(u32 table_index)
+void acpi_tb_parse_fadt(void)
 {
 	u32 length;
 	struct acpi_table_header *table;
@@ -319,11 +319,11 @@ void acpi_tb_parse_fadt(u32 table_index)
 	 * Get a local copy of the FADT and convert it to a common format
 	 * Map entire FADT, assumed to be smaller than one page.
 	 */
-	length = acpi_gbl_root_table_list.tables[table_index].length;
+	length = acpi_gbl_root_table_list.tables[acpi_gbl_fadt_index].length;
 
 	table =
-	    acpi_os_map_memory(acpi_gbl_root_table_list.tables[table_index].
-			       address, length);
+	    acpi_os_map_memory(acpi_gbl_root_table_list.
+			       tables[acpi_gbl_fadt_index].address, length);
 	if (!table) {
 		return;
 	}
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 4337990..d8ddef3 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -99,29 +99,6 @@ acpi_status acpi_tb_initialize_facs(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_tables_loaded
- *
- * PARAMETERS:  None
- *
- * RETURN:      TRUE if required ACPI tables are loaded
- *
- * DESCRIPTION: Determine if the minimum required ACPI tables are present
- *              (FADT, FACS, DSDT)
- *
- ******************************************************************************/
-
-u8 acpi_tb_tables_loaded(void)
-{
-
-	if (acpi_gbl_root_table_list.current_table_count >= 4) {
-		return (TRUE);
-	}
-
-	return (FALSE);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_check_dsdt_header
  *
  * PARAMETERS:  None
@@ -392,7 +369,8 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 		    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
 				      tables[table_index].signature,
 				      ACPI_SIG_FADT)) {
-			acpi_tb_parse_fadt(table_index);
+			acpi_gbl_fadt_index = table_index;
+			acpi_tb_parse_fadt();
 		}
 
 next_table:
-- 
1.7.10
