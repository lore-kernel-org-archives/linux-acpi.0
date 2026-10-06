Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518172DB7BF;
	Tue,  6 Oct 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249259; cv=none; b=NvRtiSD115ftEcKaXsHqyoC1pAy65tRE/yLJHv46a5zkmV3pAUob5efYCXnLDMVCLqUIWlfNjvnDzgvKVgftjnYPXIx+a7nUmC+hDrtstKol64IxlE9ks9InYECD+TeDnfXaMleYVJ8TZTshc7pZO+/9Cx0tpJfwbM/ik1zlgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249259; c=relaxed/simple;
	bh=N38iP02EQ9Seq2mKHy3NfztxeXSfFDy91jiW803hLwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftAFvfhKABFsvl8CXZ0Myf67ua5FBdNldcYedHs9Tl1rcUROw4J3uv3/8i/XMg1J0jW0NutyHJFeyjmeFo4PMj6d3vST7rGyKGYdd3Udta3uFOGCe4agSiF+lxVPKk8t06l81NqWk9nLlkmRQeUNLjoJgsL8q4z0h+Bj0Uug/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QOkEAkNg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QOkEAkNg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BCE01477;
	Mon,  5 Oct 2026 18:14:11 -0700 (PDT)
Received: from [172.29.20.205] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20813F763;
	Mon,  5 Oct 2026 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791249254; bh=N38iP02EQ9Seq2mKHy3NfztxeXSfFDy91jiW803hLwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QOkEAkNgbnkq+lxZoSGjWF3ulVkmceVteebyuoWccWXCfFbt2wG3fVIcUoehhDHn1
	 +PGOFZ9jJ3A7yNe9r+IU+UD4BAjkZk/VVLKyWusWK7oeD/mZAiLJ1WOG9Vpt5NDn/0
	 HxmGBn32GSR8hPp/TeJ5DOQ455aZj20PYapg1etg=
Message-ID: <fcfc5d26-b3ec-47dc-9d17-0e4c1d9a36ae@arm.com>
Date: Mon, 5 Oct 2026 20:14:11 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Resolve frequencies to performance
 levels
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org
Cc: zhenglifeng1@huawei.com, zhongqiu.han@oss.qualcomm.com,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,
 Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
 Shubhang Kaushik <sh@gentwo.org>, Pierre Gondois <pierre.gondois@arm.com>,
 Beata Michalska <beata.michalska@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, jonathanh@nvidia.com,
 zhanjie9@hisilicon.com, Vincent Guittot <vincent.guittot@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20260929102957.2591657-1-christian.loehle@arm.com>
 <20260929102957.2591657-3-christian.loehle@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260929102957.2591657-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


At a high level this helps, but it also means cppc_cpufreq is depending 
more heavily on lowest_freq/nominal_freq for control decisions. ACPI 
documents those fields as reporting aids rather than control inputs. 
CPPC perf is the abstract control space and may encode platform behavior 
beyond frequency. Longer term it seems that we should be moving away 
from synthesizing frequences like this.

code comment inline.

On 9/29/26 5:29 AM, Christian Loehle wrote:
> Different kHz requests can select the same CPPC performance level.
> Implement ->resolve_freq() so governors such as schedutil can skip
> redundant writes.
> 
> Precompute the affine conversion and invert its integer rounding directly.
> Share bounded conversions with ->target() and ->fast_switch(), choosing the
> first performance level when several share a kHz value. Recompute limits
> from each policy snapshot to avoid caching sysfs-shared mutable controls.
> 
> Cap intervals at or below nominal kHz at Nominal Performance, excluding
> boosted levels that alias it. Unchanged frequency limits then imply
> unchanged performance limits across boost toggles.
> 
> After clamping to CPU limits, snap the limits to supported frequencies.
> If none lies in the interval, collapse both limits to the highest supported
> frequency not above its maximum, as frequency-table verification does.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 257 ++++++++++++++++++++++++++++++---
>   1 file changed, 239 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 4ea444ff889e..fa85efb9f701 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -18,8 +18,10 @@
>   #include <linux/cpufreq.h>
>   #include <linux/irq_work.h>
>   #include <linux/kthread.h>
> +#include <linux/math64.h>
>   #include <linux/mutex.h>
>   #include <linux/time.h>
> +#include <linux/units.h>
>   #include <linux/vmalloc.h>
>   #include <uapi/linux/sched/types.h>
>   
> @@ -29,6 +31,24 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +struct cppc_perf_freq_map {
> +	s64 offset;
> +	u64 multiplier;
> +	u32 divisor;
> +};
> +
> +struct cppc_cpufreq_data {
> +	struct cppc_cpudata cpu_data;
> +	struct cppc_perf_freq_map map;
> +	unsigned int nominal_khz;
> +};
> +
> +static struct cppc_cpufreq_data *
> +cppc_cpufreq_data(struct cppc_cpudata *cpu_data)
> +{
> +	return container_of(cpu_data, struct cppc_cpufreq_data, cpu_data);
> +}
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -302,11 +322,159 @@ static inline void cppc_freq_invariance_exit(void)
>   }
>   #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
>   
> +/* Precompute the affine mapping used by cppc_perf_to_khz(). */
> +static void cppc_cpufreq_init_perf_map(struct cppc_perf_caps *caps,
> +				       struct cppc_perf_freq_map *map)
> +{
> +	if (caps->lowest_freq && caps->nominal_freq) {
> +		if (caps->lowest_freq == caps->nominal_freq) {
> +			map->multiplier = (u64)caps->nominal_freq * KHZ_PER_MHZ;
> +			map->divisor = caps->nominal_perf;
> +			map->offset = 0;
> +		} else {
> +			map->multiplier = (u64)(caps->nominal_freq -
> +					   caps->lowest_freq) * KHZ_PER_MHZ;
> +			map->divisor = caps->nominal_perf - caps->lowest_perf;
> +			map->offset = (s64)caps->nominal_freq * KHZ_PER_MHZ -
> +				div64_u64(caps->nominal_perf * map->multiplier,
> +					  map->divisor);
> +		}
> +	} else {
> +		map->multiplier = cppc_get_dmi_max_khz();
> +		map->divisor = caps->highest_perf;
> +		map->offset = 0;
> +	}
> +}

