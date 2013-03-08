From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/21] ACPICA: Update error/debug messages for fixed events
Date: Fri,  8 Mar 2013 17:21:41 +0800
Message-ID: <edc1fa665b33742ade184daba10c0c3a26a1fdf3.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9954 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933437Ab3CHJWU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:22:20 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add the actual fixed event name to all messages for clarity.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evevent.c |   12 +++++++-----
 drivers/acpi/acpica/evxface.c |   21 ++++++++++++---------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index b8ea0b2..02219ff 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -257,6 +257,8 @@ u32 acpi_ev_fixed_event_detect(void)
  *
  * DESCRIPTION: Clears the status bit for the requested event, calls the
  *              handler that previously registered for the event.
+ *              NOTE: If there is no handler for the event, the event is
+ *              disabled to prevent futher interrupts.
  *
  ******************************************************************************/
 
@@ -271,17 +273,17 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 				      status_register_id, ACPI_CLEAR_STATUS);
 
 	/*
-	 * Make sure we've got a handler. If not, report an error. The event is
-	 * disabled to prevent further interrupts.
+	 * Make sure that a handler exists. If not, report an error
+	 * and disable the event to prevent further interrupts.
 	 */
-	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
+	if (!acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 					      enable_register_id,
 					      ACPI_DISABLE_EVENT);
 
 		ACPI_ERROR((AE_INFO,
-			    "No installed handler for fixed event [0x%08X]",
-			    event));
+			    "No installed handler for fixed event - %s (%u), disabling",
+			    acpi_ut_get_event_name(event), event));
 
 		return (ACPI_INTERRUPT_NOT_HANDLED);
 	}
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index ddffd68..ca5fba9 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -467,9 +467,9 @@ acpi_install_fixed_event_handler(u32 event,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Don't allow two handlers. */
+	/* Do not allow multiple handlers */
 
-	if (NULL != acpi_gbl_fixed_event_handlers[event].handler) {
+	if (acpi_gbl_fixed_event_handlers[event].handler) {
 		status = AE_ALREADY_EXISTS;
 		goto cleanup;
 	}
@@ -483,8 +483,9 @@ acpi_install_fixed_event_handler(u32 event,
 	if (ACPI_SUCCESS(status))
 		status = acpi_enable_event(event, 0);
 	if (ACPI_FAILURE(status)) {
-		ACPI_WARNING((AE_INFO, "Could not enable fixed event 0x%X",
-			      event));
+		ACPI_WARNING((AE_INFO,
+			      "Could not enable fixed event - %s (%u)",
+			      acpi_ut_get_event_name(event), event));
 
 		/* Remove the handler */
 
@@ -492,7 +493,8 @@ acpi_install_fixed_event_handler(u32 event,
 		acpi_gbl_fixed_event_handlers[event].context = NULL;
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Enabled fixed event %X, Handler=%p\n", event,
+				  "Enabled fixed event %s (%X), Handler=%p\n",
+				  acpi_ut_get_event_name(event), event,
 				  handler));
 	}
 
@@ -544,11 +546,12 @@ acpi_remove_fixed_event_handler(u32 event, acpi_event_handler handler)
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_WARNING((AE_INFO,
-			      "Could not write to fixed event enable register 0x%X",
-			      event));
+			      "Could not disable fixed event - %s (%u)",
+			      acpi_ut_get_event_name(event), event));
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Disabled fixed event %X\n",
-				  event));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Disabled fixed event - %s (%X)\n",
+				  acpi_ut_get_event_name(event), event));
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-- 
1.7.10

