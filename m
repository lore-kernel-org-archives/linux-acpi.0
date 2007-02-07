From: Len Brown <lenb@kernel.org>
Subject: [PATCH 75/140] ACPICA: FADT verification is now table driven.
Date: Wed,  7 Feb 2007 13:51:29 -0500
Message-ID: <1170874488430-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:1897 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422813AbXBGSyv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:51 -0500
In-Reply-To: <11708744878-git-send-email-lenb@kernel.org>
Message-Id: <ea5d8ebcbb7ca3bcb35a2133805571295f3f06e8.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Disassembler now verifies an input

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c  |  289 ++++++++++++++++++++++-------------------
 drivers/acpi/tables/tbutils.c |    2 +-
 include/acpi/actables.h       |    4 +
 3 files changed, 158 insertions(+), 137 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 62485d3..8816bab 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -49,74 +49,92 @@ ACPI_MODULE_NAME("tbfadt")
 
 /* Local prototypes */
 static void inline
-acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
+acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 bit_width, u64 address);
 
-static void acpi_tb_fadt_register_error(char *register_name, u32 value);
+/* Table for conversion of FADT to common internal format and FADT validation */
 
-static void acpi_tb_convert_fadt(void);
-
-static void acpi_tb_validate_fadt(void);
-
-/* Table used for conversion of FADT to common format */
-
-typedef struct acpi_fadt_conversion {
+typedef struct acpi_fadt_info {
+	char *name;
 	u8 target;
 	u8 source;
 	u8 length;
+	u8 type;
 
-} acpi_fadt_conversion;
+} acpi_fadt_info;
 
-static struct acpi_fadt_conversion fadt_conversion_table[] = {
-	{ACPI_FADT_OFFSET(xpm1a_event_block),
+#define ACPI_FADT_REQUIRED          1
+#define ACPI_FADT_SEPARATE_LENGTH   2
+
+static struct acpi_fadt_info fadt_info_table[] = {
+	{"Pm1aEventBlock", ACPI_FADT_OFFSET(xpm1a_event_block),
 	 ACPI_FADT_OFFSET(pm1a_event_block),
-	 ACPI_FADT_OFFSET(pm1_event_length)},
-	{ACPI_FADT_OFFSET(xpm1b_event_block),
+	 ACPI_FADT_OFFSET(pm1_event_length), ACPI_FADT_REQUIRED},
+
+	{"Pm1bEventBlock", ACPI_FADT_OFFSET(xpm1b_event_block),
 	 ACPI_FADT_OFFSET(pm1b_event_block),
-	 ACPI_FADT_OFFSET(pm1_event_length)},
-	{ACPI_FADT_OFFSET(xpm1a_control_block),
+	 ACPI_FADT_OFFSET(pm1_event_length), 0},
+
+	{"Pm1aControlBlock", ACPI_FADT_OFFSET(xpm1a_control_block),
 	 ACPI_FADT_OFFSET(pm1a_control_block),
-	 ACPI_FADT_OFFSET(pm1_control_length)},
-	{ACPI_FADT_OFFSET(xpm1b_control_block),
+	 ACPI_FADT_OFFSET(pm1_control_length), ACPI_FADT_REQUIRED},
+
+	{"Pm1bControlBlock", ACPI_FADT_OFFSET(xpm1b_control_block),
 	 ACPI_FADT_OFFSET(pm1b_control_block),
-	 ACPI_FADT_OFFSET(pm1_control_length)},
-	{ACPI_FADT_OFFSET(xpm2_control_block),
+	 ACPI_FADT_OFFSET(pm1_control_length), 0},
+
+	{"Pm2ControlBlock", ACPI_FADT_OFFSET(xpm2_control_block),
 	 ACPI_FADT_OFFSET(pm2_control_block),
-	 ACPI_FADT_OFFSET(pm2_control_length)},
-	{ACPI_FADT_OFFSET(xpm_timer_block), ACPI_FADT_OFFSET(pm_timer_block),
-	 ACPI_FADT_OFFSET(pm_timer_length)},
-	{ACPI_FADT_OFFSET(xgpe0_block), ACPI_FADT_OFFSET(gpe0_block),
-	 ACPI_FADT_OFFSET(gpe0_block_length)},
-	{ACPI_FADT_OFFSET(xgpe1_block), ACPI_FADT_OFFSET(gpe1_block),
-	 ACPI_FADT_OFFSET(gpe1_block_length)}
+	 ACPI_FADT_OFFSET(pm2_control_length), ACPI_FADT_SEPARATE_LENGTH},
+
+	{"PmTimerBlock", ACPI_FADT_OFFSET(xpm_timer_block),
+	 ACPI_FADT_OFFSET(pm_timer_block),
+	 ACPI_FADT_OFFSET(pm_timer_length), ACPI_FADT_REQUIRED},
+
+	{"Gpe0Block", ACPI_FADT_OFFSET(xgpe0_block),
+	 ACPI_FADT_OFFSET(gpe0_block),
+	 ACPI_FADT_OFFSET(gpe0_block_length), ACPI_FADT_SEPARATE_LENGTH},
+
+	{"Gpe1Block", ACPI_FADT_OFFSET(xgpe1_block),
+	 ACPI_FADT_OFFSET(gpe1_block),
+	 ACPI_FADT_OFFSET(gpe1_block_length), ACPI_FADT_SEPARATE_LENGTH}
 };
 
-#define ACPI_FADT_CONVERSION_ENTRIES        (sizeof (fadt_conversion_table) / sizeof (struct acpi_fadt_conversion))
+#define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_init_generic_address
  *
- * PARAMETERS:  new_gas_struct      - GAS struct to be initialized
+ * PARAMETERS:  generic_address     - GAS struct to be initialized
  *              bit_width           - Width of this register
  *              Address             - Address of the register
  *
  * RETURN:      None
  *
- * DESCRIPTION: Initialize a GAS structure.
+ * DESCRIPTION: Initialize a Generic Address Structure (GAS)
+ *              See the ACPI specification for a full description and
+ *              definition of this structure.
  *
  ******************************************************************************/
 
 static void inline
-acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
+acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 bit_width, u64 address)
 {
 
-	ACPI_MOVE_64_TO_64(&new_gas_struct->address, &address);
-	new_gas_struct->space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	new_gas_struct->bit_width = bit_width;
-	new_gas_struct->bit_offset = 0;
-	new_gas_struct->access_width = 0;
+	/*
+	 * The 64-bit Address field is non-aligned in the byte packed
+	 * GAS struct.
+	 */
+	ACPI_MOVE_64_TO_64(&generic_address->address, &address);
+
+	/* All other fields are byte-wide */
+
+	generic_address->space_id = ACPI_ADR_SPACE_SYSTEM_IO;
+	generic_address->bit_width = bit_width;
+	generic_address->bit_offset = 0;
+	generic_address->access_width = 0;
 }
 
 /*******************************************************************************
@@ -139,8 +157,8 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
 	struct acpi_table_header *table;
 
 	/*
-	 * Special case for the FADT because of multiple versions and the fact
-	 * that it contains pointers to both the DSDT and FACS tables.
+	 * The FADT has multiple versions with different lengths,
+	 * and it contains pointers to both the DSDT and FACS tables.
 	 *
 	 * Get a local copy of the FADT and convert it to a common format
 	 * Map entire FADT, assumed to be smaller than one page.
@@ -160,29 +178,41 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
 	 */
 	(void)acpi_tb_verify_checksum(table, length);
 
