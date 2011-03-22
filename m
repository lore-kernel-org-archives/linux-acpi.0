From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi_battery: fribble sysfs files from a resume notifier
Date: Tue, 22 Mar 2011 21:40:42 +0100
Message-ID: <201103222140.42261.rjw@sisk.pl>
References: <20110322201950.GC11925@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57572 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030Ab1CVUkn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Mar 2011 16:40:43 -0400
In-Reply-To: <20110322201950.GC11925@bombadil.infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>, len.brown@intel.com
Cc: mjg@redhat.com, torvalds@linux-foundation.org, linux-acpi@vger.kernel.org

On Tuesday, March 22, 2011, Kyle McMartin wrote:
> From: Kyle McMartin <kyle@redhat.com>
> 
> Commit da8aeb92 re-poked the battery on resume, but Linus reports that
> it broke his eee and partially reverted it in b23fffd7. Unfortunately
> this also results in my x201s giving crack values until the sysfs files
> are poked again. In the revert message, it was suggested that we poke it
> from a PM notifier, so let's do that.
> 
> With this in place, I haven't noticed the units going nutty on my
> gnome-power-manager across a dozen suspends or so...
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> 
>  drivers/acpi/battery.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index ac1a599..fcc13ac 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -33,6 +33,7 @@
>  #include <linux/async.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  #include <linux/proc_fs.h>
> @@ -102,6 +103,7 @@ struct acpi_battery {
>  	struct mutex lock;
>  	struct power_supply bat;
>  	struct acpi_device *device;
> +	struct notifier_block pm_nb;
>  	unsigned long update_time;
>  	int rate_now;
>  	int capacity_now;
> @@ -940,6 +942,21 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
>  		power_supply_changed(&battery->bat);
>  }
>  
> +static int battery_notify(struct notifier_block *nb,
> +			       unsigned long mode, void *_unused)
> +{
> +	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
> +						    pm_nb);
> +	switch (mode) {
> +	case PM_POST_SUSPEND:
> +		sysfs_remove_battery(battery);
> +		sysfs_add_battery(battery);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int acpi_battery_add(struct acpi_device *device)
>  {
>  	int result = 0;
> @@ -972,6 +989,10 @@ static int acpi_battery_add(struct acpi_device *device)
>  #endif
>  		kfree(battery);
>  	}
> +
> +	battery->pm_nb.notifier_call = battery_notify;
> +	register_pm_notifier(&battery->pm_nb);
> +
>  	return result;
>  }
>  
> @@ -982,6 +1003,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
>  	battery = acpi_driver_data(device);
> +	unregister_pm_notifier(&battery->pm_nb);
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  	acpi_battery_remove_fs(device);
>  #endif
> 
> 

