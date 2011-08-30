From: Josh Boyer <jwboyer@redhat.com>
Subject: Re: [PATCH] ACPI: Ensure thermal limits match CPU frequencies
Date: Tue, 30 Aug 2011 10:03:27 -0400
Message-ID: <20110830140327.GQ2270@zod.bos.redhat.com>
References: <1314642507-32491-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046Ab1H3OEJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Aug 2011 10:04:09 -0400
Content-Disposition: inline
In-Reply-To: <1314642507-32491-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Mon, Aug 29, 2011 at 02:28:27PM -0400, Matthew Garrett wrote:
> The ACPI thermal management code supports slowing down a CPU when it's
> overheating. Right now that's done by choosing to run it at 100%, 75%, 50%
> or 25% of full speed. However, most CPUs do not allow an arbitrary
> frequency to be set and so will run at the first frequency below that value.
> This doesn't match the intent of the specification, which is to drop the
> frequency state by state until the temperature stabalises. Fix this up
> so it uses actual frequencies rather than percentages.
> 
> Reported by: Gene Snider <snider6982@comcast.net>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/processor_thermal.c |   45 +++++++++++++++++++++----------------
>  1 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index 870550d..1c4eb60 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -52,10 +52,8 @@ ACPI_MODULE_NAME("processor_thermal");
>   * _any_ cpufreq driver and not only the acpi-cpufreq driver.
>   */
>  
> -#define CPUFREQ_THERMAL_MIN_STEP 0
> -#define CPUFREQ_THERMAL_MAX_STEP 3
>  
> -static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
> +static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_limit_state);
>  static unsigned int acpi_thermal_cpufreq_is_init = 0;
>  
>  static int cpu_has_cpufreq(unsigned int cpu)
> @@ -70,19 +68,19 @@ static int acpi_thermal_cpufreq_notifier(struct notifier_block *nb,
>  					 unsigned long event, void *data)
>  {
>  	struct cpufreq_policy *policy = data;
> -	unsigned long max_freq = 0;
> +	int state = per_cpu(cpufreq_thermal_limit_state, policy->cpu);
> +	struct cpufreq_frequency_table *table;
>  
>  	if (event != CPUFREQ_ADJUST)
> -		goto out;
> +		return 0;
> +
> +	table = cpufreq_frequency_get_table(policy->cpu);

If CONFIG_CPU_FREQ_TABLE=m and CONFIG_ACPI_PROCESSOR=y, you'll get a
link error for an undefined symbol on this.  This requires
ACPI_PROCESSOR to select CPU_FREQ_TABLE.

josh
