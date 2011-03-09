From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH]: cpufreq: pcc-cpufreq: don't load driver if get_freq fails during init.
Date: Wed, 9 Mar 2011 17:09:40 +0100
Message-ID: <201103091709.40464.trenn@suse.de>
References: <20110309135906.6554.54389.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41639 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102Ab1CIQJm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Mar 2011 11:09:42 -0500
In-Reply-To: <20110309135906.6554.54389.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Greg Kroah-Hartman <gregkh@novell.com>

Good catch.

On Wednesday, March 09, 2011 03:02:49 PM Naga Chumbalkar wrote:
> 
> Return 0 on failure. This will cause the initialization of the driver
> to fail and prevent the driver from loading if the BIOS cannot handle
> the PCC interface command to "get frequency". Otherwise, the driver
> will load and display a very high value like "4294967274" (which is
> actually -EINVAL) for frequency:
> 
> # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
> 4294967274
> 
> Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>

While this is not a regression, it's an easy fix.
It should make sense to add:
CC: stable@kernel.org
?

   Thomas
> ---
> 
> diff --git a/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c 
b/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c
> index 4f6f679..4a5a42b 100644
> --- a/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c
> +++ b/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c
> @@ -195,7 +195,7 @@ static unsigned int pcc_get_freq(unsigned int cpu)
>  cmd_incomplete:
>  	iowrite16(0, &pcch_hdr->status);
>  	spin_unlock(&pcc_lock);
> -	return -EINVAL;
> +	return 0;
>  }
>  
>  static int pcc_cpufreq_target(struct cpufreq_policy *policy,
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

