From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/8] ACPI: introduce new interfaces for inactive table
	management
Date: Fri, 19 Dec 2008 15:57:50 +0800
Message-ID: <1229673470.562.138.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43283 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbYLSH7S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

introduce new interfaces for inactive table management.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbfind.c   |   55 ++++++++++++++++++++++++++++
 drivers/acpi/tables/tbinstal.c |    5 +-
 drivers/acpi/tables/tbxface.c  |   78 ++++++++++++++++++++++-------------------
 include/acpi/acpixf.h          |    7 +++
 include/acpi/actables.h        |    4 +-
 5 files changed, 110 insertions(+), 39 deletions(-)

Index: linux-2.6/drivers/acpi/tables/tbxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbxface.c
+++ linux-2.6/drivers/acpi/tables/tbxface.c
@@ -154,6 +154,27 @@ acpi_initialize_tables(struct acpi_table
 	return_ACPI_STATUS(status);
 }
 
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_initialize_inactive_tables
+ *
+ * PARAMETERS:  no
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Initialize the inactive table.
+ *
+ ******************************************************************************/
+
+acpi_status __init
+acpi_initialize_inactive_tables(void)
+{
+	return_ACPI_STATUS(
+		acpi_tb_parse_root_table(0, ACPI_TABLE_ORIGIN_INACTIVE));
+}
+ACPI_EXPORT_SYMBOL(acpi_initialize_inactive_tables)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_reallocate_root_table
@@ -436,47 +457,32 @@ ACPI_EXPORT_SYMBOL(acpi_get_table)
 acpi_status
 acpi_get_table_by_index(u32 table_index, struct acpi_table_header **table)
 {
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(acpi_get_table_by_index);
-
-	/* Parameter validation */
-
-	if (!table) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-
-	/* Validate index */
-
-	if (table_index >= acpi_gbl_root_table_list.count) {
-		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	if (!acpi_gbl_root_table_list.tables[table_index].pointer) {
-
-		/* Table is not mapped, map it */
-
-		status =
-		    acpi_tb_verify_table(&acpi_gbl_root_table_list.
-					 tables[table_index]);
-		if (ACPI_FAILURE(status)) {
-			(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-			return_ACPI_STATUS(status);
-		}
-	}
-
-	*table = acpi_gbl_root_table_list.tables[table_index].pointer;
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-	return_ACPI_STATUS(AE_OK);
+	return acpi_tb_get_table_by_index(table_index, table, 1);
 }
-
 ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
 
 /*******************************************************************************
  *
+ * FUNCTION:	acpi_get_inactive_table_by_index
+ *
+ * PARAMETERS:	table_index	- Table index
+ * 		Table		- Where the pointer to the table is returned
+ *
+ * RETURN:      Status and pointer to the table
+ *
+ * DESCRIPTION: Obtain a table by an index into the global inactive table list.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_get_inactive_table_by_index(u32 table_index,
+					struct acpi_table_header **table)
+{
+	return acpi_tb_get_table_by_index(table_index, table, 0);
+}
+ACPI_EXPORT_SYMBOL(acpi_get_inactive_table_by_index)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_load_namespace
  *
  * PARAMETERS:  None
Index: linux-2.6/drivers/acpi/tables/tbfind.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbfind.c
+++ linux-2.6/drivers/acpi/tables/tbfind.c
@@ -137,3 +137,58 @@ acpi_tb_find_table(char *signature,
 
 	return_ACPI_STATUS(AE_NOT_FOUND);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:	acpi_tb_get_table_by_index
+ *
+ * PARAMETERS:	table_index	- Table index
+ *		table		- Where the pointer to the table is returned
+ *		flag		- which table list the table is obtained from
+ *
+ * RETURN:	Status and pointer to the table
+ *
+ * DESCRIPTION:	Obtain a table by an index into the global table list.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_tb_get_table_by_index(u32 table_index,
+			struct acpi_table_header **table, int flag)
+{
+	acpi_status status;
+	struct acpi_internal_rsdt *root_table_list =
+				get_root_table_list(flag);
+
+	ACPI_FUNCTION_TRACE(acpi_tb_get_table_by_index);
+
+	/* Parameter validation */
+
+	if (!table)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+	/* Validate index */
+
+	if (table_index >= root_table_list->count) {
+		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	if (!root_table_list->tables[table_index].pointer) {
+
+		/* Table is not mapped, map it */
+		status =
+			acpi_tb_verify_table(&root_table_list->
+					tables[table_index]);
+		if (ACPI_FAILURE(status)) {
+			(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+			return_ACPI_STATUS(status);
+		}
+	}
+
+	*table = root_table_list->tables[table_index].pointer;
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	return_ACPI_STATUS(AE_OK);
+}
+
Index: linux-2.6/include/acpi/actables.h
===================================================================
--- linux-2.6.orig/include/acpi/actables.h
+++ linux-2.6/include/acpi/actables.h
@@ -65,7 +65,9 @@ void acpi_tb_create_local_fadt(struct ac
 acpi_status
 acpi_tb_find_table(char *signature,
 		   char *oem_id, char *oem_table_id, u32 *table_index);
-
+acpi_status
+acpi_tb_get_table_by_index(u32 table_index,
+			struct acpi_table_header **table, int flag);
 /*
  * tbinstal - Table removal and deletion
  */
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -55,6 +55,9 @@ acpi_status
 acpi_initialize_tables(struct acpi_table_desc *initial_storage,
 		       u32 initial_table_count, u8 allow_resize);
 
+acpi_status
+acpi_initialize_inactive_tables(void);
+
 acpi_status __init acpi_initialize_subsystem(void);
 
 acpi_status acpi_enable_subsystem(u32 flags);
@@ -120,6 +123,10 @@ acpi_get_table_by_index(u32 table_index,
 			struct acpi_table_header **out_table);
 
 acpi_status
+acpi_get_inactive_table_by_index(u32 table_index,
+			struct acpi_table_header **out_table);
+
+acpi_status
 acpi_install_table_handler(acpi_tbl_handler handler, void *context);
 
 acpi_status acpi_remove_table_handler(acpi_tbl_handler handler);
Index: linux-2.6/drivers/acpi/tables/tbinstal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbinstal.c
+++ linux-2.6/drivers/acpi/tables/tbinstal.c
@@ -68,8 +68,9 @@ acpi_status acpi_tb_verify_table(struct 
 	/* Map the table if necessary */
 
 	if (!table_desc->pointer) {
-		if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
-		    ACPI_TABLE_ORIGIN_MAPPED) {
+		if (((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
+		    ACPI_TABLE_ORIGIN_MAPPED) || table_desc->flags ==
+		    ACPI_TABLE_ORIGIN_INACTIVE) {
 			table_desc->pointer =
 			    acpi_os_map_memory(table_desc->address,
 					       table_desc->length);


