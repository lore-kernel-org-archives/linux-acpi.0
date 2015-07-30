From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH V2] cpufreq: Correct a freq check in cpufreq_set_policy
Date: Thu, 30 Jul 2015 18:10:40 +0800
Message-ID: <55B9F820.9090505@intel.com>
References: <55B6F83D.3040901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B6F83D.3040901@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Pan Xinhui <xinhuix.pan@intel.com>

This check was originally added by commit 9c9a43ed2734 ("[CPUFREQ]
return error when failing to set minfreq").It attempt to return an error
on obviously incorrect limits when we echo xxx >.../scaling_max,min_freq
Actually we just need check if new_policy->min > new_policy->max.
Because at least one of max/min is copied from cpufreq_get_policy().

For example, when we echo xxx > .../scaling_min_freq, new_policy is
copied from policy in cpufreq_get_policy. new_policy->max is same with
policy->max. new_policy->min is set to a new value.

Let me explain it in deduction method, first statement in if ():
new_policy->min > policy->max
policy->max == new_policy->max
==> new_policy->min > new_policy->max

second statement in if():
new_policy->max < policy->min
policy->max < policy->min
==>new_policy->min > new_policy->max (induction method)

So we have proved that we only need check if new_policy->min >
new_policy->max.

After apply this patch, we can also modify ->min and ->max at same time
if new freq range is very much different from current freq range. For
example, if current freq range is 480000-960000, then we want to set
this range to 1120000-2240000, we would fail in the past because
new_policy->min > policy->max. As long as the cpufreq range is valid, we
has no reason to reject the user. So correct the check to avoid such
case.

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
Change from V1:
	just update comments.
---
 drivers/cpufreq/cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 26063af..a32f50b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2245,7 +2245,11 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
-	if (new_policy->min > policy->max || new_policy->max < policy->min)
+	/*
+	* This check works well when we store new min/max freq attributes,
+	* because new_policy is a copy of policy with one field updated.
+	*/
+	if (new_policy->min > new_policy->max)
 		return -EINVAL;
 
 	/* verify the cpu speed can be set within this limit */
-- 
1.9.1
