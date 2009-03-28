From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/98] ACPICA: Add function to handle PM1 control registers
Date: Sat, 28 Mar 2009 00:31:03 -0400
Message-ID: <32c9ef994d91352b710b948ec369cd18d6bca51b.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22330 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZC1Eck (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700CB28MDZHIO@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:39 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added acpi_hw_write_pm1_control. This function writes both of the PM1
control registers (A/B). These registers are different than than
the PM1 A/B status and enable registers in that different values
can be written to the A/B registers.  Most notably, the SLP_TYP
bits can be different, as per the values returned from the _Sx
predefined methods.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/achware.h |    5 +-
 drivers/acpi/acpica/aclocal.h |   10 ++---
 drivers/acpi/acpica/hwregs.c  |   46 +++++++++++++++++-----
 drivers/acpi/acpica/hwsleep.c |   84 +++++++++++++++++------------------------
 4 files changed, 78 insertions(+), 67 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 58c69dc..4fa6ee6 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -64,8 +64,9 @@ u32 acpi_hw_get_mode(void);
  */
 struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id);
 
-acpi_status
-acpi_hw_register_read(u32 register_id, u32 * return_value);
+acpi_status acpi_hw_write_pm1_control(u32 pm1a_control, u32 pm1b_control);
+
+acpi_status acpi_hw_register_read(u32 register_id, u32 *return_value);
 
 acpi_status acpi_hw_register_write(u32 register_id, u32 value);
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index b9a0aa6..6feebc8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -781,12 +781,10 @@ struct acpi_bit_register_info {
 #define ACPI_REGISTER_PM1_STATUS                0x01
 #define ACPI_REGISTER_PM1_ENABLE                0x02
 #define ACPI_REGISTER_PM1_CONTROL               0x03
-#define ACPI_REGISTER_PM1A_CONTROL              0x04
-#define ACPI_REGISTER_PM1B_CONTROL              0x05
-#define ACPI_REGISTER_PM2_CONTROL               0x06
-#define ACPI_REGISTER_PM_TIMER                  0x07
-#define ACPI_REGISTER_PROCESSOR_BLOCK           0x08
-#define ACPI_REGISTER_SMI_COMMAND_BLOCK         0x09
+#define ACPI_REGISTER_PM2_CONTROL               0x04
+#define ACPI_REGISTER_PM_TIMER                  0x05
+#define ACPI_REGISTER_PROCESSOR_BLOCK           0x06
+#define ACPI_REGISTER_SMI_COMMAND_BLOCK         0x07
 
 /* Masks used to access the bit_registers */
 
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 5a64e57..edc627c 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -131,6 +131,42 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_hw_write_pm1_control
+ *
+ * PARAMETERS:  pm1a_control        - Value to be written to PM1A control
+ *              pm1b_control        - Value to be written to PM1B control
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Write the PM1 A/B control registers. These registers are
+ *              different than than the PM1 A/B status and enable registers
+ *              in that different values can be written to the A/B registers.
+ *              Most notably, the SLP_TYP bits can be different, as per the
+ *              values returned from the _Sx predefined methods.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_write_pm1_control(u32 pm1a_control, u32 pm1b_control)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(hw_write_pm1_control);
+
+	status = acpi_write(pm1a_control, &acpi_gbl_FADT.xpm1a_control_block);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	if (acpi_gbl_FADT.xpm1b_control_block.address) {
+		status =
+		    acpi_write(pm1b_control,
+			       &acpi_gbl_FADT.xpm1b_control_block);
+	}
+	return_ACPI_STATUS(status);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_hw_register_read
  *
  * PARAMETERS:  register_id         - ACPI Register ID
@@ -295,16 +331,6 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 						xpm1b_control_block);
 		break;
 
-	case ACPI_REGISTER_PM1A_CONTROL:	/* 16-bit access */
-
-		status = acpi_write(value, &acpi_gbl_FADT.xpm1a_control_block);
-		break;
-
-	case ACPI_REGISTER_PM1B_CONTROL:	/* 16-bit access */
-
-		status = acpi_write(value, &acpi_gbl_FADT.xpm1b_control_block);
-		break;
-
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
 
 		status = acpi_write(value, &acpi_gbl_FADT.xpm2_control_block);
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 1a7d260..51868f4 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -147,9 +147,8 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 
 	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state_prep);
 
