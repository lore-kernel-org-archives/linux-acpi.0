From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/3] cpuidle hang fix
Date: Sun, 29 Apr 2007 00:42:40 -0400
Message-ID: <200704290042.40625.lenb@kernel.org>
References: <200704260703.l3Q73xdQ023270@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57485 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbXD2Emw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:42:52 -0400
In-Reply-To: <200704260703.l3Q73xdQ023270@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com

Applied to acpi-test
thanks,
-Len

On Thursday 26 April 2007 03:03, akpm@linux-foundation.org wrote:
> From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Prevent hang on x86-64, when ACPI processor driver is added as a module on
> a system that does not support C-states.
> 
> x86-64 expects all idle handlers to enable interrupts before returning from
> idle handler.  This is due to enter_idle(), exit_idle() races.  Make
> cpuidle_idle_call() confirm to this when there is no pm_idle_old.
> 
> Also, cpuidle look at the return values of attch_driver() and set
> current_driver to NULL if attach fails on all CPUs.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/cpuidle/cpuidle.c |    2 ++
>  drivers/cpuidle/driver.c  |   15 ++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff -puN drivers/cpuidle/cpuidle.c~cpuidle-hang-fix drivers/cpuidle/cpuidle.c
> --- a/drivers/cpuidle/cpuidle.c~cpuidle-hang-fix
> +++ a/drivers/cpuidle/cpuidle.c
> @@ -43,6 +43,8 @@ static void cpuidle_idle_call(void)
>  	if (dev->status != CPUIDLE_STATUS_DOIDLE) {
>  		if (pm_idle_old)
>  			pm_idle_old();
> +		else
> +			local_irq_enable();
>  		return;
>  	}
>  
> diff -puN drivers/cpuidle/driver.c~cpuidle-hang-fix drivers/cpuidle/driver.c
> --- a/drivers/cpuidle/driver.c~cpuidle-hang-fix
> +++ a/drivers/cpuidle/driver.c
> @@ -107,11 +107,20 @@ int cpuidle_switch_driver(struct cpuidle
>  	cpuidle_curr_driver = drv;
>  
>  	if (drv) {
> +		int ret = 1;
>  		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> -			cpuidle_attach_driver(dev);
> -		if (cpuidle_curr_governor)
> +			if (cpuidle_attach_driver(dev) == 0)
> +				ret = 0;
> +
> +		/* If attach on all devices fail, switch to NULL driver */
> +		if (ret)
> +			cpuidle_curr_driver = NULL;
> +
> +		if (cpuidle_curr_driver && cpuidle_curr_governor) {
> +			printk(KERN_INFO "cpuidle: using driver %s\n",
> +					drv->name);
>  			cpuidle_install_idle_handler();
> -		printk(KERN_INFO "cpuidle: using driver %s\n", drv->name);
> +		}
>  	}
>  
>  	return 0;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
