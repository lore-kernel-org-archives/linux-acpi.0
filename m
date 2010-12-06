From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 4/6] ACPICA: Implicit notify support
Date: Mon, 06 Dec 2010 23:58:58 +0800
Message-ID: <1291651138.2197.86.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40267 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab0LFP6l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 10:58:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

This feature provides an automatic device notification for wake devices
when a wakeup GPE occurs and there is no corresponding GPE method or
handler. Rather than ignoring such a GPE, an implicit AML Notify
operation is performed on the parent device object.
This feature is not part of the ACPI specification and is provided for
Windows compatibility only. 

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acevents.h  |    2 +
 drivers/acpi/acpica/aclocal.h   |    1 +
 drivers/acpi/acpica/evgpe.c     |  242 ++++++++++++++++++++++++---------------
 drivers/acpi/acpica/evgpeblk.c  |   11 ++-
 drivers/acpi/acpica/evgpeinit.c |    1 +
 drivers/acpi/acpica/evxfgpe.c   |   58 ++++++++--
 drivers/acpi/scan.c             |    3 +-
 include/acpi/acpixf.h           |    6 +-
 include/acpi/actypes.h          |   37 ++++---
 9 files changed, 237 insertions(+), 124 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 04a83fe..70e0b28 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -91,6 +91,8 @@ struct acpi_gpe_event_info *acpi_ev_low_get_gpe_info(u32 gpe_number,
 						     struct acpi_gpe_block_info
 						     *gpe_block);
 
+acpi_status acpi_ev_finish_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 /*
  * evgpeblk - Upper-level GPE block support
  */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6a71f8e..74000f5 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -419,6 +419,7 @@ struct acpi_gpe_handler_info {
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
 	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
+	struct acpi_namespace_node *device_node;        /* Parent _PRW device for implicit notify */
 };
 
 /*
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 3fb621e..56a7805 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -52,6 +52,8 @@ ACPI_MODULE_NAME("evgpe")
 /* Local prototypes */
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context);
 
+static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_update_gpe_enable_mask
@@ -113,12 +115,13 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
 	/*
-	 * We will only allow a GPE to be enabled if it has either an
-	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
-	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
-	 * first time it fires.
+	 * We will only allow a GPE to be enabled if it has either an associated
+	 * method (_Lxx/_Exx) or a handler, or is using the implicit notify
+	 * feature. Otherwise, the GPE will be immediately disabled by
+	 * acpi_ev_gpe_dispatch the first time it fires.
 	 */
-	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	    ACPI_GPE_DISPATCH_NONE) {
 		return_ACPI_STATUS(AE_NO_HANDLER);
 	}
 
@@ -441,17 +444,25 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
  *              an interrupt handler.
  *
  ******************************************************************************/
-static void acpi_ev_asynch_enable_gpe(void *context);
 
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 {
-	struct acpi_gpe_event_info *gpe_event_info = (void *)context;
+	struct acpi_gpe_event_info *gpe_event_info = context;
 	acpi_status status;
-	struct acpi_gpe_event_info local_gpe_event_info;
+	struct acpi_gpe_event_info *local_gpe_event_info;
 	struct acpi_evaluate_info *info;
 
 	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
 
+	/* Allocate a local GPE block */
+
+	local_gpe_event_info =
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_event_info));
+	if (!local_gpe_event_info) {
+		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "while handling a GPE"));
+		return_VOID;
+	}
+
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_VOID;
@@ -468,7 +479,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	 * Take a snapshot of the GPE info for this level - we copy the info to
 	 * prevent a race condition with remove_handler/remove_block.
 	 */
-	ACPI_MEMCPY(&local_gpe_event_info, gpe_event_info,
+	ACPI_MEMCPY(local_gpe_event_info, gpe_event_info,
 		    sizeof(struct acpi_gpe_event_info));
 
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
@@ -476,12 +487,26 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		return_VOID;
 	}
 
