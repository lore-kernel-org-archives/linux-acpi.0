From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/16] ACPICA: Tables: Add deferred table verification support
Date: Mon, 10 Jul 2017 15:23:56 +0800
Message-ID: <1e793361d8f64519683456064e9474ca6c51952c.1499671182.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:52522 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdGJHYJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:24:09 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 2dd6c151d5d5e76dacba8f7db9e259fc72982d17
ACPICA commit ffddee6638aced83be18b8bc88569586c1a43e03

This patch allows tables not verified in early stage verfied in
acpi_reallocate_root_table(). This is useful for OSPMs like linux where tables
cannot be verified in early stage due to early ioremp limitations on some
architectures. Reported by Hans de Geode, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/2dd6c151
Link: https://github.com/acpica/acpica/commit/ffddee66
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbdata.c  | 34 ++++++++++++++++++++++++++++------
 drivers/acpi/acpica/tbxface.c | 27 ++++++++++++++++++++++-----
 include/acpi/actbl.h          |  1 +
 3 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 577361b..b19a2f0 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -432,6 +432,15 @@ acpi_tb_check_duplication(struct acpi_table_desc *table_desc, u32 *table_index)
 	/* Check if table is already registered */
 
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+
+		/* Do not compare with unverified tables */
+
+		if (!
+		    (acpi_gbl_root_table_list.tables[i].
+		     flags & ACPI_TABLE_IS_VERIFIED)) {
+			continue;
+		}
+
 		/*
 		 * Check for a table match on the entire table length,
 		 * not just the header.
@@ -483,6 +492,8 @@ acpi_tb_check_duplication(struct acpi_table_desc *table_desc, u32 *table_index)
  *
  * DESCRIPTION: This function is called to validate and verify the table, the
  *              returned table descriptor is in "VALIDATED" state.
+ *              Note that 'TableIndex' is required to be set to !NULL to
+ *              enable duplication check.
  *
  *****************************************************************************/
 
@@ -554,6 +565,8 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc,
 				goto invalidate_and_exit;
 			}
 		}
+
+		table_desc->flags |= ACPI_TABLE_IS_VERIFIED;
 	}
 
 	return_ACPI_STATUS(status);
@@ -579,6 +592,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 {
 	struct acpi_table_desc *tables;
 	u32 table_count;
+	u32 current_table_count, max_table_count;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(tb_resize_root_table_list);
 
@@ -598,8 +613,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 		table_count = acpi_gbl_root_table_list.current_table_count;
 	}
 
-	tables = ACPI_ALLOCATE_ZEROED(((acpi_size)table_count +
-				       ACPI_ROOT_TABLE_SIZE_INCREMENT) *
+	max_table_count = table_count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	tables = ACPI_ALLOCATE_ZEROED(((acpi_size)max_table_count) *
 				      sizeof(struct acpi_table_desc));
 	if (!tables) {
 		ACPI_ERROR((AE_INFO,
@@ -609,9 +624,16 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 	/* Copy and free the previous table array */
 
+	current_table_count = 0;
 	if (acpi_gbl_root_table_list.tables) {
-		memcpy(tables, acpi_gbl_root_table_list.tables,
-		       (acpi_size)table_count * sizeof(struct acpi_table_desc));
+		for (i = 0; i < table_count; i++) {
+			if (acpi_gbl_root_table_list.tables[i].address) {
+				memcpy(tables + current_table_count,
+				       acpi_gbl_root_table_list.tables + i,
+				       sizeof(struct acpi_table_desc));
+				current_table_count++;
+			}
+		}
 
 		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 			ACPI_FREE(acpi_gbl_root_table_list.tables);
@@ -619,8 +641,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 	}
 
 	acpi_gbl_root_table_list.tables = tables;
-	acpi_gbl_root_table_list.max_table_count =
-	    table_count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	acpi_gbl_root_table_list.max_table_count = max_table_count;
+	acpi_gbl_root_table_list.current_table_count = current_table_count;
 	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ORIGIN_ALLOCATED;
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 38c0104..26ad596 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -167,7 +167,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
 acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 {
 	acpi_status status;
-	u32 i;
+	struct acpi_table_desc *table_desc;
+	u32 i, j;
 
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
@@ -179,6 +180,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
 	/*
 	 * Ensure OS early boot logic, which is required by some hosts. If the
 	 * table state is reported to be wrong, developers should fix the
@@ -186,11 +189,11 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 	 * early stage.
 	 */
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
-		if (acpi_gbl_root_table_list.tables[i].pointer) {
+		table_desc = &acpi_gbl_root_table_list.tables[i];
+		if (table_desc->pointer) {
 			ACPI_ERROR((AE_INFO,
 				    "Table [%4.4s] is not invalidated during early boot stage",
-				    acpi_gbl_root_table_list.tables[i].
-				    signature.ascii));
+				    table_desc->signature.ascii));
 		}
 	}
 
@@ -200,11 +203,25 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 		 * table initilization here once the flag is set.
 		 */
 		acpi_gbl_enable_table_validation = TRUE;
+		for (i = 0; i < acpi_gbl_root_table_list.current_table_count;
+		     ++i) {
+			table_desc = &acpi_gbl_root_table_list.tables[i];
+			if (!(table_desc->flags & ACPI_TABLE_IS_VERIFIED)) {
+				status =
+				    acpi_tb_verify_temp_table(table_desc, NULL,
+							      &j);
+				if (ACPI_FAILURE(status)) {
+					acpi_tb_uninstall_table(table_desc);
+				}
+			}
+		}
 	}
 
 	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ALLOW_RESIZE;
-
 	status = acpi_tb_resize_root_table_list();
+	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ORIGIN_ALLOCATED;
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index bdc55c0..89509b8 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -394,6 +394,7 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (1)	/* Physical address, internally mapped */
 #define ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL  (2)	/* Virtual address, internallly allocated */
 #define ACPI_TABLE_ORIGIN_MASK              (3)
+#define ACPI_TABLE_IS_VERIFIED              (4)
 #define ACPI_TABLE_IS_LOADED                (8)
 
 /*
-- 
2.7.4

