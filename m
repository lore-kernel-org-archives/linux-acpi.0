From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 2/6] ACPICA: Rename some function and variable names
Date: Mon, 06 Dec 2010 23:58:40 +0800
Message-ID: <1291651120.2197.80.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab0LFP6R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 10:58:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Some function and variable names are renamed to be consistent with
ACPICA code base.

acpi_raw_enable_gpe -> acpi_ev_add_gpe_reference
acpi_raw_disable_gpe -> acpi_ev_remove_gpe_reference
acpi_gpe_can_wake -> acpi_setup_gpe_for_wake
acpi_gpe_wakeup -> acpi_set_gpe_wake_mask
acpi_update_gpes -> acpi_update_all_gpes
acpi_all_gpes_initialized -> acpi_gbl_all_gpes_initialized
acpi_handler_info -> acpi_gpe_handler_info
...

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acevents.h   |    9 +++---
 drivers/acpi/acpica/acglobal.h   |    2 +-
 drivers/acpi/acpica/aclocal.h    |   12 ++++----
 drivers/acpi/acpica/evgpe.c      |   28 +++++++++++++------
 drivers/acpi/acpica/evgpeblk.c   |    4 +-
 drivers/acpi/acpica/evxface.c    |   26 +++++++++---------
 drivers/acpi/acpica/evxfgpe.c    |   53 +++++++++++++++++++++++--------------
 drivers/acpi/acpica/hwgpe.c      |    2 +-
 drivers/acpi/acpica/utglobal.c   |    2 +-
 drivers/acpi/dock.c              |    2 +-
 drivers/acpi/ec.c                |    3 +-
 drivers/acpi/scan.c              |    6 ++--
 drivers/acpi/wakeup.c            |    4 +-
 drivers/char/ipmi/ipmi_si_intf.c |    3 +-
 include/acpi/acpixf.h            |   10 +++---
 include/acpi/actypes.h           |    7 +++-
 16 files changed, 101 insertions(+), 72 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 43f15c8..ebb467f 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -82,9 +82,9 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status acpi_raw_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+acpi_status acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
 
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
@@ -107,12 +107,13 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 acpi_status
 acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			     struct acpi_gpe_block_info *gpe_block,
-			     void *ignored);
+			     void *context);
 
 acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block);
 
 u32
-acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info,
+acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
+		     struct acpi_gpe_event_info *gpe_event_info,
 		     u32 gpe_number);
 
 /*
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ad88fca..fc69464 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -370,7 +370,7 @@ ACPI_EXTERN struct acpi_fixed_event_handler
 ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
 ACPI_EXTERN struct acpi_gpe_block_info
 *acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
-ACPI_EXTERN u8 acpi_all_gpes_initialized;
+ACPI_EXTERN u8 acpi_gbl_all_gpes_initialized;
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 2ceb0c0..6a71f8e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -408,17 +408,17 @@ struct acpi_predefined_data {
 
 /* Dispatch info for each GPE -- either a method or handler, cannot be both */
 
-struct acpi_handler_info {
-	acpi_event_handler address;	/* Address of handler, if any */
+struct acpi_gpe_handler_info {
+	acpi_gpe_handler address;	/* Address of handler, if any */
 	void *context;		/* Context to be passed to handler */
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level (saved) */
-	u8 orig_flags;		/* Original misc info about this GPE */
-	u8 orig_enabled;	/* Set if the GPE was originally enabled */
+	u8 original_flags;      /* Original (pre-handler) GPE info */
+	u8 originally_enabled;  /* True if GPE was originally enabled */
 };
 
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
-	struct acpi_handler_info *handler;
+	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
 };
 
 /*
@@ -458,7 +458,7 @@ struct acpi_gpe_block_info {
 	u32 register_count;	/* Number of register pairs in block */
 	u16 gpe_count;		/* Number of individual GPEs in block */
 	u8 block_base_number;	/* Base GPE number for this block */
