From: Len Brown <lenb@kernel.org>
Subject: [PATCH 83/94] ACPICA: FADT: set acpi_gbl_use_default_register_widths
 to TRUE by default
Date: Fri, 09 Jan 2009 04:27:25 -0500
Message-ID: <4b67a0e467a57e24da6b761dbf95fa5d0225ff19.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbZAIJ2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:45 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700G68698XTH5@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:13 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "robert.moore@intel.com" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: robert.moore@intel.com <robert.moore@intel.com>

This returns the FADT support to the original behavior, which is
to use default register widths. However, now check each register
definition and report a warning if it differs from the default.
This is a first step to moving away from the default widths,
rather than outright believing the widths in all FADTs for all
machines, considered rather dangerous until more data is obtained.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |  173 +++++++++++++++++++++++++----------------
 include/acpi/acglobal.h      |    2 +-
 2 files changed, 106 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index b4ce207..7dec0af 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -61,9 +61,10 @@ static void acpi_tb_validate_fadt(void);
 
 typedef struct acpi_fadt_info {
 	char *name;
-	u8 target;
-	u8 source;
+	u8 address64;
+	u8 address32;
 	u8 length;
+	u8 default_length;
 	u8 type;
 
 } acpi_fadt_info;
@@ -72,37 +73,61 @@ typedef struct acpi_fadt_info {
 #define ACPI_FADT_SEPARATE_LENGTH   2
 
 static struct acpi_fadt_info fadt_info_table[] = {
-	{"Pm1aEventBlock", ACPI_FADT_OFFSET(xpm1a_event_block),
+	{"Pm1aEventBlock",
+	 ACPI_FADT_OFFSET(xpm1a_event_block),
 	 ACPI_FADT_OFFSET(pm1a_event_block),
-	 ACPI_FADT_OFFSET(pm1_event_length), ACPI_FADT_REQUIRED},
+	 ACPI_FADT_OFFSET(pm1_event_length),
+	 ACPI_PM1_REGISTER_WIDTH * 2,	/* Enable + Status register */
+	 ACPI_FADT_REQUIRED},
 
-	{"Pm1bEventBlock", ACPI_FADT_OFFSET(xpm1b_event_block),
+	{"Pm1bEventBlock",
+	 ACPI_FADT_OFFSET(xpm1b_event_block),
 	 ACPI_FADT_OFFSET(pm1b_event_block),
-	 ACPI_FADT_OFFSET(pm1_event_length), 0},
+	 ACPI_FADT_OFFSET(pm1_event_length),
+	 ACPI_PM1_REGISTER_WIDTH * 2,	/* Enable + Status register */
+	 0},
 
-	{"Pm1aControlBlock", ACPI_FADT_OFFSET(xpm1a_control_block),
+	{"Pm1aControlBlock",
+	 ACPI_FADT_OFFSET(xpm1a_control_block),
 	 ACPI_FADT_OFFSET(pm1a_control_block),
-	 ACPI_FADT_OFFSET(pm1_control_length), ACPI_FADT_REQUIRED},
+	 ACPI_FADT_OFFSET(pm1_control_length),
+	 ACPI_PM1_REGISTER_WIDTH,
+	 ACPI_FADT_REQUIRED},
 
-	{"Pm1bControlBlock", ACPI_FADT_OFFSET(xpm1b_control_block),
+	{"Pm1bControlBlock",
+	 ACPI_FADT_OFFSET(xpm1b_control_block),
 	 ACPI_FADT_OFFSET(pm1b_control_block),
-	 ACPI_FADT_OFFSET(pm1_control_length), 0},
+	 ACPI_FADT_OFFSET(pm1_control_length),
+	 ACPI_PM1_REGISTER_WIDTH,
+	 0},
 
-	{"Pm2ControlBlock", ACPI_FADT_OFFSET(xpm2_control_block),
+	{"Pm2ControlBlock",
+	 ACPI_FADT_OFFSET(xpm2_control_block),
 	 ACPI_FADT_OFFSET(pm2_control_block),
-	 ACPI_FADT_OFFSET(pm2_control_length), ACPI_FADT_SEPARATE_LENGTH},
+	 ACPI_FADT_OFFSET(pm2_control_length),
+	 ACPI_PM2_REGISTER_WIDTH,
+	 ACPI_FADT_SEPARATE_LENGTH},
 
-	{"PmTimerBlock", ACPI_FADT_OFFSET(xpm_timer_block),
+	{"PmTimerBlock",
+	 ACPI_FADT_OFFSET(xpm_timer_block),
 	 ACPI_FADT_OFFSET(pm_timer_block),
-	 ACPI_FADT_OFFSET(pm_timer_length), ACPI_FADT_REQUIRED},
+	 ACPI_FADT_OFFSET(pm_timer_length),
+	 ACPI_PM_TIMER_WIDTH,
+	 ACPI_FADT_REQUIRED},
 
-	{"Gpe0Block", ACPI_FADT_OFFSET(xgpe0_block),
+	{"Gpe0Block",
+	 ACPI_FADT_OFFSET(xgpe0_block),
 	 ACPI_FADT_OFFSET(gpe0_block),
-	 ACPI_FADT_OFFSET(gpe0_block_length), ACPI_FADT_SEPARATE_LENGTH},
+	 ACPI_FADT_OFFSET(gpe0_block_length),
+	 0,
+	 ACPI_FADT_SEPARATE_LENGTH},
 
-	{"Gpe1Block", ACPI_FADT_OFFSET(xgpe1_block),
+	{"Gpe1Block",
+	 ACPI_FADT_OFFSET(xgpe1_block),
 	 ACPI_FADT_OFFSET(gpe1_block),
-	 ACPI_FADT_OFFSET(gpe1_block_length), ACPI_FADT_SEPARATE_LENGTH}
+	 ACPI_FADT_OFFSET(gpe1_block_length),
+	 0,
+	 ACPI_FADT_SEPARATE_LENGTH}
 };
 
 #define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
@@ -279,8 +304,9 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 
 static void acpi_tb_convert_fadt(void)
 {
-	u8 pm1_register_length;
-	struct acpi_generic_address *target;
+	u8 pm1_register_bit_width;
+	u8 pm1_register_byte_width;
+	struct acpi_generic_address *target64;
 	u32 i;
 
 	/* Update the local FADT table header length */
@@ -326,21 +352,22 @@ static void acpi_tb_convert_fadt(void)
 	}
 
 	/*
-	 * Expand the ACPI 1.0 32-bit V1.0 addresses to the ACPI 2.0 64-bit "X"
-	 * generic address structures as necessary.
+	 * Expand the ACPI 1.0 32-bit addresses to the ACPI 2.0 64-bit "X"
+	 * generic address structures as necessary. Later code will always use
+	 * the 64-bit address structures.
 	 */
 	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
-		target =
+		target64 =
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
-				 fadt_info_table[i].target);
+				 fadt_info_table[i].address64);
 
