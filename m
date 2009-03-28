From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/98] ACPICA: Rename ACPI bit register access functions
Date: Sat, 28 Mar 2009 00:31:10 -0400
Message-ID: <50ffba1bd3120b069617455545bc27bcf3cf7579.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8294 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbZC1EdT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7000HL8MHWGR9@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:42 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Rename acpi_get_register and acpi_set_register to clarify the
purpose of these functions. New names are acpi_read_bit_register
and acpi_write_bit_register.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evevent.c  |   12 ++++++------
 drivers/acpi/acpica/evmisc.c   |    4 ++--
 drivers/acpi/acpica/evxfevnt.c |   24 ++++++++++++------------
 drivers/acpi/acpica/hwacpi.c   |    2 +-
 drivers/acpi/acpica/hwsleep.c  |   15 ++++++++-------
 drivers/acpi/acpica/hwxface.c  |   16 ++++++++--------
 drivers/acpi/processor_idle.c  |   10 +++++-----
 drivers/acpi/sleep.c           |    2 +-
 include/acpi/acpixf.h          |    4 ++--
 9 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 803edd9..246f877 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -204,8 +204,8 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 
 		if (acpi_gbl_fixed_event_info[i].enable_register_id != 0xFF) {
 			status =
-			    acpi_set_register(acpi_gbl_fixed_event_info[i].
-					      enable_register_id, 0);
+			    acpi_write_bit_register(acpi_gbl_fixed_event_info
+						    [i].enable_register_id, 0);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -288,16 +288,16 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 
 	/* Clear the status bit */
 
-	(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
-				status_register_id, 1);
+	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
+				      status_register_id, 1);
 
 	/*
 	 * Make sure we've got a handler. If not, report an error. The event is
 	 * disabled to prevent further interrupts.
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
-		(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
-					enable_register_id, 0);
+		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
+					      enable_register_id, 0);
 
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event [%08X]",
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 5f89305..0e9e12b 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -534,8 +534,8 @@ acpi_status acpi_ev_release_global_lock(void)
 		 */
 		if (pending) {
 			status =
-			    acpi_set_register(ACPI_BITREG_GLOBAL_LOCK_RELEASE,
-					      1);
+			    acpi_write_bit_register
+			    (ACPI_BITREG_GLOBAL_LOCK_RELEASE, 1);
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 35485e4..484c979 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -172,8 +172,8 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 	 * register bit)
 	 */
 	status =
-	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, 1);
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
+				    enable_register_id, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -181,8 +181,8 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 	/* Make sure that the hardware responded */
 
 	status =
-	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, &value);
+	    acpi_read_bit_register(acpi_gbl_fixed_event_info[event].
+				   enable_register_id, &value);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -354,15 +354,15 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
 	 * register bit)
 	 */
 	status =
-	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, 0);
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
+				    enable_register_id, 0);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
 	status =
-	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, &value);
+	    acpi_read_bit_register(acpi_gbl_fixed_event_info[event].
+				   enable_register_id, &value);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -407,8 +407,8 @@ acpi_status acpi_clear_event(u32 event)
 	 * register bit)
 	 */
 	status =
-	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      status_register_id, 1);
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
+				    status_register_id, 1);
 
 	return_ACPI_STATUS(status);
 }
@@ -495,7 +495,7 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 	/* Get the status of the requested fixed event */
 
 	status =
