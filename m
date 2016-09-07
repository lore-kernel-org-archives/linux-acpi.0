From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/14] ACPICA: Tables: Tune table mutex to be a leaf lock
Date: Wed,  7 Sep 2016 14:07:24 +0800
Message-ID: <de7a9c83f9d8499eba3686982a07fef40783bcfc.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25393 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbcIGGHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:07:35 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit f564d57c6501b97a2871f0b4c048e79910f71783

This patch tunes MTX_TABLES into a leaf lock by always ensuring it is
released before holding other locks.

This patch also collects all table loading related functions into
acpi_tb_load_table() (invoked by load_table opcode) and
acpi_tb_install_and_load_table() (invoked by Load opcode and acpi_load_table()) so
that we can have lock tuning code collected at the boundary of these 2
functions. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/f564d57c
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Dutch Guy <lucht_piloot@gmx.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |    8 +++
 drivers/acpi/acpica/exconfig.c |  105 ++++++------------------------
 drivers/acpi/acpica/tbdata.c   |  140 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbfind.c   |   10 ++-
 drivers/acpi/acpica/tbxfload.c |   50 ++------------
 5 files changed, 182 insertions(+), 131 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 9469cd4..e85953b 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -123,6 +123,14 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
 
+acpi_status
+acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node);
+
+acpi_status
+acpi_tb_install_and_load_table(struct acpi_table_header *table,
+			       acpi_physical_address address,
+			       u8 flags, u8 override, u32 *table_index);
+
 void acpi_tb_terminate(void);
 
 acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index);
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 578d5c8..421836a 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -55,9 +55,7 @@ ACPI_MODULE_NAME("exconfig")
 
 /* Local prototypes */
 static acpi_status
-acpi_ex_add_table(u32 table_index,
-		  struct acpi_namespace_node *parent_node,
-		  union acpi_operand_object **ddb_handle);
+acpi_ex_add_table(u32 table_index, union acpi_operand_object **ddb_handle);
 
 static acpi_status
 acpi_ex_region_read(union acpi_operand_object *obj_desc,
@@ -79,13 +77,9 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc,
  ******************************************************************************/
 
 static acpi_status
-acpi_ex_add_table(u32 table_index,
-		  struct acpi_namespace_node *parent_node,
-		  union acpi_operand_object **ddb_handle)
+acpi_ex_add_table(u32 table_index, union acpi_operand_object **ddb_handle)
 {
 	union acpi_operand_object *obj_desc;
-	acpi_status status;
-	acpi_owner_id owner_id;
 
 	ACPI_FUNCTION_TRACE(ex_add_table);
 
@@ -100,40 +94,8 @@ acpi_ex_add_table(u32 table_index,
 
 	obj_desc->common.flags |= AOPOBJ_DATA_VALID;
 	obj_desc->reference.class = ACPI_REFCLASS_TABLE;
-	*ddb_handle = obj_desc;
-
-	/* Install the new table into the local data structures */
-
 	obj_desc->reference.value = table_index;
-
-	/* Add the table to the namespace */
-
-	status = acpi_ns_load_table(table_index, parent_node);
-	if (ACPI_FAILURE(status)) {
-		acpi_ut_remove_reference(obj_desc);
-		*ddb_handle = NULL;
-		return_ACPI_STATUS(status);
-	}
-
-	/* Execute any module-level code that was found in the table */
-
-	acpi_ex_exit_interpreter();
-	if (!acpi_gbl_parse_table_as_term_list
-	    && acpi_gbl_group_module_level_code) {
-		acpi_ns_exec_module_code_list();
-	}
-	acpi_ex_enter_interpreter();
-
-	/*
-	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
-	 * responsible for discovering any new wake GPEs by running _PRW methods
-	 * that may have been loaded by this table.
-	 */
-	status = acpi_tb_get_owner_id(table_index, &owner_id);
-	if (ACPI_SUCCESS(status)) {
-		acpi_ev_update_gpes(owner_id);
-	}
-
+	*ddb_handle = obj_desc;
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -160,16 +122,17 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 	struct acpi_namespace_node *start_node;
 	struct acpi_namespace_node *parameter_node = NULL;
 	union acpi_operand_object *ddb_handle;
-	struct acpi_table_header *table;
 	u32 table_index;
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
 	/* Find the ACPI table in the RSDT/XSDT */
 
+	acpi_ex_exit_interpreter();
 	status = acpi_tb_find_table(operand[0]->string.pointer,
 				    operand[1]->string.pointer,
 				    operand[2]->string.pointer, &table_index);
+	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
 			return_ACPI_STATUS(status);
@@ -232,7 +195,15 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	/* Load the table into the namespace */
 
-	status = acpi_ex_add_table(table_index, parent_node, &ddb_handle);
+	ACPI_INFO(("Dynamic OEM Table Load:"));
+	acpi_ex_exit_interpreter();
+	status = acpi_tb_load_table(table_index, parent_node);
+	acpi_ex_enter_interpreter();
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_ex_add_table(table_index, &ddb_handle);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -255,19 +226,6 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 		}
 	}
 
-	status = acpi_get_table_by_index(table_index, &table);
-	if (ACPI_SUCCESS(status)) {
-		ACPI_INFO(("Dynamic OEM Table Load:"));
-		acpi_tb_print_table_header(0, table);
-	}
-
-	/* Invoke table handler if present */
-
-	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
-					     acpi_gbl_table_handler_context);
-	}
-
 	*return_desc = ddb_handle;
 	return_ACPI_STATUS(status);
 }
