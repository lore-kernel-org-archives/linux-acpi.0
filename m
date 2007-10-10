From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] ACPICA: hw: remove use_lock flag from acpi_hw_register_{read, write}
Date: Wed, 10 Oct 2007 01:07:49 -0400
Message-ID: <1191992870-15009-4-git-send-email-lenb@kernel.org>
References: <1191992870-15009-1-git-send-email-lenb@kernel.org>
 <1191992870-15009-2-git-send-email-lenb@kernel.org>
 <1191992870-15009-3-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32478 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbXJJFHy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 01:07:54 -0400
In-Reply-To: <1191992870-15009-3-git-send-email-lenb@kernel.org>
Message-Id: <d30dc9abb4aacfd4df3f486f22bcbc0531b73283.1191992618.git.len.brown@intel.com>
In-Reply-To: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
References: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

use_lock flag is used once for acpi_hw_register_read, and never for
acpi_hw_register_write. It will greatly simplify understanding of
locking if we just drop this use_lock altogether, and wrap the only call
to ..._read in lock/unlock.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evevent.c   |    6 +--
 drivers/acpi/hardware/hwregs.c  |   89 +++++++++++++++-----------------------
 drivers/acpi/hardware/hwsleep.c |   27 ++++--------
 include/acpi/achware.h          |    4 +-
 4 files changed, 48 insertions(+), 78 deletions(-)

diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index a1f87b5..e412878 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -239,10 +239,8 @@ u32 acpi_ev_fixed_event_detect(void)
 	 * Read the fixed feature status and enable registers, as all the cases
 	 * depend on their values.  Ignore errors here.
 	 */
-	(void)acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-				    ACPI_REGISTER_PM1_STATUS, &fixed_status);
-	(void)acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-				    ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
+	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &fixed_status);
+	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
index 1d371fa..73f9c5f 100644
--- a/drivers/acpi/hardware/hwregs.c
+++ b/drivers/acpi/hardware/hwregs.c
@@ -75,8 +75,7 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
 
-	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-					ACPI_REGISTER_PM1_STATUS,
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
 					ACPI_BITMASK_ALL_FIXED_STATUS);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
@@ -259,7 +258,7 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
  *
  ******************************************************************************/
 
-acpi_status acpi_get_register(u32 register_id, u32 * return_value)
+acpi_status acpi_get_register_unlocked(u32 register_id, u32 * return_value)
 {
 	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
@@ -276,8 +275,7 @@ acpi_status acpi_get_register(u32 register_id, u32 * return_value)
 
 	/* Read from the register */
 
-	status = acpi_hw_register_read(ACPI_MTX_LOCK,
-				       bit_reg_info->parent_register,
+	status = acpi_hw_register_read(bit_reg_info->parent_register,
 				       &register_value);
 
 	if (ACPI_SUCCESS(status)) {
@@ -298,6 +296,16 @@ acpi_status acpi_get_register(u32 register_id, u32 * return_value)
 	return_ACPI_STATUS(status);
 }
 
+acpi_status acpi_get_register(u32 register_id, u32 * return_value)
+{
+	acpi_status status;
+	acpi_cpu_flags flags;
+	flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
+	status = acpi_get_register_unlocked(register_id, return_value);
+	acpi_os_release_lock(acpi_gbl_hardware_lock, flags);
+	return status;
+}
+
 ACPI_EXPORT_SYMBOL(acpi_get_register)
 
 /*******************************************************************************
@@ -335,8 +343,7 @@ acpi_status acpi_set_register(u32 register_id, u32 value)
 
 	/* Always do a register read first so we can insert the new bits  */
 
-	status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-				       bit_reg_info->parent_register,
+	status = acpi_hw_register_read(bit_reg_info->parent_register,
 				       &register_value);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
@@ -363,8 +370,7 @@ acpi_status acpi_set_register(u32 register_id, u32 value)
 						   bit_reg_info->
 						   access_bit_mask);
 		if (value) {
-			status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-							ACPI_REGISTER_PM1_STATUS,
+			status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
 							(u16) value);
 			register_value = 0;
 		}