-	/*
-	 * _PSW methods could be run here to enable wake-on keyboard, LAN, etc.
-	 */
+	/* _PSW methods could be run here to enable wake-on keyboard, LAN, etc. */
+
 	status = acpi_get_sleep_type_data(sleep_state,
 					  &acpi_gbl_sleep_type_a,
 					  &acpi_gbl_sleep_type_b);
@@ -223,8 +222,8 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
  ******************************************************************************/
 acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 {
-	u32 PM1Acontrol;
-	u32 PM1Bcontrol;
+	u32 pm1a_control;
+	u32 pm1b_control;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
 	u32 in_value;
@@ -289,24 +288,25 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	/* Get current value of PM1A control */
 
-	status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL, &PM1Acontrol);
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
+				       &pm1a_control);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
 			  "Entering sleep state [S%d]\n", sleep_state));
 
-	/* Clear SLP_EN and SLP_TYP fields */
+	/* Clear the SLP_EN and SLP_TYP fields */
 
-	PM1Acontrol &= ~(sleep_type_reg_info->access_bit_mask |
-			 sleep_enable_reg_info->access_bit_mask);
-	PM1Bcontrol = PM1Acontrol;
+	pm1a_control &= ~(sleep_type_reg_info->access_bit_mask |
+			  sleep_enable_reg_info->access_bit_mask);
+	pm1b_control = pm1a_control;
 
-	/* Insert SLP_TYP bits */
+	/* Insert the SLP_TYP bits */
 
-	PM1Acontrol |=
+	pm1a_control |=
 	    (acpi_gbl_sleep_type_a << sleep_type_reg_info->bit_position);
-	PM1Bcontrol |=
+	pm1b_control |=
 	    (acpi_gbl_sleep_type_b << sleep_type_reg_info->bit_position);
 
 	/*
@@ -314,37 +314,25 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	 * poorly implemented hardware.
 	 */
 
-	/* Write #1: fill in SLP_TYP data */
-
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
-					PM1Acontrol);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	/* Write #1: write the SLP_TYP data to the PM1 Control registers */
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
-					PM1Bcontrol);
+	status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
-	/* Insert SLP_ENABLE bit */
+	/* Insert the sleep enable (SLP_EN) bit */
 
-	PM1Acontrol |= sleep_enable_reg_info->access_bit_mask;
-	PM1Bcontrol |= sleep_enable_reg_info->access_bit_mask;
+	pm1a_control |= sleep_enable_reg_info->access_bit_mask;
+	pm1b_control |= sleep_enable_reg_info->access_bit_mask;
 
-	/* Write #2: SLP_TYP + SLP_EN */
+	/* Flush caches, as per ACPI specification */
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
-					PM1Acontrol);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	/* Write #2: Write both SLP_TYP + SLP_EN */
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
-					PM1Bcontrol);
+	status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -471,8 +459,8 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 	acpi_status status;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
-	u32 PM1Acontrol;
-	u32 PM1Bcontrol;
+	u32 pm1a_control;
+	u32 pm1b_control;
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
 
@@ -493,31 +481,29 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 		/* Get current value of PM1A control */
 
 		status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
-					       &PM1Acontrol);
+					       &pm1a_control);
 		if (ACPI_SUCCESS(status)) {
 
-			/* Clear SLP_EN and SLP_TYP fields */
+			/* Clear the SLP_EN and SLP_TYP fields */
 
-			PM1Acontrol &= ~(sleep_type_reg_info->access_bit_mask |
-					 sleep_enable_reg_info->
-					 access_bit_mask);
-			PM1Bcontrol = PM1Acontrol;
+			pm1a_control &= ~(sleep_type_reg_info->access_bit_mask |
+					  sleep_enable_reg_info->
+					  access_bit_mask);
+			pm1b_control = pm1a_control;
 
-			/* Insert SLP_TYP bits */
+			/* Insert the SLP_TYP bits */
 
-			PM1Acontrol |=
+			pm1a_control |=
 			    (acpi_gbl_sleep_type_a << sleep_type_reg_info->
 			     bit_position);
-			PM1Bcontrol |=
+			pm1b_control |=
 			    (acpi_gbl_sleep_type_b << sleep_type_reg_info->
 			     bit_position);
 
-			/* Just ignore any errors */
+			/* Write the control registers and ignore any errors */
 
-			(void)acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
-						     PM1Acontrol);
-			(void)acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
-						     PM1Bcontrol);
+			(void)acpi_hw_write_pm1_control(pm1a_control,
+							pm1b_control);
 		}
 	}
 
-- 
1.6.0.6

