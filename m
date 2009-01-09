From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/94] ACPICA: Reformat comments, no functional changes
Date: Fri, 09 Jan 2009 04:26:30 -0500
Message-ID: <9f15fc666ef54afc7aff31dfa31edecf00e0d81a.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbZAIJ2f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:35 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD7000TS6ANQ1YC@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:01 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Reformat comments to use fewer lines.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evevent.c  |   14 ++--
 drivers/acpi/events/evgpe.c    |   36 ++++++------
 drivers/acpi/events/evgpeblk.c |   38 ++++++------
 drivers/acpi/events/evmisc.c   |   29 ++++-----
 drivers/acpi/events/evregion.c |  133 +++++++++++++++++++---------------------
 drivers/acpi/events/evrgnini.c |   41 ++++++-------
 drivers/acpi/events/evsci.c    |   10 +--
 drivers/acpi/events/evxface.c  |    2 +-
 drivers/acpi/events/evxfevnt.c |   12 ++--
 9 files changed, 152 insertions(+), 163 deletions(-)

diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index c56c5c6..6ddf938 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -72,8 +72,8 @@ acpi_status acpi_ev_initialize_events(void)
 
 	/*
 	 * Initialize the Fixed and General Purpose Events. This is done prior to
-	 * enabling SCIs to prevent interrupts from occurring before the handlers are
-	 * installed.
+	 * enabling SCIs to prevent interrupts from occurring before the handlers
+	 * are installed.
 	 */
 	status = acpi_ev_fixed_event_initialize();
 	if (ACPI_FAILURE(status)) {
@@ -192,8 +192,8 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 	acpi_status status;
 
 	/*
-	 * Initialize the structure that keeps track of fixed event handlers
-	 * and enable the fixed events.
+	 * Initialize the structure that keeps track of fixed event handlers and
+	 * enable the fixed events.
 	 */
 	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
 		acpi_gbl_fixed_event_handlers[i].handler = NULL;
@@ -237,7 +237,7 @@ u32 acpi_ev_fixed_event_detect(void)
 
 	/*
 	 * Read the fixed feature status and enable registers, as all the cases
-	 * depend on their values.  Ignore errors here.
+	 * depend on their values. Ignore errors here.
 	 */
 	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &fixed_status);
 	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
