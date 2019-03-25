From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v6 2/4] perf: add arm64 smmuv3 pmu driver
Date: Mon, 25 Mar 2019 09:14:35 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8393240BA@lhreml524-mbb.china.huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-3-shameerali.kolothum.thodi@huawei.com>
 <0213c2af-149b-c47b-97cc-263f2bfecc40@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0213c2af-149b-c47b-97cc-263f2bfecc40@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "vkilari@codeaurora.org" <vkilari@codeaurora.org>, "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "pabba@codeaurora.org" <pabba@codeaurora.org>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, Linuxarm <linuxarm@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "andrew.murray@arm.com" <andrew.murray@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Robin Murphy
> Sent: 21 March 2019 15:04
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> lorenzo.pieralisi@arm.com
> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
> neil.m.leeder@gmail.com; jean-philippe.brucker@arm.com;
> pabba@codeaurora.org; John Garry <john.garry@huawei.com>;
> will.deacon@arm.com; rruigrok@codeaurora.org; Linuxarm
> <linuxarm@huawei.com>; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; andrew.murray@arm.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v6 2/4] perf: add arm64 smmuv3 pmu driver

[...]

> Ah, apologies for leading you wrong on this, but it has turned out to be
> bogus - perf_pmu_register() does things for which preemption should not
> be disabled, and it flares up particularly on PREEMPT_RT. For now, I
> think the best thing to do is to bring the put_cpu() call up here (or
> just use raw_smp_processor_id() instead) and accept that those
> vanishingly-unlikely-in-practice race conditions exist until someone can
> make the registration dance more robust in the perf core itself.
> 
> Beyond that, though, I'm trusting that everything I didn't comment on
> last time and doesn't appear at a glance to have changed is still good,
> so with the comments above addressed,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> FYI, both Will and Mark are out for a while, so whilst I expect v7
> should be good to merge, don't expect any maintainer final say for at
> least a couple of weeks yet.
> 

Thanks Robin. I will address the comments and sent out v7 soon.

Cheers,
Shameer
