From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 2/3] ACPI / osl: Add OSL_GC_HANDLER/OSL_GC_THREAD support
Date: Fri, 11 Sep 2015 10:05:28 +0800
Message-ID: <69d724d88cfe39ea95de8ee0bf192a3b6741955d.1441935832.git.lv.zheng@intel.com>
References: <cover.1441935832.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64529 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbbIKCFg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2015 22:05:36 -0400
In-Reply-To: <cover.1441935832.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Hanjun Guo <hanjun.guo@linaro.org>

This patch enables Linux capability of supporting ACPICA operand object GC.

Note that, when the operand object is deferred freed in the early stage,
the GC work queue and the GC thread cannot be used for the execution,
acpi_os_initialized can be used to indicate such periods and the operand
object can either be freed in ACPICA non deferred path (work queue) or
linked together for later try.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/bus.c |    4 ++--
 drivers/acpi/osl.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 46506e7..7455f69 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -982,8 +982,6 @@ static int __init acpi_bus_init(void)
 	int result;
 	acpi_status status;
 
-	acpi_os_initialize1();
-
 	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
@@ -1085,6 +1083,8 @@ static int __init acpi_init(void)
 		acpi_kobj = NULL;
 	}
 
+	acpi_os_initialize1();
+
 	init_acpi_device_notify();
 	result = acpi_bus_init();
 	if (result) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 739a4a6..3fb16a7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/kthread.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -79,8 +80,10 @@ static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
+static struct workqueue_struct *kacpi_gc_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
+static struct acpi_os_dpc acpi_gc_thread;
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -1100,6 +1103,16 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	kfree(dpc);
 }
 
+static int acpi_os_threaded_dpc(void *context)
+{
+	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
+
+	pr_info("ACPI: GC thread is online.\n");
+	dpc->function(dpc->context);
+	pr_info("ACPI: GC thread is offline.\n");
+	return 0;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_os_execute
@@ -1122,10 +1135,27 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
 	int ret;
+	struct task_struct *t;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
 
+        if (type == OSL_GC_THREAD) {
+		if (acpi_os_initialized) {
+			acpi_gc_thread.function = function;
+			acpi_gc_thread.context = context;
+			t = kthread_create(acpi_os_threaded_dpc,
+					   (void *)&acpi_gc_thread, "kacpi_gc_thread");
+			if (IS_ERR(t)) {
+				pr_err("Failed to create GC thread.\n");
+				status = AE_ERROR;
+			} else
+				wake_up_process(t);
+		} else
+			status = AE_NO_MEMORY;
+		goto out_thread;
+	}
+
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
 	 * freed by the callee.  The kernel handles the work_struct list  in a
@@ -1150,11 +1180,20 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	} else {
+	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	} else if (type == OSL_GC_HANDLER) {
+		queue = kacpi_gc_wq;
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	} else {
+		pr_err("Unsupported os_execute type %d.\n", type);
+		status = AE_ERROR;
 	}
 
+	if (ACPI_FAILURE(status))
+		goto err_workqueue;
+
 	/*
 	 * On some machines, a software-initiated SMI causes corruption unless
 	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
@@ -1163,13 +1202,15 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 * queueing on CPU 0.
 	 */
 	ret = queue_work_on(0, queue, &dpc->work);
-
 	if (!ret) {
 		printk(KERN_ERR PREFIX
 			  "Call to queue_work() failed.\n");
 		status = AE_ERROR;
-		kfree(dpc);
 	}
+err_workqueue:
+	if (ACPI_FAILURE(status))
+		kfree(dpc);
+out_thread:
 	return status;
 }
 EXPORT_SYMBOL(acpi_os_execute);
@@ -1839,18 +1880,20 @@ acpi_status __init acpi_os_initialize(void)
 		rv = acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
 		pr_debug(PREFIX "%s: map reset_reg status %d\n", __func__, rv);
 	}
-	acpi_os_initialized = true;
 
 	return AE_OK;
 }
 
 acpi_status __init acpi_os_initialize1(void)
 {
+	acpi_os_initialized = true;
 	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
 	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
+	kacpi_gc_wq = alloc_workqueue("kacpi_gc_handler", 0, 1);
 	kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
+	BUG_ON(!kacpi_gc_wq);
 	BUG_ON(!kacpi_hotplug_wq);
 	acpi_install_interface_handler(acpi_osi_handler);
 	acpi_osi_setup_late();
@@ -1873,6 +1916,7 @@ acpi_status acpi_os_terminate(void)
 
 	destroy_workqueue(kacpid_wq);
 	destroy_workqueue(kacpi_notify_wq);
+	destroy_workqueue(kacpi_gc_wq);
 	destroy_workqueue(kacpi_hotplug_wq);
 
 	return AE_OK;
-- 
1.7.10

