From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
Date: Thu, 24 Jan 2019 18:25:19 +0000
Message-ID: <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-3-shameerali.kolothum.thodi@huawei.com>
 <20190122162351.GE8120@e119886-lin.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
 <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Murray <andrew.murray@arm.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "vkilari@codeaurora.org" <vkilari@codeaurora.org>, "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "pabba@codeaurora.org" <pabba@codeaurora.org>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, Linuxarm <linuxarm@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 23/01/2019 12:14, Andrew Murray wrote:
[...]
>>>> +static inline void smmu_pmu_counter_set_value(struct smmu_pmu
>>> *smmu_pmu,
>>>> +					      u32 idx, u64 value)
>>>> +{
>>>> +	if (smmu_pmu->counter_mask & BIT(32))
>>>> +		writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
>>> 8));
>>>> +	else
>>>> +		writel(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
>>> 4));
>>>
>>> The arm64 IO macros use __force u32 and so it's probably OK to provide a 64
>>> bit
>>> value to writel. But you could use something like lower_32_bits for clarity.
>>
>> Yes, macro uses __force u32. I will change it to make it more clear though.

To be pedantic, the first cast which the value actually undergoes is to 
(__u32) ;)

Ultimately, __raw_writel() takes a u32, so in that sense it's never a 
problem to pass a u64, since unsigned truncation is well-defined in the 
C standard. The casting involved in the I/O accessors is mostly about 
going to an endian-specific type and back again.

[...]
>>>> +static void smmu_pmu_event_start(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx = hwc->idx;
>>>> +	u32 filter_span, filter_sid;
>>>> +	u32 evtyper;
>>>> +
>>>> +	hwc->state = 0;
>>>> +
>>>> +	smmu_pmu_set_period(smmu_pmu, hwc);
>>>> +
>>>> +	smmu_pmu_get_event_filter(event, &filter_span, &filter_sid);
>>>> +
>>>> +	evtyper = get_event(event) |
>>>> +		  filter_span << SMMU_PMCG_SID_SPAN_SHIFT;
>>>> +
>>>> +	smmu_pmu_set_evtyper(smmu_pmu, idx, evtyper);
>>>> +	smmu_pmu_set_smr(smmu_pmu, idx, filter_sid);
>>>> +	smmu_pmu_interrupt_enable(smmu_pmu, idx);
>>>> +	smmu_pmu_counter_enable(smmu_pmu, idx);
>>>> +}
>>>> +
>>>> +static void smmu_pmu_event_stop(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx = hwc->idx;
>>>> +
>>>> +	if (hwc->state & PERF_HES_STOPPED)
>>>> +		return;
>>>> +
>>>> +	smmu_pmu_counter_disable(smmu_pmu, idx);
>>>
>>> Is it intentional not to call smmu_pmu_interrupt_disable here?
>>
>> Yes, it is. Earlier patch had the interrupt toggling and Robin pointed out that
>> it is not really needed as counters are anyway stopped and explicitly disabling
>> may not solve the spurious interrupt case as well.
>>
> 
> Ah apologies for not seeing that in earlier reviews.

Hmm, I didn't exactly mean "keep enabling it every time an event is 
restarted and never disable it anywhere", though. I was thinking more 
along the lines of enabling in event_add() and disabling in event_del() 
(i.e. effectively tying it to allocation and deallocation of the counter).

Robin.