@@ -377,8 +383,7 @@ acpi_status acpi_set_register(u32 register_id, u32 value)
 					   bit_reg_info->access_bit_mask,
 					   value);
 
-		status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						ACPI_REGISTER_PM1_ENABLE,
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1_ENABLE,
 						(u16) register_value);
 		break;
 
@@ -397,15 +402,13 @@ acpi_status acpi_set_register(u32 register_id, u32 value)
 					   bit_reg_info->access_bit_mask,
 					   value);
 
-		status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						ACPI_REGISTER_PM1_CONTROL,
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1_CONTROL,
 						(u16) register_value);
 		break;
 
 	case ACPI_REGISTER_PM2_CONTROL:
 
-		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-					       ACPI_REGISTER_PM2_CONTROL,
+		status = acpi_hw_register_read(ACPI_REGISTER_PM2_CONTROL,
 					       &register_value);
 		if (ACPI_FAILURE(status)) {
 			goto unlock_and_exit;
@@ -430,8 +433,7 @@ acpi_status acpi_set_register(u32 register_id, u32 value)
 						     xpm2_control_block.
 						     address)));
 
-		status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						ACPI_REGISTER_PM2_CONTROL,
+		status = acpi_hw_register_write(ACPI_REGISTER_PM2_CONTROL,
 						(u8) (register_value));
 		break;
 
@@ -461,8 +463,7 @@ ACPI_EXPORT_SYMBOL(acpi_set_register)
  *
  * FUNCTION:    acpi_hw_register_read
  *
- * PARAMETERS:  use_lock            - Lock hardware? True/False
- *              register_id         - ACPI Register ID
+ * PARAMETERS:  register_id         - ACPI Register ID
  *              return_value        - Where the register value is returned
  *
  * RETURN:      Status and the value read.
@@ -471,19 +472,14 @@ ACPI_EXPORT_SYMBOL(acpi_set_register)
  *
  ******************************************************************************/
 acpi_status
-acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
+acpi_hw_register_read(u32 register_id, u32 * return_value)
 {
 	u32 value1 = 0;
 	u32 value2 = 0;
 	acpi_status status;
-	acpi_cpu_flags lock_flags = 0;
 
 	ACPI_FUNCTION_TRACE(hw_register_read);
 
-	if (ACPI_MTX_LOCK == use_lock) {
-		lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
-	}
-
 	switch (register_id) {
 	case ACPI_REGISTER_PM1_STATUS:	/* 16-bit access */
 
@@ -491,7 +487,7 @@ acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
 		    acpi_hw_low_level_read(16, &value1,
 					   &acpi_gbl_FADT.xpm1a_event_block);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		/* PM1B is optional */
@@ -507,7 +503,7 @@ acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
 		status =
 		    acpi_hw_low_level_read(16, &value1, &acpi_gbl_xpm1a_enable);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		/* PM1B is optional */
@@ -523,7 +519,7 @@ acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
 		    acpi_hw_low_level_read(16, &value1,
 					   &acpi_gbl_FADT.xpm1a_control_block);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		status =
@@ -558,10 +554,7 @@ acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
 		break;
 	}
 
-      unlock_and_exit:
-	if (ACPI_MTX_LOCK == use_lock) {
-		acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
-	}
+      exit:
 
 	if (ACPI_SUCCESS(status)) {
 		*return_value = value1;
@@ -574,8 +567,7 @@ acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
  *
  * FUNCTION:    acpi_hw_register_write
  *
- * PARAMETERS:  use_lock            - Lock hardware? True/False
- *              register_id         - ACPI Register ID
+ * PARAMETERS:  register_id         - ACPI Register ID
  *              Value               - The value to write
  *
  * RETURN:      Status
@@ -597,28 +589,22 @@ acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value)
+acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 {
 	acpi_status status;
-	acpi_cpu_flags lock_flags = 0;
 	u32 read_value;
 
 	ACPI_FUNCTION_TRACE(hw_register_write);
 
-	if (ACPI_MTX_LOCK == use_lock) {
-		lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
-	}
-
 	switch (register_id) {
 	case ACPI_REGISTER_PM1_STATUS:	/* 16-bit access */
 
 		/* Perform a read first to preserve certain bits (per ACPI spec) */
 
-		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-					       ACPI_REGISTER_PM1_STATUS,
+		status = acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS,
 					       &read_value);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		/* Insert the bits to be preserved */
@@ -632,7 +618,7 @@ acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value)
 		    acpi_hw_low_level_write(16, value,
 					    &acpi_gbl_FADT.xpm1a_event_block);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		/* PM1B is optional */
@@ -647,7 +633,7 @@ acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value)
 		status =
 		    acpi_hw_low_level_write(16, value, &acpi_gbl_xpm1a_enable);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		/* PM1B is optional */
