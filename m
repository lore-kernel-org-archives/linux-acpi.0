From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPICA: Events: Introduce acpi_block_gpe()/acpi_unblock_gpe()/acpi_control_gpe_handling() to allow administrative GPE enabling/disabling
Date: Mon, 16 May 2016 17:11:11 +0800
Message-ID: <216c54dbfd2be7ab949cd16afffb84c45900f1d9.1463389639.git.lv.zheng@intel.com>
References: <cover.1463389639.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16504 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbcEPJLQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 May 2016 05:11:16 -0400
In-Reply-To: <cover.1463389639.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

There is a facility in Linux, developers can manage GPE enabling/disabling
through /sys/firmware/acpi/interrupts/gpexx. This is mainly for debugging
purposes. Many users expect to use this facility to implement quirks to
disable specific GPEs when there is a gap in Linux causing GPE flood.
This is not working correctly because currently this facility invokes
enabling/disabling counting based GPE driver APIs:
 acpi_enable_gpe()/acpi_disable_gpe()
and the GPE drivers can still affect the count to mess up the GPE
management purposes.

This patch introduces acpi_block_gpe()/acpi_unblock_gpe() to be used in such
situation instead of acpi_enable_gpe()/acpi_disable_gpe().

The idea to implement this is to replace the GPE register EN bit with the
managed value, block EN set/clear operations but record the operation
results in blocked_enabled, so that after the managed state is removed,
restore the saved blocked_enabled back to the GPE register EN bit.

Now OSPMs should be able to use this facility to generate quirks. ACPICA
BZ 1102.

This facility can also be used by the administrator to control the GPE
handling mode during the runtime when the driver is capable of handling the
GPE in both the interrupt mode and the polling mode (for example, the Linux
EC driver). acpi_control_gpe_handling() is offered for this purpose. Lv Zheng.

Link: https://bugs.acpica.org/show_bug.cgi?id=1102
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acevents.h |    3 +
 drivers/acpi/acpica/aclocal.h  |    1 +
 drivers/acpi/acpica/evgpe.c    |   84 ++++++++++++++++++++++++
 drivers/acpi/acpica/evxfgpe.c  |  142 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c    |   24 ++++++-
 include/acpi/acpixf.h          |   23 +++++--
 include/acpi/actypes.h         |   85 +++++++++++++++++++-----
 7 files changed, 336 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 77af91c..3a6e4db 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -86,6 +86,9 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
