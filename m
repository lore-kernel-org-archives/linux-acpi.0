From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/Cpureq: Using cpufreq_freq_attr_rw macro to define CPB(Core Performance Boost) attribute
Date: Tue, 13 Aug 2013 13:38:16 +0200
Message-ID: <3406040.uy3dFkLbfM@vostro.rjw.lan>
References: <1376359553-5671-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40910 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757515Ab3HML1u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Aug 2013 07:27:50 -0400
In-Reply-To: <1376359553-5671-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, August 13, 2013 10:05:53 AM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> Standardise the defintion of attribute cpb in the acpi-cpufreq driver
> via cpufreq_freq_attr_rw macro.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Queued up for 3.12.

Thanks,
Rafael


> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index e673670..414ee4d 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -197,7 +197,7 @@ static ssize_t show_cpb(struct cpufreq_policy *policy, char *buf)
>  	return sprintf(buf, "%u\n", boost_enabled);
>  }
>  
> -static struct freq_attr cpb = __ATTR(cpb, 0644, show_cpb, store_cpb);
> +cpufreq_freq_attr_rw(cpb);
>  #endif
>  
>  static int check_est_cpu(unsigned int cpuid)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
