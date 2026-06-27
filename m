Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC37083C;
	Sat, 27 Jun 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782557434; cv=none; b=X0dYvU+9AM7FlgbjgjCtGDyA05pNQBI3hN2owAEM9aoLqwNzRlfuVHaWojCjeFroAydDh2Sk/1P3StW3ocDvaa1Z0A+64gad6ZCSd3442EIffcUZQy4JStnV1QAz3bRqV8KhT5B8fYxiuVN5sxD/7eSdp1JttN5HTaFW2bWfd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782557434; c=relaxed/simple;
	bh=teLWA7fD3BY3HhSk12vE+C4UiwHnCe4ozvp/dk03j5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uPgNWF9F/uR9RBBDKU5urUEy3kv/EEmFK7sUjFEkg/tT5ysGDe5WmgUv11IZsIOt8JoDnu0g5IBnTtzKbqg9lAigFPvuJEq9q666ee98UZtwoVYowNVLSa8Y9IXKfCl3B1cUKLZtC6XRPS4lTbceW6XeOXtd/sO6l3iKU79Q1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bcXLIK+n; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bcXLIK+n"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OOmOdm/5pMdvH57Crg3mglFWQt1WB+2zbQrn3R/PVdc=;
	b=bcXLIK+nqOCUumVPmwwe9I+dxGQE0a7Sd+sVJY69IZ4+erymjBiN7OVH6ly7gjvnMntjVflMD
	UsJgW33O844DIC1PxbZ6NFlodZRbkJydtRYnCzVhcpUexfmuB4qxDf0Iv0MEKWULQpq3kZ8yXeO
	ur1lurGOtSCY90m80uVEYG0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gnTc06JRszRhVt;
	Sat, 27 Jun 2026 18:41:20 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id CD9A540538;
	Sat, 27 Jun 2026 18:50:26 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 27 Jun
 2026 18:50:25 +0800
Message-ID: <317d33d5-8279-4aa8-84b7-6ae1976636ac@huawei.com>
Date: Sat, 27 Jun 2026 18:50:24 +0800
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
 <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 5/20/2026 10:55 AM, Pengjie Zhang wrote:
>
> On 5/19/2026 6:47 PM, Will Deacon wrote:
>> On Thu, Apr 30, 2026 at 06:00:44PM +0800, zhangpengjie (A) wrote:
>>> Hi all,
>>>
>>> Gentle ping on this thread. It has been a while since I posted it.
>>>
>>> Could someone please take a look when you have time? If there is 
>>> anything
>>> I should revise or any additional information needed, I'd be happy to
>>> update it.
>> It's hard to find active folks who have contributed meaningfully to the
>> cppc_acpi driver... I've added Ionella and Jeremy, in case they can take
>> a look.
>>
>> Will
> Thanks Will, and thanks for adding Ionela and Jeremy.
>
> While waiting for further comments, I would like to add some
> test data to make the effect of this series clearer.
>
> On the test platform, the maximum frequency reported by the platform
> is 2300000. I sampled cpuinfo_cur_freq before and after applying this 
> series.
>
> Before applying the series, the samples showed visible transient 
> outliers.
>  The minimum value was 2154583 and the maximum value was 2491071.
> There were 8 samples above 2400000 and 8 samples below 2200000.
> The largest value exceeded the platform maximum by about 8.3%.
>
> After applying the series, the samples became much more stable.
> The minimum value was 2290243 and the maximum value was 2306310.
> There were no samples above 2400000 and no samples below 2200000.
> The largest value exceeded the platform maximum by only about 0.27%.
>
> A summary of the 96 samples is:
>
>                     before          after
> min              2154583         2290243
> max              2491071         2306310
> range             336488           16067
> average          2298436.4       2298479.4
> stddev             55184.1          2868.2
> samples > 2300000  26 / 96         16 / 96
> samples > 2400000   8 / 96          0 / 96
> samples < 2200000   8 / 96          0 / 96
>
> So this series does not try to clamp the value to the platform maximum.
>  Instead, it reduces the sampling skew between the delivered and 
> reference
> feedback counters. The remaining small deviation around 2300000 is
>  much smaller than the previous transient spikes.
>
> One concern that may come up is that an FFH read may cause an idle
> target CPU to be woken, depending on the platform/vendor implementation.
> However, that behavior is not introduced by this series. It is already 
> part
> of how FFH counter reads are implemented on such platforms. This series
> only changes the sampling form for the FFH feedback counters: when both
> delivered and reference counters are FFH counters, read them together
> instead of issuing two separate FFH reads.
>
> If the target CPU has to be involved for an FFH read, doing one paired
> read should be no worse than doing two separate reads, and it also
> narrows the sampling window between the two counters.
>
> If there is any concern about the generic hook or the arm64 
> implementation,
> I would be happy to revise it.
>
> The raw data is as follows:
> before:
> 2303809 2294827 2300000 2293643 2290740 2300000 2297228 2296082
> 2301707 2295354 2296601 2303163 2296766 2296543 2295412 2298394
> 2297387 2300000 2308274 2301882 2297752 2418568 2491071 2300000
> 2183264 2296238 2434731 2296721 2439777 2302159 2301773 2298226
> 2300000 2305936 2301133 2297511 2300000 2300000 2294408 2298494
> 2295011 2302721 2295955 2301505 2298064 2297419 2298933 2189595
> 2298058 2296046 2300000 2301449 2414908 2296559 2305251 2166666
> 2296626 2173303 2300000 2298806 2411389 2301822 2297291 2300000
> 2423831 2297902 2300000 2435730 2302433 2295353 2298898 2296043
> 2321868 2294907 2300000 2157841 2296052 2206530 2300000 2297811
> 2297920 2294382 2297767 2157230 2302564 2298504 2296822 2300000
> 2296868 2294866 2154583 2290888 2302542 2292549 2300000 2184259
>
> after:
> 2303738 2296153 2298087 2295607 2301373 2298076 2300000 2295081
> 2297788 2300000 2300000 2295238 2301449 2300000 2298488 2297911
> 2301477 2298507 2294976 2296852 2293689 2294077 2293887 2292619
> 2300000 2300000 2298072 2300000 2291943 2300000 2295370 2300000
> 2301873 2304645 2300000 2296766 2300000 2300000 2290243 2297954
> 2297183 2306310 2300000 2296889 2300000 2303800 2301970 2296888
> 2300000 2301354 2300000 2298405 2298202 2296767 2298663 2302522
> 2297821 2302471 2300000 2303233 2298226 2298698 2300000 2297291
> 2296470 2300000 2298398 2300000 2295681 2300000 2300000 2296344
> 2300000 2296008 2302375 2297977 2298447 2296519 2295565 2294866
> 2297945 2300000 2294978 2303595 2300000 2300000 2294930 2301096
> 2296271 2296086 2294482 2300000 2294843 2300000 2296803 2295708

