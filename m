From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/22] ACPICA: Clarify/rename some root table descriptor fields
Date: Thu, 20 May 2010 01:18:43 -0400
Message-ID: <b9ee2043096b02e5da8c62f9a8a8f2e172b3606b.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0ETGPg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:36 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:15:02 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Original fields were not very descriptive and led to maintenance
problems.  New fields should help to understand the existing code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    7 ++--
 drivers/acpi/acpica/aclocal.h  |   10 +++---
 drivers/acpi/acpica/tbfind.c   |    2 +-
 drivers/acpi/acpica/tbinstal.c |   69 +++++++++++++++++++--------------------
 drivers/acpi/acpica/tbutils.c  |   19 ++++++-----
 drivers/acpi/acpica/tbxface.c  |   26 +++++++++------
 6 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 87f21d9..9070f1f 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -158,11 +158,10 @@ ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
  ****************************************************************************/
 
 /*
- * acpi_gbl_root_table_list is the master list of ACPI tables found in the
- * RSDT/XSDT.
- *
+ * acpi_gbl_root_table_list is the master list of ACPI tables that were
+ * found in the RSDT/XSDT.
  */
-ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
+ACPI_EXTERN struct acpi_table_list acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
 
 /* These addresses are calculated from the FADT Event Block addresses */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 5a6203a..0886a3d 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -213,12 +213,12 @@ struct acpi_namespace_node {
 #define ANOBJ_IS_BIT_OFFSET             0x40	/* i_aSL only: Reference is a bit offset */
 #define ANOBJ_IS_REFERENCED             0x80	/* i_aSL only: Object was referenced */
 
-/* One internal RSDT for table management */
+/* Internal ACPI table management - master table list */
 
-struct acpi_internal_rsdt {
-	struct acpi_table_desc *tables;
-	u32 count;
-	u32 size;
+struct acpi_table_list {
+	struct acpi_table_desc *tables;	/* Table descriptor array */
+	u32 current_table_count;	/* Tables currently in the array */
+	u32 max_table_count;	/* Max tables array will hold */
 	u8 flags;
 };
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index e252180..989d5c8 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -83,7 +83,7 @@ acpi_tb_find_table(char *signature,
 
 	/* Search for the table */
 
-	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if (ACPI_MEMCMP(&(acpi_gbl_root_table_list.tables[i].signature),
 				header.signature, ACPI_NAME_SIZE)) {
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 7ec02b0..83d7af8 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -137,7 +137,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 
 	/* Check if table is already registered */
 
-	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if (!acpi_gbl_root_table_list.tables[i].pointer) {
 			status =
 			    acpi_tb_verify_table(&acpi_gbl_root_table_list.
@@ -273,7 +273,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
 	/* Increase the Table Array size */
 
 	tables = ACPI_ALLOCATE_ZEROED(((acpi_size) acpi_gbl_root_table_list.
-				       size +
+				       max_table_count +
 				       ACPI_ROOT_TABLE_SIZE_INCREMENT) *
 				      sizeof(struct acpi_table_desc));
 	if (!tables) {
@@ -286,8 +286,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 	if (acpi_gbl_root_table_list.tables) {
 		ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables,
-			    (acpi_size) acpi_gbl_root_table_list.size *
-			    sizeof(struct acpi_table_desc));
+			    (acpi_size) acpi_gbl_root_table_list.
+			    max_table_count * sizeof(struct acpi_table_desc));
 
 		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 			ACPI_FREE(acpi_gbl_root_table_list.tables);
@@ -295,8 +295,9 @@ acpi_status acpi_tb_resize_root_table_list(void)
 	}
 
 	acpi_gbl_root_table_list.tables = tables;
-	acpi_gbl_root_table_list.size += ACPI_ROOT_TABLE_SIZE_INCREMENT;
-	acpi_gbl_root_table_list.flags |= (u8) ACPI_ROOT_ORIGIN_ALLOCATED;
+	acpi_gbl_root_table_list.max_table_count +=
+	    ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	acpi_gbl_root_table_list.flags |= (u8)ACPI_ROOT_ORIGIN_ALLOCATED;
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -321,38 +322,36 @@ acpi_tb_store_table(acpi_physical_address address,
 		    struct acpi_table_header *table,
 		    u32 length, u8 flags, u32 *table_index)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
+	struct acpi_table_desc *new_table;
 
 	/* Ensure that there is room for the table in the Root Table List */
 
-	if (acpi_gbl_root_table_list.count >= acpi_gbl_root_table_list.size) {
+	if (acpi_gbl_root_table_list.current_table_count >=
+	    acpi_gbl_root_table_list.max_table_count) {
 		status = acpi_tb_resize_root_table_list();
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
 	}
 
+	new_table =
+	    &acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.
+					     current_table_count];
+
 	/* Initialize added table */
 
-	acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
-	    address = address;
-	acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
-	    pointer = table;
-	acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].length =
-	    length;
-	acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
-	    owner_id = 0;
-	acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].flags =
-	    flags;
-
-	ACPI_MOVE_32_TO_32(&
-			   (acpi_gbl_root_table_list.
-			    tables[acpi_gbl_root_table_list.count].signature),
-			   table->signature);
-
-	*table_index = acpi_gbl_root_table_list.count;
-	acpi_gbl_root_table_list.count++;
-	return (status);
+	new_table->address = address;
+	new_table->pointer = table;
+	new_table->length = length;
+	new_table->owner_id = 0;
+	new_table->flags = flags;
+
+	ACPI_MOVE_32_TO_32(&new_table->signature, table->signature);
+
+	*table_index = acpi_gbl_root_table_list.current_table_count;
+	acpi_gbl_root_table_list.current_table_count++;
+	return (AE_OK);
 }
 
 /*******************************************************************************
@@ -408,7 +407,7 @@ void acpi_tb_terminate(void)
 
 	/* Delete the individual tables */
 
-	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; i++) {
 		acpi_tb_delete_table(&acpi_gbl_root_table_list.tables[i]);
 	}
 
@@ -422,7 +421,7 @@ void acpi_tb_terminate(void)
 
 	acpi_gbl_root_table_list.tables = NULL;
 	acpi_gbl_root_table_list.flags = 0;
-	acpi_gbl_root_table_list.count = 0;
+	acpi_gbl_root_table_list.current_table_count = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "ACPI Tables freed\n"));
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
@@ -452,7 +451,7 @@ acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index)
 		return_ACPI_STATUS(status);
 	}
 
