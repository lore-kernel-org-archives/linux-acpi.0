From: Dan <dan-bIuJOMs36aklhIHd5qHT+2D2FQJk+8+b@public.gmane.org>
Subject: Re: No handler for Region [ERAM] on Gateway M350?
Date: Sun, 11 Jan 2004 18:31:21 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073874681.5123.11.camel@kinkakuji>
References: <1073784787.4900.14.camel@kinkakuji>
	 <20040111164210.GC14031@poupinou.org>  <1073855519.4764.8.camel@kinkakuji>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1073855519.4764.8.camel-o+XryGznM0/1KXRcyAk9cg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> problems...I shall continue poking away at the 2.6 tree in an attempt to
> patch it with the ecdt_fake patch =)

Well, I've managed to get the patch (from
http://sourceforge.net/mailarchive/message.php?msg_id=6561311) to apply
to the 2.6.1 kernel source, and it does indeed fix my issue with not
seeing the /proc/acpi/battery/BAT0 directory, only it seems to have
broken the event model -- acpid no longer reports any events, nor can I
pick them up by hand by watching /proc/acpi/event ... I suspect that
this is due to the tinkering that I had to do with regards to the fact
that schedule_task() no longer exists in linux/sched.h in 2.6 (I'm
assuming due to the massive scheduler overhaul done between versions),
and so I was somewhat at a loss as for what to do with the following
section of the patch to drivers/acpi/osl.c (note my comment near the end
for the particular line that is the source of most of my troubles):

@@ -639,45 +651,63 @@
  	void			*context)
  {
  	acpi_status 		status = AE_OK;
 -	struct acpi_os_dpc	*dpc = NULL;
 -	struct tq_struct	*task;
 +	struct acpi_os_dpc	*dpc;
  
 -	ACPI_FUNCTION_TRACE ("os_queue_for_execution");
 +	ACPI_FUNCTION_TRACE ("acpi_os_queue_for_execution");
  
  	ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "Scheduling function [%p(%p)] for deferred
execution.\n", function, context));
  
  	if (!function)
  		return_ACPI_STATUS (AE_BAD_PARAMETER);
 -
 -	/*
 -	 * Allocate/initialize DPC structure.  Note that this memory will be
 -	 * freed by the callee.  The kernel handles the tq_struct list  in a
 -	 * way that allows us to also free its memory inside the callee.
 -	 * Because we may want to schedule several tasks with different
 -	 * parameters we can't use the approach some kernel code uses of
 -	 * having a static tq_struct.
 -	 * We can save time and code by allocating the DPC and tq_structs
 -	 * from the same memory.
 -	 */
 -	dpc = kmalloc(sizeof(struct acpi_os_dpc)+sizeof(struct tq_struct), GFP_ATOMIC);
 +	dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
  	if (!dpc)
  		return_ACPI_STATUS (AE_NO_MEMORY);
  
  	dpc->function = function;
  	dpc->context = context;
 -
 -	task = (void *)(dpc+1);
 -	INIT_TQUEUE(task, acpi_os_execute_deferred, (void*)dpc);
 -
 -	if (!schedule_task(task)) {
 -		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_task() failed.\n"));
 -		kfree(dpc);
 -		status = AE_ERROR;
 +	INIT_LIST_HEAD(&dpc->next);
 +	
 +	spin_lock(&acpi_events_list_spinlock);
 +	list_add_tail(&dpc->next, &acpi_events_list);
 +	if (first_acpi_event || (!task.sync)) {
 +		INIT_TQUEUE(&task, do_acpi_task_queue, NULL);
/* ****** This line below in particular; all else stems from this =\ ***** */
 +		if (!schedule_task(&task)) {   
 +			ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_work() failed.\n"));
 +			kfree(dpc);
 +			status = AE_ERROR;
 +		}
 +		first_acpi_event = 0;
  	}
 +	spin_unlock(&acpi_events_list_spinlock);
  
~~~~~~~~~End patch excerpt~~~~~~~~

Unfortunately, I don't know much about task scheduling in the 2.6 kernel, 
so I'm stuck on this one for a bit, at least...any ideas from someone more 
knowledgeable than I about this sort of thing? =)

Thanks,
~D. Stone



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
