From: Len Brown <lenb@kernel.org>
Subject: [PATCH 82/94] ACPICA: FADT parsing changes and fixes
Date: Fri, 09 Jan 2009 04:27:24 -0500
Message-ID: <06f5541960d02d5e0ddd8fd5c9a1554d85d94fa9.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:63000 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbZAIJ2m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:42 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD7005MC6BKCYA4@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:33 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

1) Update the register lengths for the PM1 event blocks. The
length must be divided by two in order to use these to access
the status registers.
2) Add run-time option to use default register lengths to override a
faulty FADT.
3) Add warning message if any of the X64 address structures contain a length
that does not match the legacy length earlier in the FADT.
4) Move all FADT warning messages into the ValidateFadt function.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |  125 +++++++++++++++++++++++++++++++++++-------
 include/acpi/acglobal.h      |    6 ++
 include/acpi/actypes.h       |    8 ++-
 3 files changed, 118 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 57e089f..b4ce207 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -51,7 +51,7 @@ ACPI_MODULE_NAME("tbfadt")
 /* Local prototypes */
 static inline void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
-			     u8 byte_width, u64 address);
+			     u8 space_id, u8 byte_width, u64 address);
 
 static void acpi_tb_convert_fadt(void);
 
@@ -125,7 +125,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
 
 static inline void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
-			     u8 byte_width, u64 address)
+			     u8 space_id, u8 byte_width, u64 address)
 {
 
 	/*
@@ -136,10 +136,10 @@ acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 
 	/* All other fields are byte-wide */
 
-	generic_address->space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	generic_address->bit_width = byte_width << 3;
+	generic_address->space_id = space_id;
+	generic_address->bit_width = (u8)ACPI_MUL_8(byte_width);
 	generic_address->bit_offset = 0;
-	generic_address->access_width = 0;
+	generic_address->access_width = 0;	/* Access width ANY */
 }
 
 /*******************************************************************************
@@ -226,7 +226,8 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
-			      "FADT (revision %u) is longer than ACPI 2.0 version, truncating length 0x%X to 0x%zX",
+			      "FADT (revision %u) is longer than ACPI 2.0 version, "
+			      "truncating length 0x%X to 0x%zX",
 			      table->revision, (unsigned)length,
 			      sizeof(struct acpi_table_fadt)));
 	}
@@ -245,7 +246,6 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	 * 2) Validate some of the important values within the FADT
 	 */
 	acpi_tb_convert_fadt();
-	acpi_tb_validate_fadt();
 }
 
 /*******************************************************************************
@@ -337,7 +337,11 @@ static void acpi_tb_convert_fadt(void)
 		/* Expand only if the X target is null */
 
 		if (!target->address) {
+
+			/* The space_id is always I/O for the legacy address fields */
+
 			acpi_tb_init_generic_address(target,
+						     ACPI_ADR_SPACE_SYSTEM_IO,
 						     *ACPI_ADD_PTR(u8,
 								   &acpi_gbl_FADT,
 								   fadt_info_table
@@ -350,6 +354,25 @@ static void acpi_tb_convert_fadt(void)
 		}
 	}
 
+	/* Validate FADT values now, before we make any changes */
+
+	acpi_tb_validate_fadt();
+
+	/*
+	 * Get the length of the individual PM1 registers. Each register is
+	 * defined to be the event block length / 2.
+	 */
+	pm1_register_length = (u8)ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
+
+	/*
+	 * Adjust the lengths of the PM1 Event Blocks so that they can be used to
+	 * access the PM1 status register(s).
+	 */
+	acpi_gbl_FADT.xpm1a_event_block.bit_width =
+	    (u8)ACPI_MUL_8(pm1_register_length);
+	acpi_gbl_FADT.xpm1b_event_block.bit_width =
+	    (u8)ACPI_MUL_8(pm1_register_length);
+
 	/*
 	 * Calculate separate GAS structs for the PM1 Enable registers.
 	 * These addresses do not appear (directly) in the FADT, so it is
@@ -370,11 +393,11 @@ static void acpi_tb_convert_fadt(void)
 		       " PM1_EVT_LEN (%u)\n",
 		       acpi_gbl_FADT.xpm1a_event_block.bit_width,
 		       acpi_gbl_FADT.pm1_event_length);
-	pm1_register_length = (u8) ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
 
 	/* The PM1A register block is required */
 
 	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
+				     acpi_gbl_FADT.xpm1a_event_block.space_id,
 				     pm1_register_length,
 				     (acpi_gbl_FADT.xpm1a_event_block.address +
 				      pm1_register_length));
