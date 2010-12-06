From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 5/6] ACPICA: Global event handler
Date: Mon, 06 Dec 2010 23:59:07 +0800
Message-ID: <1291651147.2197.87.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21789 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab0LFP6p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 10:58:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

The global event handler is called whenever a general purpose
or fixed ACPI event occurs.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
--- 
drivers/acpi/acpica/acglobal.h |    5 ++++
 drivers/acpi/acpica/evevent.c  |   12 ++++++++-
 drivers/acpi/acpica/evgpe.c    |    9 ++++++-
 drivers/acpi/acpica/evxface.c  |   51 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utglobal.c |    1 +
 drivers/acpi/sysfs.c           |   19 +++++++++++++-
 include/acpi/acpixf.h          |    4 +++
 include/acpi/actypes.h         |    8 ++++++
 8 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index fc69464..9bb69c5 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -146,6 +146,9 @@ u8 acpi_gbl_system_awake_and_running;
 
 extern u32 acpi_gbl_nesting_level;
 
+ACPI_EXTERN u32 acpi_gpe_count;
+ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
+
 /* Support for dynamic control method tracing mechanism */
 
 ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
@@ -371,6 +374,8 @@ ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
 ACPI_EXTERN struct acpi_gpe_block_info
 *acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
 ACPI_EXTERN u8 acpi_gbl_all_gpes_initialized;
+ACPI_EXTERN ACPI_GBL_EVENT_HANDLER acpi_gbl_global_event_handler;
+ACPI_EXTERN void *acpi_gbl_global_event_handler_context;
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index c61c303..e5e313c 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -217,9 +217,17 @@ u32 acpi_ev_fixed_event_detect(void)
 		     status_bit_mask)
 		    && (fixed_enable & acpi_gbl_fixed_event_info[i].
 			enable_bit_mask)) {
+			/*
+			 * Found an active (signalled) event. Invoke global event
+			 * handler if present.
+			 */
+			acpi_fixed_event_count[i]++;
+			if (acpi_gbl_global_event_handler) {
+				acpi_gbl_global_event_handler
+				    (ACPI_EVENT_TYPE_FIXED, NULL, i,
+				     acpi_gbl_global_event_handler_context);
+			}
 
-			/* Found an active (signalled) event */
-			acpi_os_fixed_event_count(i);
 			int_status |= acpi_ev_fixed_event_dispatch(i);
 		}
 	}
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 56a7805..c9d9ecf 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -641,7 +641,14 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
-	acpi_os_gpe_count(gpe_number);
+	/* Invoke global event handler if present */
+
+	acpi_gpe_count++;
+	if (acpi_gbl_global_event_handler) {
+		acpi_gbl_global_event_handler(ACPI_EVENT_TYPE_GPE, gpe_device,
+					      gpe_number,
+					      acpi_gbl_global_event_handler_context);
+	}
 
 	/*
 	 * If edge-triggered, clear the GPE status bit now. Note that
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index d193b90..1226689 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -92,6 +92,57 @@ acpi_status acpi_install_exception_handler(acpi_exception_handler handler)
 
 ACPI_EXPORT_SYMBOL(acpi_install_exception_handler)
 #endif				/*  ACPI_FUTURE_USAGE  */
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_install_global_event_handler
+ *
+ * PARAMETERS:  Handler         - Pointer to the global event handler function
+ *              Context         - Value passed to the handler on each event
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Saves the pointer to the handler function. The global handler
+ *              is invoked upon each incoming GPE and Fixed Event. It is
+ *              invoked at interrupt level at the time of the event dispatch.
+ *              Can be used to update event counters, etc.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_install_global_event_handler(ACPI_GBL_EVENT_HANDLER handler, void *context)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_install_global_event_handler);
+
+	/* Parameter validation */
+
+	if (!handler) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Don't allow two handlers. */
+
+	if (acpi_gbl_global_event_handler) {
+		status = AE_ALREADY_EXISTS;
+		goto cleanup;
+	}
+
+	acpi_gbl_global_event_handler = handler;
+	acpi_gbl_global_event_handler_context = context;
+
+      cleanup:
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_global_event_handler)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_fixed_event_handler
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index a99c32a..508537f 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -778,6 +778,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_init_handler = NULL;
 	acpi_gbl_table_handler = NULL;
 	acpi_gbl_interface_handler = NULL;
+	acpi_gbl_global_event_handler = NULL;
 
 	/* Global Lock support */
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index f8588f8..61891e7 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -438,7 +438,7 @@ static void delete_gpe_attr_array(void)
 	return;
 }
 
-void acpi_os_gpe_count(u32 gpe_number)
+static void gpe_count(u32 gpe_number)
 {
 	acpi_gpe_count++;
 
@@ -454,7 +454,7 @@ void acpi_os_gpe_count(u32 gpe_number)
 	return;
 }
 
-void acpi_os_fixed_event_count(u32 event_number)
+static void fixed_event_count(u32 event_number)
 {
 	if (!all_counters)
 		return;
@@ -468,6 +468,16 @@ void acpi_os_fixed_event_count(u32 event_number)
 	return;
 }
 
+static void acpi_gbl_event_handler(u32 event_type, acpi_handle device,
+	u32 event_number, void *context)
+{
+	if (event_type == ACPI_EVENT_TYPE_GPE)
+		gpe_count(event_number);
+
+	if (event_type == ACPI_EVENT_TYPE_FIXED)
+		fixed_event_count(event_number);
+}
+
 static int get_status(u32 index, acpi_event_status *status,
 		      acpi_handle *handle)
 {
@@ -601,6 +611,7 @@ end:
 
 void acpi_irq_stats_init(void)
 {
+	acpi_status status;
 	int i;
 
 	if (all_counters)
@@ -619,6 +630,10 @@ void acpi_irq_stats_init(void)
 	if (all_counters == NULL)
 		goto fail;
 
+	status = acpi_install_global_event_handler(acpi_gbl_event_handler, NULL);
+	if (ACPI_FAILURE(status))
+		goto fail;
+
 	counter_attrs = kzalloc(sizeof(struct kobj_attribute) * (num_counters),
 				GFP_KERNEL);
 	if (counter_attrs == NULL)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9de6a17..e8142d5 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -229,6 +229,10 @@ acpi_status
 acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
 
 acpi_status
+acpi_install_global_event_handler(ACPI_GBL_EVENT_HANDLER handler,
+				 void *context);
+
+acpi_status
 acpi_install_fixed_event_handler(u32 acpi_event,
 				 acpi_event_handler handler, void *context);
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d7274ee..939a431 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -895,6 +895,14 @@ typedef void
 /*
  * Various handlers and callback procedures
  */
+typedef
+void (*ACPI_GBL_EVENT_HANDLER) (u32 event_type,
+			       acpi_handle device,
+			       u32 event_number, void *context);
+
+#define ACPI_EVENT_TYPE_GPE         0
+#define ACPI_EVENT_TYPE_FIXED       1
+
 typedef u32(*acpi_event_handler) (void *context);
 
 typedef
-- 
1.5.3




