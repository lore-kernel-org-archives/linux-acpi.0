From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 01/19] ACPI: simplify deferred execution path
Date: Mon, 31 Aug 2009 16:32:10 -0600
Message-ID: <20090831223210.11814.12684.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:43286 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZHaWcF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:05 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We had two functions, acpi_os_execute_deferred() and
acpi_os_execute_hp_deferred() that differed only in that the
latter did acpi_os_wait_events_complete(NULL) before executing
the deferred function.

This patch consolidates those two functions and uses a flag in
the struct acpi_os_dpc to determine whether to do the wait.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/osl.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c5b4f1e..d753206 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -58,6 +58,7 @@ struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
 	void *context;
 	struct work_struct work;
+	int wait;
 };
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -703,21 +704,8 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 		return;
 	}
 
-	dpc->function(dpc->context);
-	kfree(dpc);
-
-	return;
-}
-
-static void acpi_os_execute_hp_deferred(struct work_struct *work)
-{
-	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
-	if (!dpc) {
-		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
-		return;
-	}
-
-	acpi_os_wait_events_complete(NULL);
+	if (dpc->wait)
+		acpi_os_wait_events_complete(NULL);
 
 	dpc->function(dpc->context);
 	kfree(dpc);
@@ -746,7 +734,6 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
-	work_func_t func;
 	int ret;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
@@ -779,8 +766,8 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	 */
 	queue = hp ? kacpi_hotplug_wq :
 		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
-	func = hp ? acpi_os_execute_hp_deferred : acpi_os_execute_deferred;
-	INIT_WORK(&dpc->work, func);
+	dpc->wait = hp ? 1 : 0;
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 	ret = queue_work(queue, &dpc->work);
 
 	if (!ret) {

