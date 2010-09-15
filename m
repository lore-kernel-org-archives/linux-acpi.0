From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][PATCH] ACPI / ACPICA: Defer enabling of runtime GPEs (v3)
Date: Thu, 16 Sep 2010 00:30:43 +0200
Message-ID: <201009160030.43983.rjw@sisk.pl>
References: <201008290110.56740.rjw@sisk.pl> <201008312235.49410.rjw@sisk.pl> <4911F71203A09E4D9981D27F9D830858AEE0B9B3@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59909 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285Ab0IOWby (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Sep 2010 18:31:54 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858AEE0B9B3@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The current ACPI GPEs initialization code has a problem that it
enables some GPEs pointed to by device _PRW methods, generally
intended for signaling wakeup events (system or device wakeup).
These GPEs are then almost immediately disabled by the ACPI namespace
scanning code with the help of acpi_gpe_can_wake(), but it would be
better not to enable them at all until really necessary.

Modify the initialization of GPEs so that the ones that have
associated _Lxx or _Exx methods and are not pointed to by any _PRW
methods will be enabled after the namespace scan is complete.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acevents.h  |    5 +--
 drivers/acpi/acpica/acglobal.h  |    1 
 drivers/acpi/acpica/aclocal.h   |    3 +
 drivers/acpi/acpica/evevent.c   |   41 --------------------------
 drivers/acpi/acpica/evgpeblk.c  |   47 +++++++++++++-----------------
 drivers/acpi/acpica/evgpeinit.c |   31 --------------------
 drivers/acpi/acpica/evxface.c   |   19 ++++++------
 drivers/acpi/acpica/evxfevnt.c  |   61 ++++++++++++++++++++++++++++------------
 drivers/acpi/acpica/utglobal.c  |    1 
 drivers/acpi/acpica/utxface.c   |   13 --------
 drivers/acpi/dock.c             |    1 
 drivers/acpi/scan.c             |    9 +++++
 include/acpi/acpixf.h           |    2 +
 13 files changed, 94 insertions(+), 140 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -379,21 +379,12 @@ acpi_status acpi_gpe_can_wake(acpi_handl
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
+	if (gpe_event_info) {
+		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+	} else {
 		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
-		goto unlock_and_exit;
 	}
 
-	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
-	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD) {
-		(void)acpi_raw_disable_gpe(gpe_event_info);
-	}
-
-unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
@@ -651,7 +642,7 @@ acpi_install_gpe_block(acpi_handle gpe_d
 		       struct acpi_generic_address *gpe_block_address,
 		       u32 register_count, u32 interrupt_number)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	union acpi_operand_object *obj_desc;
 	struct acpi_namespace_node *node;
 	struct acpi_gpe_block_info *gpe_block;
@@ -715,10 +706,6 @@ acpi_install_gpe_block(acpi_handle gpe_d
 
 	obj_desc->device.gpe_block = gpe_block;
 
-	/* Enable the runtime GPEs in the new block */
-
-	status = acpi_ev_initialize_gpe_block(node, gpe_block);
-
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
@@ -924,3 +911,43 @@ acpi_status acpi_enable_all_runtime_gpes
 
 	return_ACPI_STATUS(status);
 }
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_update_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Enable all GPEs that have associated _Lxx or _Exx methods and
+ *              are not pointed to by any device _PRW methods indicating that
+ *              these GPEs are generally intended for system or device wakeup
+ *              (such GPEs have to be enabled directly when the devices whose
+ *              _PRW methods point to them are set up for wakeup signaling).
+ *
+ ******************************************************************************/
+
+acpi_status acpi_update_gpes(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_update_gpes);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	} else if (acpi_all_gpes_initialized) {
+		goto unlock;
+	}
+
+	status = acpi_ev_walk_gpe_list(acpi_ev_initialize_gpe_block, NULL);
+	if (ACPI_SUCCESS(status)) {
+		acpi_all_gpes_initialized = TRUE;
+	}
+
+unlock:
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return_ACPI_STATUS(status);
+}
Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -105,8 +105,9 @@ acpi_ev_create_gpe_block(struct acpi_nam
 			 struct acpi_gpe_block_info **return_gpe_block);
 
 acpi_status
-acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
-			     struct acpi_gpe_block_info *gpe_block);
+acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			     struct acpi_gpe_block_info *gpe_block,
+			     void *ignored);
 
 acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block);
 
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -363,6 +363,7 @@ acpi_ev_create_gpe_block(struct acpi_nam
 	gpe_block->gpe_count = (u16)(register_count * ACPI_GPE_REGISTER_WIDTH);
 	gpe_block->register_count = register_count;
 	gpe_block->block_base_number = gpe_block_base_number;
+	gpe_block->initialized = FALSE;
 
 	ACPI_MEMCPY(&gpe_block->block_address, gpe_block_address,
 		    sizeof(struct acpi_generic_address));
@@ -385,11 +386,12 @@ acpi_ev_create_gpe_block(struct acpi_nam
 		return_ACPI_STATUS(status);
 	}
 
+	acpi_all_gpes_initialized = FALSE;
+
 	/* Find all GPE methods (_Lxx or_Exx) for this block */
 
 	walk_info.gpe_block = gpe_block;
 	walk_info.gpe_device = gpe_device;
-	walk_info.enable_this_gpe = FALSE;
 	walk_info.execute_by_owner_id = FALSE;
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
@@ -434,35 +436,34 @@ acpi_ev_create_gpe_block(struct acpi_nam
  ******************************************************************************/
 
 acpi_status
-acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
-			     struct acpi_gpe_block_info *gpe_block)
+acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			     struct acpi_gpe_block_info *gpe_block,
+			     void *ignored)
 {
 	acpi_status status;
 	struct acpi_gpe_event_info *gpe_event_info;
 	u32 gpe_enabled_count;
 	u32 gpe_index;
-	u32 gpe_number;
 	u32 i;
 	u32 j;
 
 	ACPI_FUNCTION_TRACE(ev_initialize_gpe_block);
 
-	/* Ignore a null GPE block (e.g., if no GPE block 1 exists) */
-
-	if (!gpe_block) {
+	/*
+	 * Ignore a null GPE block (e.g., if no GPE block 1 exists) and
+	 * GPE blocks that have been initialized already.
+	 */
+	if (!gpe_block || gpe_block->initialized) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
-	 * Enable all GPEs that have a corresponding method.  Any other GPEs
-	 * within this block must be enabled via the acpi_enable_gpe interface.
+	 * Enable all GPEs that have a corresponding method and have the
+	 * ACPI_GPE_CAN_WAKE flag unset.  Any other GPEs within this block must
+	 * be enabled via the acpi_enable_gpe() interface.
 	 */
 	gpe_enabled_count = 0;
 
-	if (gpe_device == acpi_gbl_fadt_gpe_device) {
-		gpe_device = NULL;
-	}
-
 	for (i = 0; i < gpe_block->register_count; i++) {
 		for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
 
@@ -470,27 +471,19 @@ acpi_ev_initialize_gpe_block(struct acpi
 
 			gpe_index = (i * ACPI_GPE_REGISTER_WIDTH) + j;
 			gpe_event_info = &gpe_block->event_info[gpe_index];
-			gpe_number = gpe_index + gpe_block->block_base_number;
 
 			/* Ignore GPEs that have no corresponding _Lxx/_Exx method */
 
-			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)) {
+			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)
+			    || (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 				continue;
 			}
 
-			/*
-			 * If the GPE has already been enabled for runtime
-			 * signaling, make sure it remains enabled, but do not
-			 * increment its reference counter.
-			 */
-			status = gpe_event_info->runtime_count ?
-				acpi_ev_enable_gpe(gpe_event_info) :
-				acpi_enable_gpe(gpe_device, gpe_number);
-
+			status = acpi_raw_enable_gpe(gpe_event_info);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
-						"Could not enable GPE 0x%02X",
-						gpe_number));
+					"Could not enable GPE 0x%02X",
+					gpe_index + gpe_block->block_base_number));
 				continue;
 			}
 
@@ -504,5 +497,7 @@ acpi_ev_initialize_gpe_block(struct acpi
 				  gpe_enabled_count));
 	}
 
