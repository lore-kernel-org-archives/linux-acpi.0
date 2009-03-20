From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] ACPI: cap off P-state transition latency from buggy
	BIOSes
Date: Fri, 20 Mar 2009 09:17:45 +0100
Message-ID: <20090320081745.GA31137@elte.hu>
References: <20090319214140.GA28868@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:33290 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbZCTISE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Mar 2009 04:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20090319214140.GA28868@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, mjg59@srcf.ucam.org


* Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:

> Some BIOSes report very high frequency transition latency which 
> are plainly wrong on CPus that can change frequency using native 
> MSR interface.
> 
> One such system is IBM T42 (2327-8ZU) as reported by Owen Taylor 
> and Rik van Riel.
> 
> cpufreq_ondemand driver uses this transition latency to come up 
> with a reasonable sampling interval to sample CPU usage and with 
> such high latency value, ondemand sampling interval ends up being 
> very high (0.5 sec, in this particular case), resulting in 
> performance impact due to slow response to increasing frequency.
> 
> Fix it by capping-off the transition latency to 20uS for native 
> MSR based frequency transitions.
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

btw.., in the next merge window we'll have printk_once():

   f036be9: printk: introduce printk_once()

so then the above can be cleaned up to:

> +	/* Check for high latency (>20uS) from buggy BIOSes, like on T42 */
> +	if (perf->control_register.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
> +	    policy->cpuinfo.transition_latency > 20 * 1000) {
> +
> +		policy->cpuinfo.transition_latency = 20 * 1000;
> +		printk_once(KERN_INFO
> +		    "Capping off P-state tranision latency at 20 uS\n");
> +	}

	Ingo
