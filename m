Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483B438490
	for <linux-acpi@vger.kernel.org>; Fri,  2 Oct 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945180; cv=none; b=cmfvLAC0KyRqES4kBLiR/WOrOd7LlJcZCH6g6EEiYvV/F2C1GrGel3r53VHFq10QKzCVkIiiN+foMqtrl+I+ySlWdZFvCx+t/EgTeNKP7VA5AGdoAbKrx+xVDVlyBWGyrRnZ+GUJhxl5QHxsHO5koXZAgIsLMku0l5Sj/5pRfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945180; c=relaxed/simple;
	bh=vpmbNHCj8AiW61gBA9TK7A4FEVWBhJ5jgjhYMuO2mjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kszumuiOWYzqWsHB7JaWUXufid0YQiB+yVyPtVG/4/kRQF94NWEgK2R8PhRvYB5aC3v8y76Oy8pjmQEEVYQCIhJQBgqsw5Gb23mdOXuX59BtPiA3vJM0EOI+eKyNpyd166wNOXTxe35mUQooxJQktGQTwha9lZjtee1UVB3iUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qqm0qUao; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AxMIOaMm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qqm0qUao";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AxMIOaMm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nQaN2061966
	for <linux-acpi@vger.kernel.org>; Fri, 2 Oct 2026 12:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TJRKfKcudVdIXp7kbw1mzYEB8ftrNn95nsWIQz3ozyU=; b=Qqm0qUao8AqMrszC
	lwhBZ5MZPsdrBMukQGX0AE6n1C3g+JdMT+L69ecCi+z8vgxzN+PucBN9X9H1eckZ
	5Ni+Di7soU3uUbWEZsP1z/+2XCwUbYTiDeif1g2bkDsN7CH4Jsm6GxJSQilhCWGB
	t3z7UDFi1ipJ2HAUKYap10UHYbXIVfZaYN8bn7VjWf28zynKDlYybBUz5d4Ye6S3
	x+gGLMkrwNwGsejIOvm2Cd5X3+3E1iqbNwOTpkWZIObyuYq6/b5t1bf5oqSADRC8
	Mz9+1s4G6TwRYCcZRORaW8HGil3tVOjqFbEc2txC+D07Hhf+SMoHhrhgm44fIXdv
	D1tVow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256msen6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2026 12:46:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e305755a01so26471405ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2026 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790945177; x=1791549977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJRKfKcudVdIXp7kbw1mzYEB8ftrNn95nsWIQz3ozyU=;
        b=AxMIOaMmmPFZdYMYO5YhpLAu7ybh8Dv3EdqqCprS1SQ2dBw35gk2w9WyaCguOn3Cpv
         /uNuEWJak1QKwrPHK42tgLUTTewBt5QN7c6LSx0l8yeGAC5dJRMS2RRTegtOFc5jhl9i
         sqWw3I73bnhR+tFuhPAKKx+/0aqntE0WF10dA2vOgI+3qisFExK+3pqceo+mdcf0DjKW
         kZWq5qK881fKUXY/bbxsxWOSuY8l4WEtuaKOL34k9YzrNc8u2k9mwjsUUMnUYxM56uMQ
         hQHjbpPPDijqNC5Zz2vatq9bpX9rGBdQ3cjrTE/Q85YDhuwnnwgwXsvreVRRYoj0RpMQ
         uUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945177; x=1791549977;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJRKfKcudVdIXp7kbw1mzYEB8ftrNn95nsWIQz3ozyU=;
        b=YZSJUqsLfGkEQWi8ztuRS6NC4PsOsX1xYEr1ndHEjHzQwuC+tivaOYj/G7FrqBkKSk
         vLZxyk6fmWRkjPwf6A4ElMw1+oLIx6M5bwnSPwDw0OcU4xqpyu0xtjgr7K+KDkn8ny02
         S3OR30KiSC8gxEjEQAxzAUYoq6oNFbK6qQH0d6LY4aNHMocRrfuk4zsXzTFyHYehe/j1
         Gvk6ISW23+SBS/NFSSAls/ibS6xIunq3kpE6yQA21VRNOZuMC3Pl7ji5588dNs0rMStl
         geksizU4E8J9/5D0Q8nJCHqabwniTVxKWJhn+YL7IRjcAp4b9LTA2/1AHOi15NLxDjrw
         UDMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhOAdtElwfl+Fe97gxadO1LJ/CzIFvLQRdzqUVWYjo/AvzArawX4nxASJHTq5DBfOPoJNVYhr5E3Ej@vger.kernel.org