-	if (table_index >= acpi_gbl_root_table_list.count) {
+	if (table_index >= acpi_gbl_root_table_list.current_table_count) {
 
 		/* The table index does not exist */
 
@@ -505,7 +504,7 @@ acpi_status acpi_tb_allocate_owner_id(u32 table_index)
 	ACPI_FUNCTION_TRACE(tb_allocate_owner_id);
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	if (table_index < acpi_gbl_root_table_list.count) {
+	if (table_index < acpi_gbl_root_table_list.current_table_count) {
 		status = acpi_ut_allocate_owner_id
 		    (&(acpi_gbl_root_table_list.tables[table_index].owner_id));
 	}
@@ -533,7 +532,7 @@ acpi_status acpi_tb_release_owner_id(u32 table_index)
 	ACPI_FUNCTION_TRACE(tb_release_owner_id);
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	if (table_index < acpi_gbl_root_table_list.count) {
+	if (table_index < acpi_gbl_root_table_list.current_table_count) {
 		acpi_ut_release_owner_id(&
 					 (acpi_gbl_root_table_list.
 					  tables[table_index].owner_id));
@@ -564,7 +563,7 @@ acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id)
 	ACPI_FUNCTION_TRACE(tb_get_owner_id);
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	if (table_index < acpi_gbl_root_table_list.count) {
+	if (table_index < acpi_gbl_root_table_list.current_table_count) {
 		*owner_id =
 		    acpi_gbl_root_table_list.tables[table_index].owner_id;
 		status = AE_OK;
@@ -589,7 +588,7 @@ u8 acpi_tb_is_table_loaded(u32 table_index)
 	u8 is_loaded = FALSE;
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	if (table_index < acpi_gbl_root_table_list.count) {
+	if (table_index < acpi_gbl_root_table_list.current_table_count) {
 		is_loaded = (u8)
 		    (acpi_gbl_root_table_list.tables[table_index].flags &
 		     ACPI_TABLE_IS_LOADED);
@@ -616,7 +615,7 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
 {
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	if (table_index < acpi_gbl_root_table_list.count) {
+	if (table_index < acpi_gbl_root_table_list.current_table_count) {
 		if (is_loaded) {
 			acpi_gbl_root_table_list.tables[table_index].flags |=
 			    ACPI_TABLE_IS_LOADED;
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index a9b105f..34f9c2b 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -158,7 +158,7 @@ acpi_status acpi_tb_initialize_facs(void)
 u8 acpi_tb_tables_loaded(void)
 {
 
-	if (acpi_gbl_root_table_list.count >= 3) {
+	if (acpi_gbl_root_table_list.current_table_count >= 3) {
 		return (TRUE);
 	}
 
@@ -707,14 +707,14 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	 */
 	table_entry =
 	    ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
-	acpi_gbl_root_table_list.count = 2;
+	acpi_gbl_root_table_list.current_table_count = 2;
 
 	/*
 	 * Initialize the root table array from the RSDT/XSDT
 	 */
 	for (i = 0; i < table_count; i++) {
-		if (acpi_gbl_root_table_list.count >=
-		    acpi_gbl_root_table_list.size) {
+		if (acpi_gbl_root_table_list.current_table_count >=
+		    acpi_gbl_root_table_list.max_table_count) {
 
 			/* There is no more room in the root table array, attempt resize */
 
@@ -724,19 +724,20 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 					      "Truncating %u table entries!",
 					      (unsigned) (table_count -
 					       (acpi_gbl_root_table_list.
-					       count - 2))));
+							  current_table_count -
+							  2))));
 				break;
 			}
 		}
 
 		/* Get the table physical address (32-bit for RSDT, 64-bit for XSDT) */
 
-		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
-		    address =
+		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.
+						current_table_count].address =
 		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
 
 		table_entry += table_entry_size;
-		acpi_gbl_root_table_list.count++;
+		acpi_gbl_root_table_list.current_table_count++;
 	}
 
 	/*
@@ -749,7 +750,7 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	 * Complete the initialization of the root table array by examining
 	 * the header of each table
 	 */
-	for (i = 2; i < acpi_gbl_root_table_list.count; i++) {
+	for (i = 2; i < acpi_gbl_root_table_list.current_table_count; i++) {
 		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
 				      address, NULL, i);
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index adb7f56..4a8b9e6 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -72,7 +72,7 @@ static int no_auto_ssdt;
 acpi_status acpi_allocate_root_table(u32 initial_table_count)
 {
 
-	acpi_gbl_root_table_list.size = initial_table_count;
+	acpi_gbl_root_table_list.max_table_count = initial_table_count;
 	acpi_gbl_root_table_list.flags = ACPI_ROOT_ALLOW_RESIZE;
 
 	return (acpi_tb_resize_root_table_list());
@@ -130,7 +130,7 @@ acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 			    sizeof(struct acpi_table_desc));
 
 		acpi_gbl_root_table_list.tables = initial_table_array;
-		acpi_gbl_root_table_list.size = initial_table_count;
+		acpi_gbl_root_table_list.max_table_count = initial_table_count;
 		acpi_gbl_root_table_list.flags = ACPI_ROOT_ORIGIN_UNKNOWN;
 		if (allow_resize) {
 			acpi_gbl_root_table_list.flags |=
@@ -189,7 +189,8 @@ acpi_status acpi_reallocate_root_table(void)
 	 * increment to create the new table size.
 	 */
 	current_size = (acpi_size)
-	    acpi_gbl_root_table_list.count * sizeof(struct acpi_table_desc);
+	    acpi_gbl_root_table_list.current_table_count *
+	    sizeof(struct acpi_table_desc);
 
 	new_size = current_size +
 	    (ACPI_ROOT_TABLE_SIZE_INCREMENT * sizeof(struct acpi_table_desc));
@@ -209,8 +210,9 @@ acpi_status acpi_reallocate_root_table(void)
 	 * size of the original table list.
 	 */
 	acpi_gbl_root_table_list.tables = tables;
-	acpi_gbl_root_table_list.size =
-	    acpi_gbl_root_table_list.count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	acpi_gbl_root_table_list.max_table_count =
+	    acpi_gbl_root_table_list.current_table_count +
+	    ACPI_ROOT_TABLE_SIZE_INCREMENT;
 	acpi_gbl_root_table_list.flags =
 	    ACPI_ROOT_ORIGIN_ALLOCATED | ACPI_ROOT_ALLOW_RESIZE;
 
@@ -291,7 +293,8 @@ acpi_get_table_header(char *signature,
 
 	/* Walk the root table list */
 
-	for (i = 0, j = 0; i < acpi_gbl_root_table_list.count; i++) {
+	for (i = 0, j = 0; i < acpi_gbl_root_table_list.current_table_count;
+	     i++) {
 		if (!ACPI_COMPARE_NAME
 		    (&(acpi_gbl_root_table_list.tables[i].signature),
 		     signature)) {
@@ -354,7 +357,7 @@ acpi_status acpi_unload_table_id(acpi_owner_id id)
 	ACPI_FUNCTION_TRACE(acpi_unload_table_id);
 
 	/* Find table in the global table list */
-	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if (id != acpi_gbl_root_table_list.tables[i].owner_id) {
 			continue;
 		}
@@ -404,7 +407,8 @@ acpi_get_table_with_size(char *signature,
 
 	/* Walk the root table list */
 
-	for (i = 0, j = 0; i < acpi_gbl_root_table_list.count; i++) {
+	for (i = 0, j = 0; i < acpi_gbl_root_table_list.current_table_count;
+	     i++) {
 		if (!ACPI_COMPARE_NAME
 		    (&(acpi_gbl_root_table_list.tables[i].signature),
 		     signature)) {
@@ -472,7 +476,7 @@ acpi_get_table_by_index(u32 table_index, struct acpi_table_header **table)
 
 	/* Validate index */
 
-	if (table_index >= acpi_gbl_root_table_list.count) {
+	if (table_index >= acpi_gbl_root_table_list.current_table_count) {
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
@@ -523,7 +527,7 @@ static acpi_status acpi_tb_load_namespace(void)
 	 * Load the namespace. The DSDT is required, but any SSDT and
 	 * PSDT tables are optional. Verify the DSDT.
 	 */
-	if (!acpi_gbl_root_table_list.count ||
+	if (!acpi_gbl_root_table_list.current_table_count ||
 	    !ACPI_COMPARE_NAME(&
 			       (acpi_gbl_root_table_list.
 				tables[ACPI_TABLE_INDEX_DSDT].signature),
@@ -577,7 +581,7 @@ static acpi_status acpi_tb_load_namespace(void)
 	/* Load any SSDT or PSDT tables. Note: Loop leaves tables locked */
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if ((!ACPI_COMPARE_NAME
 		     (&(acpi_gbl_root_table_list.tables[i].signature),
 		      ACPI_SIG_SSDT)
-- 
1.6.0.6