+	gpe_block->initialized = TRUE;
+
 	return_ACPI_STATUS(AE_OK);
 }
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -308,6 +308,8 @@ acpi_install_gpe_block(acpi_handle gpe_d
 
 acpi_status acpi_remove_gpe_block(acpi_handle gpe_device);
 
+acpi_status acpi_update_gpes(void);
+
 /*
  * Resource interfaces
  */
Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -413,6 +413,7 @@ struct acpi_handler_info {
 	void *context;		/* Context to be passed to handler */
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level (saved) */
 	u8 orig_flags;		/* Original misc info about this GPE */
+	u8 orig_enabled;	/* Set if the GPE was originally enabled */
 };
 
 union acpi_gpe_dispatch_info {
@@ -457,6 +458,7 @@ struct acpi_gpe_block_info {
 	u32 register_count;	/* Number of register pairs in block */
 	u16 gpe_count;		/* Number of individual GPEs in block */
 	u8 block_base_number;	/* Base GPE number for this block */
+	u8 initialized;         /* If set, the GPE block has been initialized */
 };
 
 /* Information about GPE interrupt handlers, one per each interrupt level used for GPEs */
@@ -473,7 +475,6 @@ struct acpi_gpe_walk_info {
 	struct acpi_gpe_block_info *gpe_block;
 	u16 count;
 	acpi_owner_id owner_id;
-	u8 enable_this_gpe;
 	u8 execute_by_owner_id;
 };
 
Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c
+++ linux-2.6/drivers/acpi/acpica/evgpeinit.c
@@ -210,8 +210,7 @@ acpi_status acpi_ev_gpe_initialize(void)
  *
  * DESCRIPTION: Check for new GPE methods (_Lxx/_Exx) made available as a
  *              result of a Load() or load_table() operation. If new GPE
- *              methods have been installed, register the new methods and
- *              enable and runtime GPEs that are associated with them.
+ *              methods have been installed, register the new methods.
  *
  ******************************************************************************/
 
@@ -239,7 +238,6 @@ void acpi_ev_update_gpes(acpi_owner_id t
 	walk_info.owner_id = table_owner_id;
 	walk_info.execute_by_owner_id = TRUE;
 	walk_info.count = 0;
-	walk_info.enable_this_gpe = TRUE;
 
 	/* Walk the interrupt level descriptor list */
 
@@ -301,8 +299,6 @@ void acpi_ev_update_gpes(acpi_owner_id t
  *
  * If walk_info->execute_by_owner_id is TRUE, we only execute examine GPE methods
  *    with that owner.
- * If walk_info->enable_this_gpe is TRUE, the GPE that is referred to by a GPE
- *    method is immediately enabled (Used for Load/load_table operators)
  *
  ******************************************************************************/
 
@@ -315,8 +311,6 @@ acpi_ev_match_gpe_method(acpi_handle obj
 	struct acpi_gpe_walk_info *walk_info =
 	    ACPI_CAST_PTR(struct acpi_gpe_walk_info, context);
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_namespace_node *gpe_device;
-	acpi_status status;
 	u32 gpe_number;
 	char name[ACPI_NAME_SIZE + 1];
 	u8 type;
@@ -421,29 +415,6 @@ acpi_ev_match_gpe_method(acpi_handle obj
 	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_METHOD);
 	gpe_event_info->dispatch.method_node = method_node;
 
-	/*
-	 * Enable this GPE if requested. This only happens when during the
-	 * execution of a Load or load_table operator. We have found a new
-	 * GPE method and want to immediately enable the GPE if it is a
-	 * runtime GPE.
-	 */
-	if (walk_info->enable_this_gpe) {
-
-		walk_info->count++;
-		gpe_device = walk_info->gpe_device;
-
-		if (gpe_device == acpi_gbl_fadt_gpe_device) {
-			gpe_device = NULL;
-		}
-
-		status = acpi_enable_gpe(gpe_device, gpe_number);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Could not enable GPE 0x%02X",
-					gpe_number));
-		}
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
 			  "Registered GPE method %s as GPE number 0x%.2X\n",
 			  name, gpe_number));
Index: linux-2.6/drivers/acpi/acpica/evevent.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evevent.c
+++ linux-2.6/drivers/acpi/acpica/evevent.c
@@ -95,47 +95,6 @@ acpi_status acpi_ev_initialize_events(vo
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_install_fadt_gpes
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Completes initialization of the FADT-defined GPE blocks
- *              (0 and 1). The HW must be fully initialized at this point,
- *              including global lock support.
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_install_fadt_gpes(void)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_install_fadt_gpes);
-
-	/* Namespace must be locked */
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	/* FADT GPE Block 0 */
-
-	(void)acpi_ev_initialize_gpe_block(acpi_gbl_fadt_gpe_device,
-					   acpi_gbl_gpe_fadt_blocks[0]);
-
-	/* FADT GPE Block 1 */
-
-	(void)acpi_ev_initialize_gpe_block(acpi_gbl_fadt_gpe_device,
-					   acpi_gbl_gpe_fadt_blocks[1]);
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-	return_ACPI_STATUS(AE_OK);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ev_install_xrupt_handlers
  *
  * PARAMETERS:  None
Index: linux-2.6/drivers/acpi/acpica/utxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/utxface.c
+++ linux-2.6/drivers/acpi/acpica/utxface.c
@@ -290,19 +290,6 @@ acpi_status acpi_initialize_objects(u32 
 	}
 
 	/*
-	 * Complete the GPE initialization for the GPE blocks defined in the FADT
-	 * (GPE block 0 and 1).
-	 *
-	 * NOTE: Currently, there seems to be no need to run the _REG methods
-	 * before enabling the GPEs.
-	 */
-	if (!(flags & ACPI_NO_EVENT_INIT)) {
-		status = acpi_ev_install_fadt_gpes();
-		if (ACPI_FAILURE(status))
-			return (status);
-	}
-
-	/*
 	 * Empty the caches (delete the cached objects) on the assumption that
 	 * the table load filled them up more than they will be at runtime --
 	 * thus wasting non-paged memory.
Index: linux-2.6/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxface.c
+++ linux-2.6/drivers/acpi/acpica/evxface.c
@@ -793,15 +793,16 @@ acpi_install_gpe_handler(acpi_handle gpe
 			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
 
 	/*
-	 * If the GPE is associated with a method and it cannot wake up the
-	 * system from sleep states, it was enabled automatically during
-	 * initialization, so it has to be disabled now to avoid spurious
-	 * execution of the handler.
+	 * If the GPE is associated with a method, it might have been enabled
+	 * automatically during initialization, in which case it has to be
+	 * disabled now to avoid spurious execution of the handler.
 	 */
 
 	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE))
