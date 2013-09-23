From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 07/14] ACPICA: Add support for host-installed SCI handlers.
Date: Mon, 23 Sep 2013 09:52:05 +0800
Message-ID: <36fde9b2ce4fe126612113453b9896cd8f7daddc.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51727 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153Ab3IWBwV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:52:21 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This change adds support to allow hosts to install System Control
Interrupt handlers. Certain ACPI functionality requires the host
to handle raw SCIs. For example, the "SCI Doorbell" that is defined
for memory power state support requires the host device driver to
handle SCIs to examine if the doorbell has been activated. Multiple
SCI handlers can be installed to allow for future expansion.
Debugger support is included.
Lv Zheng, Bob Moore. ACPICA BZ 1032.

Bug summary:
It is reported when the PCC (Platform Communication Channel, via
MPST table, defined in ACPI specification 5.0) subchannel responds
to the host, it issues an SCI and the host must probe the subchannel
for channel status.

Buglink: http://bugs.acpica.org/show_bug.cgi?id=1032
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acdebug.h   |    3 +-
 drivers/acpi/acpica/acevents.h  |    6 +-
 drivers/acpi/acpica/acglobal.h  |    1 +
 drivers/acpi/acpica/aclocal.h   |    8 +++
 drivers/acpi/acpica/evgpeutil.c |    2 +-
 drivers/acpi/acpica/evmisc.c    |   14 ++--
 drivers/acpi/acpica/evsci.c     |   80 ++++++++++++++++++++--
 drivers/acpi/acpica/evxface.c   |  139 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utglobal.c  |    3 +-
 include/acpi/acpixf.h           |   13 +++-
 include/acpi/actypes.h          |    3 +
 11 files changed, 249 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 9feba08..30c2d69 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -113,11 +113,12 @@ void acpi_db_display_handlers(void);
 ACPI_HW_DEPENDENT_RETURN_VOID(void
 			      acpi_db_generate_gpe(char *gpe_arg,
 						   char *block_arg))
+ ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_generate_sci(void))
 
 /*
  * dbconvert - miscellaneous conversion routines
  */
- acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value);
+acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value);
 
 acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object);
 
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index ab0e977..3ae5fd0 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -242,11 +242,11 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
  */
 u32 ACPI_SYSTEM_XFACE acpi_ev_gpe_xrupt_handler(void *context);
 
-u32 acpi_ev_install_sci_handler(void);
+u32 acpi_ev_sci_dispatch(void);
 
-acpi_status acpi_ev_remove_sci_handler(void);
+u32 acpi_ev_install_sci_handler(void);
 
-u32 acpi_ev_initialize_SCI(u32 program_SCI);
+acpi_status acpi_ev_remove_all_sci_handlers(void);
 
 ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_ev_terminate(void))
 #endif				/* __ACEVENTS_H__  */
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index c9ad2e1..0fba431 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -269,6 +269,7 @@ ACPI_EXTERN acpi_table_handler acpi_gbl_table_handler;
 ACPI_EXTERN void *acpi_gbl_table_handler_context;
 ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
 ACPI_EXTERN acpi_interface_handler acpi_gbl_interface_handler;
