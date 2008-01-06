From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 12:06:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801061203510.7367-100000@netrider.rowland.org>
References: <200801061419.52277.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:1153 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754239AbYAFRGm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 12:06:42 -0500
In-Reply-To: <200801061419.52277.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:

> > If you can figure out a way to disable the warning in device_del() for 
> > just the one device being unregistered by 
> > device_pm_destroy_suspended(),
> 
> Something like this, perhaps:
> 
> @@ -905,6 +915,18 @@ void device_del(struct device * dev)
>  	struct device * parent = dev->parent;
>  	struct class_interface *class_intf;
>  
> +	if (down_trylock(&dev->sem)) {
> +		if (pm_sleep_lock()) {
> +			dev_warn(dev, "Illegal %s during suspend\n",
> +				__FUNCTION__);
> +			dump_stack();
> +		} else {
> +			pm_sleep_unlock();
> +		}
> +	} else {
> +		up(&dev->sem);
> +	}
> +
>  	if (parent)
>  		klist_del(&dev->knode_parent);
>  	if (MAJOR(dev->devt))

Bizarre, but it should work.  Be sure to include plenty of explanatory 
comments -- otherwise nobody will be able to figure it out!  :-)

Alan Stern

