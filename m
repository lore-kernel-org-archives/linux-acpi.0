From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/98] ACPICA: Restructure bit register access functions
Date: Sat, 28 Mar 2009 00:31:11 -0400
Message-ID: <88dcb04a813265e1a5a1bc74af2db7efa7d62ee6.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22330 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZC1Ecp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:45 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700CC88MIZHIO@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:43 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Update code for acpi_read_bit_register and acpi_write_bit_register.
Simplified code path, condensed duplicate code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwxface.c |  177 ++++++++++++++--------------------------
 1 files changed, 62 insertions(+), 115 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 529251c..caad516 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -133,8 +133,8 @@ acpi_status acpi_read(u32 *value, struct acpi_generic_address *reg)
 	*value = 0;
 
 	/*
-	 * Two address spaces supported: Memory or IO.
-	 * PCI_Config is not supported here because the GAS struct is insufficient
+	 * Two address spaces supported: Memory or IO. PCI_Config is
+	 * not supported here because the GAS structure is insufficient
 	 */
 	switch (reg->space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
@@ -266,11 +266,12 @@ ACPI_EXPORT_SYMBOL(acpi_write)
  ******************************************************************************/
 acpi_status acpi_read_bit_register(u32 register_id, u32 *return_value)
 {
-	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
+	u32 register_value;
+	u32 value;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(acpi_read_bit_register);
+	ACPI_FUNCTION_TRACE_U32(acpi_read_bit_register, register_id);
 
 	/* Get the info structure corresponding to the requested ACPI Register */
 
@@ -283,23 +284,22 @@ acpi_status acpi_read_bit_register(u32 register_id, u32 *return_value)
 
 	status = acpi_hw_register_read(bit_reg_info->parent_register,
 				       &register_value);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
-	if (ACPI_SUCCESS(status)) {
-
-		/* Normalize the value that was read */
-
-		register_value =
-		    ((register_value & bit_reg_info->access_bit_mask)
-		     >> bit_reg_info->bit_position);
+	/* Normalize the value that was read, mask off other bits */
 
-		*return_value = register_value;
+	value = ((register_value & bit_reg_info->access_bit_mask)
+		 >> bit_reg_info->bit_position);
 
-		ACPI_DEBUG_PRINT((ACPI_DB_IO, "Read value %8.8X register %X\n",
-				  register_value,
-				  bit_reg_info->parent_register));
-	}
+	ACPI_DEBUG_PRINT((ACPI_DB_IO,
+			  "BitReg %X, ParentReg %X, Actual %8.8X, ReturnValue %8.8X\n",
+			  register_id, bit_reg_info->parent_register,
+			  register_value, value));
 
-	return_ACPI_STATUS(status);
+	*return_value = value;
+	return_ACPI_STATUS(AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_read_bit_register)
@@ -321,13 +321,16 @@ ACPI_EXPORT_SYMBOL(acpi_read_bit_register)
  * SUPPORTS:    Bit fields in PM1 Status, PM1 Enable, PM1 Control, and
  *              PM2 Control.
  *
+ * Note that at this level, the fact that there may be actually two
+ * hardware registers (A and B - and B may not exist) is abstracted.
+ *
  ******************************************************************************/
 acpi_status acpi_write_bit_register(u32 register_id, u32 value)
 {
-	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
-	acpi_status status;
 	acpi_cpu_flags lock_flags;
+	u32 register_value;
+	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE_U32(acpi_write_bit_register, register_id);
 
@@ -335,127 +338,71 @@ acpi_status acpi_write_bit_register(u32 register_id, u32 value)
 
 	bit_reg_info = acpi_hw_get_bit_register_info(register_id);
 	if (!bit_reg_info) {
-		ACPI_ERROR((AE_INFO, "Bad ACPI HW RegisterId: %X",
-			    register_id));
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
 
-	/* Always do a register read first so we can insert the new bits  */
-
-	status = acpi_hw_register_read(bit_reg_info->parent_register,
-				       &register_value);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
-
 	/*
-	 * Decode the Register ID
-	 * Register ID = [Register block ID] | [bit ID]
-	 *
-	 * Check bit ID to fine locate Register offset.
-	 * Check Mask to determine Register offset, and then read-write.
+	 * At this point, we know that the parent register is one of the
+	 * following: PM1 Status, PM1 Enable, PM1 Control, or PM2 Control
 	 */
-	switch (bit_reg_info->parent_register) {
-	case ACPI_REGISTER_PM1_STATUS:
-
-		/*
-		 * Status Registers are different from the rest. Clear by
-		 * writing 1, and writing 0 has no effect. So, the only relevant
-		 * information is the single bit we're interested in, all others should
-		 * be written as 0 so they will be left unchanged.
-		 */
-		value = ACPI_REGISTER_PREPARE_BITS(value,
-						   bit_reg_info->bit_position,
-						   bit_reg_info->
-						   access_bit_mask);
-		if (value) {
-			status =
-			    acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
-						   (u16) value);
-			register_value = 0;
-		}
-		break;
-
-	case ACPI_REGISTER_PM1_ENABLE:
-
-		ACPI_REGISTER_INSERT_VALUE(register_value,
-					   bit_reg_info->bit_position,
-					   bit_reg_info->access_bit_mask,
-					   value);
-
-		status = acpi_hw_register_write(ACPI_REGISTER_PM1_ENABLE,
-						(u16) register_value);
-		break;
-
-	case ACPI_REGISTER_PM1_CONTROL:
-
+	if (bit_reg_info->parent_register != ACPI_REGISTER_PM1_STATUS) {
 		/*
-		 * Write the PM1 Control register.
-		 * Note that at this level, the fact that there are actually TWO
-		 * registers (A and B - and B may not exist) is abstracted.
+		 * 1) Case for PM1 Enable, PM1 Control, and PM2 Control
+		 *
+		 * Perform a register read to preserve the bits that we are not
+		 * interested in
 		 */
-		ACPI_DEBUG_PRINT((ACPI_DB_IO, "PM1 control: Read %X\n",
-				  register_value));
-
-		ACPI_REGISTER_INSERT_VALUE(register_value,
-					   bit_reg_info->bit_position,
-					   bit_reg_info->access_bit_mask,
-					   value);
-
-		status = acpi_hw_register_write(ACPI_REGISTER_PM1_CONTROL,
-						(u16) register_value);
-		break;
-
-	case ACPI_REGISTER_PM2_CONTROL:
-
-		status = acpi_hw_register_read(ACPI_REGISTER_PM2_CONTROL,
+		status = acpi_hw_register_read(bit_reg_info->parent_register,
 					       &register_value);
 		if (ACPI_FAILURE(status)) {
 			goto unlock_and_exit;
 		}
 
-		ACPI_DEBUG_PRINT((ACPI_DB_IO,
-				  "PM2 control: Read %X from %8.8X%8.8X\n",
-				  register_value,
-				  ACPI_FORMAT_UINT64(acpi_gbl_FADT.
-						     xpm2_control_block.
-						     address)));
-
+		/*
+		 * Insert the input bit into the value that was just read
+		 * and write the register
+		 */
 		ACPI_REGISTER_INSERT_VALUE(register_value,
 					   bit_reg_info->bit_position,
 					   bit_reg_info->access_bit_mask,
 					   value);
 
-		ACPI_DEBUG_PRINT((ACPI_DB_IO,
-				  "About to write %4.4X to %8.8X%8.8X\n",
-				  register_value,
-				  ACPI_FORMAT_UINT64(acpi_gbl_FADT.
-						     xpm2_control_block.
-						     address)));
+		status = acpi_hw_register_write(bit_reg_info->parent_register,
+						register_value);
+	} else {
+		/*
+		 * 2) Case for PM1 Status
+		 *
+		 * The Status register is different from the rest. Clear an event
+		 * by writing 1, writing 0 has no effect. So, the only relevant
+		 * information is the single bit we're interested in, all others
+		 * should be written as 0 so they will be left unchanged.
+		 */
+		register_value = ACPI_REGISTER_PREPARE_BITS(value,
+							    bit_reg_info->
+							    bit_position,
+							    bit_reg_info->
+							    access_bit_mask);
 
-		status = acpi_hw_register_write(ACPI_REGISTER_PM2_CONTROL,
-						(u8) (register_value));
-		break;
+		/* No need to write the register if value is all zeros */
 
-	default:
-		break;
+		if (register_value) {
+			status =
+			    acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
+						   register_value);
+		}
 	}
 
-      unlock_and_exit:
-
-	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
-
-	/* Normalize the value that was read */
+	ACPI_DEBUG_PRINT((ACPI_DB_IO,
+			  "BitReg %X, ParentReg %X, Value %8.8X, Actual %8.8X\n",
+			  register_id, bit_reg_info->parent_register, value,
+			  register_value));
 
-	ACPI_DEBUG_EXEC(register_value =
-			((register_value & bit_reg_info->access_bit_mask) >>
-			 bit_reg_info->bit_position));
+unlock_and_exit:
 
-	ACPI_DEBUG_PRINT((ACPI_DB_IO,
-			  "Set bits: %8.8X actual %8.8X register %X\n", value,
-			  register_value, bit_reg_info->parent_register));
+	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
 	return_ACPI_STATUS(status);
 }
 
-- 
1.6.0.6

