From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Workaround for _PPC (BIOS cpufreq limitations)
Date: Sat, 19 May 2007 00:55:58 -0400
Message-ID: <200705190055.58626.lenb@kernel.org>
References: <1179543568.16465.35.camel@sublime.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41026 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbXESE66 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 May 2007 00:58:58 -0400
In-Reply-To: <1179543568.16465.35.camel@sublime.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Friday 18 May 2007 22:59, Thomas Renninger wrote:
> Len, can you apply this one, pls.
> 
> Workaround for _PPC (BIOS cpufreq limitations)
> 
> There have been fixes using _PPC, which seem to unhide a problem
> on HP nx6125 (double cpufreq switch freezes the machine for
> several seconds).
> This one should provide a workaround for the nx6125 and for
> possible other machines that show any weird _PPC behaviour.

I don't understand what the failure is, and why this workaround
is effective.  Is this a clue here to a real bug
that requires a real fix, rather than a workaround?

-Len

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> ---
>  drivers/acpi/processor_perflib.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.21/drivers/acpi/processor_perflib.c
> ===================================================================
> --- linux-2.6.21.orig/drivers/acpi/processor_perflib.c
> +++ linux-2.6.21/drivers/acpi/processor_perflib.c
> @@ -60,6 +60,11 @@ static DEFINE_MUTEX(performance_mutex);
>   * policy is adjusted accordingly.
>   */
>  
> +static unsigned int ignore_ppc = 0;
> +module_param(ignore_ppc, uint, 0644);
> +MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> +		 "limited by BIOS, this should help");
> +
>  #define PPC_REGISTERED   1
>  #define PPC_IN_USE       2
>  
> @@ -72,6 +77,9 @@ static int acpi_processor_ppc_notifier(s
>  	struct acpi_processor *pr;
>  	unsigned int ppc = 0;
>  
> +	if (ignore_ppc)
> +		return 0;
> +
>  	mutex_lock(&performance_mutex);
>  
>  	if (event != CPUFREQ_INCOMPATIBLE)
> @@ -130,7 +138,13 @@ static int acpi_processor_get_platform_l
>  
>  int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
>  {
> -	int ret = acpi_processor_get_platform_limit(pr);
> +	int ret;
> +
> +	if (ignore_ppc)
> +		return 0;
> +
> +	ret = acpi_processor_get_platform_limit(pr);
> +
>  	if (ret < 0)
>  		return (ret);
>  	else
> 
> 
