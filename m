From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/35] ACPI/acpi_pad: Remove the local apic nonsense
Date: Mon, 16 Feb 2015 19:54:12 +0100
Message-ID: <1621111.kx7SauspkE@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <20150216122412.023909722@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62097 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753237AbbBPSbC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Feb 2015 13:31:02 -0500
In-Reply-To: <20150216122412.023909722@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, February 16, 2015 01:14:36 PM Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> While looking through the (ab)use of the clockevents_notify() function
> I stumbled over the following gem in the acpi_pad code:
> 
>   if (lapic_detected_unstable && !lapic_marked_unstable) {
>      /* LAPIC could halt in idle, so notify users */
>      for_each_online_cpu(i)
>        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &i);
>      lapic_marked_unstable = 1;
>   }
> 
> This code calls on the cpu which detects the lapic unstable condition
> first clockevents_notify() to tell the core code that the broadcast
> should be enabled on all online cpus. Brilliant stuff that as it
> notifies the core code a num_online_cpus() times that the broadcast
> should be enabled on the current cpu.
> 
> This probably has never been noticed because that code got never
> tested with NOHZ=n and HIGHRES_TIMER=n or it just worked by chance
> because one of the other mechanisms told the core in the right way
> that the local apic timer is wreckaged.
> 
> Sigh, this is:
> 
>  - The 4th incarnation of idle drivers which has their own mechanism
>    to detect and deal with X86_FEATURE_ARAT.
> 
>  - The 2nd incarnation of fake idle mechanisms with a different set of
>    brainmelting bugs.
> 
>  - Has been merged against an explicit NAK of the scheduler
>    maintainer with the promise to improve it over time.
> 
>  - Another example of featuritis driven trainwreck engineering.
> 
>  - Another pointless waste of my time.
> 
> Fix this nonsense by removing that lapic detection and notification
> logic and simply call into the clockevents code unconditonally. The
> ARAT feature is marked in the lapic clockevent already so the core
> code will just ignore the requests and return.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  drivers/acpi/acpi_pad.c |   26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> Index: linux/drivers/acpi/acpi_pad.c
> ===================================================================
> --- linux.orig/drivers/acpi/acpi_pad.c
> +++ linux/drivers/acpi/acpi_pad.c
> @@ -41,8 +41,6 @@ static unsigned long power_saving_mwait_
>  
>  static unsigned char tsc_detected_unstable;
>  static unsigned char tsc_marked_unstable;
> -static unsigned char lapic_detected_unstable;
> -static unsigned char lapic_marked_unstable;
>  
>  static void power_saving_mwait_init(void)
>  {
> @@ -82,13 +80,10 @@ static void power_saving_mwait_init(void
>  		 */
>  		if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
>  			tsc_detected_unstable = 1;
> -		if (!boot_cpu_has(X86_FEATURE_ARAT))
> -			lapic_detected_unstable = 1;
>  		break;
>  	default:
> -		/* TSC & LAPIC could halt in idle */
> +		/* TSC could halt in idle */
>  		tsc_detected_unstable = 1;
> -		lapic_detected_unstable = 1;
>  	}
>  #endif
>  }
> @@ -177,28 +172,17 @@ static int power_saving_thread(void *dat
>  				mark_tsc_unstable("TSC halts in idle");
>  				tsc_marked_unstable = 1;
>  			}
> -			if (lapic_detected_unstable && !lapic_marked_unstable) {
> -				int i;
> -				/* LAPIC could halt in idle, so notify users */
> -				for_each_online_cpu(i)
> -					clockevents_notify(
> -						CLOCK_EVT_NOTIFY_BROADCAST_ON,
> -						&i);
> -				lapic_marked_unstable = 1;
> -			}
> +			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> +
>  			local_irq_disable();
>  			cpu = smp_processor_id();
> -			if (lapic_marked_unstable)
> -				clockevents_notify(
> -					CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> +			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>  			stop_critical_timings();
>  
>  			mwait_idle_with_hints(power_saving_mwait_eax, 1);
>  
>  			start_critical_timings();
> -			if (lapic_marked_unstable)
> -				clockevents_notify(
> -					CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> +			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>  			local_irq_enable();
>  
>  			if (time_before(expire_time, jiffies)) {
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