+ACPI_EXTERN struct acpi_sci_handler_info *acpi_gbl_sci_handler_list;
 
 /* Owner ID support */
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 0ed0066..be9e30e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -398,6 +398,14 @@ struct acpi_simple_repair_info {
  *
  ****************************************************************************/
 
+/* Dispatch info for each host-installed SCI handler */
+
+struct acpi_sci_handler_info {
+	struct acpi_sci_handler_info *next;
+	acpi_sci_handler address;	/* Address of handler */
+	void *context;		/* Context to be passed to handler */
+};
+
 /* Dispatch info for each GPE -- either a method or handler, cannot be both */
 
 struct acpi_gpe_handler_info {
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index b24dbb8..d523390 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -196,7 +196,7 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  *
  * FUNCTION:    acpi_ev_get_gpe_xrupt_block
  *
- * PARAMETERS:  interrupt_number     - Interrupt for a GPE block
+ * PARAMETERS:  interrupt_number            - Interrupt for a GPE block
  *
  * RETURN:      A GPE interrupt block
  *
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 1b111ef..a568754 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -264,13 +264,6 @@ void acpi_ev_terminate(void)
 
 		status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block, NULL);
 
-		/* Remove SCI handler */
-
-		status = acpi_ev_remove_sci_handler();
-		if (ACPI_FAILURE(status)) {
-			ACPI_ERROR((AE_INFO, "Could not remove SCI handler"));
-		}
-
 		status = acpi_ev_remove_global_lock_handler();
 		if (ACPI_FAILURE(status)) {
 			ACPI_ERROR((AE_INFO,
@@ -280,6 +273,13 @@ void acpi_ev_terminate(void)
 		acpi_gbl_events_initialized = FALSE;
 	}
 
+	/* Remove SCI handlers */
+
+	status = acpi_ev_remove_all_sci_handlers();
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not remove SCI handler"));
+	}
+
 	/* Deallocate all handler objects installed within GPE info structs */
 
 	status = acpi_ev_walk_gpe_list(acpi_ev_delete_gpe_handlers, NULL);
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index b905acf..b2f0fb2 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -54,6 +54,52 @@ static u32 ACPI_SYSTEM_XFACE acpi_ev_sci_xrupt_handler(void *context);
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_sci_dispatch
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status code indicates whether interrupt was handled.
+ *
+ * DESCRIPTION: Dispatch the SCI to all host-installed SCI handlers.
+ *
+ ******************************************************************************/
+
+u32 acpi_ev_sci_dispatch(void)
+{
+	struct acpi_sci_handler_info *sci_handler;
+	acpi_cpu_flags flags;
+	u32 int_status = ACPI_INTERRUPT_NOT_HANDLED;
+
+	ACPI_FUNCTION_NAME(ev_sci_dispatch);
+
+	/* Are there any host-installed SCI handlers? */
+
+	if (!acpi_gbl_sci_handler_list) {
+		return (int_status);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Invoke all host-installed SCI handlers */
+
+	sci_handler = acpi_gbl_sci_handler_list;
+	while (sci_handler) {
+
+		/* Invoke the installed handler (at interrupt level) */
+
+		int_status |= sci_handler->address((u32)acpi_gbl_FADT.
+						   sci_interrupt,
+						   sci_handler->context);
+
+		sci_handler = sci_handler->next;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return (int_status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_sci_xrupt_handler
  *
  * PARAMETERS:  context   - Calling Context
@@ -89,6 +135,10 @@ static u32 ACPI_SYSTEM_XFACE acpi_ev_sci_xrupt_handler(void *context)
 	 */
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
 
+	/* Invoke all host-installed SCI handlers */
+
+	interrupt_handled |= acpi_ev_sci_dispatch();
+
 	return_UINT32(interrupt_handled);
 }
 
@@ -112,14 +162,13 @@ u32 ACPI_SYSTEM_XFACE acpi_ev_gpe_xrupt_handler(void *context)
 	ACPI_FUNCTION_TRACE(ev_gpe_xrupt_handler);
 
 	/*
-	 * We are guaranteed by the ACPI CA initialization/shutdown code that
+	 * We are guaranteed by the ACPICA initialization/shutdown code that
 	 * if this interrupt handler is installed, ACPI is enabled.
 	 */
 
 	/* GPEs: Check for and dispatch any GPEs that have occurred */
 
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
-
 	return_UINT32(interrupt_handled);
 }
 
@@ -150,15 +199,15 @@ u32 acpi_ev_install_sci_handler(void)
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_ev_remove_sci_handler
+ * FUNCTION:    acpi_ev_remove_all_sci_handlers
  *
  * PARAMETERS:  none
  *
- * RETURN:      E_OK if handler uninstalled OK, E_ERROR if handler was not
+ * RETURN:      AE_OK if handler uninstalled, AE_ERROR if handler was not
  *              installed to begin with
  *
  * DESCRIPTION: Remove the SCI interrupt handler. No further SCIs will be
- *              taken.
+ *              taken. Remove all host-installed SCI handlers.
  *
  * Note:  It doesn't seem important to disable all events or set the event
  *        enable registers to their original values. The OS should disable
@@ -167,11 +216,13 @@ u32 acpi_ev_install_sci_handler(void)
  *
  ******************************************************************************/
 
-acpi_status acpi_ev_remove_sci_handler(void)
+acpi_status acpi_ev_remove_all_sci_handlers(void)
 {
+	struct acpi_sci_handler_info *sci_handler;
+	acpi_cpu_flags flags;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(ev_remove_sci_handler);
+	ACPI_FUNCTION_TRACE(ev_remove_all_sci_handlers);
 
 	/* Just let the OS remove the handler and disable the level */
 
@@ -179,6 +230,21 @@ acpi_status acpi_ev_remove_sci_handler(void)
 	    acpi_os_remove_interrupt_handler((u32) acpi_gbl_FADT.sci_interrupt,
 					     acpi_ev_sci_xrupt_handler);
 
+	if (!acpi_gbl_sci_handler_list) {
+		return (status);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Free all host-installed SCI handlers */
+
+	while (acpi_gbl_sci_handler_list) {
+		sci_handler = acpi_gbl_sci_handler_list;
+		acpi_gbl_sci_handler_list = sci_handler->next;
+		ACPI_FREE(sci_handler);
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index ca5fba9..6f56146 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -385,6 +385,144 @@ ACPI_EXPORT_SYMBOL(acpi_install_exception_handler)
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_install_sci_handler
+ *
+ * PARAMETERS:  address             - Address of the handler
+ *              context             - Value passed to the handler on each SCI
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a handler for a System Control Interrupt.
+ *
+ ******************************************************************************/
+acpi_status acpi_install_sci_handler(acpi_sci_handler address, void *context)
+{
+	struct acpi_sci_handler_info *new_sci_handler;
+	struct acpi_sci_handler_info *sci_handler;
+	acpi_cpu_flags flags;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_install_sci_handler);
+
+	if (!address) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	/* Allocate and init a handler object */
+
+	new_sci_handler = ACPI_ALLOCATE(sizeof(struct acpi_sci_handler_info));
+	if (!new_sci_handler) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	new_sci_handler->address = address;
+	new_sci_handler->context = context;
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Lock list during installation */
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	sci_handler = acpi_gbl_sci_handler_list;
+
+	/* Ensure handler does not already exist */
+
+	while (sci_handler) {
+		if (address == sci_handler->address) {
+			status = AE_ALREADY_EXISTS;
+			goto unlock_and_exit;
+		}
+
+		sci_handler = sci_handler->next;
+	}
+
+	/* Install the new handler into the global list (at head) */
+
+	new_sci_handler->next = acpi_gbl_sci_handler_list;
+	acpi_gbl_sci_handler_list = new_sci_handler;
+
+      unlock_and_exit:
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+      exit:
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(new_sci_handler);
+	}
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_remove_sci_handler
+ *
+ * PARAMETERS:  address             - Address of the handler
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove a handler for a System Control Interrupt.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_remove_sci_handler(acpi_sci_handler address)
+{
+	struct acpi_sci_handler_info *prev_sci_handler;
+	struct acpi_sci_handler_info *next_sci_handler;
+	acpi_cpu_flags flags;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_remove_sci_handler);
+
+	if (!address) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Remove the SCI handler with lock */
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	prev_sci_handler = NULL;
+	next_sci_handler = acpi_gbl_sci_handler_list;
+	while (next_sci_handler) {
+		if (next_sci_handler->address == address) {
+
+			/* Unlink and free the SCI handler info block */
+
+			if (prev_sci_handler) {
+				prev_sci_handler->next = next_sci_handler->next;
+			} else {
+				acpi_gbl_sci_handler_list =
+				    next_sci_handler->next;
+			}
+
+			acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+			ACPI_FREE(next_sci_handler);
+			goto unlock_and_exit;
+		}
+
+		prev_sci_handler = next_sci_handler;
+		next_sci_handler = next_sci_handler->next;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	status = AE_NOT_EXIST;
+
+      unlock_and_exit:
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_install_global_event_handler
  *
  * PARAMETERS:  handler         - Pointer to the global event handler function
@@ -398,6 +536,7 @@ ACPI_EXPORT_SYMBOL(acpi_install_exception_handler)
  *              Can be used to update event counters, etc.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_install_global_event_handler(acpi_gbl_event_handler handler, void *context)
 {
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index d6f26bf..046d5b0 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -291,7 +291,7 @@ acpi_status acpi_ut_init_globals(void)
 
 #if (!ACPI_REDUCED_HARDWARE)
 
-	/* GPE support */
+	/* GPE/SCI support */
 
 	acpi_gbl_all_gpes_initialized = FALSE;
 	acpi_gbl_gpe_xrupt_list_head = NULL;
@@ -300,6 +300,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_current_gpe_count = 0;
 
 	acpi_gbl_global_event_handler = NULL;
+	acpi_gbl_sci_handler_list = NULL;
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 85bfdbe..55a4d3a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -280,9 +280,16 @@ acpi_status
 acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_install_global_event_handler
-				(acpi_gbl_event_handler handler, void *context))
-
+				acpi_install_sci_handler(acpi_sci_handler
+							 address,
+							 void *context))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_remove_sci_handler(acpi_sci_handler
+							 address))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_install_global_event_handler
+				 (acpi_gbl_event_handler handler,
+				  void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_fixed_event_handler(u32
 								  acpi_event,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index b748aef..850f750 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -946,6 +946,9 @@ typedef void
  * Various handlers and callback procedures
  */
 typedef
+u32 (*acpi_sci_handler) (u32 interrupt_number, void *context);
+
+typedef
 void (*acpi_gbl_event_handler) (u32 event_type,
 			       acpi_handle device,
 			       u32 event_number, void *context);
-- 
1.7.10

