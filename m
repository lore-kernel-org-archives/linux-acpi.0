From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Tue, 21 Nov 2006 01:13:34 +0300
Message-ID: <4562288E.7000104@linux.intel.com>
References: <B41635854730A14CA71C92B36EC22AAC5AD485@mssmsx411> <Pine.LNX.4.64.0611181104030.3692@woody.osdl.org> <455FB44C.8050103@linux.intel.com> <Pine.LNX.4.64.0611182048560.3692@woody.osdl.org> <456043F7.1030105@linux.intel.com> <Pine.LNX.4.64.0611201003540.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060701080002000104020609"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:41307 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S966529AbWKTW5G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 17:57:06 -0500
In-Reply-To: <Pine.LNX.4.64.0611201003540.3692@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, linux-acpi@vger.kernel.org, David Brownell <david-b@pacbell.net>

This is a multi-part message in MIME format.
--------------060701080002000104020609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Linus Torvalds wrote:
> On Sun, 19 Nov 2006, Alexey Starikovskiy wrote:
>   
>> I agree to all your comments with one exception, please see below. Attached is
>> the reworked patch against latest git. Please test.
>>     
>
> Ok, this one works for me too, and looks much simpler.
>
>   
>> Linus Torvalds wrote:
>>     
>>> And we might as well do it when we add an entry to the _deferred_ queue, no? 
>>>       
>>   
>> acpi_os_execute() is called from interrupt context for insertion into
>> _deferred_ queue, so it's not possible to yield in it, no?
>>     
>
> Hmm. Yes. Anyway, the new patch looks acceptable, and certainly much 
> simpler than trying to count events.
>
> It probably causes tons of new unnecessary scheduling events, but I doubt 
> we really care.
>
> That said, what we _really_ want here is a "priority queue" for the 
> events, and some way to put an event back on the queue while running it 
> (eg ACPI "Sleep" event). But I guess the ACPI interpreter isn't done that 
> way (ie you can't just push and pop ACPI state).
>
> 		Linus
>   
Linus, thanks for diagnosing and testing. Yes, interpeter is not 
currently able to put its stack aside.

David, could you try this patch too?

Regards,
    Alex.






--------------060701080002000104020609
Content-Type: text/plain;
 name="yield_on_deferred_events.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="yield_on_deferred_events.patch"

ACPI: created a dedicated workqueue for notify() execution

From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

Needed to handle while loop in GPE handler of HP notebooks.    
http://bugzilla.kernel.org/show_bug.cgi?id=5534

Yield processor before execution of deferred event queue. Needed to avoid
flooding of Compaq n620c with events.
---

 drivers/acpi/osl.c |   51 +++++++++++++++++++++++++++++++++++----------------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 068fe4f..169ca04 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -34,6 +34,7 @@ #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
+#include <linux/syscalls.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
 #include <acpi/acpi.h>
@@ -73,6 +74,7 @@ static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
+static struct workqueue_struct *kacpi_notify_wq;
 
 acpi_status acpi_os_initialize(void)
 {
@@ -91,8 +93,9 @@ acpi_status acpi_os_initialize1(void)
 		return AE_NULL_ENTRY;
 	}
 	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
 	BUG_ON(!kacpid_wq);
-
+	BUG_ON(!kacpi_notify_wq);
 	return AE_OK;
 }
 
@@ -104,6 +107,7 @@ acpi_status acpi_os_terminate(void)
 	}
 
 	destroy_workqueue(kacpid_wq);
+	destroy_workqueue(kacpi_notify_wq);
 
 	return AE_OK;
 }
@@ -566,10 +570,23 @@ void acpi_os_derive_pci_id(acpi_handle r
 
 static void acpi_os_execute_deferred(void *context)
 {
-	struct acpi_os_dpc *dpc = NULL;
+	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
+	if (!dpc) {
+		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
+		return;
+	}
+
+	sys_sched_yield();
+	dpc->function(dpc->context);
+
+	kfree(dpc);
 
+	return;
+}
 
-	dpc = (struct acpi_os_dpc *)context;
+static void acpi_os_execute_notify(void *context)
+{
+	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
 	if (!dpc) {
 		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
 		return;
@@ -604,14 +621,12 @@ acpi_status acpi_os_execute(acpi_execute
 	struct acpi_os_dpc *dpc;
 	struct work_struct *task;
 
-	ACPI_FUNCTION_TRACE("os_queue_for_execution");
-
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
 
 	if (!function)
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		return AE_BAD_PARAMETER;
 
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
@@ -624,9 +639,8 @@ acpi_status acpi_os_execute(acpi_execute
 	 * from the same memory.
 	 */
 
-	dpc =
-	    kmalloc(sizeof(struct acpi_os_dpc) + sizeof(struct work_struct),
-		    GFP_ATOMIC);
+	dpc = kzalloc(sizeof(struct acpi_os_dpc) +
+			sizeof(struct work_struct), GFP_ATOMIC);
 	if (!dpc)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 
@@ -634,13 +648,18 @@ acpi_status acpi_os_execute(acpi_execute
 	dpc->context = context;
 
 	task = (void *)(dpc + 1);
-	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
-
-	if (!queue_work(kacpid_wq, task)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Call to queue_work() failed.\n"));
-		kfree(dpc);
-		status = AE_ERROR;
+	if (type == OSL_NOTIFY_HANDLER) {
+		INIT_WORK(task, acpi_os_execute_notify, (void *)dpc);
+		if (!queue_work(kacpi_notify_wq, task)) {
+			status = AE_ERROR;
+			kfree(dpc);
+		}
+	} else {
+		INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
+		if (!queue_work(kacpid_wq, task)) {
+			status = AE_ERROR;
+			kfree(dpc);
+		}
 	}
 
 	return_ACPI_STATUS(status);

--------------060701080002000104020609--
