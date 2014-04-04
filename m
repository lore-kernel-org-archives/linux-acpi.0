From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/28] ACPICA: Tables: Fix the issue that table checksums are not always verified before installation.
Date: Fri,  4 Apr 2014 12:38:57 +0800
Message-ID: <5fb6aa57fb93af9c11f0f9f6f4a79c53d9693739.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22847 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaDDEji (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:38 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The original table handling code does not always verify checksums before
installing a table, this is because code to achieve this must be
implemented here and there in the redundant code blocks.

There are two stages during table initialization:
1. "INSTALLED" after acpi_tb_install_table() and acpi_tb_override_table(),
   struct acpi_table_desc.Pointer is ensured to be NULL.  This can be safely used
   during OSPM's early boot stage.
2. "VALIDATED" after acpi_tb_validate_table(), struct acpi_table_desc.Pointer is
   ensured to be not NULL.  This must not be used during OSPM's early boot
   stage.

This patch changes acpi_tb_add_table() into an early boot safe API to reduce
code redundancies by changing the table state that is returned by this
function from "VALIDATED" to "INSTALLED".  Then the table verification
code can be done in a single place.  Originally, the acpi_tb_add_table() can
only be used by dynamic table loadings that are executed after early boot
stage, it cannot be used by static table loadings that are executed in
early boot stage as:
1.  The address of the table is a virtual address either maintained by
    OSPMs who call acpi_load_table() or by ACPICA whenever "Load" or
    "LoadTable" opcodes are executed, while during early boot stage,
    physical address of the table should be used for table loading.
2.  The API will ensure the state of the loaded table to be "VALIDATED"
    while during early boot stage, tables maintained by root table list
    should be kept as "INSTALLED".

To achieve this:
1. Rename acpi_tb_install_table() to acpi_tb_install_fixed_table() as it only
   applies to DSDT/FACS installation.  Rename acpi_tb_add_table() to
   acpi_tb_install_non_fixed_table() as it will be applied to the installation
   of the rest kinds of tables.
2. Introduce acpi_tb_install_table(), acpi_tb_install_and_override_table to collect
   redudant code where their invocations actually have slight differences.
   1. acpi_tb_install_table() is used to fill an struct acpi_table_desc where the
      table length is known to the caller.
   2. acpi_tb_install_and_override_table() is used to perform necessary
      overriding before installation.
3. Change a parameter of acpi_tb_install_non_fixed_table() from struct acpi_table_desc
   to acpi_physical_address to allow it to be invoked by static table
   loadings.  Also cleanup acpi_ex_load_op() and acpi_load_table() to accomodate
   to the parameter change.
4. Invoke acpi_tb_install_non_fixed_table() for all table loadings other than
   DSDT/FACS in acpi_tb_parse_root_table() to improve code maintainability
   (logics are collected in the single function).  Also delete useless code
   from acpi_tb_parse_root_table().
5. Remove all acpi_tb_validate_table() from acpi_tb_install_non_fixed_table() and
   acpi_tb_install_fixed_table() so that the table descriptor is kept in the
   state of "INSTALLED" but not "VALIDATED" after returning from these
   functions.
6. Introduce temporary struct acpi_table_desc (new_table_desc/old_table_desc) into
   the functions to indicate a table descriptor that is not maintained by
   acpi_gbl_root_table_list. Introduce acpi_tb_acquire_temporal_table() and
   acpi_tb_release_temporal_table() to handle the use cases of such temporal
   tables.  They are only used for verified installation.
7. Introduce acpi_tb_verify_table() to validate table and verify table
   checksum, also remove table checksum verification from
   acpi_tb_validate_table(). Invoke acpi_tb_validate_table() in the functions
   that will convert a table into "LOADED" state or invoke it from
   acpi_get_table_XXX() APIs. Invoke acpi_tb_verify_table() on temporary
   struct acpi_table_desc(s) that are going to be "INSTALLED".
8. Change acpi_tb_override_table() logic so that a temporary struct acpi_table_desc
   will be overridden before installtion, this makes code simpler.

After applying the patch, tables are always installed after being
overridden and the table checksums are always verified before installation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |   24 +-
 drivers/acpi/acpica/exconfig.c |   75 ++---
 drivers/acpi/acpica/tbfadt.c   |   10 +-
 drivers/acpi/acpica/tbinstal.c |  708 +++++++++++++++++++++++++++++-----------
 drivers/acpi/acpica/tbutils.c  |  173 +---------
 drivers/acpi/acpica/tbxfload.c |   26 +-
 6 files changed, 607 insertions(+), 409 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index c569eab..32aec48 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -76,10 +76,10 @@ acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc);
 
-struct acpi_table_header *acpi_tb_override_table(struct acpi_table_header
-						 *table_header,
-						 struct acpi_table_desc
-						 *table_desc);
+acpi_status
+acpi_tb_verify_table(struct acpi_table_desc *table_desc, char *signature);
+
+void acpi_tb_override_table(struct acpi_table_desc *old_table_desc);
 
 acpi_status
 acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
