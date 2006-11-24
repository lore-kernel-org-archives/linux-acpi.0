From: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/65] ACPICA: misc fixes for new Table Manager:
Date: Fri, 24 Nov 2006 02:18:22 -0500
Message-ID: <11643527703526-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30357 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934463AbWKXHPe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:34 -0500
In-Reply-To: <11643527654192-git-send-email-len.brown@intel.com>
Message-Id: <0faeae4ba9aef6951c161cb01955ae3d25743f16.1164352290.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbinstal.c  |   35 +--
 drivers/acpi/tables/tbutils.c   |  544 ++++++++++++++++++++++++--------------
 drivers/acpi/tables/tbxface.c   |   58 +++--
 drivers/acpi/utilities/utmisc.c |    8 +-
 include/acpi/acconfig.h         |    2 +-
 include/acpi/aclocal.h          |   21 +-
 include/acpi/actables.h         |    6 +-
 include/acpi/actbl.h            |   12 +-
 8 files changed, 420 insertions(+), 266 deletions(-)

diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 9076ca0..9e0b3ce 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("tbinstal")
  *****************************************************************************/
 acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 {
-	u8 checksum;
+	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(tb_verify_table);
 
@@ -84,17 +84,9 @@ acpi_status acpi_tb_verify_table(struct
 
 	/* Always calculate checksum, ignore bad checksum if requested */
 
-	checksum = acpi_tb_checksum(ACPI_CAST_PTR(void, table_desc->pointer),
-				    table_desc->length);
-
-#if (ACPI_CHECKSUM_ABORT)
-
-	if (checksum) {
-		return_ACPI_STATUS(AE_BAD_CHECKSUM);
-	}
-#endif
-
-	return_ACPI_STATUS(AE_OK);
+	status =
+	    acpi_tb_verify_checksum(table_desc->pointer, table_desc->length);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
@@ -188,7 +180,7 @@ acpi_status acpi_tb_resize_root_table_li
 
 	/* allow_resize flag is a parameter to acpi_initialize_tables */
 
-	if (!(acpi_gbl_root_table_list.flags & ACPI_TABLE_FLAGS_ALLOW_RESIZE)) {
+	if (!(acpi_gbl_root_table_list.flags & ACPI_ROOT_ALLOW_RESIZE)) {
 		ACPI_ERROR((AE_INFO,
 			    "Resize of Root Table Array is not allowed"));
 		return_ACPI_STATUS(AE_SUPPORT);
@@ -212,18 +204,14 @@ acpi_status acpi_tb_resize_root_table_li
 			    acpi_gbl_root_table_list.size *
 			    sizeof(struct acpi_table_desc));
 
-		if (acpi_gbl_root_table_list.flags & ACPI_TABLE_ORIGIN_MASK ==
-		    ACPI_TABLE_ORIGIN_ALLOCATED) {
+		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 			ACPI_FREE(acpi_gbl_root_table_list.tables);
 		}
 	}
 
 	acpi_gbl_root_table_list.tables = tables;
 	acpi_gbl_root_table_list.size += ACPI_ROOT_TABLE_SIZE_INCREMENT;
-	acpi_gbl_root_table_list.flags = (u8) (ACPI_TABLE_ORIGIN_ALLOCATED |
-					       (acpi_gbl_root_table_list.
-						flags &
-						~ACPI_TABLE_ORIGIN_MASK));
+	acpi_gbl_root_table_list.flags |= (u8) ACPI_ROOT_ORIGIN_ALLOCATED;
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -348,8 +336,7 @@ void acpi_tb_terminate(void)
 	 * Delete the root table array if allocated locally. Array cannot be
 	 * mapped, so we don't need to check for that flag.
 	 */
-	if ((acpi_gbl_root_table_list.flags & ACPI_TABLE_ORIGIN_MASK) ==
-	    ACPI_TABLE_ORIGIN_ALLOCATED) {
+	if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 		ACPI_FREE(acpi_gbl_root_table_list.tables);
 	}
 
@@ -497,7 +484,7 @@ u8 acpi_tb_is_table_loaded(acpi_native_u
 	if (table_index < acpi_gbl_root_table_list.count) {
 		is_loaded = (u8)
 		    (acpi_gbl_root_table_list.tables[table_index].
-		     flags & ACPI_TABLE_FLAGS_LOADED);
+		     flags & ACPI_TABLE_IS_LOADED);
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
@@ -524,10 +511,10 @@ void acpi_tb_set_table_loaded_flag(acpi_
 	if (table_index < acpi_gbl_root_table_list.count) {
 		if (is_loaded) {
 			acpi_gbl_root_table_list.tables[table_index].flags |=
-			    ACPI_TABLE_FLAGS_LOADED;
+			    ACPI_TABLE_IS_LOADED;
 		} else {
 			acpi_gbl_root_table_list.tables[table_index].flags &=
-			    ~ACPI_TABLE_FLAGS_LOADED;
+			    ~ACPI_TABLE_IS_LOADED;
 		}
 	}
 
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 3620ac5..2f4ab75 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -48,11 +48,52 @@
 ACPI_MODULE_NAME("tbutils")
 
 /* Local prototypes */
-static void acpi_tb_parse_fadt(struct acpi_table_fadt *fadt, u8 flags);
+static void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
+
+static void acpi_tb_convert_fadt(void);
+
+static void
+acpi_tb_install_table(acpi_physical_address address,
+		      u8 flags, char *signature, acpi_native_uint table_index);
 
 static void inline
 acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
-			     u8 bit_width, acpi_physical_address address);
+			     u8 bit_width, u64 address);
+
+/* Table used for conversion of FADT to common format */
+
+typedef struct acpi_fadt_conversion {
+	u8 target;
+	u8 source;
+	u8 length;
+
+} acpi_fadt_conversion;
+
+static struct acpi_fadt_conversion fadt_conversion_table[] = {
+	{ACPI_FADT_OFFSET(xpm1a_event_block),
+	 ACPI_FADT_OFFSET(pm1a_event_block),
+	 ACPI_FADT_OFFSET(pm1_event_length)},
+	{ACPI_FADT_OFFSET(xpm1b_event_block),
+	 ACPI_FADT_OFFSET(pm1b_event_block),
+	 ACPI_FADT_OFFSET(pm1_event_length)},
+	{ACPI_FADT_OFFSET(xpm1a_control_block),
+	 ACPI_FADT_OFFSET(pm1a_control_block),
+	 ACPI_FADT_OFFSET(pm1_control_length)},
+	{ACPI_FADT_OFFSET(xpm1b_control_block),
+	 ACPI_FADT_OFFSET(pm1b_control_block),
+	 ACPI_FADT_OFFSET(pm1_control_length)},
+	{ACPI_FADT_OFFSET(xpm2_control_block),
+	 ACPI_FADT_OFFSET(pm2_control_block),
+	 ACPI_FADT_OFFSET(pm2_control_length)},
+	{ACPI_FADT_OFFSET(xpm_timer_block), ACPI_FADT_OFFSET(pm_timer_block),
+	 ACPI_FADT_OFFSET(pm_timer_length)},
+	{ACPI_FADT_OFFSET(xgpe0_block), ACPI_FADT_OFFSET(gpe0_block),
+	 ACPI_FADT_OFFSET(gpe0_block_length)},
+	{ACPI_FADT_OFFSET(xgpe1_block), ACPI_FADT_OFFSET(gpe1_block),
+	 ACPI_FADT_OFFSET(gpe1_block_length)}
+};
+
+#define ACPI_FADT_CONVERSION_ENTRIES        (sizeof (fadt_conversion_table) / sizeof (struct acpi_fadt_conversion))
 
 /*******************************************************************************
  *
@@ -63,7 +104,7 @@ acpi_tb_init_generic_address(struct acpi
  *
  * RETURN:      None
  *
- * DESCRIPTION: Print an ACPI table header
+ * DESCRIPTION: Print an ACPI table header. Special cases for FACS and RSDP.
  *
  ******************************************************************************/
 
@@ -72,12 +113,32 @@ acpi_tb_print_table_header(acpi_physical
 			   struct acpi_table_header *header)
 {
 
-	ACPI_INFO((AE_INFO,
-		   "%4.4s @ 0x%p Length 0x%04X (v%3.3d %6.6s %8.8s 0x%08X %4.4s 0x%08X)",
-		   header->signature, ACPI_CAST_PTR(void, address),
-		   header->length, header->revision, header->oem_id,
-		   header->oem_table_id, header->oem_revision,
-		   header->asl_compiler_id, header->asl_compiler_revision));
+	if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_FACS)) {
+
+		/* FACS only has signature and length fields of common table header */
+
+		ACPI_INFO((AE_INFO, "%4.4s @ 0x%p/0x%04X",
+			   header->signature, ACPI_CAST_PTR(void, address),
+			   header->length));
+	} else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
+
+		/* RSDP has no common fields */
+
+		ACPI_INFO((AE_INFO, "RSDP @ 0x%p/0x%04X (v%3.3d %6.6s)",
+			   ACPI_CAST_PTR(void, address),
+			   (((struct acpi_table_rsdp *)header)->revision > 0) ?
+			   ((struct acpi_table_rsdp *)header)->length : 20,
+			   ((struct acpi_table_rsdp *)header)->revision,
+			   ((struct acpi_table_rsdp *)header)->oem_id));
+	} else {
+		ACPI_INFO((AE_INFO,
+			   "%4.4s @ 0x%p/0x%04X (v%3.3d %6.6s %8.8s 0x%08X %4.4s 0x%08X)",
+			   header->signature, ACPI_CAST_PTR(void, address),
+			   header->length, header->revision, header->oem_id,
+			   header->oem_table_id, header->oem_revision,
+			   header->asl_compiler_id,
+			   header->asl_compiler_revision));
+	}
 }
 
 /*******************************************************************************
@@ -96,7 +157,7 @@ acpi_tb_print_table_header(acpi_physical
 
 static void inline
 acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
-			     u8 bit_width, acpi_physical_address address)
+			     u8 bit_width, u64 address)
 {
 
 	ACPI_STORE_ADDRESS(new_gas_struct->address, address);
@@ -108,6 +169,45 @@ acpi_tb_init_generic_address(struct acpi
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_validate_checksum
+ *
+ * PARAMETERS:  Table               - ACPI table to verify
+ *              Length              - Length of entire table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Verifies that the table checksums to zero. Optionally returns
+ *              exception on bad checksum.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
+{
+	u8 checksum;
+
+	/* Compute the checksum on the table */
+
+	checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, table), length);
+
+	/* Checksum ok? (should be zero) */
+
+	if (checksum) {
+		ACPI_WARNING((AE_INFO,
+			      "Incorrect checksum in table [%4.4s] -  %2.2X, should be %2.2X",
+			      table->signature, table->checksum,
+			      (u8) (table->checksum - checksum)));
+
+#if (ACPI_CHECKSUM_ABORT)
+
+		return (AE_BAD_CHECKSUM);
+#endif
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_checksum
  *
  * PARAMETERS:  Buffer          - Pointer to memory region to be checked
@@ -135,24 +235,38 @@ u8 acpi_tb_checksum(u8 * buffer, acpi_na
  *
  * FUNCTION:    acpi_tb_convert_fadt
  *
- * PARAMETERS:  Fadt                - FADT table to be converted
+ * PARAMETERS:  None, uses acpi_gbl_FADT
  *
  * RETURN:      None
  *
- * DESCRIPTION: Converts a BIOS supplied ACPI 1.0 FADT to a local
- *              ACPI 2.0 FADT. If the BIOS supplied a 2.0 FADT then it is simply
- *              copied to the local FADT.  The ACPI CA software uses this
- *              local FADT. Thus a significant amount of special #ifdef
- *              type codeing is saved.
+ * DESCRIPTION: Converts all versions of the FADT to a common internal format.
+ *
+ * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt), and must contain
+ *              a copy of the actual FADT.
+ *
+ * ACPICA will use the "X" fields of the FADT for all addresses.
+ *
+ * "X" fields are optional extensions to the original V1.0 fields. Even if
+ * they are present in the structure, they can be optionally not used by
+ * setting them to zero. Therefore, we must selectively expand V1.0 fields
+ * if the corresponding X field is zero.
+ *
+ * For ACPI 1.0 FADTs, all address fields are expanded to the corresponding
+ * "X" fields.
+ *
+ * For ACPI 2.0 FADTs, any "X" fields that are NULL are filled in by
+ * expanding the corresponding ACPI 1.0 field.
  *
  ******************************************************************************/
 
-void acpi_tb_convert_fadt(struct acpi_table_fadt *fadt)
+static void acpi_tb_convert_fadt(void)
 {
+	u8 pm1_register_length;
+	struct acpi_generic_address *target;
+	acpi_native_uint i;
+
+	/* Expand the FACS and DSDT addresses as necessary */
 
-	/*
-	 * Convert table pointers to 64-bit fields
-	 */
 	if (!acpi_gbl_FADT.Xfacs) {
 		acpi_gbl_FADT.Xfacs = (u64) acpi_gbl_FADT.facs;
 	}
@@ -162,62 +276,49 @@ void acpi_tb_convert_fadt(struct acpi_ta
 	}
 
 	/*
-	 * Convert the V1.0 block addresses to V2.0 GAS structures
+	 * Expand the V1.0 addresses to the "X" generic address structs,
+	 * as necessary.
 	 */
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xpm1a_event_block,
-				     acpi_gbl_FADT.pm1_event_length,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     pm1a_event_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xpm1b_event_block,
-				     acpi_gbl_FADT.pm1_event_length,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     pm1b_event_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xpm1a_control_block,
-				     acpi_gbl_FADT.pm1_control_length,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     pm1a_control_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xpm1b_control_block,
-				     acpi_gbl_FADT.pm1_control_length,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     pm1b_control_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xpm2_control_block,
-				     acpi_gbl_FADT.pm2_control_length,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     pm2_control_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xpm_timer_block,
-				     acpi_gbl_FADT.pm_timer_length,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     pm_timer_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xgpe0_block, 0,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     gpe0_block);
-	acpi_tb_init_generic_address(&acpi_gbl_FADT.xgpe1_block, 0,
-				     (acpi_physical_address) acpi_gbl_FADT.
-				     gpe1_block);
+	for (i = 0; i < ACPI_FADT_CONVERSION_ENTRIES; i++) {
+		target =
+		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
+				 fadt_conversion_table[i].target);
+
+		if (!target->address) {
+			acpi_tb_init_generic_address(target,
+						     *ACPI_ADD_PTR(u8,
+								   &acpi_gbl_FADT,
+								   fadt_conversion_table
+								   [i].length),
+						     *ACPI_ADD_PTR(u64,
+								   &acpi_gbl_FADT,
+								   fadt_conversion_table
+								   [i].source));
+		}
+	}
 
 	/*
-	 * Create separate GAS structs for the PM1 Enable registers
+	 * Calculate separate GAS structs for the PM1 Enable registers.
+	 * These addresses do not appear (directly) in the FADT, so it is
+	 * useful to calculate them once, here.
 	 */
