From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 01/19] ACPI: simplify deferred execution path
Date: Fri, 31 Jul 2009 15:36:38 -0600
Message-ID: <20090731213638.29930.591.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:33507 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbZGaVgk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:36:40 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
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
index 5691f16..10df23d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -58,6 +58,7 @@ struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
 	void *context;
 	struct work_struct work;
+	int wait;
 };
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -702,21 +703,8 @@ static void acpi_os_execute_deferred(struct work_struct *work)
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
@@ -745,7 +733,6 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
-	work_func_t func;
 	int ret;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
@@ -778,8 +765,8 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	 */
 	queue = hp ? kacpi_hotplug_wq :
 		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
-	func = hp ? acpi_os_execute_hp_deferred : acpi_os_execute_deferred;
-	INIT_WORK(&dpc->work, func);
+	dpc->wait = hp ? 1 : 0;
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 	ret = queue_work(queue, &dpc->work);
 
 	if (!ret) {

