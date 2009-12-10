From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Thu, 10 Dec 2009 10:31:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912101010090.2825-100000@iolanthe.rowland.org>
References: <200912100018.19723.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54649 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754271AbZLJPbF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 10:31:05 -0500
In-Reply-To: <200912100018.19723.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thu, 10 Dec 2009, Rafael J. Wysocki wrote:

> > How about CONFIG_PROVE_LOCKING?  If lockdep really does start 
> > complaining then switching to completions would be a simple way to 
> > appease it.
> 
> Ah, that one is not set.  I guess I'll try it later, although I've already
> decided to use completions anyway.

You should see how badly lockdep complains about the rwsems.  If it 
really doesn't like them then using completions makes sense.

> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -56,6 +58,7 @@ static bool transition_started;
>  void device_pm_init(struct device *dev)
>  {
>  	dev->power.status = DPM_ON;
> +	init_completion(&dev->power.completion);
>  	pm_runtime_init(dev);
>  }

You need a matching complete_all() in device_pm_remove(), in case 
someone else is waiting for the device when it gets unregistered.

> +/**
> + * dpm_synchronize - Wait for PM callbacks of all devices to complete.
> + */
> +static void dpm_synchronize(void)
> +{
> +	struct device *dev;
> +
> +	async_synchronize_full();
> +
> +	mutex_lock(&dpm_list_mtx);
> +	list_for_each_entry(dev, &dpm_list, power.entry)
> +		INIT_COMPLETION(dev->power.completion);
> +	mutex_unlock(&dpm_list_mtx);
> +}

I agree with Linus, initializing the completions here is weird.  You
should initialize them just before using them.

> @@ -683,6 +786,7 @@ static int dpm_suspend(pm_message_t stat
>  
>  	INIT_LIST_HEAD(&list);
>  	mutex_lock(&dpm_list_mtx);
> +	pm_transition = state;
>  	while (!list_empty(&dpm_list)) {
>  		struct device *dev = to_device(dpm_list.prev);
>  
> @@ -697,13 +801,18 @@ static int dpm_suspend(pm_message_t stat
>  			put_device(dev);
>  			break;
>  		}
> -		dev->power.status = DPM_OFF;
>  		if (!list_empty(&dev->power.entry))
>  			list_move(&dev->power.entry, &list);
>  		put_device(dev);
> +		error = atomic_read(&async_error);
> +		if (error)
> +			break;
>  	}
>  	list_splice(&list, dpm_list.prev);

Here's something you might want to do in a later patch.  These awkward 
list-pointer manipulations can be simplified as follows:

static bool dpm_iterate_forward;
static struct device *dpm_next;

In device_pm_remove():

	mutex_lock(&dpm_list_mtx);
	if (dev == dpm_next)
		dpm_next = to_device(dpm_iterate_forward ?
			dev->power.entry.next : dev->power.entry.prev);
	list_del_init(&dev->power.entry);
	mutex_unlock(&dpm_list_mtx);

In dpm_resume():

	dpm_iterate_forward = true;
	list_for_each_entry_safe(dev, dpm_next, dpm_list, power.entry) {
		...

In dpm_suspend():

	dpm_iterate_forward = false;
	list_for_each_entry_safe_reverse(dev, dpm_next, dpm_list, 
			power.entry) {
		...

Whether this really is better is a matter of opinion; I like it.

Alan Stern

