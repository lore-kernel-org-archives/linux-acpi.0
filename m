From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800
 quirk
Date: Thu, 4 Apr 2019 13:32:25 +0100
Message-ID: <20190404123218.GA27823@fuggles.cambridge.arm.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-5-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326151753.19384-5-shameerali.kolothum.thodi@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: lorenzo.pieralisi@arm.com, robin.murphy@arm.com, andrew.murray@arm.com, jean-philippe.brucker@arm.com, mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org, vkilari@codeaurora.org, rruigrok@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, neil.m.leeder@gmail.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 03:17:53PM +0000, Shameer Kolothum wrote:
> HiSilicon erratum 162001800 describes the limitation of
> SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.
> 
> On these platforms, the PMCG event counter registers
> (SMMU_PMCG_EVCNTRn) are read only and as a result it
> is not possible to set the initial counter period value
> on event monitor start.
> 
> To work around this, the current value of the counter
> is read and used for delta calculations. OEM information
> from ACPI header is used to identify the affected hardware
> platforms.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
>  drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/acpi_iort.h     |  1 +
>  3 files changed, 57 insertions(+), 8 deletions(-)

I need an Ack from Lorenzo for the IORT parts of this patch.

Will