-	/* Copy the entire FADT locally */
+	/*
+	 * If the FADT is larger than what we know about, we have a problem.
+	 * Truncate the table, but make some noise.
+	 */
+	if (length > sizeof(struct acpi_table_fadt)) {
+		ACPI_WARNING((AE_INFO,
+			      "FADT (revision %u) is too large, truncating length 0x%X to 0x%X",
+			      table->revision, length,
+			      sizeof(struct acpi_table_fadt)));
+	}
 
-	ACPI_MEMSET(&acpi_gbl_FADT, 0, sizeof(struct acpi_table_fadt));
+	/* Copy the entire FADT locally. Zero first for tb_convert_fadt */
 
+	ACPI_MEMSET(&acpi_gbl_FADT, 0, sizeof(struct acpi_table_fadt));
 	ACPI_MEMCPY(&acpi_gbl_FADT, table,
 		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
-	acpi_os_unmap_memory(table, length);
 
-	/* Convert local FADT to the common internal format */
+	/* All done with the real FADT, unmap it */
+
+	acpi_os_unmap_memory(table, length);
 
+	/*
+	 * 1) Convert the local copy of the FADT to the common internal format
+	 * 2) Validate some of the important values within the FADT
+	 */
 	acpi_tb_convert_fadt();
+	acpi_tb_validate_fadt(&acpi_gbl_FADT);
 
-	/* Extract the DSDT and FACS tables from the FADT */
+	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
 	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
 			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
 
 	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
 			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
-
-	/* Validate important FADT values */
-
-	acpi_tb_validate_fadt();
 }
 
 /*******************************************************************************
@@ -194,6 +224,7 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
  * RETURN:      None
  *
  * DESCRIPTION: Converts all versions of the FADT to a common internal format.
+ *              -> Expand all 32-bit addresses to 64-bit.
  *
  * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt),
  *              and must contain a copy of the actual FADT.
@@ -213,13 +244,17 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
  *
  ******************************************************************************/
 
