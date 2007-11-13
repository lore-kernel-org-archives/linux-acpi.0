From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: Defer enabling of level GPE until all pending notifies
	done
Date: Tue, 13 Nov 2007 13:05:45 +0300
Message-ID: <20071113100545.13159.20465.stgit@localhost.localdomain>
References: <1194828146.32662.3.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36990 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751590AbXKMKFv (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 05:05:51 -0500
In-Reply-To: <1194828146.32662.3.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Level GPE should not be enabled until all work caused by it is done,
e.g. all Notify() methods are completed.
This could be accomplished by appending enable_gpe function to the end
of notify queue.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/events/evgpe.c |   17 +++++++++++++----
 drivers/acpi/osl.c          |   42 ++++++++----------------------------------
 2 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index e22f4a9..b4509f9 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -501,6 +501,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
  *              an interrupt handler.
  *
  ******************************************************************************/
+static void acpi_ev_asynch_enable_gpe(void *context);
 
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 {
@@ -576,22 +577,30 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 					 method_node)));
 		}
 	}
+	/* Defer enabling of GPE until all notify handlers are done */
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_asynch_enable_gpe,
+				gpe_event_info);
+	return_VOID;
+}
 
-	if ((local_gpe_event_info.flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
+static void acpi_ev_asynch_enable_gpe(void *context)
+{
+	struct acpi_gpe_event_info *gpe_event_info = context;
+	acpi_status status;
+	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
 	    ACPI_GPE_LEVEL_TRIGGERED) {
 		/*
 		 * GPE is level-triggered, we clear the GPE status bit after
 		 * handling the event.
 		 */
-		status = acpi_hw_clear_gpe(&local_gpe_event_info);
+		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			return_VOID;
 		}
 	}
 
 	/* Enable this GPE */
-
-	(void)acpi_hw_write_gpe_enable_reg(&local_gpe_event_info);
+	(void)acpi_hw_write_gpe_enable_reg(gpe_event_info);
 	return_VOID;
 }
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index aabc6ca..6816ac6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -625,25 +625,6 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	dpc->function(dpc->context);
 	kfree(dpc);
 
-	/* Yield cpu to notify thread */
-	cond_resched();
-
-	return;
-}
-
-static void acpi_os_execute_notify(struct work_struct *work)
-{
-	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
-
-	if (!dpc) {
-		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
-		return;
-	}
-
-	dpc->function(dpc->context);
-
-	kfree(dpc);
-
 	return;
 }
 
@@ -667,7 +648,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 {
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
-
+	struct workqueue_struct *queue;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
@@ -691,20 +672,13 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	dpc->function = function;
 	dpc->context = context;
 
-	if (type == OSL_NOTIFY_HANDLER) {
-		INIT_WORK(&dpc->work, acpi_os_execute_notify);
-		if (!queue_work(kacpi_notify_wq, &dpc->work)) {
-			status = AE_ERROR;
-			kfree(dpc);
-		}
-	} else {
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-		if (!queue_work(kacpid_wq, &dpc->work)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Call to queue_work() failed.\n"));
-			status = AE_ERROR;
-			kfree(dpc);
-		}
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	queue = (type == OSL_NOTIFY_HANDLER) ? kacpi_notify_wq : kacpid_wq;
+	if (!queue_work(queue, &dpc->work)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			  "Call to queue_work() failed.\n"));
+		status = AE_ERROR;
+		kfree(dpc);
 	}
 	return_ACPI_STATUS(status);
 }

