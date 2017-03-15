From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 6/7] ACPICA: Tables: Add sanity check for static table load
Date: Wed, 15 Mar 2017 14:37:35 +0800
Message-ID: <97da7387f97478e3ffba5a7295aaadf3e095bcb2.1489558845.git.lv.zheng@intel.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:30757 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdCOGhk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 02:37:40 -0400
In-Reply-To: <cover.1489558845.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

This patch extends sanity check to static table load. Also enables
acpi_ut_is_aml_table() for Linux kernel. This patch achieves this by invoking
acpi_tb_load_table() instead of acpi_ns_load_table().

Some redundant code blocks are therefore reduced:
1. acpi_tb_validate_table() is replaced by acpi_get_table_by_index() invoked in
   acpi_tb_validate_table_for_load(), DSDT handling code is thus moved to this
   function as it must be invoked for validated tables;
2. MLC handling in both acpi_ns_load_table() and acpi_tb_load_table() can be
   combined into acpi_tb_load_table(), Reload parameter is added to
   acpi_tb_load_table() in order to distiguish different table loading stages
   to keep group MLC logics.
Reported by Hans de Goede, fixed by Lv Zheng.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/actables.h |  3 +-
 drivers/acpi/acpica/exconfig.c |  2 +-
 drivers/acpi/acpica/nsload.c   | 18 -----------
 drivers/acpi/acpica/tbdata.c   | 69 +++++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/tbxfload.c | 40 +++---------------------
 5 files changed, 63 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index db78af4..e478576 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -124,7 +124,8 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
 
 acpi_status
-acpi_tb_load_table(u32 *table_index, struct acpi_namespace_node *parent_node);
+acpi_tb_load_table(u32 *table_index,
+		   u8 reload, struct acpi_namespace_node *parent_node);
 
 acpi_status
 acpi_tb_install_and_load_table(acpi_physical_address address,
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index c82ea9b..a95c71d 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -197,7 +197,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	ACPI_INFO(("Dynamic OEM Table Load:"));
 	acpi_ex_exit_interpreter();
-	status = acpi_tb_load_table(&table_index, parent_node);
+	status = acpi_tb_load_table(&table_index, TRUE, parent_node);
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index d2915e1..1f3163a 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -144,24 +144,6 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "**** Completed Table Object Initialization\n"));
 
