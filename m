From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800
 quirk
Date: Thu, 4 Apr 2019 16:47:11 +0100
Message-ID: <20190404154711.GA27577@fuggles.cambridge.arm.com>
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
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e2c9b26..4dc68de 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1366,9 +1366,23 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>  				       ACPI_EDGE_SENSITIVE, &res[2]);
>  }
>  
> +static struct acpi_platform_list pmcg_plat_info[] __initdata = {
> +	/* HiSilicon Hip08 Platform */
> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,

Passing integer constant 0 for the reason feels wrong to me. I'm going to
change it to "Erratum #162001800" and also add an entry to
silicon-errata.txt.

Please shout if that's not ok.

Will
