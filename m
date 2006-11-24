From: Len Brown <len.brown@intel.com>
Subject: [PATCH 42/65] ACPICA: Remove obsolete Flags parameter.
Date: Fri, 24 Nov 2006 02:18:52 -0500
Message-ID: <11643528032291-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35472 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934482AbWKXHQG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:06 -0500
In-Reply-To: <11643528022585-git-send-email-len.brown@intel.com>
Message-Id: <6ccc4ddcc4790ad35ecc1b433d693cd9a356d8b1.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Remove flags parameter for acpi_{get,set}_register().
It is no longer necessary now that these functions use a
spinlock for mutual exclusion.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/cpu/cpufreq/longhaul.c |    9 +++------
 drivers/acpi/events/evevent.c           |    8 +++-----
 drivers/acpi/events/evmisc.c            |    2 +-
 drivers/acpi/events/evxfevnt.c          |   12 ++++++------
 drivers/acpi/hardware/hwacpi.c          |    3 +--
 drivers/acpi/hardware/hwregs.c          |   18 +++++-------------
 drivers/acpi/hardware/hwsleep.c         |   22 ++++++++--------------
 drivers/acpi/pci_link.c                 |    2 +-
 drivers/acpi/processor_idle.c           |   21 +++++++--------------
 include/acpi/achware.h                  |    2 +-
 include/acpi/acpixf.h                   |    4 ++--
 11 files changed, 38 insertions(+), 65 deletions(-)

