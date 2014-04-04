From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/28] ACPICA: Table Manager: Misc cleanup and renames, no functional change.
Date: Fri,  4 Apr 2014 12:39:26 +0800
Message-ID: <a990e4e058903c7ea56d5cfe597dab6e55c31ed2.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22847 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbaDDEji (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:38 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some various cleanups and renames.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |   18 ++--
 drivers/acpi/acpica/exconfig.c |    8 +-
 drivers/acpi/acpica/tbinstal.c |  179 +++++++++++++++++++++-------------------
 drivers/acpi/acpica/tbutils.c  |   20 +++--
 drivers/acpi/acpica/tbxface.c  |    2 +-
 drivers/acpi/acpica/tbxfload.c |   16 ++--
 include/acpi/actbl.h           |    6 +-
 7 files changed, 133 insertions(+), 116 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 3d20a96..ade430c 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -91,9 +91,9 @@ acpi_tb_release_table(struct acpi_table_header *table,
 		      u32 table_length, u8 table_flags);
 
 acpi_status
-acpi_tb_install_non_fixed_table(acpi_physical_address address,
-				u8 flags,
-				u8 reload, u8 override, u32 *table_index);
+acpi_tb_install_standard_table(acpi_physical_address address,
+			       u8 flags,
+			       u8 reload, u8 override, u32 *table_index);
 
 acpi_status
 acpi_tb_store_table(acpi_physical_address address,
@@ -137,14 +137,14 @@ void acpi_tb_check_dsdt_header(void);
 struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
 
 void
-acpi_tb_install_table(struct acpi_table_desc *table_desc,
-		      acpi_physical_address address,
-		      u8 flags, struct acpi_table_header *table);
+acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
+			      acpi_physical_address address,
+			      u8 flags, struct acpi_table_header *table);
 
 void
-acpi_tb_install_and_override_table(u32 table_index,
-				   struct acpi_table_desc *new_table_desc,
-				   u8 override);
+acpi_tb_install_table_with_override(u32 table_index,
+				    struct acpi_table_desc *new_table_desc,
+				    u8 override);
 
 acpi_status
 acpi_tb_install_fixed_table(acpi_physical_address address,
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 815003d..7d29494 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -482,9 +482,11 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 	ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
-						 ACPI_TABLE_ORIGIN_INTERN_VIRTUAL,
-						 TRUE, TRUE, &table_index);
+
+	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
+						ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
+						TRUE, TRUE, &table_index);
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9835213..50a6f22 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -51,12 +51,12 @@ ACPI_MODULE_NAME("tbinstal")
 
 /* Local prototypes */
 static acpi_status
-acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
-			       acpi_physical_address address, u8 flags);
+acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
+			   acpi_physical_address address, u8 flags);
 
-static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc);
+static void acpi_tb_release_temp_table(struct acpi_table_desc *table_desc);
 
-static acpi_status acpi_tb_acquire_root_table_entry(u32 *table_index);
+static acpi_status acpi_tb_get_root_table_entry(u32 *table_index);
 
 static u8
 acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc,
@@ -73,8 +73,8 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Acquire a table. It can be used for tables not maintained in
- *              acpi_gbl_root_table_list.
+ * DESCRIPTION: Acquire an ACPI table. It can be used for tables not
+ *              maintained in the acpi_gbl_root_table_list.
  *
  ******************************************************************************/
 
@@ -86,14 +86,14 @@ acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
 	struct acpi_table_header *table = NULL;
 
 	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_INTERN_PHYSICAL:
+	case ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL:
 
 		table =
 		    acpi_os_map_memory(table_desc->address, table_desc->length);
 		break;
 
-	case ACPI_TABLE_ORIGIN_INTERN_VIRTUAL:
-	case ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL:
 
 		table =
 		    ACPI_CAST_PTR(struct acpi_table_header,
@@ -116,7 +116,6 @@ acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
 	*table_ptr = table;
 	*table_length = table_desc->length;
 	*table_flags = table_desc->flags;
-
 	return (AE_OK);
 }
 