+acpi_ev_manage_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action);
+
+acpi_status
 acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 13331d7..17a6834 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -484,6 +484,7 @@ struct acpi_gpe_event_info {
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
 	u8 runtime_count;	/* References to a run GPE */
+	u8 blocked_enabled;	/* GPE should be enabled but blocked */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 4b4949c..f821bdd 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -130,6 +130,90 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_manage_gpe
+ *
+ * PARAMETERS:  gpe_event_info          - GPE to force enabling/disabling
+ *              action                  - ACPI_GPE_ENABLE, ACPI_GPE_DISABLE or
+ *                                        ACPI_GPE_UNMANAGE
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Unconditionally enable or disable an individual GPE for the
+ *              administrative purposes during the runtime.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ev_manage_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
+{
+	acpi_status status;
+	acpi_event_status event_status;
+
+	ACPI_FUNCTION_TRACE(ev_manage_gpe);
+
+	/* Perform the action */
+
+	switch (action) {
+	case ACPI_GPE_ENABLE:
+	case ACPI_GPE_DISABLE:
+
+		if (!(gpe_event_info->flags & ACPI_GPE_MANAGED_FLAG_MASK)) {
+			status =
+			    acpi_hw_get_gpe_status(gpe_event_info,
+						   &event_status);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
+			if (event_status & ACPI_EVENT_FLAG_ENABLE_SET) {
+				gpe_event_info->blocked_enabled = TRUE;
+			} else {
+				gpe_event_info->blocked_enabled = FALSE;
+			}
+		}
+
+		/* Reset flags so that acpi_hw_low_set_gpe() can take effective */
+
+		gpe_event_info->flags &= ~ACPI_GPE_MANAGED_FLAG_MASK;
+		if (action == ACPI_GPE_ENABLE) {
+			(void)acpi_hw_low_set_gpe(gpe_event_info,
+						  ACPI_GPE_ENABLE);
+			gpe_event_info->flags |= ACPI_GPE_MANAGED_ENABLED;
+		} else {
+			(void)acpi_hw_low_set_gpe(gpe_event_info,
+						  ACPI_GPE_DISABLE);
+			gpe_event_info->flags |= ACPI_GPE_MANAGED_DISABLED;
+		}
+		break;
+
+	case ACPI_GPE_UNMANAGE:
+
+		if (!(gpe_event_info->flags & ACPI_GPE_MANAGED_FLAG_MASK)) {
+			return_ACPI_STATUS(AE_BAD_PARAMETER);
+		}
+
+		/* Reset flags so that acpi_hw_low_set_gpe() can take effective */
+
+		gpe_event_info->flags &= ~ACPI_GPE_MANAGED_FLAG_MASK;
+		if (gpe_event_info->blocked_enabled) {
+			(void)acpi_hw_low_set_gpe(gpe_event_info,
+						  ACPI_GPE_ENABLE);
+		} else {
+			(void)acpi_hw_low_set_gpe(gpe_event_info,
+						  ACPI_GPE_DISABLE);
+		}
+		gpe_event_info->blocked_enabled = FALSE;
+		break;
+
+	default:
+
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_add_gpe_reference
  *
  * PARAMETERS:  gpe_event_info          - Add a reference to this GPE
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 17cfef7..3ad8fa9 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -257,6 +257,148 @@ ACPI_EXPORT_SYMBOL(acpi_set_gpe)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_block_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Unconditionally disable an individual GPE.
+ *              This API is typically used by the system administrator to
+ *              block the GPE enabling, ex., prevent the GPE flooding.
+ *
+ ******************************************************************************/
+acpi_status acpi_block_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_block_gpe);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	status = acpi_ev_manage_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_block_gpe)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_unblock_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Stop unconditional GPE disabling.
+ *              This API reverts acpi_block_gpe().
+ *
+ ******************************************************************************/
+acpi_status acpi_unblock_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_unblock_gpe);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	status = acpi_ev_manage_gpe(gpe_event_info, ACPI_GPE_UNMANAGE);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_unblock_gpe)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_control_gpe_handling
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *              use_interrupt_mode  - Allow the GPE to be dispatched in the
+ *                                    interrupt mode
+ *              use_polling_mode    - Allow the GPE to be dispatched in the
+ *                                    polling mode
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Switch the GPE handling mode between the interrupt only mode,
+ *              the polling only mode and the interrupt/polling adaptive mode.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_control_gpe_handling(acpi_handle gpe_device,
+			  u32 gpe_number,
+			  u8 use_interrupt_mode, u8 use_polling_mode)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
+	acpi_cpu_flags flags;
+	u8 action;
+
+	ACPI_FUNCTION_TRACE(acpi_control_gpe_handling);
+
+	if (!use_interrupt_mode && !use_polling_mode) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	/* Pick up and peform the correct action */
+
+	action = ACPI_GPE_UNMANAGE;
+	if (!use_interrupt_mode) {
+		action = ACPI_GPE_DISABLE;
+	}
+	if (!use_polling_mode) {
+		action = ACPI_GPE_ENABLE;
+	}
+	status = acpi_ev_manage_gpe(gpe_event_info, action);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_control_gpe_handling)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_mark_gpe_for_wake
  *
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index bdecd5e..8cdddbe 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -98,7 +98,7 @@ acpi_status
 acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	u32 enable_mask;
 	u32 register_bit;
 
@@ -148,9 +148,21 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 		return (AE_BAD_PARAMETER);
 	}
 
-	/* Write the updated enable mask */
+	/* Check if there is an administrative GPE enabling/disabling */
 
