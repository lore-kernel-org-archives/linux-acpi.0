From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ACPI: Make /proc/acpi/wakeup interface handle PCI devices
 (again)
Date: Fri, 3 Oct 2008 05:51:23 -0700
Message-ID: <20081003055123.bda469ce.akpm@linux-foundation.org>
References: <200809262221.48040.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59126 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022AbYJCMwG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Oct 2008 08:52:06 -0400
In-Reply-To: <200809262221.48040.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Fri, 26 Sep 2008 22:21:47 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Len,
> 
> I think we should do this in .27.

Is Len not there?  Can some other acpi person please review this for
2.6.27 inclusion?


> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI: Make /proc/acpi/wakeup interface handle PCI devices (again)
> 
> Make the ACPI /proc/acpi/wakeup interface set the appropriate
> wake-up bits of physical devices corresponding to the ACPI
> devices and make those bits be set initially for devices that are
> enabled to wake up by default.  This is needed to restore the
> previous behavior for the PCI devices that were previously handled
> correctly with the help of the /proc/acpi/wakeup interface.

hm, if you say so.  It's a bit hard to judge the impact of not fixing this?

When is "previous"?  Was 2.6.26 similarly busted?

Thanks.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/glue.c       |    5 ++++-
>  drivers/acpi/sleep/proc.c |   10 ++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/sleep/proc.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/sleep/proc.c
> +++ linux-2.6/drivers/acpi/sleep/proc.c
> @@ -377,6 +377,14 @@ acpi_system_wakeup_device_seq_show(struc
>  	return 0;
>  }
>  
> +static void physical_device_enable_wakeup(struct acpi_device *adev)
> +{
> +	struct device *dev = acpi_get_physical_device(adev->handle);
> +
> +	if (dev && device_can_wakeup(dev))
> +		device_set_wakeup_enable(dev, adev->wakeup.state.enabled);
> +}
> +
>  static ssize_t
>  acpi_system_write_wakeup_device(struct file *file,
>  				const char __user * buffer,
> @@ -411,6 +419,7 @@ acpi_system_write_wakeup_device(struct f
>  		}
>  	}
>  	if (found_dev) {
> +		physical_device_enable_wakeup(found_dev);
>  		list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>  			struct acpi_device *dev = container_of(node,
>  							       struct
> @@ -428,6 +437,7 @@ acpi_system_write_wakeup_device(struct f
>  				       dev->pnp.bus_id, found_dev->pnp.bus_id);
>  				dev->wakeup.state.enabled =
>  				    found_dev->wakeup.state.enabled;
> +				physical_device_enable_wakeup(dev);
>  			}
>  		}
>  	}
> Index: linux-2.6/drivers/acpi/glue.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/glue.c
> +++ linux-2.6/drivers/acpi/glue.c
> @@ -165,8 +165,11 @@ static int acpi_bind_one(struct device *
>  				"firmware_node");
>  		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
>  				"physical_node");
> -		if (acpi_dev->wakeup.flags.valid)
> +		if (acpi_dev->wakeup.flags.valid) {
>  			device_set_wakeup_capable(dev, true);
> +			device_set_wakeup_enable(dev,
> +						acpi_dev->wakeup.state.enabled);
> +		}
>  	}
>  
>  	return 0;