@@ -130,7 +129,7 @@ acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
  *
  * RETURN:      None
  *
- * DESCRIPTION: Release a table. The reversal of acpi_tb_acquire_table().
+ * DESCRIPTION: Release a table. The inverse of acpi_tb_acquire_table().
  *
  ******************************************************************************/
 
@@ -138,14 +137,15 @@ void
 acpi_tb_release_table(struct acpi_table_header *table,
 		      u32 table_length, u8 table_flags)
 {
+
 	switch (table_flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_INTERN_PHYSICAL:
+	case ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL:
 
 		acpi_os_unmap_memory(table, table_length);
 		break;
 
-	case ACPI_TABLE_ORIGIN_INTERN_VIRTUAL:
-	case ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL:
 	default:
 
 		break;
@@ -193,7 +193,7 @@ acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Invalidate one internal ACPI table, this is reversal of
+ * DESCRIPTION: Invalidate one internal ACPI table, this is the inverse of
  *              acpi_tb_validate_table().
  *
  ******************************************************************************/
@@ -278,7 +278,7 @@ invalidate_and_exit:
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_install_table
+ * FUNCTION:    acpi_tb_init_table_descriptor
  *
  * PARAMETERS:  table_desc              - Table descriptor
  *              address                 - Physical address of the table
@@ -287,17 +287,18 @@ invalidate_and_exit:
  *
  * RETURN:      None
  *
- * DESCRIPTION: Install an ACPI table into the global data structure.
+ * DESCRIPTION: Initialize a new table descriptor
  *
  ******************************************************************************/
 
 void
-acpi_tb_install_table(struct acpi_table_desc *table_desc,
-		      acpi_physical_address address,
-		      u8 flags, struct acpi_table_header *table)
+acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
+			      acpi_physical_address address,
+			      u8 flags, struct acpi_table_header *table)
 {
+
 	/*
-	 * Initialize the table entry. Set the pointer to NULL, since the
+	 * Initialize the table descriptor. Set the pointer to NULL, since the
 	 * table is not fully mapped at this time.
 	 */
 	ACPI_MEMSET(table_desc, 0, sizeof(struct acpi_table_desc));
@@ -309,7 +310,7 @@ acpi_tb_install_table(struct acpi_table_desc *table_desc,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_acquire_temporal_table
+ * FUNCTION:    acpi_tb_acquire_temp_table
  *
  * PARAMETERS:  table_desc          - Table descriptor to be acquired
  *              address             - Address of the table
@@ -319,21 +320,21 @@ acpi_tb_install_table(struct acpi_table_desc *table_desc,
  *
  * DESCRIPTION: This function validates the table header to obtain the length
  *              of a table and fills the table descriptor to make its state as
- *              "INSTALLED".  Such table descriptor is only used for verified
+ *              "INSTALLED". Such a table descriptor is only used for verified
  *              installation.
  *
  ******************************************************************************/
 
 static acpi_status
-acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
-			       acpi_physical_address address, u8 flags)
+acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
+			   acpi_physical_address address, u8 flags)
 {
 	struct acpi_table_header *table_header;
 
 	switch (flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_INTERN_PHYSICAL:
+	case ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL:
 
-		/* Try to obtain the length of the table */
+		/* Get the length of the full table from the header */
 
 		table_header =
 		    acpi_os_map_memory(address,
@@ -341,19 +342,23 @@ acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
 		if (!table_header) {
 			return (AE_NO_MEMORY);
 		}
-		acpi_tb_install_table(table_desc, address, flags, table_header);
+
+		acpi_tb_init_table_descriptor(table_desc, address, flags,
+					      table_header);
 		acpi_os_unmap_memory(table_header,
 				     sizeof(struct acpi_table_header));
 		return (AE_OK);
 
-	case ACPI_TABLE_ORIGIN_INTERN_VIRTUAL:
-	case ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL:
 
 		table_header = ACPI_CAST_PTR(struct acpi_table_header, address);
 		if (!table_header) {
 			return (AE_NO_MEMORY);
 		}
-		acpi_tb_install_table(table_desc, address, flags, table_header);
+
+		acpi_tb_init_table_descriptor(table_desc, address, flags,
+					      table_header);
 		return (AE_OK);
 
 	default:
@@ -368,21 +373,22 @@ acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_release_temporal_table
+ * FUNCTION:    acpi_tb_release_temp_table
  *
  * PARAMETERS:  table_desc          - Table descriptor to be released
  *
  * RETURN:      Status
  *
- * DESCRIPTION: The reversal of acpi_tb_acquire_temporal_table().
+ * DESCRIPTION: The inverse of acpi_tb_acquire_temp_table().
  *
  ******************************************************************************/
 
-static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc)
+static void acpi_tb_release_temp_table(struct acpi_table_desc *table_desc)
 {
+
 	/*
 	 * Note that the .Address is maintained by the callers of
-	 * acpi_tb_acquire_temporal_table(), thus do not invoke acpi_tb_uninstall_table()
+	 * acpi_tb_acquire_temp_table(), thus do not invoke acpi_tb_uninstall_table()
 	 * where .Address will be freed.
 	 */
 	acpi_tb_invalidate_table(table_desc);
@@ -390,7 +396,7 @@ static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_install_and_override_table
+ * FUNCTION:    acpi_tb_install_table_with_override
  *
  * PARAMETERS:  table_index             - Index into root table array
  *              new_table_desc          - New table descriptor to install
@@ -406,10 +412,11 @@ static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc)
  ******************************************************************************/
 
 void
-acpi_tb_install_and_override_table(u32 table_index,
-				   struct acpi_table_desc *new_table_desc,
-				   u8 override)
+acpi_tb_install_table_with_override(u32 table_index,
+				    struct acpi_table_desc *new_table_desc,
+				    u8 override)
 {
+
 	if (table_index >= acpi_gbl_root_table_list.current_table_count) {
 		return;
 	}
@@ -425,9 +432,11 @@ acpi_tb_install_and_override_table(u32 table_index,
 		acpi_tb_override_table(new_table_desc);
 	}
 
-	acpi_tb_install_table(&acpi_gbl_root_table_list.tables[table_index],
-			      new_table_desc->address, new_table_desc->flags,
-			      new_table_desc->pointer);
+	acpi_tb_init_table_descriptor(&acpi_gbl_root_table_list.
+				      tables[table_index],
+				      new_table_desc->address,
+				      new_table_desc->flags,
+				      new_table_desc->pointer);
 
 	acpi_tb_print_table_header(new_table_desc->address,
 				   new_table_desc->pointer);
@@ -473,8 +482,8 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 
 	/* Fill a table descriptor for validation */
 
-	status = acpi_tb_acquire_temporal_table(&new_table_desc, address,
-						ACPI_TABLE_ORIGIN_INTERN_PHYSICAL);
+	status = acpi_tb_acquire_temp_table(&new_table_desc, address,
+					    ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
 			    ACPI_CAST_PTR(void, address)));
@@ -488,13 +497,13 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 		goto release_and_exit;
 	}
 
-	acpi_tb_install_and_override_table(table_index, &new_table_desc, TRUE);
+	acpi_tb_install_table_with_override(table_index, &new_table_desc, TRUE);
 
 release_and_exit:
 
-	/* Release the temporal table descriptor */
+	/* Release the temporary table descriptor */
 
-	acpi_tb_release_temporal_table(&new_table_desc);
+	acpi_tb_release_temp_table(&new_table_desc);
 	return_ACPI_STATUS(status);
 }
 
@@ -539,13 +548,12 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
 	/* Release the acquired table */
 
 	acpi_tb_release_table(table, table_length, table_flags);
-
 	return (is_equivalent);
 }
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_install_non_fixed_table
+ * FUNCTION:    acpi_tb_install_standard_table
  *
  * PARAMETERS:  address             - Address of the table (might be a virtual
  *                                    address depending on the table_flags)
@@ -557,7 +565,7 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
  * RETURN:      Status
  *
  * DESCRIPTION: This function is called to install an ACPI table that is
- *              neither DSDT nor FACS.
+ *              neither DSDT nor FACS (a "standard" table.)
  *              When this function is called by "Load" or "LoadTable" opcodes,
  *              or by acpi_load_table() API, the "Reload" parameter is set.
  *              After sucessfully returning from this function, table is
@@ -566,20 +574,19 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
  ******************************************************************************/
 
 acpi_status
-acpi_tb_install_non_fixed_table(acpi_physical_address address,
-				u8 flags,
-				u8 reload, u8 override, u32 *table_index)
+acpi_tb_install_standard_table(acpi_physical_address address,
+			       u8 flags,
+			       u8 reload, u8 override, u32 *table_index)
 {
 	u32 i;
 	acpi_status status = AE_OK;
 	struct acpi_table_desc new_table_desc;
 
-	ACPI_FUNCTION_TRACE(tb_install_non_fixed_table);
+	ACPI_FUNCTION_TRACE(tb_install_standard_table);
 
-	/* Acquire a temporal table descriptor for validation */
+	/* Acquire a temporary table descriptor for validation */
 
-	status =
-	    acpi_tb_acquire_temporal_table(&new_table_desc, address, flags);
+	status = acpi_tb_acquire_temp_table(&new_table_desc, address, flags);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
 			    ACPI_CAST_PTR(void, address)));
