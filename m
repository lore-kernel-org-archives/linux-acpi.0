From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/98] ACPICA: Split out PM1 status registers from the FADT
Date: Sat, 28 Mar 2009 00:30:55 -0400
Message-ID: <531c633d2be8e79087335a46d3c017ca5837e588.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27041 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZC1Ecg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:36 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700APF8M9MKO8@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:34 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add new globals for the PM1 status registers (A/B), similar to the
way the PM1 enable registers are handled. Instead of overloading
the FADT Event Register blocks. This makes the code clearer and
less prone to error.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    5 +-
 drivers/acpi/acpica/hwregs.c   |   18 ++--
 drivers/acpi/acpica/tbfadt.c   |  246 ++++++++++++++++++++++------------------
 3 files changed, 147 insertions(+), 122 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 634fb07..f3e87ba 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -148,9 +148,12 @@ ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
 ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
 
-/* These addresses are calculated from FADT address values */
+/* These addresses are calculated from the FADT Event Block addresses */
 
+ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_status;
 ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_enable;
+
+ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_status;
 ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
 
 /*
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 4dc43b0..7ef0b8e 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -72,21 +72,23 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_IO, "About to write %04X to %04X\n",
 			  ACPI_BITMASK_ALL_FIXED_STATUS,
-			  (u16) acpi_gbl_FADT.xpm1a_event_block.address));
+			  (u16) acpi_gbl_xpm1a_status.address));
 
 	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
 
+	/* Clear the fixed events */
+
 	status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
 					ACPI_BITMASK_ALL_FIXED_STATUS);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
 	}
 
-	/* Clear the fixed events */
+	/* Write PM1B register if present */
 