@@ -91,7 +91,8 @@ acpi_tb_release_table(struct acpi_table_header *table,
 		      u32 table_length, u8 table_flags);
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index);
+acpi_tb_install_non_fixed_table(acpi_physical_address address,
+				u8 flags, u8 reload, u32 *table_index);
 
 acpi_status
 acpi_tb_store_table(acpi_physical_address address,
@@ -135,8 +136,17 @@ void acpi_tb_check_dsdt_header(void);
 struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
 
 void
-acpi_tb_install_table(acpi_physical_address address,
-		      char *signature, u32 table_index);
+acpi_tb_install_table(struct acpi_table_desc *table_desc,
+		      acpi_physical_address address,
+		      u8 flags, struct acpi_table_header *table);
+
+void
+acpi_tb_install_and_override_table(u32 table_index,
+				   struct acpi_table_desc *new_table_desc);
+
+acpi_status
+acpi_tb_install_fixed_table(acpi_physical_address address,
+			    char *signature, u32 table_index);
 
 acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 11a014c..52ea900 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -343,16 +343,14 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object *ddb_handle;
+	struct acpi_table_header *table_header;
 	struct acpi_table_header *table;
-	struct acpi_table_desc table_desc;
 	u32 table_index;
 	acpi_status status;
 	u32 length;
 
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
-	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
-
 	/* Source Object can be either an op_region or a Buffer/Field */
 
 	switch (obj_desc->common.type) {
@@ -380,17 +378,17 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		/* Get the table header first so we can get the table length */
 
-		table = ACPI_ALLOCATE(sizeof(struct acpi_table_header));
-		if (!table) {
+		table_header = ACPI_ALLOCATE(sizeof(struct acpi_table_header));
+		if (!table_header) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		status =
 		    acpi_ex_region_read(obj_desc,
 					sizeof(struct acpi_table_header),
-					ACPI_CAST_PTR(u8, table));
-		length = table->length;
-		ACPI_FREE(table);
+					ACPI_CAST_PTR(u8, table_header));
+		length = table_header->length;
+		ACPI_FREE(table_header);
 
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
@@ -420,22 +418,19 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		/* Allocate a buffer for the table */
 
-		table_desc.pointer = ACPI_ALLOCATE(length);
-		if (!table_desc.pointer) {
+		table = ACPI_ALLOCATE(length);
+		if (!table) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		/* Read the entire table */
 
 		status = acpi_ex_region_read(obj_desc, length,
-					     ACPI_CAST_PTR(u8,
-							   table_desc.pointer));
+					     ACPI_CAST_PTR(u8, table));
 		if (ACPI_FAILURE(status)) {
-			ACPI_FREE(table_desc.pointer);
+			ACPI_FREE(table);
 			return_ACPI_STATUS(status);
 		}
-
-		table_desc.address = ACPI_PTR_TO_PHYSADDR(table_desc.pointer);
 		break;
 
 	case ACPI_TYPE_BUFFER:	/* Buffer or resolved region_field */
@@ -452,10 +447,10 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		/* Get the actual table length from the table header */
 
-		table =
+		table_header =
 		    ACPI_CAST_PTR(struct acpi_table_header,
 				  obj_desc->buffer.pointer);
-		length = table->length;
+		length = table_header->length;
 
 		/* Table cannot extend beyond the buffer */
 
@@ -470,13 +465,12 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		 * Copy the table from the buffer because the buffer could be modified
 		 * or even deleted in the future
 		 */
-		table_desc.pointer = ACPI_ALLOCATE(length);
-		if (!table_desc.pointer) {
+		table = ACPI_ALLOCATE(length);
+		if (!table) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
-		ACPI_MEMCPY(table_desc.pointer, table, length);
-		table_desc.address = ACPI_PTR_TO_PHYSADDR(table_desc.pointer);
+		ACPI_MEMCPY(table, table_header, length);
 		break;
 
 	default:
@@ -484,27 +478,30 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
-	/* Validate table checksum (will not get validated in tb_add_table) */
-
-	status = acpi_tb_verify_checksum(table_desc.pointer, length);
-	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(table_desc.pointer);
-		return_ACPI_STATUS(status);
-	}
-
-	/* Complete the table descriptor */
-
-	table_desc.length = length;
-	table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
-
 	/* Install the new table into the local data structures */
 
-	status = acpi_tb_add_table(&table_desc, &table_index);
+	ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
+						 ACPI_TABLE_ORIGIN_ALLOCATED,
+						 TRUE, &table_index);
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 
 		/* Delete allocated table buffer */
 
-		ACPI_FREE(table_desc.pointer);
+		ACPI_FREE(table);
+		return_ACPI_STATUS(status);
+	}
+
+	/*
+	 * Note: Now table is "INSTALLED", it must be validated before
+	 * loading.
+	 */
+	status =
+	    acpi_tb_validate_table(&acpi_gbl_root_table_list.
+				   tables[table_index]);
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
@@ -536,9 +533,6 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(status);
 	}
 
-	ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
-	acpi_tb_print_table_header(0, table_desc.pointer);
-
 	/* Remove the reference by added by acpi_ex_store above */
 
 	acpi_ut_remove_reference(ddb_handle);
@@ -546,8 +540,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	/* Invoke table handler if present */
 
 	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD,
-					     table_desc.pointer,
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
 					     acpi_gbl_table_handler_context);
 	}
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index ec14588..a37af16 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -332,15 +332,15 @@ void acpi_tb_parse_fadt(u32 table_index)
 
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
-			      ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
+	acpi_tb_install_fixed_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
+				    ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
 
 	/* If Hardware Reduced flag is set, there is no FACS */
 
 	if (!acpi_gbl_reduced_hardware) {
-		acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.
-				      Xfacs, ACPI_SIG_FACS,
-				      ACPI_TABLE_INDEX_FACS);
+		acpi_tb_install_fixed_table((acpi_physical_address)
+					    acpi_gbl_FADT.Xfacs, ACPI_SIG_FACS,
+					    ACPI_TABLE_INDEX_FACS);
 	}
 }
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index d3e1db2..099e678 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -49,6 +49,19 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbinstal")
 
+/* Local prototypes */
+static acpi_status
+acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
+			       acpi_physical_address address, u8 flags);
+
+static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc);
+
+static acpi_status acpi_tb_acquire_root_table_entry(u32 *table_index);
+
+static u8
+acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc,
+			    u32 table_index);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_acquire_table
@@ -64,6 +77,7 @@ ACPI_MODULE_NAME("tbinstal")
  *              acpi_gbl_root_table_list.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
 		      struct acpi_table_header **table_ptr,
