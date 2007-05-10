From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI: Keep TSC stable, when lapic_timer_c2_ok is set
Date: Thu, 10 May 2007 04:09:37 -0400
Message-ID: <200705100409.37753.lenb@kernel.org>
References: <1178555611.3042.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50014 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbXEJILM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2007 04:11:12 -0400
In-Reply-To: <1178555611.3042.13.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org

On Monday 07 May 2007 12:33, Thomas Gleixner wrote:
> Len,
> 
> can you please integrate the patch into your git tree to make Andrew
> happier. I'd like to see this in 2.6.22 if possible.

what tree does this apply to?

Note, however, that the assumption that the TSC and the LAPIC
timer breaking under the same conditions will not always
be true going forward.

In particular, there will be systems with a fully functional TSC
and a broken LAPIC timer.  But I guess we'll cross that bridge
when we come to it...

-Len

> Thanks,
> 
> 	tglx
> 
> ------------------------>
> 
> Subject: ACPI: Keep TSC stable, when lapic_timer_c2_ok is set
> 
> The local apic timer stop in C2 resp. C3 states is coupled with the
> stop of the TSC. When the local apic timer is marked stable in C2
> on the kernel commandline, then keep the TSC marked stable in C2 as well.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  drivers/acpi/processor_idle.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> Index: linux-acpi-2.6/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-acpi-2.6.orig/drivers/acpi/processor_idle.c
> +++ linux-acpi-2.6/drivers/acpi/processor_idle.c
> @@ -305,18 +305,23 @@ static void acpi_state_timer_broadcast(s
>  				       struct acpi_processor_cx *cx,
>  				       int broadcast)
>  {
> -#ifdef CONFIG_GENERIC_CLOCKEVENTS
> -
>  	int state = cx - pr->power.states;
>  
>  	if (state >= pr->power.timer_broadcast_on_state) {
> +
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
>  		unsigned long reason;
>  
>  		reason = broadcast ?  CLOCK_EVT_NOTIFY_BROADCAST_ENTER :
>  			CLOCK_EVT_NOTIFY_BROADCAST_EXIT;
>  		clockevents_notify(reason, &pr->id);
> -	}
>  #endif
> +
> +#ifdef CONFIG_GENERIC_TIME
> +		/* TSC halts in C2/3, so notify users */
> +		mark_tsc_unstable();
> +#endif
> +	}
>  }
>  
>  #else
> @@ -481,10 +489,6 @@ static void acpi_processor_idle(void)
>  		/* Get end time (ticks) */
>  		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
>  
> -#ifdef CONFIG_GENERIC_TIME
> -		/* TSC halts in C2, so notify users */
> -		mark_tsc_unstable();
> -#endif
>  		/* Re-enable interrupts */
>  		local_irq_enable();
>  		current_thread_info()->status |= TS_POLLING;
> @@ -523,10 +527,6 @@ static void acpi_processor_idle(void)
>  			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
>  		}
>  
> -#ifdef CONFIG_GENERIC_TIME
> -		/* TSC halts in C3, so notify users */
> -		mark_tsc_unstable();
> -#endif
>  		/* Re-enable interrupts */
>  		local_irq_enable();
>  		current_thread_info()->status |= TS_POLLING;
> 
> 
