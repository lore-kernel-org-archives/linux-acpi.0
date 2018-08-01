From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
Date: Wed, 1 Aug 2018 11:20:14 +0100
Message-ID: <2cd649f9-129c-84eb-aa85-bc7615409158@arm.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA838755908@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838755908@FRAEML521-MBX.china.huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "vkilari@codeaurora.org" <vkilari@codeaurora.org>, "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>, "pabba@codeaurora.org" <pabba@codeaurora.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, Linuxarm <linuxarm@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

Hi Shameer,

On 01/08/18 09:52, Shameerali Kolothum Thodi wrote:
> Hi Lorenzo/Robin,
> 
> Just a  gentle ping on this series. This is a v2 for smmu pmcg support
> based on Neil Leeder's v1[1].

Thanks for picking this up - it's not gone unnoticed ;)

It'll take me a while to page all this stuff back in, so given where we 
are in the cycle I was planning to review it once rc1 is out, hope 
that's OK.

Cheers,
Robin.

> Main changes include,
> -an helper function to IORT to retrieve the associated SMMU info.
> -MSI support to the PMU driver.
> 
> Please take a look and let me know your thoughts.
> 
> Thanks,
> Shameer
> 
> [1]https://www.spinics.net/lists/arm-kernel/msg598591.html
> 
>> -----Original Message-----
>> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
>> Shameer Kolothum
>> Sent: 24 July 2018 12:45
>> To: lorenzo.pieralisi@arm.com; robin.murphy@arm.com
>> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
>> neil.m.leeder@gmail.com; pabba@codeaurora.org; will.deacon@arm.com;
>> rruigrok@codeaurora.org; Linuxarm <linuxarm@huawei.com>; linux-
>> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
>>
>> This adds a driver for the SMMUv3 PMU into the perf framework.
>> It includes an IORT update to support PM Counter Groups.
>>
>> This is based on the initial work done by Neil Leeder[1]
>>
>> SMMUv3 PMCG devices are named as arm_smmu_v3_x_pmcg_y where x
>> denotes the associated smmuv3 dev id(if any) and y denotes the
>> pmu dev id.
>>
>> Usage example:
>> For common arch supported events:
>> perf stat -e arm_smmu_v3_0_pmcg_6/transaction,filter_enable=1,
>>   filter_span=1,filter_stream_id=0x42/ -a pwd
>>
>> For IMP DEF events:
>> perf stat -e arm_smmu_v3.0_pmcg.6/event=id/ -a pwd
>>
>> Sanity tested on HiSilicon platform. Further testing on supported
>> platforms are very much welcome.
>>
>> v1 --> v2
>>
>> - Addressed comments from Robin.
>> - Added an helper to retrieve the associated smmu dev and named PMUs
>>    to make the association visible to user.
>> - Added MSI support  for overflow irq
>>
>> [1]https://www.spinics.net/lists/arm-kernel/msg598591.html
>>
>> Neil Leeder (2):
>>    acpi: arm64: add iort support for PMCG
>>    perf: add arm64 smmuv3 pmu driver
>>
>> Shameer Kolothum (2):
>>    acpi: arm64: iort helper to find the associated smmu of pmcg node
>>    perf/smmuv3: Add MSI irq support
>>
>>   drivers/acpi/arm64/iort.c     | 179 +++++++--
>>   drivers/perf/Kconfig          |   9 +
>>   drivers/perf/Makefile         |   1 +
>>   drivers/perf/arm_smmuv3_pmu.c | 901
>> ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi_iort.h     |   4 +
>>   5 files changed, 1063 insertions(+), 31 deletions(-)
>>   create mode 100644 drivers/perf/arm_smmuv3_pmu.c
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> Linuxarm mailing list
>> Linuxarm@huawei.com
>> http://hulk.huawei.com/mailman/listinfo/linuxarm
