From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH] CPPC: Initialize CPUFreq CPU co-ord type correctly
Date: Fri, 13 Nov 2015 15:47:43 -0500
Message-ID: <CAJ5Y-eZ6LUd31B_oECmm5eV9ZyyFiOO0KNtYCGikuNSbgxCUEA@mail.gmail.com>
References: <1447375974-3736-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35646 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009AbbKMUsE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2015 15:48:04 -0500
Received: by lfdo63 with SMTP id o63so59175333lfd.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2015 12:48:03 -0800 (PST)
In-Reply-To: <1447375974-3736-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafael Wysocki <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Rafael,

On 12 November 2015 at 19:52, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> The CPU policy struct indicates the co-ordination type
> for all CPUs of a common freq domain. Initialize it
> correctly using the CPU specific data gathered from
> CPPC ACPI lib via acpi_get_psd_map().
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 93c219f..508809b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -98,6 +98,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         policy->max = cpu->perf_caps.highest_perf;
>         policy->cpuinfo.min_freq = policy->min;
>         policy->cpuinfo.max_freq = policy->max;
> +       policy->shared_type = cpu->shared_type;
>
>         if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
>                 cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> --
> 1.9.1
>

I apologize for not spotting this earlier, but I seem to have gotten
overzealous cleaning up code here. Can this make it into v4.4-rc1
along with what you've already pushed out?

Thanks,
Ashwin.
