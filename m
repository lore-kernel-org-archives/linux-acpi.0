Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDF3112DA;
	Wed, 20 May 2026 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245762; cv=none; b=J8hR+hGvmUh+/hRXRKeZeFAIfoQ/tjHcAxPQ3yycDNOKw7GngVbk5VVFejM6jYgusnBY/LVVqVUTngw8OSktVHaASYbYjB4aiRDbZoYcoSGIU45yiRDGaB52RuzxVYe1Cyluq8P+GXUIzGhVBCeI6RKJJiYV4c/X8gIlyIGInL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245762; c=relaxed/simple;
	bh=b37zFhf8nl5LZBmxf1w7SRwnU0bGDDT6xXU5VOnptOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fq6K6/vZVQZPmbPitUBEvdjCaZwvMj0hmKIc3Xx6tSGqjUsngdpTSXBcBAW4eI3CYSSlfAXvNuslUOmOUjq4x8JwgD1aPhJ05546SI6inMHcDdFcuMkjdRynwkmPC4MKkXJB+Q2ed3z34e4xju2Jf76nrXcEvzoRJqDOXcdaObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J5NIh9A8; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J5NIh9A8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BWviZjjto1yMbr31/bRcxfE0EG6NBe9FcUa0M9S8NIQ=;
	b=J5NIh9A8MN5cskdCn1evrZmIx8Lf9Tt5gNdTZZoRlA2govlmA45MNU8QNpEjtIcQSd9s8SVTl
	pDOSy/blsBC06wlkc0rMlaVTEosk3cQJXX7NAEuZlknRuD0CvMnV2HLelemEMyOulgyLuf1mcL+
	nqb7yB5xiv+hXh/dgVkERzA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gKwvf1XgLzmV6b;
	Wed, 20 May 2026 10:48:14 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 966E8402AB;
	Wed, 20 May 2026 10:55:56 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 May
 2026 10:55:55 +0800
Message-ID: <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>
Date: Wed, 20 May 2026 10:55:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] CPPC: reduce FFH feedback-counter sampling skew on
 arm64
To: Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <sumitg@nvidia.com>,
	<cuiyunhui@bytedance.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <wangzhi12@huawei.com>, <ionela.voinescu@arm.com>,
	<jeremy.linton@arm.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <aa1284c1-ea26-48ca-a7d7-022027c8228a@huawei.com>
 <agw_1IYaY4zeobZE@willie-the-truck>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <agw_1IYaY4zeobZE@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 5/19/2026 6:47 PM, Will Deacon wrote:
> On Thu, Apr 30, 2026 at 06:00:44PM +0800, zhangpengjie (A) wrote:
>> Hi all,
>>
>> Gentle ping on this thread. It has been a while since I posted it.
>>
>> Could someone please take a look when you have time? If there is anything
>> I should revise or any additional information needed, I'd be happy to
>> update it.
> It's hard to find active folks who have contributed meaningfully to the
> cppc_acpi driver... I've added Ionella and Jeremy, in case they can take
> a look.
>
> Will
Thanks Will, and thanks for adding Ionela and Jeremy.

While waiting for further comments, I would like to add some
test data to make the effect of this series clearer.

On the test platform, the maximum frequency reported by the platform
is 2300000. I sampled cpuinfo_cur_freq before and after applying this 
series.

Before applying the series, the samples showed visible transient outliers.
  The minimum value was 2154583 and the maximum value was 2491071.
There were 8 samples above 2400000 and 8 samples below 2200000.
The largest value exceeded the platform maximum by about 8.3%.

After applying the series, the samples became much more stable.
The minimum value was 2290243 and the maximum value was 2306310.
There were no samples above 2400000 and no samples below 2200000.
The largest value exceeded the platform maximum by only about 0.27%.

A summary of the 96 samples is:

                     before          after
min              2154583         2290243
max              2491071         2306310
range             336488           16067
average          2298436.4       2298479.4
stddev             55184.1          2868.2
samples > 2300000  26 / 96         16 / 96
samples > 2400000   8 / 96          0 / 96
samples < 2200000   8 / 96          0 / 96