-static void acpi_tb_convert_fadt(void)
+void acpi_tb_convert_fadt(void)
 {
 	u8 pm1_register_length;
 	struct acpi_generic_address *target;
 	acpi_native_uint i;
 
-	/* Expand the FACS and DSDT addresses as necessary */
+	/* Update the local FADT table header length */
+
+	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
+
+	/* Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary */
 
 	if (!acpi_gbl_FADT.Xfacs) {
 		acpi_gbl_FADT.Xfacs = (u64) acpi_gbl_FADT.facs;
@@ -233,10 +268,10 @@ static void acpi_tb_convert_fadt(void)
 	 * Expand the 32-bit V1.0 addresses to the 64-bit "X" generic address
 	 * structures as necessary.
 	 */
-	for (i = 0; i < ACPI_FADT_CONVERSION_ENTRIES; i++) {
+	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
 		target =
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
-				 fadt_conversion_table[i].target);
+				 fadt_info_table[i].target);
 
 		/* Expand only if the X target is null */
 
@@ -244,11 +279,11 @@ static void acpi_tb_convert_fadt(void)
 			acpi_tb_init_generic_address(target,
 						     *ACPI_ADD_PTR(u8,
 								   &acpi_gbl_FADT,
-								   fadt_conversion_table
+								   fadt_info_table
 								   [i].length),
 						     (u64) * ACPI_ADD_PTR(u32,
 									  &acpi_gbl_FADT,
-									  fadt_conversion_table
+									  fadt_info_table
 									  [i].
 									  source));
 		}
@@ -265,14 +300,14 @@ static void acpi_tb_convert_fadt(void)
 	 */
 	pm1_register_length = (u8) ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
 
-	/* PM1A is required */
+	/* The PM1A register block is required */
 
 	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
 				     pm1_register_length,
 				     (acpi_gbl_FADT.xpm1a_event_block.address +
 				      pm1_register_length));
 
-	/* PM1B is optional; leave null if not present */
+	/* The PM1B register block is optional, ignore if not present */
 
 	if (acpi_gbl_FADT.xpm1b_event_block.address) {
 		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
@@ -280,102 +315,84 @@ static void acpi_tb_convert_fadt(void)
 					     (acpi_gbl_FADT.xpm1b_event_block.
 					      address + pm1_register_length));
 	}
-
-	/* Global FADT is the new common V2.0 FADT  */
-
-	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
 }
 
 /******************************************************************************
  *
  * FUNCTION:    acpi_tb_validate_fadt
  *
- * PARAMETERS:  None
+ * PARAMETERS:  Table           - Pointer to the FADT to be validated
  *
  * RETURN:      None
  *
- * DESCRIPTION: Validate various ACPI registers in the FADT. For problems,
- *              issue a message, but no status is returned.
+ * DESCRIPTION: Validate various important fields within the FADT. If a problem
+ *              is found, issue a message, but no status is returned.
+ *              Used by both the table manager and the disassembler.
+ *
+ * Possible additional checks:
+ * (acpi_gbl_FADT.pm1_event_length >= 4)
+ * (acpi_gbl_FADT.pm1_control_length >= 2)
+ * (acpi_gbl_FADT.pm_timer_length >= 4)
+ * Gpe block lengths must be multiple of 2
  *
  ******************************************************************************/
 
