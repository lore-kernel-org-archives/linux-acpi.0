From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Clean-up GPE handling across suspend/resume for wake-up devices
Date: Thu, 27 Sep 2007 15:47:23 -0400
Message-ID: <200709271547.23988.lenb@kernel.org>
References: <20070926154730.31557.81389.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42060 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758379AbXI0Trl (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2007 15:47:41 -0400
In-Reply-To: <20070926154730.31557.81389.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

Thanks for re-freshing this patch on top of 2.6.23-rc8, Alexey.

Applied.
-Len


On Wednesday 26 September 2007 11:47, Alexey Starikovskiy wrote:
> acpi_gpe_sleep_prepare() does not have counterpart at resume time, so changes to GPEs are final.
> In case someone use S4 and then try S3, he will miss some wakeup devices.
> So, acpi_gpe_sleep_prepare() is removed, and acpi_enable_wakeup_device() gets its functionality.
> acpi_disable_wakeup_device() rolls back the changes.
> 
> Reference: https://bugzilla.novell.com/show_bug.cgi?id=292300
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/sleep/main.c   |    1 
>  drivers/acpi/sleep/sleep.h  |    1 
>  drivers/acpi/sleep/wakeup.c |  117 +++++++++++++++----------------------------
>  include/acpi/acpi_bus.h     |    1 
>  4 files changed, 40 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index 2cbb9aa..9426ac1 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -44,7 +44,6 @@ int acpi_sleep_prepare(u32 acpi_state)
>  	ACPI_FLUSH_CPU_CACHE();
>  	acpi_enable_wakeup_device_prep(acpi_state);
>  #endif
> -	acpi_gpe_sleep_prepare(acpi_state);
>  	acpi_enter_sleep_state_prep(acpi_state);
>  	return 0;
>  }
> diff --git a/drivers/acpi/sleep/sleep.h b/drivers/acpi/sleep/sleep.h
> index ff1f850..a2ea125 100644
> --- a/drivers/acpi/sleep/sleep.h
> +++ b/drivers/acpi/sleep/sleep.h
> @@ -5,6 +5,5 @@ extern int acpi_suspend (u32 state);
>  extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
>  extern void acpi_enable_wakeup_device(u8 sleep_state);
>  extern void acpi_disable_wakeup_device(u8 sleep_state);
> -extern void acpi_gpe_sleep_prepare(u32 sleep_state);
>  
>  extern int acpi_sleep_prepare(u32 acpi_state);
> diff --git a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/sleep/wakeup.c
> index 97c27dd..ed8e41b 100644
> --- a/drivers/acpi/sleep/wakeup.c
> +++ b/drivers/acpi/sleep/wakeup.c
> @@ -64,36 +64,29 @@ void acpi_enable_wakeup_device(u8 sleep_state)
>  	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
>  	spin_lock(&acpi_device_lock);
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev = container_of(node,
> -						       struct acpi_device,
> -						       wakeup_list);
> -
> +		struct acpi_device *dev =
> +			container_of(node, struct acpi_device, wakeup_list);
> +		if (!dev->wakeup.flags.valid)
> +			continue;
>  		/* If users want to disable run-wake GPE,
>  		 * we only disable it for wake and leave it for runtime
>  		 */
> -		if (dev->wakeup.flags.run_wake && !dev->wakeup.state.enabled) {
> -			spin_unlock(&acpi_device_lock);
> -			acpi_set_gpe_type(dev->wakeup.gpe_device,
> -					  dev->wakeup.gpe_number,
> -					  ACPI_GPE_TYPE_RUNTIME);
> -			/* Re-enable it, since set_gpe_type will disable it */
> -			acpi_enable_gpe(dev->wakeup.gpe_device,
> -					dev->wakeup.gpe_number, ACPI_ISR);
> -			spin_lock(&acpi_device_lock);
> +		if (!dev->wakeup.state.enabled ||
> +		    sleep_state > (u32) dev->wakeup.sleep_state) {
> +			if (dev->wakeup.flags.run_wake) {
> +				spin_unlock(&acpi_device_lock);
> +				/* set_gpe_type will disable GPE, leave it like that */
> +				acpi_set_gpe_type(dev->wakeup.gpe_device,
> +						  dev->wakeup.gpe_number,
> +						  ACPI_GPE_TYPE_RUNTIME);
> +				spin_lock(&acpi_device_lock);
> +			}
>  			continue;
>  		}
> -
> -		if (!dev->wakeup.flags.valid ||
> -		    !dev->wakeup.state.enabled ||
> -		    (sleep_state > (u32) dev->wakeup.sleep_state))
> -			continue;
> -
>  		spin_unlock(&acpi_device_lock);
> -		/* run-wake GPE has been enabled */
>  		if (!dev->wakeup.flags.run_wake)
>  			acpi_enable_gpe(dev->wakeup.gpe_device,
>  					dev->wakeup.gpe_number, ACPI_ISR);
> -		dev->wakeup.state.active = 1;
>  		spin_lock(&acpi_device_lock);
>  	}
>  	spin_unlock(&acpi_device_lock);
> @@ -112,26 +105,25 @@ void acpi_disable_wakeup_device(u8 sleep_state)
>  
>  	spin_lock(&acpi_device_lock);
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev = container_of(node,
> -						       struct acpi_device,
> -						       wakeup_list);
> +		struct acpi_device *dev =
> +			container_of(node, struct acpi_device, wakeup_list);
>  
> -		if (dev->wakeup.flags.run_wake && !dev->wakeup.state.enabled) {
> -			spin_unlock(&acpi_device_lock);
> -			acpi_set_gpe_type(dev->wakeup.gpe_device,
> -					  dev->wakeup.gpe_number,
> -					  ACPI_GPE_TYPE_WAKE_RUN);
> -			/* Re-enable it, since set_gpe_type will disable it */
> -			acpi_enable_gpe(dev->wakeup.gpe_device,
> -					dev->wakeup.gpe_number, ACPI_NOT_ISR);
> -			spin_lock(&acpi_device_lock);
> +		if (!dev->wakeup.flags.valid)
>  			continue;
> -		}
> -
> -		if (!dev->wakeup.flags.valid ||
> -		    !dev->wakeup.state.active ||
> -		    (sleep_state > (u32) dev->wakeup.sleep_state))
> +		if (!dev->wakeup.state.enabled ||
> +		    sleep_state > (u32) dev->wakeup.sleep_state) {
> +			if (dev->wakeup.flags.run_wake) {
> +				spin_unlock(&acpi_device_lock);
> +				acpi_set_gpe_type(dev->wakeup.gpe_device,
> +						  dev->wakeup.gpe_number,
> +						  ACPI_GPE_TYPE_WAKE_RUN);
> +				/* Re-enable it, since set_gpe_type will disable it */
> +				acpi_enable_gpe(dev->wakeup.gpe_device,
> +						dev->wakeup.gpe_number, ACPI_NOT_ISR);
> +				spin_lock(&acpi_device_lock);
> +			}
>  			continue;
> +		}
>  
>  		spin_unlock(&acpi_device_lock);
>  		acpi_disable_wakeup_device_power(dev);
> @@ -142,7 +134,6 @@ void acpi_disable_wakeup_device(u8 sleep_state)
>  			acpi_clear_gpe(dev->wakeup.gpe_device,
>  				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
>  		}
> -		dev->wakeup.state.active = 0;
>  		spin_lock(&acpi_device_lock);
>  	}
>  	spin_unlock(&acpi_device_lock);
> @@ -160,48 +151,20 @@ static int __init acpi_wakeup_device_init(void)
>  		struct acpi_device *dev = container_of(node,
>  						       struct acpi_device,
>  						       wakeup_list);
> -
>  		/* In case user doesn't load button driver */
> -		if (dev->wakeup.flags.run_wake && !dev->wakeup.state.enabled) {
> -			spin_unlock(&acpi_device_lock);
> -			acpi_set_gpe_type(dev->wakeup.gpe_device,
> -					  dev->wakeup.gpe_number,
> -					  ACPI_GPE_TYPE_WAKE_RUN);
> -			acpi_enable_gpe(dev->wakeup.gpe_device,
> -					dev->wakeup.gpe_number, ACPI_NOT_ISR);
> -			dev->wakeup.state.enabled = 1;
> -			spin_lock(&acpi_device_lock);
> -		}
> +		if (!dev->wakeup.flags.run_wake || dev->wakeup.state.enabled)
> +			continue;
> +		spin_unlock(&acpi_device_lock);
> +		acpi_set_gpe_type(dev->wakeup.gpe_device,
> +				  dev->wakeup.gpe_number,
> +				  ACPI_GPE_TYPE_WAKE_RUN);
> +		acpi_enable_gpe(dev->wakeup.gpe_device,
> +				dev->wakeup.gpe_number, ACPI_NOT_ISR);
> +		dev->wakeup.state.enabled = 1;
> +		spin_lock(&acpi_device_lock);
>  	}
>  	spin_unlock(&acpi_device_lock);
> -
>  	return 0;
>  }
>  
>  late_initcall(acpi_wakeup_device_init);
> -
> -/*
> - * Disable all wakeup GPEs before entering requested sleep state.
> - *	@sleep_state:	ACPI state
> - * Since acpi_enter_sleep_state() will disable all
> - * RUNTIME GPEs, we simply mark all GPES that
> - * are not enabled for wakeup from requested state as RUNTIME.
> - */
> -void acpi_gpe_sleep_prepare(u32 sleep_state)
> -{
> -	struct list_head *node, *next;
> -
> -	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev = container_of(node,
> -						       struct acpi_device,
> -						       wakeup_list);
> -
> -		/* The GPE can wakeup system from this state, don't touch it */
> -		if ((u32) dev->wakeup.sleep_state >= sleep_state)
> -			continue;
> -		/* acpi_set_gpe_type will automatically disable GPE */
> -		acpi_set_gpe_type(dev->wakeup.gpe_device,
> -				  dev->wakeup.gpe_number,
> -				  ACPI_GPE_TYPE_RUNTIME);
> -	}
> -}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 8a388e7..7b74b60 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -264,7 +264,6 @@ struct acpi_device_wakeup_flags {
>  
>  struct acpi_device_wakeup_state {
>  	u8 enabled:1;
> -	u8 active:1;
>  };
>  
>  struct acpi_device_wakeup {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
