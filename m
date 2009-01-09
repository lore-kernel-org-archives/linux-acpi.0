From: Len Brown <lenb@kernel.org>
Subject: [PATCH 74/94] ACPICA: New: acpi_read and acpi_write public interfaces
Date: Fri, 09 Jan 2009 04:27:16 -0500
Message-ID: <ecfbbc7b46f74ca48b9f42132739114c9e70f8e4.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbZAIJ2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:41 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700ENE6BGP3I2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:29 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Changed the acpi_hw_low_level_read and acpi_hw_low_level_write functions to
the public acpi_read and acpi_write to allow direct access to
ACPI registers.  Removed the "width" parameter since the width
can be obtained from the input GAS structure. Updated the FADT
initialization to setup the GAS structures with the proper
widths. Some widths are still hardcoded because many FADTs have
incorrect register lengths.

Signed-off-by: Bob Moore <robert.moore@intel.com
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c    |   12 ++---
 drivers/acpi/events/evgpeblk.c |   14 ++----
 drivers/acpi/hardware/hwgpe.c  |   49 +++++++----------
 drivers/acpi/hardware/hwregs.c |  117 ++++++++++++++++++----------------------
 drivers/acpi/reboot.c          |    2 +-
 include/acpi/achware.h         |    7 ---
 include/acpi/acpixf.h          |   14 +++--
 7 files changed, 89 insertions(+), 126 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 12b49d3..a548859 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -422,10 +422,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 			/* Read the Status Register */
 
 			status =
-			    acpi_hw_low_level_read(ACPI_GPE_REGISTER_WIDTH,
-						   &status_reg,
-						   &gpe_register_info->
-						   status_address);
+			    acpi_read(&status_reg,
+				      &gpe_register_info->status_address);
 			if (ACPI_FAILURE(status)) {
 				goto unlock_and_exit;
 			}
@@ -433,10 +431,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 			/* Read the Enable Register */
 
 			status =
-			    acpi_hw_low_level_read(ACPI_GPE_REGISTER_WIDTH,
-						   &enable_reg,
-						   &gpe_register_info->
-						   enable_address);
+			    acpi_read(&enable_reg,
+				      &gpe_register_info->enable_address);
 			if (ACPI_FAILURE(status)) {
 				goto unlock_and_exit;
 			}
diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 2872be2..488503f 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -830,10 +830,8 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 		    ACPI_GPE_REGISTER_WIDTH;
 		this_register->enable_address.bit_width =
 		    ACPI_GPE_REGISTER_WIDTH;
-		this_register->status_address.bit_offset =
-		    ACPI_GPE_REGISTER_WIDTH;
-		this_register->enable_address.bit_offset =
-		    ACPI_GPE_REGISTER_WIDTH;
+		this_register->status_address.bit_offset = 0;
+		this_register->enable_address.bit_offset = 0;
 
 		/* Init the event_info for each GPE within this register */
 
@@ -846,18 +844,14 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 		/* Disable all GPEs within this register */
 
-		status = acpi_hw_low_level_write(ACPI_GPE_REGISTER_WIDTH, 0x00,
-						 &this_register->
-						 enable_address);
+		status = acpi_write(0x00, &this_register->enable_address);
 		if (ACPI_FAILURE(status)) {
 			goto error_exit;
 		}
 
 		/* Clear any pending GPE events within this register */
 
-		status = acpi_hw_low_level_write(ACPI_GPE_REGISTER_WIDTH, 0xFF,
-						 &this_register->
-						 status_address);
+		status = acpi_write(0xFF, &this_register->status_address);
 		if (ACPI_FAILURE(status)) {
 			goto error_exit;
 		}
diff --git a/drivers/acpi/hardware/hwgpe.c b/drivers/acpi/hardware/hwgpe.c
index 5ab7cac..09aaeaa 100644
--- a/drivers/acpi/hardware/hwgpe.c
+++ b/drivers/acpi/hardware/hwgpe.c
@@ -81,8 +81,7 @@ acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	/* Get current value of the enable register that contains this GPE */
 
-	status = acpi_hw_low_level_read(ACPI_GPE_REGISTER_WIDTH, &enable_mask,
-					&gpe_register_info->enable_address);
+	status = acpi_read(&enable_mask, &gpe_register_info->enable_address);
 	if (ACPI_FAILURE(status)) {
 		return (status);
 	}
@@ -96,9 +95,7 @@ acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	/* Write the updated enable mask */
 
-	status = acpi_hw_low_level_write(ACPI_GPE_REGISTER_WIDTH, enable_mask,
-					 &gpe_register_info->enable_address);
-
+	status = acpi_write(enable_mask, &gpe_register_info->enable_address);
 	return (status);
 }
 
