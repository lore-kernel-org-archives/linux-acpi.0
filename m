From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v5 0/4] arm64 SMMUv3 PMU driver with IORT support
Date: Tue, 22 Jan 2019 14:38:23 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392939DF@lhreml524-mbb.china.huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "vkilari@codeaurora.org" <vkilari@codeaurora.org>, "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "pabba@codeaurora.org" <pabba@codeaurora.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, Linuxarm <linuxarm@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

Hi Robin/Lorenzo,

A gentle reminder on this series. Please take a look.

Thanks,
Shameer

> -----Original Message-----
> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Shameer
> Kolothum
> Sent: 30 November 2018 15:48
> To: lorenzo.pieralisi@arm.com; robin.murphy@arm.com
> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
> neil.m.leeder@gmail.com; jean-philippe.brucker@arm.com;
> pabba@codeaurora.org; will.deacon@arm.com; rruigrok@codeaurora.org;
> Linuxarm <linuxarm@huawei.com>; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v5 0/4] arm64 SMMUv3 PMU driver with IORT support
> 
> This adds a driver for the SMMUv3 PMU into the perf framework.
> It includes an IORT update to support PM Counter Groups.
> 
> This is based on the initial work done by Neil Leeder[1]
> 
> SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page>
> where <phys_addr_page> is the physical page address of the SMMU PMCG.
> For example, the PMCG at 0xff88840000 is named smmuv3_pmcg_ff88840
> 
> Usage example:
> For common arch supported events:
> perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
>  filter_span=1,filter_stream_id=0x42/ -a netperf
> 
> For IMP DEF events:
> perf stat -e smmuv3_pmcg_ff88840/event=id/ -a netperf
> 
> This is sanity tested on a HiSilicon platform that requires
> a quirk to run  it properly. As per HiSilicon erratum  #162001800,
> PMCG event counter registers (SMMU_PMCG_EVCNTRn) on HiSilicon Hip08
> platforms are read only and this prevents the software from setting
> the initial period on event start. Unfortunately we were a bit late
> in the cycle to detect this issue and now require software workaround
> for this. Patch #4 is added to this series to provide a workaround
> for this issue.
> 
> Further testing on supported platforms are very much welcome.
> 
> v4 ---> v5
> -IORT code is modified to pass the option/quirk flags to the driver
>  through platform_data (patch #4), based on Robin's comments.
> -Removed COMPILE_TEST (patch #2).
> 
> v3 --> v4
> 
> -Addressed comments from Jean and Robin.
> -Merged dma config callbacks as per Lorenzo's comments(patch #1).
> -Added handling of Global(Counter0) filter settings mode(patch #2).
> -Added patch #4 to address HiSilicon erratum  #162001800
> -
> v2 --> v3
> 
> -Addressed comments from Robin.
> -Removed iort helper function to retrieve the PMCG reference smmu.
> -PMCG devices are now named using the base address
> 
> v1 --> v2
> 
> - Addressed comments from Robin.
> - Added an helper to retrieve the associated smmu dev and named PMUs
>   to make the association visible to user.
> - Added MSI support  for overflow irq
> 
> [1]https://www.spinics.net/lists/arm-kernel/msg598591.html
> 
> Neil Leeder (2):
>   acpi: arm64: add iort support for PMCG
>   perf: add arm64 smmuv3 pmu driver
> 
> Shameer Kolothum (2):
>   perf/smmuv3: Add MSI irq support
>   perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800 quirk
> 
>  drivers/acpi/arm64/iort.c     | 127 +++++--
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 859
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi_iort.h     |   3 +
>  5 files changed, 975 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> 
> --
> 2.7.4
> 
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
