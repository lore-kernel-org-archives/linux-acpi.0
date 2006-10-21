From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 8/8] acpi-cpufreq: remove dead code
Date: Sat, 21 Oct 2006 01:28:06 -0400
Message-ID: <200610210128.07621.len.brown@intel.com>
References: <200610202130.k9KLUUfN003257@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33201 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932222AbWJUFZr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Oct 2006 01:25:47 -0400
In-Reply-To: <200610202130.k9KLUUfN003257@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org

I would expect to see this same change in both speedstep-centrino.c and acpi-cpufreq.c, no?

On Friday 20 October 2006 17:30, akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c:396: warning: 'sw_any_bug_dmi_table' defined but not used
> 
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> diff -puN arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~acpi-cpufreq-remove-dead-code arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
> --- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~acpi-cpufreq-remove-dead-code
> +++ a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -402,6 +402,7 @@ static int sw_any_bug_found(struct dmi_s
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SMP
>  static struct dmi_system_id sw_any_bug_dmi_table[] = {
>  	{
>  		.callback = sw_any_bug_found,
> @@ -414,6 +415,7 @@ static struct dmi_system_id sw_any_bug_d
>  	},
>  	{ }
>  };
> +#endif
>  
>  static int
>  acpi_cpufreq_cpu_init (
> _
> 
