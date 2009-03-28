From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/98] ACPICA: Optimize ACPI register locking
Date: Sat, 28 Mar 2009 00:31:09 -0400
Message-ID: <9892dd23cbbfab1f7d4818622296e415979a9c77.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbZC1Ecy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:54 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LDV8MHLBWL@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:42 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed locking for reads from the ACPI bit registers in PM1
Status, Enable, Control, and PM2 Control. The lock is not required
when reading the single-bit registers. The acpi_get_register_unlocked
function is no longer needed and has been removed. This will
improve performance for reads on these registers.  ACPICA BZ 760.

http://www.acpica.org/bugzilla/show_bug.cgi?id=760

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |    2 +-
 drivers/acpi/acpica/hwxface.c |   65 +++++++++++++++++------------------------
 drivers/acpi/processor_idle.c |    2 +-
 include/acpi/acpixf.h         |    2 -
 4 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 26e249e..677ccb6 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -365,7 +365,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	/* Wait until we enter sleep state */
 
 	do {
-		status = acpi_get_register_unlocked(ACPI_BITREG_WAKE_STATUS,
+		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS,
 						    &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 4df9eac..c810019 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -242,24 +242,35 @@ ACPI_EXPORT_SYMBOL(acpi_write)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_register_unlocked
+ * FUNCTION:    acpi_get_register
  *
- * PARAMETERS:  register_id     - ID of ACPI bit_register to access
- *              return_value    - Value that was read from the register
+ * PARAMETERS:  register_id     - ID of ACPI Bit Register to access
+ *              return_value    - Value that was read from the register,
+ *                                normalized to bit position zero.
  *
- * RETURN:      Status and the value read from specified Register. Value
+ * RETURN:      Status and the value read from the specified Register. Value
  *              returned is normalized to bit0 (is shifted all the way right)
  *
  * DESCRIPTION: ACPI bit_register read function. Does not acquire the HW lock.
  *
+ * SUPPORTS:    Bit fields in PM1 Status, PM1 Enable, PM1 Control, and
+ *              PM2 Control.
+ *
+ * Note: The hardware lock is not required when reading the ACPI bit registers
+ *       since almost all of them are single bit and it does not matter that
+ *       the parent hardware register can be split across two physical
+ *       registers. The only multi-bit field is SLP_TYP in the PM1 control
+ *       register, but this field does not cross an 8-bit boundary (nor does
+ *       it make much sense to actually read this field.)
+ *
  ******************************************************************************/
-acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value)
+acpi_status acpi_get_register(u32 register_id, u32 *return_value)
 {
 	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(acpi_get_register_unlocked);
+	ACPI_FUNCTION_TRACE(acpi_get_register);
 
 	/* Get the info structure corresponding to the requested ACPI Register */
 
@@ -268,7 +279,7 @@ acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Read from the register */
+	/* Read the entire parent register */
 
 	status = acpi_hw_register_read(bit_reg_info->parent_register,
 				       &register_value);
@@ -291,46 +302,24 @@ acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value)
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_get_register_unlocked)
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_get_register
- *
- * PARAMETERS:  register_id     - ID of ACPI bit_register to access
- *              return_value    - Value that was read from the register
- *
- * RETURN:      Status and the value read from specified Register. Value
- *              returned is normalized to bit0 (is shifted all the way right)
- *
- * DESCRIPTION: ACPI bit_register read function.
- *
- ******************************************************************************/
-acpi_status acpi_get_register(u32 register_id, u32 *return_value)
-{
-	acpi_status status;
-	acpi_cpu_flags flags;
-
-	flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
-	status = acpi_get_register_unlocked(register_id, return_value);
-	acpi_os_release_lock(acpi_gbl_hardware_lock, flags);
-
-	return (status);
-}
-
 ACPI_EXPORT_SYMBOL(acpi_get_register)
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_set_register
  *
- * PARAMETERS:  register_id     - ID of ACPI bit_register to access
- *              Value           - (only used on write) value to write to the
- *                                Register, NOT pre-normalized to the bit pos
+ * PARAMETERS:  register_id     - ID of ACPI Bit Register to access
+ *              Value           - Value to write to the register, in bit
+ *                                position zero. The bit is automaticallly
+ *                                shifted to the correct position.
  *
  * RETURN:      Status
  *
- * DESCRIPTION: ACPI Bit Register write function.
+ * DESCRIPTION: ACPI Bit Register write function. Acquires the hardware lock
+ *              since most operations require a read/modify/write sequence.
+ *
+ * SUPPORTS:    Bit fields in PM1 Status, PM1 Enable, PM1 Control, and
+ *              PM2 Control.
  *
  ******************************************************************************/
 acpi_status acpi_set_register(u32 register_id, u32 value)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 7bc22a4..6946047 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -800,7 +800,7 @@ static int acpi_idle_bm_check(void)
 {
 	u32 bm_status = 0;
 
-	acpi_get_register_unlocked(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 	if (bm_status)
 		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
 	/*
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e10c896..325d4b0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -347,8 +347,6 @@ acpi_status acpi_reset(void);
 
 acpi_status acpi_get_register(u32 register_id, u32 * return_value);
 
-acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
-
 acpi_status acpi_set_register(u32 register_id, u32 value);
 
 acpi_status acpi_set_firmware_waking_vector(u32 physical_address);
-- 
1.6.0.6

