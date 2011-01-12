From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/9] ACPICA: Implicit notify support
Date: Wed, 12 Jan 2011 04:38:07 -0500
Message-ID: <bba63a296ffab20e08d9e8252d2f0d99050ac859.1294824789.git.len.brown@intel.com>
References: <1294825090-21150-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:36648 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab1ALJic (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 04:38:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW0049VLG4OJ51@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 03:38:32 -0600 (CST)
In-reply-to: <1294825090-21150-1-git-send-email-lenb@kernel.org>
In-reply-to: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
References: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

This feature provides an automatic device notification for wake devices
when a wakeup GPE occurs and there is no corresponding GPE method or
handler. Rather than ignoring such a GPE, an implicit AML Notify
operation is performed on the parent device object.
This feature is not part of the ACPI specification and is provided for
Windows compatibility only.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acevents.h  |    2 +
 drivers/acpi/acpica/aclocal.h   |    1 +
 drivers/acpi/acpica/evgpe.c     |  172 +++++++++++++++++++++++----------------
 drivers/acpi/acpica/evgpeblk.c  |   11 ++-
 drivers/acpi/acpica/evgpeinit.c |    1 +
 drivers/acpi/acpica/evxfgpe.c   |   58 +++++++++++---
 drivers/acpi/ec.c               |    2 +-
 drivers/acpi/scan.c             |    2 +-
 include/acpi/acpixf.h           |    6 +-
 include/acpi/actypes.h          |   39 +++++----
 10 files changed, 187 insertions(+), 107 deletions(-)

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
index c259995..2dbca95 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -115,12 +115,13 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
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
 
@@ -486,12 +487,26 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
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
 
@@ -518,6 +533,11 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
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
@@ -531,6 +551,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	return_VOID;
 }
 
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_asynch_enable_gpe
@@ -541,38 +562,60 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
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
@@ -595,6 +638,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		    struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 {
 	acpi_status status;
+	u32 return_value;
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
@@ -616,54 +660,49 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
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
@@ -690,17 +729,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
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
index 4c8dea5..734a494 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -415,6 +415,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
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
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8188772..fa848c4 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -619,7 +619,7 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 		wake_up(&ec->wait);
 		ec_check_sci(ec, acpi_ec_read_status(ec));
 	}
-	return ACPI_INTERRUPT_HANDLED;
+	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
 }
 
 /* --------------------------------------------------------------------------
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 70249b3..ce6741e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -778,7 +778,7 @@ acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
 		wakeup->resources.handles[i] = element->reference.handle;
 	}
 
-	acpi_setup_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
+	acpi_setup_gpe_for_wake(handle, wakeup->gpe_device, wakeup->gpe_number);
 
  out:
 	kfree(buffer.pointer);
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
1.7.4.rc1.7.g2cf08