X-Gm-Message-State: AFq9FYJsx5o3r1uVgoTgHVUtXlNF3R/UuiaKbsDZ6g9LXawb3uezyr3G
	GDBB3Yvgpka1CbfkzD7Uf7s75ghNEkJjYj9g0rFcDFPpx5M07+sPnO1hfH0kYtDegr963MPNnD7
	HsaJ6XygVEuLglTEzcn5K0lip+TtABRcSYCQK0NMMpNkOhMWenrXcCB/gJw5LCxhL
X-Gm-Gg: AYBFou2YqTrEad90nkmcGp6SgoluIeTjID4DT+qWLxKlBndUxsSkTk0BtkQCgQllIiW
	N18crauwdB8w00BR4qfMlAtlExPPG0tRdcocote2aBwGKVWEcPgaHo1kvReQIwezgPjrGHkkEKF
	75mnivFNEVB7D6qWYgke1l+oKMvFMV/clZElB8ae94z5jGEtaNkNtOwqGYHYn8NCchb70dorJA0
	OLOR6HaUreqC8Zcjza3A3igyXDcSgCbsaU3WtDyC0xY5o3pb9U3yU3SmQCV3QQLlZLmVr8GTJyh
	UYeLZ+v5P36h0BqcgHKeyt+AzuJcBE54ZSkEbVTttPskkpm90WM8p0/YK2YD0w9kjxQhl6Ztngz
	r3yDLyqeZvyugTUpbZSVzoA9QxWb1mn06Jvxkl9y1G1XAUBxkqhp8q54vOkCkSFuz4uUMYg==
X-Received: by 2002:a17:902:ccd2:b0:2df:59f1:f304 with SMTP id d9443c01a7336-2e49b65e87bmr23206265ad.33.1790945177272;
        Fri, 02 Oct 2026 05:46:17 -0700 (PDT)
X-Received: by 2002:a17:902:ccd2:b0:2df:59f1:f304 with SMTP id d9443c01a7336-2e49b65e87bmr23205955ad.33.1790945176740;
        Fri, 02 Oct 2026 05:46:16 -0700 (PDT)
Received: from [10.133.33.14] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f71c1d8sm7308885ad.70.2026.10.02.05.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 05:46:15 -0700 (PDT)
Message-ID: <4e218e26-19ac-4c05-94a8-c156952f4da0@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 20:46:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: Skip updates for unchanged resolved limits
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org
Cc: zhenglifeng1@huawei.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
        "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Shubhang Kaushik <sh@gentwo.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Peter Zijlstra
 <peterz@infradead.org>, jonathanh@nvidia.com,
        zhanjie9@hisilicon.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, zhongqiu.han@oss.qualcomm.com
References: <20260929102957.2591657-1-christian.loehle@arm.com>
 <20260929102957.2591657-4-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260929102957.2591657-4-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfXwnb/0+U+5Rh+
 AK+yJzMB/5WFTdTm8kypST3FSSu/ExEq6671ACkzfqjJwxl+NXvmN8RV6z8sDxMOoczA9Zmcu0g
 Z1hJ5jvpDE1JfS/yHkLs9u43t/9e+kE=
X-Proofpoint-ORIG-GUID: ISUWM3GTijRMuyOZAMEDO6Fmi5X38Yqd
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfa79a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=wYuGpgGkS1f18Qd9x5MA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: ISUWM3GTijRMuyOZAMEDO6Fmi5X38Yqd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX47bK2nowltXq
 mMElFX/uJmTT1hJVKLaxwWOmW+5hpIT4j5/8S81PNlbRQotWlPI/mLfE+F2D8b3SSJ+DtNIGlBS
 FwTGnTyqD7JsdQdOEtW+uost0616jXAWxX86YiScEPh5thuUnC/sY9Fl1RA9EuhL8bklBzLDwFl
 8UmynLJ93Ec70VouFvnKzlI5awi4rdqWSqH0Fp8c/JJpisYaM2Vl6/1WW5w+v770GpSr944lTVr
 OY21Bc+2eica9OfFNImcpWj9mRyDBF7SBJkfMld2HAGm0/XjdBKFTk/kjDT/9HkCcTrFjOJmssE
 i/dqgzEijL3kAfQ01N5crBGusEMIfA8cw69GT2DklbCgO4ZjjAFW9VCU4wnHapuodhyWCU/Qe5F
 JVCGwo+NOqg3BxvzSIZ52XYp83IZXegenICoZBTHrG9M5NWEfQikEgBlITeQsJWQa7FtgSIcVUB
 FTVxVWM0e31Dcu4cVtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020050

