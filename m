From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/4] ACPI: Fix acpi_safe_halt usages and interrupt enabling/disabling
Date: Thu, 7 Feb 2008 02:21:06 -0500
Message-ID: <200802070221.07000.lenb@kernel.org>
References: <20080201013502.750627000@intel.com> <20080201013629.115986000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43626 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446AbYBGHVg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 02:21:36 -0500
In-Reply-To: <20080201013629.115986000@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Thursday 31 January 2008 20:35, venkatesh.pallipadi@intel.com wrote:
> acpi_safe_halt() needs interrupts to be disabled for atomic
> need_resched check and safe halt. Otherwise we may miss an
> interrupt and go into halt.
> 
> acpi_safe_halt() also does not enable interrupts on all return paths.
> 
> So the callers should handle enable and disable interrupts around it.
> 
> There were multiple places where this was not happening. Below is the fix.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.25-rc/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.25-rc.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.25-rc/drivers/acpi/processor_idle.c
> @@ -201,6 +201,10 @@ static inline u32 ticks_elapsed_in_us(u3
>  		return PM_TIMER_TICKS_TO_US((0xFFFFFFFF - t1) + t2);
>  }
>  
> +/*
> + * Callers should disable interrupts before the call and enable
> + * interrupts after return.
> + */
>  static void acpi_safe_halt(void)
>  {
>  	current_thread_info()->status &= ~TS_POLLING;
> @@ -393,6 +397,8 @@ static void acpi_processor_idle(void)
>  			pm_idle_save();
>  		else
>  			acpi_safe_halt();
> +
> +		local_irq_enable();
>  		return;
>  	}
>  
> @@ -501,6 +507,7 @@ static void acpi_processor_idle(void)
>  		 *       skew otherwise.
>  		 */
>  		sleep_ticks = 0xFFFFFFFF;
> +		local_irq_enable();
>  		break;
>  
>  	case ACPI_STATE_C2:
> @@ -1378,11 +1385,13 @@ static int acpi_idle_enter_c1(struct cpu
>  	if (unlikely(!pr))
>  		return 0;
>  
> +	local_irq_disable();
>  	if (pr->flags.bm_check)
>  		acpi_idle_update_bm_rld(pr, cx);
>  
>  	acpi_safe_halt();
>  
> +	local_irq_enable();
>  	cx->usage++;
>  
>  	return 0;
> @@ -1490,7 +1499,9 @@ static int acpi_idle_enter_bm(struct cpu
>  		if (dev->safe_state) {
>  			return dev->safe_state->enter(dev, dev->safe_state);
>  		} else {
> +			local_irq_disable();
>  			acpi_safe_halt();
> +			local_irq_enable();
>  			return 0;
>  		}
>  	}
> 
