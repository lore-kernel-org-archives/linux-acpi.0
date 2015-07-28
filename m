From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] cpufreq: Correct a freq check in cpufreq_set_policy
Date: Tue, 28 Jul 2015 13:17:04 +0800
Message-ID: <55B71050.7070707@intel.com>
References: <55B6F83D.3040901@intel.com> <20150728044137.GF1229@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150728044137.GF1229@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

hi, Viresh
	thanks for your quick reply! :)
On 2015=E5=B9=B407=E6=9C=8828=E6=97=A5 12:41, Viresh Kumar wrote:
> On 28-07-15, 11:34, Pan Xinhui wrote:
>> From: Pan Xinhui <xinhuix.pan@intel.com>
>>
>> This check was originally added by commit 9c9a43ed2734 ("[CPUFREQ]
>> return error when failing to set minfreq").It attempt to return an e=
rror
>> on obviously incorrect limits when we echo xxx >.../scaling_max,min_=
freq
>> Actually we just need check if new_policy->min > new_policy->max.
>> Because at least one of max/min is copied from cpufreq_get_policy().
>>
>> For example, when we echo xxx > .../scaling_min_freq, new_policy is
>> copied from policy in cpufreq_get_policy. new_policy->max is same wi=
th
>> policy->max. new_policy->min is set to a new value.
>>
>> Let me explain it in deduction method, first statment in if ():
>> new_policy->min > policy->max
>> policy->max =3D=3D new_policy->max
>> =3D=3D> new_policy->min > new_policy->max
>>
>> second statment in if():
>> new_policy->max < policy->min
>> policy->max < policy->min
>> =3D=3D>new_policy->min > new_policy->max (induction method)
>>
>> So we have proved that we only need check if new_policy->min >
>> new_policy->max.
>>
>> After apply this patch, we can also modify ->min and ->max in same t=
ime
>> if new freq range is very much different from current freq range. Fo=
r
>> example, if current freq range is 480000-960000, then we want to set
>> this range to 1120000-2240000, we would fail in the past because
>> new_policy->min > policy->max. As long as the cpufreq range is valid=
, we
>> has no reason to reject the user. So correct the check.
>>
>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
>=20
> Does this patch depend on the other patch you sent where you are
> trying to update both min/max in the same call to
> cpufreq_set_policy()? If so, they should have been part of the same
> series in proper order, as you have sent them as separate patches.
>

Thanks for pointing out my mistakes. I will send them in a same series =
with proper order.
Sorry for that.
=20
> Now, if we don't consider your first patch at all, then this patch is
> obviously wrong. We need to take care of both the checks.
>=20
Agree, we need take care of every checks. BUT, As We have proved, it's =
equal to check if (new_policy->min > new_policy->max). I don't why it's=
 wrong.
with/without this patch, echo 0 > .../scaling_min_freq has no error. mi=
n freq is just set to the limit min freq. I prefer to treat it as a fea=
ture. :)
So I don't add new_policy->min < policy->cpuinfo.min_freq || new_policy=
->max > policy->cpuinfo.max_freq.

We have ->verify callback, no need to worry about that an out-of-limit =
cpufreq will harm kernel.
This check is just to tell userspace that *the cpufreq you are trying t=
o set is wrong, pls double check.*

thanks
xinhui
