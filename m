From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / ACPICA: Fix problems related with GPE reference counting
Date: Fri, 21 May 2010 00:11:01 +0200
Message-ID: <201005210011.01955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53212 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755163Ab0ETWJ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 May 2010 18:09:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>, Robert Moore <robert.moore@intel.com>

Hi,

The patch below needs some more testing, but I _think_ it should work.  It's
against 2.6.34 with some ACPICA changes that shouldn't interfere with it.
Tomorrow I'll rebase it on top of the current Linus' tree.

The problems are described in the changelog, as well as the changes to address
them.

Please tell me what you think.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

There are a few problems with the recently introduced GPE reference
counting mechanism.

First of all, acpi_set_gpe() won't enable wakeup-only GPEs,
because it uses acpi_ev_enable_gpe() that, in turn, calls
acpi_hw_write_gpe_enable_reg() that will only enable the GPE if its
bit is set in the register's enable_for_run.  Worse yet,
acpi_hw_write_gpe_enable_reg() always writes the entire
enable_for_run mask into the register, so in theory it may enable
more GPEs than just the one we want to enable (for example, it may
enable GPEs in the same register that were disabled by
acpi_hw_low_disable_gpe() previously).

Second, the enable_for_run and enable_for_wake masks of the GPE
registers only change when the GPEs' runtime_count and wakeup_count
fields change from zero to nonzero and the other way around, so it
doesn't make sense to update the enable_for_run and enable_for_wake
masks outside of acpi_enable_gpe() and acpi_disable_gpe().

To address these problems, call acpi_ev_update_gpe_enable_masks()
directly from acpi_enable_gpe() and acpi_disable_gpe() where the
GPE's runtime_count and wakeup_count counters change in such a
way that its register's enable_for_run and enable_for_wake masks have
to be updated.  Change acpi_hw_low_disable_gpe() into
acpi_hw_low_set_gpe() that can set as well as clear the appropriate
bit in the GPE's register and use it wherever necessary.  Modify
acpi_hw_write_gpe_enable_reg() so that it only sets the GPE bit
corresponding to its argument in the register and only if that
bit is set in the register's enable_for_run mask.  Finally, remove
acpi_ev_enable_gpe() and acpi_ev_disable_gpe() that aren't necessary
any more.

In addition to that, to reduce code duplication, move the computation
of a GPE's register bit mask to a separate function and call it
wherever that computation has to be carried out.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/achware.h  |    6 ++
 drivers/acpi/acpica/evgpe.c    |   86 ++---------------------------------
 drivers/acpi/acpica/evgpeblk.c |   13 ++++-
 drivers/acpi/acpica/evxfevnt.c |   27 ++++++++---
 drivers/acpi/acpica/hwgpe.c    |  100 ++++++++++++++++++++++++++++++++---------
 5 files changed, 121 insertions(+), 111 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-2.6/drivers/acpi/acpica/hwgpe.c
@@ -57,21 +57,45 @@ acpi_hw_enable_wakeup_gpe_block(struct a
 
 /******************************************************************************
  *
- * FUNCTION:	acpi_hw_low_disable_gpe
+ * FUNCTION:	acpi_hw_gpe_register_bit
+ *
+ * PARAMETERS:	gpe_event_info	    - Info block for the GPE
+ *		gpe_register_info   - Info block for the GPE register
+ *
+ * RETURN:	Status
+ *
+ * DESCRIPTION:	Compute the enable mask with one bit corresponding to the given
+ *		GPE set.
+ *
+ ******************************************************************************/
+
+u32 acpi_hw_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
+			     struct acpi_gpe_register_info *gpe_register_info)
+{
+	return (u32)1 << (gpe_event_info->gpe_number -
+				gpe_register_info->base_gpe_number);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:	acpi_hw_low_set_gpe
  *
  * PARAMETERS:	gpe_event_info	    - Info block for the GPE to be disabled
+ *		action		    - Enable or disable
  *
  * RETURN:	Status
  *
- * DESCRIPTION: Disable a single GPE in the enable register.
+ * DESCRIPTION: Enable or disable a single GPE in its enable register.
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info,
+				u8 action)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
 	u32 enable_mask;
+	u32 register_bit;
 
 	/* Get the info block for the entire GPE register */
 
@@ -80,6 +104,9 @@ acpi_status acpi_hw_low_disable_gpe(stru
 		return (AE_NOT_EXIST);
 	}
 
+	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+						gpe_register_info);
+
 	/* Get current value of the enable register that contains this GPE */
 
 	status = acpi_hw_read(&enable_mask, &gpe_register_info->enable_address);
@@ -87,11 +114,22 @@ acpi_status acpi_hw_low_disable_gpe(stru
 		return (status);
 	}
 
