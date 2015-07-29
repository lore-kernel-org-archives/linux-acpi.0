From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Correct a freq check in cpufreq_set_policy
Date: Wed, 29 Jul 2015 02:28:16 +0200
Message-ID: <2213721.TSGdMqobs2@vostro.rjw.lan>
References: <55B6F83D.3040901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59405 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750827AbbG2ABU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2015 20:01:20 -0400
In-Reply-To: <55B6F83D.3040901@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Tuesday, July 28, 2015 11:34:21 AM Pan Xinhui wrote:
> From: Pan Xinhui <xinhuix.pan@intel.com>
> 
> This check was originally added by commit 9c9a43ed2734 ("[CPUFREQ]
> return error when failing to set minfreq").It attempt to return an error
> on obviously incorrect limits when we echo xxx >.../scaling_max,min_freq
> Actually we just need check if new_policy->min > new_policy->max.
> Because at least one of max/min is copied from cpufreq_get_policy().
> 
> For example, when we echo xxx > .../scaling_min_freq, new_policy is
> copied from policy in cpufreq_get_policy. new_policy->max is same with
> policy->max. new_policy->min is set to a new value.
> 
> Let me explain it in deduction method, first statment in if ():
> new_policy->min > policy->max
> policy->max == new_policy->max
> ==> new_policy->min > new_policy->max
> 
> second statment in if():
> new_policy->max < policy->min
> policy->max < policy->min
> ==>new_policy->min > new_policy->max (induction method)
> 
> So we have proved that we only need check if new_policy->min >
> new_policy->max.
> 
> After apply this patch, we can also modify ->min and ->max in same time
> if new freq range is very much different from current freq range. For
> example, if current freq range is 480000-960000, then we want to set
> this range to 1120000-2240000, we would fail in the past because
> new_policy->min > policy->max. As long as the cpufreq range is valid, we
> has no reason to reject the user. So correct the check.
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6424e05..8772346 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2276,7 +2276,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
>  
> -	if (new_policy->min > policy->max || new_policy->max < policy->min)

Please add a comment here mentioning the fact that this *relies* on new_policy
being a copy of policy with one field updated.

> +	if (new_policy->min > new_policy->max)
>  		return -EINVAL;
>  
>  	/* verify the cpu speed can be set within this limit */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