-	/*
-	 * Execute any module-level code that was detected during the table load
-	 * phase. Although illegal since ACPI 2.0, there are many machines that
-	 * contain this type of code. Each block of detected executable AML code
-	 * outside of any control method is wrapped with a temporary control
-	 * method object and placed on a global list. The methods on this list
-	 * are executed below.
-	 *
-	 * This case executes the module-level code for each table immediately
-	 * after the table has been loaded. This provides compatibility with
-	 * other ACPI implementations. Optionally, the execution can be deferred
-	 * until later, see acpi_initialize_objects.
-	 */
-	if (!acpi_gbl_parse_table_as_term_list
-	    && !acpi_gbl_group_module_level_code) {
-		acpi_ns_exec_module_code_list();
-	}
-
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1e1222d..180c7a3 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -843,6 +843,7 @@ acpi_tb_validate_table_for_load(u32 *table_index,
 	u32 i;
 	struct acpi_table_desc *table_desc;
 	acpi_status status = AE_OK;
+	struct acpi_table_header *new_dsdt;
 
 	/* Acquire the table lock */
 
@@ -859,6 +860,37 @@ acpi_tb_validate_table_for_load(u32 *table_index,
 		goto unlock_and_exit;
 	}
 
+	if (*table_index == acpi_gbl_dsdt_index) {
+		/*
+		 * Save the DSDT pointer for simple access. This is the mapped memory
+		 * address. We must take care here because the address of the .Tables
+		 * array can change dynamically as tables are loaded at run-time.
+		 * Note: .Pointer field is not validated until after call to
+		 * acpi_get_table_by_index().
+		 */
+		acpi_gbl_DSDT = table_desc->pointer;
+
+		/*
+		 * Optionally copy the entire DSDT to local memory (instead of simply
+		 * mapping it.) There are some BIOSs that corrupt or replace the
+		 * original DSDT, creating the need for this option. Default is FALSE,
+		 * do not copy the DSDT.
+		 */
+		if (acpi_gbl_copy_dsdt_locally) {
+			new_dsdt = acpi_tb_copy_dsdt(acpi_gbl_dsdt_index);
+			if (new_dsdt) {
+				acpi_gbl_DSDT = new_dsdt;
+			}
+		}
+
+		/*
+		 * Save the original DSDT header for detection of table corruption
+		 * and/or replacement of the DSDT from outside the OS.
+		 */
+		memcpy(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT,
+		       sizeof(struct acpi_table_header));
+	}
+
 	/* Validate the incoming table signature */
 
 	if (!acpi_ut_is_aml_table(table_desc->signature.ascii)) {
@@ -920,6 +952,7 @@ acpi_tb_validate_table_for_load(u32 *table_index,
  * FUNCTION:    acpi_tb_load_table
  *
  * PARAMETERS:  table_index             - Table index
+ *              reload                  - Whether reload should be performed
  *              parent_node             - Where table index is returned
  *
  * RETURN:      Status
@@ -929,7 +962,8 @@ acpi_tb_validate_table_for_load(u32 *table_index,
  ******************************************************************************/
 
 acpi_status
-acpi_tb_load_table(u32 *table_index, struct acpi_namespace_node *parent_node)
+acpi_tb_load_table(u32 *table_index,
+		   u8 reload, struct acpi_namespace_node *parent_node)
 {
 	struct acpi_table_header *table;
 	acpi_status status;
@@ -953,21 +987,28 @@ acpi_tb_load_table(u32 *table_index, struct acpi_namespace_node *parent_node)
 
 	status = acpi_ns_load_table(*table_index, parent_node);
 
-	/* Execute any module-level code that was found in the table */
-
-	if (!acpi_gbl_parse_table_as_term_list
-	    && acpi_gbl_group_module_level_code) {
+	/*
+	 * Execute any module-level code that was found in the table. This only
+	 * applies when new grammar support is not set (as MLC are executed in
+	 * place) and dynamic table loading. For static table loading, executes
+	 * MLC here if group module level code is not set, otherwise, it is
+	 * executed in acpi_initialize_objects().
+	 */
+	if (!acpi_gbl_parse_table_as_term_list &&
+	    (reload || !acpi_gbl_group_module_level_code)) {
 		acpi_ns_exec_module_code_list();
 	}
 
-	/*
-	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
-	 * responsible for discovering any new wake GPEs by running _PRW methods
-	 * that may have been loaded by this table.
-	 */
-	status = acpi_tb_get_owner_id(*table_index, &owner_id);
-	if (ACPI_SUCCESS(status)) {
-		acpi_ev_update_gpes(owner_id);
+	if (reload) {
+		/*
+		 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host
+		 * is responsible for discovering any new wake GPEs by running _PRW
+		 * methods that may have been loaded by this table.
+		 */
+		status = acpi_tb_get_owner_id(*table_index, &owner_id);
+		if (ACPI_SUCCESS(status)) {
+			acpi_ev_update_gpes(owner_id);
+		}
 	}
 
 	/* Invoke table handler */
@@ -1008,7 +1049,7 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 		goto exit;
 	}
 
-	status = acpi_tb_load_table(&i, acpi_gbl_root_node);
+	status = acpi_tb_load_table(&i, TRUE, acpi_gbl_root_node);
 
 exit:
 	*table_index = i;
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 9753176..76f4c1b 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -139,7 +139,6 @@ acpi_status acpi_tb_load_namespace(void)
 {
 	acpi_status status;
 	u32 i;
-	struct acpi_table_header *new_dsdt;
 	struct acpi_table_desc *table;
 	u32 tables_loaded = 0;
 	u32 tables_failed = 0;
@@ -155,44 +154,16 @@ acpi_status acpi_tb_load_namespace(void)
 	table = &acpi_gbl_root_table_list.tables[acpi_gbl_dsdt_index];
 
 	if (!acpi_gbl_root_table_list.current_table_count ||
-	    !ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_DSDT) ||
-	    ACPI_FAILURE(acpi_tb_validate_table(table))) {
+	    !ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_DSDT)) {
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
 
-	/*
-	 * Save the DSDT pointer for simple access. This is the mapped memory
-	 * address. We must take care here because the address of the .Tables
-	 * array can change dynamically as tables are loaded at run-time. Note:
-	 * .Pointer field is not validated until after call to acpi_tb_validate_table.
-	 */
-	acpi_gbl_DSDT = table->pointer;
-
-	/*
-	 * Optionally copy the entire DSDT to local memory (instead of simply
-	 * mapping it.) There are some BIOSs that corrupt or replace the original
-	 * DSDT, creating the need for this option. Default is FALSE, do not copy
-	 * the DSDT.
-	 */
-	if (acpi_gbl_copy_dsdt_locally) {
-		new_dsdt = acpi_tb_copy_dsdt(acpi_gbl_dsdt_index);
-		if (new_dsdt) {
-			acpi_gbl_DSDT = new_dsdt;
-		}
-	}
-
-	/*
-	 * Save the original DSDT header for detection of table corruption
-	 * and/or replacement of the DSDT from outside the OS.
-	 */
-	memcpy(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT,
-	       sizeof(struct acpi_table_header));
-
 	/* Load and parse tables */
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-	status = acpi_ns_load_table(acpi_gbl_dsdt_index, acpi_gbl_root_node);
+	status =
+	    acpi_tb_load_table(&acpi_gbl_dsdt_index, FALSE, acpi_gbl_root_node);
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "[DSDT] table load failed"));
@@ -207,15 +178,14 @@ acpi_status acpi_tb_load_namespace(void)
 		table = &acpi_gbl_root_table_list.tables[i];
 
 		if (!table->address || i == acpi_gbl_dsdt_index ||
-		    !acpi_ut_is_aml_table(table->signature.ascii) ||
-		    ACPI_FAILURE(acpi_tb_validate_table(table))) {
+		    !acpi_ut_is_aml_table(table->signature.ascii)) {
 			continue;
 		}
 
 		/* Ignore errors while loading tables, get as many as possible */
 
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-		status = acpi_ns_load_table(i, acpi_gbl_root_node);
+		status = acpi_tb_load_table(&i, FALSE, acpi_gbl_root_node);
 		(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-- 
2.7.4