-	/*
-	 * Must check for control method type dispatch one more time to avoid a
-	 * race with ev_gpe_install_handler
-	 */
-	if ((local_gpe_event_info.flags & ACPI_GPE_DISPATCH_MASK) ==
-	    ACPI_GPE_DISPATCH_METHOD) {
+	/* Do the correct dispatch - normal method or implicit notify */
+
+	switch (local_gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
+	case ACPI_GPE_DISPATCH_NOTIFY:
+
+		/*
+		 * Implicit notify.
+		 * Dispatch a DEVICE_WAKE notify to the appropriate handler.
+		 * NOTE: the request is queued for execution after this method
+		 * completes. The notify handlers are NOT invoked synchronously
+		 * from this thread -- because handlers may in turn run other
+		 * control methods.
+		 */
+		status =
+		    acpi_ev_queue_notify_request(local_gpe_event_info->dispatch.
+						 device_node,
+						 ACPI_NOTIFY_DEVICE_WAKE);
+		break;
+
+	case ACPI_GPE_DISPATCH_METHOD:
 
 		/* Allocate the evaluation information block */
 
@@ -494,7 +519,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			 * control method that corresponds to this GPE
 			 */
 			info->prefix_node =
-			    local_gpe_event_info.dispatch.method_node;
+			    local_gpe_event_info->dispatch.method_node;
 			info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 			status = acpi_ns_evaluate(info);
@@ -505,41 +530,91 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			ACPI_EXCEPTION((AE_INFO, status,
 					"while evaluating GPE method [%4.4s]",
 					acpi_ut_get_node_name
-					(local_gpe_event_info.dispatch.
+					(local_gpe_event_info->dispatch.
 					 method_node)));
 		}
+
+		break;
+
+	default:
+		return_VOID;	/* Should never happen */
 	}
+
 	/* Defer enabling of GPE until all notify handlers are done */
-	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_asynch_enable_gpe,
-				gpe_event_info);
+
+	status = acpi_os_execute(OSL_NOTIFY_HANDLER,
+				 acpi_ev_asynch_enable_gpe,
+				 local_gpe_event_info);
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(local_gpe_event_info);
+	}
 	return_VOID;
 }
 
-static void acpi_ev_asynch_enable_gpe(void *context)
-{
-	struct acpi_gpe_event_info *gpe_event_info = context;
-	acpi_status status;
-	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
-	    ACPI_GPE_LEVEL_TRIGGERED) {
-		/*
-		 * GPE is level-triggered, we clear the GPE status bit after handling
-		 * the event.
-		 */
-		status = acpi_hw_clear_gpe(gpe_event_info);
-		if (ACPI_FAILURE(status)) {
-			return_VOID;
-		}
-	}
 
-	/*
-	 * Enable this GPE, conditionally. This means that the GPE will only be
-	 * physically enabled if the enable_for_run bit is set in the event_info
-	 */
-	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_asynch_enable_gpe
+ *
+ * PARAMETERS:  Context (gpe_event_info) - Info for this GPE
+ *              Callback from acpi_os_execute
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Asynchronous clear/enable for GPE. This allows the GPE to
+ *              complete (i.e., finish execution of Notify)
+ *
+ ******************************************************************************/
 
-	return_VOID;
+static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context)
+ {
+ 	struct acpi_gpe_event_info *gpe_event_info = context;
+
+	(void)acpi_ev_finish_gpe(gpe_event_info);
+
+	ACPI_FREE(gpe_event_info);
+	return;
 }
 
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_finish_gpe
+ *
+ * PARAMETERS:  gpe_event_info      - Info for this GPE
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear/Enable a GPE. Common code that is used after execution
+ *              of a GPE method or a synchronous or asynchronous GPE handler.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ev_finish_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+ 	acpi_status status;
+
+ 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
+ 	    ACPI_GPE_LEVEL_TRIGGERED) {
+ 		/*
+		 * GPE is level-triggered, we clear the GPE status bit after
+		 * handling the event.
+ 		 */
+ 		status = acpi_hw_clear_gpe(gpe_event_info);
+ 		if (ACPI_FAILURE(status)) {
+			return (status);
+ 		}
+ 	}
+ 
+ 	/*
+	 * Enable this GPE, conditionally. This means that the GPE will
+	 * only be physically enabled if the enable_for_run bit is set
+	 * in the event_info.
+ 	 */
+	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
+	return (AE_OK);
+}
+ 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_gpe_dispatch
@@ -562,6 +637,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		    struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 {
 	acpi_status status;
+	u32 return_value;
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
@@ -583,54 +659,49 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 	}
 
 	/*
-	 * Dispatch the GPE to either an installed handler, or the control method
-	 * associated with this GPE (_Lxx or _Exx). If a handler exists, we invoke
-	 * it and do not attempt to run the method. If there is neither a handler
-	 * nor a method, we disable this GPE to prevent further such pointless
-	 * events from firing.
+	 * Always disable the GPE so that it does not keep firing before
+	 * any asynchronous activity completes (either from the execution
+	 * of a GPE method or an asynchronous GPE handler.)
+	 *
+	 * If there is no handler or method to run, just disable the
+	 * GPE and leave it disabled permanently to prevent further such
+	 * pointless events from firing.
+	 */
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Unable to disable GPE%02X", gpe_number));
+		return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
+	}
+
+	/*
+	 * Dispatch the GPE to either an installed handler or the control
+	 * method associated with this GPE (_Lxx or _Exx). If a handler
+	 * exists, we invoke it and do not attempt to run the method.
+	 * If there is neither a handler nor a method, leave the GPE
+	 * disabled.
 	 */
 	switch (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
 	case ACPI_GPE_DISPATCH_HANDLER:
 
-		/*
-		 * Invoke the installed handler (at interrupt level)
-		 * Ignore return status for now.
-		 * TBD: leave GPE disabled on error?
-		 */
-		(void)gpe_event_info->dispatch.handler->address(gpe_device,
-								gpe_number,
-								gpe_event_info->
-								dispatch.
-								handler->
-								context);
-
-		/* It is now safe to clear level-triggered events. */
-
-		if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
-		    ACPI_GPE_LEVEL_TRIGGERED) {
-			status = acpi_hw_clear_gpe(gpe_event_info);
-			if (ACPI_FAILURE(status)) {
-				ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to clear GPE[0x%2X]",
-						gpe_number));
-				return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
-			}
+		/* Invoke the installed handler (at interrupt level) */
+
+		return_value =
+		    gpe_event_info->dispatch.handler->address(gpe_device,
+							      gpe_number,
+							      gpe_event_info->
+							      dispatch.handler->
+							      context);
+
+		/* If requested, clear (if level-triggered) and reenable the GPE */
+
+		if (return_value & ACPI_REENABLE_GPE) {
+			(void)acpi_ev_finish_gpe(gpe_event_info);
 		}
 		break;
 
 	case ACPI_GPE_DISPATCH_METHOD:
