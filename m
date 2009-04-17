From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 4/8] acpi-cpufreq: Do not let get_measured perf depend
 on internal variable
Date: Fri, 17 Apr 2009 10:24:37 -0700
Message-ID: <1239989077.4529.8644.camel@localhost.localdomain>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
	 <1239978132-6261-5-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52800 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962AbZDQR1R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 13:27:17 -0400
In-Reply-To: <1239978132-6261-5-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>


Ack.

I am not sure below printk is adding much value though, considering
cpufreq_frequency_table_cpuinfo() that is initializing cpuinfo.max_freq
is getting called just one line before this code.

Thanks,
Venki

> +	if (perf->states[0].core_frequency * 1000 !=
policy->cpuinfo.max_freq)
> +		printk(KERN_WARNING FW_WARN "P-state 0 is not max freq\n");
> +


On Fri, 2009-04-17 at 07:22 -0700, Thomas Renninger wrote:
> Take already available policy->cpuinfo.max_freq and get rid of acpi-cpufreq
> specific max_freq variable.
> 
> This implies that P0 is always the highest frequency which should always
> be true as ACPI spec says:
> As a result, the zeroth entry describes the highest performance state
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
> Cc: <cpufreq@vger.kernel.org>
> ---
>  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> index 7948d88..7a9a161 100644
> --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> +++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -65,7 +65,6 @@ enum {
>  struct acpi_cpufreq_data {
>  	struct acpi_processor_performance *acpi_data;
>  	struct cpufreq_frequency_table *freq_table;
> -	unsigned int max_freq;
>  	unsigned int resume;
>  	unsigned int cpu_feature;
>  };
> @@ -340,7 +339,7 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
>  
>  #endif
>  
> -	retval = (per_cpu(drv_data, policy->cpu)->max_freq * perf_percent) / 100;
> +	retval = (policy->cpuinfo.max_freq * perf_percent) / 100;
>  
>  	return retval;
>  }
> @@ -698,7 +697,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  				    " latency at 20 uS\n");
>  	}
>  
> -	data->max_freq = perf->states[0].core_frequency * 1000;
>  	/* table init */
>  	for (i = 0; i < perf->state_count; i++) {
>  		if (i > 0 && perf->states[i].core_frequency >=
> @@ -717,6 +715,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	if (result)
>  		goto err_freqfree;
>  
> +	if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
> +		printk(KERN_WARNING FW_WARN "P-state 0 is not max freq\n");
> +
>  	switch (perf->control_register.space_id) {
>  	case ACPI_ADR_SPACE_SYSTEM_IO:
>  		/* Current speed is unknown and not detectable by IO port */