@@ -133,8 +130,8 @@ acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info * gpe_event_info)
 
 	/* Write the entire GPE (runtime) enable register */
 
-	status = acpi_hw_low_level_write(8, gpe_register_info->enable_for_run,
-					 &gpe_register_info->enable_address);
+	status = acpi_write(gpe_register_info->enable_for_run,
+			    &gpe_register_info->enable_address);
 
 	return (status);
 }
@@ -167,9 +164,8 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 	 * Write a one to the appropriate bit in the status register to
 	 * clear this GPE.
 	 */
-	status = acpi_hw_low_level_write(8, register_bit,
-					 &gpe_event_info->register_info->
-					 status_address);
+	status = acpi_write(register_bit,
+			    &gpe_event_info->register_info->status_address);
 
 	return (status);
 }
@@ -228,9 +224,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	/* GPE currently active (status bit == 1)? */
 
-	status =
-	    acpi_hw_low_level_read(8, &in_byte,
-				   &gpe_register_info->status_address);
+	status = acpi_read(&in_byte, &gpe_register_info->status_address);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
 	}
@@ -273,9 +267,9 @@ acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 		/* Disable all GPEs in this register */
 
-		status = acpi_hw_low_level_write(8, 0x00,
-						 &gpe_block->register_info[i].
-						 enable_address);
+		status =
+		    acpi_write(0x00,
+			       &gpe_block->register_info[i].enable_address);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -310,9 +304,9 @@ acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 		/* Clear status on all GPEs in this register */
 
-		status = acpi_hw_low_level_write(8, 0xFF,
-						 &gpe_block->register_info[i].
-						 status_address);
+		status =
+		    acpi_write(0xFF,
+			       &gpe_block->register_info[i].status_address);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -353,12 +347,9 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 		/* Enable all "runtime" GPEs in this register */
 
-		status =
-		    acpi_hw_low_level_write(8,
-					    gpe_block->register_info[i].
-					    enable_for_run,
-					    &gpe_block->register_info[i].
-					    enable_address);
+		status = acpi_write(gpe_block->register_info[i].enable_for_run,
+				    &gpe_block->register_info[i].
+				    enable_address);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -398,11 +389,9 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 		/* Enable all "wake" GPEs in this register */
 
-		status = acpi_hw_low_level_write(8,
-						 gpe_block->register_info[i].
-						 enable_for_wake,
-						 &gpe_block->register_info[i].
-						 enable_address);
+		status = acpi_write(gpe_block->register_info[i].enable_for_wake,
+				    &gpe_block->register_info[i].
+				    enable_address);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
index 69dc8b4..d6d2ec6 100644
--- a/drivers/acpi/hardware/hwregs.c
+++ b/drivers/acpi/hardware/hwregs.c
@@ -84,9 +84,8 @@ acpi_status acpi_hw_clear_acpi_status(void)
 	/* Clear the fixed events */
 
 	if (acpi_gbl_FADT.xpm1b_event_block.address) {
-		status =
-		    acpi_hw_low_level_write(16, ACPI_BITMASK_ALL_FIXED_STATUS,
-					    &acpi_gbl_FADT.xpm1b_event_block);
+		status = acpi_write(ACPI_BITMASK_ALL_FIXED_STATUS,
+				    &acpi_gbl_FADT.xpm1b_event_block);
 		if (ACPI_FAILURE(status)) {
 			goto unlock_and_exit;
 		}
@@ -244,6 +243,8 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
 	return (&acpi_gbl_bit_register_info[register_id]);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_get_register_unlocked)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_register
