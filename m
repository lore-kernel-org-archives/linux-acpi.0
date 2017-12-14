From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 1/3] ACPICA: Add new API to query wakeup reasons
Date: Thu, 14 Dec 2017 14:38:37 +0800
Message-ID: <fc3d7c98b8411c88950bef9fb56543fc7f16fda0.1513233415.git.lv.zheng@intel.com>
References: <cover.1513233415.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:28223 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbdLNGik (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 01:38:40 -0500
In-Reply-To: <cover.1513233415.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

From: Chen Yu <yu.c.chen@intel.com>

This patch adds a new API to be invoked right after resuming to query
wakeup reasons.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acevents.h  |   2 +
 drivers/acpi/acpica/acglobal.h  |   1 +
 drivers/acpi/acpica/achware.h   |   4 ++
 drivers/acpi/acpica/aclocal.h   |   1 +
 drivers/acpi/acpica/evevent.c   |  25 ++++++++++
 drivers/acpi/acpica/hwgpe.c     | 102 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwsleep.c   |  38 +++++++++++++++
 drivers/acpi/acpica/hwxfsleep.c |  23 +++++++++
 drivers/acpi/sleep.c            |   1 +
 include/acpi/acpixf.h           |   1 +
 10 files changed, 198 insertions(+)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index a2adfd4..007f877 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -53,6 +53,8 @@ acpi_status acpi_ev_install_xrupt_handlers(void);
 
 u32 acpi_ev_fixed_event_detect(void);
 
+void acpi_ev_save_wokenup_fixed_events(u8 save_flags);
+
 /*
  * evmisc
  */
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 95eed44..cefa574 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -272,6 +272,7 @@ ACPI_GLOBAL(acpi_gbl_event_handler, acpi_gbl_global_event_handler);
 ACPI_GLOBAL(void *, acpi_gbl_global_event_handler_context);
 ACPI_GLOBAL(struct acpi_fixed_event_handler,
 	    acpi_gbl_fixed_event_handlers[ACPI_NUM_FIXED_EVENTS]);
+ACPI_GLOBAL(u32, acpi_gbl_wokenup_fixed_events);
 
 extern struct acpi_fixed_event_info
     acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS];
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index cd722d8..b209c23 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -89,6 +89,8 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state);
 
 acpi_status acpi_hw_legacy_wake(u8 sleep_state);
 
+void acpi_hw_detect_wakeup_events(u8 is_wakeup);
+
 /*
  * hwesleep - sleep/wake support (Extended FADT-V5 sleep registers)
  */
@@ -140,6 +142,8 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block,
 				 void *context);
 
+acpi_status acpi_hw_save_wokenup_gpes(u8 save_flags);
+
 /*
  * hwpci - PCI configuration support
  */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index a56675f..ff1ed01 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -498,6 +498,7 @@ struct acpi_gpe_register_info {
 	u8 enable_for_run;	/* GPEs to keep enabled when running */
 	u8 mask_for_run;	/* GPEs to keep masked when running */
 	u8 enable_mask;		/* Current mask of enabled GPEs */
+	u8 wokenup;		/* GPEs flagged for the last resume */
 };
 
 /*
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index d3b6b31..70e0459 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -294,4 +294,29 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 		 handler) (acpi_gbl_fixed_event_handlers[event].context));
 }
 
+void acpi_ev_save_wokenup_fixed_events(u8 save_flags)
+{
+	u32 fixed_status;
+	u32 fixed_enable;
+
+	ACPI_FUNCTION_NAME(ev_save_wokenup_fixed_events);
+
+	/*
+	 * Read the fixed feature status and enable registers, as all the cases
+	 * depend on their values. Ignore errors here.
+	 */
+	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &fixed_status);
+	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
+			  "Wakeup Fixed Event Block: Enable %08X Status %08X\n",
+			  fixed_enable, fixed_status));
+
+	if (save_flags) {
+		acpi_gbl_wokenup_fixed_events = (fixed_status & fixed_enable);
+	} else {
+		acpi_gbl_wokenup_fixed_events = 0;
+	}
+}
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 09b6822..d52d7dd 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -58,6 +58,11 @@ static acpi_status
 acpi_hw_gpe_enable_write(u8 enable_mask,
 			 struct acpi_gpe_register_info *gpe_register_info);
 