@@ -590,7 +597,8 @@ acpi_tb_install_non_fixed_table(acpi_physical_address address,
 	 * Optionally do not load any SSDTs from the RSDT/XSDT. This can
 	 * be useful for debugging ACPI problems on some machines.
 	 */
-	if (!reload && acpi_gbl_disable_ssdt_table_install &&
+	if (!reload &&
+	    acpi_gbl_disable_ssdt_table_install &&
 	    ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG_SSDT)) {
 		ACPI_INFO((AE_INFO, "Ignoring installation of %4.4s at %p",
 			   new_table_desc.signature.ascii, ACPI_CAST_PTR(void,
@@ -675,7 +683,7 @@ acpi_tb_install_non_fixed_table(acpi_physical_address address,
 				 * As we are going to return AE_OK to the caller, we should
 				 * take the responsibility of freeing the input descriptor.
 				 * Refill the input descriptor to ensure
-				 * acpi_tb_install_and_override_table() can be called again to
+				 * acpi_tb_install_table_with_override() can be called again to
 				 * indicate the re-installation.
 				 */
 				acpi_tb_uninstall_table(&new_table_desc);
@@ -688,18 +696,19 @@ acpi_tb_install_non_fixed_table(acpi_physical_address address,
 
 	/* Add the table to the global root table list */
 
-	status = acpi_tb_acquire_root_table_entry(&i);
+	status = acpi_tb_get_root_table_entry(&i);
 	if (ACPI_FAILURE(status)) {
 		goto release_and_exit;
 	}
+
 	*table_index = i;
-	acpi_tb_install_and_override_table(i, &new_table_desc, override);
+	acpi_tb_install_table_with_override(i, &new_table_desc, override);
 
 release_and_exit:
 
-	/* Release the temporal table descriptor */
+	/* Release the temporary table descriptor */
 
-	acpi_tb_release_temporal_table(&new_table_desc);
+	acpi_tb_release_temp_table(&new_table_desc);
 	return_ACPI_STATUS(status);
 }
 
@@ -733,9 +742,9 @@ void acpi_tb_override_table(struct acpi_table_desc *old_table_desc)
 
 	status = acpi_os_table_override(old_table_desc->pointer, &table);
 	if (ACPI_SUCCESS(status) && table) {
-		acpi_tb_acquire_temporal_table(&new_table_desc,
-					       ACPI_PTR_TO_PHYSADDR(table),
-					       ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL);
+		acpi_tb_acquire_temp_table(&new_table_desc,
+					   ACPI_PTR_TO_PHYSADDR(table),
+					   ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL);
 		override_type = "Logical";
 		goto finish_override;
 	}
@@ -745,8 +754,8 @@ void acpi_tb_override_table(struct acpi_table_desc *old_table_desc)
 	status = acpi_os_physical_table_override(old_table_desc->pointer,
 						 &address, &length);
 	if (ACPI_SUCCESS(status) && address && length) {
-		acpi_tb_acquire_temporal_table(&new_table_desc, address,
-					       ACPI_TABLE_ORIGIN_INTERN_PHYSICAL);
+		acpi_tb_acquire_temp_table(&new_table_desc, address,
+					   ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL);
 		override_type = "Physical";
 		goto finish_override;
 	}
@@ -776,13 +785,14 @@ finish_override:
 	 * Replace the original table descriptor and keep its state as
 	 * "VALIDATED".
 	 */
-	acpi_tb_install_table(old_table_desc, new_table_desc.address,
-			      new_table_desc.flags, new_table_desc.pointer);
+	acpi_tb_init_table_descriptor(old_table_desc, new_table_desc.address,
+				      new_table_desc.flags,
+				      new_table_desc.pointer);
 	acpi_tb_validate_table(old_table_desc);
 
-	/* Release the temporal table descriptor */
+	/* Release the temporary table descriptor */
 
-	acpi_tb_release_temporal_table(&new_table_desc);
+	acpi_tb_release_temp_table(&new_table_desc);
 }
 
 /*******************************************************************************
@@ -851,7 +861,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_acquire_root_table_entry
+ * FUNCTION:    acpi_tb_get_root_table_entry
  *
  * PARAMETERS:  table_index         - Where table index is returned
  *
@@ -861,7 +871,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
  *
  ******************************************************************************/
 
-static acpi_status acpi_tb_acquire_root_table_entry(u32 *table_index)
+static acpi_status acpi_tb_get_root_table_entry(u32 *table_index)
 {
 	acpi_status status;
 
@@ -887,7 +897,8 @@ static acpi_status acpi_tb_acquire_root_table_entry(u32 *table_index)
  * PARAMETERS:  address             - Table address
  *              table               - Table header
  *              length              - Table length
- *              flags               - flags
+ *              flags               - Install flags
+ *              table_index         - Where the table index is returned
  *
  * RETURN:      Status and table index.
  *
@@ -903,7 +914,7 @@ acpi_tb_store_table(acpi_physical_address address,
 	acpi_status status;
 	struct acpi_table_desc *table_desc;
 
-	status = acpi_tb_acquire_root_table_entry(table_index);
+	status = acpi_tb_get_root_table_entry(table_index);
 	if (ACPI_FAILURE(status)) {
 		return (status);
 	}
@@ -911,9 +922,8 @@ acpi_tb_store_table(acpi_physical_address address,
 	/* Initialize added table */
 
 	table_desc = &acpi_gbl_root_table_list.tables[*table_index];
-	acpi_tb_install_table(table_desc, address, flags, table);
+	acpi_tb_init_table_descriptor(table_desc, address, flags, table);
 	table_desc->pointer = table;
-
 	return (AE_OK);
 }
 
@@ -943,12 +953,11 @@ void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc)
 	acpi_tb_invalidate_table(table_desc);
 
 	if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
-	    ACPI_TABLE_ORIGIN_INTERN_VIRTUAL) {
+	    ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL) {
 		ACPI_FREE(ACPI_CAST_PTR(void, table_desc->address));
 	}
 
 	table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
-
 	return_VOID;
 }
 
@@ -991,8 +1000,8 @@ void acpi_tb_terminate(void)
 	acpi_gbl_root_table_list.current_table_count = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "ACPI Tables freed\n"));
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_VOID;
 }
 
@@ -1074,8 +1083,10 @@ acpi_status acpi_tb_allocate_owner_id(u32 table_index)
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	if (table_index < acpi_gbl_root_table_list.current_table_count) {
-		status = acpi_ut_allocate_owner_id
-		    (&(acpi_gbl_root_table_list.tables[table_index].owner_id));
+		status =
+		    acpi_ut_allocate_owner_id(&
+					      (acpi_gbl_root_table_list.
+					       tables[table_index].owner_id));
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
@@ -1146,7 +1157,7 @@ acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id * owner_id)
  *
  * FUNCTION:    acpi_tb_is_table_loaded
  *
- * PARAMETERS:  table_index         - Table index
+ * PARAMETERS:  table_index         - Index into the root table
  *
  * RETURN:      Table Loaded Flag
  *
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index aa11949..6c31d77 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -179,10 +179,12 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 
 	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
 	acpi_tb_uninstall_table(table_desc);
-	acpi_tb_install_table(&acpi_gbl_root_table_list.
-			      tables[ACPI_TABLE_INDEX_DSDT],
-			      ACPI_PTR_TO_PHYSADDR(new_table),
-			      ACPI_TABLE_ORIGIN_INTERN_VIRTUAL, new_table);
+
+	acpi_tb_init_table_descriptor(&acpi_gbl_root_table_list.
+				      tables[ACPI_TABLE_INDEX_DSDT],
+				      ACPI_PTR_TO_PHYSADDR(new_table),
+				      ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
+				      new_table);
 
 	ACPI_INFO((AE_INFO,
 		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
@@ -470,11 +472,11 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 		/* Get the table physical address (32-bit for RSDT, 64-bit for XSDT) */
 
 		status =
-		    acpi_tb_install_non_fixed_table(acpi_tb_get_root_table_entry
-						    (table_entry,
-						     table_entry_size),
-						    ACPI_TABLE_ORIGIN_INTERN_PHYSICAL,
-						    FALSE, TRUE, &table_index);
+		    acpi_tb_install_standard_table(acpi_tb_get_root_table_entry
+						   (table_entry,
+						    table_entry_size),
+						   ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+						   FALSE, TRUE, &table_index);
 
 		if (ACPI_SUCCESS(status) &&
 		    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 19c0b13..6482b0d 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -233,7 +233,7 @@ acpi_get_table_header(char *signature,
 		if (!acpi_gbl_root_table_list.tables[i].pointer) {
 			if ((acpi_gbl_root_table_list.tables[i].flags &
 			     ACPI_TABLE_ORIGIN_MASK) ==
-			    ACPI_TABLE_ORIGIN_INTERN_PHYSICAL) {
+			    ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL) {
 				header =
 				    acpi_os_map_memory(acpi_gbl_root_table_list.
 						       tables[i].address,
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 529f633..ab5308b 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -219,13 +219,13 @@ acpi_install_table(acpi_physical_address address, u8 physical)
 	ACPI_FUNCTION_TRACE(acpi_install_table);
 
 	if (physical) {
-		flags = ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL;
+		flags = ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL;
 	} else {
-		flags = ACPI_TABLE_ORIGIN_INTERN_PHYSICAL;
+		flags = ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL;
 	}
 
-	status = acpi_tb_install_non_fixed_table(address, flags,
-						 FALSE, FALSE, &table_index);
+	status = acpi_tb_install_standard_table(address, flags,
+						FALSE, FALSE, &table_index);
 
 	return_ACPI_STATUS(status);
 }
@@ -272,9 +272,11 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 
 	ACPI_INFO((AE_INFO, "Host-directed Dynamic ACPI Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
-						 ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL,
-						 TRUE, FALSE, &table_index);
+
+	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
+						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
+						TRUE, FALSE, &table_index);
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 0cdf4cc..1cc7ef1 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -367,9 +367,9 @@ struct acpi_table_desc {
 
 /* Masks for Flags field above */
 
-#define ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL    (0)	/* Virtual address, external maintained */
-#define ACPI_TABLE_ORIGIN_INTERN_PHYSICAL   (1)	/* Physical address, internal mapped */
-#define ACPI_TABLE_ORIGIN_INTERN_VIRTUAL    (2)	/* Virtual address, internal allocated */
+#define ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL  (0)	/* Virtual address, external maintained */
+#define ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (1)	/* Physical address, internally mapped */
+#define ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL  (2)	/* Virtual address, internallly allocated */
 #define ACPI_TABLE_ORIGIN_MASK              (3)
 #define ACPI_TABLE_IS_LOADED                (8)
 
-- 
1.7.10