On 9/29/2026 6:29 PM, Christian Loehle wrote:
> Commit 9801be8bef65 ("cpufreq: Avoid redundant target() calls for unchanged
> limits") introduced policy->update_limits to skip ->target() when both the
> frequency and effective limits are unchanged. schedutil still bypasses its
> frequency cache on every limit notification for CPUFREQ_NEED_UPDATE_LIMITS
> drivers, and fast switching never consumes the pending state.
> 
> Keep raw QoS/limit notifications triggering schedutil recomputation, but
> only let CPUFREQ_NEED_UPDATE_LIMITS force a same-frequency callback when
> resolved policy->{min,max} changes remain pending. Expose that test through
> a cpufreq-core helper.
> 
> Consume pending state before both slow and fast callbacks, including
> frequency changes, instead of clearing it only in the target == cur case.
> Use release/acquire ordering for the limits and restore pending state on
> failure, preserving concurrent updates and retries. Favor the maximum
> if lockless limit reads observe an inverted pair.
> 
> This applies to cppc-cpufreq and amd-pstate's frequency-based paths; the
> ->adjust_perf() path is unchanged.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/cpufreq/cpufreq.c        | 82 ++++++++++++++++++++++++++------
>   include/linux/cpufreq.h          |  1 +
>   kernel/sched/cpufreq_schedutil.c | 19 ++------
>   3 files changed, 72 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44bda2f32fcf..9e932c2a986d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2058,6 +2058,21 @@ bool cpufreq_driver_test_flags(u16 flags)
>   	return !!(cpufreq_driver->flags & flags);
>   }
>   
> +/**
> + * cpufreq_driver_needs_limits_update - Check for a pending driver limit update.
> + * @policy: CPU frequency policy to check.
> + *
> + * Return: Whether changed resolved limits require a driver callback.
> + */
> +bool cpufreq_driver_needs_limits_update(struct cpufreq_policy *policy)
> +{
> +	if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +		return false;
> +
> +	/* Pairs with cpufreq_set_update_limits(). */
> +	return smp_load_acquire(&policy->update_limits);
> +}
> +
>   /**
>    * cpufreq_get_current_driver - Return the current driver's name.
>    *
> @@ -2183,6 +2198,30 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>    *                              GOVERNORS                            *
>    *********************************************************************/
>   
> +static bool cpufreq_test_and_clear_update_limits(struct cpufreq_policy *policy)
> +{
> +	if (!cpufreq_driver_needs_limits_update(policy))
> +		return false;
> +
> +	return xchg(&policy->update_limits, false);

Since policy->update_limits is a bool, this would require a 1-byte
xchg(), which, as far as I know, is not supported on all architectures.
such as on sparc:

static __always_inline unsigned long
__arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
{
	switch (size) {
	case 2:
		return xchg16(ptr, x);
	case 4:
		return xchg32(ptr, x);
	case 8:
		return xchg64(ptr, x);
	}
	__xchg_called_with_bad_pointer();
	return x;
}


> +}
> +
> +static void cpufreq_set_update_limits(struct cpufreq_policy *policy)
> +{
> +	/* Publish the new limits before making their update pending. */
> +	smp_store_release(&policy->update_limits, true);
> +}
> +
> +static void cpufreq_read_policy_limits(struct cpufreq_policy *policy,
> +				       unsigned int *min, unsigned int *max)
> +{
> +	/* Lockless reads can mix limit updates; favor max if inverted. */
> +	*min = READ_ONCE(policy->min);
> +	*max = READ_ONCE(policy->max);
> +	if (unlikely(*min > *max))
> +		*min = *max;
> +}
> +
>   /**
>    * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
>    * @policy: cpufreq policy to switch the frequency for.
> @@ -2209,14 +2248,20 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>   unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   					unsigned int target_freq)
>   {
> -	unsigned int freq;
> +	bool update_limits;
> +	unsigned int min, max, freq;
>   	int cpu;
>   
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +	update_limits = cpufreq_test_and_clear_update_limits(policy);
> +	cpufreq_read_policy_limits(policy, &min, &max);
> +	target_freq = clamp_val(target_freq, min, max);
>   	freq = cpufreq_driver->fast_switch(policy, target_freq);
>   
> -	if (!freq)
> +	if (!freq) {
> +		if (update_limits)
> +			cpufreq_set_update_limits(policy);
>   		return 0;
> +	}
>   
>   	policy->cur = freq;
>   	arch_set_freq_scale(policy->related_cpus, freq,
> @@ -2367,12 +2412,16 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   			    unsigned int relation)
>   {
>   	unsigned int old_target_freq = target_freq;
> +	unsigned int min, max;
> +	bool update_limits;
> +	int ret;
>   
>   	if (cpufreq_disabled())
>   		return -ENODEV;
>   
> -	target_freq = __resolve_freq(policy, target_freq, policy->min,
> -				     policy->max, relation);
> +	update_limits = cpufreq_test_and_clear_update_limits(policy);
> +	cpufreq_read_policy_limits(policy, &min, &max);
> +	target_freq = __resolve_freq(policy, target_freq, min, max, relation);
>   
>   	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
>   		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
> @@ -2384,11 +2433,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   	 * calls.
>   	 */
>   	if (target_freq == policy->cur) {
> -		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
> -		    !policy->update_limits)
> +		if (!update_limits)
>   			return 0;
> -
> -		policy->update_limits = false;
>   	}
>   
>   	if (cpufreq_driver->target) {
> @@ -2399,13 +2445,19 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   		if (!policy->efficiencies_available)
>   			relation &= ~CPUFREQ_RELATION_E;
>   
> -		return cpufreq_driver->target(policy, target_freq, relation);
> +		ret = cpufreq_driver->target(policy, target_freq, relation);
> +	} else if (cpufreq_driver->target_index) {
> +		ret = __target_index(policy, policy->cached_resolved_idx);
> +	} else {
> +		if (update_limits)
> +			cpufreq_set_update_limits(policy);
> +		return -EINVAL;
>   	}
>   
> -	if (!cpufreq_driver->target_index)
> -		return -EINVAL;
> +	if (ret && update_limits)
> +		cpufreq_set_update_limits(policy);
>   
> -	return __target_index(policy, policy->cached_resolved_idx);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>   
> @@ -2681,7 +2733,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   			      CPUFREQ_RELATION_H);
>   	if (freq != policy->max) {
>   		WRITE_ONCE(policy->max, freq);
> -		policy->update_limits = true;
> +		cpufreq_set_update_limits(policy);
>   	}
>   
>   	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
> @@ -2689,7 +2741,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   	freq = min(freq, policy->max);
>   	if (freq != policy->min) {
>   		WRITE_ONCE(policy->min, freq);
> -		policy->update_limits = true;
> +		cpufreq_set_update_limits(policy);
>   	}
>   
>   	trace_cpu_frequency_limits(policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index a0a7619d11fd..acd60c2b30f1 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -499,6 +499,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>   void cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>   
>   bool cpufreq_driver_test_flags(u16 flags);
> +bool cpufreq_driver_needs_limits_update(struct cpufreq_policy *policy);
>   const char *cpufreq_get_current_driver(void);
>   void *cpufreq_get_driver_data(void);
>   
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 49ccd6f1c185..43e448ee3c4c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -123,22 +123,11 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>   static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>   				   unsigned int next_freq)
>   {
> -	if (sg_policy->need_freq_update) {
> -		sg_policy->need_freq_update = false;
> -		/*
> -		 * The policy limits have changed, but if the return value of
> -		 * cpufreq_driver_resolve_freq() after applying the new limits
> -		 * is still equal to the previously selected frequency, the
> -		 * driver callback need not be invoked unless the driver
> -		 * specifically wants that to happen on every update of the
> -		 * policy limits.
> -		 */
> -		if (sg_policy->next_freq == next_freq &&
> -		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> -			return false;
> -	} else if (sg_policy->next_freq == next_freq) {
> +	sg_policy->need_freq_update = false;
> +
> +	if (sg_policy->next_freq == next_freq &&
> +	    !cpufreq_driver_needs_limits_update(sg_policy->policy))
>   		return false;
> -	}
>   
>   	sg_policy->next_freq = next_freq;
>   	sg_policy->last_freq_update_time = time;


-- 
Thx and BRs,
Zhongqiu Han
