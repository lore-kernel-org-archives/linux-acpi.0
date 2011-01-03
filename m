From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 6/8] ACPICA: Implicit notify support
Date: Tue, 4 Jan 2011 00:46:17 +0100
Message-ID: <201101040046.17980.rjw@sisk.pl>
References: <1292218757.10384.95.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54031 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab1ACXqy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jan 2011 18:46:54 -0500
In-Reply-To: <1292218757.10384.95.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Monday, December 13, 2010, Lin Ming wrote:
> This feature provides an automatic device notification for wake devices
> when a wakeup GPE occurs and there is no corresponding GPE method or
> handler. Rather than ignoring such a GPE, an implicit AML Notify
> operation is performed on the parent device object.
> This feature is not part of the ACPI specification and is provided for
> Windows compatibility only.
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Unfortunately, this patch contains a bug:

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index afdbd6e..8d77cf5 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -750,7 +750,8 @@ acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
>  		device->wakeup.resources.handles[i] = element->reference.handle;
>  	}
>  
> -	acpi_setup_gpe_for_wake(device->wakeup.gpe_device, device->wakeup.gpe_number);
> +	acpi_setup_gpe_for_wake(device->wakeup.gpe_device, NULL,
> +		device->wakeup.gpe_number);

because this change makes acpi_setup_gpe_for_wake() return with error code (the
first argument here should be device->handle and the second one should be
device->wakeup.gpe_device instead of NULL).

Appended is a rebased and fixed replacement of this patch (it also contains a
missing change in ec.c).

Thanks,
Rafael

---
From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA: Implicit notify support (v2)

This feature provides an automatic device notification for wake devices
when a wakeup GPE occurs and there is no corresponding GPE method or
handler. Rather than ignoring such a GPE, an implicit AML Notify
operation is performed on the parent device object.
This feature is not part of the ACPI specification and is provided for
Windows compatibility only.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acevents.h  |    2 
 drivers/acpi/acpica/aclocal.h   |    1 
 drivers/acpi/acpica/evgpe.c     |  172 +++++++++++++++++++++++-----------------
 drivers/acpi/acpica/evgpeblk.c  |   11 +-
 drivers/acpi/acpica/evgpeinit.c |    1 
 drivers/acpi/acpica/evxfgpe.c   |   58 ++++++++++---
 drivers/acpi/ec.c               |    2 
 drivers/acpi/scan.c             |    2 
 include/acpi/acpixf.h           |    6 -
 include/acpi/actypes.h          |   39 +++++----
 10 files changed, 187 insertions(+), 107 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -91,6 +91,8 @@ struct acpi_gpe_event_info *acpi_ev_low_
 						     struct acpi_gpe_block_info
 						     *gpe_block);
 
+acpi_status acpi_ev_finish_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 /*
  * evgpeblk - Upper-level GPE block support
  */
Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -419,6 +419,7 @@ struct acpi_gpe_handler_info {
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
 	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
+	struct acpi_namespace_node *device_node;        /* Parent _PRW device for implicit notify */
 };
 
 /*
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -115,12 +115,13 @@ acpi_ev_enable_gpe(struct acpi_gpe_event
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
 
@@ -486,12 +487,26 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 		return_VOID;
 	}
 
-	/*
-	 * Must check for control method type dispatch one more time to avoid a
-	 * race with ev_gpe_install_handler
-	 */
-	if ((local_gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
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
 
@@ -518,6 +533,11 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 					(local_gpe_event_info->dispatch.
 					 method_node)));
 		}
+
+		break;
+
+	default:
+		return_VOID;    /* Should never happen */
 	}
 
 	/* Defer enabling of GPE until all notify handlers are done */
@@ -531,6 +551,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 	return_VOID;
 }
 
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_asynch_enable_gpe
@@ -541,38 +562,60 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
  * RETURN:      None
  *
  * DESCRIPTION: Asynchronous clear/enable for GPE. This allows the GPE to
