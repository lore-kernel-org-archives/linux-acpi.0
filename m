From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2/5] fix a deadlock in hotplug case
Date: Mon, 22 Jun 2009 15:54:07 -0600
Message-ID: <200906221554.07792.bjorn.helgaas@hp.com>
References: <n> <1245641478-31805-1-git-send-email-rui.zhang@intel.com> <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:39249 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZFVVyH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 17:54:07 -0400
In-Reply-To: <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Sunday 21 June 2009 09:31:15 pm Zhang Rui wrote:
> we used to run the hotplug code in keventd_wq.
> But when hot removing the ACPI battery device,
> power_supply_unregister invokes flush_scheduled_work.
> This causes a deadlock.
> Introduce a new workqueue for hotplug in this patch.
> http://bugzilla.kernel.org/show_bug.cgi?id=13533

Can you be specific about how the deadlock occurs?  That will
make it easier to make sure we don't re-introduce the deadlock
if this design is ever changed in the future.  And I will probably
try to change this design, so this is really a self-serving
request :-)

I suspect the deadlock is something like this:

  <user removes battery, platform generates system-level notify>
    acpi_bus_notify
      blocking_notifier_call_chain
        acpi_dock_notifier_call
          acpi_os_hotplug_execute(acpi_dock_deferred_cb, ...)
            __acpi_os_execute(..., acpi_dock_deferred_cb, ...)
              schedule_work(<acpi_dock_deferred_cb>)
                queue_work(keventd_wq, <acpi_dock_deferred_cb>)
                  <acpi_dock_deferred_cb queued for execution in keventd_wq>

  worker_thread(keventd_wq)
    acpi_os_execute_hp_deferred
      acpi_dock_deferred_cb
        dock_notify
          hotplug_dock_devices
            dock_remove_acpi_device
              acpi_bus_trim
                acpi_bus_remove
                  device_release_driver
                    acpi_device_remove
                      acpi_battery_remove
                        sysfs_remove_battery
                          power_supply_unregister
                            flush_scheduled_work
                              flush_workqueue(keventd_wq)

Now we're waiting for keventd_wq to be flushed, but it won't be
considered flushed until acpi_os_execute_hp_deferred() completes.

This sort of analysis is obviously way too long and too specific
for a source code comment, but it would be nice to have it in the
bugzilla, at least.

And maybe the changelog could mention that flush_scheduled_work()
applies to keventd_wq, just to close the loop there.

The source code comment:

> +/* 
> + * run the hotplug code in a seperate workqueue
> + * to avoid the deadlock issue
> + */

should be more specific about what "the deadlock issue" is.
Maybe something like:

  /*
   * We can't run hotplug code in keventd_wq because the hotplug
   * code may call driver .remove() functions, which often use
   * flush_scheduled_work() to wait for keventd_wq to be flushed.
   */

And it might make more sense to put the comment where the queue
is used, i.e., in __acpi_os_execute(), rather than at the definition.

Bjorn

> +static struct workqueue_struct *kacpi_hotplug_wq;
>  
>  struct acpi_res_list {
>  	resource_size_t start;
> @@ -192,8 +197,10 @@ acpi_status acpi_os_initialize1(void)
>  {
>  	kacpid_wq = create_singlethread_workqueue("kacpid");
>  	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
> +	kacpi_hotplug_wq = create_singlethread_workqueue("kacpi_hotplug");
>  	BUG_ON(!kacpid_wq);
>  	BUG_ON(!kacpi_notify_wq);
> +	BUG_ON(!kacpi_hotplug_wq);
>  	return AE_OK;
>  }
>  
> @@ -206,6 +213,7 @@ acpi_status acpi_os_terminate(void)
>  
>  	destroy_workqueue(kacpid_wq);
>  	destroy_workqueue(kacpi_notify_wq);
> +	destroy_workqueue(kacpi_hotplug_wq);
>  
>  	return AE_OK;
>  }
> @@ -716,6 +724,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
>  	acpi_status status = AE_OK;
>  	struct acpi_os_dpc *dpc;
>  	struct workqueue_struct *queue;
> +	work_func_t func;
>  	int ret;
>  	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
>  			  "Scheduling function [%p(%p)] for deferred execution.\n",
> @@ -740,15 +749,11 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
>  	dpc->function = function;
>  	dpc->context = context;
>  
> -	if (!hp) {
> -		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
> -		queue = (type == OSL_NOTIFY_HANDLER) ?
> -			kacpi_notify_wq : kacpid_wq;
> -		ret = queue_work(queue, &dpc->work);
> -	} else {
> -		INIT_WORK(&dpc->work, acpi_os_execute_hp_deferred);
> -		ret = schedule_work(&dpc->work);
> -	}
> +	queue = hp ? kacpi_hotplug_wq :
> +		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
> +	func = hp ? acpi_os_execute_hp_deferred : acpi_os_execute_deferred;
> +	INIT_WORK(&dpc->work, func);
> +	ret = queue_work(queue, &dpc->work);
>  
>  	if (!ret) {
>  		printk(KERN_ERR PREFIX


