From: Len Brown <lenb@kernel.org>
Subject: [PATCH 83/140] ACPICA: Remove obsolete Flags parameter.
Date: Wed,  7 Feb 2007 13:51:37 -0500
Message-ID: <11708744971522-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <d8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4.1170873817.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:37868 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422793AbXBGSy7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:59 -0500
In-Reply-To: <11708744962247-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Remove flags parameter for acpi_{get,set}_register().
It is no longer necessary now that these functions use a
spinlock for mutual exclusion.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evevent.c   |    8 +++-----
 drivers/acpi/events/evmisc.c    |    2 +-
 drivers/acpi/events/evxfevnt.c  |   12 ++++++------
 drivers/acpi/hardware/hwacpi.c  |    3 +--
 drivers/acpi/hardware/hwregs.c  |   18 +++++-------------
 drivers/acpi/hardware/hwsleep.c |   22 ++++++++--------------
 drivers/acpi/pci_link.c         |    2 +-
 drivers/acpi/processor_idle.c   |   21 +++++++--------------
 include/acpi/achware.h          |    2 +-
 include/acpi/acpixf.h           |    4 ++--
 10 files changed, 35 insertions(+), 59 deletions(-)

diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index 6b4bc99..f09d1aa 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -204,8 +204,7 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 		if (acpi_gbl_fixed_event_info[i].enable_register_id != 0xFF) {
 			status =
 			    acpi_set_register(acpi_gbl_fixed_event_info[i].
-					      enable_register_id, 0,
-					      ACPI_MTX_LOCK);
+					      enable_register_id, 0);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -291,7 +290,7 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	/* Clear the status bit */
 
 	(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
-				status_register_id, 1, ACPI_MTX_DO_NOT_LOCK);
+				status_register_id, 1);
 
 	/*
 	 * Make sure we've got a handler.  If not, report an error.
@@ -299,8 +298,7 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
-					enable_register_id, 0,
-					ACPI_MTX_DO_NOT_LOCK);
+					enable_register_id, 0);
 
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event [%08X]",
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 21449f3..3bacede 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -493,7 +493,7 @@ acpi_status acpi_ev_release_global_lock(void)
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
@@ -157,7 +157,7 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, 1, ACPI_MTX_LOCK);
+			      enable_register_id, 1);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -166,7 +166,7 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 
 	status =
 	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      enable_register_id, &value, ACPI_MTX_LOCK);
+			      enable_register_id, &value);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -356,14 +356,14 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
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
@@ -498,7 +498,7 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 
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
@@ -253,18 +251,15 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
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
@@ -277,15 +277,14 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
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
@@ -398,8 +397,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	/* Wait until we enter sleep state */
 
 	do {
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value,
-					   ACPI_MTX_DO_NOT_LOCK);
+		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -432,13 +430,12 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 
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
@@ -465,8 +462,7 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 
 	do {
 		acpi_os_stall(1000);
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value,
-					   ACPI_MTX_DO_NOT_LOCK);
+		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -599,13 +595,11 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
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
index 481e633..662e429 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -785,7 +785,7 @@ static int irqrouter_resume(struct sys_device *dev)
 
 
 	/* Make sure SCI is enabled again (Apple firmware bug?) */
-	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);
+	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1);
 
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9fa3d39..db21dda 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -187,8 +187,7 @@ acpi_processor_power_activate(struct acpi_processor *pr,
 		case ACPI_STATE_C3:
 			/* Disable bus master reload */
 			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
-				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0,
-						  ACPI_MTX_DO_NOT_LOCK);
+				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 			break;
 		}
 	}
@@ -198,8 +197,7 @@ acpi_processor_power_activate(struct acpi_processor *pr,
 	case ACPI_STATE_C3:
 		/* Enable bus master reload */
 		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1,
-					  ACPI_MTX_DO_NOT_LOCK);
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 		break;
 	}
 
@@ -291,12 +289,10 @@ static void acpi_processor_idle(void)
 
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
@@ -411,8 +407,7 @@ static void acpi_processor_idle(void)
 				 * All CPUs are trying to go to C3
 				 * Disable bus master arbitration
 				 */
-				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
-						  ACPI_MTX_DO_NOT_LOCK);
+				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 			}
 		} else {
 			/* SMP with no shared cache... Invalidate cache  */
@@ -428,8 +423,7 @@ static void acpi_processor_idle(void)
 		if (pr->flags.bm_check) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
-			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
-					  ACPI_MTX_DO_NOT_LOCK);
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 		}
 
 #ifdef CONFIG_GENERIC_TIME
@@ -890,8 +884,7 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
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
index f4b0a81..9c26400 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -312,9 +312,9 @@ acpi_resource_to_address64(struct acpi_resource *resource,
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
1.5.0.rc3.39.gec804