- *              complete.
+ *              complete (i.e., finish execution of Notify)
  *
  ******************************************************************************/
 
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info = context;
+
+	(void)acpi_ev_finish_gpe(gpe_event_info);
+
+	ACPI_FREE(gpe_event_info);
+	return;
+}
+
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
 	acpi_status status;
 
 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
 	    ACPI_GPE_LEVEL_TRIGGERED) {
 		/*
-		 * GPE is level-triggered, we clear the GPE status bit after handling
-		 * the event.
+		 * GPE is level-triggered, we clear the GPE status bit after
+		 * handling the event.
 		 */
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
-			goto exit;
+			return (status);
 		}
 	}
 
 	/*
-	 * Enable this GPE, conditionally. This means that the GPE will only be
-	 * physically enabled if the enable_for_run bit is set in the event_info
+	 * Enable this GPE, conditionally. This means that the GPE will
+	 * only be physically enabled if the enable_for_run bit is set
+	 * in the event_info.
 	 */
 	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
-
-exit:
-	ACPI_FREE(gpe_event_info);
-	return;
+	return (AE_OK);
 }
 
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_gpe_dispatch
@@ -595,6 +638,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
 		    struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 {
 	acpi_status status;
+	u32 return_value;
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
@@ -616,54 +660,49 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
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
@@ -690,17 +729,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
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
 
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -472,9 +472,14 @@ acpi_ev_initialize_gpe_block(struct acpi
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
Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c
+++ linux-2.6/drivers/acpi/acpica/evgpeinit.c
@@ -415,6 +415,7 @@ acpi_ev_match_gpe_method(acpi_handle obj
 	 * Add the GPE information from above to the gpe_event_info block for
 	 * use during dispatch of this GPE.
 	 */
+	gpe_event_info->flags &= ~(ACPI_GPE_DISPATCH_MASK);
 	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_METHOD);
 	gpe_event_info->dispatch.method_node = method_node;
 
Index: linux-2.6/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-2.6/drivers/acpi/acpica/evxfgpe.c
@@ -166,39 +166,75 @@ acpi_status acpi_disable_gpe(acpi_handle
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
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -778,7 +778,7 @@ acpi_bus_extract_wakeup_device_power_pac
 		wakeup->resources.handles[i] = element->reference.handle;
 	}
 
-	acpi_setup_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
+	acpi_setup_gpe_for_wake(handle, wakeup->gpe_device, wakeup->gpe_number);
 
  out:
 	kfree(buffer.pointer);
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -292,10 +292,12 @@ acpi_status acpi_enable_gpe(acpi_handle
 
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
Index: linux-2.6/include/acpi/actypes.h
===================================================================
--- linux-2.6.orig/include/acpi/actypes.h
+++ linux-2.6/include/acpi/actypes.h
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
- */
-#define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x01
-#define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x01
-#define ACPI_GPE_EDGE_TRIGGERED         (u8) 0x00
+ * +-------+-+-+---+
+ * |  7:4  |3|2|1:0|
+ * +-------+-+-+---+
+ *     |    | |  |
+ *     |    | |  +-- Type of dispatch:to method, handler, notify, or none
+ *     |    | +----- Interrupt type: edge or level triggered
+ *     |    +------- Is a Wake GPE
+ *     +------------ <Reserved>
+ */
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
@@ -954,6 +955,10 @@ u32 (*acpi_interface_handler) (acpi_stri
 #define ACPI_INTERRUPT_NOT_HANDLED      0x00
 #define ACPI_INTERRUPT_HANDLED          0x01
 
+/* GPE handler return values */
+
+#define ACPI_REENABLE_GPE               0x80
+
 /* Length of 32-bit EISAID values when converted back to a string */
 
 #define ACPI_EISAID_STRING_SIZE         8	/* Includes null terminator */
Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -619,7 +619,7 @@ static u32 acpi_ec_gpe_handler(acpi_hand
 		wake_up(&ec->wait);
 		ec_check_sci(ec, acpi_ec_read_status(ec));
 	}
-	return ACPI_INTERRUPT_HANDLED;
+	return (ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE);
 }
 
 /* --------------------------------------------------------------------------
