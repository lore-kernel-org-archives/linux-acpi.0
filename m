From: Len Brown <lenb@kernel.org>
Subject: [PATCH 68/140] ACPICA: Delete stale FADT functions outside tbfadt.c.
Date: Wed,  7 Feb 2007 13:51:22 -0500
Message-ID: <11708744752537-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:17574 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422799AbXBGSyk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:40 -0500
In-Reply-To: <11708744732351-git-send-email-lenb@kernel.org>
Message-Id: <765ec20180fb70b4ee9d730167b2a0b76879f791.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Moved all FADT-related functions to a new file, tbfadt.c.
Eliminated the acpi_hw_initialize function - the
FADT registers are now validated when the table is loaded.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwacpi.c   |   29 -----
 drivers/acpi/tables/tbutils.c    |  238 +-------------------------------------
 drivers/acpi/utilities/utinit.c  |   95 ---------------
 drivers/acpi/utilities/utxface.c |   14 ---
 include/acpi/achware.h           |    2 -
 include/acpi/actables.h          |    9 ++
 include/acpi/acutils.h           |    2 -
 7 files changed, 10 insertions(+), 379 deletions(-)

diff --git a/drivers/acpi/hardware/hwacpi.c b/drivers/acpi/hardware/hwacpi.c
index 14e8111..9c7df71 100644
--- a/drivers/acpi/hardware/hwacpi.c
+++ b/drivers/acpi/hardware/hwacpi.c
@@ -49,34 +49,6 @@ ACPI_MODULE_NAME("hwacpi")
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_hw_initialize
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Initialize and validate the various ACPI registers defined in
- *              the FADT.
- *
- ******************************************************************************/
-acpi_status acpi_hw_initialize(void)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(hw_initialize);
-
-	/* Sanity check the FADT for valid values */
-
-	status = acpi_ut_validate_fadt();
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	return_ACPI_STATUS(AE_OK);
-}
-
-/******************************************************************************
- *
  * FUNCTION:    acpi_hw_set_mode
  *
  * PARAMETERS:  Mode            - SYS_MODE_ACPI or SYS_MODE_LEGACY
@@ -86,7 +58,6 @@ acpi_status acpi_hw_initialize(void)
  * DESCRIPTION: Transitions the system into the requested mode.
  *
  ******************************************************************************/
-
 acpi_status acpi_hw_set_mode(u32 mode)
 {
 
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 6d13737..54e53e6 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -48,57 +48,10 @@
 ACPI_MODULE_NAME("tbutils")
 
 /* Local prototypes */
-static void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
-
-static void acpi_tb_convert_fadt(void);
-
-static void
-acpi_tb_install_table(acpi_physical_address address,
-		      u8 flags, char *signature, acpi_native_uint table_index);
-
-static void inline
-acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
-			     u8 bit_width, u64 address);
-
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 * table_entry,
 			     acpi_native_uint table_entry_size);
 