-	/* Clear just the bit that corresponds to this GPE */
+	/* Set ot clear just the bit that corresponds to this GPE */
+
+	switch (action) {
+	case ACPI_GPE_ENABLE:
+		ACPI_SET_BIT(enable_mask, register_bit);
+		break;
+
+	case ACPI_GPE_DISABLE:
+		ACPI_CLEAR_BIT(enable_mask, register_bit);
+		break;
+
+	default:
+		ACPI_ERROR((AE_INFO, "Invalid action\n"));
+		return (AE_BAD_PARAMETER);
+	}
 
-	ACPI_CLEAR_BIT(enable_mask, ((u32)1 <<
-				     (gpe_event_info->gpe_number -
-				      gpe_register_info->base_gpe_number)));
 
 	/* Write the updated enable mask */
 
@@ -118,6 +156,8 @@ acpi_hw_write_gpe_enable_reg(struct acpi
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
+	u32 enable_mask;
+	u32 register_bit;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -128,10 +168,21 @@ acpi_hw_write_gpe_enable_reg(struct acpi
 		return (AE_NOT_EXIST);
 	}
 
-	/* Write the entire GPE (runtime) enable register */
+	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+						gpe_register_info);
 
-	status = acpi_hw_write(gpe_register_info->enable_for_run,
-			       &gpe_register_info->enable_address);
+	/* Get current value of the enable register that contains this GPE */
+
+	status = acpi_hw_read(&enable_mask, &gpe_register_info->enable_address);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	if (register_bit & gpe_register_info->enable_for_run) {
+		ACPI_SET_BIT(enable_mask, register_bit);
+		status = acpi_hw_write(enable_mask,
+					&gpe_register_info->enable_address);
+	}
 
 	return (status);
 }
@@ -150,21 +201,28 @@ acpi_hw_write_gpe_enable_reg(struct acpi
 
 acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 {
+	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
-	u8 register_bit;
+	u32 register_bit;
 
 	ACPI_FUNCTION_ENTRY();
 
-	register_bit = (u8)(1 <<
-			    (gpe_event_info->gpe_number -
-			     gpe_event_info->register_info->base_gpe_number));
+	/* Get the info block for the entire GPE register */
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		return (AE_NOT_EXIST);
+	}
+
+	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+						gpe_register_info);
 
 	/*
 	 * Write a one to the appropriate bit in the status register to
 	 * clear this GPE.
 	 */
 	status = acpi_hw_write(register_bit,
-			       &gpe_event_info->register_info->status_address);
+				&gpe_register_info->status_address);
 
 	return (status);
 }
@@ -187,7 +245,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_e
 		       acpi_event_status * event_status)
 {
 	u32 in_byte;
-	u8 register_bit;
+	u32 register_bit;
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
 	acpi_event_status local_event_status = 0;
@@ -201,12 +259,12 @@ acpi_hw_get_gpe_status(struct acpi_gpe_e
 	/* Get the info block for the entire GPE register */
 
 	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		return (AE_NOT_EXIST);
+	}
 
-	/* Get the register bitmask for this GPE */
-
-	register_bit = (u8)(1 <<
-			    (gpe_event_info->gpe_number -
-			     gpe_event_info->register_info->base_gpe_number));
+	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+						gpe_register_info);
 
 	/* GPE currently enabled? (enabled for runtime?) */
 
Index: linux-2.6/drivers/acpi/acpica/achware.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/achware.h
+++ linux-2.6/drivers/acpi/acpica/achware.h
@@ -90,7 +90,11 @@ acpi_status acpi_hw_write_port(acpi_io_a
 /*
  * hwgpe - GPE support
  */
-acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+u32 acpi_hw_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
+			     struct acpi_gpe_register_info *gpe_register_info);
+
+acpi_status acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info,
+				u8 action);
 
 acpi_status
 acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -68,7 +68,7 @@ acpi_status
 acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
-	u8 register_bit;
+	u32 register_bit;
 
 	ACPI_FUNCTION_TRACE(ev_update_gpe_enable_masks);
 
@@ -77,9 +77,8 @@ acpi_ev_update_gpe_enable_masks(struct a
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	register_bit = (u8)
-	    (1 <<
-	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
+	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+						gpe_register_info);
 
 	ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake, register_bit);
 	ACPI_CLEAR_BIT(gpe_register_info->enable_for_run, register_bit);