So this series does not try to clamp the value to the platform maximum.
  Instead, it reduces the sampling skew between the delivered and reference
feedback counters. The remaining small deviation around 2300000 is
  much smaller than the previous transient spikes.

One concern that may come up is that an FFH read may cause an idle
target CPU to be woken, depending on the platform/vendor implementation.
However, that behavior is not introduced by this series. It is already part
of how FFH counter reads are implemented on such platforms. This series
only changes the sampling form for the FFH feedback counters: when both
delivered and reference counters are FFH counters, read them together
instead of issuing two separate FFH reads.

If the target CPU has to be involved for an FFH read, doing one paired
read should be no worse than doing two separate reads, and it also
narrows the sampling window between the two counters.

If there is any concern about the generic hook or the arm64 implementation,
I would be happy to revise it.

The raw data is as follows:
before:
2303809 2294827 2300000 2293643 2290740 2300000 2297228 2296082
2301707 2295354 2296601 2303163 2296766 2296543 2295412 2298394
2297387 2300000 2308274 2301882 2297752 2418568 2491071 2300000
2183264 2296238 2434731 2296721 2439777 2302159 2301773 2298226
2300000 2305936 2301133 2297511 2300000 2300000 2294408 2298494
2295011 2302721 2295955 2301505 2298064 2297419 2298933 2189595
2298058 2296046 2300000 2301449 2414908 2296559 2305251 2166666
2296626 2173303 2300000 2298806 2411389 2301822 2297291 2300000
2423831 2297902 2300000 2435730 2302433 2295353 2298898 2296043
2321868 2294907 2300000 2157841 2296052 2206530 2300000 2297811
2297920 2294382 2297767 2157230 2302564 2298504 2296822 2300000
2296868 2294866 2154583 2290888 2302542 2292549 2300000 2184259

after:
2303738 2296153 2298087 2295607 2301373 2298076 2300000 2295081
2297788 2300000 2300000 2295238 2301449 2300000 2298488 2297911
2301477 2298507 2294976 2296852 2293689 2294077 2293887 2292619
2300000 2300000 2298072 2300000 2291943 2300000 2295370 2300000
2301873 2304645 2300000 2296766 2300000 2300000 2290243 2297954
2297183 2306310 2300000 2296889 2300000 2303800 2301970 2296888
2300000 2301354 2300000 2298405 2298202 2296767 2298663 2302522
2297821 2302471 2300000 2303233 2298226 2298698 2300000 2297291
2296470 2300000 2298398 2300000 2295681 2300000 2300000 2296344
2300000 2296008 2302375 2297977 2298447 2296519 2295565 2294866
2297945 2300000 2294978 2303595 2300000 2300000 2294930 2301096
2296271 2296086 2294482 2300000 2294843 2300000 2296803 2295708
>> On 4/10/2026 5:41 PM, Pengjie Zhang wrote:
>>> The legacy CPPC feedback-counter path reads the delivered and reference
>>> performance counters separately.
>>>
>>> On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
>>> served through a cross-CPU counter read helper. Reading the counters
>>> separately therefore widens the sampling window between them and can
>>> skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
>>> load, the skew is observable as transient values that may exceed the
>>> platform maximum, as discussed in [1] and [2].
>>>
>>> This series adds a small generic hook for architectures that can obtain
>>> both FFH feedback counters in one operation, while preserving the
>>> existing per-register read path as the fallback.
>>>
>>> Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
>>> Patch 2 implements the hook on arm64 by sampling both AMU counters in a
>>> single operation on the target CPU.
>>>
>>> [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>>> [2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
>>>
>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>>
>>> Pengjie Zhang (2):
>>>     ACPI: CPPC: add paired FFH feedback-counter read hook
>>>     arm64: topology: read CPPC FFH feedback counters in one operation
>>>
>>>    arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
>>>    drivers/acpi/cppc_acpi.c     | 58 +++++++++++++++++++++++++---
>>>    include/acpi/cppc_acpi.h     |  7 ++++
>>>    3 files changed, 127 insertions(+), 13 deletions(-)
>>>