+	pm1_register_length = (u8) ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
+
+	/* PM1A is required */
+
 	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
-				     (u8) ACPI_DIV_2(acpi_gbl_FADT.
-						     pm1_event_length),
-				     (acpi_physical_address)
-				     (acpi_gbl_FADT.xpm1a_event_block.address +
-				      ACPI_DIV_2(acpi_gbl_FADT.
-						 pm1_event_length)));
+				     pm1_register_length,
+				     (u64) (acpi_gbl_FADT.xpm1a_event_block.
+					    address + pm1_register_length));
+
+	/* PM1B is optional; leave null if not present */
 
-	/*
-	 * PM1B is optional; leave null if not present
-	 */
 	if (acpi_gbl_FADT.xpm1b_event_block.address) {
 		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
-					     (u8) ACPI_DIV_2(acpi_gbl_FADT.
-							     pm1_event_length),
-					     (acpi_physical_address)
-					     (acpi_gbl_FADT.xpm1b_event_block.
-					      address +
-					      ACPI_DIV_2(acpi_gbl_FADT.
-							 pm1_event_length)));
+					     pm1_register_length,
+					     (u64) (acpi_gbl_FADT.
+						    xpm1b_event_block.address +
+						    pm1_register_length));
 	}
 
 	/* Global FADT is the new common V2.0 FADT  */