@@ -148,8 +162,8 @@ acpi_tb_release_table(struct acpi_table_header *table,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to validate (ensure Pointer is valid)
- *              and verify the table.
+ * DESCRIPTION: This function is called to validate the table, the returned
+ *              table descriptor is in "VALIDATED" state.
  *
  *****************************************************************************/
 
@@ -165,16 +179,11 @@ acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc)
 		status = acpi_tb_acquire_table(table_desc, &table_desc->pointer,
 					       &table_desc->length,
 					       &table_desc->flags);
-		if (ACPI_FAILURE(status) || !table_desc->pointer) {
-			return_ACPI_STATUS(AE_NO_MEMORY);
+		if (!table_desc->pointer) {
+			status = AE_NO_MEMORY;
 		}
 	}
 
-	/* Always calculate checksum, ignore bad checksum if requested */
-
-	status =
-	    acpi_tb_verify_checksum(table_desc->pointer, table_desc->length);
-
 	return_ACPI_STATUS(status);
 }
 
@@ -209,157 +218,473 @@ void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc)
 	return_VOID;
 }
 
-/*******************************************************************************
+/******************************************************************************
  *
- * FUNCTION:    acpi_tb_add_table
+ * FUNCTION:    acpi_tb_verify_table
  *
  * PARAMETERS:  table_desc          - Table descriptor
- *              table_index         - Where the table index is returned
+ *              signature           - Table signature to verify
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to add an ACPI table. It is used to
- *              dynamically load tables via the Load and load_table AML
- *              operators.
+ * DESCRIPTION: This function is called to validate and verify the table, the
+ *              returned table descriptor is in "VALIDATED" state.
  *
- ******************************************************************************/
+ *****************************************************************************/
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
+acpi_tb_verify_table(struct acpi_table_desc *table_desc, char *signature)
 {
-	u32 i;
 	acpi_status status = AE_OK;
-	struct acpi_table_header *final_table;
 
-	ACPI_FUNCTION_TRACE(tb_add_table);
+	ACPI_FUNCTION_TRACE(tb_verify_table);
 
-	if (!table_desc->pointer) {
-		status = acpi_tb_validate_table(table_desc);
-		if (ACPI_FAILURE(status) || !table_desc->pointer) {
-			acpi_tb_invalidate_table(table_desc);
-			return_ACPI_STATUS(status);
-		}
+	/* Validate the table */
+
+	status = acpi_tb_validate_table(table_desc);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	/*
-	 * Validate the incoming table signature.
-	 *
-	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
-	 * 2) We added support for OEMx tables, signature "OEM".
-	 * 3) Valid tables were encountered with a null signature, so we just
-	 *    gave up on validating the signature, (05/2008).
-	 * 4) We encountered non-AML tables such as the MADT, which caused
-	 *    interpreter errors and kernel faults. So now, we once again allow
-	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
-	 */
-	if ((table_desc->pointer->signature[0] != 0x00) &&
-	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT))
-	    && (ACPI_STRNCMP(table_desc->pointer->signature, "OEM", 3))) {
+	/* If a particular signature is expected (DSDT/FACS), it must match */
+
+	if (signature && !ACPI_COMPARE_NAME(&table_desc->signature, signature)) {
 		ACPI_BIOS_ERROR((AE_INFO,
-				 "Table has invalid signature [%4.4s] (0x%8.8X), "
-				 "must be SSDT or OEMx",
-				 acpi_ut_valid_acpi_name(table_desc->pointer->
-							 signature) ?
-				 table_desc->pointer->signature : "????",
-				 *(u32 *)table_desc->pointer->signature));
+				 "Invalid signature 0x%X for ACPI table, expected [%s]",
+				 table_desc->signature.integer, signature));
+		status = AE_BAD_SIGNATURE;
+		goto invalidate_and_exit;
+	}
+
+	/* Verify the checksum */
 
-		return_ACPI_STATUS(AE_BAD_SIGNATURE);
+	status =
+	    acpi_tb_verify_checksum(table_desc->pointer, table_desc->length);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
+				"%4.4s " ACPI_PRINTF_UINT
+				" Attempted table install failed",
+				acpi_ut_valid_acpi_name(table_desc->signature.
+							ascii) ? table_desc->
+				signature.ascii : "????",
+				ACPI_FORMAT_TO_UINT(table_desc->address)));
+		goto invalidate_and_exit;
 	}
 
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+	return_ACPI_STATUS(AE_OK);
 
-	/* Check if table is already registered */
+invalidate_and_exit:
+	acpi_tb_invalidate_table(table_desc);
+	return_ACPI_STATUS(status);
+}
 
-	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
-		if (!acpi_gbl_root_table_list.tables[i].pointer) {
-			status =
-			    acpi_tb_validate_table(&acpi_gbl_root_table_list.
-						   tables[i]);
-			if (ACPI_FAILURE(status)
-			    || !acpi_gbl_root_table_list.tables[i].pointer) {
-				continue;
-			}
-		}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_install_table
+ *
+ * PARAMETERS:  table_desc              - Table descriptor
+ *              address                 - Physical address of the table
+ *              flags                   - Allocation flags of the table
+ *              table                   - Pointer to the table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Install an ACPI table into the global data structure.
+ *
+ ******************************************************************************/
 
