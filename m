From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 2/7] ACPICA: Tables: Add sanity check for load_table opcode
Date: Wed, 15 Mar 2017 14:37:02 +0800
Message-ID: <22eed5748743dc30c9fe9e2f8c9a89aaeab3f446.1489558845.git.lv.zheng@intel.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21573 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdCOGhQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 02:37:16 -0400
In-Reply-To: <cover.1489558845.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

This patch refines table load sanity checks, moving them to
acpi_tb_load_table() so that it can cover load_table opcode. Note that table
index should be updated to the duplicate table according to the current
design (no table uninstall). Reported by Hans de Goede, fixed by Lv Zheng.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/actables.h |   2 +-
 drivers/acpi/acpica/exconfig.c |   2 +-
 drivers/acpi/acpica/tbdata.c   | 174 ++++++++++++++++++++++++++++++++++++++---
 drivers/acpi/acpica/tbinstal.c | 160 +++----------------------------------
 4 files changed, 180 insertions(+), 158 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 89ed31b..1509797 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -124,7 +124,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
 
 acpi_status
-acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node);
+acpi_tb_load_table(u32 *table_index, struct acpi_namespace_node *parent_node);
 
 acpi_status
 acpi_tb_install_and_load_table(acpi_physical_address address,
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 61813bd..c82ea9b 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -197,7 +197,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	ACPI_INFO(("Dynamic OEM Table Load:"));
 	acpi_ex_exit_interpreter();
-	status = acpi_tb_load_table(table_index, parent_node);
+	status = acpi_tb_load_table(&table_index, parent_node);
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 42ea044..b7bff76 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -50,6 +50,14 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbdata")
 
+/* Local prototypes */
+static u8
+acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
+
+static acpi_status
+acpi_tb_validate_table_for_load(u32 *table_index,
+				struct acpi_table_header **out_table);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_init_table_descriptor
@@ -64,6 +72,7 @@ ACPI_MODULE_NAME("tbdata")
  * DESCRIPTION: Initialize a new table descriptor
  *
  ******************************************************************************/
+
 void
 acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
 			      acpi_physical_address address,
@@ -770,6 +779,155 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_compare_tables
+ *
+ * PARAMETERS:  table_desc          - Table 1 descriptor to be compared
+ *              table_index         - Index of table 2 to be compared
+ *
+ * RETURN:      TRUE if both tables are identical.
+ *
+ * DESCRIPTION: This function compares a table with another table that has
+ *              already been installed in the root table list.
+ *
+ ******************************************************************************/
+
+static u8
+acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
+{
+	acpi_status status = AE_OK;
+	u8 is_identical;
+	struct acpi_table_header *table;
+	u32 table_length;
+	u8 table_flags;
+
+	status =
+	    acpi_tb_acquire_table(&acpi_gbl_root_table_list.tables[table_index],
+				  &table, &table_length, &table_flags);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	/*
+	 * Check for a table match on the entire table length,
+	 * not just the header.
+	 */
+	is_identical = (u8)((table_desc->length != table_length ||
+			     memcmp(table_desc->pointer, table, table_length)) ?
+			    FALSE : TRUE);
+
+	/* Release the acquired table */
+
+	acpi_tb_release_table(table, table_length, table_flags);
+	return (is_identical);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_validate_table_for_load
+ *
+ * PARAMETERS:  table_index         - Index of table
+ *              out_table           - Validated table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function returns failures if a table cannot be loaded.
+ *              For now, we use special logic to avoid reloading of tables,
+ *              as such, table index may be updated.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_tb_validate_table_for_load(u32 *table_index,
+				struct acpi_table_header **out_table)
+{
+	u32 i;
+	struct acpi_table_desc *table_desc;
+	acpi_status status = AE_OK;
+
+	/* Acquire the table lock */
+
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+	table_desc = &acpi_gbl_root_table_list.tables[*table_index];
+
+	/*
+	 * Note: Now table is "INSTALLED", it must be validated before
+	 * using.
+	 */
+	status = acpi_tb_get_table(table_desc, out_table);
+	if (ACPI_FAILURE(status)) {
+		goto unlock_and_exit;
+	}
+
+	/*
+	 * Validate the incoming table signature.
+	 *
+	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
+	 * 2) We added support for OEMx tables, signature "OEM".
+	 * 3) Valid tables were encountered with a null signature, so we just
+	 *    gave up on validating the signature, (05/2008).
+	 * 4) We encountered non-AML tables such as the MADT, which caused
+	 *    interpreter errors and kernel faults. So now, we once again allow
+	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
+	 */
+	if ((table_desc->signature.ascii[0] != 0x00) &&
+	    (!ACPI_COMPARE_NAME(&table_desc->signature, ACPI_SIG_SSDT)) &&
+	    (strncmp(table_desc->signature.ascii, "OEM", 3))) {
+		ACPI_BIOS_ERROR((AE_INFO,
+				 "Table has invalid signature [%4.4s] (0x%8.8X), "
+				 "must be SSDT or OEMx",
+				 acpi_ut_valid_nameseg(table_desc->signature.
+						       ascii) ? table_desc->
+				 signature.ascii : "????",
+				 table_desc->signature.integer));
+
+		status = AE_BAD_SIGNATURE;
+		goto unlock_and_exit;
+	}
+
+	/* Check if table is already loaded */
+
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+		/*
+		 * Check for a table match on the entire table length, not just the
+		 * header.
+		 */
+		if (!acpi_tb_compare_tables(table_desc, i)) {
+			continue;
+		}
+
+		/*
+		 * Note: the current mechanism does not unregister a table if it is
+		 * dynamically unloaded. The related namespace entries are deleted,
+		 * but the table remains in the root table list.
+		 *
+		 * The assumption here is that the number of different tables that
+		 * will be loaded is actually small, and there is minimal overhead
+		 * in just keeping the table in case it is needed again.
+		 *
+		 * If this assumption changes in the future (perhaps on large
+		 * machines with many table load/unload operations), tables will
+		 * need to be unregistered when they are unloaded, and slots in the
+		 * root table list should be reused when empty.
+		 */
+		*table_index = i;
+		if (acpi_gbl_root_table_list.tables[i].
+		    flags & ACPI_TABLE_IS_LOADED) {
+			status = AE_ALREADY_EXISTS;
+			goto unlock_and_exit;
+		}
+	}
+
+unlock_and_exit:
+
+	/* Release the table lock */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	return (status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_load_table
  *
  * PARAMETERS:  table_index             - Table index
@@ -782,7 +940,7 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
  ******************************************************************************/
 
 acpi_status
-acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
+acpi_tb_load_table(u32 *table_index, struct acpi_namespace_node *parent_node)
 {
 	struct acpi_table_header *table;
 	acpi_status status;
@@ -790,16 +948,14 @@ acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
 
 	ACPI_FUNCTION_TRACE(tb_load_table);
 
-	/*
-	 * Note: Now table is "INSTALLED", it must be validated before
-	 * using.
-	 */
-	status = acpi_get_table_by_index(table_index, &table);
+	/* Sanity checks */
+
+	status = acpi_tb_validate_table_for_load(table_index, &table);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
-	status = acpi_ns_load_table(table_index, parent_node);
+	status = acpi_ns_load_table(*table_index, parent_node);
 
 	/* Execute any module-level code that was found in the table */
 
@@ -813,7 +969,7 @@ acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
 	 * responsible for discovering any new wake GPEs by running _PRW methods
 	 * that may have been loaded by this table.
 	 */
-	status = acpi_tb_get_owner_id(table_index, &owner_id);
+	status = acpi_tb_get_owner_id(*table_index, &owner_id);
 	if (ACPI_SUCCESS(status)) {
 		acpi_ev_update_gpes(owner_id);
 	}
@@ -856,7 +1012,7 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 		goto exit;
 	}
 
-	status = acpi_tb_load_table(i, acpi_gbl_root_node);
+	status = acpi_tb_load_table(&i, acpi_gbl_root_node);
 
 exit:
 	*table_index = i;
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index ee74515..5e3d445 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -48,54 +48,6 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbinstal")
 
-/* Local prototypes */
-static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_compare_tables
- *
- * PARAMETERS:  table_desc          - Table 1 descriptor to be compared
- *              table_index         - Index of table 2 to be compared
- *
- * RETURN:      TRUE if both tables are identical.
- *
- * DESCRIPTION: This function compares a table with another table that has
- *              already been installed in the root table list.
- *
- ******************************************************************************/
-
-static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
-{
-	acpi_status status = AE_OK;
-	u8 is_identical;
-	struct acpi_table_header *table;
-	u32 table_length;
-	u8 table_flags;
-
-	status =
-	    acpi_tb_acquire_table(&acpi_gbl_root_table_list.tables[table_index],
-				  &table, &table_length, &table_flags);
-	if (ACPI_FAILURE(status)) {
-		return (FALSE);
-	}
-
-	/*
-	 * Check for a table match on the entire table length,
-	 * not just the header.
-	 */
-	is_identical = (u8)((table_desc->length != table_length ||
-			     memcmp(table_desc->pointer, table, table_length)) ?
-			    FALSE : TRUE);
-
-	/* Release the acquired table */
-
-	acpi_tb_release_table(table, table_length, table_flags);
-	return (is_identical);
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_install_table_with_override
@@ -112,7 +64,6 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
  *              table array.
  *
  ******************************************************************************/
-
 void
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 				    u8 override, u32 *table_index)
@@ -120,11 +71,6 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 	u32 i;
 	acpi_status status;
 
-	status = acpi_tb_get_next_table_descriptor(&i, NULL);
-	if (ACPI_FAILURE(status)) {
-		return;
-	}
-
 	/*
 	 * ACPI Table Override:
 	 *
@@ -136,6 +82,15 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 		acpi_tb_override_table(new_table_desc);
 	}
 
+	/* Acquire the table lock */
+
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+	status = acpi_tb_get_next_table_descriptor(&i, NULL);
+	if (ACPI_FAILURE(status)) {
+		return;
+	}
+
 	acpi_tb_init_table_descriptor(&acpi_gbl_root_table_list.tables[i],
 				      new_table_desc->address,
 				      new_table_desc->flags,
@@ -153,6 +108,10 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 	if (i == acpi_gbl_dsdt_index) {
 		acpi_ut_set_integer_width(new_table_desc->pointer->revision);
 	}
+
+	/* Release the table lock */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 }
 
 /*******************************************************************************
@@ -181,7 +140,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 			       u8 flags,
 			       u8 reload, u8 override, u32 *table_index)
 {
-	u32 i;
 	acpi_status status = AE_OK;
 	struct acpi_table_desc new_table_desc;
 
@@ -217,90 +175,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 		goto release_and_exit;
 	}
 
-	/* Acquire the table lock */
-
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-
-	if (reload) {
-		/*
-		 * Validate the incoming table signature.
-		 *
-		 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
-		 * 2) We added support for OEMx tables, signature "OEM".
-		 * 3) Valid tables were encountered with a null signature, so we just
-		 *    gave up on validating the signature, (05/2008).
-		 * 4) We encountered non-AML tables such as the MADT, which caused
-		 *    interpreter errors and kernel faults. So now, we once again allow
-		 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
-		 */
-		if ((new_table_desc.signature.ascii[0] != 0x00) &&
-		    (!ACPI_COMPARE_NAME
-		     (&new_table_desc.signature, ACPI_SIG_SSDT))
-		    && (strncmp(new_table_desc.signature.ascii, "OEM", 3))) {
-			ACPI_BIOS_ERROR((AE_INFO,
-					 "Table has invalid signature [%4.4s] (0x%8.8X), "
-					 "must be SSDT or OEMx",
-					 acpi_ut_valid_nameseg(new_table_desc.
-							       signature.
-							       ascii) ?
-					 new_table_desc.signature.
-					 ascii : "????",
-					 new_table_desc.signature.integer));
-
-			status = AE_BAD_SIGNATURE;
-			goto unlock_and_exit;
-		}
-
-		/* Check if table is already registered */
-
-		for (i = 0; i < acpi_gbl_root_table_list.current_table_count;
-		     ++i) {
-			/*
-			 * Check for a table match on the entire table length,
-			 * not just the header.
-			 */
-			if (!acpi_tb_compare_tables(&new_table_desc, i)) {
-				continue;
-			}
-
-			/*
-			 * Note: the current mechanism does not unregister a table if it is
-			 * dynamically unloaded. The related namespace entries are deleted,
-			 * but the table remains in the root table list.
-			 *
-			 * The assumption here is that the number of different tables that
-			 * will be loaded is actually small, and there is minimal overhead
-			 * in just keeping the table in case it is needed again.
-			 *
-			 * If this assumption changes in the future (perhaps on large
-			 * machines with many table load/unload operations), tables will
-			 * need to be unregistered when they are unloaded, and slots in the
-			 * root table list should be reused when empty.
-			 */
-			if (acpi_gbl_root_table_list.tables[i].flags &
-			    ACPI_TABLE_IS_LOADED) {
-
-				/* Table is still loaded, this is an error */
-
-				status = AE_ALREADY_EXISTS;
-				goto unlock_and_exit;
-			} else {
-				/*
-				 * Table was unloaded, allow it to be reloaded.
-				 * As we are going to return AE_OK to the caller, we should
-				 * take the responsibility of freeing the input descriptor.
-				 * Refill the input descriptor to ensure
-				 * acpi_tb_install_table_with_override() can be called again to
-				 * indicate the re-installation.
-				 */
-				acpi_tb_uninstall_table(&new_table_desc);
-				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-				*table_index = i;
-				return_ACPI_STATUS(AE_OK);
-			}
-		}
-	}
-
 	/* Add the table to the global root table list */
 
 	acpi_tb_install_table_with_override(&new_table_desc, override,
@@ -308,15 +182,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	/* Invoke table handler */
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	acpi_tb_notify_table(ACPI_TABLE_EVENT_INSTALL, new_table_desc.pointer);
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-
-unlock_and_exit:
-
-	/* Release the table lock */
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 
 release_and_exit:
 
-- 
2.7.4

