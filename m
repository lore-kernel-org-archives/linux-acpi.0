From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/28] ACPICA: Tables: Cleanup split INSTALLED/VALIDATED table state logics.
Date: Fri,  4 Apr 2014 12:38:42 +0800
Message-ID: <cdb28e6765402b6d53735552eebe3e75a3812221.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38069 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbaDDEit (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:49 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch is mainly a naming cleanup to clarify hidden logics, no
functional changes.

acpi_initialize_tables() is used by Linux to install table addresses for
early boot steps.  During this stage, table addresses are mapped by
early_ioremap() mechanism which is different from the runtime IO mappings.
Thus it is not safe for ACPICA to keep mapped pointers in struct acpi_table_desc
structure during this stage.

In order to support this in ACPICA, table states are divided into
1. "INSTALLED" (where struct acpi_table_desc.Pointer is always NULL) and
2. "VALIDATED" (where struct acpi_table_desc.Pointer is always not NULL).
During acpi_initialize_tables(), table state are ensured to be "INSTALLED"
but not "VALIDATED".  This logic is ensured by the original code in very
ambigious way.  For example, currently acpi_tb_delete_table() is invoked in
some place to perform an uninstallation while it is invoked in other place
to perform an invalidation.  They happen to work just because no one enters
the penalty where the 2 behaviours are not equivalent.

The naming cleanups are made in this patch:
A. For installation and validation:
   There is code setting struct acpi_table_desc.Pointer first and delete it
   immediately to keep the descriptor's state as "INSTALLED" during the
   installation.  This patch implements this in more direct way.  After
   applying it, struct acpi_table_desc.Pointer will never be set in
   acpi_tb_install_table() and acpi_tb_override_table() as they are the only
   functions invoked during acpi_initialize_tables(). This is achieved by:
1. Rename acpi_tb_verify_table() to acpi_tb_validate_table() to clarify this
   change.
2. Rename acpi_tb_table_override() to acpi_tb_override_table() to keep nameing
   consistencies as other APIs (verb. Table).
3. Stops setting struct acpi_table_desc.Pointer in acpi_tb_install_table() and
   acpi_tb_table_override().
4. Introduce acpi_tb_acquire_table() to acquire the table pointer that is not
   maintained in the struct acpi_table_desc of the global root table list and
   rewrite acpi_tb_validate_table() using this new function to reduce
   redundancies.
5. Replace the table pointer using the overridden table pointer in
   acpi_tb_add_table(). As acpi_tb_add_table() is not invoked during early boot
   stage, tables returned from this functions should be "VALIDATED".  As
   acpi_tb_override_table() is modified by this patch to return a "INSTALLED"
   but not "VALIDATED" descriptor, to keep acpi_tb_add_table() unchanged,
   struct acpi_table_desc.Pointer is filled in acpi_tb_add_table().
B. For invalidation and uninstallation:
   The original code invalidate table by invoking acpi_tb_delete_table() here
   and there, but actually this function should only be used to uninstall
   tables.  This can work just because its invocations are equivalent to
   invalidation in some cases.
   This patch splits acpi_tb_delete_table() into acpi_tb_invalidate_table() and
   acpi_tb_uninstall_table() and cleans up the hidden logic using the new
   APIs.  This is achieved by:
1. Rename acpi_tb_delete_table() to acpi_tb_uninstall_table() as it is mainly
   called before resetting struct acpi_table_desc.Address.  Thus the table
   descriptor is in "not INSTALLED" state.  This patch enforces this by
   setting struct acpi_table_desc.Address to NULL in this function.
2. Introduce acpi_tb_invalidate_table() to be the reversal of
   acpi_tb_validate_table() and invoke it in acpi_tb_uninstall_table().
3. Introduce acpi_tb_release_table() to release the table pointer that is not
   maintained in acpi_gbl_root_table_list and rewrite acpi_tb_invalidate_table()
   using this new function to reduce redundancies.

After cleaning up, the maintainability of the internal APIs are also
improved:
1. acpi_tb_acquire_table: Acquire struct acpi_table_header according to
                       ACPI_TABLE_ORIGIN_xxx flags.
2. acpi_tb_release_table: Release struct acpi_table_header according to
                       ACPI_TABLE_ORIGIN_xxx flags.
3. acpi_tb_install_table: Make struct acpi_table_desc.Address not NULL according to
                       ACPI_TABLE_ORIGIN_xxx flags.
4. acpi_tb_uninstall_table: Make struct acpi_table_desc.Address NULL according to
                         ACPI_TABLE_ORIGIN_xxx flags.
5. acpi_tb_validate_table: Make struct acpi_table_desc.Pointer not NULL according to
                        ACPI_TABLE_ORIGIN_xxx flags.
6. acpi_tb_invalidate_table: Make struct acpi_table_desc.Pointer NULL according to
                          ACPI_TABLE_ORIGIN_xxx flags.
7. acpi_tb_override_table: Replace struct acpi_table_desc.Address and
                        struct acpi_table_desc.Flags.  It only happens in
                        "INSTALLED" state.

The patch has been unit tested in acpi_exec by:
1. Initializing;
2. Executing exc_tbl ASLTS tests;
3. Executing "Load" command.
So that all original acpi_tb_install_table() and acpi_tb_override_table()
invocations are covered.

Known Issues:
1. Cleanup acpi_tb_add_table() to Kill Code Redundancies
   Current implementation in acpi_tb_add_table() is not very clean, further
   patch can rewrite acpi_tb_add_table() with ordered acpi_tb_install_table(),
   acpi_tb_override_table() and acpi_tb_validate_table(). It is not done in this
   patch so that it is easy for the reviewers to understand the changes in
   this patch.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |   17 ++-
 drivers/acpi/acpica/tbfind.c   |    4 +-
 drivers/acpi/acpica/tbinstal.c |  299 +++++++++++++++++++++++++++-------------
 drivers/acpi/acpica/tbutils.c  |   11 +-
 drivers/acpi/acpica/tbxface.c  |    6 +-
 drivers/acpi/acpica/tbxfload.c |    6 +-
 6 files changed, 235 insertions(+), 108 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 5fa4b20..c569eab 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -72,14 +72,25 @@ acpi_tb_find_table(char *signature,
  */
 acpi_status acpi_tb_resize_root_table_list(void);
 
-acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc);
+acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc);
 
-struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
+void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc);
+
+struct acpi_table_header *acpi_tb_override_table(struct acpi_table_header
 						 *table_header,
 						 struct acpi_table_desc
 						 *table_desc);
 
 acpi_status
+acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
+		      struct acpi_table_header **table_ptr,
+		      u32 *table_length, u8 *table_flags);
+
+void
+acpi_tb_release_table(struct acpi_table_header *table,
+		      u32 table_length, u8 table_flags);
+
+acpi_status
 acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index);
 
 acpi_status
@@ -87,7 +98,7 @@ acpi_tb_store_table(acpi_physical_address address,
 		    struct acpi_table_header *table,
 		    u32 length, u8 flags, u32 *table_index);
 
-void acpi_tb_delete_table(struct acpi_table_desc *table_desc);
+void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_terminate(void);
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index c120039..cb94770 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -99,8 +99,8 @@ acpi_tb_find_table(char *signature,
 			/* Table is not currently mapped, map it */
 
 			status =
-			    acpi_tb_verify_table(&acpi_gbl_root_table_list.
-						 tables[i]);
+			    acpi_tb_validate_table(&acpi_gbl_root_table_list.
+						   tables[i]);
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
 			}
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 0040e19..93a99ef 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -49,49 +49,123 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbinstal")
 
