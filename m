From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sat, 5 Jan 2008 15:08:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801051455320.26040-100000@netrider.rowland.org>
References: <200801051936.22307.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:1092 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756500AbYAEUIs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 15:08:48 -0500
In-Reply-To: <200801051936.22307.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sat, 5 Jan 2008, Rafael J. Wysocki wrote:

> Greg, Andrew,
> 
> The appended patch is a replacement for
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch that deadlocked
> suspend and hibernation on some systems.
> 
> Please consider for applying.

This warning message:

> @@ -905,6 +915,13 @@ void device_del(struct device * dev)
>  	struct device * parent = dev->parent;
>  	struct class_interface *class_intf;
>  
> +	if (pm_sleep_lock()) {
> +		dev_warn(dev, "Illegal %s during suspend\n", __FUNCTION__);
> +		dump_stack();
> +	} else {

will unavoidably be triggered by this code:

> +void device_pm_destroy_suspended(struct device *dev)
> +{
> +	pr_debug("PM: Removing suspended device %s:%s\n",
> +		 dev->bus ? dev->bus->name : "No Bus",
> +		 kobject_name(&dev->kobj));
> +	mutex_lock(&dpm_list_mtx);
> +	list_del_init(&dev->power.entry);
> +	mutex_unlock(&dpm_list_mtx);
> +	up(&dev->sem);
> +	device_unregister(dev);
> +}

since the call to device_del() will occur while the pm_sleep_rwsem is
still locked for writing.  That's why I suggested not unregistering
these devices until after everything else has been resumed and the
rwsem has been dropped.

Another thing to watch out for: Just in case somebody ends up calling
destroy_suspended_device(dev) from within dev's own resume method, you 
should interchange the resume_device() and the list_move_tail() 
calls in dpm_resume().

Alan Stern



