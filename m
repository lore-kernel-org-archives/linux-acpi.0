From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 057/112] ACPI: register ACPI Processor as generic
	thermal cooling device
Date: Tue, 12 Feb 2008 09:14:49 +0100
Message-ID: <1202804089.7977.497.camel@queen.suse.de>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
	 <d9460fd227ed2ce52941b6a12ad4de05c195f6aa.1202376824.git.len.brown@intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:50419 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbYBLIOv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 03:14:51 -0500
In-Reply-To: <d9460fd227ed2ce52941b6a12ad4de05c195f6aa.1202376824.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

Hi,

ok it's a bit late now..., just one comment:

On Thu, 2008-02-07 at 04:34 -0500, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Register ACPI processor as thermal cooling devices.
> A combination of processor T-state and P-state are used for thermal throttling.
> the processor will reduce the frequency first and then set the T-state.
> 
> we use cpufreq_thermal_reduction_pctg to calculate the cpufreq limit,
> and call cpufreq_verify_with_limit to set the cpufreq limit.
> if cpufreq driver is loaded, then we have four cooling state for cpufreq control.
> cooling state 0: cpufreq limit == max_freq
> cooling state 1: cpufreq limit == max_freq * 80%
> cooling state 2: cpufreq limit == max_freq * 60%
> cooling state 3: cpufreq limit == max_freq * 40%

> @@ -93,6 +94,9 @@ static int acpi_processor_apply_limit(struct acpi_processor *pr)
>   * _any_ cpufreq driver and not only the acpi-cpufreq driver.
>   */
>  
> +#define CPUFREQ_THERMAL_MIN_STEP 0
> +#define CPUFREQ_THERMAL_MAX_STEP 3
> +
>  static unsigned int cpufreq_thermal_reduction_pctg[NR_CPUS];
>  static unsigned int acpi_thermal_cpufreq_is_init = 0;
>  
> @@ -109,8 +113,9 @@ static int acpi_thermal_cpufreq_increase(unsigned int cpu)
>  	if (!cpu_has_cpufreq(cpu))
>  		return -ENODEV;
>  
> -	if (cpufreq_thermal_reduction_pctg[cpu] < 60) {
> -		cpufreq_thermal_reduction_pctg[cpu] += 20;
> +	if (cpufreq_thermal_reduction_pctg[cpu] <
> +		CPUFREQ_THERMAL_MAX_STEP) {
> +		cpufreq_thermal_reduction_pctg[cpu]++;
>  		cpufreq_update_policy(cpu);
>  		return 0;
>  	}
> @@ -123,8 +128,9 @@ static int acpi_thermal_cpufreq_decrease(unsigned int cpu)
>  	if (!cpu_has_cpufreq(cpu))
>  		return -ENODEV;
>  
> -	if (cpufreq_thermal_reduction_pctg[cpu] > 20)
> -		cpufreq_thermal_reduction_pctg[cpu] -= 20;
> +	if (cpufreq_thermal_reduction_pctg[cpu] >
> +		(CPUFREQ_THERMAL_MIN_STEP + 1))
cpufreq_thermal_reduction_pctg[cpu] must never be:
CPUFREQ_THERMAL_MIN_STEP 0
or the frequency is set to zero?

This looks a bit confusing, why not define:
#define CPUFREQ_THERMAL_MIN_STEP 1

and then remove the:
CPUFREQ_THERMAL_MIN_STEP + 1
to:
+	if (cpufreq_thermal_reduction_pctg[cpu] >
+		(CPUFREQ_THERMAL_MIN_STEP))
+		cpufreq_thermal_reduction_pctg[cpu]--;

> +		cpufreq_thermal_reduction_pctg[cpu]--;
>  	else
>  		cpufreq_thermal_reduction_pctg[cpu] = 0;
>  	cpufreq_update_policy(cpu);

   Thomas

