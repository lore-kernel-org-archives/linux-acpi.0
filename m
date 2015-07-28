From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Correct a freq check in cpufreq_set_policy
Date: Tue, 28 Jul 2015 10:11:37 +0530
Message-ID: <20150728044137.GF1229@linux>
References: <55B6F83D.3040901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B6F83D.3040901@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

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

Does this patch depend on the other patch you sent where you are
trying to update both min/max in the same call to
cpufreq_set_policy()? If so, they should have been part of the same
series in proper order, as you have sent them as separate patches.

Now, if we don't consider your first patch at all, then this patch is
obviously wrong. We need to take care of both the checks.

-- 
viresh
