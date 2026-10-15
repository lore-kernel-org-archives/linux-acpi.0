Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A47231836;
	Thu, 15 Oct 2026 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036645; cv=none; b=OFzlCi280G4glWsdmDdVeRPsOvOITA1N3IML5pM4MyK1aqX/MTaOWyBMxcfgZvUQ+44auziEQxUwepsSu413b5y98+ulBPOhXvNiZTPOd+kFX+XKoXsJJJw1yKQhMEWYgmoMex4bX2kjBC3VUn48V7qbKVX1i0Ez6k7k/bYMlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036645; c=relaxed/simple;
	bh=laQEQmrevBbZLzCFQIVrAgnpTTHO73JD9uv0iZcWKOg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=cpGg0kLG45pDTgiWmT3c1AGLfUNHnZz36jBgeYA7I5tNiBuu01ijVQ+auvLTRa8XDK04QLLaHjAL8lIYb2iN4D/uv7LrNNm2JDkJlHKgpi2dJRwceOzxHLPcVmwrELH6VH17QJIEqy+3ithgMdcKp+XW+u1F6cSwbf7vmtIC7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j4v8l59c0zKm8R;
	Thu, 15 Oct 2026 11:44:55 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E97934057C;
	Thu, 15 Oct 2026 11:57:17 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 15 Oct
 2026 11:57:16 +0800
Message-ID: <526758a6-40f5-4810-8e17-6e94afc3fab2@hisilicon.com>
Date: Thu, 15 Oct 2026 11:57:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Zhan <zhanjie9@hisilicon.com>
Subject: Re: [PATCH 1/3] cpufreq: Add a driver frequency resolution callback
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>
CC: <zhenglifeng1@huawei.com>, <zhongqiu.han@oss.qualcomm.com>,
	<viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>, Perry
 Yuan <perry.yuan@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, Shubhang Kaushik
	<sh@gentwo.org>, Pierre Gondois <pierre.gondois@arm.com>, Beata Michalska
	<beata.michalska@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>, Sudeep Holla
	<sudeep.holla@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Jeremy Linton
	<jeremy.linton@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	<jonathanh@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
References: <20260929102957.2591657-1-christian.loehle@arm.com>
 <20260929102957.2591657-2-christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <20260929102957.2591657-2-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 9/29/2026 6:29 PM, Christian Loehle wrote:
> Without a frequency table, cpufreq treats the policy range as continuous
> even when the driver selects discrete performance levels. Governors can
> then issue different kHz requests for the same driver setting.
> 
> Add ->resolve_freq() for table-less ->target() drivers to canonicalize
> requests within the supplied limits using CPUFREQ_RELATION_{L,H,C}.
> Document the callback and verification contracts so callers can safely
> cache resolved requests.
Hi Christian,

IIUC, ->target() + ->resolve_freq() should do almost the same work as
->target_index() + freq_table. Why not switch to ->target_index() if that's
intended?

I had a few unsent comments on the second CPPC patch but perhaps we discuss
this first.

Jie
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst |  4 ++++
>  Documentation/cpu-freq/cpu-drivers.rst   | 19 +++++++++++++++++++
>  drivers/cpufreq/cpufreq.c                | 17 +++++++++++++++--
>  include/linux/cpufreq.h                  | 10 ++++++++++
>  4 files changed, 48 insertions(+), 2 deletions(-)
> 
[...]
>  
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..44bda2f32fcf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -480,8 +480,12 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>  
>  	target_freq = clamp_val(target_freq, min, max);
>  
> -	if (!policy->freq_table)
> +	if (!policy->freq_table) {
> +		if (cpufreq_driver->resolve_freq)
> +			return cpufreq_driver->resolve_freq(policy, target_freq, min, max,
> +							    relation & ~CPUFREQ_RELATION_E);
>  		return target_freq;
> +	}
>  
>  	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
>  	policy->cached_resolved_idx = idx;
> @@ -495,7 +499,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>   * @policy: associated policy to interrogate
>   * @target_freq: target frequency to resolve.
>   *
> - * The target to driver frequency mapping is cached in the policy.
> + * The frequency-table resolution path caches the mapping in the policy.
> + *
> + * Keep the policy active and exclude driver teardown; a policy reference
> + * alone does not protect driver-private data.
Do you mean the caller should ensure this?
This function doesn't seem to do this.
>   *
>   * Return: Lowest driver-supported frequency greater than or equal to the
>   * given target_freq, subject to policy (min/max) and driver limitations.
> @@ -1445,6 +1452,11 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  		 * If there is a problem with its frequency table, take it
>  		 * offline and drop it.
>  		 */
> +		if (policy->freq_table && cpufreq_driver->resolve_freq) {
> +			ret = -EINVAL;
> +			goto out_offline_policy;
> +		}
> +
>  		ret = cpufreq_table_validate_and_sort(policy);
>  		if (ret)
>  			goto out_offline_policy;
> @@ -2925,6 +2937,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  
>  	if (!driver_data || !driver_data->verify || !driver_data->init ||
>  	     (driver_data->target_index && driver_data->target) ||
> +	     (driver_data->resolve_freq && !driver_data->target) ||
>  	     (!!driver_data->setpolicy == (driver_data->target_index || driver_data->target)) ||
>  	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
>  	     (!driver_data->online != !driver_data->offline) ||
[...]
