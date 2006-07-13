From: Len Brown <len.brown@intel.com>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 22:46:42 -0400
Message-ID: <200607122246.42669.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28577 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932327AbWGMCod (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 22:44:33 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, robert.moore@intel.com

>Here's a suggested revert.

Please try this smaller revert to just osl.c.
(it builds and boots for me)

It reverts acpi_os_queue_for_execution() to exactly
as it was in 2.6.17, except it changes the name to
acpi_os_execute() to match ACPICA 20060512.

(yes, it is okay we ignore the 1st parameter,
 it wasn't used until the 5534 fix we are reverting)

thanks,
-Len

Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 47dfde9..b7d1514 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -36,7 +36,6 @@ #include <linux/kmod.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
-#include <linux/kthread.h>
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
@@ -583,16 +582,6 @@ static void acpi_os_execute_deferred(voi
 	return;
 }
 
-static int acpi_os_execute_thread(void *context)
-{
-	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
-	if (dpc) {
-		dpc->function(dpc->context);
-		kfree(dpc);
-	}
-	do_exit(0);
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_os_execute
@@ -614,10 +603,16 @@ acpi_status acpi_os_execute(acpi_execute
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct work_struct *task;
-	struct task_struct *p;
+
+	ACPI_FUNCTION_TRACE("os_queue_for_execution");
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Scheduling function [%p(%p)] for deferred execution.\n",
+			  function, context));
 
 	if (!function)
-		return AE_BAD_PARAMETER;
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
 	 * freed by the callee.  The kernel handles the tq_struct list  in a
@@ -628,34 +623,27 @@ acpi_status acpi_os_execute(acpi_execute
 	 * We can save time and code by allocating the DPC and tq_structs
 	 * from the same memory.
 	 */
-	if (type == OSL_NOTIFY_HANDLER) {
-		dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_KERNEL);
-	} else {
-		dpc = kmalloc(sizeof(struct acpi_os_dpc) +
-				sizeof(struct work_struct), GFP_ATOMIC);
-	}
+
+	dpc =
+	    kmalloc(sizeof(struct acpi_os_dpc) + sizeof(struct work_struct),
+		    GFP_ATOMIC);
 	if (!dpc)
-		return AE_NO_MEMORY;
+		return_ACPI_STATUS(AE_NO_MEMORY);
+
 	dpc->function = function;
 	dpc->context = context;
 
-	if (type == OSL_NOTIFY_HANDLER) {
-		p = kthread_create(acpi_os_execute_thread, dpc, "kacpid_notify");
-		if (!IS_ERR(p)) {
-			wake_up_process(p);
-		} else {
-			status = AE_NO_MEMORY;
-			kfree(dpc);
-		}
-	} else {
-		task = (void *)(dpc + 1);
-		INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
-		if (!queue_work(kacpid_wq, task)) {
-			status = AE_ERROR;
-			kfree(dpc);
-		}
+	task = (void *)(dpc + 1);
+	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
+
+	if (!queue_work(kacpid_wq, task)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Call to queue_work() failed.\n"));
+		kfree(dpc);
+		status = AE_ERROR;
 	}
-	return status;
+
+	return_ACPI_STATUS(status);
 }
 
 EXPORT_SYMBOL(acpi_os_execute);
