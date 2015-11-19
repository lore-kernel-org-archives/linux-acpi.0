From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] CPPC: Initialize and check CPUFreq CPU co-ord type correctly
Date: Thu, 19 Nov 2015 23:17:12 +0100
Message-ID: <2207845.vCMVaXtKa3@vostro.rjw.lan>
References: <CAJ5Y-eY=fo=JT11CqYR09Nis--TLpdHtxo+JyC6nh07kVgUrdg@mail.gmail.com> <1447947607-10822-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50461 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759286AbbKSVrj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 16:47:39 -0500
In-Reply-To: <1447947607-10822-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org

On Thursday, November 19, 2015 10:40:07 AM Ashwin Chaugule wrote:
> The CPU policy struct indicates the co-ordination type
> for all CPUs of a common freq domain. Initialize it
> correctly using the CPU specific data gathered from
> CPPC ACPI lib via acpi_get_psd_map().
> 
> The PSD object is optional, so the cpu->shared_type
> can also be 0. So instead of assuming any value other
> than SW_ANY(0xFD) is unsupported, explictly check
> if shared_type is SW_ALL and then bail.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

I'm assiming that this is a replacement for https://patchwork.kernel.org/patch/7607581/
so I'm going to replace that patch with this one, but that means it will go
into -rc3 instead.

> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index e8cb334..7c0bdfb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -98,10 +98,11 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->max = cpu->perf_caps.highest_perf;
>  	policy->cpuinfo.min_freq = policy->min;
>  	policy->cpuinfo.max_freq = policy->max;
> +	policy->shared_type = cpu->shared_type;
>  
>  	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
>  		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> -	else {
> +	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
>  		/* Support only SW_ANY for now. */
>  		pr_debug("Unsupported CPU co-ord type\n");
>  		return -EFAULT;
> 

Thanks,
Rafael

