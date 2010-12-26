From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/33] ACPICA: Misc comments to minimize code divergence
Date: Sun, 26 Dec 2010 17:43:45 -0500
Message-ID: <eb371d4153b24096e489cceae7c9d005162371df.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51680 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0LZW64 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:56 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:55 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Modify/add some comments to minimize ACPICA/linux GPE code divergence.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/achware.h   |    2 +-
 drivers/acpi/acpica/evgpe.c     |   21 +++++++++++++--------
 drivers/acpi/acpica/evgpeblk.c  |   18 ++++++++----------
 drivers/acpi/acpica/evgpeinit.c |   24 ++++++++++++++++++++----
 drivers/acpi/acpica/evxfgpe.c   |   32 +++++++++++++++++++++-----------
 drivers/acpi/acpica/hwgpe.c     |   30 ++++++++++++++++++------------
 6 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 167470a..258d628 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -94,7 +94,7 @@ u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
 			     struct acpi_gpe_register_info *gpe_register_info);
 
 acpi_status
-acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action);
+acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action);
 
 acpi_status
 acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 3bcf5ef..7c339d3 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -104,7 +104,7 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Clear the given GPE from stale events and enable it.
+ * DESCRIPTION: Clear a GPE of stale events and enable it.
  *
  ******************************************************************************/
 acpi_status
@@ -142,7 +142,7 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  * FUNCTION:    acpi_ev_add_gpe_reference
  *
- * PARAMETERS:  gpe_event_info  - GPE to enable
+ * PARAMETERS:  gpe_event_info          - Add a reference to this GPE
  *
  * RETURN:      Status
  *
@@ -163,6 +163,9 @@ acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info
 
 	gpe_event_info->runtime_count++;
 	if (gpe_event_info->runtime_count == 1) {
+
+		/* Enable on first reference */
+
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
 			status = acpi_ev_enable_gpe(gpe_event_info);
@@ -180,7 +183,7 @@ acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info
  *
  * FUNCTION:    acpi_ev_remove_gpe_reference
  *
- * PARAMETERS:  gpe_event_info  - GPE to disable
+ * PARAMETERS:  gpe_event_info          - Remove a reference to this GPE
  *
  * RETURN:      Status
  *
@@ -201,6 +204,9 @@ acpi_status acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_i
 
 	gpe_event_info->runtime_count--;
 	if (!gpe_event_info->runtime_count) {
+
+		/* Disable on last reference */
+
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
 			status = acpi_hw_low_set_gpe(gpe_event_info,
@@ -386,7 +392,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 			}
 
 			ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
-					  "Read GPE Register at GPE%X: Status=%02X, Enable=%02X\n",
+					  "Read GPE Register at GPE%02X: Status=%02X, Enable=%02X\n",
 					  gpe_register_info->base_gpe_number,
 					  status_reg, enable_reg));
 
@@ -660,8 +666,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to clear GPE[0x%2X]",
-					gpe_number));
+					"Unable to clear GPE%02X", gpe_number));
 			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
 		}
 	}
@@ -720,7 +725,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 					 gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to queue handler for GPE[0x%2X] - event disabled",
+					"Unable to queue handler for GPE%2X - event disabled",
 					gpe_number));
 		}
 		break;
@@ -733,7 +738,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		 * a GPE to be enabled if it has no handler or method.
 		 */
 		ACPI_ERROR((AE_INFO,
-			    "No handler or method for GPE[0x%2X], disabling event",
+			    "No handler or method for GPE%02X, disabling event",
 			    gpe_number));
 
 		break;
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index e2e8164..9acb869 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -361,9 +361,9 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 
 	gpe_block->node = gpe_device;
 	gpe_block->gpe_count = (u16)(register_count * ACPI_GPE_REGISTER_WIDTH);
+	gpe_block->initialized = FALSE;
 	gpe_block->register_count = register_count;
 	gpe_block->block_base_number = gpe_block_base_number;
-	gpe_block->initialized = FALSE;
 
 	ACPI_MEMCPY(&gpe_block->block_address, gpe_block_address,
 		    sizeof(struct acpi_generic_address));
@@ -423,14 +423,12 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
  *
  * FUNCTION:    acpi_ev_initialize_gpe_block
  *
