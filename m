From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: cap off P-state transition latency from buggy BIOSes
Date: Fri, 27 Mar 2009 21:23:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903272122110.26419@localhost.localdomain>
References: <20090319214140.GA28868@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:16040 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZC1BX6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 21:23:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH600F0ZZVA73DO@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 20:23:35 -0500 (CDT)
In-reply-to: <20090319214140.GA28868@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, mjg59@srcf.ucam.org


On Thu, 19 Mar 2009, Pallipadi, Venkatesh wrote:

> 
> Some BIOSes report very high frequency transition latency which are plainly
> wrong on CPus that can change frequency using native MSR interface.
> 
> One such system is IBM T42 (2327-8ZU) as reported by Owen Taylor and
> Rik van Riel.
> 
> cpufreq_ondemand driver uses this transition latency to come up with a
> reasonable sampling interval to sample CPU usage and with such high
> latency value, ondemand sampling interval ends up being very high
> (0.5 sec, in this particular case), resulting in performance impact due to
> slow response to increasing frequency.
> 
> Fix it by capping-off the transition latency to 20uS for native MSR based
> frequency transitions.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> ---
>  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2008-05-02 09:45:23.000000000 -0700
> +++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2008-06-30 12:08:32.000000000 -0700
> @@ -659,6 +659,18 @@ static int acpi_cpufreq_cpu_init(struct 
>  			    perf->states[i].transition_latency * 1000;
>  	}
>  
> +	/* Check for high latency (>20uS) from buggy BIOSes, like on T42 */
> +	if (perf->control_register.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
> +	    policy->cpuinfo.transition_latency > 20 * 1000) {
> +		static int print_once;
> +		policy->cpuinfo.transition_latency = 20 * 1000;
> +		if (!print_once) {
> +			print_once = 1;
> +			printk(KERN_INFO "Capping off P-state tranision latency"
> +				" at 20 uS\n");
> +		}
> +	}
> +
>  	data->max_freq = perf->states[0].core_frequency * 1000;
>  	/* table init */
>  	for (i=0; i<perf->state_count; i++) {
> --

Sort of makes you wonder if Windows is using this bogus info, or 
ignoring it...

applied.

thanks,
Len Brown, Intel Open Source Technology Center