To follow up on the test data and address any potential questions about
why the patched frequency doesn't clamp exactly to 2300000, I would like
to share a breakdown of the instruction-level overhead that explains this
minor jitter.

Even when pairing the reads in this series, cpu_read_constcnt() and
cpu_read_corecnt() still have intrinsic function call and execution
overheads. A simplified execution trace looks like this:

cpu_read_constcnt:
bl
mrs constcnt    <-- T_const (Read timestamp)
str
ret

cpu_read_corecnt:
bl
mrs corecnt     <-- T_core  (Read timestamp)
str
ret

Let δ (delta) be the delay between the two reads in core cycles,
such that δ = T_core - T_const.

For two consecutive samples:
Sample 1: constcnt = A1, corecnt = B1 (with delay δ1)
Sample 2: constcnt = A2, corecnt = B2 (with delay δ2)

If we substitute these into the frequency calculation:
freq = (B2 - B1) / (A2 - A1) * cntfrq

We get:
freq = Real_Freq + [ (δ2 - δ1) / (A2 - A1) ] * cntfrq

The error term is entirely dictated by (δ2 - δ1). On modern superscalar,
out-of-order architectures like ARM64, even identical instruction sequences
  experience microarchitectural jitter. Because of this, δ1 may not
be equal to δ2.

On our test platform, the maximum observed difference for (δ2 - δ1) is
roughly 40 cycles. Over a typical 2us sampling window (plus the FFH
function call overhead), this translates to a maximum theoretical error of
< 10MHz, which is less than 1%.

>>> On 4/10/2026 5:41 PM, Pengjie Zhang wrote:
>>>> The legacy CPPC feedback-counter path reads the delivered and 
>>>> reference
>>>> performance counters separately.
>>>>
>>>> On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
>>>> served through a cross-CPU counter read helper. Reading the counters
>>>> separately therefore widens the sampling window between them and can
>>>> skew the delivered/reference ratio used by cpuinfo_cur_freq. Under 
>>>> heavy
>>>> load, the skew is observable as transient values that may exceed the
>>>> platform maximum, as discussed in [1] and [2].
>>>>
>>>> This series adds a small generic hook for architectures that can 
>>>> obtain
>>>> both FFH feedback counters in one operation, while preserving the
>>>> existing per-register read path as the fallback.
>>>>
>>>> Patch 1 adds the generic CPPC hook and uses it from 
>>>> cppc_get_perf_ctrs().
>>>> Patch 2 implements the hook on arm64 by sampling both AMU counters 
>>>> in a
>>>> single operation on the target CPU.
>>>>
>>>> [1] 
>>>> https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>>>> [2] 
>>>> https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/ 
>>>>
>>>>
>>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>>>
>>>> Pengjie Zhang (2):
>>>>     ACPI: CPPC: add paired FFH feedback-counter read hook
>>>>     arm64: topology: read CPPC FFH feedback counters in one operation
>>>>
>>>>    arch/arm64/kernel/topology.c | 75 
>>>> ++++++++++++++++++++++++++++++++----
>>>>    drivers/acpi/cppc_acpi.c     | 58 +++++++++++++++++++++++++---
>>>>    include/acpi/cppc_acpi.h     |  7 ++++
>>>>    3 files changed, 127 insertions(+), 13 deletions(-)
>>>>