-/******************************************************************************
+/*******************************************************************************
  *
- * FUNCTION:    acpi_tb_verify_table
+ * FUNCTION:    acpi_tb_acquire_table
  *
- * PARAMETERS:  table_desc          - table
+ * PARAMETERS:  table_desc          - Table descriptor
+ *              table_ptr           - Where table is returned
+ *              table_length        - Where table length is returned
+ *              table_flags         - Where table allocation flags are returned
  *
  * RETURN:      Status
  *
- * DESCRIPTION: this function is called to verify and map table
+ * DESCRIPTION: Acquire a table. It can be used for tables not maintained in
+ *              acpi_gbl_root_table_list.
  *
- *****************************************************************************/
-acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
+ ******************************************************************************/
+acpi_status
+acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
+		      struct acpi_table_header **table_ptr,
+		      u32 *table_length, u8 *table_flags)
 {
-	acpi_status status = AE_OK;
+	struct acpi_table_header *table = NULL;
 
-	ACPI_FUNCTION_TRACE(tb_verify_table);
+	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
+	case ACPI_TABLE_ORIGIN_MAPPED:
 
-	/* Map the table if necessary */
+		table =
+		    acpi_os_map_memory(table_desc->address, table_desc->length);
+		break;
 
-	if (!table_desc->pointer) {
-		switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
-		case ACPI_TABLE_ORIGIN_MAPPED:
+	case ACPI_TABLE_ORIGIN_ALLOCATED:
+	case ACPI_TABLE_ORIGIN_UNKNOWN:
+	case ACPI_TABLE_ORIGIN_OVERRIDE:
 
-			table_desc->pointer =
-			    acpi_os_map_memory(table_desc->address,
-					       table_desc->length);
-			break;
+		table =
+		    ACPI_CAST_PTR(struct acpi_table_header,
+				  table_desc->address);
+		break;
 
-		case ACPI_TABLE_ORIGIN_ALLOCATED:
-		case ACPI_TABLE_ORIGIN_UNKNOWN:
-		case ACPI_TABLE_ORIGIN_OVERRIDE:
+	default:
 
-			table_desc->pointer =
-			    ACPI_CAST_PTR(struct acpi_table_header,
-					  table_desc->address);
-			break;
+		break;
+	}
 
-		default:
+	/* Table is not valid yet */
 
-			break;
-		}
+	if (!table) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Fill the return values */
+
+	*table_ptr = table;
+	*table_length = table_desc->length;
+	*table_flags = table_desc->flags;
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_release_table
+ *
+ * PARAMETERS:  table               - Pointer for the table
+ *              table_length        - Length for the table
+ *              table_flags         - Allocation flags for the table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Release a table. The reversal of acpi_tb_acquire_table().
+ *
+ ******************************************************************************/
+
+void
+acpi_tb_release_table(struct acpi_table_header *table,
+		      u32 table_length, u8 table_flags)
+{
+	switch (table_flags & ACPI_TABLE_ORIGIN_MASK) {
+	case ACPI_TABLE_ORIGIN_MAPPED:
+
+		acpi_os_unmap_memory(table, table_length);
+		break;
+
+	case ACPI_TABLE_ORIGIN_ALLOCATED:
+	case ACPI_TABLE_ORIGIN_UNKNOWN:
+	case ACPI_TABLE_ORIGIN_OVERRIDE:
+	default:
+
+		break;
+	}
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_validate_table
+ *
+ * PARAMETERS:  table_desc          - Table descriptor
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function is called to validate (ensure Pointer is valid)
+ *              and verify the table.
+ *
+ *****************************************************************************/
+
+acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc)
+{
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE(tb_validate_table);
+
+	/* Validate the table if necessary */
 
-		if (!table_desc->pointer) {
+	if (!table_desc->pointer) {
+		status = acpi_tb_acquire_table(table_desc, &table_desc->pointer,
+					       &table_desc->length,
+					       &table_desc->flags);
+		if (ACPI_FAILURE(status) || !table_desc->pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 	}
@@ -106,6 +180,37 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_invalidate_table
+ *
+ * PARAMETERS:  table_desc          - Table descriptor
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Invalidate one internal ACPI table, this is reversal of
+ *              acpi_tb_validate_table().
+ *
+ ******************************************************************************/
+
+void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc)
+{
+
+	ACPI_FUNCTION_TRACE(tb_invalidate_table);
+
+	/* Table must be validated */
+
+	if (!table_desc->pointer) {
+		return_VOID;
+	}
+
+	acpi_tb_release_table(table_desc->pointer, table_desc->length,
+			      table_desc->flags);
+	table_desc->pointer = NULL;
+
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_add_table
  *
  * PARAMETERS:  table_desc          - Table descriptor
@@ -124,11 +229,12 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 {
 	u32 i;
 	acpi_status status = AE_OK;
+	struct acpi_table_header *final_table;
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
 
 	if (!table_desc->pointer) {
-		status = acpi_tb_verify_table(table_desc);
+		status = acpi_tb_validate_table(table_desc);
 		if (ACPI_FAILURE(status) || !table_desc->pointer) {
 			return_ACPI_STATUS(status);
 		}
@@ -166,8 +272,8 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if (!acpi_gbl_root_table_list.tables[i].pointer) {
 			status =
-			    acpi_tb_verify_table(&acpi_gbl_root_table_list.
-						 tables[i]);
+			    acpi_tb_validate_table(&acpi_gbl_root_table_list.
+						   tables[i]);
 			if (ACPI_FAILURE(status)
 			    || !acpi_gbl_root_table_list.tables[i].pointer) {
 				continue;
@@ -215,7 +321,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		} else {
 			/* Table was unloaded, allow it to be reloaded */
 
-			acpi_tb_delete_table(table_desc);
+			acpi_tb_uninstall_table(table_desc);
 			table_desc->pointer =
 			    acpi_gbl_root_table_list.tables[i].pointer;
 			table_desc->address =
@@ -229,9 +335,15 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 	 * ACPI Table Override:
 	 * Allow the host to override dynamically loaded tables.
 	 * NOTE: the table is fully mapped at this point, and the mapping will
-	 * be deleted by tb_table_override if the table is actually overridden.
+	 * be deleted by acpi_tb_override_table if the table is actually overridden.
 	 */
-	(void)acpi_tb_table_override(table_desc->pointer, table_desc);
+	final_table = acpi_tb_override_table(table_desc->pointer, table_desc);
+	if (final_table) {
+
+		/* Ensure table descriptor is in "VALIDATED" state */
+
+		table_desc->pointer = final_table;
+	}
 
 	/* Add the table to the global root table list */
 
@@ -252,7 +364,7 @@ release:
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_table_override
+ * FUNCTION:    acpi_tb_override_table
  *
  * PARAMETERS:  table_header        - Header for the original table
  *              table_desc          - Table descriptor initialized for the
@@ -264,29 +376,35 @@ release:
  *
  * DESCRIPTION: Attempt table override by calling the OSL override functions.
  *              Note: If the table is overridden, then the entire new table
- *              is mapped and returned by this function.
+ *              is acquired and returned by this function.
+ *              After invocation, the table descriptor is in a state that is
+ *              "INSTALLED" but not "VALIDATED", thus the "Pointer" member is
+ *              kept NULL.
  *
  ******************************************************************************/
 
-struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
+struct acpi_table_header *acpi_tb_override_table(struct acpi_table_header
 						 *table_header,
 						 struct acpi_table_desc
 						 *table_desc)
 {
 	acpi_status status;
-	struct acpi_table_header *new_table = NULL;
-	acpi_physical_address new_address = 0;
-	u32 new_table_length = 0;
+	struct acpi_table_header *new_table;
+	u32 new_table_length;
 	u8 new_flags;
 	char *override_type;
+	struct acpi_table_desc new_table_desc;
+
+	ACPI_MEMSET(&new_table_desc, 0, sizeof(struct acpi_table_desc));
 
 	/* (1) Attempt logical override (returns a logical address) */
 
-	status = acpi_os_table_override(table_header, &new_table);
-	if (ACPI_SUCCESS(status) && new_table) {
-		new_address = ACPI_PTR_TO_PHYSADDR(new_table);
-		new_table_length = new_table->length;
-		new_flags = ACPI_TABLE_ORIGIN_OVERRIDE;
+	status = acpi_os_table_override(table_header, &new_table_desc.pointer);
+	if (ACPI_SUCCESS(status) && new_table_desc.pointer) {
+		new_table_desc.address =
+		    ACPI_PTR_TO_PHYSADDR(new_table_desc.pointer);
+		new_table_desc.length = new_table_desc.pointer->length;
+		new_table_desc.flags = ACPI_TABLE_ORIGIN_OVERRIDE;
 		override_type = "Logical";
 		goto finish_override;
 	}
@@ -294,25 +412,12 @@ struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
 	/* (2) Attempt physical override (returns a physical address) */
 
 	status = acpi_os_physical_table_override(table_header,
-						 &new_address,
-						 &new_table_length);
-	if (ACPI_SUCCESS(status) && new_address && new_table_length) {
-
-		/* Map the entire new table */
-
-		new_table = acpi_os_map_memory(new_address, new_table_length);
-		if (!new_table) {
-			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
-					"%4.4s " ACPI_PRINTF_UINT
-					" Attempted physical table override failed",
-					table_header->signature,
-					ACPI_FORMAT_TO_UINT(table_desc->
-							    address)));
-			return (NULL);
-		}
-
+						 &new_table_desc.address,
+						 &new_table_desc.length);
+	if (ACPI_SUCCESS(status) && new_table_desc.address
+	    && new_table_desc.length) {
 		override_type = "Physical";
-		new_flags = ACPI_TABLE_ORIGIN_MAPPED;
+		new_table_desc.flags = ACPI_TABLE_ORIGIN_MAPPED;
 		goto finish_override;
 	}
 
@@ -320,22 +425,36 @@ struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
 
 finish_override:
 
+	/*
+	 * Acquire the entire new table to indicate overridden.
+	 * Note that this is required by the callers of this function.
+	 */
+	status = acpi_tb_acquire_table(&new_table_desc, &new_table,
+				       &new_table_length, &new_flags);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
+				"%4.4s " ACPI_PRINTF_UINT
+				" Attempted table override failed",
+				table_header->signature,
+				ACPI_FORMAT_TO_UINT(table_desc->address)));
+		return (NULL);
+	}
+
 	ACPI_INFO((AE_INFO, "%4.4s " ACPI_PRINTF_UINT
 		   " %s table override, new table: " ACPI_PRINTF_UINT,
 		   table_header->signature,
 		   ACPI_FORMAT_TO_UINT(table_desc->address),
-		   override_type, ACPI_FORMAT_TO_UINT(new_table)));
+		   override_type, ACPI_FORMAT_TO_UINT(new_table_desc.address)));
 
-	/* We can now unmap/delete the original table (if fully mapped) */
+	/* We can now uninstall the original table (if fully mapped) */
 
-	acpi_tb_delete_table(table_desc);
+	acpi_tb_uninstall_table(table_desc);
 
-	/* Setup descriptor for the new table */
+	/* Install the new table */
 
-	table_desc->address = new_address;
-	table_desc->pointer = new_table;
-	table_desc->length = new_table_length;
-	table_desc->flags = new_flags;
+	table_desc->address = new_table_desc.address;
+	table_desc->length = new_table_desc.length;
+	table_desc->flags = new_table_desc.flags;
 
 	return (new_table);
 }
@@ -458,9 +577,9 @@ acpi_tb_store_table(acpi_physical_address address,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_delete_table
+ * FUNCTION:    acpi_tb_uninstall_table
  *
- * PARAMETERS:  table_index         - Table index
+ * PARAMETERS:  table_desc          - Table descriptor
  *
  * RETURN:      None
  *
@@ -468,35 +587,27 @@ acpi_tb_store_table(acpi_physical_address address,
  *
  ******************************************************************************/
 
-void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
+void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc)
 {
 
-	/* Table must be mapped or allocated */
-
-	if (!table_desc->pointer) {
-		return;
-	}
-
-	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_MAPPED:
-
-		acpi_os_unmap_memory(table_desc->pointer, table_desc->length);
-		break;
-
-	case ACPI_TABLE_ORIGIN_ALLOCATED:
+	ACPI_FUNCTION_TRACE(tb_uninstall_table);
 
-		ACPI_FREE(table_desc->pointer);
-		table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
-		break;
+	/* Table must be installed */
 
-		/* Not mapped or allocated, there is nothing we can do */
+	if (!table_desc->address) {
+		return_VOID;
+	}
 
-	default:
+	acpi_tb_invalidate_table(table_desc);
 
-		return;
+	if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
+	    ACPI_TABLE_ORIGIN_ALLOCATED) {
+		ACPI_FREE(ACPI_CAST_PTR(void, table_desc->address));
 	}
 
-	table_desc->pointer = NULL;
+	table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
+
+	return_VOID;
 }
 
 /*******************************************************************************
@@ -522,7 +633,7 @@ void acpi_tb_terminate(void)
 	/* Delete the individual tables */
 
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; i++) {
-		acpi_tb_delete_table(&acpi_gbl_root_table_list.tables[i]);
+		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 9b6992d..c61432f 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -178,7 +178,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 	}
 
 	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