@@ -227,84 +328,132 @@ void acpi_tb_convert_fadt(struct acpi_ta
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_parse_fadt
+ * FUNCTION:    acpi_tb_install_table
  *
- * PARAMETERS:  Fadt                - Pointer to FADT table
- *              Flags               - Flags
+ * PARAMETERS:  Address                 - Physical address of DSDT or FACS
+ *              Flags                   - Flags
+ *              Signature               - Table signature, NULL if no need to
+ *                                        match
+ *              table_index             - Index into root table array
  *
- * RETURN:      none
+ * RETURN:      None
  *
- * DESCRIPTION: This function is called to initialise the FADT, DSDT and FACS
- *              tables (FADT contains the addresses of the DSDT and FACS)
+ * DESCRIPTION: Install an ACPI table into the global data structure.
  *
  ******************************************************************************/
 
-static void acpi_tb_parse_fadt(struct acpi_table_fadt *fadt, u8 flags)
+static void
+acpi_tb_install_table(acpi_physical_address address,
+		      u8 flags, char *signature, acpi_native_uint table_index)
 {
-	acpi_physical_address dsdt_address =
-	    (acpi_physical_address) fadt->Xdsdt;
-	acpi_physical_address facs_address =
-	    (acpi_physical_address) fadt->Xfacs;
 	struct acpi_table_header *table;
 
-	if (!dsdt_address) {
-		goto no_dsdt;
+	if (!address) {
+		ACPI_ERROR((AE_INFO,
+			    "Null physical address for ACPI table [%s]",
+			    signature));
+		return;
 	}
 
-	table =
-	    acpi_os_map_memory(dsdt_address, sizeof(struct acpi_table_header));
+	/* Map just the table header */
+
+	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
 	if (!table) {
-		goto no_dsdt;
+		return;
+	}
+
+	/* If a particular signature is expected, signature must match */
+
+	if (signature && !ACPI_COMPARE_NAME(table->signature, signature)) {
+		ACPI_ERROR((AE_INFO,
+			    "Invalid signature 0x%X for ACPI table [%s]",
+			    *ACPI_CAST_PTR(u32, table->signature), signature));
+		goto unmap_and_exit;
 	}
 
-	/* Initialize the DSDT table */
+	/* Initialize the table entry */
+
+	acpi_gbl_root_table_list.tables[table_index].address = address;
+	acpi_gbl_root_table_list.tables[table_index].length = table->length;
+	acpi_gbl_root_table_list.tables[table_index].flags = flags;
 
 	ACPI_MOVE_32_TO_32(&
-			   (acpi_gbl_root_table_list.
-			    tables[ACPI_TABLE_INDEX_DSDT].signature),
-			   ACPI_SIG_DSDT);
+			   (acpi_gbl_root_table_list.tables[table_index].
+			    signature), table->signature);
 
-	acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].address =
-	    dsdt_address;
-	acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].length =
-	    table->length;
-	acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].flags = flags;
+	acpi_tb_print_table_header(address, table);
 