+static acpi_status
+acpi_hw_save_wokenup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			       struct acpi_gpe_block_info *gpe_block,
+			       void *context);
+
 /******************************************************************************
  *
  * FUNCTION:	acpi_hw_get_gpe_register_bit
@@ -545,4 +550,101 @@ acpi_status acpi_hw_enable_all_wakeup_gpes(void)
 	return_ACPI_STATUS(status);
 }
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_save_wokenup_gpe_block
+ *
+ * PARAMETERS:  gpe_xrupt_info      - GPE Interrupt info
+ *              gpe_block           - Gpe Block info
+ *              context             - Pointing to a flag indicating whether
+ *                                    GPE status should be saved as wakeup
+ *                                    reasons
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Save all flagged GPEs as GPEs that have woken the system up.
+ *              This function should be invoked right after resuming.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_save_wokenup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			       struct acpi_gpe_block_info *gpe_block,
+			       void *context)
+{
+	u32 i;
+	acpi_status status;
+	struct acpi_gpe_register_info *gpe_register_info;
+	u32 status_reg;
+	u32 enable_reg;
+	u8 save_flags = *ACPI_CAST_PTR(u8, context);
+
+	ACPI_FUNCTION_NAME(hw_save_wokenup_gpe_block);
+
+	/* Examine each GPE Register within the block */
+
+	for (i = 0; i < gpe_block->register_count; i++) {
+		gpe_register_info = &gpe_block->register_info[i];
+
+		/* Read the Status Register */
+
+		status =
+		    acpi_hw_read(&status_reg,
+				 &gpe_register_info->status_address);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/* Read the Enable Register */
+
+		status =
+		    acpi_hw_read(&enable_reg,
+				 &gpe_register_info->enable_address);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
+				  "Read registers for wakeup GPE %02X-%02X: Status=%02X, Enable=%02X, "
+				  "RunEnable=%02X, WakeEnable=%02X\n",
+				  gpe_register_info->base_gpe_number,
+				  gpe_register_info->base_gpe_number +
+				  (ACPI_GPE_REGISTER_WIDTH - 1), status_reg,
+				  enable_reg, gpe_register_info->enable_for_run,
+				  gpe_register_info->enable_for_wake));
+
+		if (save_flags) {
+			gpe_register_info->wokenup =
+			    (u8)(status_reg & enable_reg);
+		} else {
+			gpe_register_info->wokenup = 0;
+		}
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_save_wokenup_gpes
+ *
+ * PARAMETERS:  save_flags          - Save enable/status flags
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Saved flagged GPEs right after being resumed
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_save_wokenup_gpes(u8 save_flags)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(hw_save_wokenup_gpes);
+
+	status =
+	    acpi_ev_walk_gpe_list(acpi_hw_save_wokenup_gpe_block, &save_flags);
+	return_ACPI_STATUS(status);
+}
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 1fe7387..4186b83 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -44,6 +44,7 @@
 
 #include <acpi/acpi.h>
 #include "accommon.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
@@ -51,6 +52,31 @@ ACPI_MODULE_NAME("hwsleep")
 #if (!ACPI_REDUCED_HARDWARE)	/* Entire module */
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_hw_detect_wakeup_events
+ *
+ * PARAMETERS:  is_wakeup           - Whether system is being woken up
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check the status of the platform wakeup events (GPEs or
+ *              fixed events). This can be invoked right before suspending or
+ *              right after resuming.
+ *
+ ******************************************************************************/
+void acpi_hw_detect_wakeup_events(u8 is_wakeup)
+{
+
+	ACPI_FUNCTION_NAME(hw_detect_wakeup_events);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
+			  "Detecting wakup GPEs/Events %s",
+			  is_wakeup ? "after resuming" : "before suspending"));
+	(void)acpi_hw_save_wokenup_gpes(is_wakeup);
+	(void)acpi_ev_save_wokenup_fixed_events(is_wakeup);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_hw_legacy_sleep
  *
  * PARAMETERS:  sleep_state         - Which sleep state to enter
@@ -61,6 +87,7 @@ ACPI_MODULE_NAME("hwsleep")
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
+
 acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 {
 	struct acpi_bit_register_info *sleep_type_reg_info;
@@ -159,6 +186,10 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 
+	/* Debugging purpose: record wakeup events before sleeping */
+
+	acpi_hw_detect_wakeup_events(FALSE);
+
 	/* Write #2: Write both SLP_TYP + SLP_EN */
 
 	status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
@@ -199,6 +230,13 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 
 	} while (!in_value);
 
+	/*
+	 * This may not be reached, as OSPM should have chosen to jump back
+	 * from FACS waking vector to a different point. Normally, where
+	 * acpi_enter_sleep_state() is invoked.
+	 */
+	acpi_hw_detect_wakeup_events(TRUE);
+
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index e5c095c..baa7028 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -452,3 +452,26 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_leave_sleep_state)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_detect_waekup_reasons
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Save platform wakeup reasons (flagged GPEs/fixed_events) right
+ *              after resuming.
+ *
+ ******************************************************************************/
+void acpi_detect_wakeup_reasons(void)
+{
+
+	ACPI_FUNCTION_TRACE(acpi_detect_wakeup_reasons);
+
+	acpi_hw_detect_wakeup_events(TRUE);
+	return_VOID;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_detect_wakeup_reasons)
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 15cd862..7c70c3c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -582,6 +582,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		if (error)
 			return error;
 		pr_info(PREFIX "Low-level resume complete\n");
+		acpi_detect_wakeup_reasons();
 		pm_set_resume_via_firmware();
 		break;
 	}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e02610a..c514edd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -891,6 +891,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_set_firmware_waking_vector
 				(acpi_physical_address physical_address,
 				 acpi_physical_address physical_address64))
+ACPI_EXTERNAL_RETURN_VOID(void acpi_detect_wakeup_reasons(void))
 /*
  * ACPI Timer interfaces
  */
-- 
2.7.4