diff --git a/arch/i386/kernel/cpu/cpufreq/longhaul.c b/arch/i386/kernel/cpu/cpufreq/longhaul.c
index 1797ce7..43fcee4 100644
--- a/arch/i386/kernel/cpu/cpufreq/longhaul.c
+++ b/arch/i386/kernel/cpu/cpufreq/longhaul.c
@@ -245,8 +245,7 @@ static void longhaul_setstate(unsigned i
 
 	if (pr->flags.bm_control) {
  		/* Disable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
-				  ACPI_MTX_DO_NOT_LOCK);
+		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 	} else if (port22_en) {
 		/* Disable AGP and PCI arbiters */
 		outb(3, 0x22);
@@ -279,16 +278,14 @@ static void longhaul_setstate(unsigned i
 	 */
 	case TYPE_POWERSAVER:
 		/* Don't allow wakeup */
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0,
-				  ACPI_MTX_DO_NOT_LOCK);
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 		do_powersaver(cx->address, clock_ratio_index);
 		break;
 	}
 
 	if (pr->flags.bm_control) {
 		/* Enable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
-				  ACPI_MTX_DO_NOT_LOCK);
+		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 	} else if (port22_en) {
 		/* Enable arbiters */
 		outb(0, 0x22);
diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index 6b4bc99..f09d1aa 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -204,8 +204,7 @@ static acpi_status acpi_ev_fixed_event_i
 		if (acpi_gbl_fixed_event_info[i].enable_register_id != 0xFF) {
 			status =
 			    acpi_set_register(acpi_gbl_fixed_event_info[i].
-					      enable_register_id, 0,
-					      ACPI_MTX_LOCK);
+					      enable_register_id, 0);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -291,7 +290,7 @@ static u32 acpi_ev_fixed_event_dispatch(
 	/* Clear the status bit */
 
 	(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
-				status_register_id, 1, ACPI_MTX_DO_NOT_LOCK);
+				status_register_id, 1);
 
 	/*
 	 * Make sure we've got a handler.  If not, report an error.
@@ -299,8 +298,7 @@ static u32 acpi_ev_fixed_event_dispatch(
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
-					enable_register_id, 0,
-					ACPI_MTX_DO_NOT_LOCK);
+					enable_register_id, 0);
 
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event [%08X]",
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 484d219..1d7a327 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -495,7 +495,7 @@ acpi_status acpi_ev_release_global_lock(
 		if (pending) {
 			status =
 			    acpi_set_register(ACPI_BITREG_GLOBAL_LOCK_RELEASE,
-					      1, ACPI_MTX_LOCK);
+					      1);
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/events/evxfevnt.c
index 91e5f5b..a3d148e 100644
--- a/drivers/acpi/events/evxfevnt.c
+++ b/drivers/acpi/events/evxfevnt.c
@@ -157,7 +157,7 @@ acpi_status acpi_enable_event(u32 event,
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, 1, ACPI_MTX_LOCK);
+			      enable_register_id, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -166,7 +166,7 @@ acpi_status acpi_enable_event(u32 event,
 
 	status =
 	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, &value, ACPI_MTX_LOCK);
+			      enable_register_id, &value);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -356,14 +356,14 @@ acpi_status acpi_disable_event(u32 event
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, 0, ACPI_MTX_LOCK);
+			      enable_register_id, 0);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
 	status =
 	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, &value, ACPI_MTX_LOCK);
+			      enable_register_id, &value);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -409,7 +409,7 @@ acpi_status acpi_clear_event(u32 event)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      status_register_id, 1, ACPI_MTX_LOCK);
+			      status_register_id, 1);
 
 	return_ACPI_STATUS(status);
 }
@@ -498,7 +498,7 @@ acpi_status acpi_get_event_status(u32 ev
 
 	status =
 	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      status_register_id, event_status, ACPI_MTX_LOCK);
+			      status_register_id, event_status);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/hardware/hwacpi.c b/drivers/acpi/hardware/hwacpi.c
index 9c7df71..dbcc4c0 100644
--- a/drivers/acpi/hardware/hwacpi.c
+++ b/drivers/acpi/hardware/hwacpi.c
@@ -171,8 +171,7 @@ u32 acpi_hw_get_mode(void)
 		return_UINT32(ACPI_SYS_MODE_ACPI);
 	}
 
-	status =
-	    acpi_get_register(ACPI_BITREG_SCI_ENABLE, &value, ACPI_MTX_LOCK);
+	status = acpi_get_register(ACPI_BITREG_SCI_ENABLE, &value);
 	if (ACPI_FAILURE(status)) {
 		return_UINT32(ACPI_SYS_MODE_LEGACY);
 	}
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
index 9fe7adf..716e4ae 100644
--- a/drivers/acpi/hardware/hwregs.c
+++ b/drivers/acpi/hardware/hwregs.c
@@ -54,17 +54,15 @@ ACPI_MODULE_NAME("hwregs")
  *
  * FUNCTION:    acpi_hw_clear_acpi_status
  *
- * PARAMETERS:  Flags           - Lock the hardware or not
+ * PARAMETERS:  None
  *
- * RETURN:      none
+ * RETURN:      None
  *
  * DESCRIPTION: Clears all fixed and general purpose status bits
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
- * NOTE: TBD: Flags parameter is obsolete, to be removed
- *
  ******************************************************************************/
-acpi_status acpi_hw_clear_acpi_status(u32 flags)
+acpi_status acpi_hw_clear_acpi_status(void)
 {
 	acpi_status status;
 	acpi_cpu_flags lock_flags = 0;
@@ -253,18 +251,15 @@ struct acpi_bit_register_info *acpi_hw_g
  *
  * PARAMETERS:  register_id     - ID of ACPI bit_register to access
  *              return_value    - Value that was read from the register
- *              Flags           - Lock the hardware or not
  *
  * RETURN:      Status and the value read from specified Register. Value
  *              returned is normalized to bit0 (is shifted all the way right)
  *
  * DESCRIPTION: ACPI bit_register read function.
  *
- * NOTE: TBD: Flags parameter is obsolete, to be removed
- *
  ******************************************************************************/
 
-acpi_status acpi_get_register(u32 register_id, u32 * return_value, u32 flags)
+acpi_status acpi_get_register(u32 register_id, u32 * return_value)
 {
 	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
@@ -312,16 +307,13 @@ ACPI_EXPORT_SYMBOL(acpi_get_register)
  * PARAMETERS:  register_id     - ID of ACPI bit_register to access
  *              Value           - (only used on write) value to write to the
  *                                Register, NOT pre-normalized to the bit pos
- *              Flags           - Lock the hardware or not
  *
  * RETURN:      Status
  *
  * DESCRIPTION: ACPI Bit Register write function.
  *
- * NOTE: TBD: Flags parameter is obsolete, to be removed
- *
  ******************************************************************************/
-acpi_status acpi_set_register(u32 register_id, u32 value, u32 flags)
+acpi_status acpi_set_register(u32 register_id, u32 value)
 {
 	u32 register_value = 0;
 	struct acpi_bit_register_info *bit_reg_info;
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 6faa76b..7c96451 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -277,15 +277,14 @@ acpi_status asmlinkage acpi_enter_sleep_
 
 	/* Clear wake status */
 
-	status =
-	    acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_DO_NOT_LOCK);
+	status = acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
 	/* Clear all fixed and general purpose status bits */
 
-	status = acpi_hw_clear_acpi_status(ACPI_MTX_DO_NOT_LOCK);
+	status = acpi_hw_clear_acpi_status();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -398,8 +397,7 @@ acpi_status asmlinkage acpi_enter_sleep_
 	/* Wait until we enter sleep state */
 
 	do {
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value,
-					   ACPI_MTX_DO_NOT_LOCK);
+		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -432,13 +430,12 @@ acpi_status asmlinkage acpi_enter_sleep_
 
 	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state_s4bios);
 
-	status =
-	    acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_DO_NOT_LOCK);
+	status = acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
-	status = acpi_hw_clear_acpi_status(ACPI_MTX_DO_NOT_LOCK);
+	status = acpi_hw_clear_acpi_status();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -465,8 +462,7 @@ acpi_status asmlinkage acpi_enter_sleep_
 
 	do {
 		acpi_os_stall(1000);
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value,
-					   ACPI_MTX_DO_NOT_LOCK);
+		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -599,13 +595,11 @@ acpi_status acpi_leave_sleep_state(u8 sl
 
 	(void)
 	    acpi_set_register(acpi_gbl_fixed_event_info
-			      [ACPI_EVENT_POWER_BUTTON].enable_register_id, 1,
-			      ACPI_MTX_DO_NOT_LOCK);
+			      [ACPI_EVENT_POWER_BUTTON].enable_register_id, 1);
 
 	(void)
 	    acpi_set_register(acpi_gbl_fixed_event_info
-			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1,
-			      ACPI_MTX_DO_NOT_LOCK);
+			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1);
 
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 5aaf358..5f5a9c0 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -787,7 +787,7 @@ static int irqrouter_resume(struct sys_d
 
 
 	/* Make sure SCI is enabled again (Apple firmware bug?) */
-	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);
+	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1);
 
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4208ab7..b419586 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -187,8 +187,7 @@ acpi_processor_power_activate(struct acp
 		case ACPI_STATE_C3:
 			/* Disable bus master reload */
 			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
-				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0,
-						  ACPI_MTX_DO_NOT_LOCK);
+				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 			break;
 		}
 	}
