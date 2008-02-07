From: Len Brown <lenb@kernel.org>
Subject: [PATCH 006/112] ACPI: Defer enabling of level GPE until all pending notifies done
Date: Thu,  7 Feb 2008 04:33:28 -0500
Message-ID: <17bc54eef91df29f0a22e8a1562a404cf7a68e74.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754800AbYBGJfX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:23 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Level GPE should not be enabled until all work caused by it is done,
e.g. all Notify() methods are completed.
This can be accomplished by appending enable_gpe function to the end
of notify queue.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
index e3a673a..21d3459 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -618,25 +618,6 @@ static void acpi_os_execute_deferred(struct work_struct *work)
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
 
@@ -660,7 +641,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 {
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
-
+	struct workqueue_struct *queue;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
@@ -684,20 +665,13 @@ acpi_status acpi_os_execute(acpi_execute_type type,
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
-- 
1.5.4.23.gef5b9