@@ -478,13 +436,12 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	/* Install the new table into the local data structures */
 
 	ACPI_INFO(("Dynamic OEM Table Load:"));
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-
-	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
-						ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
-						TRUE, TRUE, &table_index);
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	acpi_ex_exit_interpreter();
+	status =
+	    acpi_tb_install_and_load_table(table, ACPI_PTR_TO_PHYSADDR(table),
+					   ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
+					   TRUE, &table_index);
+	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 
 		/* Delete allocated table buffer */
@@ -494,25 +451,13 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	}
 
 	/*
-	 * Note: Now table is "INSTALLED", it must be validated before
-	 * loading.
-	 */
-	status =
-	    acpi_tb_validate_table(&acpi_gbl_root_table_list.
-				   tables[table_index]);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/*
 	 * Add the table to the namespace.
 	 *
 	 * Note: Load the table objects relative to the root of the namespace.
 	 * This appears to go against the ACPI specification, but we do it for
 	 * compatibility with other ACPI implementations.
 	 */
-	status =
-	    acpi_ex_add_table(table_index, acpi_gbl_root_node, &ddb_handle);
+	status = acpi_ex_add_table(table_index, &ddb_handle);
 	if (ACPI_FAILURE(status)) {
 
 		/* On error, table_ptr was deallocated above */
@@ -535,14 +480,6 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	/* Remove the reference by added by acpi_ex_store above */
 
 	acpi_ut_remove_reference(ddb_handle);
-
-	/* Invoke table handler if present */
-
-	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
-					     acpi_gbl_table_handler_context);
-	}
-
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1388a19..7e93fd6 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acnamesp.h"
 #include "actables.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbdata")
@@ -771,3 +772,142 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_load_table
+ *
+ * PARAMETERS:  table_index             - Table index
+ *              parent_node             - Where table index is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Load an ACPI table
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	acpi_owner_id owner_id;
+
+	ACPI_FUNCTION_TRACE(tb_load_table);
+
+	/*
+	 * Note: Now table is "INSTALLED", it must be validated before
+	 * using.
+	 */
+	status = acpi_get_table_by_index(table_index, &table);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_ns_load_table(table_index, parent_node);
+
+	/* Execute any module-level code that was found in the table */
+
+	if (!acpi_gbl_parse_table_as_term_list
+	    && acpi_gbl_group_module_level_code) {
+		acpi_ns_exec_module_code_list();
+	}
+
+	/*
+	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
+	 * responsible for discovering any new wake GPEs by running _PRW methods
+	 * that may have been loaded by this table.
+	 */
+	status = acpi_tb_get_owner_id(table_index, &owner_id);
+	if (ACPI_SUCCESS(status)) {
+		acpi_ev_update_gpes(owner_id);
+	}
+
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
+					     acpi_gbl_table_handler_context);
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_install_and_load_table
+ *
+ * PARAMETERS:  table                   - Pointer to the table
+ *              address                 - Physical address of the table
+ *              flags                   - Allocation flags of the table
+ *              table_index             - Where table index is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install and load an ACPI table
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_tb_install_and_load_table(struct acpi_table_header *table,
+			       acpi_physical_address address,
+			       u8 flags, u8 override, u32 *table_index)
+{
+	acpi_status status;
+	u32 i;
+	acpi_owner_id owner_id;
+
+	ACPI_FUNCTION_TRACE(acpi_load_table);
+
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+	/* Install the table and load it into the namespace */
+
+	status = acpi_tb_install_standard_table(address, flags, TRUE,
+						override, &i);
+	if (ACPI_FAILURE(status)) {
+		goto unlock_and_exit;
+	}
+
+	/*
+	 * Note: Now table is "INSTALLED", it must be validated before
+	 * using.
+	 */
+	status = acpi_tb_validate_table(&acpi_gbl_root_table_list.tables[i]);
+	if (ACPI_FAILURE(status)) {
+		goto unlock_and_exit;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	status = acpi_ns_load_table(i, acpi_gbl_root_node);
+
+	/* Execute any module-level code that was found in the table */
+
+	if (!acpi_gbl_parse_table_as_term_list
+	    && acpi_gbl_group_module_level_code) {
+		acpi_ns_exec_module_code_list();
+	}
+
+	/*
+	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
+	 * responsible for discovering any new wake GPEs by running _PRW methods
+	 * that may have been loaded by this table.
+	 */
+	status = acpi_tb_get_owner_id(i, &owner_id);
+	if (ACPI_SUCCESS(status)) {
+		acpi_ev_update_gpes(owner_id);
+	}
+
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
+					     acpi_gbl_table_handler_context);
+	}
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+unlock_and_exit:
+	*table_index = i;
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	return_ACPI_STATUS(status);
+}
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index e348d61..a3f7b37 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -68,7 +68,7 @@ acpi_status
 acpi_tb_find_table(char *signature,
 		   char *oem_id, char *oem_table_id, u32 *table_index)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	struct acpi_table_header header;
 	u32 i;
 