-		/*
-		 * Check for a table match on the entire table length,
-		 * not just the header.
-		 */
-		if (table_desc->length !=
-		    acpi_gbl_root_table_list.tables[i].length) {
-			continue;
+void
+acpi_tb_install_table(struct acpi_table_desc *table_desc,
+		      acpi_physical_address address,
+		      u8 flags, struct acpi_table_header *table)
+{
+	/*
+	 * Initialize the table entry. Set the pointer to NULL, since the
+	 * table is not fully mapped at this time.
+	 */
+	ACPI_MEMSET(table_desc, 0, sizeof(struct acpi_table_desc));
+	table_desc->address = address;
+	table_desc->length = table->length;
+	table_desc->flags = flags;
+	ACPI_MOVE_32_TO_32(table_desc->signature.ascii, table->signature);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_acquire_temporal_table
+ *
+ * PARAMETERS:  table_desc          - Table descriptor to be acquired
+ *              address             - Address of the table
+ *              flags               - Allocation flags of the table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function validates the table header to obtain the length
+ *              of a table and fills the table descriptor to make its state as
+ *              "INSTALLED".  Such table descriptor is only used for verified
+ *              installation.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
+			       acpi_physical_address address, u8 flags)
+{
+	struct acpi_table_header *table_header;
+
+	switch (flags & ACPI_TABLE_ORIGIN_MASK) {
+	case ACPI_TABLE_ORIGIN_MAPPED:
+
+		/* Try to obtain the length of the table */
+
+		table_header =
+		    acpi_os_map_memory(address,
+				       sizeof(struct acpi_table_header));
+		if (!table_header) {
+			return (AE_NO_MEMORY);
 		}
+		acpi_tb_install_table(table_desc, address, flags, table_header);
+		acpi_os_unmap_memory(table_header,
+				     sizeof(struct acpi_table_header));
+		return (AE_OK);
 
-		if (ACPI_MEMCMP(table_desc->pointer,
-				acpi_gbl_root_table_list.tables[i].pointer,
-				acpi_gbl_root_table_list.tables[i].length)) {
-			continue;
+	case ACPI_TABLE_ORIGIN_ALLOCATED:
+	case ACPI_TABLE_ORIGIN_UNKNOWN:
+	case ACPI_TABLE_ORIGIN_OVERRIDE:
+
+		table_header = ACPI_CAST_PTR(struct acpi_table_header, address);
+		if (!table_header) {
+			return (AE_NO_MEMORY);
 		}
+		acpi_tb_install_table(table_desc, address, flags, table_header);
+		return (AE_OK);
 
-		/*
-		 * Note: the current mechanism does not unregister a table if it is
-		 * dynamically unloaded. The related namespace entries are deleted,
-		 * but the table remains in the root table list.
-		 *
-		 * The assumption here is that the number of different tables that
-		 * will be loaded is actually small, and there is minimal overhead
-		 * in just keeping the table in case it is needed again.
-		 *
-		 * If this assumption changes in the future (perhaps on large
-		 * machines with many table load/unload operations), tables will
-		 * need to be unregistered when they are unloaded, and slots in the
-		 * root table list should be reused when empty.
-		 */
-		*table_index = i;
+	default:
 
-		if (acpi_gbl_root_table_list.tables[i].
-		    flags & ACPI_TABLE_IS_LOADED) {
+		break;
+	}
 
-			/* Table is still loaded, this is an error */
+	/* Table is not valid yet */
 
-			status = AE_ALREADY_EXISTS;
-			goto release;
-		} else {
-			/* Table was unloaded, allow it to be reloaded */
-
-			acpi_tb_uninstall_table(table_desc);
-			table_desc->pointer =
-			    acpi_gbl_root_table_list.tables[i].pointer;
-			table_desc->address =
-			    acpi_gbl_root_table_list.tables[i].address;
-			status = AE_OK;
-			goto print_header;
-		}
+	return (AE_NO_MEMORY);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_release_temporal_table
+ *
+ * PARAMETERS:  table_desc          - Table descriptor to be released
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: The reversal of acpi_tb_acquire_temporal_table().
+ *
+ ******************************************************************************/
+
+static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc)
+{
+	/*
+	 * Note that the .Address is maintained by the callers of
+	 * acpi_tb_acquire_temporal_table(), thus do not invoke acpi_tb_uninstall_table()
+	 * where .Address will be freed.
+	 */
+	acpi_tb_invalidate_table(table_desc);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_install_and_override_table
+ *
+ * PARAMETERS:  table_index             - Index into root table array
+ *              new_table_desc          - New table descriptor to install
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Install an ACPI table into the global data structure. The
+ *              table override mechanism is called to allow the host
+ *              OS to replace any table before it is installed in the root
+ *              table array.
+ *
+ ******************************************************************************/
+
+void
+acpi_tb_install_and_override_table(u32 table_index,
+				   struct acpi_table_desc *new_table_desc)
+{
+	if (table_index >= acpi_gbl_root_table_list.current_table_count) {
+		return;
 	}
 
 	/*
 	 * ACPI Table Override:
-	 * Allow the host to override dynamically loaded tables.
-	 * NOTE: the table is fully mapped at this point, and the mapping will
-	 * be deleted by acpi_tb_override_table if the table is actually overridden.
+	 *
+	 * Before we install the table, let the host OS override it with a new
+	 * one if desired. Any table within the RSDT/XSDT can be replaced,
+	 * including the DSDT which is pointed to by the FADT.
 	 */
-	final_table = acpi_tb_override_table(table_desc->pointer, table_desc);
-	if (final_table) {
+	acpi_tb_override_table(new_table_desc);
+
+	acpi_tb_install_table(&acpi_gbl_root_table_list.tables[table_index],
+			      new_table_desc->address, new_table_desc->flags,
+			      new_table_desc->pointer);
 
-		/* Ensure table descriptor is in "VALIDATED" state */
+	acpi_tb_print_table_header(new_table_desc->address,
+				   new_table_desc->pointer);
 
-		table_desc->pointer = final_table;
+	/* Set the global integer width (based upon revision of the DSDT) */
+
+	if (table_index == ACPI_TABLE_INDEX_DSDT) {
+		acpi_ut_set_integer_width(new_table_desc->pointer->revision);
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_install_fixed_table
+ *
+ * PARAMETERS:  address                 - Physical address of DSDT or FACS
+ *              signature               - Table signature, NULL if no need to
+ *                                        match
+ *              table_index             - Index into root table array
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a fixed ACPI table (DSDT/FACS) into the global data
+ *              structure.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_tb_install_fixed_table(acpi_physical_address address,
+			    char *signature, u32 table_index)
+{
+	struct acpi_table_desc new_table_desc;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(tb_install_fixed_table);
+
+	if (!address) {
+		ACPI_ERROR((AE_INFO,
+			    "Null physical address for ACPI table [%s]",
+			    signature));
+		return (AE_NO_MEMORY);
+	}
+
+	/* Fill a table descriptor for validation */
+
+	status = acpi_tb_acquire_temporal_table(&new_table_desc, address,
+						ACPI_TABLE_ORIGIN_MAPPED);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
+			    ACPI_CAST_PTR(void, address)));
+		return_ACPI_STATUS(status);
+	}
+
+	/* Validate and verify a table before installation */
+
+	status = acpi_tb_verify_table(&new_table_desc, signature);
+	if (ACPI_FAILURE(status)) {
+		goto release_and_exit;
+	}
+
+	acpi_tb_install_and_override_table(table_index, &new_table_desc);
+
+release_and_exit:
+
+	/* Release the temporal table descriptor */
+
+	acpi_tb_release_temporal_table(&new_table_desc);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_is_equivalent_table
+ *
+ * PARAMETERS:  table_desc          - Table 1 descriptor to be compared
+ *              table_index         - Index of table 2 to be compared
+ *
+ * RETURN:      TRUE if 2 tables are equivalent
+ *
+ * DESCRIPTION: This function is called to compare a table with what have
+ *              already been installed in the root table list.
+ *
+ ******************************************************************************/
+
+static u8
+acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
+{
+	acpi_status status = AE_OK;
+	u8 is_equivalent;
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
+	is_equivalent = (u8)((table_desc->length != table_length ||
+			      ACPI_MEMCMP(table_desc->pointer, table,
+					  table_length)) ? FALSE : TRUE);
+
+	/* Release the acquired table */
+
+	acpi_tb_release_table(table, table_length, table_flags);
+
+	return (is_equivalent);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_install_non_fixed_table
+ *
+ * PARAMETERS:  address             - Address of the table (might be a logical
+ *                                    address depending on the table_flags)
+ *              flags               - Flags for the table
+ *              reload              - Whether reload should be performed
+ *              table_index         - Where the table index is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function is called to install an ACPI table that is
+ *              neither DSDT nor FACS.
+ *              When this function is called by "Load" or "LoadTable" opcodes,
+ *              or by acpi_load_table() API, the "Reload" parameter is set.
+ *              After sucessfully returning from this function, table is
+ *              "INSTALLED" but not "VALIDATED".
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_tb_install_non_fixed_table(acpi_physical_address address,
+				u8 flags, u8 reload, u32 *table_index)
+{
+	u32 i;
+	acpi_status status = AE_OK;
+	struct acpi_table_desc new_table_desc;
+
+	ACPI_FUNCTION_TRACE(tb_install_non_fixed_table);
+
+	/* Acquire a temporal table descriptor for validation */
+
+	status =
+	    acpi_tb_acquire_temporal_table(&new_table_desc, address, flags);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
+			    ACPI_CAST_PTR(void, address)));
+		return_ACPI_STATUS(status);
+	}
+
+	/* Validate and verify a table before installation */
+
+	status = acpi_tb_verify_table(&new_table_desc, NULL);
+	if (ACPI_FAILURE(status)) {
+		goto release_and_exit;
+	}
+
+	if (reload) {
+		/*
+		 * Validate the incoming table signature.
+		 *
+		 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
+		 * 2) We added support for OEMx tables, signature "OEM".
+		 * 3) Valid tables were encountered with a null signature, so we just
+		 *    gave up on validating the signature, (05/2008).
+		 * 4) We encountered non-AML tables such as the MADT, which caused
+		 *    interpreter errors and kernel faults. So now, we once again allow
+		 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
+		 */
+		if ((new_table_desc.signature.ascii[0] != 0x00) &&
+		    (!ACPI_COMPARE_NAME
+		     (&new_table_desc.signature, ACPI_SIG_SSDT))
+		    && (ACPI_STRNCMP(new_table_desc.signature.ascii, "OEM", 3)))
+		{
+			ACPI_BIOS_ERROR((AE_INFO,
+					 "Table has invalid signature [%4.4s] (0x%8.8X), "
+					 "must be SSDT or OEMx",
+					 acpi_ut_valid_acpi_name(new_table_desc.
+								 signature.
+								 ascii) ?
+					 new_table_desc.signature.
+					 ascii : "????",
+					 new_table_desc.signature.integer));
+
+			status = AE_BAD_SIGNATURE;
+			goto release_and_exit;
+		}
+
+		/* Check if table is already registered */
+
+		for (i = 0; i < acpi_gbl_root_table_list.current_table_count;
+		     ++i) {
+			/*
+			 * Check for a table match on the entire table length,
+			 * not just the header.
+			 */
+			if (!acpi_tb_is_equivalent_table(&new_table_desc, i)) {
+				continue;
+			}
+
+			/*
+			 * Note: the current mechanism does not unregister a table if it is
+			 * dynamically unloaded. The related namespace entries are deleted,
+			 * but the table remains in the root table list.
+			 *
+			 * The assumption here is that the number of different tables that
+			 * will be loaded is actually small, and there is minimal overhead
+			 * in just keeping the table in case it is needed again.
+			 *
+			 * If this assumption changes in the future (perhaps on large
+			 * machines with many table load/unload operations), tables will
+			 * need to be unregistered when they are unloaded, and slots in the
+			 * root table list should be reused when empty.
+			 */
+			if (acpi_gbl_root_table_list.tables[i].
+			    flags & ACPI_TABLE_IS_LOADED) {
+
+				/* Table is still loaded, this is an error */
+
+				status = AE_ALREADY_EXISTS;
+				goto release_and_exit;
+			} else {
+				/*
+				 * Table was unloaded, allow it to be reloaded.
+				 * As we are going to return AE_OK to the caller, we should
+				 * take the responsibility of freeing the input descriptor.
+				 * Refill the input descriptor to ensure
+				 * acpi_tb_install_and_override_table() can be called again to
+				 * indicate the re-installation.
+				 */
+				acpi_tb_uninstall_table(&new_table_desc);
+				*table_index = i;
+				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+				return_ACPI_STATUS(AE_OK);
+			}
+		}
 	}
 
 	/* Add the table to the global root table list */
 
-	status = acpi_tb_store_table(table_desc->address, table_desc->pointer,
-				     table_desc->length, table_desc->flags,
-				     table_index);
+	status = acpi_tb_acquire_root_table_entry(&i);
 	if (ACPI_FAILURE(status)) {
-		goto release;
+		goto release_and_exit;
 	}
+	*table_index = i;
+	acpi_tb_install_and_override_table(i, &new_table_desc);
 
-print_header:
-	acpi_tb_print_table_header(table_desc->address, table_desc->pointer);
+release_and_exit:
 
-release:
-	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	/* Release the temporal table descriptor */
+
+	acpi_tb_release_temporal_table(&new_table_desc);
 	return_ACPI_STATUS(status);
 }
 
@@ -367,97 +692,82 @@ release:
  *
  * FUNCTION:    acpi_tb_override_table
  *
- * PARAMETERS:  table_header        - Header for the original table
- *              table_desc          - Table descriptor initialized for the
- *                                    original table. May or may not be mapped.
+ * PARAMETERS:  old_table_desc      - Validated table descriptor to be
+ *                                    overridden
  *
- * RETURN:      Pointer to the entire new table. NULL if table not overridden.
- *              If overridden, installs the new table within the input table
- *              descriptor.
+ * RETURN:      None
  *
  * DESCRIPTION: Attempt table override by calling the OSL override functions.
  *              Note: If the table is overridden, then the entire new table
  *              is acquired and returned by this function.
- *              After invocation, the table descriptor is in a state that is
- *              "INSTALLED" but not "VALIDATED", thus the "Pointer" member is
- *              kept NULL.
+ *              Before/after invocation, the table descriptor is in a state
+ *              that is "VALIDATED".
  *
  ******************************************************************************/
 
-struct acpi_table_header *acpi_tb_override_table(struct acpi_table_header
-						 *table_header,
-						 struct acpi_table_desc
-						 *table_desc)
+void acpi_tb_override_table(struct acpi_table_desc *old_table_desc)
 {
 	acpi_status status;
-	struct acpi_table_header *new_table;
-	u32 new_table_length;
-	u8 new_flags;
 	char *override_type;
 	struct acpi_table_desc new_table_desc;
-
-	ACPI_MEMSET(&new_table_desc, 0, sizeof(struct acpi_table_desc));
+	struct acpi_table_header *table;
+	acpi_physical_address address;
+	u32 length;
 
 	/* (1) Attempt logical override (returns a logical address) */
 
-	status = acpi_os_table_override(table_header, &new_table_desc.pointer);
-	if (ACPI_SUCCESS(status) && new_table_desc.pointer) {
-		new_table_desc.address =
-		    ACPI_PTR_TO_PHYSADDR(new_table_desc.pointer);
-		new_table_desc.length = new_table_desc.pointer->length;
-		new_table_desc.flags = ACPI_TABLE_ORIGIN_OVERRIDE;
+	status = acpi_os_table_override(old_table_desc->pointer, &table);
+	if (ACPI_SUCCESS(status) && table) {
+		acpi_tb_acquire_temporal_table(&new_table_desc,
+					       ACPI_PTR_TO_PHYSADDR(table),
+					       ACPI_TABLE_ORIGIN_OVERRIDE);
 		override_type = "Logical";
 		goto finish_override;
 	}
 
 	/* (2) Attempt physical override (returns a physical address) */
 
-	status = acpi_os_physical_table_override(table_header,
-						 &new_table_desc.address,
-						 &new_table_desc.length);
-	if (ACPI_SUCCESS(status) && new_table_desc.address
-	    && new_table_desc.length) {
+	status = acpi_os_physical_table_override(old_table_desc->pointer,
+						 &address, &length);
+	if (ACPI_SUCCESS(status) && address && length) {
+		acpi_tb_acquire_temporal_table(&new_table_desc, address,
+					       ACPI_TABLE_ORIGIN_MAPPED);
 		override_type = "Physical";
-		new_table_desc.flags = ACPI_TABLE_ORIGIN_MAPPED;
 		goto finish_override;
 	}
 
-	return (NULL);		/* There was no override */
+	return;			/* There was no override */
 
 finish_override:
 
-	/*
-	 * Acquire the entire new table to indicate overridden.
-	 * Note that this is required by the callers of this function.
-	 */
-	status = acpi_tb_acquire_table(&new_table_desc, &new_table,
-				       &new_table_length, &new_flags);
+	/* Validate and verify a table before overriding */
+
+	status = acpi_tb_verify_table(&new_table_desc, NULL);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
-				"%4.4s " ACPI_PRINTF_UINT
-				" Attempted table override failed",
-				table_header->signature,
-				ACPI_FORMAT_TO_UINT(table_desc->address)));
-		return (NULL);
+		return;
 	}
 
 	ACPI_INFO((AE_INFO, "%4.4s " ACPI_PRINTF_UINT
 		   " %s table override, new table: " ACPI_PRINTF_UINT,
-		   table_header->signature,
-		   ACPI_FORMAT_TO_UINT(table_desc->address),
+		   old_table_desc->signature.ascii,
+		   ACPI_FORMAT_TO_UINT(old_table_desc->address),
 		   override_type, ACPI_FORMAT_TO_UINT(new_table_desc.address)));
 
-	/* We can now uninstall the original table (if fully mapped) */
+	/* We can now uninstall the original table */
 
-	acpi_tb_uninstall_table(table_desc);
+	acpi_tb_uninstall_table(old_table_desc);
 
-	/* Install the new table */
+	/*
+	 * Replace the original table descriptor and keep its state as
+	 * "VALIDATED".
+	 */
+	acpi_tb_install_table(old_table_desc, new_table_desc.address,
+			      new_table_desc.flags, new_table_desc.pointer);
+	acpi_tb_validate_table(old_table_desc);
 
-	table_desc->address = new_table_desc.address;
-	table_desc->length = new_table_desc.length;
-	table_desc->flags = new_table_desc.flags;
+	/* Release the temporal table descriptor */
 
-	return (new_table);
+	acpi_tb_release_temporal_table(&new_table_desc);
 }
 
 /*******************************************************************************
@@ -526,26 +836,19 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_store_table
+ * FUNCTION:    acpi_tb_acquire_root_table_entry
  *
- * PARAMETERS:  address             - Table address
- *              table               - Table header
- *              length              - Table length
- *              flags               - flags
+ * PARAMETERS:  table_index         - Where table index is returned
  *
  * RETURN:      Status and table index.
  *
- * DESCRIPTION: Add an ACPI table to the global table list
+ * DESCRIPTION: Allocate a new ACPI table entry to the global table list
  *
  ******************************************************************************/
 
-acpi_status
-acpi_tb_store_table(acpi_physical_address address,
-		    struct acpi_table_header *table,
-		    u32 length, u8 flags, u32 *table_index)
+static acpi_status acpi_tb_acquire_root_table_entry(u32 *table_index)
 {
 	acpi_status status;
-	struct acpi_table_desc *new_table;
 
 	/* Ensure that there is room for the table in the Root Table List */
 
@@ -557,22 +860,45 @@ acpi_tb_store_table(acpi_physical_address address,
 		}
 	}
 
-	new_table =
-	    &acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.
-					     current_table_count];
+	*table_index = acpi_gbl_root_table_list.current_table_count;
+	acpi_gbl_root_table_list.current_table_count++;
+	return (AE_OK);
+}
 