-	    acpi_get_register(acpi_gbl_fixed_event_info[event].
+	    acpi_read_bit_register(acpi_gbl_fixed_event_info[event].
 			      enable_register_id, &value);
 	if (ACPI_FAILURE(status))
 		return_ACPI_STATUS(status);
@@ -503,7 +503,7 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 	*event_status = value;
 
 	status =
-	    acpi_get_register(acpi_gbl_fixed_event_info[event].
+	    acpi_read_bit_register(acpi_gbl_fixed_event_info[event].
 			      status_register_id, &value);
 	if (ACPI_FAILURE(status))
 		return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index a9d4fea..8902db8 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -172,7 +172,7 @@ u32 acpi_hw_get_mode(void)
 		return_UINT32(ACPI_SYS_MODE_ACPI);
 	}
 
-	status = acpi_get_register(ACPI_BITREG_SCI_ENABLE, &value);
+	status = acpi_read_bit_register(ACPI_BITREG_SCI_ENABLE, &value);
 	if (ACPI_FAILURE(status)) {
 		return_UINT32(ACPI_SYS_MODE_LEGACY);
 	}
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 677ccb6..78d62b8 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -250,7 +250,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	/* Clear wake status */
 
-	status = acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
+	status = acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -365,7 +365,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	/* Wait until we enter sleep state */
 
 	do {
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS,
+		status = acpi_read_bit_register(ACPI_BITREG_WAKE_STATUS,
 						    &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
@@ -399,7 +399,7 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 
 	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state_s4bios);
 
-	status = acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
+	status = acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -431,7 +431,8 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 
 	do {
 		acpi_os_stall(1000);
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
+		status =
+		    acpi_read_bit_register(ACPI_BITREG_WAKE_STATUS, &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -592,18 +593,18 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	 * it to determine whether the system is rebooting or resuming. Clear
 	 * it for compatibility.
 	 */
-	acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
+	acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
 
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	/* Enable power button */
 
 	(void)
-	    acpi_set_register(acpi_gbl_fixed_event_info
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info
 			      [ACPI_EVENT_POWER_BUTTON].enable_register_id, 1);
 
 	(void)
-	    acpi_set_register(acpi_gbl_fixed_event_info
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info
 			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1);
 
 	arg.integer.value = ACPI_SST_WORKING;
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index c810019..529251c 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -242,7 +242,7 @@ ACPI_EXPORT_SYMBOL(acpi_write)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_register
+ * FUNCTION:    acpi_read_bit_register
  *
  * PARAMETERS:  register_id     - ID of ACPI Bit Register to access
  *              return_value    - Value that was read from the register,
@@ -264,13 +264,13 @@ ACPI_EXPORT_SYMBOL(acpi_write)
  *       it make much sense to actually read this field.)
  *
  ******************************************************************************/
-acpi_status acpi_get_register(u32 register_id, u32 *return_value)
+acpi_status acpi_read_bit_register(u32 register_id, u32 *return_value)
 {
 	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(acpi_get_register);
+	ACPI_FUNCTION_TRACE(acpi_read_bit_register);
 
 	/* Get the info structure corresponding to the requested ACPI Register */
 
@@ -302,11 +302,11 @@ acpi_status acpi_get_register(u32 register_id, u32 *return_value)
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_get_register)
+ACPI_EXPORT_SYMBOL(acpi_read_bit_register)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_set_register
+ * FUNCTION:    acpi_write_bit_register
  *
  * PARAMETERS:  register_id     - ID of ACPI Bit Register to access
  *              Value           - Value to write to the register, in bit
@@ -322,14 +322,14 @@ ACPI_EXPORT_SYMBOL(acpi_get_register)
  *              PM2 Control.
  *
  ******************************************************************************/
-acpi_status acpi_set_register(u32 register_id, u32 value)
+acpi_status acpi_write_bit_register(u32 register_id, u32 value)
 {
 	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
 	acpi_status status;
 	acpi_cpu_flags lock_flags;
 
-	ACPI_FUNCTION_TRACE_U32(acpi_set_register, register_id);
+	ACPI_FUNCTION_TRACE_U32(acpi_write_bit_register, register_id);
 
 	/* Get the info structure corresponding to the requested ACPI Register */
 
@@ -459,7 +459,7 @@ acpi_status acpi_set_register(u32 register_id, u32 value)
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_set_register)
+ACPI_EXPORT_SYMBOL(acpi_write_bit_register)
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6946047..5c69e85 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -630,7 +630,7 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	 * In either case, the proper way to
 	 * handle BM_RLD is to set it and leave it set.
 	 */
-	acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
+	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 
 	return;
 }
@@ -800,9 +800,9 @@ static int acpi_idle_bm_check(void)
 {
 	u32 bm_status = 0;
 
-	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 	if (bm_status)
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
+		acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
 	/*
 	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
 	 * the true state of bus mastering activity; forcing us to
@@ -1028,7 +1028,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		c3_cpu_count++;
 		/* Disable bus master arbitration when all CPUs are in C3 */
 		if (c3_cpu_count == num_online_cpus())
-			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
+			acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 1);
 		spin_unlock(&c3_lock);
 	} else if (!pr->flags.bm_check) {
 		ACPI_FLUSH_CPU_CACHE();
@@ -1041,7 +1041,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	/* Re-enable bus master arbitration */
 	if (pr->flags.bm_check && pr->flags.bm_control) {
 		spin_lock(&c3_lock);
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
+		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
 		c3_cpu_count--;
 		spin_unlock(&c3_lock);
 	}
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 00456fc..837ac7d 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -248,7 +248,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
 	if (set_sci_en_on_resume)
-		acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1);
+		acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
 	else
 		acpi_enable();
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 325d4b0..a5525a5 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -345,9 +345,9 @@ acpi_resource_to_address64(struct acpi_resource *resource,
  */
 acpi_status acpi_reset(void);
 
-acpi_status acpi_get_register(u32 register_id, u32 * return_value);
+acpi_status acpi_read_bit_register(u32 register_id, u32 *return_value);
 
-acpi_status acpi_set_register(u32 register_id, u32 value);
+acpi_status acpi_write_bit_register(u32 register_id, u32 value);
 
 acpi_status acpi_set_firmware_waking_vector(u32 physical_address);
 
-- 
1.6.0.6

