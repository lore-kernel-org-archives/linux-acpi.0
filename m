From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 3/8] acpi-cpufreq: First multiply then divide to avoid
 zero results
Date: Fri, 17 Apr 2009 10:10:27 -0700
Message-ID: <1239988227.4529.8641.camel@localhost.localdomain>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
	 <1239978132-6261-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47402 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815AbZDQRNI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 13:13:08 -0400
In-Reply-To: <1239978132-6261-4-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>


Why is this needed? Normal C precedence rules should take care of this.
No?

Thanks,
Venki 

On Fri, 2009-04-17 at 07:22 -0700, Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
> Cc: <cpufreq@vger.kernel.org>
> ---
>  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> index 4475523..7948d88 100644
> --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> +++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -340,7 +340,7 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
>  
>  #endif
>  
> -	retval = per_cpu(drv_data, policy->cpu)->max_freq * perf_percent / 100;
> +	retval = (per_cpu(drv_data, policy->cpu)->max_freq * perf_percent) / 100;
>  
>  	return retval;
>  }