-	acpi_tb_print_table_header(dsdt_address, table);
+	if (table_index == ACPI_TABLE_INDEX_DSDT) {
 
-	/* Global integer width is based upon revision of the DSDT */
+		/* Global integer width is based upon revision of the DSDT */
 
-	acpi_ut_set_integer_width(table->revision);
+		acpi_ut_set_integer_width(table->revision);
+	}
+
+      unmap_and_exit:
 	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+}
 
-      no_dsdt:
-	if (!facs_address) {
-		return;
-	}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_parse_fadt
+ *
+ * PARAMETERS:  table_index         - Index for the FADT
+ *              Flags               - Flags
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Initialize the FADT, DSDT and FACS tables
+ *              (FADT contains the addresses of the DSDT and FACS)
+ *
+ ******************************************************************************/
+
+static void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
+{
+	u32 length;
+	struct acpi_table_header *table;
+
+	/*
+	 * Special case for the FADT because of multiple versions and the fact
+	 * that it contains pointers to both the DSDT and FACS tables.
+	 *
+	 * Get a local copy of the FADT and convert it to a common format
+	 * Map entire FADT, assumed to be smaller than one page.
+	 */
+	length = acpi_gbl_root_table_list.tables[table_index].length;
 
 	table =
-	    acpi_os_map_memory(facs_address, sizeof(struct acpi_table_header));
+	    acpi_os_map_memory(acpi_gbl_root_table_list.tables[table_index].
+			       address, length);
 	if (!table) {
 		return;
 	}
 
-	/* Initialize the FACS table */
+	/*
+	 * Validate the FADT checksum before we copy the table. Ignore
+	 * checksum error as we want to try to get the DSDT and FACS.
+	 */
+	(void)acpi_tb_verify_checksum(table, length);
 
-	ACPI_MOVE_32_TO_32(&
-			   (acpi_gbl_root_table_list.
-			    tables[ACPI_TABLE_INDEX_FACS].signature),
-			   ACPI_SIG_FACS);
+	/* Copy the entire FADT locally */
 
-	acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_FACS].address =
-	    facs_address;
-	acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_FACS].length =
-	    table->length;
-	acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_FACS].flags = flags;
+	ACPI_MEMSET(&acpi_gbl_FADT, sizeof(struct acpi_table_fadt), 0);
 