@@ -291,8 +291,8 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 				status_register_id, 1);
 
 	/*
-	 * Make sure we've got a handler.  If not, report an error.
-	 * The event is disabled to prevent further interrupts.
+	 * Make sure we've got a handler. If not, report an error. The event is
+	 * disabled to prevent further interrupts.
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index f45c74f..12b49d3 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -125,7 +125,7 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info,
 	    (1 <<
 	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
 
-	/* 1) Disable case.  Simply clear all enable bits */
+	/* 1) Disable case. Simply clear all enable bits */
 
 	if (type == ACPI_GPE_DISABLE) {
 		ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake,
@@ -134,7 +134,7 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* 2) Enable case.  Set/Clear the appropriate enable bits */
+	/* 2) Enable case. Set/Clear the appropriate enable bits */
 
 	switch (gpe_event_info->flags & ACPI_GPE_TYPE_MASK) {
 	case ACPI_GPE_TYPE_WAKE:
@@ -295,7 +295,7 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  * FUNCTION:    acpi_ev_get_gpe_event_info
  *
- * PARAMETERS:  gpe_device          - Device node.  NULL for GPE0/GPE1
+ * PARAMETERS:  gpe_device          - Device node. NULL for GPE0/GPE1
  *              gpe_number          - Raw GPE number
  *
  * RETURN:      A GPE event_info struct. NULL if not a valid GPE
@@ -372,7 +372,7 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
  *
  * RETURN:      INTERRUPT_HANDLED or INTERRUPT_NOT_HANDLED
  *
- * DESCRIPTION: Detect if any GP events have occurred.  This function is
+ * DESCRIPTION: Detect if any GP events have occurred. This function is
  *              executed at interrupt level.
  *
  ******************************************************************************/
@@ -400,8 +400,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 
 	/*
 	 * We need to obtain the GPE lock for both the data structs and registers
-	 * Note: Not necessary to obtain the hardware lock, since the GPE registers
-	 * are owned by the gpe_lock.
+	 * Note: Not necessary to obtain the hardware lock, since the GPE
+	 * registers are owned by the gpe_lock.
 	 */
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
@@ -410,9 +410,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 	gpe_block = gpe_xrupt_list->gpe_block_list_head;
 	while (gpe_block) {
 		/*
-		 * Read all of the 8-bit GPE status and enable registers
-		 * in this GPE block, saving all of them.
-		 * Find all currently active GP events.
+		 * Read all of the 8-bit GPE status and enable registers in this GPE
+		 * block, saving all of them. Find all currently active GP events.
 		 */
 		for (i = 0; i < gpe_block->register_count; i++) {
 
@@ -527,8 +526,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	(void)acpi_ev_enable_gpe(gpe_event_info, FALSE);
 
 	/*
-	 * Take a snapshot of the GPE info for this level - we copy the
-	 * info to prevent a race condition with remove_handler/remove_block.
+	 * Take a snapshot of the GPE info for this level - we copy the info to
+	 * prevent a race condition with remove_handler/remove_block.
 	 */
 	ACPI_MEMCPY(&local_gpe_event_info, gpe_event_info,
 		    sizeof(struct acpi_gpe_event_info));
@@ -539,8 +538,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	}
 
 	/*
-	 * Must check for control method type dispatch one more
-	 * time to avoid race with ev_gpe_install_handler
+	 * Must check for control method type dispatch one more time to avoid a
+	 * race with ev_gpe_install_handler
 	 */
 	if ((local_gpe_event_info.flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_METHOD) {
@@ -584,8 +583,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
 	    ACPI_GPE_LEVEL_TRIGGERED) {
 		/*
-		 * GPE is level-triggered, we clear the GPE status bit after
-		 * handling the event.
+		 * GPE is level-triggered, we clear the GPE status bit after handling
+		 * the event.
 		 */
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
@@ -624,7 +623,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 	acpi_os_gpe_count(gpe_number);
 
 	/*
-	 * If edge-triggered, clear the GPE status bit now.  Note that
+	 * If edge-triggered, clear the GPE status bit now. Note that
 	 * level-triggered events are cleared after the GPE is serviced.
 	 */
 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
@@ -650,7 +649,8 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 
 		/*
 		 * Invoke the installed handler (at interrupt level)
-		 * Ignore return status for now.  TBD: leave GPE disabled on error?
+		 * Ignore return status for now.
+		 * TBD: leave GPE disabled on error?
 		 */
 		(void)gpe_event_info->dispatch.handler->address(gpe_event_info->
 								dispatch.
@@ -708,7 +708,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 			    gpe_number));
 
 		/*
-		 * Disable the GPE. The GPE will remain disabled until the ACPI
+		 * Disable the GPE. The GPE will remain disabled until the ACPICA
 		 * Core Subsystem is restarted, or a handler is installed.
 		 */
 		status = acpi_ev_disable_gpe(gpe_event_info);
diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 73c058e..7537cda 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -309,17 +309,17 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 	     (gpe_block->block_base_number +
 	      (gpe_block->register_count * 8)))) {
 		/*
-		 * Not valid for this GPE block, just ignore it
-		 * However, it may be valid for a different GPE block, since GPE0 and GPE1
-		 * methods both appear under \_GPE.
+		 * Not valid for this GPE block, just ignore it. However, it may be
+		 * valid for a different GPE block, since GPE0 and GPE1 methods both
+		 * appear under \_GPE.
 		 */
 		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
-	 * Now we can add this information to the gpe_event_info block
-	 * for use during dispatch of this GPE. Default type is RUNTIME, although
-	 * this may change when the _PRW methods are executed later.
+	 * Now we can add this information to the gpe_event_info block for use
+	 * during dispatch of this GPE. Default type is RUNTIME, although this may
+	 * change when the _PRW methods are executed later.
 	 */
 	gpe_event_info =
 	    &gpe_block->event_info[gpe_number - gpe_block->block_base_number];
@@ -394,8 +394,8 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	gpe_block = gpe_info->gpe_block;
 
 	/*
-	 * The _PRW object must return a package, we are only interested
-	 * in the first element
+	 * The _PRW object must return a package, we are only interested in the
+	 * first element
 	 */
 	obj_desc = pkg_desc->package.elements[0];
 
@@ -434,7 +434,7 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	/*
 	 * Is this GPE within this block?
 	 *
-	 * TRUE iff these conditions are true:
+	 * TRUE if and only if these conditions are true:
 	 *     1) The GPE devices match.
 	 *     2) The GPE index(number) is within the range of the Gpe Block
 	 *          associated with the GPE device.
@@ -457,6 +457,7 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 		if (ACPI_FAILURE(status)) {
 			goto cleanup;
 		}
+
 		status =
 		    acpi_ev_update_gpe_enable_masks(gpe_event_info,
 						    ACPI_GPE_DISABLE);
@@ -476,9 +477,9 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
  * RETURN:      A GPE interrupt block
  *
  * DESCRIPTION: Get or Create a GPE interrupt block. There is one interrupt
- *              block per unique interrupt level used for GPEs.
- *              Should be called only when the GPE lists are semaphore locked
- *              and not subject to change.
+ *              block per unique interrupt level used for GPEs. Should be
+ *              called only when the GPE lists are semaphore locked and not
+ *              subject to change.
  *
  ******************************************************************************/
 
@@ -608,8 +609,9 @@ acpi_ev_delete_gpe_xrupt(struct acpi_gpe_xrupt_info *gpe_xrupt)
  *
  * FUNCTION:    acpi_ev_install_gpe_block
  *
- * PARAMETERS:  gpe_block       - New GPE block
- *              interrupt_number - Xrupt to be associated with this GPE block
+ * PARAMETERS:  gpe_block               - New GPE block
+ *              interrupt_number        - Xrupt to be associated with this
+ *                                        GPE block
  *
  * RETURN:      Status
  *
@@ -666,7 +668,7 @@ acpi_ev_install_gpe_block(struct acpi_gpe_block_info *gpe_block,
  *
  * FUNCTION:    acpi_ev_delete_gpe_block
  *
- * PARAMETERS:  gpe_block       - Existing GPE block
+ * PARAMETERS:  gpe_block           - Existing GPE block
  *
  * RETURN:      Status
  *
@@ -786,9 +788,9 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 	/*
 	 * Initialize the GPE Register and Event structures. A goal of these
-	 * tables is to hide the fact that there are two separate GPE register sets
-	 * in a given GPE hardware block, the status registers occupy the first half,
-	 * and the enable registers occupy the second half.
+	 * tables is to hide the fact that there are two separate GPE register
+	 * sets in a given GPE hardware block, the status registers occupy the
+	 * first half, and the enable registers occupy the second half.
 	 */
 	this_register = gpe_register_info;
 	this_event = gpe_event_info;
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 82c457f..dbac5b3 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -148,7 +148,9 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			break;
 
 		default:
+
 			/* All other types are not supported */
+
 			return (AE_TYPE);
 		}
 	}
@@ -189,9 +191,8 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			acpi_ut_delete_generic_state(notify_info);
 		}
 	} else {
-		/*
-		 * There is no notify handler (per-device or system) for this device.
-		 */
+		/* There is no notify handler (per-device or system) for this device */
+
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No notify handler for Notify (%4.4s, %X) node %p\n",
 				  acpi_ut_get_node_name(node), notify_value,
@@ -225,9 +226,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 	ACPI_FUNCTION_ENTRY();
 
 	/*
-	 * We will invoke a global notify handler if installed.
-	 * This is done _before_ we invoke the per-device handler attached
-	 * to the device.
+	 * We will invoke a global notify handler if installed. This is done
+	 * _before_ we invoke the per-device handler attached to the device.
 	 */
 	if (notify_info->notify.value <= ACPI_MAX_SYS_NOTIFY) {
 
@@ -339,11 +339,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 						  NULL);
 
 	/*
-	 * If the global lock does not exist on this platform, the attempt
-	 * to enable GBL_STATUS will fail (the GBL_ENABLE bit will not stick)
-	 * Map to AE_OK, but mark global lock as not present.
-	 * Any attempt to actually use the global lock will be flagged
-	 * with an error.
+	 * If the global lock does not exist on this platform, the attempt to
+	 * enable GBL_STATUS will fail (the GBL_ENABLE bit will not stick).
+	 * Map to AE_OK, but mark global lock as not present. Any attempt to
+	 * actually use the global lock will be flagged with an error.
 	 */
 	if (status == AE_NO_HARDWARE_RESPONSE) {
 		ACPI_ERROR((AE_INFO,
@@ -452,8 +451,8 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	}
 
 	/*
-	 * Make sure that a global lock actually exists. If not, just treat
-	 * the lock as a standard mutex.
+	 * Make sure that a global lock actually exists. If not, just treat the
+	 * lock as a standard mutex.
 	 */
 	if (!acpi_gbl_global_lock_present) {
 		acpi_gbl_global_lock_acquired = TRUE;
@@ -572,8 +571,8 @@ void acpi_ev_terminate(void)
 
 	if (acpi_gbl_events_initialized) {
 		/*
-		 * Disable all event-related functionality.
-		 * In all cases, on error, print a message but obviously we don't abort.
+		 * Disable all event-related functionality. In all cases, on error,
+		 * print a message but obviously we don't abort.
 		 */
 
 		/* Disable all fixed events */
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 236fbd1..3ddddbf 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -48,16 +48,8 @@
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evregion")
-#define ACPI_NUM_DEFAULT_SPACES     4
-static u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
-	ACPI_ADR_SPACE_SYSTEM_MEMORY,
-	ACPI_ADR_SPACE_SYSTEM_IO,
-	ACPI_ADR_SPACE_PCI_CONFIG,
-	ACPI_ADR_SPACE_DATA_TABLE
-};
 
 /* Local prototypes */
-
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -66,6 +58,17 @@ static acpi_status
 acpi_ev_install_handler(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
+/* These are the address spaces that will get default handlers */
+
+#define ACPI_NUM_DEFAULT_SPACES     4
+
+static u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
+	ACPI_ADR_SPACE_SYSTEM_MEMORY,
+	ACPI_ADR_SPACE_SYSTEM_IO,
+	ACPI_ADR_SPACE_PCI_CONFIG,
+	ACPI_ADR_SPACE_DATA_TABLE
+};
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_install_region_handlers
@@ -91,18 +94,19 @@ acpi_status acpi_ev_install_region_handlers(void)
 	}
 
 	/*
-	 * All address spaces (PCI Config, EC, SMBus) are scope dependent
-	 * and registration must occur for a specific device.
+	 * All address spaces (PCI Config, EC, SMBus) are scope dependent and
+	 * registration must occur for a specific device.
 	 *
-	 * In the case of the system memory and IO address spaces there is currently
-	 * no device associated with the address space.  For these we use the root.
+	 * In the case of the system memory and IO address spaces there is
+	 * currently no device associated with the address space. For these we
+	 * use the root.
 	 *
-	 * We install the default PCI config space handler at the root so
-	 * that this space is immediately available even though the we have
-	 * not enumerated all the PCI Root Buses yet.  This is to conform
-	 * to the ACPI specification which states that the PCI config
-	 * space must be always available -- even though we are nowhere
-	 * near ready to find the PCI root buses at this point.
+	 * We install the default PCI config space handler at the root so that
+	 * this space is immediately available even though the we have not
+	 * enumerated all the PCI Root Buses yet. This is to conform to the ACPI
+	 * specification which states that the PCI config space must be always
+	 * available -- even though we are nowhere near ready to find the PCI root
+	 * buses at this point.
 	 *
 	 * NOTE: We ignore AE_ALREADY_EXISTS because this means that a handler
 	 * has already been installed (via acpi_install_address_space_handler).
@@ -160,12 +164,11 @@ acpi_status acpi_ev_initialize_op_regions(void)
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * Run the _REG methods for op_regions in each default address space
-	 */
-	for (i = 0; i < ACPI_NUM_DEFAULT_SPACES; i++) {
+	/* Run the _REG methods for op_regions in each default address space */
 
-		/* TBD: Make sure handler is the DEFAULT handler, otherwise
+	for (i = 0; i < ACPI_NUM_DEFAULT_SPACES; i++) {
+		/*
+		 * TBD: Make sure handler is the DEFAULT handler, otherwise
 		 * _REG will have already been run.
 		 */
 		status = acpi_ev_execute_reg_methods(acpi_gbl_root_node,
@@ -318,13 +321,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	}
 
 	/*
-	 * It may be the case that the region has never been initialized
+	 * It may be the case that the region has never been initialized.
 	 * Some types of regions require special init code
 	 */
 	if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)) {
-		/*
-		 * This region has not been initialized yet, do it
-		 */
+
+		/* This region has not been initialized yet, do it */
+
 		region_setup = handler_desc->address_space.setup;
 		if (!region_setup) {
 
@@ -339,9 +342,9 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		}
 
 		/*
-		 * We must exit the interpreter because the region
-		 * setup will potentially execute control methods
-		 * (e.g., _REG method for this region)
+		 * We must exit the interpreter because the region setup will
+		 * potentially execute control methods (for example, the _REG method
+		 * for this region)
 		 */
 		acpi_ex_exit_interpreter();
 
@@ -364,9 +367,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(status);
 		}
 
-		/*
-		 * Region initialization may have been completed by region_setup
-		 */
+		/* Region initialization may have been completed by region_setup */
+
 		if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)) {
 			region_obj->region.flags |= AOPOBJ_SETUP_COMPLETE;
 
@@ -521,8 +523,8 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 			}
 
 			/*
-			 * If the region has been activated, call the setup handler
-			 * with the deactivate notification
+			 * If the region has been activated, call the setup handler with
+			 * the deactivate notification
 			 */
 			if (region_obj->region.flags & AOPOBJ_SETUP_COMPLETE) {
 				region_setup = handler_obj->address_space.setup;
@@ -668,8 +670,8 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 	}
 
 	/*
-	 * We only care about regions.and objects
-	 * that are allowed to have address space handlers
+	 * We only care about regions and objects that are allowed to have
+	 * address space handlers
 	 */
 	if ((node->type != ACPI_TYPE_DEVICE) &&
 	    (node->type != ACPI_TYPE_REGION) && (node != acpi_gbl_root_node)) {
@@ -710,9 +712,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 				/*
 				 * Since the object we found it on was a device, then it
 				 * means that someone has already installed a handler for
-				 * the branch of the namespace from this device on.  Just
+				 * the branch of the namespace from this device on. Just
 				 * bail out telling the walk routine to not traverse this
-				 * branch.  This preserves the scoping rule for handlers.
+				 * branch. This preserves the scoping rule for handlers.
 				 */
 				return (AE_CTRL_DEPTH);
 			}
