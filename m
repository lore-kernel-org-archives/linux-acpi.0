From: chen gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI: Don't let acpi_pad needlessly mark LAPIC unstable
Date: Wed, 02 Jun 2010 14:30:17 +0800
Message-ID: <4C05FA79.2030300@linux.intel.com>
References: <1275190628-18265-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:51106 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751674Ab0FBGaU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 02:30:20 -0400
In-Reply-To: <1275190628-18265-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: venki@google.com, shaohua.li@intel.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On 2010-5-30 11:37, Chen Gong wrote:
> according to Venki's suggestion in the commit 0dc698b,
> adding LAPIC unstable detection in the acpi_pad drvier too.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/acpi_pad.c |   36 ++++++++++++++++++++++++------------
>  1 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index d269a8f..446aced 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -46,6 +46,8 @@ static unsigned long power_saving_mwait_eax;
>  
>  static unsigned char tsc_detected_unstable;
>  static unsigned char tsc_marked_unstable;
> +static unsigned char lapic_detected_unstable;
> +static unsigned char lapic_marked_unstable;
>  
>  static void power_saving_mwait_init(void)
>  {
> @@ -75,9 +77,6 @@ static void power_saving_mwait_init(void)
>  	power_saving_mwait_eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
>  		(highest_subcstate - 1);
>  
> -	for_each_online_cpu(i)
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &i);
> -
>  #if defined(CONFIG_GENERIC_TIME) && defined(CONFIG_X86)
>  	switch (boot_cpu_data.x86_vendor) {
>  	case X86_VENDOR_AMD:
> @@ -86,13 +85,15 @@ static void power_saving_mwait_init(void)
>  		 * AMD Fam10h TSC will tick in all
>  		 * C/P/S0/S1 states when this bit is set.
>  		 */
> -		if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
> -			return;
> -
> -		/*FALL THROUGH*/
> +		if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
> +			tsc_detected_unstable = 1;
> +		if (!boot_cpu_has(X86_FEATURE_ARAT))
> +			lapic_detected_unstable = 1;
> +		break;
>  	default:
> -		/* TSC could halt in idle */
> +		/* TSC & LAPIC could halt in idle */
>  		tsc_detected_unstable = 1;
> +		lapic_detected_unstable = 1;
>  	}
>  #endif
>  }
> @@ -180,10 +181,20 @@ static int power_saving_thread(void *data)
>  				mark_tsc_unstable("TSC halts in idle");
>  				tsc_marked_unstable = 1;
>  			}
> +			if (lapic_detected_unstable && !lapic_marked_unstable) {
> +				int i;
> +				/* LAPIC could halt in idle, so notify users */
> +				for_each_online_cpu(i)
> +					clockevents_notify(
> +						CLOCK_EVT_NOTIFY_BROADCAST_ON,
> +						&i);
> +				lapic_marked_unstable = 1;
> +			}
>  			local_irq_disable();
>  			cpu = smp_processor_id();
> -			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> -				&cpu);
> +			if (lapic_marked_unstable)
> +				clockevents_notify(
> +					CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>  			stop_critical_timings();
>  
>  			__monitor((void *)&current_thread_info()->flags, 0, 0);
> @@ -192,8 +203,9 @@ static int power_saving_thread(void *data)
>  				__mwait(power_saving_mwait_eax, 1);
>  
>  			start_critical_timings();
> -			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
> -				&cpu);
> +			if (lapic_marked_unstable)
> +				clockevents_notify(
> +					CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>  			local_irq_enable();
>  
>  			if (jiffies > expire_time) {

Ping again.
Is it reasonable ?
