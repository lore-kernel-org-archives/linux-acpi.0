From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 2/4] perf/smmuv3: Add arm64 smmuv3 pmu driver
Date: Thu, 4 Apr 2019 16:30:20 +0100
Message-ID: <20190404153020.GD27558@fuggles.cambridge.arm.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: lorenzo.pieralisi@arm.com, robin.murphy@arm.com, andrew.murray@arm.com, jean-philippe.brucker@arm.com, mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org, vkilari@codeaurora.org, rruigrok@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, neil.m.leeder@gmail.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 03:17:51PM +0000, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Adds a new driver to support the SMMUv3 PMU and add it into the
> perf events framework.
> 
> Each SMMU node may have multiple PMUs associated with it, each of
> which may support different events.
> 
> SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page> where
> <phys_addr_page> is the physical page address of the SMMU PMCG
> wrapped to 4K boundary. For example, the PMCG at 0xff88840000 is
> named smmuv3_pmcg_ff88840
> 
> Filtering by stream id is done by specifying filtering parameters
> with the event. options are:
>    filter_enable    - 0 = no filtering, 1 = filtering enabled
>    filter_span      - 0 = exact match, 1 = pattern match
>    filter_stream_id - pattern to filter against
> 
> Example: perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
>                        filter_span=1,filter_stream_id=0x42/ -a netperf
> 
> Applies filter pattern 0x42 to transaction events, which means events
> matching stream ids 0x42 & 0x43 are counted as only upper StreamID
> bits are required to match the given filter. Further filtering
> information is available in the SMMU documentation.
> 
> SMMU events are not attributable to a CPU, so task mode and sampling
> are not supported.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 776 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 786 insertions(+)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c

[...]

> +static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct smmu_pmu *smmu_pmu;
> +	unsigned int target;
> +
> +	smmu_pmu = hlist_entry_safe(node, struct smmu_pmu, node);
> +	if (cpu != smmu_pmu->on_cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> +	smmu_pmu->on_cpu = target;
> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));

I'm going to make this (and the other invocation) use
irq_set_affinity_hint() instead, so that we can build this driver as a
module with the appropriate Kconfig tweak.

Will