-/* Table used for conversion of FADT to common format */
-
-typedef struct acpi_fadt_conversion {
-	u8 target;
-	u8 source;
-	u8 length;
-
-} acpi_fadt_conversion;
-
-static struct acpi_fadt_conversion fadt_conversion_table[] = {
-	{ACPI_FADT_OFFSET(xpm1a_event_block),
-	 ACPI_FADT_OFFSET(pm1a_event_block),
-	 ACPI_FADT_OFFSET(pm1_event_length)},
-	{ACPI_FADT_OFFSET(xpm1b_event_block),
-	 ACPI_FADT_OFFSET(pm1b_event_block),
-	 ACPI_FADT_OFFSET(pm1_event_length)},
-	{ACPI_FADT_OFFSET(xpm1a_control_block),
-	 ACPI_FADT_OFFSET(pm1a_control_block),
-	 ACPI_FADT_OFFSET(pm1_control_length)},
-	{ACPI_FADT_OFFSET(xpm1b_control_block),
-	 ACPI_FADT_OFFSET(pm1b_control_block),
-	 ACPI_FADT_OFFSET(pm1_control_length)},
-	{ACPI_FADT_OFFSET(xpm2_control_block),
-	 ACPI_FADT_OFFSET(pm2_control_block),
-	 ACPI_FADT_OFFSET(pm2_control_length)},
-	{ACPI_FADT_OFFSET(xpm_timer_block), ACPI_FADT_OFFSET(pm_timer_block),
-	 ACPI_FADT_OFFSET(pm_timer_length)},
-	{ACPI_FADT_OFFSET(xgpe0_block), ACPI_FADT_OFFSET(gpe0_block),
-	 ACPI_FADT_OFFSET(gpe0_block_length)},
-	{ACPI_FADT_OFFSET(xgpe1_block), ACPI_FADT_OFFSET(gpe1_block),
-	 ACPI_FADT_OFFSET(gpe1_block_length)}
-};
-
-#define ACPI_FADT_CONVERSION_ENTRIES        (sizeof (fadt_conversion_table) / sizeof (struct acpi_fadt_conversion))
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_print_table_header
@@ -153,32 +106,6 @@ acpi_tb_print_table_header(acpi_physical_address address,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_init_generic_address
- *
- * PARAMETERS:  new_gas_struct      - GAS struct to be initialized
- *              bit_width           - Width of this register
- *              Address             - Address of the register
- *
- * RETURN:      None
- *
- * DESCRIPTION: Initialize a GAS structure.
- *
- ******************************************************************************/
-
-static void inline
-acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
-			     u8 bit_width, u64 address)
-{
-
-	ACPI_MOVE_64_TO_64(&new_gas_struct->address, &address);
-	new_gas_struct->space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	new_gas_struct->bit_width = bit_width;
-	new_gas_struct->bit_offset = 0;
-	new_gas_struct->access_width = 0;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_validate_checksum
  *
  * PARAMETERS:  Table               - ACPI table to verify
@@ -243,107 +170,6 @@ u8 acpi_tb_checksum(u8 * buffer, acpi_native_uint length)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_convert_fadt
- *
- * PARAMETERS:  None, uses acpi_gbl_FADT
- *
- * RETURN:      None
- *
- * DESCRIPTION: Converts all versions of the FADT to a common internal format.
- *
- * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt), and must contain
- *              a copy of the actual FADT.
- *
- * ACPICA will use the "X" fields of the FADT for all addresses.
- *
- * "X" fields are optional extensions to the original V1.0 fields. Even if
- * they are present in the structure, they can be optionally not used by
- * setting them to zero. Therefore, we must selectively expand V1.0 fields
- * if the corresponding X field is zero.
- *
- * For ACPI 1.0 FADTs, all address fields are expanded to the corresponding
- * "X" fields.
- *
- * For ACPI 2.0 FADTs, any "X" fields that are NULL are filled in by
- * expanding the corresponding ACPI 1.0 field.
- *
- ******************************************************************************/
-
-static void acpi_tb_convert_fadt(void)
-{
-	u8 pm1_register_length;
-	struct acpi_generic_address *target;
-	acpi_native_uint i;
-
-	/* Expand the FACS and DSDT addresses as necessary */
-
-	if (!acpi_gbl_FADT.Xfacs) {
-		acpi_gbl_FADT.Xfacs = (u64) acpi_gbl_FADT.facs;
-	}
-
-	if (!acpi_gbl_FADT.Xdsdt) {
-		acpi_gbl_FADT.Xdsdt = (u64) acpi_gbl_FADT.dsdt;
-	}
-
-	/*
-	 * Expand the 32-bit V1.0 addresses to the 64-bit "X" generic address
-	 * structures as necessary.
-	 */
-	for (i = 0; i < ACPI_FADT_CONVERSION_ENTRIES; i++) {
-		target =
-		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
-				 fadt_conversion_table[i].target);
-
-		/* Expand only if the X target is null */
-
-		if (!target->address) {
-			acpi_tb_init_generic_address(target,
-						     *ACPI_ADD_PTR(u8,
-								   &acpi_gbl_FADT,
-								   fadt_conversion_table
-								   [i].length),
-						     (u64) * ACPI_ADD_PTR(u32,
-									  &acpi_gbl_FADT,
-									  fadt_conversion_table
-									  [i].
-									  source));
-		}
-	}
-
-	/*
-	 * Calculate separate GAS structs for the PM1 Enable registers.
-	 * These addresses do not appear (directly) in the FADT, so it is
-	 * useful to calculate them once, here.
-	 *
-	 * The PM event blocks are split into two register blocks, first is the
-	 * PM Status Register block, followed immediately by the PM Enable Register
-	 * block. Each is of length (pm1_event_length/2)
-	 */
-	pm1_register_length = (u8) ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
-
-	/* PM1A is required */
-
-	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
-				     pm1_register_length,
-				     (acpi_gbl_FADT.xpm1a_event_block.address +
-				      pm1_register_length));
-
-	/* PM1B is optional; leave null if not present */
-
-	if (acpi_gbl_FADT.xpm1b_event_block.address) {
-		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
-					     pm1_register_length,
-					     (acpi_gbl_FADT.xpm1b_event_block.
-					      address + pm1_register_length));
-	}
-
-	/* Global FADT is the new common V2.0 FADT  */
-
-	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_install_table
  *
  * PARAMETERS:  Address                 - Physical address of DSDT or FACS