+	    && gpe_event_info->runtime_count) {
+		handler->orig_enabled = 1;
 		(void)acpi_raw_disable_gpe(gpe_event_info);
+	}
 
 	/* Install the handler */
 
@@ -904,13 +905,13 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 	gpe_event_info->flags |= handler->orig_flags;
 
 	/*
-	 * If the GPE was previously associated with a method and it cannot wake
-	 * up the system from sleep states, it should be enabled at this point
-	 * to restore the post-initialization configuration.
+	 * If the GPE was previously associated with a method and it was
+	 * enabled, it should be enabled at this point to restore the
+	 * post-initialization configuration.
 	 */
 
 	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE))
+	    && handler->orig_enabled)
 		(void)acpi_raw_enable_gpe(gpe_event_info);
 
 	/* Now we can free the handler object */
Index: linux-2.6/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
+++ linux-2.6/drivers/acpi/acpica/acglobal.h
@@ -364,6 +364,7 @@ ACPI_EXTERN struct acpi_fixed_event_hand
 ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
 ACPI_EXTERN struct acpi_gpe_block_info
 *acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
+ACPI_EXTERN u8 acpi_all_gpes_initialized;
 
 /*****************************************************************************
  *
Index: linux-2.6/drivers/acpi/acpica/utglobal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/utglobal.c
+++ linux-2.6/drivers/acpi/acpica/utglobal.c
@@ -766,6 +766,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
 	acpi_current_gpe_count = 0;
+	acpi_all_gpes_initialized = FALSE;
 
 	/* Global handlers */
 
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -1431,6 +1431,7 @@ EXPORT_SYMBOL(acpi_bus_add);
 int acpi_bus_start(struct acpi_device *device)
 {
 	struct acpi_bus_ops ops;
+	int result;
 
 	if (!device)
 		return -EINVAL;
@@ -1438,7 +1439,11 @@ int acpi_bus_start(struct acpi_device *d
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_start = 1;
 
-	return acpi_bus_scan(device->handle, &ops, NULL);
+	result = acpi_bus_scan(device->handle, &ops, NULL);
+
+	acpi_update_gpes();
+
+	return result;
 }
 EXPORT_SYMBOL(acpi_bus_start);
 
@@ -1552,6 +1557,8 @@ int __init acpi_scan_init(void)
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
+	else
+		acpi_update_gpes();
 
 	return result;
 }
Index: linux-2.6/drivers/acpi/dock.c
===================================================================
--- linux-2.6.orig/drivers/acpi/dock.c
+++ linux-2.6/drivers/acpi/dock.c
@@ -725,6 +725,7 @@ static void dock_notify(acpi_handle hand
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
 			dock_lock(ds, 1);
+			acpi_update_gpes();
 			break;
 		}
 		if (dock_present(ds) || dock_in_progress(ds))