-	acpi_tb_delete_table(table_desc);
+	acpi_tb_uninstall_table(table_desc);
 	table_desc->address = ACPI_PTR_TO_PHYSADDR(new_table);
 	table_desc->pointer = new_table;
 	table_desc->flags = ACPI_TABLE_ORIGIN_ALLOCATED;
@@ -268,7 +268,7 @@ acpi_tb_install_table(acpi_physical_address address,
 	 * fully mapped later (in verify table). In any case, we must
 	 * unmap the header that was mapped above.
 	 */
-	final_table = acpi_tb_table_override(table, table_desc);
+	final_table = acpi_tb_override_table(table, table_desc);
 	if (!final_table) {
 		final_table = table;	/* There was no override */
 	}
@@ -290,7 +290,12 @@ acpi_tb_install_table(acpi_physical_address address,
 	 * flag set and will not be deleted below.
 	 */
 	if (final_table != table) {
-		acpi_tb_delete_table(table_desc);
+		/*
+		 * Table is in "INSTALLED" state, the final_table pointer is not
+		 * maintained in the root table list.
+		 */
+		acpi_tb_release_table(final_table, table_desc->length,
+				      table_desc->flags);
 	}
 
 unmap_and_exit:
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 4debc12..ae3fe4d 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -346,7 +346,7 @@ acpi_get_table_with_size(char *signature,
 		}
 
 		status =
-		    acpi_tb_verify_table(&acpi_gbl_root_table_list.tables[i]);
+		    acpi_tb_validate_table(&acpi_gbl_root_table_list.tables[i]);
 		if (ACPI_SUCCESS(status)) {
 			*out_table = acpi_gbl_root_table_list.tables[i].pointer;
 			*tbl_size = acpi_gbl_root_table_list.tables[i].length;
@@ -416,8 +416,8 @@ acpi_get_table_by_index(u32 table_index, struct acpi_table_header ** table)
 		/* Table is not mapped, map it */
 
 		status =
-		    acpi_tb_verify_table(&acpi_gbl_root_table_list.
-					 tables[table_index]);
+		    acpi_tb_validate_table(&acpi_gbl_root_table_list.
+					   tables[table_index]);
 		if (ACPI_FAILURE(status)) {
 			(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 			return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 0909420..a2899b0 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -117,7 +117,7 @@ static acpi_status acpi_tb_load_namespace(void)
 				tables[ACPI_TABLE_INDEX_DSDT].signature),
 			       ACPI_SIG_DSDT)
 	    ||
-	    ACPI_FAILURE(acpi_tb_verify_table
+	    ACPI_FAILURE(acpi_tb_validate_table
 			 (&acpi_gbl_root_table_list.
 			  tables[ACPI_TABLE_INDEX_DSDT]))) {
 		status = AE_NO_ACPI_TABLES;
@@ -128,7 +128,7 @@ static acpi_status acpi_tb_load_namespace(void)
 	 * Save the DSDT pointer for simple access. This is the mapped memory
 	 * address. We must take care here because the address of the .Tables
 	 * array can change dynamically as tables are loaded at run-time. Note:
-	 * .Pointer field is not validated until after call to acpi_tb_verify_table.
+	 * .Pointer field is not validated until after call to acpi_tb_validate_table.
 	 */
 	acpi_gbl_DSDT =
 	    acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].pointer;
@@ -174,7 +174,7 @@ static acpi_status acpi_tb_load_namespace(void)
 					(acpi_gbl_root_table_list.tables[i].
 					 signature), ACPI_SIG_PSDT))
 		    ||
-		    ACPI_FAILURE(acpi_tb_verify_table
+		    ACPI_FAILURE(acpi_tb_validate_table
 				 (&acpi_gbl_root_table_list.tables[i]))) {
 			continue;
 		}
-- 
1.7.10