@@ -661,11 +647,10 @@ acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value)
 		/*
 		 * Perform a read first to preserve certain bits (per ACPI spec)
 		 */
-		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-					       ACPI_REGISTER_PM1_CONTROL,
+		status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
 					       &read_value);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		/* Insert the bits to be preserved */
@@ -679,7 +664,7 @@ acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value)
 		    acpi_hw_low_level_write(16, value,
 					    &acpi_gbl_FADT.xpm1a_control_block);
 		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
+			goto exit;
 		}
 
 		status =
@@ -728,11 +713,7 @@ acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value)
 		break;
 	}
 
-      unlock_and_exit:
-	if (ACPI_MTX_LOCK == use_lock) {
-		acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
-	}
-
+      exit:
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index cf69c00..4d0c677 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -313,8 +313,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	/* Get current value of PM1A control */
 
-	status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-				       ACPI_REGISTER_PM1_CONTROL, &PM1Acontrol);
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL, &PM1Acontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -341,15 +340,13 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	/* Write #1: fill in SLP_TYP data */
 
-	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-					ACPI_REGISTER_PM1A_CONTROL,
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
 					PM1Acontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
-	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-					ACPI_REGISTER_PM1B_CONTROL,
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
 					PM1Bcontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -364,15 +361,13 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-					ACPI_REGISTER_PM1A_CONTROL,
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
 					PM1Acontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
-	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-					ACPI_REGISTER_PM1B_CONTROL,
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
 					PM1Bcontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -392,8 +387,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		 */
 		acpi_os_stall(10000000);
 
-		status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						ACPI_REGISTER_PM1_CONTROL,
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1_CONTROL,
 						sleep_enable_reg_info->
 						access_bit_mask);
 		if (ACPI_FAILURE(status)) {
@@ -520,8 +514,7 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
 		/* Get current value of PM1A control */
 
-		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-					       ACPI_REGISTER_PM1_CONTROL,
+		status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
 					       &PM1Acontrol);
 		if (ACPI_SUCCESS(status)) {
 
@@ -543,11 +536,9 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
 			/* Just ignore any errors */
 
-			(void)acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						     ACPI_REGISTER_PM1A_CONTROL,
+			(void)acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
 						     PM1Acontrol);
-			(void)acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						     ACPI_REGISTER_PM1B_CONTROL,
+			(void)acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
 						     PM1Bcontrol);
 		}
 	}
diff --git a/include/acpi/achware.h b/include/acpi/achware.h
index 9df275c..4053df9 100644
--- a/include/acpi/achware.h
+++ b/include/acpi/achware.h
@@ -71,9 +71,9 @@ u32 acpi_hw_get_mode(void);
 struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id);
 
 acpi_status
-acpi_hw_register_read(u8 use_lock, u32 register_id, u32 * return_value);
+acpi_hw_register_read(u32 register_id, u32 * return_value);
 
-acpi_status acpi_hw_register_write(u8 use_lock, u32 register_id, u32 value);
+acpi_status acpi_hw_register_write(u32 register_id, u32 value);
 
 acpi_status
 acpi_hw_low_level_read(u32 width,
-- 
1.5.3.4.206.g58ba4
