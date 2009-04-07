From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/2] acpi x86: Make aperf/mperf MSR access in acpi_cpufreq
 read_only
Date: Tue, 07 Apr 2009 01:35:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070135120.5698@localhost.localdomain>
References: <20090406182606.706570000@intel.com>
 <20090406182724.072503000@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:55926 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbZDGFfc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 01:35:32 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP00DR2U74LGEE@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 00:35:29 -0500 (CDT)
In-reply-to: <20090406182724.072503000@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.orgt

applied

(and cpufreq@vger.kernel.org cc'd)

thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 6 Apr 2009, venkatesh.pallipadi@intel.com wrote:

> Not write zeroes to APERF and MPERF by ondemand governor. With this
> change, other users can share these MSRs for reads.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> ---
>  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> index 340bdbe..9d3af38 100644
> --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> +++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -68,6 +68,7 @@ struct acpi_cpufreq_data {
>  	unsigned int max_freq;
>  	unsigned int resume;
>  	unsigned int cpu_feature;
> +	u64 saved_aperf, saved_mperf;
>  };
>  
>  static DEFINE_PER_CPU(struct acpi_cpufreq_data *, drv_data);
> @@ -259,9 +260,6 @@ static long read_measured_perf_ctrs(void *_cur)
>  	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
>  	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
>  
> -	wrmsr(MSR_IA32_APERF, 0, 0);
> -	wrmsr(MSR_IA32_MPERF, 0, 0);
> -
>  	return 0;
>  }
>  
> @@ -281,13 +279,20 @@ static long read_measured_perf_ctrs(void *_cur)
>  static unsigned int get_measured_perf(struct cpufreq_policy *policy,
>  				      unsigned int cpu)
>  {
> -	struct perf_pair cur;
> +	struct perf_pair readin, cur;
>  	unsigned int perf_percent;
>  	unsigned int retval;
>  
> -	if (!work_on_cpu(cpu, read_measured_perf_ctrs, &cur))
> +	if (!work_on_cpu(cpu, read_measured_perf_ctrs, &readin))
>  		return 0;
>  
> +	cur.aperf.whole = readin.aperf.whole -
> +				per_cpu(drv_data, cpu)->saved_aperf;
> +	cur.mperf.whole = readin.mperf.whole -
> +				per_cpu(drv_data, cpu)->saved_mperf;
> +	per_cpu(drv_data, cpu)->saved_aperf = readin.aperf.whole;
> +	per_cpu(drv_data, cpu)->saved_mperf = readin.mperf.whole;
> +
>  #ifdef __i386__
>  	/*
>  	 * We dont want to do 64 bit divide with 32 bit kernel
> -- 
> 1.6.0.6
> 
> -- 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
