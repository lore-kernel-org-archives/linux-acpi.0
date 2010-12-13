From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2 5/8] ACPICA: Fix local variable mess in
 acpi_ev_asynch_execute_gpe_method
Date: Mon, 13 Dec 2010 13:39:07 +0800
Message-ID: <1292218747.10384.94.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9703 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab0LMFef (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Dec 2010 00:34:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Change the local variable in acpi_ev_asynch_execute_gpe_method()
back into a pointer as ACPICA code base does.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/evgpe.c |   57 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 3fb621e..c259995 100644
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
@@ -441,17 +443,25 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
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
@@ -468,7 +478,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	 * Take a snapshot of the GPE info for this level - we copy the info to
 	 * prevent a race condition with remove_handler/remove_block.
 	 */
-	ACPI_MEMCPY(&local_gpe_event_info, gpe_event_info,
+	ACPI_MEMCPY(local_gpe_event_info, gpe_event_info,
 		    sizeof(struct acpi_gpe_event_info));
 
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
@@ -480,7 +490,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	 * Must check for control method type dispatch one more time to avoid a
 	 * race with ev_gpe_install_handler
 	 */
-	if ((local_gpe_event_info.flags & ACPI_GPE_DISPATCH_MASK) ==
+	if ((local_gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_METHOD) {
 
 		/* Allocate the evaluation information block */
@@ -494,7 +504,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			 * control method that corresponds to this GPE
 			 */
 			info->prefix_node =
-			    local_gpe_event_info.dispatch.method_node;
+			    local_gpe_event_info->dispatch.method_node;
 			info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 			status = acpi_ns_evaluate(info);
@@ -505,20 +515,41 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			ACPI_EXCEPTION((AE_INFO, status,
 					"while evaluating GPE method [%4.4s]",
 					acpi_ut_get_node_name
-					(local_gpe_event_info.dispatch.
+					(local_gpe_event_info->dispatch.
 					 method_node)));
 		}
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
+ *              complete.
+ *
+ ******************************************************************************/
+
+static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info = context;
 	acpi_status status;
+
 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
 	    ACPI_GPE_LEVEL_TRIGGERED) {
 		/*
@@ -527,7 +558,7 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 		 */
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
-			return_VOID;
+			goto exit;
 		}
 	}
 
@@ -537,7 +568,9 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 	 */
 	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
 
-	return_VOID;
+exit:
+	ACPI_FREE(gpe_event_info);
+	return;
 }
 
 /*******************************************************************************
-- 
1.5.3