-	u8 initialized;         /* If set, the GPE block has been initialized */
+	u8 initialized;         /* TRUE if this block is initialized */
 };
 
 /* Information about GPE interrupt handlers, one per each interrupt level used for GPEs */
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index f226eac..3fb621e 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -137,7 +137,7 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_raw_enable_gpe
+ * FUNCTION:    acpi_ev_add_gpe_reference
  *
  * PARAMETERS:  gpe_event_info  - GPE to enable
  *
@@ -148,10 +148,12 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  ******************************************************************************/
 
-acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status = AE_OK;
 
+	ACPI_FUNCTION_TRACE(ev_add_gpe_reference);
+
 	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
 		return_ACPI_STATUS(AE_LIMIT);
 	}
@@ -173,7 +175,7 @@ acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_raw_disable_gpe
+ * FUNCTION:    acpi_ev_remove_gpe_reference
  *
  * PARAMETERS:  gpe_event_info  - GPE to disable
  *
@@ -184,10 +186,12 @@ acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  ******************************************************************************/
 
-acpi_status acpi_raw_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status = AE_OK;
 
+	ACPI_FUNCTION_TRACE(ev_remove_gpe_reference);
+
 	if (!gpe_event_info->runtime_count) {
 		return_ACPI_STATUS(AE_LIMIT);
 	}
@@ -405,7 +409,9 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 					 * or method.
 					 */
 					int_status |=
-					    acpi_ev_gpe_dispatch(&gpe_block->
+					    acpi_ev_gpe_dispatch(gpe_block->
+								 node,
+								 &gpe_block->
 						event_info[((acpi_size) i * ACPI_GPE_REGISTER_WIDTH) + j], j + gpe_register_info->base_gpe_number);
 				}
 			}
@@ -529,7 +535,7 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 	 * Enable this GPE, conditionally. This means that the GPE will only be
 	 * physically enabled if the enable_for_run bit is set in the event_info
 	 */
-	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_COND_ENABLE);
+	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
 
 	return_VOID;
 }
@@ -538,7 +544,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
  *
  * FUNCTION:    acpi_ev_gpe_dispatch
  *
- * PARAMETERS:  gpe_event_info  - Info for this GPE
+ * PARAMETERS:  gpe_device      - Device node. NULL for GPE0/GPE1
+ *              gpe_event_info  - Info for this GPE
  *              gpe_number      - Number relative to the parent GPE block
  *
  * RETURN:      INTERRUPT_HANDLED or INTERRUPT_NOT_HANDLED
@@ -551,7 +558,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
  ******************************************************************************/
 
 u32
-acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
+acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
+		    struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 {
 	acpi_status status;
 
@@ -589,7 +597,9 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 		 * Ignore return status for now.
 		 * TBD: leave GPE disabled on error?
 		 */
-		(void)gpe_event_info->dispatch.handler->address(gpe_event_info->
+		(void)gpe_event_info->dispatch.handler->address(gpe_device,
+								gpe_number,
+								gpe_event_info->
 								dispatch.
 								handler->
 								context);
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 020add3..2a445df 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -386,7 +386,7 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 		return_ACPI_STATUS(status);
 	}
 
-	acpi_all_gpes_initialized = FALSE;
+	acpi_gbl_all_gpes_initialized = FALSE;
 
 	/* Find all GPE methods (_Lxx or_Exx) for this block */
 
@@ -479,7 +479,7 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				continue;
 			}
 
-			status = acpi_raw_enable_gpe(gpe_event_info);
+			status = acpi_ev_add_gpe_reference(gpe_event_info);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 					"Could not enable GPE 0x%02X",
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 36af222..d193b90 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -671,10 +671,10 @@ ACPI_EXPORT_SYMBOL(acpi_remove_notify_handler)
 acpi_status
 acpi_install_gpe_handler(acpi_handle gpe_device,
 			 u32 gpe_number,
-			 u32 type, acpi_event_handler address, void *context)
+			 u32 type, acpi_gpe_handler address, void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_handler_info *handler;
+	struct acpi_gpe_handler_info *handler;
 	acpi_status status;
 	acpi_cpu_flags flags;
 
