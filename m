From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/4] ACPI, CPU_IDLE: Support C1 idle time accounting
Date: Thu, 7 Feb 2008 02:38:20 -0500
Message-ID: <200802070238.21068.lenb@kernel.org>
References: <20080201013502.750627000@intel.com> <20080201013629.535233000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45199 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872AbYBGHik (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 02:38:40 -0500
In-Reply-To: <20080201013629.535233000@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: linux-acpi@vger.kernel.org

applied.

thanks,
-len
On Thursday 31 January 2008 20:35, venkatesh.pallipadi@intel.com wrote:
> Show C1 idle time in /sysfs cpuidle interface. C1 idle time may not
> be entirely accurate in all cases. It includes the time spent
> in the interrupt handler after wakeup with "hlt" based C1. But, it will
> be accurate with "mwait" based C1.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.25-rc/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.25-rc.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.25-rc/drivers/acpi/processor_idle.c
> @@ -1382,8 +1382,10 @@ static inline void acpi_idle_do_entry(st
>  static int acpi_idle_enter_c1(struct cpuidle_device *dev,
>  			      struct cpuidle_state *state)
>  {
> +	u32 t1, t2;
>  	struct acpi_processor *pr;
>  	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
> +
>  	pr = processors[smp_processor_id()];
>  
>  	if (unlikely(!pr))
> @@ -1393,12 +1395,14 @@ static int acpi_idle_enter_c1(struct cpu
>  	if (pr->flags.bm_check)
>  		acpi_idle_update_bm_rld(pr, cx);
>  
> +	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
>  	acpi_idle_do_entry(cx);
> +	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
>  
>  	local_irq_enable();
>  	cx->usage++;
>  
> -	return 0;
> +	return ticks_elapsed_in_us(t1, t2);
>  }
>  
>  /**
> @@ -1632,6 +1636,7 @@ static int acpi_processor_setup_cpuidle(
>  		switch (cx->type) {
>  			case ACPI_STATE_C1:
>  			state->flags |= CPUIDLE_FLAG_SHALLOW;
> +			state->flags |= CPUIDLE_FLAG_TIME_VALID;
>  			state->enter = acpi_idle_enter_c1;
>  			dev->safe_state = state;
>  			break;
> 