@@ -198,8 +197,7 @@ acpi_processor_power_activate(struct acp
 	case ACPI_STATE_C3:
 		/* Enable bus master reload */
 		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1,
-					  ACPI_MTX_DO_NOT_LOCK);
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 		break;
 	}
 
@@ -287,12 +285,10 @@ static void acpi_processor_idle(void)
 
 		pr->power.bm_activity <<= diff;
 
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
-				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
+		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 		if (bm_status) {
 			pr->power.bm_activity |= 0x1;
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
-					  1, ACPI_MTX_DO_NOT_LOCK);
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
 		}
 		/*
 		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
@@ -404,8 +400,7 @@ static void acpi_processor_idle(void)
 				 * All CPUs are trying to go to C3
 				 * Disable bus master arbitration
 				 */
-				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
-						  ACPI_MTX_DO_NOT_LOCK);
+				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 			}
 		} else {
 			/* SMP with no shared cache... Invalidate cache  */
@@ -421,8 +416,7 @@ static void acpi_processor_idle(void)
 		if (pr->flags.bm_check) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
-			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
-					  ACPI_MTX_DO_NOT_LOCK);
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 		}
 
 #ifdef CONFIG_GENERIC_TIME
@@ -882,8 +876,7 @@ static void acpi_processor_power_verify_
 					  " for C3 to be enabled on SMP systems\n"));
 			return;
 		}
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD,
-				  0, ACPI_MTX_DO_NOT_LOCK);
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 	}
 
 	/*
diff --git a/include/acpi/achware.h b/include/acpi/achware.h
index f3e9a03..ae449f2 100644
--- a/include/acpi/achware.h
+++ b/include/acpi/achware.h
@@ -82,7 +82,7 @@ acpi_hw_low_level_read(u32 width,
 acpi_status
 acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address *reg);
 
-acpi_status acpi_hw_clear_acpi_status(u32 flags);
+acpi_status acpi_hw_clear_acpi_status(void);
 
 /*
  * hwgpe - GPE support
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4a5b14b..035a5a8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -306,9 +306,9 @@ acpi_resource_to_address64(struct acpi_r
 /*
  * Hardware (ACPI device) interfaces
  */
-acpi_status acpi_get_register(u32 register_id, u32 * return_value, u32 flags);
+acpi_status acpi_get_register(u32 register_id, u32 * return_value);
 
-acpi_status acpi_set_register(u32 register_id, u32 value, u32 flags);
+acpi_status acpi_set_register(u32 register_id, u32 value);
 
 acpi_status
 acpi_set_firmware_waking_vector(acpi_physical_address physical_address);
-- 
1.4.4.1