@@ -393,6 +416,7 @@ static void acpi_tb_convert_fadt(void)
 			       acpi_gbl_FADT.xpm1b_event_block.bit_width,
 			       acpi_gbl_FADT.pm1_event_length);
 		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
+					     acpi_gbl_FADT.xpm1b_event_block.space_id,
 					     pm1_register_length,
 					     (acpi_gbl_FADT.xpm1b_event_block.
 					      address + pm1_register_length));
@@ -401,6 +425,30 @@ static void acpi_tb_convert_fadt(void)
 		    acpi_gbl_FADT.xpm1b_event_block.space_id;
 
 	}
+
+	if (acpi_gbl_use_default_register_widths) {
+		/*
+		 * Optionally, use the default sizes for the ACPI registers.
+		 * Some FADTs do not have the correct length(s).
+		 *
+		 * Note: Xpm1a_event_block and Xpm1b_event_block are used to access the PM1
+		 * status registers. The PM1 enable registers are created above.
+		 */
+		acpi_gbl_xpm1a_enable.bit_width = ACPI_PM1_REGISTER_WIDTH;
+		acpi_gbl_xpm1b_enable.bit_width = ACPI_PM1_REGISTER_WIDTH;
+
+		acpi_gbl_FADT.xpm1a_event_block.bit_width =
+		    ACPI_PM1_REGISTER_WIDTH;
+		acpi_gbl_FADT.xpm1b_event_block.bit_width =
+		    ACPI_PM1_REGISTER_WIDTH;
+		acpi_gbl_FADT.xpm1a_control_block.bit_width =
+		    ACPI_PM1_REGISTER_WIDTH;
+		acpi_gbl_FADT.xpm1b_control_block.bit_width =
+		    ACPI_PM1_REGISTER_WIDTH;
+		acpi_gbl_FADT.xpm2_control_block.bit_width =
+		    ACPI_PM2_REGISTER_WIDTH;
+		acpi_gbl_FADT.xpm_timer_block.bit_width = ACPI_PM_TIMER_WIDTH;
+	}
 }
 
 /******************************************************************************
@@ -425,26 +473,63 @@ static void acpi_tb_convert_fadt(void)
 
 static void acpi_tb_validate_fadt(void)
 {
+	char *name;
 	u32 *address32;
 	struct acpi_generic_address *address64;
 	u8 length;
 	u32 i;
 
-	/* Examine all of the 64-bit extended address fields (X fields) */
+	/*
+	 * Check for FACS and DSDT address mismatches. An address mismatch between
+	 * the 32-bit and 64-bit address fields (FIRMWARE_CTRL/X_FIRMWARE_CTRL and
+	 * DSDT/X_DSDT) would indicate the presence of two FACS or two DSDT tables.
+	 */
+	if (acpi_gbl_FADT.facs &&
+	    (acpi_gbl_FADT.Xfacs != (u64) acpi_gbl_FADT.facs)) {
+		ACPI_WARNING((AE_INFO,
+			      "32/64 FACS address mismatch in FADT - "
+			      "two FACS tables! %8.8X/%8.8X%8.8X",
+			      acpi_gbl_FADT.facs,
+			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xfacs)));
+	}
 
-	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+	if (acpi_gbl_FADT.dsdt &&
+	    (acpi_gbl_FADT.Xdsdt != (u64) acpi_gbl_FADT.dsdt)) {
+		ACPI_WARNING((AE_INFO,
+			      "32/64 DSDT address mismatch in FADT - "
+			      "two DSDT tables! %8.8X/%8.8X%8.8X",
+			      acpi_gbl_FADT.dsdt,
+			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xdsdt)));
+	}
 