-	ACPI_INFO((AE_INFO, "%4.4s @ 0x%p",
-		   table->signature, ACPI_CAST_PTR(void, facs_address)));
+	ACPI_MEMCPY(&acpi_gbl_FADT, table,
+		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
+	acpi_os_unmap_memory(table, length);
 
-	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+	/* Convert local FADT to the common internal format */
+
+	acpi_tb_convert_fadt();
+
+	/* Extract the DSDT and FACS tables from the FADT */
+
+	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
+			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
+
+	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
+			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
 }
 
 /*******************************************************************************
@@ -325,20 +474,33 @@ static void acpi_tb_parse_fadt(struct ac
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_parse_root_table(struct acpi_table_rsdp *rsdp, u8 flags)
+acpi_status
+acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 {
+	struct acpi_table_rsdp *rsdp;
+	acpi_native_uint table_entry_size;
+	acpi_native_uint i;
+	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
 	u32 length;
 	u8 *table_entry;
-	acpi_native_uint i;
-	acpi_native_uint pointer_size;
-	u32 table_count;
-	u8 checksum;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(tb_parse_root_table);
 
+	/*
+	 * Map the entire RSDP and extract the address of the RSDT or XSDT
+	 */
+	rsdp = acpi_os_map_memory(rsdp_address, sizeof(struct acpi_table_rsdp));
+	if (!rsdp) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	acpi_tb_print_table_header(rsdp_address,
+				   ACPI_CAST_PTR(struct acpi_table_header,
+						 rsdp));
+
 	/* Differentiate between RSDT and XSDT root tables */
 
 	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
@@ -347,22 +509,30 @@ acpi_status acpi_tb_parse_root_table(str
 		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
 		 * the ACPI specification.
 		 */
-		address = (acpi_native_uint) rsdp->xsdt_physical_address;
-		pointer_size = sizeof(u64);
+		address = (acpi_physical_address) rsdp->xsdt_physical_address;
+		table_entry_size = sizeof(u64);
 	} else {
 		/* Root table is an RSDT (32-bit physical addresses) */
 
-		address = (acpi_native_uint) rsdp->rsdt_physical_address;
-		pointer_size = sizeof(u32);
+		address = (acpi_physical_address) rsdp->rsdt_physical_address;
+		table_entry_size = sizeof(u32);
 	}
 