-	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
+	if (gpe_event_info->flags & ACPI_GPE_MANAGED_FLAG_MASK) {
+		if (enable_mask & register_bit) {
+			gpe_event_info->blocked_enabled = TRUE;
+		} else {
+			gpe_event_info->blocked_enabled = FALSE;
+		}
+	} else {
+		/* Write the updated enable mask */
+
+		status =
+		    acpi_hw_write(enable_mask,
+				  &gpe_register_info->enable_address);
+	}
 	return (status);
 }
 
@@ -228,6 +240,12 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		local_event_status |= ACPI_EVENT_FLAG_HAS_HANDLER;
 	}
 
+	/* GPE currently managed? (enabled/disabled by the system admin?) */
+
+	if (gpe_event_info->flags & ACPI_GPE_MANAGED_FLAG_MASK) {
+		local_event_status |= ACPI_EVENT_FLAG_MANAGED;
+	}
+
 	/* Get the info block for the entire GPE register */
 
 	gpe_register_info = gpe_event_info->register_info;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4e4c214..a0a6544 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -732,15 +732,28 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						u32 gpe_number))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_mark_gpe_for_wake(acpi_handle gpe_device,
-						       u32 gpe_number))
+				acpi_block_gpe(acpi_handle gpe_device,
+					       u32 gpe_number))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_unblock_gpe(acpi_handle gpe_device,
+						 u32 gpe_number))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_setup_gpe_for_wake(acpi_handle
-							parent_device,
-							acpi_handle gpe_device,
+				acpi_control_gpe_handling(acpi_handle
+							  gpe_device,
+							  u32 gpe_number,
+							  u8 use_interrupt_mode,
+							  u8 use_polling_mode))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_mark_gpe_for_wake(acpi_handle gpe_device,
 							u32 gpe_number))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_setup_gpe_for_wake(acpi_handle
+							 parent_device,
+							 acpi_handle gpe_device,
+							 u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_set_gpe_wake_mask(acpi_handle gpe_device,
 							u32 gpe_number,
 							u8 action))
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index cb389ef..9f841f2 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -732,16 +732,17 @@ typedef u32 acpi_event_type;
  * The encoding of acpi_event_status is illustrated below.
  * Note that a set bit (1) indicates the property is TRUE
  * (e.g. if bit 0 is set then the event is enabled).
- * +-------------+-+-+-+-+-+
- * |   Bits 31:5 |4|3|2|1|0|
- * +-------------+-+-+-+-+-+
- *          |     | | | | |
- *          |     | | | | +- Enabled?
- *          |     | | | +--- Enabled for wake?
- *          |     | | +----- Status bit set?
- *          |     | +------- Enable bit set?
- *          |     +--------- Has a handler?
- *          +--------------- <Reserved>
+ * +-------------+-+-+-+-+-+-+
+ * |   Bits 31:6 |5|4|3|2|1|0|
+ * +-------------+-+-+-+-+-+-+
+ *          |     | | | | | |
+ *          |     | | | | | +- Enabled?
+ *          |     | | | | +--- Enabled for wake?
+ *          |     | | | +----- Status bit set?
+ *          |     | | +------- Enable bit set?
+ *          |     | +--------- Has a handler?
+ *          |     +----------- Enabling/disabling forced?
+ *          +----------------- <Reserved>
  */
 typedef u32 acpi_event_status;
 
@@ -751,6 +752,7 @@ typedef u32 acpi_event_status;
 #define ACPI_EVENT_FLAG_STATUS_SET      (acpi_event_status) 0x04
 #define ACPI_EVENT_FLAG_ENABLE_SET      (acpi_event_status) 0x08
 #define ACPI_EVENT_FLAG_HAS_HANDLER     (acpi_event_status) 0x10
