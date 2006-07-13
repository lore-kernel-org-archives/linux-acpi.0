From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Subject: RE: kacpi_notify?
Date: Thu, 13 Jul 2006 15:07:56 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC0907F8@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56385 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751525AbWGMLI4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2006 07:08:56 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

Linus,

I'm terribly sorry that my patch broke on your machine.
May I ask you to send me or attach to #5534 output of acpidump from this
machine?
Do you think that the whole idea is crap, or if I limit number of
possible spawned threads and forsibly put current thread to sleep (which
will release ACPICA executer mutex), as it happens in DSDT of nx6125 it
will be possible to use it?

Thanks in advance, and once again my apology.
Alex.

>-----Original Message-----
>From: Linus Torvalds [mailto:torvalds@osdl.org] 
>Sent: Thursday, July 13, 2006 4:15 AM
>To: Brown, Len
>Cc: Andrew Morton; linux-acpi@vger.kernel.org; Moore, Robert; 
>Starikovskiy, Alexey Y
>Subject: RE: kacpi_notify?
>
>
>
>On Wed, 12 Jul 2006, Brown, Len wrote:
>> 
>> Ugh, ACPICA starts depending on on acpi_os_execute() at that time,
>> so a simple revert will break the build -- needs to be tweaked.
>
>Yeah, I just noticed.
>
>Those "ACPICA" commits are crap. Crap, crap, crap. They do 
>more than one 
>thing, and are clearly just patches applied from a system that 
>probably 
>does have finer-grained granularity of tracking the changes.
>
>Here's a suggested revert. This boots, and seems to have the problem 
>fixed. At least I can now recompile the kernel on that machine again, 
>without the machine crashing.
>
>		Linus
>
>----
>Revert "ACPI: execute Notify() handlers on new thread"
>
>This reverts commit b8d35192c55fb055792ff0641408eaaec7c88988 (and parts
>of commit 958dd242b691f64ab4632b4903dbb1e16fee8269: "ACPI: ACPICA
>20060512", which were intertwined, along with some Smart Battery logic
>that had already started using the broken routines).
>
>The thread execution doesn't actually solve the bug it set out to solve
>(see
>
>	http://bugzilla.kernel.org/show_bug.cgi?id=5534
>
>for more details) because the new events can get caught behind the AML
>semaphore or other serialization.  And when that happens, the notify
>threads keep on pilin gup until the system dies.
>
>Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
>
>diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>index e5d7963..bdf3e12 100644
>--- a/drivers/acpi/ec.c
>+++ b/drivers/acpi/ec.c
>@@ -759,7 +759,8 @@ static u32 acpi_ec_gpe_poll_handler(void
> 
> 	acpi_disable_gpe(NULL, ec->common.gpe_bit, ACPI_ISR);
> 
>-	status = acpi_os_execute(OSL_EC_POLL_HANDLER, 
>acpi_ec_gpe_query, ec);
>+	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
>+					     acpi_ec_gpe_query, ec);
> 
> 	if (status == AE_OK)
> 		return ACPI_INTERRUPT_HANDLED;
>@@ -797,7 +798,7 @@ static u32 acpi_ec_gpe_intr_handler(void
> 
> 	if (value & ACPI_EC_FLAG_SCI) {
> 		atomic_add(1, &ec->intr.pending_gpe);
>-		status = acpi_os_execute(OSL_EC_BURST_HANDLER,
>+		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
> 						     
>acpi_ec_gpe_query, ec);
> 		return status == AE_OK ?
> 		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
>diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
>index c76c058..aad17dd 100644
>--- a/drivers/acpi/events/evgpe.c
>+++ b/drivers/acpi/events/evgpe.c
>@@ -495,8 +495,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
>  * RETURN:      None
>  *
>  * DESCRIPTION: Perform the actual execution of a GPE control 
>method. This
>- *              function is called from an invocation of 
>acpi_os_execute and
>- *              therefore does NOT execute at interrupt level 
>- so that
>+ *              function is called from an invocation of 
>acpi_os_queue_for_execution
>+ *              (and therefore does NOT execute at interrupt 
>level) so that
>  *              the control method itself is not executed in 
>the context of
>  *              an interrupt handler.
>  *
>@@ -692,9 +692,9 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
> 		 * Execute the method associated with the GPE
> 		 * NOTE: Level-triggered GPEs are cleared after 
>the method completes.
> 		 */
>-		status = acpi_os_execute(OSL_GPE_HANDLER,
>-					 
>acpi_ev_asynch_execute_gpe_method,
>-					 gpe_event_info);
>+		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
>+						     
>acpi_ev_asynch_execute_gpe_method,
>+						     gpe_event_info);
> 		if (ACPI_FAILURE(status)) {
> 			ACPI_EXCEPTION((AE_INFO, status,
> 					"Unable to queue 
>handler for GPE[%2X] - event disabled",
>diff --git a/drivers/acpi/events/evmisc.c 
>b/drivers/acpi/events/evmisc.c
>index 6eef4ef..625dd3b 100644
>--- a/drivers/acpi/events/evmisc.c
>+++ b/drivers/acpi/events/evmisc.c
>@@ -192,9 +192,9 @@ acpi_ev_queue_notify_request(struct acpi
> 		notify_info->notify.value = (u16) notify_value;
> 		notify_info->notify.handler_obj = handler_obj;
> 
>-		status =
>-		    acpi_os_execute(OSL_NOTIFY_HANDLER, 
>acpi_ev_notify_dispatch,
>-				    notify_info);
>+		status = acpi_os_queue_for_execution(OSD_PRIORITY_HIGH,
>+						     
>acpi_ev_notify_dispatch,
>+						     notify_info);
> 		if (ACPI_FAILURE(status)) {
> 			acpi_ut_delete_generic_state(notify_info);
> 		}
>@@ -347,9 +347,9 @@ static u32 acpi_ev_global_lock_handler(v
> 
> 		/* Run the Global Lock thread which will signal 
>all waiting threads */
> 
>-		status =
>-		    acpi_os_execute(OSL_GLOBAL_LOCK_HANDLER,
>-				    acpi_ev_global_lock_thread, 
>context);
>+		status = acpi_os_queue_for_execution(OSD_PRIORITY_HIGH,
>+						     
>acpi_ev_global_lock_thread,
>+						     context);
> 		if (ACPI_FAILURE(status)) {
> 			ACPI_EXCEPTION((AE_INFO, status,
> 					"Could not queue Global 
>Lock thread"));
>diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>index 47dfde9..8eb3ab6 100644
>--- a/drivers/acpi/osl.c
>+++ b/drivers/acpi/osl.c
>@@ -36,7 +36,6 @@ #include <linux/kmod.h>
> #include <linux/delay.h>
> #include <linux/workqueue.h>
> #include <linux/nmi.h>
>-#include <linux/kthread.h>
> #include <acpi/acpi.h>
> #include <asm/io.h>
> #include <acpi/acpi_bus.h>
>@@ -583,41 +582,23 @@ static void acpi_os_execute_deferred(voi
> 	return;
> }
> 
>-static int acpi_os_execute_thread(void *context)
>-{
>-	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
>-	if (dpc) {
>-		dpc->function(dpc->context);
>-		kfree(dpc);
>-	}
>-	do_exit(0);
>-}
>-
>-/*************************************************************
>******************
>- *
>- * FUNCTION:    acpi_os_execute
>- *
>- * PARAMETERS:  Type               - Type of the callback
>- *              Function           - Function to be executed
>- *              Context            - Function parameters
>- *
>- * RETURN:      Status
>- *
>- * DESCRIPTION: Depending on type, either queues function for 
>deferred execution or
>- *              immediately executes function on a separate thread.
>- *
>- 
>***************************************************************
>***************/
>-
>-acpi_status acpi_os_execute(acpi_execute_type type,
>+acpi_status
>+acpi_os_queue_for_execution(u32 priority,
> 			    acpi_osd_exec_callback function, 
>void *context)
> {
> 	acpi_status status = AE_OK;
> 	struct acpi_os_dpc *dpc;
> 	struct work_struct *task;
>-	struct task_struct *p;
>+
>+	ACPI_FUNCTION_TRACE("os_queue_for_execution");
>+
>+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
>+			  "Scheduling function [%p(%p)] for 
>deferred execution.\n",
>+			  function, context));
> 
> 	if (!function)
>-		return AE_BAD_PARAMETER;
>+		return_ACPI_STATUS(AE_BAD_PARAMETER);
>+
> 	/*
> 	 * Allocate/initialize DPC structure.  Note that this 
>memory will be
> 	 * freed by the callee.  The kernel handles the 
>tq_struct list  in a
>@@ -628,37 +609,30 @@ acpi_status acpi_os_execute(acpi_execute
> 	 * We can save time and code by allocating the DPC and 
>tq_structs
> 	 * from the same memory.
> 	 */
>-	if (type == OSL_NOTIFY_HANDLER) {
>-		dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_KERNEL);
>-	} else {
>-		dpc = kmalloc(sizeof(struct acpi_os_dpc) +
>-				sizeof(struct work_struct), GFP_ATOMIC);
>-	}
>+
>+	dpc =
>+	    kmalloc(sizeof(struct acpi_os_dpc) + sizeof(struct 
>work_struct),
>+		    GFP_ATOMIC);
> 	if (!dpc)
>-		return AE_NO_MEMORY;
>+		return_ACPI_STATUS(AE_NO_MEMORY);
>+
> 	dpc->function = function;
> 	dpc->context = context;
> 
>-	if (type == OSL_NOTIFY_HANDLER) {
>-		p = kthread_create(acpi_os_execute_thread, dpc, 
>"kacpid_notify");
>-		if (!IS_ERR(p)) {
>-			wake_up_process(p);
>-		} else {
>-			status = AE_NO_MEMORY;
>-			kfree(dpc);
>-		}
>-	} else {
>-		task = (void *)(dpc + 1);
>-		INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
>-		if (!queue_work(kacpid_wq, task)) {
>-			status = AE_ERROR;
>-			kfree(dpc);
>-		}
>+	task = (void *)(dpc + 1);
>+	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
>+
>+	if (!queue_work(kacpid_wq, task)) {
>+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>+				  "Call to queue_work() failed.\n"));
>+		kfree(dpc);
>+		status = AE_ERROR;
> 	}
>-	return status;
>+
>+	return_ACPI_STATUS(status);
> }
> 
>-EXPORT_SYMBOL(acpi_os_execute);
>+EXPORT_SYMBOL(acpi_os_queue_for_execution);
> 
> void acpi_os_wait_events_complete(void *context)
> {
>diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
>index db7b350..87d7800 100644
>--- a/drivers/acpi/sbs.c
>+++ b/drivers/acpi/sbs.c
>@@ -1366,7 +1366,7 @@ static void acpi_ac_remove(struct acpi_s
> 
> static void acpi_sbs_update_queue_run(unsigned long data)
> {
>-	acpi_os_execute(OSL_GPE_HANDLER, acpi_sbs_update_queue, 
>(void *)data);
>+	acpi_os_queue_for_execution(OSD_PRIORITY_GPE, 
>acpi_sbs_update_queue, (void *)data);
> }
> 
> static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
>@@ -1658,11 +1658,11 @@ static int acpi_sbs_add(struct acpi_devi
> 
> 	init_timer(&sbs->update_timer);
> 	if (update_mode == QUEUE_UPDATE_MODE) {
>-		status = acpi_os_execute(OSL_GPE_HANDLER,
>+		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
> 					 acpi_sbs_update_queue, 
>(void *)sbs);
> 		if (status != AE_OK) {
> 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>-					  "acpi_os_execute() 
>failed\n"));
>+					  
>"acpi_os_queue_for_execution() failed\n"));
> 		}
> 	}
> 	sbs->update_time = update_time;
>diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>index 5753d06..e16e69a 100644
>--- a/drivers/acpi/thermal.c
>+++ b/drivers/acpi/thermal.c
>@@ -657,7 +657,8 @@ static void acpi_thermal_run(unsigned lo
> {
> 	struct acpi_thermal *tz = (struct acpi_thermal *)data;
> 	if (!tz->zombie)
>-		acpi_os_execute(OSL_GPE_HANDLER, 
>acpi_thermal_check, (void *)data);
>+		acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
>+					    acpi_thermal_check, 
>(void *)data);
> }
> 
> static void acpi_thermal_check(void *data)
>diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
>index 0cd63bc..8040084 100644
>--- a/include/acpi/acpiosxf.h
>+++ b/include/acpi/acpiosxf.h
>@@ -50,16 +50,12 @@ #define __ACPIOSXF_H__
> #include "platform/acenv.h"
> #include "actypes.h"
> 
>-/* Types for acpi_os_execute */
>+/* Priorities for acpi_os_queue_for_execution */
> 
>-typedef enum {
>-	OSL_GLOBAL_LOCK_HANDLER,
>-	OSL_NOTIFY_HANDLER,
>-	OSL_GPE_HANDLER,
>-	OSL_DEBUGGER_THREAD,
>-	OSL_EC_POLL_HANDLER,
>-	OSL_EC_BURST_HANDLER
>-} acpi_execute_type;
>+#define OSD_PRIORITY_GPE            1
>+#define OSD_PRIORITY_HIGH           2
>+#define OSD_PRIORITY_MED            3
>+#define OSD_PRIORITY_LO             4
> 
> #define ACPI_NO_UNIT_LIMIT          ((u32) -1)
> #define ACPI_MUTEX_SEM              1
>@@ -188,8 +184,8 @@ acpi_os_remove_interrupt_handler(u32 gsi
> acpi_thread_id acpi_os_get_thread_id(void);
> 
> acpi_status
>-acpi_os_execute(acpi_execute_type type,
>-		acpi_osd_exec_callback function, void *context);
>+acpi_os_queue_for_execution(u32 priority,
>+			    acpi_osd_exec_callback function, 
>void *context);
> 
> void acpi_os_wait_events_complete(void *context);
> 
>