-
-		/*
-		 * Disable the GPE, so it doesn't keep firing before the method has a
-		 * chance to run (it runs asynchronously with interrupts enabled).
-		 */
-		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to disable GPE[0x%2X]",
-					gpe_number));
-			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
-		}
+	case ACPI_GPE_DISPATCH_NOTIFY:
 
 		/*
 		 * Execute the method associated with the GPE
@@ -657,17 +728,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 			    "No handler or method for GPE[0x%2X], disabling event",
 			    gpe_number));
 
-		/*
-		 * Disable the GPE. The GPE will remain disabled a handler
-		 * is installed or ACPICA is restarted.
-		 */
-		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to disable GPE[0x%2X]",
-					gpe_number));
-			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
-		}
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 2a445df..e2e8164 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -472,9 +472,14 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			gpe_index = (i * ACPI_GPE_REGISTER_WIDTH) + j;
 			gpe_event_info = &gpe_block->event_info[gpe_index];
 
-			/* Ignore GPEs that have no corresponding _Lxx/_Exx method */
-
-			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)
+			/*
+			 * Ignore GPEs that have no corresponding _Lxx/_Exx method
+			 * and GPEs that are used to wake the system
+			 */
+			if (((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+			     ACPI_GPE_DISPATCH_NONE)
+			    || ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
+				== ACPI_GPE_DISPATCH_HANDLER)
 			    || (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 				continue;
 			}
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 2c7def9..223dba2 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -412,6 +412,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	 * Add the GPE information from above to the gpe_event_info block for
 	 * use during dispatch of this GPE.
 	 */
+	gpe_event_info->flags &= ~(ACPI_GPE_DISPATCH_MASK);
 	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_METHOD);
 	gpe_event_info->dispatch.method_node = method_node;
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 99f77ab..fcf4a5c 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -166,39 +166,75 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 }
 ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
 
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_setup_gpe_for_wake
  *
- * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
- *              gpe_number      - GPE level within the GPE block
+ * PARAMETERS:  wake_device         - Device associated with the GPE (via _PRW)
+ *              gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Set the ACPI_GPE_CAN_WAKE flag for the given GPE.  If the GPE
- *              has a corresponding method and is currently enabled, disable it
- *              (GPEs with corresponding methods are enabled unconditionally
- *              during initialization, but GPEs that can wake up are expected
- *              to be initially disabled).
+ * DESCRIPTION: Mark a GPE as having the ability to wake the system. This
+ *              interface is intended to be used as the host executes the
+ *              _PRW methods (Power Resources for Wake) in the system tables.
+ *              Each _PRW appears under a Device Object (The wake_device), and
+ *              contains the info for the wake GPE associated with the
+ *              wake_device.
  *
  ******************************************************************************/
-acpi_status acpi_setup_gpe_for_wake(acpi_handle gpe_device, u32 gpe_number)
+acpi_status
+acpi_setup_gpe_for_wake(acpi_handle wake_device,
+			acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_OK;
+	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_namespace_node *device_node;
 	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_setup_gpe_for_wake);
 