@@ -693,7 +693,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	/* Allocate memory for the handler object */
 
-	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
+	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_handler_info));
 	if (!handler) {
 		status = AE_NO_MEMORY;
 		goto unlock_and_exit;
@@ -722,7 +722,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	handler->address = address;
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
-	handler->orig_flags = gpe_event_info->flags &
+	handler->original_flags = gpe_event_info->flags &
 			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
 
 	/*
@@ -731,10 +731,10 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	 * disabled now to avoid spurious execution of the handler.
 	 */
 
-	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
+	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
 	    && gpe_event_info->runtime_count) {
-		handler->orig_enabled = 1;
-		(void)acpi_raw_disable_gpe(gpe_event_info);
+		handler->originally_enabled = 1;
+		(void)acpi_ev_remove_gpe_reference(gpe_event_info);
 	}
 
 	/* Install the handler */
@@ -777,10 +777,10 @@ ACPI_EXPORT_SYMBOL(acpi_install_gpe_handler)
  ******************************************************************************/
 acpi_status
 acpi_remove_gpe_handler(acpi_handle gpe_device,
-			u32 gpe_number, acpi_event_handler address)
+			u32 gpe_number, acpi_gpe_handler address)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_handler_info *handler;
+	struct acpi_gpe_handler_info *handler;
 	acpi_status status;
 	acpi_cpu_flags flags;
 
@@ -835,7 +835,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	gpe_event_info->dispatch.method_node = handler->method_node;
 	gpe_event_info->flags &=
 		~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
-	gpe_event_info->flags |= handler->orig_flags;
+	gpe_event_info->flags |= handler->original_flags;
 
 	/*
 	 * If the GPE was previously associated with a method and it was
@@ -843,9 +843,9 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	 * post-initialization configuration.
 	 */
 
-	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && handler->orig_enabled)
-		(void)acpi_raw_enable_gpe(gpe_event_info);
+	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
+	    && handler->originally_enabled)
+		(void)acpi_ev_add_gpe_reference(gpe_event_info);
 
 	/* Now we can free the handler object */
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 8068065..99f77ab 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -51,7 +51,7 @@ ACPI_MODULE_NAME("evxfgpe")
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_update_gpes
+ * FUNCTION:    acpi_update_all_gpes
  *
  * PARAMETERS:  None
  *
@@ -65,30 +65,34 @@ ACPI_MODULE_NAME("evxfgpe")
  *
  ******************************************************************************/
 
-acpi_status acpi_update_gpes(void)
+acpi_status acpi_update_all_gpes(void)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(acpi_update_gpes);
+	ACPI_FUNCTION_TRACE(acpi_update_all_gpes);
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
-	} else if (acpi_all_gpes_initialized) {
-		goto unlock;
+	}
+
+	if (acpi_gbl_all_gpes_initialized) {
+		goto unlock_and_exit;
 	}
 
 	status = acpi_ev_walk_gpe_list(acpi_ev_initialize_gpe_block, NULL);
 	if (ACPI_SUCCESS(status)) {
-		acpi_all_gpes_initialized = TRUE;
+		acpi_gbl_all_gpes_initialized = TRUE;
 	}
 
-unlock:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_update_all_gpes)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enable_gpe
@@ -117,7 +121,7 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		status = acpi_raw_enable_gpe(gpe_event_info);
+		status = acpi_ev_add_gpe_reference(gpe_event_info);
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
@@ -154,7 +158,7 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		status = acpi_raw_disable_gpe(gpe_event_info) ;
+		status = acpi_ev_remove_gpe_reference(gpe_event_info) ;
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
@@ -164,7 +168,7 @@ ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_gpe_can_wake
+ * FUNCTION:    acpi_setup_gpe_for_wake
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
@@ -178,13 +182,13 @@ ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
  *              to be initially disabled).
  *
  ******************************************************************************/
-acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number)
+acpi_status acpi_setup_gpe_for_wake(acpi_handle gpe_device, u32 gpe_number)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
 
-	ACPI_FUNCTION_TRACE(acpi_gpe_can_wake);
+	ACPI_FUNCTION_TRACE(acpi_setup_gpe_for_wake);
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
@@ -200,11 +204,11 @@ acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number)
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
-ACPI_EXPORT_SYMBOL(acpi_gpe_can_wake)
+ACPI_EXPORT_SYMBOL(acpi_setup_gpe_for_wake)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_gpe_wakeup
+ * FUNCTION:    acpi_set_gpe_wake_mask
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
@@ -216,7 +220,7 @@ ACPI_EXPORT_SYMBOL(acpi_gpe_can_wake)
  *
  ******************************************************************************/
 
-acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action)
+acpi_status acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 action)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -224,18 +228,23 @@ acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action)
 	acpi_cpu_flags flags;
 	u32 register_bit;
 
-	ACPI_FUNCTION_TRACE(acpi_gpe_wakeup);
+	ACPI_FUNCTION_TRACE(acpi_set_gpe_wake_mask);
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info || !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
+	if (!gpe_event_info) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
 	}
 
+	if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
+		status = AE_TYPE;
+		goto unlock_and_exit;
+	}
+
 	gpe_register_info = gpe_event_info->register_info;
 	if (!gpe_register_info) {
 		status = AE_NOT_EXIST;
@@ -269,7 +278,7 @@ unlock_and_exit:
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
+ACPI_EXPORT_SYMBOL(acpi_set_gpe_wake_mask)
 
 /*******************************************************************************
  *
@@ -387,6 +396,8 @@ acpi_status acpi_disable_all_gpes(void)
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_disable_all_gpes)
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_enable_all_runtime_gpes
@@ -416,6 +427,8 @@ acpi_status acpi_enable_all_runtime_gpes(void)
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_enable_all_runtime_gpes)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_gpe_block
@@ -435,7 +448,7 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 		       struct acpi_generic_address *gpe_block_address,
 		       u32 register_count, u32 interrupt_number)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 	union acpi_operand_object *obj_desc;
 	struct acpi_namespace_node *node;
 	struct acpi_gpe_block_info *gpe_block;
@@ -603,7 +616,7 @@ acpi_get_gpe_device(u32 index, acpi_handle *gpe_device)
 		return_ACPI_STATUS(status);
 	}
 
-	*gpe_device = info.gpe_device;
+	*gpe_device = ACPI_CAST_PTR(acpi_handle, info.gpe_device);
 	return_ACPI_STATUS(info.status);
 }
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 14750db..7c6d485 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -118,7 +118,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 	switch (action) {
-	case ACPI_GPE_COND_ENABLE:
+	case ACPI_GPE_CONDITIONAL_ENABLE:
 		if (!(register_bit & gpe_register_info->enable_for_run))
 			return (AE_BAD_PARAMETER);
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index e87bc67..a99c32a 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -768,7 +768,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
 	acpi_current_gpe_count = 0;
-	acpi_all_gpes_initialized = FALSE;
+	acpi_gbl_all_gpes_initialized = FALSE;
 
 	/* Global handlers */
 
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 81514a4..1864ad3 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -725,7 +725,7 @@ static void dock_notify(acpi_handle handle, u32 event, void *data)
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
 			dock_lock(ds, 1);
-			acpi_update_gpes();
+			acpi_update_all_gpes();
 			break;
 		}
 		if (dock_present(ds) || dock_in_progress(ds))
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 372ff80..e15439a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -606,7 +606,8 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
 	return 0;
 }
 
