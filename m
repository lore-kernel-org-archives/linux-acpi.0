From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Correct a freq check in cpufreq_set_policy
Date: Tue, 28 Jul 2015 10:54:57 +0530
Message-ID: <20150728052457.GB31364@linux>
References: <55B6F83D.3040901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36042 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbbG1FZD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2015 01:25:03 -0400
Received: by pachj5 with SMTP id hj5so63580927pac.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2015 22:25:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55B6F83D.3040901@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On 28-07-15, 11:34, Pan Xinhui wrote:
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
> +	if (new_policy->min > new_policy->max)
>  		return -EINVAL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