-		/* Expand only if the X target is null */
+		/* Expand only if the 64-bit X target is null */
 
-		if (!target->address) {
+		if (!target64->address) {
 
-			/* The space_id is always I/O for the legacy address fields */
+			/* The space_id is always I/O for the 32-bit legacy address fields */
 
-			acpi_tb_init_generic_address(target,
+			acpi_tb_init_generic_address(target64,
 						     ACPI_ADR_SPACE_SYSTEM_IO,
 						     *ACPI_ADD_PTR(u8,
 								   &acpi_gbl_FADT,
@@ -350,7 +377,7 @@ static void acpi_tb_convert_fadt(void)
 									  &acpi_gbl_FADT,
 									  fadt_info_table
 									  [i].
-									  source));
+									  address32));
 		}
 	}
 
@@ -359,19 +386,53 @@ static void acpi_tb_convert_fadt(void)
 	acpi_tb_validate_fadt();
 
 	/*
-	 * Get the length of the individual PM1 registers. Each register is
-	 * defined to be the event block length / 2.
+	 * Optionally check all register lengths against the default values and
+	 * update them if they are incorrect.
 	 */
-	pm1_register_length = (u8)ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
+	if (acpi_gbl_use_default_register_widths) {
+		for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+			target64 =
+			    ACPI_ADD_PTR(struct acpi_generic_address,
+					 &acpi_gbl_FADT,
+					 fadt_info_table[i].address64);
+
+			/*
+			 * If a valid register (Address != 0) and the (default_length > 0)
+			 * (Not a GPE register), then check the width against the default.
+			 */
+			if ((target64->address) &&
+			    (fadt_info_table[i].default_length > 0) &&
+			    (fadt_info_table[i].default_length !=
+			     target64->bit_width)) {
+				ACPI_WARNING((AE_INFO,
+					      "Invalid length for %s: %d, using default %d",
+					      fadt_info_table[i].name,
+					      target64->bit_width,
+					      fadt_info_table[i].
+					      default_length));
+
+				/* Incorrect size, set width to the default */
+
+				target64->bit_width =
+				    fadt_info_table[i].default_length;
+			}
+		}
+	}
+
+	/*
+	 * Get the length of the individual PM1 registers (enable and status).
+	 * Each register is defined to be (event block length / 2).
+	 */
+	pm1_register_bit_width =
+	    (u8)ACPI_DIV_2(acpi_gbl_FADT.xpm1a_event_block.bit_width);
+	pm1_register_byte_width = (u8)ACPI_DIV_8(pm1_register_bit_width);
 
 	/*
 	 * Adjust the lengths of the PM1 Event Blocks so that they can be used to
-	 * access the PM1 status register(s).
+	 * access the PM1 status register(s). Use (width / 2)
 	 */