@@ -723,9 +725,8 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 		}
 
 		/*
-		 * As long as the device didn't have a handler for this
-		 * space we don't care about it.  We just ignore it and
-		 * proceed.
+		 * As long as the device didn't have a handler for this space we
+		 * don't care about it. We just ignore it and proceed.
 		 */
 		return (AE_OK);
 	}
@@ -733,16 +734,14 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 	/* Object is a Region */
 
 	if (obj_desc->region.space_id != handler_obj->address_space.space_id) {
-		/*
-		 * This region is for a different address space
-		 * -- just ignore it
-		 */
+
+		/* This region is for a different address space, just ignore it */
+
 		return (AE_OK);
 	}
 
 	/*
-	 * Now we have a region and it is for the handler's address
-	 * space type.
+	 * Now we have a region and it is for the handler's address space type.
 	 *
 	 * First disconnect region for any previous handler (if any)
 	 */
@@ -786,9 +785,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	ACPI_FUNCTION_TRACE(ev_install_space_handler);
 
 	/*
-	 * This registration is valid for only the types below
-	 * and the root.  This is where the default handlers
-	 * get placed.
+	 * This registration is valid for only the types below and the root. This
+	 * is where the default handlers get placed.
 	 */
 	if ((node->type != ACPI_TYPE_DEVICE) &&
 	    (node->type != ACPI_TYPE_PROCESSOR) &&
@@ -848,8 +846,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (obj_desc) {
 		/*
-		 * The attached device object already exists.
-		 * Make sure the handler is not already installed.
+		 * The attached device object already exists. Make sure the handler
+		 * is not already installed.
 		 */
 		handler_obj = obj_desc->device.handler;
 
@@ -864,8 +862,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 				    handler) {
 					/*
 					 * It is (relatively) OK to attempt to install the SAME
-					 * handler twice. This can easily happen
-					 * with PCI_Config space.
+					 * handler twice. This can easily happen with the
+					 * PCI_Config space.
 					 */
 					status = AE_SAME_HANDLER;
 					goto unlock_and_exit;
@@ -925,9 +923,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	/*
 	 * Install the handler
 	 *
-	 * At this point there is no existing handler.
-	 * Just allocate the object for the handler and link it
-	 * into the list.
+	 * At this point there is no existing handler. Just allocate the object
+	 * for the handler and link it into the list.
 	 */
 	handler_obj =
 	    acpi_ut_create_internal_object(ACPI_TYPE_LOCAL_ADDRESS_HANDLER);
@@ -1000,11 +997,10 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	ACPI_FUNCTION_TRACE(ev_execute_reg_methods);
 
 	/*
-	 * Run all _REG methods for all Operation Regions for this
-	 * space ID.  This is a separate walk in order to handle any
-	 * interdependencies between regions and _REG methods.  (i.e. handlers
-	 * must be installed for all regions of this Space ID before we
-	 * can run any _REG methods)
+	 * Run all _REG methods for all Operation Regions for this space ID. This
+	 * is a separate walk in order to handle any interdependencies between
+	 * regions and _REG methods. (i.e. handlers must be installed for all
+	 * regions of this Space ID before we can run any _REG methods)
 	 */
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
 					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
@@ -1042,8 +1038,8 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 	}
 
 	/*
-	 * We only care about regions.and objects
-	 * that are allowed to have address space handlers
+	 * We only care about regions.and objects that are allowed to have address
+	 * space handlers
 	 */
 	if ((node->type != ACPI_TYPE_REGION) && (node != acpi_gbl_root_node)) {
 		return (AE_OK);
@@ -1062,10 +1058,9 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 	/* Object is a Region */
 
 	if (obj_desc->region.space_id != space_id) {
-		/*
-		 * This region is for a different address space
-		 * -- just ignore it
-		 */
+
+		/* This region is for a different address space, just ignore it */
+
 		return (AE_OK);
 	}
 
diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 6b94b38..f9e561e 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -233,9 +233,9 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 				if (ACPI_FAILURE(status)) {
 					if (status == AE_SAME_HANDLER) {
 						/*
-						 * It is OK if the handler is already installed on the root
-						 * bridge.  Still need to return a context object for the
-						 * new PCI_Config operation region, however.
+						 * It is OK if the handler is already installed on the
+						 * root bridge. Still need to return a context object
+						 * for the new PCI_Config operation region, however.
 						 */
 						status = AE_OK;
 					} else {
@@ -272,8 +272,8 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	}
 
 	/*
-	 * For PCI_Config space access, we need the segment, bus,
-	 * device and function numbers.  Acquire them here.
+	 * For PCI_Config space access, we need the segment, bus, device and
+	 * function numbers. Acquire them here.
 	 *
 	 * Find the parent device object. (This allows the operation region to be
 	 * within a subscope under the device, such as a control method.)
@@ -289,16 +289,16 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	}
 
 	/*
-	 * Get the PCI device and function numbers from the _ADR object
-	 * contained in the parent's scope.
+	 * Get the PCI device and function numbers from the _ADR object contained
+	 * in the parent's scope.
 	 */
 	status =
 	    acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR, pci_device_node,
 					    &pci_value);
 
 	/*
-	 * The default is zero, and since the allocation above zeroed
-	 * the data, just do nothing on failure.
+	 * The default is zero, and since the allocation above zeroed the data,
+	 * just do nothing on failure.
 	 */
 	if (ACPI_SUCCESS(status)) {
 		pci_id->device = ACPI_HIWORD(ACPI_LODWORD(pci_value));
@@ -382,9 +382,8 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 	struct acpi_compatible_id_list *cid;
 	u32 i;
 
-	/*
-	 * Get the _HID and check for a PCI Root Bridge
-	 */
+	/* Get the _HID and check for a PCI Root Bridge */
+
 	status = acpi_ut_execute_HID(node, &hid);
 	if (ACPI_FAILURE(status)) {
 		return (FALSE);
@@ -394,10 +393,8 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 		return (TRUE);
 	}
 
-	/*
-	 * The _HID did not match.
-	 * Get the _CID and check for a PCI Root Bridge
-	 */
+	/* The _HID did not match. Get the _CID and check for a PCI Root Bridge */
+
 	status = acpi_ut_execute_CID(node, &cid);
 	if (ACPI_FAILURE(status)) {
 		return (FALSE);
@@ -516,9 +513,9 @@ acpi_ev_default_region_setup(acpi_handle handle,
  *              Get the appropriate address space handler for a newly
  *              created region.
  *
- *              This also performs address space specific initialization.  For
+ *              This also performs address space specific initialization. For
  *              example, PCI regions must have an _ADR object that contains
- *              a PCI address in the scope of the definition.  This address is
+ *              a PCI address in the scope of the definition. This address is
  *              required to perform an access to PCI config space.
  *
  * MUTEX:       Interpreter should be unlocked, because we may run the _REG
@@ -572,7 +569,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 	if (ACPI_SUCCESS(status)) {
 		/*
 		 * The _REG method is optional and there can be only one per region
-		 * definition.  This will be executed when the handler is attached
+		 * definition. This will be executed when the handler is attached
 		 * or removed
 		 */
 		region_obj2->extra.method_REG = method_node;
@@ -670,10 +667,8 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 			}
 		}
 
-		/*
-		 * This node does not have the handler we need;
-		 * Pop up one level
-		 */
+		/* This node does not have the handler we need; Pop up one level */
+
 		node = acpi_ns_get_parent_node(node);
 	}
 
diff --git a/drivers/acpi/events/evsci.c b/drivers/acpi/events/evsci.c
index 2a8b778..b5fc805 100644
--- a/drivers/acpi/events/evsci.c
+++ b/drivers/acpi/events/evsci.c
@@ -115,10 +115,8 @@ u32 ACPI_SYSTEM_XFACE acpi_ev_gpe_xrupt_handler(void *context)
 	 * if this interrupt handler is installed, ACPI is enabled.
 	 */
 
-	/*
-	 * GPEs:
-	 * Check for and dispatch any GPEs that have occurred
-	 */
+	/* GPEs: Check for and dispatch any GPEs that have occurred */
+
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
 
 	return_UINT32(interrupt_handled);
@@ -158,11 +156,11 @@ u32 acpi_ev_install_sci_handler(void)
  * RETURN:      E_OK if handler uninstalled OK, E_ERROR if handler was not
  *              installed to begin with
  *
- * DESCRIPTION: Remove the SCI interrupt handler.  No further SCIs will be
+ * DESCRIPTION: Remove the SCI interrupt handler. No further SCIs will be
  *              taken.
  *
  * Note:  It doesn't seem important to disable all events or set the event
- *        enable registers to their original values.  The OS should disable
+ *        enable registers to their original values. The OS should disable
  *        the SCI interrupt level when the handler is removed, so no more
  *        events will come in.
  *
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 94a6efe..a286787 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -267,7 +267,7 @@ acpi_install_notify_handler(acpi_handle device,
 	/*
 	 * Root Object:
 	 * Registering a notify handler on the root object indicates that the
-	 * caller wishes to receive notifications for all objects.  Note that
+	 * caller wishes to receive notifications for all objects. Note that
 	 * only one <external> global handler can be regsitered (per notify type).
 	 */
 	if (device == ACPI_ROOT_OBJECT) {
diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/events/evxfevnt.c
index 41554f7..669b8ca 100644
--- a/drivers/acpi/events/evxfevnt.c
+++ b/drivers/acpi/events/evxfevnt.c
@@ -161,8 +161,8 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 	}
 
 	/*
-	 * Enable the requested fixed event (by writing a one to the
-	 * enable register bit)
+	 * Enable the requested fixed event (by writing a one to the enable
+	 * register bit)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
@@ -343,8 +343,8 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
 	}
 
 	/*
-	 * Disable the requested fixed event (by writing a zero to the
-	 * enable register bit)
+	 * Disable the requested fixed event (by writing a zero to the enable
+	 * register bit)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
@@ -396,8 +396,8 @@ acpi_status acpi_clear_event(u32 event)
 	}
 
 	/*
-	 * Clear the requested fixed event (By writing a one to the
-	 * status register bit)
+	 * Clear the requested fixed event (By writing a one to the status
+	 * register bit)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
-- 
1.5.6.6