This appears be a rework of the scaling computation code in 
cppc_khz_to_perf() from cppc_acpi.c. And it appears that all the callers 
of that function are in this module, so is there a reason that the 
implementation of cppc_khz_to_perf() couldn't be moved here and make use 
of cppc_cpufreq_init_perf_map() to generate a map and then compute perf 
as its inverse (freq - map->offset) * map.div/map.mul?

That can preserve the rouding/etc if i'm understanding this.



> +
> +static unsigned int
> +cppc_cpufreq_perf_to_khz(const struct cppc_perf_freq_map *map, u32 perf)
> +{
> +	s64 freq = map->offset + div64_u64(perf * map->multiplier,
> +					    map->divisor);
> +
> +	return freq > 0 ? freq : 0;
> +}
> +
> +/*
> + * Invert integer-kHz rounding: L finds the first level at or above the
> + * target frequency, H the last at or below it, within the supplied bounds.
> + */
> +static u32 cppc_cpufreq_perf_for_freq(const struct cppc_perf_freq_map *map,
> +				      unsigned int target_freq,
> +				      u32 min_perf, u32 max_perf,
> +				      unsigned int relation)
> +{
> +	s64 scaled_freq = (s64)target_freq - map->offset;
> +	u64 perf;
> +
> +	switch (relation) {
> +	case CPUFREQ_RELATION_L:
> +		if (!target_freq || scaled_freq <= 0)
> +			perf = 0;
> +		else
> +			perf = mul_u64_u64_div_u64_roundup(scaled_freq,
> +							   map->divisor,
> +							   map->multiplier);
> +		break;
> +
> +	case CPUFREQ_RELATION_H:
> +		if (scaled_freq < 0) {
> +			perf = 0;
> +		} else {
> +			perf = mul_u64_u64_div_u64_roundup(scaled_freq + 1,
> +							   map->divisor,
> +							   map->multiplier);
> +			perf--;
> +		}
> +		break;
> +
> +	default:
> +		WARN_ON_ONCE(1);
> +		return min_perf;
> +	}
> +
> +	return clamp_t(u64, perf, min_perf, max_perf);
> +}
> +
> +static void cppc_cpufreq_perf_limits(struct cppc_perf_caps *caps,
> +				     struct cppc_cpufreq_data *data,
> +				     unsigned int min_freq,
> +				     unsigned int max_freq,
> +				     u32 *min_perf, u32 *max_perf)
> +{
> +	u32 policy_max_perf;
> +
> +	/* Do not include boosted levels that alias the nominal frequency. */
> +	policy_max_perf = max_freq <= data->nominal_khz ?
> +			  caps->nominal_perf : caps->highest_perf;
> +	*min_perf = cppc_cpufreq_perf_for_freq(&data->map, min_freq,
> +					       caps->lowest_perf,
> +					       policy_max_perf,
> +					       CPUFREQ_RELATION_L);
> +	*max_perf = cppc_cpufreq_perf_for_freq(&data->map, max_freq,
> +					       caps->lowest_perf,
> +					       policy_max_perf,
> +					       CPUFREQ_RELATION_H);
What is the actual consequence of not just picking min_perf = 
caps->lowest_perf and max_perf as nominal/highest? Is it possible the HW 
is never instructed into either its highest or lowest state since its 
rounding away from the firmware provided min/max?

> +}
> +
> +static unsigned int
> +cppc_cpufreq_resolve_freq(struct cpufreq_policy *policy,
> +			  unsigned int target_freq,
> +			  unsigned int min_freq,
> +			  unsigned int max_freq,
> +			  unsigned int relation)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	struct cppc_cpufreq_data *data = cppc_cpufreq_data(cpu_data);
> +	const struct cppc_perf_freq_map *map = &data->map;
> +	u32 min_perf, max_perf, perf;
> +
> +	cppc_cpufreq_perf_limits(caps, data, min_freq, max_freq,
> +				 &min_perf, &max_perf);
> +	if (WARN_ON_ONCE(min_perf > max_perf))
> +		return cppc_cpufreq_perf_to_khz(map, max_perf);
> +
> +	switch (relation) {
> +	case CPUFREQ_RELATION_L:
> +	case CPUFREQ_RELATION_H:
> +		perf = cppc_cpufreq_perf_for_freq(map, target_freq,
> +						  min_perf, max_perf, relation);
> +		break;
> +	case CPUFREQ_RELATION_C: {
> +		u32 lower = cppc_cpufreq_perf_for_freq(map, target_freq,
> +							min_perf, max_perf,
> +							CPUFREQ_RELATION_H);
> +		u32 upper = cppc_cpufreq_perf_for_freq(map, target_freq,
> +							min_perf, max_perf,
> +							CPUFREQ_RELATION_L);
> +		unsigned int lower_freq = cppc_cpufreq_perf_to_khz(map, lower);
> +		unsigned int upper_freq = cppc_cpufreq_perf_to_khz(map, upper);
> +
> +		if (lower_freq >= target_freq)
> +			perf = lower;
> +		else if (upper_freq <= target_freq)
> +			perf = upper;
> +		else if (target_freq - lower_freq < upper_freq - target_freq)
> +			perf = lower;
> +		else
> +			perf = upper;
> +		break;
> +	}
> +	default:
> +		WARN_ON_ONCE(1);
> +		return target_freq;
> +	}
> +
> +	return cppc_cpufreq_perf_to_khz(map, perf);
> +}
> +
>   static void cppc_cpufreq_get_perf_limits(struct cppc_cpudata *cpu_data,
>   					 struct cpufreq_policy *policy,
>   					 u32 *min_perf, u32 *max_perf)
>   {
>   	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	struct cppc_cpufreq_data *data = cppc_cpufreq_data(cpu_data);
>   	unsigned int min_freq, max_freq;
>   	u32 min, max;
>   
> @@ -315,11 +483,11 @@ static void cppc_cpufreq_get_perf_limits(struct cppc_cpudata *cpu_data,
>   	if (unlikely(min_freq > max_freq))
>   		min_freq = max_freq;
>   
> -	min = cppc_khz_to_perf(caps, min_freq);
> -	max = cppc_khz_to_perf(caps, max_freq);
> +	cppc_cpufreq_perf_limits(caps, data, min_freq, max_freq,
> +				 &min, &max);
>   
> -	*min_perf = clamp_t(u32, min, caps->lowest_perf, caps->highest_perf);
> -	*max_perf = clamp_t(u32, max, caps->lowest_perf, caps->highest_perf);
> +	*min_perf = min(min, max);
> +	*max_perf = max;
>   }
>   
>   static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
> @@ -330,6 +498,26 @@ static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
>   				     &cpu_data->perf_ctrls.max_perf);
>   }
>   
> +static unsigned int
> +cppc_cpufreq_update_perf_ctrls(struct cppc_cpudata *cpu_data,
> +			       struct cpufreq_policy *policy,
> +			       unsigned int target_freq)
> +{
> +	struct cppc_cpufreq_data *data = cppc_cpufreq_data(cpu_data);
> +	u32 min_perf, max_perf, desired_perf;
> +
> +	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
> +	/* Use the first level when several share the same integer-kHz value. */
> +	desired_perf = cppc_cpufreq_perf_for_freq(&data->map, target_freq,
> +						  min_perf, max_perf,
> +						  CPUFREQ_RELATION_L);
> +	cpu_data->perf_ctrls.min_perf = min_perf;
> +	cpu_data->perf_ctrls.max_perf = max_perf;
> +	cpu_data->perf_ctrls.desired_perf = desired_perf;
> +
> +	return cppc_cpufreq_perf_to_khz(&data->map, desired_perf);
> +}
> +
>   static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>   				   unsigned int target_freq,
>   				   unsigned int relation)
> @@ -339,12 +527,9 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>   	struct cpufreq_freqs freqs;
>   	int ret = 0;
>   
> -	cpu_data->perf_ctrls.desired_perf =
> -			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
> -	cppc_cpufreq_update_perf_limits(cpu_data, policy);
> -
>   	freqs.old = policy->cur;
> -	freqs.new = target_freq;
> +	freqs.new = cppc_cpufreq_update_perf_ctrls(cpu_data, policy,
> +						   target_freq);
>   
>   	cpufreq_freq_transition_begin(policy, &freqs);
>   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> @@ -361,13 +546,12 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   					      unsigned int target_freq)
>   {
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int resolved_freq;
>   	unsigned int cpu = policy->cpu;
> -	u32 desired_perf;
>   	int ret;
>   
> -	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
> -	cpu_data->perf_ctrls.desired_perf = desired_perf;
> -	cppc_cpufreq_update_perf_limits(cpu_data, policy);
> +	resolved_freq = cppc_cpufreq_update_perf_ctrls(cpu_data, policy,
> +						       target_freq);
>   
>   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>   	if (ret) {
> @@ -376,12 +560,39 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   		return 0;
>   	}
>   
> -	return target_freq;
> +	return resolved_freq;
>   }
>   
>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>   {
> +	struct cpufreq_policy *cur_policy;
> +	struct cppc_cpudata *cpu_data;
> +	struct cppc_cpufreq_data *data;
> +	struct cppc_perf_caps *caps;
> +	unsigned int min_freq, max_freq;
> +	u32 min_perf, max_perf;
> +
>   	cpufreq_verify_within_cpu_limits(policy);
> +
> +	cur_policy = cpufreq_cpu_get_raw(policy->cpu);
> +	if (WARN_ON_ONCE(!cur_policy || !cur_policy->driver_data))
> +		return -ENODEV;
> +
> +	cpu_data = cur_policy->driver_data;
> +	data = cppc_cpufreq_data(cpu_data);
> +	caps = &cpu_data->perf_caps;
> +	cppc_cpufreq_perf_limits(caps, data, policy->min, policy->max,
> +				 &min_perf, &max_perf);
> +	min_freq = cppc_cpufreq_perf_to_khz(&data->map, min_perf);
> +	max_freq = cppc_cpufreq_perf_to_khz(&data->map, max_perf);
> +
> +	/* Favor the maximum if no supported frequency lies in the interval. */
> +	if (min_perf > max_perf || min_freq > policy->max ||
> +	    max_freq < policy->min)
> +		min_freq = max_freq;
> +
> +	policy->min = min_freq;
> +	policy->max = max_freq;
>   	return 0;
>   }
>   
> @@ -618,12 +829,14 @@ static void populate_efficiency_class(void)
>   
>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   {
> +	struct cppc_cpufreq_data *data;
>   	struct cppc_cpudata *cpu_data;
>   	int ret;
>   
> -	cpu_data = kzalloc_obj(struct cppc_cpudata);
> -	if (!cpu_data)
> +	data = kzalloc_obj(struct cppc_cpufreq_data);
> +	if (!data)
>   		goto out;
> +	cpu_data = &data->cpu_data;
>   
>   	if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
>   		goto free_cpu;
> @@ -640,6 +853,10 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   		goto free_mask;
>   	}
>   
> +	cppc_cpufreq_init_perf_map(&cpu_data->perf_caps, &data->map);
> +	data->nominal_khz = cppc_cpufreq_perf_to_khz(&data->map,
> +						     cpu_data->perf_caps.nominal_perf);
> +
>   	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>   	if (ret) {
>   		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
> @@ -651,7 +868,7 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   free_mask:
>   	free_cpumask_var(cpu_data->shared_cpu_map);
>   free_cpu:
> -	kfree(cpu_data);
> +	kfree(data);
>   out:
>   	return NULL;
>   }
> @@ -659,9 +876,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>   {
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_cpufreq_data *data;
> +
> +	data = container_of(cpu_data, struct cppc_cpufreq_data, cpu_data);
>   
>   	free_cpumask_var(cpu_data->shared_cpu_map);
> -	kfree(cpu_data);
> +	kfree(data);
>   	policy->driver_data = NULL;
>   }
>   
> @@ -1056,6 +1276,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify = cppc_verify_policy,
>   	.target = cppc_cpufreq_set_target,
> +	.resolve_freq = cppc_cpufreq_resolve_freq,
>   	.get = cppc_cpufreq_get_rate,
>   	.fast_switch = cppc_cpufreq_fast_switch,
>   	.init = cppc_cpufreq_cpu_init,