+#define ACPI_EVENT_FLAG_MANAGED         (acpi_event_status) 0x20
 #define ACPI_EVENT_FLAG_SET             ACPI_EVENT_FLAG_STATUS_SET
 
 /* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
@@ -758,17 +760,20 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
 #define ACPI_GPE_CONDITIONAL_ENABLE     2
+#define ACPI_GPE_UNMANAGE               3
 
 /*
  * GPE info flags - Per GPE
- * +-------+-+-+---+
- * |  7:5  |4|3|2:0|
- * +-------+-+-+---+
- *     |    | |  |
- *     |    | |  +-- Type of dispatch:to method, handler, notify, or none
- *     |    | +----- Interrupt type: edge or level triggered
- *     |    +------- Is a Wake GPE
- *     +------------ <Reserved>
+ * +-+-+-+-+-+---+
+ * |7|6|5|4|3|2:0|
+ * +-+-+-+-+-+---+
+ *  | | | | |  |
+ *  | | | | |  +-- Type of dispatch:to method, handler, notify, or none
+ *  | | | | +----- Interrupt type: edge or level triggered
+ *  | | | +------- Is a Wake GPE
+ *  | | +--------- Force GPE enabling
+ *  | +----------- Force GPE disabling
+ *  +------------- <Reserved>
  */
 #define ACPI_GPE_DISPATCH_NONE          (u8) 0x00
 #define ACPI_GPE_DISPATCH_METHOD        (u8) 0x01
@@ -785,6 +790,50 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_CAN_WAKE               (u8) 0x10
 
 /*
+ * Flags used by the GPE management APIs
+ *
+ * The GPE management APIs are not implemented for the GPE drivers. It is
+ * designed for providing the management purposes out of the GPE drivers'
+ * awareness. The GPE driver APIs should still be working as expected
+ * during the period the GPE management purposes are applied. There are 2
+ * use cases for the flags:
+ *
+ * 1. Prevent the GPE flooding
+ *    These flags can be used to control how the GPE is dispatched by the
+ *    event dispatcher. Note that the ACPI_GPE_MANAGED_DISABLED can also be
+ *    used to prevent the GPE flooding that cannot be prevented due to the
+ *    ACPI_GPE_DISPATCH_NONE sanity check. This kind of the GPE flooding
+ *    happens on the GPE where there is a _Lxx/_Exx prepared by the BIOS
+ *    but the OSPM still cannot handle it correctly by executing the
+ *    method. Such kind of incapability is mostly because of the feature
+ *    gaps in the OSPM:
+ *    ACPI_GPE_MANAGED_ENABLED:  force the event dispatcher to always
+ *                               enable the GPE
+ *    ACPI_GPE_MANAGED_DISABLED: force the event dispatcher to always
+ *                               disable the GPE
+ *                               prevent the GPE from flooding
+ *    acpi_block_gpe()/acpi_unblock_gpe() are the APIs offering the GPE
+ *    flooding prevention feature.
+ *
+ * 2. Control the GPE handling mode
+ *    A GPE driver may be able to handle the GPE both in the interrupt mode
+ *    and in the polling mode. Since the polling mode is a mechanism
+ *    implemented by the driver itself and is not controlled by the event
+ *    dispatcher, this mechanism can be used to switch between the
+ *    interrupt mode (dispatched via the event dispatcher) and the polling
+ *    mode (implemented by the GPE drivers):
+ *    ACPI_GPE_MANAGED_ENABLED:  force the driver to use the interrupt mode
+ *    ACPI_GPE_MANAGED_DISABLED: force the driver to use the polling mode
+ *    None:                      allow the driver to use the
+ *                               interrupt/polling adaptive mode
+ *    acpi_control_gpe_handling() is the API offering the GPE handling mode
+ *    switch feature.
+ */
+#define ACPI_GPE_MANAGED_ENABLED        (u8) 0x20
+#define ACPI_GPE_MANAGED_DISABLED       (u8) 0x40
+#define ACPI_GPE_MANAGED_FLAG_MASK      (u8) 0x60
+
+/*
  * Flags for GPE and Lock interfaces
  */
 #define ACPI_NOT_ISR                    0x1
-- 
1.7.10