-	acpi_gbl_FADT.xpm1a_event_block.bit_width =
-	    (u8)ACPI_MUL_8(pm1_register_length);
-	acpi_gbl_FADT.xpm1b_event_block.bit_width =
-	    (u8)ACPI_MUL_8(pm1_register_length);
+	acpi_gbl_FADT.xpm1a_event_block.bit_width = pm1_register_bit_width;
+	acpi_gbl_FADT.xpm1b_event_block.bit_width = pm1_register_bit_width;
 
 	/*
 	 * Calculate separate GAS structs for the PM1 Enable registers.
@@ -398,9 +459,9 @@ static void acpi_tb_convert_fadt(void)
 
 	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
 				     acpi_gbl_FADT.xpm1a_event_block.space_id,
-				     pm1_register_length,
+				     pm1_register_byte_width,
 				     (acpi_gbl_FADT.xpm1a_event_block.address +
-				      pm1_register_length));
+				      pm1_register_byte_width));
 	/* Don't forget to copy space_id of the GAS */
 	acpi_gbl_xpm1a_enable.space_id =
 	    acpi_gbl_FADT.xpm1a_event_block.space_id;
@@ -417,38 +478,14 @@ static void acpi_tb_convert_fadt(void)
 			       acpi_gbl_FADT.pm1_event_length);
 		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
 					     acpi_gbl_FADT.xpm1b_event_block.space_id,
-					     pm1_register_length,
+					     pm1_register_byte_width,
 					     (acpi_gbl_FADT.xpm1b_event_block.
-					      address + pm1_register_length));
+					      address + pm1_register_byte_width));
 		/* Don't forget to copy space_id of the GAS */
 		acpi_gbl_xpm1b_enable.space_id =
 		    acpi_gbl_FADT.xpm1b_event_block.space_id;
 
 	}
-
-	if (acpi_gbl_use_default_register_widths) {
-		/*
-		 * Optionally, use the default sizes for the ACPI registers.
-		 * Some FADTs do not have the correct length(s).
-		 *
-		 * Note: Xpm1a_event_block and Xpm1b_event_block are used to access the PM1
-		 * status registers. The PM1 enable registers are created above.
-		 */
-		acpi_gbl_xpm1a_enable.bit_width = ACPI_PM1_REGISTER_WIDTH;
-		acpi_gbl_xpm1b_enable.bit_width = ACPI_PM1_REGISTER_WIDTH;
-
-		acpi_gbl_FADT.xpm1a_event_block.bit_width =
-		    ACPI_PM1_REGISTER_WIDTH;
-		acpi_gbl_FADT.xpm1b_event_block.bit_width =
-		    ACPI_PM1_REGISTER_WIDTH;
-		acpi_gbl_FADT.xpm1a_control_block.bit_width =
-		    ACPI_PM1_REGISTER_WIDTH;
-		acpi_gbl_FADT.xpm1b_control_block.bit_width =
-		    ACPI_PM1_REGISTER_WIDTH;
-		acpi_gbl_FADT.xpm2_control_block.bit_width =
-		    ACPI_PM2_REGISTER_WIDTH;
-		acpi_gbl_FADT.xpm_timer_block.bit_width = ACPI_PM_TIMER_WIDTH;
-	}
 }
 
 /******************************************************************************
@@ -511,10 +548,10 @@ static void acpi_tb_validate_fadt(void)
 		 */
 		address64 = ACPI_ADD_PTR(struct acpi_generic_address,
 					 &acpi_gbl_FADT,
-					 fadt_info_table[i].target);
+					 fadt_info_table[i].address64);
 		address32 =
 		    ACPI_ADD_PTR(u32, &acpi_gbl_FADT,
-				 fadt_info_table[i].source);
+				 fadt_info_table[i].address32);
 		length =
 		    *ACPI_ADD_PTR(u8, &acpi_gbl_FADT,
 				  fadt_info_table[i].length);
@@ -522,7 +559,7 @@ static void acpi_tb_validate_fadt(void)
 
 		/*
 		 * For each extended field, check for length mismatch between the
-		 * legacy length field and the corresonding 64-bit X length field.
+		 * legacy length field and the corresponding 64-bit X length field.
 		 */
 		if (address64 && (address64->bit_width != ACPI_MUL_8(length))) {
 			ACPI_WARNING((AE_INFO,
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 55eb5d6..ddb40f5 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -106,7 +106,7 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_leave_wake_gpes_disabled, TRUE);
  * Optionally use default values for the ACPI register widths. Set this to
  * TRUE to use the defaults, if an FADT contains incorrect widths/lengths.
  */
-ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, FALSE);
+ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
 
 /*****************************************************************************
  *
-- 
1.5.6.6