@@ -483,63 +484,49 @@ acpi_hw_register_read(u32 register_id, u32 * return_value)
 	switch (register_id) {
 	case ACPI_REGISTER_PM1_STATUS:	/* 16-bit access */
 
-		status =
-		    acpi_hw_low_level_read(16, &value1,
-					   &acpi_gbl_FADT.xpm1a_event_block);
+		status = acpi_read(&value1, &acpi_gbl_FADT.xpm1a_event_block);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
 		/* PM1B is optional */
 
-		status =
-		    acpi_hw_low_level_read(16, &value2,
-					   &acpi_gbl_FADT.xpm1b_event_block);
+		status = acpi_read(&value2, &acpi_gbl_FADT.xpm1b_event_block);
 		value1 |= value2;
 		break;
 
 	case ACPI_REGISTER_PM1_ENABLE:	/* 16-bit access */
 
-		status =
-		    acpi_hw_low_level_read(16, &value1, &acpi_gbl_xpm1a_enable);
+		status = acpi_read(&value1, &acpi_gbl_xpm1a_enable);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
 		/* PM1B is optional */
 
-		status =
-		    acpi_hw_low_level_read(16, &value2, &acpi_gbl_xpm1b_enable);
+		status = acpi_read(&value2, &acpi_gbl_xpm1b_enable);
 		value1 |= value2;
 		break;
 
 	case ACPI_REGISTER_PM1_CONTROL:	/* 16-bit access */
 
-		status =
-		    acpi_hw_low_level_read(16, &value1,
-					   &acpi_gbl_FADT.xpm1a_control_block);
+		status = acpi_read(&value1, &acpi_gbl_FADT.xpm1a_control_block);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
-		status =
-		    acpi_hw_low_level_read(16, &value2,
-					   &acpi_gbl_FADT.xpm1b_control_block);
+		status = acpi_read(&value2, &acpi_gbl_FADT.xpm1b_control_block);
 		value1 |= value2;
 		break;
 
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
 
-		status =
-		    acpi_hw_low_level_read(8, &value1,
-					   &acpi_gbl_FADT.xpm2_control_block);
+		status = acpi_read(&value1, &acpi_gbl_FADT.xpm2_control_block);
 		break;
 
 	case ACPI_REGISTER_PM_TIMER:	/* 32-bit access */
 
-		status =
-		    acpi_hw_low_level_read(32, &value1,
-					   &acpi_gbl_FADT.xpm_timer_block);
+		status = acpi_read(&value1, &acpi_gbl_FADT.xpm_timer_block);
 		break;
 
 	case ACPI_REGISTER_SMI_COMMAND_BLOCK:	/* 8-bit access */
@@ -614,32 +601,26 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 		/* Now we can write the data */
 
-		status =
-		    acpi_hw_low_level_write(16, value,
-					    &acpi_gbl_FADT.xpm1a_event_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm1a_event_block);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
 		/* PM1B is optional */
 
-		status =
-		    acpi_hw_low_level_write(16, value,
-					    &acpi_gbl_FADT.xpm1b_event_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm1b_event_block);
 		break;
 
 	case ACPI_REGISTER_PM1_ENABLE:	/* 16-bit access */
 
-		status =
-		    acpi_hw_low_level_write(16, value, &acpi_gbl_xpm1a_enable);
+		status = acpi_write(value, &acpi_gbl_xpm1a_enable);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
 		/* PM1B is optional */
 
-		status =
-		    acpi_hw_low_level_write(16, value, &acpi_gbl_xpm1b_enable);
+		status = acpi_write(value, &acpi_gbl_xpm1b_enable);
 		break;
 
 	case ACPI_REGISTER_PM1_CONTROL:	/* 16-bit access */
@@ -660,44 +641,32 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 		/* Now we can write the data */
 
-		status =
-		    acpi_hw_low_level_write(16, value,
-					    &acpi_gbl_FADT.xpm1a_control_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm1a_control_block);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
 
-		status =
-		    acpi_hw_low_level_write(16, value,
-					    &acpi_gbl_FADT.xpm1b_control_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm1b_control_block);
 		break;
 
 	case ACPI_REGISTER_PM1A_CONTROL:	/* 16-bit access */
 
-		status =
-		    acpi_hw_low_level_write(16, value,
-					    &acpi_gbl_FADT.xpm1a_control_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm1a_control_block);
 		break;
 
 	case ACPI_REGISTER_PM1B_CONTROL:	/* 16-bit access */
 
-		status =
-		    acpi_hw_low_level_write(16, value,
-					    &acpi_gbl_FADT.xpm1b_control_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm1b_control_block);
 		break;
 
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
 
-		status =
-		    acpi_hw_low_level_write(8, value,
-					    &acpi_gbl_FADT.xpm2_control_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm2_control_block);
 		break;
 
 	case ACPI_REGISTER_PM_TIMER:	/* 32-bit access */
 
-		status =
-		    acpi_hw_low_level_write(32, value,
-					    &acpi_gbl_FADT.xpm_timer_block);
+		status = acpi_write(value, &acpi_gbl_FADT.xpm_timer_block);
 		break;
 
 	case ACPI_REGISTER_SMI_COMMAND_BLOCK:	/* 8-bit access */
@@ -719,10 +688,9 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_hw_low_level_read
+ * FUNCTION:    acpi_read
  *
- * PARAMETERS:  Width               - 8, 16, or 32
- *              Value               - Where the value is returned
+ * PARAMETERS:  Value               - Where the value is returned
  *              Reg                 - GAS register structure
  *
  * RETURN:      Status
@@ -731,13 +699,13 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
  *
  ******************************************************************************/
 
-acpi_status
-acpi_hw_low_level_read(u32 width, u32 * value, struct acpi_generic_address *reg)
+acpi_status acpi_read(u32 *value, struct acpi_generic_address *reg)
 {
+	u32 width;
 	u64 address;
 	acpi_status status;
 
-	ACPI_FUNCTION_NAME(hw_low_level_read);
+	ACPI_FUNCTION_NAME(acpi_read);
 
 	/*
 	 * Must have a valid pointer to a GAS structure, and
@@ -754,6 +722,16 @@ acpi_hw_low_level_read(u32 width, u32 * value, struct acpi_generic_address *reg)
 	if (!address) {
 		return (AE_OK);
 	}
+
+	/* Supported widths are 8/16/32 */
+
+	width = reg->bit_width;
+	if ((width != 8) && (width != 16) && (width != 32)) {
+		return (AE_SUPPORT);
+	}
+
+	/* Initialize entire 32-bit return value to zero */
+
 	*value = 0;
 
 	/*
@@ -787,12 +765,13 @@ acpi_hw_low_level_read(u32 width, u32 * value, struct acpi_generic_address *reg)
 	return (status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_read)
+
 /******************************************************************************
  *
- * FUNCTION:    acpi_hw_low_level_write
+ * FUNCTION:    acpi_write
  *
- * PARAMETERS:  Width               - 8, 16, or 32
- *              Value               - To be written
+ * PARAMETERS:  Value               - To be written
  *              Reg                 - GAS register structure
  *
  * RETURN:      Status
@@ -802,12 +781,13 @@ acpi_hw_low_level_read(u32 width, u32 * value, struct acpi_generic_address *reg)
  ******************************************************************************/
 
 acpi_status
-acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address * reg)
+acpi_write(u32 value, struct acpi_generic_address *reg)
 {
+	u32 width;
 	u64 address;
 	acpi_status status;
 
-	ACPI_FUNCTION_NAME(hw_low_level_write);
+	ACPI_FUNCTION_NAME(acpi_write);
 
 	/*
 	 * Must have a valid pointer to a GAS structure, and
@@ -825,6 +805,13 @@ acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address * reg)
 		return (AE_OK);
 	}
 
+	/* Supported widths are 8/16/32 */
+
+	width = reg->bit_width;
+	if ((width != 8) && (width != 16) && (width != 32)) {
+		return (AE_SUPPORT);
+	}
+
 	/*
 	 * Two address spaces supported: Memory or IO.
 	 * PCI_Config is not supported here because the GAS struct is insufficient
@@ -855,3 +842,5 @@ acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address * reg)
 
 	return (status);
 }
+
+ACPI_EXPORT_SYMBOL(acpi_write)
diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index a6b662c..b46fe52 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -42,7 +42,7 @@ void acpi_reboot(void)
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
-		acpi_hw_low_level_write(8, reset_value, rr);
+		acpi_write(reset_value, rr);
 		break;
 	}
 	/* Wait ten seconds */
diff --git a/include/acpi/achware.h b/include/acpi/achware.h
index 960f816..cd40810 100644
--- a/include/acpi/achware.h
+++ b/include/acpi/achware.h
@@ -75,13 +75,6 @@ acpi_hw_register_read(u32 register_id, u32 * return_value);
 
 acpi_status acpi_hw_register_write(u32 register_id, u32 value);
 
-acpi_status
-acpi_hw_low_level_read(u32 width,
-		       u32 * value, struct acpi_generic_address *reg);
-
-acpi_status
-acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address *reg);
-
 acpi_status acpi_hw_clear_acpi_status(void);
 
 /*
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 6d8fb6f..030aeb5 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -81,11 +81,6 @@ const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
 
-#ifdef ACPI_FUTURE_USAGE
-acpi_status
-acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
-#endif
-
 /*
  * ACPI Memory management
  */
@@ -195,9 +190,12 @@ acpi_status acpi_get_id(acpi_handle object, acpi_owner_id * out_type);
 acpi_status acpi_get_parent(acpi_handle object, acpi_handle * out_handle);
 
 /*
- * Event handler interfaces
+ * Handler interfaces
  */
 acpi_status
+acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
+
+acpi_status
 acpi_install_fixed_event_handler(u32 acpi_event,
 				 acpi_event_handler handler, void *context);
 
@@ -336,6 +334,10 @@ acpi_set_firmware_waking_vector(u32 physical_address);
 acpi_status
 acpi_set_firmware_waking_vector64(u64 physical_address);
 
+acpi_status acpi_read(u32 *value, struct acpi_generic_address *reg);
+
+acpi_status acpi_write(u32 value, struct acpi_generic_address *reg);
+
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
 
-- 
1.5.6.6

