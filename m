From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PNPACPI: add support for remote wakeup
Date: Sat, 12 Jun 2010 23:44:00 +0200
Message-ID: <201006122344.00576.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1006071645090.18836-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57126 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab0FLVpz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jun 2010 17:45:55 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006071645090.18836-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday, June 07, 2010, Alan Stern wrote:
> This patch (as1354) adds remote-wakeup support to the pnpacpi driver.
> The new can_wakeup method also allows other PNP protocol drivers
> (pnpbios or iaspnp) to add wakeup support, but I don't know enough
> about how they work to actually do it.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Len, Matthew, is anyone going to merge this patch?  It looks entirely correct
and useful.

Or should I take it?

Rafael


> ---
> 
> Len, this patch seems to have gotten lost in the shuffle, so I'm 
> submitting it again.
> 
> Alan Stern
> 
> 
> 
> Index: usb-2.6/include/linux/pnp.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pnp.h
> +++ usb-2.6/include/linux/pnp.h
> @@ -414,6 +414,7 @@ struct pnp_protocol {
>  	int (*disable) (struct pnp_dev *dev);
>  
>  	/* protocol specific suspend/resume */
> +	bool (*can_wakeup) (struct pnp_dev *dev);
>  	int (*suspend) (struct pnp_dev * dev, pm_message_t state);
>  	int (*resume) (struct pnp_dev * dev);
>  
> Index: usb-2.6/drivers/pnp/core.c
> ===================================================================
> --- usb-2.6.orig/drivers/pnp/core.c
> +++ usb-2.6/drivers/pnp/core.c
> @@ -164,6 +164,9 @@ int __pnp_add_device(struct pnp_dev *dev
>  	list_add_tail(&dev->global_list, &pnp_global);
>  	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
>  	spin_unlock(&pnp_lock);
> +	if (dev->protocol->can_wakeup)
> +		device_set_wakeup_capable(&dev->dev,
> +				dev->protocol->can_wakeup(dev));
>  	return device_register(&dev->dev);
>  }
>  
> Index: usb-2.6/drivers/pnp/pnpacpi/core.c
> ===================================================================
> --- usb-2.6.orig/drivers/pnp/pnpacpi/core.c
> +++ usb-2.6/drivers/pnp/pnpacpi/core.c
> @@ -121,17 +121,37 @@ static int pnpacpi_disable_resources(str
>  }
>  
>  #ifdef CONFIG_ACPI_SLEEP
> +static bool pnpacpi_can_wakeup(struct pnp_dev *dev)
> +{
> +	struct acpi_device *acpi_dev = dev->data;
> +	acpi_handle handle = acpi_dev->handle;
> +
> +	return acpi_bus_can_wakeup(handle);
> +}
> +
>  static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
>  {
>  	struct acpi_device *acpi_dev = dev->data;
>  	acpi_handle handle = acpi_dev->handle;
>  	int power_state;
>  
> +	if (device_can_wakeup(&dev->dev)) {
> +		int rc = acpi_pm_device_sleep_wake(&dev->dev,
> +				device_may_wakeup(&dev->dev));
> +
> +		if (rc)
> +			return rc;
> +	}
>  	power_state = acpi_pm_device_sleep_state(&dev->dev, NULL);
>  	if (power_state < 0)
>  		power_state = (state.event == PM_EVENT_ON) ?
>  				ACPI_STATE_D0 : ACPI_STATE_D3;
>  
> +	/* acpi_bus_set_power() often fails (keyboard port can't be
> +	 * powered-down?), and in any case, our return value is ignored
> +	 * by pnp_bus_suspend().  Hence we don't revert the wakeup
> +	 * setting if the set_power fails.
> +	 */
>  	return acpi_bus_set_power(handle, power_state);
>  }
>  
> @@ -140,6 +160,8 @@ static int pnpacpi_resume(struct pnp_dev
>  	struct acpi_device *acpi_dev = dev->data;
>  	acpi_handle handle = acpi_dev->handle;
>  
> +	if (device_may_wakeup(&dev->dev))
> +		acpi_pm_device_sleep_wake(&dev->dev, false);
>  	return acpi_bus_set_power(handle, ACPI_STATE_D0);
>  }
>  #endif
> @@ -150,6 +172,7 @@ struct pnp_protocol pnpacpi_protocol = {
>  	.set	 = pnpacpi_set_resources,
>  	.disable = pnpacpi_disable_resources,
>  #ifdef CONFIG_ACPI_SLEEP
> +	.can_wakeup = pnpacpi_can_wakeup,
>  	.suspend = pnpacpi_suspend,
>  	.resume = pnpacpi_resume,
>  #endif