-	/* Initialize added table */
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_store_table
+ *
+ * PARAMETERS:  address             - Table address
+ *              table               - Table header
+ *              length              - Table length
+ *              flags               - flags
+ *
+ * RETURN:      Status and table index.
+ *
+ * DESCRIPTION: Add an ACPI table to the global table list
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_tb_store_table(acpi_physical_address address,
+		    struct acpi_table_header * table,
+		    u32 length, u8 flags, u32 *table_index)
+{
+	acpi_status status;
+	struct acpi_table_desc *table_desc;
+
+	status = acpi_tb_acquire_root_table_entry(table_index);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
-	new_table->address = address;
-	new_table->pointer = table;
-	new_table->length = length;
-	new_table->owner_id = 0;
-	new_table->flags = flags;
+	/* Initialize added table */
 
-	ACPI_MOVE_32_TO_32(&new_table->signature, table->signature);
+	table_desc = &acpi_gbl_root_table_list.tables[*table_index];
+	acpi_tb_install_table(table_desc, address, flags, table);
+	table_desc->pointer = table;
 
-	*table_index = acpi_gbl_root_table_list.current_table_count;
-	acpi_gbl_root_table_list.current_table_count++;
 	return (AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index c61432f..e58dfbf 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -179,9 +179,10 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 
 	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
 	acpi_tb_uninstall_table(table_desc);
-	table_desc->address = ACPI_PTR_TO_PHYSADDR(new_table);
-	table_desc->pointer = new_table;
-	table_desc->flags = ACPI_TABLE_ORIGIN_ALLOCATED;
+	acpi_tb_install_table(&acpi_gbl_root_table_list.
+			      tables[ACPI_TABLE_INDEX_DSDT],
+			      ACPI_PTR_TO_PHYSADDR(new_table),
+			      ACPI_TABLE_ORIGIN_ALLOCATED, new_table);
 
 	ACPI_INFO((AE_INFO,
 		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
@@ -192,121 +193,6 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_install_table
- *
- * PARAMETERS:  address                 - Physical address of DSDT or FACS
- *              signature               - Table signature, NULL if no need to
- *                                        match
- *              table_index             - Index into root table array
- *
- * RETURN:      None
- *
- * DESCRIPTION: Install an ACPI table into the global data structure. The
- *              table override mechanism is called to allow the host
- *              OS to replace any table before it is installed in the root
- *              table array.
- *
- ******************************************************************************/
-
-void
-acpi_tb_install_table(acpi_physical_address address,
-		      char *signature, u32 table_index)
-{
-	struct acpi_table_header *table;
-	struct acpi_table_header *final_table;
-	struct acpi_table_desc *table_desc;
-
-	if (!address) {
-		ACPI_ERROR((AE_INFO,
-			    "Null physical address for ACPI table [%s]",
-			    signature));
-		return;
-	}
-
-	/* Map just the table header */
-
-	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
-	if (!table) {
-		ACPI_ERROR((AE_INFO,
-			    "Could not map memory for table [%s] at %p",
-			    signature, ACPI_CAST_PTR(void, address)));
-		return;
-	}
-
-	/* If a particular signature is expected (DSDT/FACS), it must match */
-
-	if (signature && !ACPI_COMPARE_NAME(table->signature, signature)) {
-		ACPI_BIOS_ERROR((AE_INFO,
-				 "Invalid signature 0x%X for ACPI table, expected [%s]",
-				 *ACPI_CAST_PTR(u32, table->signature),
-				 signature));
-		goto unmap_and_exit;
-	}
-
-	/*
-	 * Initialize the table entry. Set the pointer to NULL, since the
-	 * table is not fully mapped at this time.
-	 */
-	table_desc = &acpi_gbl_root_table_list.tables[table_index];
-
-	table_desc->address = address;
-	table_desc->pointer = NULL;
-	table_desc->length = table->length;
-	table_desc->flags = ACPI_TABLE_ORIGIN_MAPPED;
-	ACPI_MOVE_32_TO_32(table_desc->signature.ascii, table->signature);
-
-	/*
-	 * ACPI Table Override:
-	 *
-	 * Before we install the table, let the host OS override it with a new
-	 * one if desired. Any table within the RSDT/XSDT can be replaced,
-	 * including the DSDT which is pointed to by the FADT.
-	 *
-	 * NOTE: If the table is overridden, then final_table will contain a
-	 * mapped pointer to the full new table. If the table is not overridden,
-	 * or if there has been a physical override, then the table will be
-	 * fully mapped later (in verify table). In any case, we must
-	 * unmap the header that was mapped above.
-	 */
-	final_table = acpi_tb_override_table(table, table_desc);
-	if (!final_table) {
-		final_table = table;	/* There was no override */
-	}
-
-	acpi_tb_print_table_header(table_desc->address, final_table);
-
-	/* Set the global integer width (based upon revision of the DSDT) */
-
-	if (table_index == ACPI_TABLE_INDEX_DSDT) {
-		acpi_ut_set_integer_width(final_table->revision);
-	}
-
-	/*
-	 * If we have a physical override during this early loading of the ACPI
-	 * tables, unmap the table for now. It will be mapped again later when
-	 * it is actually used. This supports very early loading of ACPI tables,
-	 * before virtual memory is fully initialized and running within the
-	 * host OS. Note: A logical override has the ACPI_TABLE_ORIGIN_OVERRIDE
-	 * flag set and will not be deleted below.
-	 */
-	if (final_table != table) {
-		/*
-		 * Table is in "INSTALLED" state, the final_table pointer is not
-		 * maintained in the root table list.
-		 */
-		acpi_tb_release_table(final_table, table_desc->length,
-				      table_desc->flags);
-	}
-
-unmap_and_exit:
-
-	/* Always unmap the table header that we mapped above */
-
-	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_get_root_table_entry
  *
  * PARAMETERS:  table_entry         - Pointer to the RSDT/XSDT table entry
@@ -470,6 +356,7 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
+	u32 table_index;
 
 	ACPI_FUNCTION_TRACE(tb_parse_root_table);
 
@@ -579,31 +466,24 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	/* Initialize the root table array from the RSDT/XSDT */
 
 	for (i = 0; i < table_count; i++) {
-		if (acpi_gbl_root_table_list.current_table_count >=
-		    acpi_gbl_root_table_list.max_table_count) {
-
-			/* There is no more room in the root table array, attempt resize */
-
-			status = acpi_tb_resize_root_table_list();
-			if (ACPI_FAILURE(status)) {
-				ACPI_WARNING((AE_INFO,
-					      "Truncating %u table entries!",
-					      (unsigned)(table_count -
-							 (acpi_gbl_root_table_list.
-							  current_table_count -
-							  2))));
-				break;
-			}
-		}
 
 		/* Get the table physical address (32-bit for RSDT, 64-bit for XSDT) */
 
-		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.
-						current_table_count].address =
-		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
+		status =
+		    acpi_tb_install_non_fixed_table(acpi_tb_get_root_table_entry
+						    (table_entry,
+						     table_entry_size),
+						    ACPI_TABLE_ORIGIN_MAPPED,
+						    FALSE, &table_index);
+
+		if (ACPI_SUCCESS(status) &&
+		    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
+				      tables[table_index].signature,
+				      ACPI_SIG_FADT)) {
+			acpi_tb_parse_fadt(table_index);
+		}
 
 		table_entry += table_entry_size;
-		acpi_gbl_root_table_list.current_table_count++;
 	}
 
 	/*
@@ -612,22 +492,5 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	 */
 	acpi_os_unmap_memory(table, length);
 
-	/*
-	 * Complete the initialization of the root table array by examining
-	 * the header of each table
-	 */
-	for (i = 2; i < acpi_gbl_root_table_list.current_table_count; i++) {
-		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
-				      address, NULL, i);
-
-		/* Special case for FADT - validate it then get the DSDT and FACS */
-
-		if (ACPI_COMPARE_NAME
-		    (&acpi_gbl_root_table_list.tables[i].signature,
-		     ACPI_SIG_FADT)) {
-			acpi_tb_parse_fadt(i);
-		}
-	}
-
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index a2899b0..77e8d26 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -226,7 +226,6 @@ unlock_and_exit:
 acpi_status acpi_load_table(struct acpi_table_header *table)
 {
 	acpi_status status;
-	struct acpi_table_desc table_desc;
 	u32 table_index;
 
 	ACPI_FUNCTION_TRACE(acpi_load_table);
@@ -237,14 +236,6 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Init local table descriptor */
-
-	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
-	table_desc.address = ACPI_PTR_TO_PHYSADDR(table);
-	table_desc.pointer = table;
-	table_desc.length = table->length;
-	table_desc.flags = ACPI_TABLE_ORIGIN_UNKNOWN;
-
 	/* Must acquire the interpreter lock during this operation */
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
@@ -255,7 +246,22 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	/* Install the table and load it into the namespace */
 
 	ACPI_INFO((AE_INFO, "Host-directed Dynamic ACPI Table Load:"));
-	status = acpi_tb_add_table(&table_desc, &table_index);
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
+						 ACPI_TABLE_ORIGIN_UNKNOWN,
+						 TRUE, &table_index);
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	if (ACPI_FAILURE(status)) {
+		goto unlock_and_exit;
+	}
+
+	/*
+	 * Note: Now table is "INSTALLED", it must be validated before
+	 * using.
+	 */
+	status =
+	    acpi_tb_validate_table(&acpi_gbl_root_table_list.
+				   tables[table_index]);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
 	}
-- 
1.7.10

