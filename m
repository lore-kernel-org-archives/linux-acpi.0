From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/5] fix a deadlock in hotplug case
Date: Mon, 22 Jun 2009 11:31:15 +0800
Message-ID: <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
References: <n>
 <1245641478-31805-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56781 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbZFVDad (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 23:30:33 -0400
In-Reply-To: <1245641478-31805-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

we used to run the hotplug code in keventd_wq.
But when hot removing the ACPI battery device,
power_supply_unregister invokes flush_scheduled_work.
This causes a deadlock.
Introduce a new workqueue for hotplug in this patch.
http://bugzilla.kernel.org/show_bug.cgi?id=13533

Tested-by: Paul Martin <pm@debian.org>
Tested-by: Vojtech Gondzala <vojtech.gondzala@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/osl.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d916bea..80488db 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -79,6 +79,11 @@ static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
+/* 
+ * run the hotplug code in a seperate workqueue
+ * to avoid the deadlock issue
+ */
+static struct workqueue_struct *kacpi_hotplug_wq;
 
 struct acpi_res_list {
 	resource_size_t start;
@@ -192,8 +197,10 @@ acpi_status acpi_os_initialize1(void)
 {
 	kacpid_wq = create_singlethread_workqueue("kacpid");
 	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
+	kacpi_hotplug_wq = create_singlethread_workqueue("kacpi_hotplug");
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
+	BUG_ON(!kacpi_hotplug_wq);
 	return AE_OK;
 }
 
@@ -206,6 +213,7 @@ acpi_status acpi_os_terminate(void)
 
 	destroy_workqueue(kacpid_wq);
 	destroy_workqueue(kacpi_notify_wq);
+	destroy_workqueue(kacpi_hotplug_wq);
 
 	return AE_OK;
 }
@@ -716,6 +724,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
+	work_func_t func;
 	int ret;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
@@ -740,15 +749,11 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	dpc->function = function;
 	dpc->context = context;
 
-	if (!hp) {
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-		queue = (type == OSL_NOTIFY_HANDLER) ?
-			kacpi_notify_wq : kacpid_wq;
-		ret = queue_work(queue, &dpc->work);
-	} else {
-		INIT_WORK(&dpc->work, acpi_os_execute_hp_deferred);
-		ret = schedule_work(&dpc->work);
-	}
+	queue = hp ? kacpi_hotplug_wq :
+		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
+	func = hp ? acpi_os_execute_hp_deferred : acpi_os_execute_deferred;
+	INIT_WORK(&dpc->work, func);
+	ret = queue_work(queue, &dpc->work);
 
 	if (!ret) {
 		printk(KERN_ERR PREFIX
-- 
1.5.4.4