@@ -95,77 +94,6 @@ acpi_ev_update_gpe_enable_masks(struct a
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_enable_gpe
- *
- * PARAMETERS:  gpe_event_info          - GPE to enable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Enable a GPE based on the GPE type
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_enable_gpe);
-
-	/* Make sure HW enable masks are updated */
-
-	status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
-
-	/* Clear the GPE (of stale events), then enable it */
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
-
-	/* Enable the requested GPE */
-	status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_disable_gpe
- *
- * PARAMETERS:  gpe_event_info          - GPE to disable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Disable a GPE based on the GPE type
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_disable_gpe);
-
-	/* Make sure HW enable masks are updated */
-
-	status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
-
-	/*
-	 * Even if we don't know the GPE type, make sure that we always
-	 * disable it. low_disable_gpe will just clear the enable bit for this
-	 * GPE and write it. It will not write out the current GPE enable mask,
-	 * since this may inadvertently enable GPEs too early, if a rogue GPE has
-	 * come in during ACPICA initialization - possibly as a result of AML or
-	 * other code that has enabled the GPE.
-	 */
-	status = acpi_hw_low_disable_gpe(gpe_event_info);
-	return_ACPI_STATUS(status);
-}
-
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ev_gpeblk_event_info
  *
  * PARAMETERS:  gpe_block           - GPE block to search
@@ -401,10 +329,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 		return_VOID;
 	}
 
-	/* Set the GPE flags for return to enabled state */
-
-	(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
-
 	/*
 	 * Take a snapshot of the GPE info for this level - we copy the info to
 	 * prevent a race condition with remove_handler/remove_block.
@@ -557,7 +481,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * Disable the GPE, so it doesn't keep firing before the method has a
 		 * chance to run (it runs asynchronously with interrupts enabled).
 		 */
-		status = acpi_ev_disable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[%2X]",
@@ -591,7 +515,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * Disable the GPE. The GPE will remain disabled until the ACPICA
 		 * Core Subsystem is restarted, or a handler is installed.
 		 */
-		status = acpi_ev_disable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[%2X]",
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -235,11 +235,17 @@ acpi_status acpi_set_gpe(acpi_handle gpe
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
-		status = acpi_ev_enable_gpe(gpe_event_info);
+		/* Clear the GPE (of stale events), then enable it */
+		status = acpi_hw_clear_gpe(gpe_event_info);
+		if (ACPI_FAILURE(status))
+			break;
+
+		/* Enable the requested GPE */
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 		break;
 
 	case ACPI_GPE_DISABLE:
-		status = acpi_ev_disable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		break;
 
 	default:
@@ -291,7 +297,10 @@ acpi_status acpi_enable_gpe(acpi_handle 
 
 	if (type & ACPI_GPE_TYPE_RUNTIME) {
 		if (++gpe_event_info->runtime_count == 1) {
-			status = acpi_ev_enable_gpe(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_SUCCESS(status))
+				status = acpi_hw_low_set_gpe(gpe_event_info,
+							     ACPI_GPE_ENABLE);
 			if (ACPI_FAILURE(status))
 				gpe_event_info->runtime_count--;
 		}
@@ -308,7 +317,7 @@ acpi_status acpi_enable_gpe(acpi_handle 
 		 * system into a sleep state.
 		 */
 		if (++gpe_event_info->wakeup_count == 1)
-			acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
 	}
 
 unlock_and_exit:
@@ -351,8 +360,12 @@ acpi_status acpi_disable_gpe(acpi_handle
 	}
 
 	if ((type & ACPI_GPE_TYPE_RUNTIME) && gpe_event_info->runtime_count) {
-		if (--gpe_event_info->runtime_count == 0)
-			status = acpi_ev_disable_gpe(gpe_event_info);
+		if (--gpe_event_info->runtime_count == 0) {
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_SUCCESS(status))
+				status = acpi_hw_low_set_gpe(gpe_event_info,
+							     ACPI_GPE_DISABLE);
+		}
 	}
 
 	if ((type & ACPI_GPE_TYPE_WAKE) && gpe_event_info->wakeup_count) {
@@ -361,7 +374,7 @@ acpi_status acpi_disable_gpe(acpi_handle
 		 * states, so we don't need to disable them here.
 		 */
 		if (--gpe_event_info->wakeup_count == 0)
-			acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
 	}
 
 unlock_and_exit:
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -1016,6 +1016,18 @@ acpi_ev_initialize_gpe_block(struct acpi
 			/* Get the info block for this particular GPE */
 			gpe_index = (acpi_size)i * ACPI_GPE_REGISTER_WIDTH + j;
 			gpe_event_info = &gpe_block->event_info[gpe_index];
+			gpe_number = gpe_index + gpe_block->block_base_number;
+
+			/*
+			 * Ensure that the register bit corresponding to this
+			 * GPE are clear in its register's enable masks.
+			 */
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_FAILURE(status)) {
+				ACPI_ERROR((AE_INFO, "Failed to update enable "
+					"masks for GPE %02X\n", gpe_number));
+				continue;
+			}
 
 			if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
 				wake_gpe_count++;
@@ -1026,7 +1038,6 @@ acpi_ev_initialize_gpe_block(struct acpi
 			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD))
 				continue;
 
-			gpe_number = gpe_index + gpe_block->block_base_number;
 			status = acpi_enable_gpe(gpe_device, gpe_number,
 						ACPI_GPE_TYPE_RUNTIME);
 			if (ACPI_FAILURE(status))