@@ -96,6 +96,7 @@ acpi_tb_find_table(char *signature,
 
 	/* Search for the table */
 
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if (memcmp(&(acpi_gbl_root_table_list.tables[i].signature),
 			   header.signature, ACPI_NAME_SIZE)) {
@@ -115,7 +116,7 @@ acpi_tb_find_table(char *signature,
 			    acpi_tb_validate_table(&acpi_gbl_root_table_list.
 						   tables[i]);
 			if (ACPI_FAILURE(status)) {
-				return_ACPI_STATUS(status);
+				goto unlock_and_exit;
 			}
 
 			if (!acpi_gbl_root_table_list.tables[i].pointer) {
@@ -144,9 +145,12 @@ acpi_tb_find_table(char *signature,
 			ACPI_DEBUG_PRINT((ACPI_DB_TABLES,
 					  "Found table [%4.4s]\n",
 					  header.signature));
-			return_ACPI_STATUS(AE_OK);
+			goto unlock_and_exit;
 		}
 	}
+	status = AE_NOT_FOUND;
 
+unlock_and_exit:
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(AE_NOT_FOUND);
 }
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 6088712..870ad64 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -189,11 +189,11 @@ acpi_status acpi_tb_load_namespace(void)
 	memcpy(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT,
 	       sizeof(struct acpi_table_header));
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-
 	/* Load and parse tables */
 
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	status = acpi_ns_load_table(acpi_gbl_dsdt_index, acpi_gbl_root_node);
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "[DSDT] table load failed"));
 		tables_failed++;
@@ -203,7 +203,6 @@ acpi_status acpi_tb_load_namespace(void)
 
 	/* Load any SSDT or PSDT tables. Note: Loop leaves tables locked */
 
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		table = &acpi_gbl_root_table_list.tables[i];
 
@@ -221,6 +220,7 @@ acpi_status acpi_tb_load_namespace(void)
 
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 		status = acpi_ns_load_table(i, acpi_gbl_root_node);
+		(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"(%4.4s:%8.8s) while loading table",
@@ -236,8 +236,6 @@ acpi_status acpi_tb_load_namespace(void)
 		} else {
 			tables_loaded++;
 		}
-
-		(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	}
 
 	if (!tables_failed) {
@@ -325,49 +323,13 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Must acquire the interpreter lock during this operation */
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Install the table and load it into the namespace */
 
 	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-
-	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
-						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
-						TRUE, FALSE, &table_index);
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
-
-	/*
-	 * Note: Now table is "INSTALLED", it must be validated before
-	 * using.
-	 */
 	status =
-	    acpi_tb_validate_table(&acpi_gbl_root_table_list.
-				   tables[table_index]);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
-
-	status = acpi_ns_load_table(table_index, acpi_gbl_root_node);
-
-	/* Invoke table handler if present */
-
-	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
-					     acpi_gbl_table_handler_context);
-	}
-
-unlock_and_exit:
-	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+	    acpi_tb_install_and_load_table(table, ACPI_PTR_TO_PHYSADDR(table),
+					   ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
+					   FALSE, &table_index);
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.10