+	/* Parameter Validation */
+
+	if (!wake_device) {
+		/*
+		 * By forcing wake_device to be valid, we automatically enable the
+		 * implicit notify feature on all hosts.
+		 */
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	/* Validate wake_device is of type Device */
+
+	device_node = ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
+	if (device_node->type != ACPI_TYPE_DEVICE) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
+		/*
+		 * If there is no method or handler for this GPE, then the
+		 * wake_device will be notified whenever this GPE fires (aka
+		 * "implicit notify") Note: The GPE is assumed to be
+		 * level-triggered (for windows compatibility).
+		 */
+		if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+		    ACPI_GPE_DISPATCH_NONE) {
+			gpe_event_info->flags =
+			    (ACPI_GPE_DISPATCH_NOTIFY |
+			     ACPI_GPE_LEVEL_TRIGGERED);
+			gpe_event_info->dispatch.device_node = device_node;
+		}
+
 		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
-	} else {
-		status = AE_BAD_PARAMETER;
+		status = AE_OK;
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index afdbd6e..8d77cf5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -750,7 +750,8 @@ acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
 		device->wakeup.resources.handles[i] = element->reference.handle;
 	}
 
-	acpi_setup_gpe_for_wake(device->wakeup.gpe_device, device->wakeup.gpe_number);
+	acpi_setup_gpe_for_wake(device->wakeup.gpe_device, NULL,
+		device->wakeup.gpe_number);
 
 	return AE_OK;
 }
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b806e56..9de6a17 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -292,10 +292,12 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
-acpi_status acpi_setup_gpe_for_wake(acpi_handle gpe_device, u32 gpe_number);
-
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 
+acpi_status
+acpi_setup_gpe_for_wake(acpi_handle parent_device,
+			acpi_handle gpe_device, u32 gpe_number);
+
 acpi_status acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
 acpi_status
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index b9575ad..d7274ee 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -664,25 +664,26 @@ typedef u32 acpi_event_status;
 
 /*
  * GPE info flags - Per GPE
- * +-------+---+-+-+
- * |  7:4  |3:2|1|0|
- * +-------+---+-+-+
- *     |     |  | |
- *     |     |  | +--- Interrupt type: edge or level triggered
- *     |     |  +----- GPE can wake the system
- *     |     +-------- Type of dispatch:to method, handler, or none
- *     +-------------- <Reserved>
+ * +-------+-+-+---+
+ * |  7:4  |3|2|1:0|
+ * +-------+-+-+---+
+ *     |    | |  |
+ *     |    | |  +-- Type of dispatch:to method, handler, notify, or none
+ *     |    | +----- Interrupt type: edge or level triggered
+ *     |    +------- Is a Wake GPE
+ *     +------------ <Reserved>
  */
-#define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x01
-#define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x01
-#define ACPI_GPE_EDGE_TRIGGERED         (u8) 0x00
+#define ACPI_GPE_DISPATCH_NONE          (u8) 0x00
+#define ACPI_GPE_DISPATCH_METHOD        (u8) 0x01
+#define ACPI_GPE_DISPATCH_HANDLER       (u8) 0x02
+#define ACPI_GPE_DISPATCH_NOTIFY        (u8) 0x03
+#define ACPI_GPE_DISPATCH_MASK          (u8) 0x03
 
-#define ACPI_GPE_CAN_WAKE		(u8) 0x02
+#define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x04
+#define ACPI_GPE_EDGE_TRIGGERED         (u8) 0x00
+#define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x04
 
-#define ACPI_GPE_DISPATCH_MASK          (u8) 0x0C
-#define ACPI_GPE_DISPATCH_HANDLER       (u8) 0x04
-#define ACPI_GPE_DISPATCH_METHOD        (u8) 0x08
-#define ACPI_GPE_DISPATCH_NOT_USED      (u8) 0x00
+#define ACPI_GPE_CAN_WAKE               (u8) 0x08
 
 /*
  * Flags for GPE and Lock interfaces
@@ -954,6 +955,10 @@ u32 (*acpi_interface_handler) (acpi_string interface_name, u32 supported);
 #define ACPI_INTERRUPT_NOT_HANDLED      0x00
 #define ACPI_INTERRUPT_HANDLED          0x01
 
+/* GPE handler return values */
+
+#define ACPI_REENABLE_GPE               0x80
+
 /* Length of 32-bit EISAID values when converted back to a string */
 
 #define ACPI_EISAID_STRING_SIZE         8	/* Includes null terminator */
-- 
1.5.3