- * PARAMETERS:  gpe_device          - Handle to the parent GPE block
- *              gpe_block           - Gpe Block info
+ * PARAMETERS:  acpi_gpe_callback
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Initialize and enable a GPE block. First find and run any
- *              _PRT methods associated with the block, then enable the
- *              appropriate GPEs.
+ * DESCRIPTION: Initialize and enable a GPE block. Enable GPEs that have
+ *              associated methods.
  *              Note: Assumes namespace is locked.
  *
  ******************************************************************************/
@@ -450,8 +448,8 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	ACPI_FUNCTION_TRACE(ev_initialize_gpe_block);
 
 	/*
-	 * Ignore a null GPE block (e.g., if no GPE block 1 exists) and
-	 * GPE blocks that have been initialized already.
+	 * Ignore a null GPE block (e.g., if no GPE block 1 exists), and
+	 * any GPE blocks that have been initialized already.
 	 */
 	if (!gpe_block || gpe_block->initialized) {
 		return_ACPI_STATUS(AE_OK);
@@ -459,8 +457,8 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 	/*
 	 * Enable all GPEs that have a corresponding method and have the
-	 * ACPI_GPE_CAN_WAKE flag unset.  Any other GPEs within this block must
-	 * be enabled via the acpi_enable_gpe() interface.
+	 * ACPI_GPE_CAN_WAKE flag unset. Any other GPEs within this block
+	 * must be enabled via the acpi_enable_gpe() interface.
 	 */
 	gpe_enabled_count = 0;
 
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 223dba2..beb3675 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -45,11 +45,27 @@
 #include "accommon.h"
 #include "acevents.h"
 #include "acnamesp.h"
-#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evgpeinit")
 
+/*
+ * Note: History of _PRW support in ACPICA
+ *
+ * Originally (2000 - 2010), the GPE initialization code performed a walk of
+ * the entire namespace to execute the _PRW methods and detect all GPEs
+ * capable of waking the system.
+ *
+ * As of 10/2010, the _PRW method execution has been removed since it is
+ * actually unnecessary. The host OS must in fact execute all _PRW methods
+ * in order to identify the device/power-resource dependencies. We now put
+ * the onus on the host OS to identify the wake GPEs as part of this process
+ * and to inform ACPICA of these GPEs via the acpi_setup_gpe_for_wake interface. This
+ * not only reduces the complexity of the ACPICA initialization code, but in
+ * some cases (on systems with very large namespaces) it should reduce the
+ * kernel boot time as well.
+ */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_gpe_initialize
@@ -222,7 +238,7 @@ void acpi_ev_update_gpes(acpi_owner_id table_owner_id)
 	acpi_status status = AE_OK;
 
 	/*
-	 * 2) Find any _Lxx/_Exx GPE methods that have just been loaded.
+	 * Find any _Lxx/_Exx GPE methods that have just been loaded.
 	 *
 	 * Any GPEs that correspond to new _Lxx/_Exx methods are immediately
 	 * enabled.
@@ -235,9 +251,9 @@ void acpi_ev_update_gpes(acpi_owner_id table_owner_id)
 		return;
 	}
 
+	walk_info.count = 0;
 	walk_info.owner_id = table_owner_id;
 	walk_info.execute_by_owner_id = TRUE;
-	walk_info.count = 0;
 
 	/* Walk the interrupt level descriptor list */
 
@@ -298,7 +314,7 @@ void acpi_ev_update_gpes(acpi_owner_id table_owner_id)
  *                  xx     - is the GPE number [in HEX]
  *
  * If walk_info->execute_by_owner_id is TRUE, we only execute examine GPE methods
- *    with that owner.
+ * with that owner.
  *
  ******************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index fcf4a5c..416845b 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -55,13 +55,19 @@ ACPI_MODULE_NAME("evxfgpe")
  *
  * PARAMETERS:  None
  *
- * RETURN:      None
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Complete GPE initialization and enable all GPEs that have
+ *              associated _Lxx or _Exx methods and are not pointed to by any
+ *              device _PRW methods (this indicates that these GPEs are
+ *              generally intended for system or device wakeup. Such GPEs
+ *              have to be enabled directly when the devices whose _PRW
+ *              methods point to them are set up for wakeup signaling.)
  *
- * DESCRIPTION: Enable all GPEs that have associated _Lxx or _Exx methods and
- *              are not pointed to by any device _PRW methods indicating that
- *              these GPEs are generally intended for system or device wakeup
- *              (such GPEs have to be enabled directly when the devices whose
- *              _PRW methods point to them are set up for wakeup signaling).
+ * NOTE: Should be called after any GPEs are added to the system. Primarily,
+ * after the system _PRW methods have been run, but also after a GPE Block
+ * Device has been added or if any new GPE methods have been added via a
+ * dynamic table load.
  *
  ******************************************************************************/
 
@@ -252,7 +258,8 @@ ACPI_EXPORT_SYMBOL(acpi_setup_gpe_for_wake)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Set or clear the GPE's wakeup enable mask bit.
+ * DESCRIPTION: Set or clear the GPE's wakeup enable mask bit. The GPE must
+ *              already be marked as a WAKE GPE.
  *
  ******************************************************************************/
 
@@ -268,8 +275,10 @@ acpi_status acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 ac
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
-	/* Ensure that we have a valid GPE number */
-
+	/*
+	 * Ensure that we have a valid GPE number and that this GPE is in
+	 * fact a wake GPE
+	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (!gpe_event_info) {
 		status = AE_BAD_PARAMETER;
@@ -366,7 +375,7 @@ ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Get status of an event (general purpose)
+ * DESCRIPTION: Get the current status of a GPE (signalled/not_signalled)
  *
  ******************************************************************************/
 acpi_status
@@ -476,7 +485,8 @@ ACPI_EXPORT_SYMBOL(acpi_enable_all_runtime_gpes)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Create and Install a block of GPE registers
+ * DESCRIPTION: Create and Install a block of GPE registers. The GPEs are not
+ *              enabled here.
  *
  ******************************************************************************/
 acpi_status
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 7c6d485..85c3cbd 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -62,10 +62,10 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  * PARAMETERS:	gpe_event_info	    - Info block for the GPE
  *		gpe_register_info   - Info block for the GPE register
  *
- * RETURN:	Status
+ * RETURN:	Register mask with a one in the GPE bit position
  *
- * DESCRIPTION:	Compute GPE enable mask with one bit corresponding to the given
- *		GPE set.
+ * DESCRIPTION: Compute the register mask for this GPE. One bit is set in the
+ *              correct position for the input GPE.
  *
  ******************************************************************************/
 
@@ -85,12 +85,12 @@ u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
  *
  * RETURN:	Status
  *
- * DESCRIPTION: Enable or disable a single GPE in its enable register.
+ * DESCRIPTION: Enable or disable a single GPE in the parent enable register.
  *
  ******************************************************************************/
 
 acpi_status
-acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
+acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
@@ -113,14 +113,20 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 		return (status);
 	}
 