-static void acpi_tb_validate_fadt(void)
+void acpi_tb_validate_fadt(struct acpi_table_fadt *table)
 {
+	u32 *address32;
+	struct acpi_generic_address *address64;
+	u8 length;
+	acpi_native_uint i;
 
-	/* These length fields have a minimum value */
-
-	if (acpi_gbl_FADT.pm1_event_length < 4) {
-		acpi_tb_fadt_register_error("Pm1EventLength",
-					    (u32) acpi_gbl_FADT.
-					    pm1_event_length);
-	}
-
-	if (acpi_gbl_FADT.pm_timer_length < 4) {
-		acpi_tb_fadt_register_error("PmTimerLength",
-					    (u32) acpi_gbl_FADT.
-					    pm_timer_length);
-	}
-
-	/* These length and address fields must be non-zero */
-
-	if (!acpi_gbl_FADT.pm1_control_length) {
-		acpi_tb_fadt_register_error("Pm1ControlLength", 0);
-	}
-
-	if (!acpi_gbl_FADT.xpm1a_event_block.address) {
-		acpi_tb_fadt_register_error("XPm1aEventBlock.Address", 0);
-	}
-
-	if (!acpi_gbl_FADT.xpm1a_control_block.address) {
-		acpi_tb_fadt_register_error("XPm1aControlBlock.Address", 0);
-	}
-
-	if (!acpi_gbl_FADT.xpm_timer_block.address) {
-		acpi_tb_fadt_register_error("XPmTimerBlock.Address", 0);
-	}
-
-	/* If PM2 block is present, must have non-zero length */
-
-	if ((acpi_gbl_FADT.xpm2_control_block.address &&
-	     !acpi_gbl_FADT.pm2_control_length)) {
-		acpi_tb_fadt_register_error("Pm2ControlLength",
-					    (u32) acpi_gbl_FADT.
-					    pm2_control_length);
-	}
-
-	/* Length of any valid GPE blocks must be a multiple of 2 */
+	/* Examine all of the 64-bit extended address fields (X fields) */
+
+	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+
+		/* Generate pointers to the 32-bit and 64-bit addresses and get the length */
+
+		address64 =
+		    ACPI_ADD_PTR(struct acpi_generic_address, table,
+				 fadt_info_table[i].target);
+		address32 = ACPI_ADD_PTR(u32, table, fadt_info_table[i].source);
+		length = *ACPI_ADD_PTR(u8, table, fadt_info_table[i].length);
+
+		if (fadt_info_table[i].type & ACPI_FADT_REQUIRED) {
+			/*
+			 * Field is required (Pm1a_event, Pm1a_control, pm_timer).
+			 * Both the address and length must be non-zero.
+			 */
+			if (!address64->address || !length) {
+				ACPI_ERROR((AE_INFO,
+					    "Required field \"%s\" has zero address and/or length: %8.8X%8.8X/%X",
+					    fadt_info_table[i].name,
+					    ACPI_FORMAT_UINT64(address64->
+							       address),
+					    length));
+			}
+		} else if (fadt_info_table[i].type & ACPI_FADT_SEPARATE_LENGTH) {
+			/*
+			 * Field is optional (PM2Control, GPE0, GPE1) AND has its own
+			 * length field. If present, both the address and length must be valid.
+			 */
+			if ((address64->address && !length)
+			    || (!address64->address && length)) {
+				ACPI_WARNING((AE_INFO,
+					      "Optional field \"%s\" has zero address or length: %8.8X%8.8X/%X",
+					      fadt_info_table[i].name,
+					      ACPI_FORMAT_UINT64(address64->
+								 address),
+					      length));
+			}
+		}
 
-	if (acpi_gbl_FADT.xgpe0_block.address &&
-	    (acpi_gbl_FADT.gpe0_block_length & 1)) {
-		acpi_tb_fadt_register_error("Gpe0BlockLength",
-					    (u32) acpi_gbl_FADT.
-					    gpe0_block_length);
-	}
+		/* If both 32- and 64-bit addresses are valid (non-zero), they must match */
 
-	if (acpi_gbl_FADT.xgpe1_block.address &&
-	    (acpi_gbl_FADT.gpe1_block_length & 1)) {
-		acpi_tb_fadt_register_error("Gpe1BlockLength",
-					    (u32) acpi_gbl_FADT.
-					    gpe1_block_length);
+		if (address64->address && *address32 &&
+		    (address64->address != (u64) * address32)) {
+			ACPI_ERROR((AE_INFO,
+				    "32/64X address mismatch in \"%s\": [%8.8X] [%8.8X%8.8X], using 64X",
+				    fadt_info_table[i].name, *address32,
+				    ACPI_FORMAT_UINT64(address64->address)));
+		}
 	}
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_fadt_register_error
- *
- * PARAMETERS:  register_name           - Pointer to string identifying register
- *              Value                   - Actual register contents value
- *
- * RETURN:      None
- *
- * DESCRIPTION: Display FADT warning message
- *
- ******************************************************************************/
-
-static void acpi_tb_fadt_register_error(char *register_name, u32 value)
-{
-
-	ACPI_WARNING((AE_INFO, "Invalid FADT value in field \"%s\" = %X",
-		      register_name, value));
-}
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 54e53e6..1033748 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -280,7 +280,7 @@ acpi_tb_get_root_table_entry(u8 * table_entry,
 #if ACPI_MACHINE_WIDTH == 32
 		if (address64 > ACPI_UINT32_MAX) {
 
-			/* Will truncate 64-bit address to 32 bits */
+			/* Will truncate 64-bit address to 32 bits, issue warning */
 
 			ACPI_WARNING((AE_INFO,
 				      "64-bit Physical Address in XSDT is too large (%8.8X%8.8X), truncating",
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 99fa51a..65a69ca 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -51,6 +51,10 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count);
  */
 void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
 
+void acpi_tb_convert_fadt(void);
+
+void acpi_tb_validate_fadt(struct acpi_table_fadt *table);
+
 /*
  * tbfind - find ACPI table
  */
-- 
1.5.0.rc3.39.gec804