-	if (acpi_gbl_FADT.xpm1b_event_block.address) {
+	if (acpi_gbl_xpm1b_status.address) {
 		status = acpi_write(ACPI_BITMASK_ALL_FIXED_STATUS,
-				    &acpi_gbl_FADT.xpm1b_event_block);
+				    &acpi_gbl_xpm1b_status);
 		if (ACPI_FAILURE(status)) {
 			goto unlock_and_exit;
 		}
@@ -150,14 +152,14 @@ acpi_hw_register_read(u32 register_id, u32 * return_value)
 	switch (register_id) {
 	case ACPI_REGISTER_PM1_STATUS:	/* 16-bit access */
 
-		status = acpi_read(&value1, &acpi_gbl_FADT.xpm1a_event_block);
+		status = acpi_read(&value1, &acpi_gbl_xpm1a_status);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
 		/* PM1B is optional */
 
-		status = acpi_read(&value2, &acpi_gbl_FADT.xpm1b_event_block);
+		status = acpi_read(&value2, &acpi_gbl_xpm1b_status);
 		value1 |= value2;
 		break;
 
@@ -267,14 +269,14 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 		/* Now we can write the data */
 
-		status = acpi_write(value, &acpi_gbl_FADT.xpm1a_event_block);
+		status = acpi_write(value, &acpi_gbl_xpm1a_status);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
 		/* PM1B is optional */
 
-		status = acpi_write(value, &acpi_gbl_FADT.xpm1b_event_block);
+		status = acpi_write(value, &acpi_gbl_xpm1b_status);
 		break;
 
 	case ACPI_REGISTER_PM1_ENABLE:	/* 16-bit access */
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 4b683cc..a8191ef 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -57,6 +57,8 @@ static void acpi_tb_convert_fadt(void);
 
 static void acpi_tb_validate_fadt(void);
 
+static void acpi_tb_setup_fadt_registers(void);
+
 /* Table for conversion of FADT to common internal format and FADT validation */
 
 typedef struct acpi_fadt_info {
@@ -132,6 +134,35 @@ static struct acpi_fadt_info fadt_info_table[] = {
 
 #define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
 
+/* Table used to split Event Blocks into separate status/enable registers */
+
+typedef struct acpi_fadt_pm_info {
+	struct acpi_generic_address *target;
+	u8 source;
+	u8 register_num;
+
+} acpi_fadt_pm_info;
+
+static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
+	{&acpi_gbl_xpm1a_status,
+	 ACPI_FADT_OFFSET(xpm1a_event_block),
+	 0},
+
+	{&acpi_gbl_xpm1a_enable,
+	 ACPI_FADT_OFFSET(xpm1a_event_block),
+	 1},
+
+	{&acpi_gbl_xpm1b_status,
+	 ACPI_FADT_OFFSET(xpm1b_event_block),
+	 0},
+
+	{&acpi_gbl_xpm1b_enable,
+	 ACPI_FADT_OFFSET(xpm1b_event_block),
+	 1}
+};
+
+#define ACPI_FADT_PM_INFO_ENTRIES   (sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_init_generic_address
@@ -207,7 +238,7 @@ void acpi_tb_parse_fadt(u32 table_index)
 	 */
 	(void)acpi_tb_verify_checksum(table, length);
 
-	/* Obtain a local copy of the FADT in common ACPI 2.0+ format */
+	/* Create a local copy of the FADT in common ACPI 2.0+ format */
 
 	acpi_tb_create_local_fadt(table, length);
 
@@ -265,11 +296,17 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	ACPI_MEMCPY(&acpi_gbl_FADT, table,
 		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
 
-	/*
-	 * 1) Convert the local copy of the FADT to the common internal format
-	 * 2) Validate some of the important values within the FADT
-	 */
+	/* Convert the local copy of the FADT to the common internal format */
+
 	acpi_tb_convert_fadt();
+
+	/* Validate FADT values now, before we make any changes */
+
+	acpi_tb_validate_fadt();
+
+	/* Initialize the global ACPI register structures */
+
+	acpi_tb_setup_fadt_registers();
 }
 
 /*******************************************************************************
@@ -303,8 +340,6 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 
 static void acpi_tb_convert_fadt(void)
 {
-	u8 pm1_register_bit_width;
-	u8 pm1_register_byte_width;
 	struct acpi_generic_address *target64;
 	u32 i;
 
@@ -379,112 +414,6 @@ static void acpi_tb_convert_fadt(void)
 									  address32));
 		}
 	}
-
-	/* Validate FADT values now, before we make any changes */
-
-	acpi_tb_validate_fadt();
-
-	/*
-	 * Optionally check all register lengths against the default values and
-	 * update them if they are incorrect.
-	 */
-	if (acpi_gbl_use_default_register_widths) {
-		for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
-			target64 =
-			    ACPI_ADD_PTR(struct acpi_generic_address,
-					 &acpi_gbl_FADT,
-					 fadt_info_table[i].address64);
-
-			/*
-			 * If a valid register (Address != 0) and the (default_length > 0)
-			 * (Not a GPE register), then check the width against the default.
-			 */
-			if ((target64->address) &&
-			    (fadt_info_table[i].default_length > 0) &&
-			    (fadt_info_table[i].default_length !=
-			     target64->bit_width)) {
-				ACPI_WARNING((AE_INFO,
-					      "Invalid length for %s: %d, using default %d",
-					      fadt_info_table[i].name,
-					      target64->bit_width,
-					      fadt_info_table[i].
-					      default_length));
-
-				/* Incorrect size, set width to the default */
-
-				target64->bit_width =
-				    fadt_info_table[i].default_length;
-			}
-		}
-	}
-
-	/*
-	 * Get the length of the individual PM1 registers (enable and status).
-	 * Each register is defined to be (event block length / 2).
-	 */
-	pm1_register_bit_width =
-	    (u8)ACPI_DIV_2(acpi_gbl_FADT.xpm1a_event_block.bit_width);
-	pm1_register_byte_width = (u8)ACPI_DIV_8(pm1_register_bit_width);
-
-	/*
-	 * Adjust the lengths of the PM1 Event Blocks so that they can be used to
-	 * access the PM1 status register(s). Use (width / 2)
-	 */
-	acpi_gbl_FADT.xpm1a_event_block.bit_width = pm1_register_bit_width;
-	acpi_gbl_FADT.xpm1b_event_block.bit_width = pm1_register_bit_width;
-
-	/*
-	 * Calculate separate GAS structs for the PM1 Enable registers.
-	 * These addresses do not appear (directly) in the FADT, so it is
-	 * useful to calculate them once, here.
-	 *
-	 * The PM event blocks are split into two register blocks, first is the
-	 * PM Status Register block, followed immediately by the PM Enable
-	 * Register block. Each is of length (xpm1x_event_block.bit_width/2).
-	 *
-	 * On various systems the v2 fields (and particularly the bit widths)
-	 * cannot be relied upon, though. Hence resort to using the v1 length
-	 * here (and warn about the inconsistency).
-	 */
-	if (acpi_gbl_FADT.xpm1a_event_block.bit_width
-	    != acpi_gbl_FADT.pm1_event_length * 8)
-		printk(KERN_WARNING "FADT: "
-		       "X_PM1a_EVT_BLK.bit_width (%u) does not match"
-		       " PM1_EVT_LEN (%u)\n",
-		       acpi_gbl_FADT.xpm1a_event_block.bit_width,
-		       acpi_gbl_FADT.pm1_event_length);
-
-	/* The PM1A register block is required */
-
-	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
-				     acpi_gbl_FADT.xpm1a_event_block.space_id,
-				     pm1_register_byte_width,
-				     (acpi_gbl_FADT.xpm1a_event_block.address +
-				      pm1_register_byte_width));
-	/* Don't forget to copy space_id of the GAS */
-	acpi_gbl_xpm1a_enable.space_id =
-	    acpi_gbl_FADT.xpm1a_event_block.space_id;
-
-	/* The PM1B register block is optional, ignore if not present */
-
-	if (acpi_gbl_FADT.xpm1b_event_block.address) {
-		if (acpi_gbl_FADT.xpm1b_event_block.bit_width
-		    != acpi_gbl_FADT.pm1_event_length * 8)
-			printk(KERN_WARNING "FADT: "
-			       "X_PM1b_EVT_BLK.bit_width (%u) does not match"
-			       " PM1_EVT_LEN (%u)\n",
-			       acpi_gbl_FADT.xpm1b_event_block.bit_width,
-			       acpi_gbl_FADT.pm1_event_length);
-		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
-					     acpi_gbl_FADT.xpm1b_event_block.space_id,
-					     pm1_register_byte_width,
-					     (acpi_gbl_FADT.xpm1b_event_block.
-					      address + pm1_register_byte_width));
-		/* Don't forget to copy space_id of the GAS */
-		acpi_gbl_xpm1b_enable.space_id =
-		    acpi_gbl_FADT.xpm1b_event_block.space_id;
-
-	}
 }
 
 /******************************************************************************
@@ -607,3 +536,94 @@ static void acpi_tb_validate_fadt(void)
 		}
 	}
 }
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_setup_fadt_registers
+ *
+ * PARAMETERS:  None, uses acpi_gbl_FADT.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Initialize global ACPI PM1 register definitions. Optionally,
+ *              force FADT register definitions to their default lengths.
+ *
+ ******************************************************************************/
+
+static void acpi_tb_setup_fadt_registers(void)
+{
+	struct acpi_generic_address *target64;
+	struct acpi_generic_address *source64;
+	u8 pm1_register_byte_width;
+	u32 i;
+
+	/*
+	 * Optionally check all register lengths against the default values and
+	 * update them if they are incorrect.
+	 */
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
+	 * Each register is defined to be (event block length / 2). Extra divide
+	 * by 8 converts bits to bytes.
+	 */
+	pm1_register_byte_width =
+	    (u8)ACPI_DIV_16(acpi_gbl_FADT.xpm1a_event_block.bit_width);
+
+	/*
+	 * Calculate separate GAS structs for the PM1x (A/B) Status and Enable
+	 * registers. These addresses do not appear (directly) in the FADT, so it
+	 * is useful to pre-calculate them from the PM1 Event Block definitions.
+	 *
+	 * The PM event blocks are split into two register blocks, first is the
+	 * PM Status Register block, followed immediately by the PM Enable
+	 * Register block. Each is of length (pm1_event_length/2)
+	 *
+	 * Note: The PM1A event block is required by the ACPI specification.
+	 * However, the PM1B event block is optional and is rarely, if ever,
+	 * used.
+	 */
+
+	for (i = 0; i < ACPI_FADT_PM_INFO_ENTRIES; i++) {
+		source64 =
+		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
+				 fadt_pm_info_table[i].source);
+
+		acpi_tb_init_generic_address(fadt_pm_info_table[i].target,
+					     source64->space_id,
+					     pm1_register_byte_width,
+					     source64->address +
+					     (fadt_pm_info_table[i].
+					      register_num *
+					      pm1_register_byte_width));
+	}
+}
-- 
1.6.0.6