-	/* Set ot clear just the bit that corresponds to this GPE */
+	/* Set or clear just the bit that corresponds to this GPE */
 
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 	switch (action) {
 	case ACPI_GPE_CONDITIONAL_ENABLE:
-		if (!(register_bit & gpe_register_info->enable_for_run))
+
+		/* Only enable if the enable_for_run bit is set */
+
+		if (!(register_bit & gpe_register_info->enable_for_run)) {
 			return (AE_BAD_PARAMETER);
+		}
+
+		/*lint -fallthrough */
 
 	case ACPI_GPE_ENABLE:
 		ACPI_SET_BIT(enable_mask, register_bit);
@@ -131,7 +137,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Invalid action\n"));
+		ACPI_ERROR((AE_INFO, "Invalid GPE Action, %u\n", action));
 		return (AE_BAD_PARAMETER);
 	}
 
@@ -168,13 +174,13 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 		return (AE_NOT_EXIST);
 	}
 
-	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
-						gpe_register_info);
-
 	/*
 	 * Write a one to the appropriate bit in the status register to
 	 * clear this GPE.
 	 */
+	register_bit =
+	    acpi_hw_get_gpe_register_bit(gpe_event_info, gpe_register_info);
+
 	status = acpi_hw_write(register_bit,
 			       &gpe_register_info->status_address);
 
@@ -201,8 +207,8 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 	u32 in_byte;
 	u32 register_bit;
 	struct acpi_gpe_register_info *gpe_register_info;
-	acpi_status status;
 	acpi_event_status local_event_status = 0;
+	acpi_status status;
 
 	ACPI_FUNCTION_ENTRY();
 
-- 
1.7.3.3.557.gb5c17