-static u32 acpi_ec_gpe_handler(void *data)
+static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
+	u32 gpe_number, void *data)
 {
 	struct acpi_ec *ec = data;
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2b6c21d..afdbd6e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -750,7 +750,7 @@ acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
 		device->wakeup.resources.handles[i] = element->reference.handle;
 	}
 
-	acpi_gpe_can_wake(device->wakeup.gpe_device, device->wakeup.gpe_number);
+	acpi_setup_gpe_for_wake(device->wakeup.gpe_device, device->wakeup.gpe_number);
 
 	return AE_OK;
 }
@@ -1444,7 +1444,7 @@ int acpi_bus_start(struct acpi_device *device)
 
 	result = acpi_bus_scan(device->handle, &ops, NULL);
 
-	acpi_update_gpes();
+	acpi_update_all_gpes();
 
 	return result;
 }
@@ -1561,7 +1561,7 @@ int __init acpi_scan_init(void)
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
 	else
-		acpi_update_gpes();
+		acpi_update_all_gpes();
 
 	return result;
 }
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index f62a50c..c6cb68e 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -45,7 +45,7 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
 			acpi_enable_wakeup_device_power(dev, sleep_state);
 
 		/* The wake-up power should have been enabled already. */
-		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+		acpi_set_gpe_wake_mask(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
 				ACPI_GPE_ENABLE);
 	}
 }
@@ -67,7 +67,7 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 		    || (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
-		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+		acpi_set_gpe_wake_mask(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
 				ACPI_GPE_DISABLE);
 
 		if (dev->wakeup.state.enabled)
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 035da9e..c4bacc6 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1928,7 +1928,8 @@ static void __devinit hardcode_find_bmc(void)
 static int acpi_failure;
 
 /* For GPE-type interrupts. */
-static u32 ipmi_acpi_gpe(void *context)
+static u32 ipmi_acpi_gpe(acpi_handle gpe_device,
+	u32 gpe_number, void *context)
 {
 	struct smi_info *smi_info = context;
 	unsigned long   flags;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 53b7cfd..b806e56 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -258,11 +258,11 @@ acpi_remove_address_space_handler(acpi_handle device,
 acpi_status
 acpi_install_gpe_handler(acpi_handle gpe_device,
 			 u32 gpe_number,
-			 u32 type, acpi_event_handler address, void *context);
+			 u32 type, acpi_gpe_handler address, void *context);
 
 acpi_status
 acpi_remove_gpe_handler(acpi_handle gpe_device,
-			u32 gpe_number, acpi_event_handler address);
+			u32 gpe_number, acpi_gpe_handler address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
@@ -292,11 +292,11 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
-acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number);
+acpi_status acpi_setup_gpe_for_wake(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 
-acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action);
+acpi_status acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
@@ -315,7 +315,7 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 
 acpi_status acpi_remove_gpe_block(acpi_handle gpe_device);
 
-acpi_status acpi_update_gpes(void);
+acpi_status acpi_update_all_gpes(void);
 
 /*
  * Resource interfaces
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2b134b6..b9575ad 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -656,11 +656,11 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_gpe_wakeup, acpi_hw_low_set_gpe */
+/* Actions for acpi_set_gpe_wake_mask, acpi_hw_low_set_gpe */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
-#define ACPI_GPE_COND_ENABLE            2
+#define ACPI_GPE_CONDITIONAL_ENABLE     2
 
 /*
  * GPE info flags - Per GPE
@@ -897,6 +897,9 @@ typedef void
 typedef u32(*acpi_event_handler) (void *context);
 
 typedef
+u32 (*acpi_gpe_handler) (acpi_handle gpe_device, u32 gpe_number, void *context);
+
+typedef
 void (*acpi_notify_handler) (acpi_handle device, u32 value, void *context);
 
 typedef
-- 
1.5.3