-	/* Map the table header to get the full table length */
+	/*
+	 * It is not possible to map more than one entry in some environments,
+	 * so unmap the RSDP here before mapping other tables
+	 */
+	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
+
+	/* Map the RSDT/XSDT table header to get the full table length */
 
 	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
 	if (!table) {
-		return (AE_NO_MEMORY);
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
+	acpi_tb_print_table_header(address, table);
+
 	/* Get the length of the full table, verify length and map entire table */
 
 	length = table->length;
@@ -371,48 +541,45 @@ acpi_status acpi_tb_parse_root_table(str
 	if (length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO, "Invalid length 0x%X in RSDT/XSDT",
 			    length));
-		return (AE_INVALID_TABLE_LENGTH);
+		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
 	}
 
 	table = acpi_os_map_memory(address, length);
 	if (!table) {
-		return (AE_NO_MEMORY);
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	/* Validate the root table checksum */
 
-	checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, table), length);
-#if (ACPI_CHECKSUM_ABORT)
-
-	if (checksum) {
+	status = acpi_tb_verify_checksum(table, length);
+	if (ACPI_FAILURE(status)) {
 		acpi_os_unmap_memory(table, length);
-		return (AE_BAD_CHECKSUM);
+		return_ACPI_STATUS(status);
 	}
-#endif
-
-	acpi_tb_print_table_header(address, table);
 
 	/* Calculate the number of tables described in the root table */
 
 	table_count =
-	    (table->length - sizeof(struct acpi_table_header)) / pointer_size;
-
-	/* Setup loop */
+	    (table->length -
+	     sizeof(struct acpi_table_header)) / table_entry_size;
 
+	/*
+	 * First two entries in the table array are reserved for the DSDT and FACS,
+	 * which are not actually present in the RSDT/XSDT - they come from the FADT
+	 */
 	table_entry =
 	    ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
 	acpi_gbl_root_table_list.count = 2;
 
 	/*
-	 * Initialize the ACPI table entries
-	 * First two entries in the table array are reserved for the DSDT and FACS
+	 * Initialize the root table array from the RSDT/XSDT
 	 */
-	for (i = 0; i < table_count; ++i, table_entry += pointer_size) {
-
-		/* Ensure there is room for another table entry */
-
+	for (i = 0; i < table_count; i++) {
 		if (acpi_gbl_root_table_list.count >=
 		    acpi_gbl_root_table_list.size) {
+
+			/* There is no more room in the root table array, attempt resize */
+
 			status = acpi_tb_resize_root_table_list();
 			if (ACPI_FAILURE(status)) {
 				ACPI_WARNING((AE_INFO,
@@ -425,20 +592,34 @@ acpi_status acpi_tb_parse_root_table(str
 			}
 		}
 
-		/* Get the physical address (32-bit for RSDT, 64-bit for XSDT) */
-
-		if (pointer_size == sizeof(u32)) {
+		/*
+		 * Get the table physical address (32-bit for RSDT, 64-bit for XSDT)
+		 */
+		if ((table_entry_size == sizeof(u32)) ||
+		    (sizeof(acpi_physical_address) == sizeof(u32))) {
+			/*
+			 * 32-bit platform, RSDT: Move 32-bit to 32-bit
+			 * 32-bit platform, XSDT: Truncate 64-bit to 32-bit
+			 * 64-bit platform, RSDT: Expand 32-bit to 64-bit
+			 *
+			 * Note: Addresses are 32-bit aligned in both RSDT and XSDT
+			 */
 			acpi_gbl_root_table_list.
 			    tables[acpi_gbl_root_table_list.count].address =
 			    (acpi_physical_address) (*ACPI_CAST_PTR
 						     (u32, table_entry));
 		} else {
-			acpi_gbl_root_table_list.
-			    tables[acpi_gbl_root_table_list.count].address =
-			    (acpi_physical_address) (*ACPI_CAST_PTR
-						     (u64, table_entry));
+			/*
+			 * 64-bit platform, XSDT: Move 64-bit to 64-bit
+			 *
+			 * Note: 64-bit addresses are only 32-bit aligned in the XSDT
+			 */
+			ACPI_MOVE_64_TO_64(&acpi_gbl_root_table_list.
+					   tables[acpi_gbl_root_table_list.
+						  count].address, table_entry);
 		}
 
+		table_entry += table_entry_size;
 		acpi_gbl_root_table_list.count++;
 	}
 
@@ -448,59 +629,20 @@ acpi_status acpi_tb_parse_root_table(str
 	 */
 	acpi_os_unmap_memory(table, length);
 
-	/* Initialize all tables other than the DSDT and FACS */
-
+	/*
+	 * Complete the initialization of the root table array by examining
+	 * the header of each table
+	 */
 	for (i = 2; i < acpi_gbl_root_table_list.count; i++) {
-		address = acpi_gbl_root_table_list.tables[i].address;
-		length = sizeof(struct acpi_table_header);
-
-		table = acpi_os_map_memory(address, length);
-		if (!table) {
-			continue;
-		}
-
-		acpi_gbl_root_table_list.tables[i].length = table->length;
-		acpi_gbl_root_table_list.tables[i].flags = flags;
-
-		ACPI_MOVE_32_TO_32(&
-				   (acpi_gbl_root_table_list.tables[i].
-				    signature), table->signature);
-
-		acpi_tb_print_table_header(address, table);
-
-		/*
-		 * Special case for the FADT because of multiple versions -
-		 * get a local copy and convert to common format
-		 */
-		if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_FADT)) {
-			acpi_os_unmap_memory(table, length);
-			length = table->length;
-
-			table = acpi_os_map_memory(address, length);
-			if (!table) {
-				continue;
-			}
-
-			/* Copy the entire FADT locally */
-
-			ACPI_MEMCPY(&acpi_gbl_FADT, table,
-				    ACPI_MIN(table->length,
-					     sizeof(struct acpi_table_fadt)));
+		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
+				      address, flags, NULL, i);
 
-			/* Small table means old revision, convert to new */
+		/* Special case for FADT - get the DSDT and FACS */
 
-			if (table->length < sizeof(struct acpi_table_fadt)) {
-				acpi_tb_convert_fadt(ACPI_CAST_PTR
-						     (struct acpi_table_fadt,
-						      table));
-			}
-
-			/* Unmap original FADT */
-
-			acpi_os_unmap_memory(table, length);
-			acpi_tb_parse_fadt(&acpi_gbl_FADT, flags);
-		} else {
-			acpi_os_unmap_memory(table, length);
+		if (ACPI_COMPARE_NAME
+		    (&acpi_gbl_root_table_list.tables[i].signature,
+		     ACPI_SIG_FADT)) {
+			acpi_tb_parse_fadt(i, flags);
 		}
 	}
 
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index 61faaa6..c697d6d 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -82,9 +82,8 @@ acpi_status
 acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
-	acpi_physical_address address;
+	acpi_physical_address rsdp_address;
 	acpi_status status;
-	struct acpi_table_rsdp *rsdp;
 
 	ACPI_FUNCTION_TRACE(acpi_initialize_tables);
 
@@ -94,7 +93,7 @@ acpi_initialize_tables(struct acpi_table
 	 */
 	if (!initial_table_array) {
 		acpi_gbl_root_table_list.size = initial_table_count;
-		acpi_gbl_root_table_list.flags = ACPI_TABLE_FLAGS_ALLOW_RESIZE;
+		acpi_gbl_root_table_list.flags = ACPI_ROOT_ALLOW_RESIZE;
 
 		status = acpi_tb_resize_root_table_list();
 		if (ACPI_FAILURE(status)) {
@@ -103,37 +102,33 @@ acpi_initialize_tables(struct acpi_table
 	} else {
 		/* Root Table Array has been statically allocated by the host */
 
+		ACPI_MEMSET(initial_table_array,
+			    initial_table_count *
+			    sizeof(struct acpi_table_desc), 0);
+
 		acpi_gbl_root_table_list.tables = initial_table_array;
 		acpi_gbl_root_table_list.size = initial_table_count;
-		acpi_gbl_root_table_list.flags = ACPI_TABLE_ORIGIN_UNKNOWN;
+		acpi_gbl_root_table_list.flags = ACPI_ROOT_ORIGIN_UNKNOWN;
 		if (allow_resize) {
-			acpi_gbl_root_table_list.flags =
-			    ACPI_TABLE_FLAGS_ALLOW_RESIZE;
+			acpi_gbl_root_table_list.flags |=
+			    ACPI_ROOT_ALLOW_RESIZE;
 		}
 	}
 
-	/* Get the RSDP and map it */
+	/* Get the address of the RSDP */
 
-	address = acpi_os_get_root_pointer();
-	if (!address) {
+	rsdp_address = acpi_os_get_root_pointer();
+	if (!rsdp_address) {
 		return_ACPI_STATUS(AE_NOT_FOUND);
 	}
 
-	rsdp = acpi_os_map_memory(address, sizeof(struct acpi_table_rsdp));
-	if (!rsdp) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	ACPI_INFO((AE_INFO, "%.8s @ 0x%p",
-		   rsdp->signature, ACPI_CAST_PTR(void, address)));
-
 	/*
 	 * Get the root table (RSDT or XSDT) and extract all entries to the local
 	 * Root Table Array. This array contains the information of the RSDT/XSDT
 	 * in a common, more useable format.
 	 */
-	status = acpi_tb_parse_root_table(rsdp, ACPI_TABLE_ORIGIN_MAPPED);
-	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
+	status =
+	    acpi_tb_parse_root_table(rsdp_address, ACPI_TABLE_ORIGIN_MAPPED);
 	return_ACPI_STATUS(status);
 }
 
@@ -164,8 +159,7 @@ acpi_status acpi_reallocate_root_table(v
 	 * Only reallocate the root table if the host provided a static buffer
 	 * for the table array in the call to acpi_initialize_tables.
 	 */
-	if ((acpi_gbl_root_table_list.flags & ACPI_TABLE_ORIGIN_MASK) !=
-	    ACPI_TABLE_ORIGIN_UNKNOWN) {
+	if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
@@ -185,7 +179,7 @@ acpi_status acpi_reallocate_root_table(v
 	acpi_gbl_root_table_list.size = acpi_gbl_root_table_list.count;
 	acpi_gbl_root_table_list.tables = tables;
 	acpi_gbl_root_table_list.flags =
-	    ACPI_TABLE_ORIGIN_ALLOCATED | ACPI_TABLE_FLAGS_ALLOW_RESIZE;
+	    ACPI_ROOT_ORIGIN_ALLOCATED | ACPI_ROOT_ALLOW_RESIZE;
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -217,6 +211,12 @@ acpi_get_table_header(char *signature,
 	acpi_native_uint i;
 	acpi_native_uint j;
 
+	/* Parameter validation */
+
+	if (!signature || !out_table_header) {
+		return (AE_BAD_PARAMETER);
+	}
+
 	/*
 	 * Walk the root table list
 	 */
@@ -237,7 +237,7 @@ acpi_get_table_header(char *signature,
 				acpi_gbl_root_table_list.tables[i].
 				flags & ACPI_TABLE_ORIGIN_MASK);
 
-		if (!out_table_header) {
+		if (!(*out_table_header)) {
 			return (AE_NO_MEMORY);
 		}
 
@@ -270,6 +270,12 @@ acpi_get_table(char *signature,
 	acpi_native_uint j;
 	acpi_status status;
 
+	/* Parameter validation */
+
+	if (!signature || !out_table) {
+		return (AE_BAD_PARAMETER);
+	}
+
 	/*
 	 * Walk the root table list
 	 */
@@ -318,6 +324,12 @@ acpi_get_table_by_index(acpi_native_uint
 
 	ACPI_FUNCTION_TRACE(acpi_get_table_by_index);
 
+	/* Parameter validation */
+
+	if (!table) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 	/* Validate index */
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 47dcf82..4b03051 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -996,9 +996,13 @@ acpi_ut_info(char *module_name, u32 line
 {
 	va_list args;
 
-	acpi_os_printf("ACPI (%s-%04d): ", module_name, line_number);
+	/*
+	 * Removed module_name, line_number, and acpica version, not needed
+	 * for info output
+	 */
+	acpi_os_printf("ACPI: ");
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
-	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	acpi_os_printf("\n");
 }
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index cf712df..ed181bc 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -63,7 +63,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20060823
+#define ACPI_CA_VERSION                 0x20060828
 
 /*
  * OS name, used for the _OS object.  The _OS object is essentially obsolete,
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 0f12fec..a870484 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -227,6 +227,16 @@ struct acpi_table_desc {
 	u8 flags;
 };
 
+/* Flags for above */
+
+#define ACPI_TABLE_ORIGIN_UNKNOWN       (0)
+#define ACPI_TABLE_ORIGIN_MAPPED        (1)
+#define ACPI_TABLE_ORIGIN_ALLOCATED     (2)
+#define ACPI_TABLE_ORIGIN_MASK          (3)
+#define ACPI_TABLE_IS_LOADED            (4)
+
+/* One internal RSDT for table management */
+
 struct acpi_internal_rsdt {
 	struct acpi_table_desc *tables;
 	u32 count;
@@ -234,14 +244,11 @@ struct acpi_internal_rsdt {
 	u8 flags;
 };
 
-/* Flags for both structs above */
+/* Flags for above */
 
-#define ACPI_TABLE_ORIGIN_UNKNOWN       (0)
-#define ACPI_TABLE_ORIGIN_MAPPED        (1)
-#define ACPI_TABLE_ORIGIN_ALLOCATED     (2)
-#define ACPI_TABLE_ORIGIN_MASK          (3)
-#define ACPI_TABLE_FLAGS_LOADED         (4)
-#define ACPI_TABLE_FLAGS_ALLOW_RESIZE   (8)
+#define ACPI_ROOT_ORIGIN_UNKNOWN        (0)	/* ~ORIGIN_ALLOCATED */
+#define ACPI_ROOT_ORIGIN_ALLOCATED      (1)
+#define ACPI_ROOT_ALLOW_RESIZE          (2)
 
 /* Predefined (fixed) table indexes */
 
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 1737a2f..9183de1 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -94,9 +94,11 @@ acpi_tb_print_table_header(acpi_physical
 
 u8 acpi_tb_checksum(u8 * buffer, acpi_native_uint length);
 
-void acpi_tb_convert_fadt(struct acpi_table_fadt *fadt);
+acpi_status
+acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
-acpi_status acpi_tb_parse_root_table(struct acpi_table_rsdp *rsdp, u8 flags);
+acpi_status
+acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags);
 
 void *acpi_tb_map(acpi_physical_address address, u32 length, u32 flags);
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index b455f54..c55939e 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -199,8 +199,8 @@ struct acpi_table_fadt {
 	u32 pm1b_control_block;	/* Port address of Power Mgt 1b Control Reg Blk */
 	u32 pm2_control_block;	/* Port address of Power Mgt 2 Control Reg Blk */
 	u32 pm_timer_block;	/* Port address of Power Mgt Timer Ctrl Reg Blk */
-	u32 gpe0_block;		/* Port addr of General Purpose acpi_event 0 Reg Blk */
-	u32 gpe1_block;		/* Port addr of General Purpose acpi_event 1 Reg Blk */
+	u32 gpe0_block;		/* Port addr of General Purpose Event 0 Reg Blk */
+	u32 gpe1_block;		/* Port addr of General Purpose Event 1 Reg Blk */
 	u8 pm1_event_length;	/* Byte Length of ports at pm1_x_evt_blk */
 	u8 pm1_control_length;	/* Byte Length of ports at pm1_x_cnt_blk */
 	u8 pm2_control_length;	/* Byte Length of ports at pm2_cnt_blk */
@@ -226,14 +226,14 @@ struct acpi_table_fadt {
 	u8 reserved4[3];	/* These three bytes must be zero */
 	u64 Xfacs;		/* 64-bit physical address of FACS */
 	u64 Xdsdt;		/* 64-bit physical address of DSDT */
-	struct acpi_generic_address xpm1a_event_block;	/* Extended Power Mgt 1a acpi_event Reg Blk address */
-	struct acpi_generic_address xpm1b_event_block;	/* Extended Power Mgt 1b acpi_event Reg Blk address */
+	struct acpi_generic_address xpm1a_event_block;	/* Extended Power Mgt 1a Event Reg Blk address */
+	struct acpi_generic_address xpm1b_event_block;	/* Extended Power Mgt 1b Event Reg Blk address */
 	struct acpi_generic_address xpm1a_control_block;	/* Extended Power Mgt 1a Control Reg Blk address */
 	struct acpi_generic_address xpm1b_control_block;	/* Extended Power Mgt 1b Control Reg Blk address */
 	struct acpi_generic_address xpm2_control_block;	/* Extended Power Mgt 2 Control Reg Blk address */
 	struct acpi_generic_address xpm_timer_block;	/* Extended Power Mgt Timer Ctrl Reg Blk address */
-	struct acpi_generic_address xgpe0_block;	/* Extended General Purpose acpi_event 0 Reg Blk address */
-	struct acpi_generic_address xgpe1_block;	/* Extended General Purpose acpi_event 1 Reg Blk address */
+	struct acpi_generic_address xgpe0_block;	/* Extended General Purpose Event 0 Reg Blk address */
+	struct acpi_generic_address xgpe1_block;	/* Extended General Purpose Event 1 Reg Blk address */
 };
 
 /* FADT flags */
-- 
1.4.4.1