@@ -358,7 +184,7 @@ static void acpi_tb_convert_fadt(void)
  *
  ******************************************************************************/
 
-static void
+void
 acpi_tb_install_table(acpi_physical_address address,
 		      u8 flags, char *signature, acpi_native_uint table_index)
 {
@@ -412,68 +238,6 @@ acpi_tb_install_table(acpi_physical_address address,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_parse_fadt
- *
- * PARAMETERS:  table_index         - Index for the FADT
- *              Flags               - Flags
- *
- * RETURN:      None
- *
- * DESCRIPTION: Initialize the FADT, DSDT and FACS tables
- *              (FADT contains the addresses of the DSDT and FACS)
- *
- ******************************************************************************/
-
-static void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
-{
-	u32 length;
-	struct acpi_table_header *table;
-
-	/*
-	 * Special case for the FADT because of multiple versions and the fact
-	 * that it contains pointers to both the DSDT and FACS tables.
-	 *
-	 * Get a local copy of the FADT and convert it to a common format
-	 * Map entire FADT, assumed to be smaller than one page.
-	 */
-	length = acpi_gbl_root_table_list.tables[table_index].length;
-
-	table =
-	    acpi_os_map_memory(acpi_gbl_root_table_list.tables[table_index].
-			       address, length);
-	if (!table) {
-		return;
-	}
-
-	/*
-	 * Validate the FADT checksum before we copy the table. Ignore
-	 * checksum error as we want to try to get the DSDT and FACS.
-	 */
-	(void)acpi_tb_verify_checksum(table, length);
-
-	/* Copy the entire FADT locally */
-
-	ACPI_MEMSET(&acpi_gbl_FADT, 0, sizeof(struct acpi_table_fadt));
-
-	ACPI_MEMCPY(&acpi_gbl_FADT, table,
-		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
-	acpi_os_unmap_memory(table, length);
-
-	/* Convert local FADT to the common internal format */
-
-	acpi_tb_convert_fadt();
-
-	/* Extract the DSDT and FACS tables from the FADT */
-
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
-			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
-
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
-			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_get_root_table_entry
  *
  * PARAMETERS:  table_entry         - Pointer to the RSDT/XSDT table entry
diff --git a/drivers/acpi/utilities/utinit.c b/drivers/acpi/utilities/utinit.c
index 5079f19..303bde7 100644
--- a/drivers/acpi/utilities/utinit.c
+++ b/drivers/acpi/utilities/utinit.c
@@ -50,103 +50,8 @@
 ACPI_MODULE_NAME("utinit")
 
 /* Local prototypes */
-static void acpi_ut_fadt_register_error(char *register_name, u32 value);
-
 static void acpi_ut_terminate(void);
 
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_fadt_register_error
- *
- * PARAMETERS:  register_name           - Pointer to string identifying register
- *              Value                   - Actual register contents value
- *
- * RETURN:      None
- *
- * DESCRIPTION: Display failure message
- *
- ******************************************************************************/
-
-static void acpi_ut_fadt_register_error(char *register_name, u32 value)
-{
-
-	ACPI_WARNING((AE_INFO, "Invalid FADT value %s = %X",
-		      register_name, value));
-}
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_ut_validate_fadt
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Validate various ACPI registers in the FADT
- *
- ******************************************************************************/
-
-acpi_status acpi_ut_validate_fadt(void)
-{
-
-	/*
-	 * Verify Fixed ACPI Description Table fields,
-	 * but don't abort on any problems, just display error
-	 */
-	if (acpi_gbl_FADT.pm1_event_length < 4) {
-		acpi_ut_fadt_register_error("Pm1EventLength",
-					    (u32) acpi_gbl_FADT.
-					    pm1_event_length);
-	}
-
-	if (acpi_gbl_FADT.pm_timer_length < 4) {
-		acpi_ut_fadt_register_error("PmTimerLength",
-					    (u32) acpi_gbl_FADT.
-					    pm_timer_length);
-	}
-
-	if (!acpi_gbl_FADT.pm1_control_length) {
-		acpi_ut_fadt_register_error("Pm1ControlLength", 0);
-	}
-
-	if (!acpi_gbl_FADT.xpm1a_event_block.address) {
-		acpi_ut_fadt_register_error("XPm1aEventBlock.Address", 0);
-	}
-
-	if (!acpi_gbl_FADT.xpm1a_control_block.address) {
-		acpi_ut_fadt_register_error("XPm1aControlBlock.Address", 0);
-	}
-
-	if (!acpi_gbl_FADT.xpm_timer_block.address) {
-		acpi_ut_fadt_register_error("XPmTimerBlock.Address", 0);
-	}
-
-	if ((acpi_gbl_FADT.xpm2_control_block.address &&
-	     !acpi_gbl_FADT.pm2_control_length)) {
-		acpi_ut_fadt_register_error("Pm2ControlLength",
-					    (u32) acpi_gbl_FADT.
-					    pm2_control_length);
-	}
-
-	/* Length of GPE blocks must be a multiple of 2 */
-
-	if (acpi_gbl_FADT.xgpe0_block.address &&
-	    (acpi_gbl_FADT.gpe0_block_length & 1)) {
-		acpi_ut_fadt_register_error("Gpe0BlockLength",
-					    (u32) acpi_gbl_FADT.
-					    gpe0_block_length);
-	}
-
-	if (acpi_gbl_FADT.xgpe1_block.address &&
-	    (acpi_gbl_FADT.gpe1_block_length & 1)) {
-		acpi_ut_fadt_register_error("Gpe1BlockLength",
-					    (u32) acpi_gbl_FADT.
-					    gpe1_block_length);
-	}
-
-	return (AE_OK);
-}
-
 /******************************************************************************
  *
  * FUNCTION:    acpi_ut_terminate
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index 7ea2981..bec0f54 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -127,20 +127,6 @@ acpi_status acpi_enable_subsystem(u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_enable_subsystem);
 
-	/*
-	 * We must initialize the hardware before we can enable ACPI.
-	 * The values from the FADT are validated here.
-	 */
-	if (!(flags & ACPI_NO_HARDWARE_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Initializing ACPI hardware\n"));
-
-		status = acpi_hw_initialize();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/* Enable ACPI mode */
 
 	if (!(flags & ACPI_NO_ACPI_ENABLE)) {
diff --git a/include/acpi/achware.h b/include/acpi/achware.h
index 29b60a8..f3e9a03 100644
--- a/include/acpi/achware.h
+++ b/include/acpi/achware.h
@@ -61,8 +61,6 @@
 /*
  * hwacpi - high level functions
  */
-acpi_status acpi_hw_initialize(void);
-
 acpi_status acpi_hw_set_mode(u32 mode);
 
 u32 acpi_hw_get_mode(void);
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 9183de1..6294734 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -45,6 +45,11 @@
 #define __ACTABLES_H__
 
 /*
+ * tbfadt - FADT parse/convert/validate
+ */
+void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
+
+/*
  * tbfind - find ACPI table
  */
 acpi_status
@@ -97,6 +102,10 @@ u8 acpi_tb_checksum(u8 * buffer, acpi_native_uint length);
 acpi_status
 acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
+void
+acpi_tb_install_table(acpi_physical_address address,
+		      u8 flags, char *signature, acpi_native_uint table_index);
+
 acpi_status
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags);
 
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index 3c66f54..ba7d7e9 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -141,8 +141,6 @@ acpi_status acpi_ut_hardware_initialize(void);
 
 void acpi_ut_subsystem_shutdown(void);
 
-acpi_status acpi_ut_validate_fadt(void);
-
 /*
  * utclib - Local implementations of C library functions
  */
-- 
1.5.0.rc3.39.gec804
