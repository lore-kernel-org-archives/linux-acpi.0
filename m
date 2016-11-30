From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/11] ACPICA: Tables: Cleanup acpi_tb_install_and_load_table()
Date: Wed, 30 Nov 2016 15:21:19 +0800
Message-ID: <95c9d9326e34c9b498ee698cf410739b2f4401d5.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15732 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756508AbcK3HVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:21:47 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 7fdac0289faa1c28b91413c8e394e87372aa69e6

acpi_tb_install_and_load_table() can invoke acpi_tb_load_table() to eliminate
redundant code.

No functional change. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/7fdac028
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |    3 +--
 drivers/acpi/acpica/exconfig.c |    7 +++----
 drivers/acpi/acpica/tbdata.c   |   45 +++++-----------------------------------
 drivers/acpi/acpica/tbxfload.c |    7 +++----
 4 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index e85953b..1850005 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -127,8 +127,7 @@
 acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node);
 
 acpi_status
-acpi_tb_install_and_load_table(struct acpi_table_header *table,
-			       acpi_physical_address address,
+acpi_tb_install_and_load_table(acpi_physical_address address,
 			       u8 flags, u8 override, u32 *table_index);
 
 void acpi_tb_terminate(void);
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 718428b..8b8d620 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -437,10 +437,9 @@
 
 	ACPI_INFO(("Dynamic OEM Table Load:"));
 	acpi_ex_exit_interpreter();
-	status =
-	    acpi_tb_install_and_load_table(table, ACPI_PTR_TO_PHYSADDR(table),
-					   ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
-					   TRUE, &table_index);
+	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
+						ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
+						TRUE, &table_index);
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index d9ca8c2..4cbfa30 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -832,9 +832,9 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
  *
  * FUNCTION:    acpi_tb_install_and_load_table
  *
- * PARAMETERS:  table                   - Pointer to the table
- *              address                 - Physical address of the table
+ * PARAMETERS:  address                 - Physical address of the table
  *              flags                   - Allocation flags of the table
+ *              override                - Whether override should be performed
  *              table_index             - Where table index is returned
  *
  * RETURN:      Status
@@ -844,15 +844,13 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
  ******************************************************************************/
 
 acpi_status
-acpi_tb_install_and_load_table(struct acpi_table_header *table,
-			       acpi_physical_address address,
+acpi_tb_install_and_load_table(acpi_physical_address address,
 			       u8 flags, u8 override, u32 *table_index)
 {
 	acpi_status status;
 	u32 i;
-	acpi_owner_id owner_id;
 
-	ACPI_FUNCTION_TRACE(acpi_load_table);
+	ACPI_FUNCTION_TRACE(tb_install_and_load_table);
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
@@ -864,41 +862,8 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
 		goto unlock_and_exit;
 	}
 
-	/*
-	 * Note: Now table is "INSTALLED", it must be validated before
-	 * using.
-	 */
-	status = acpi_tb_validate_table(&acpi_gbl_root_table_list.tables[i]);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
-
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-	status = acpi_ns_load_table(i, acpi_gbl_root_node);
-
-	/* Execute any module-level code that was found in the table */
-
-	if (!acpi_gbl_parse_table_as_term_list
-	    && acpi_gbl_group_module_level_code) {
-		acpi_ns_exec_module_code_list();
-	}
-
-	/*
-	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
-	 * responsible for discovering any new wake GPEs by running _PRW methods
-	 * that may have been loaded by this table.
-	 */
-	status = acpi_tb_get_owner_id(i, &owner_id);
-	if (ACPI_SUCCESS(status)) {
-		acpi_ev_update_gpes(owner_id);
-	}
-
-	/* Invoke table handler if present */
-
-	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
-					     acpi_gbl_table_handler_context);
-	}
+	status = acpi_tb_load_table(i, acpi_gbl_root_node);
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 unlock_and_exit:
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 2599e831..77de33b 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -330,10 +330,9 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	/* Install the table and load it into the namespace */
 
 	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
-	status =
-	    acpi_tb_install_and_load_table(table, ACPI_PTR_TO_PHYSADDR(table),
-					   ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
-					   FALSE, &table_index);
+	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
+						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
+						FALSE, &table_index);
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.10