-		/* Generate pointers to the 32-bit and 64-bit addresses and get the length */
+	/* Examine all of the 64-bit extended address fields (X fields) */
 
-		address64 =
-		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
-				 fadt_info_table[i].target);
+	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+		/*
+		 * Generate pointers to the 32-bit and 64-bit addresses, get the
+		 * register length (width), and the register name
+		 */
+		address64 = ACPI_ADD_PTR(struct acpi_generic_address,
+					 &acpi_gbl_FADT,
+					 fadt_info_table[i].target);
 		address32 =
 		    ACPI_ADD_PTR(u32, &acpi_gbl_FADT,
 				 fadt_info_table[i].source);
 		length =
 		    *ACPI_ADD_PTR(u8, &acpi_gbl_FADT,
 				  fadt_info_table[i].length);
+		name = fadt_info_table[i].name;
+
+		/*
+		 * For each extended field, check for length mismatch between the
+		 * legacy length field and the corresonding 64-bit X length field.
+		 */
+		if (address64 && (address64->bit_width != ACPI_MUL_8(length))) {
+			ACPI_WARNING((AE_INFO,
+				      "32/64X bit length mismatch in %s: %d/%d",
+				      name, ACPI_MUL_8(length),
+				      address64->bit_width));
+		}
 
 		if (fadt_info_table[i].type & ACPI_FADT_REQUIRED) {
 			/*
@@ -453,8 +538,8 @@ static void acpi_tb_validate_fadt(void)
 			 */
 			if (!address64->address || !length) {
 				ACPI_ERROR((AE_INFO,
-					    "Required field \"%s\" has zero address and/or length: %8.8X%8.8X/%X",
-					    fadt_info_table[i].name,
+					    "Required field %s has zero address and/or length: %8.8X%8.8X/%X",
+					    name,
 					    ACPI_FORMAT_UINT64(address64->
 							       address),
 					    length));
@@ -467,8 +552,8 @@ static void acpi_tb_validate_fadt(void)
 			if ((address64->address && !length)
 			    || (!address64->address && length)) {
 				ACPI_WARNING((AE_INFO,
-					      "Optional field \"%s\" has zero address or length: %8.8X%8.8X/%X",
-					      fadt_info_table[i].name,
+					      "Optional field %s has zero address or length: %8.8X%8.8X/%X",
+					      name,
 					      ACPI_FORMAT_UINT64(address64->
 								 address),
 					      length));
@@ -480,8 +565,8 @@ static void acpi_tb_validate_fadt(void)
 		if (address64->address && *address32 &&
 		    (address64->address != (u64) * address32)) {
 			ACPI_ERROR((AE_INFO,
-				    "32/64X address mismatch in \"%s\": [%8.8X] [%8.8X%8.8X], using 64X",
-				    fadt_info_table[i].name, *address32,
+				    "32/64X address mismatch in %s: [%8.8X] [%8.8X%8.8X], using 64X",
+				    name, *address32,
 				    ACPI_FORMAT_UINT64(address64->address)));
 		}
 	}
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 78f3c14..55eb5d6 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -102,6 +102,12 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_create_osi_method, TRUE);
  */
 ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_leave_wake_gpes_disabled, TRUE);
 
+/*
+ * Optionally use default values for the ACPI register widths. Set this to
+ * TRUE to use the defaults, if an FADT contains incorrect widths/lengths.
+ */
+ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, FALSE);
+
 /*****************************************************************************
  *
  * Debug support
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 24b2cef..03744d2 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -309,10 +309,16 @@ typedef u32 acpi_physical_address;
  *
  *****************************************************************************/
 
-/* Number of distinct GPE register blocks and register width */
+/* Number of distinct FADT-based GPE register blocks (GPE0 and GPE1) */
 
 #define ACPI_MAX_GPE_BLOCKS             2
+
+/* Default ACPI register widths */
+
 #define ACPI_GPE_REGISTER_WIDTH         8
+#define ACPI_PM1_REGISTER_WIDTH         16
+#define ACPI_PM2_REGISTER_WIDTH         8
+#define ACPI_PM_TIMER_WIDTH             32
 
 /* Names within the namespace are 4 bytes long */
 
-- 
1.5.6.6

