From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 5/8] arm: arm64: pmu: Assign platform PMU CPU affinity
Date: Wed, 15 Jun 2016 14:09:50 +0100
Message-ID: <20160615130950.GK24029@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-6-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37251 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbcFONJ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jun 2016 09:09:56 -0400
Content-Disposition: inline
In-Reply-To: <1465511013-10742-6-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, mlangsdorf@redhat.com

On Thu, Jun 09, 2016 at 05:23:30PM -0500, Jeremy Linton wrote:
> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 52 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index fee4be0e8..865a9db 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt) "hw perfevents: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -24,6 +25,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>  
> +#include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/irq_regs.h>
>  
> @@ -872,25 +874,56 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  }
>  
>  /*
> - * CPU PMU identification and probing.
> + * CPU PMU identification and probing. Its possible to have
> + * multiple CPU types in an ARM machine. Assure that we are
> + * picking the right PMU types based on the CPU in question
>   */
> -static int probe_current_pmu(struct arm_pmu *pmu,
> -			     const struct pmu_probe_info *info)
> +static int probe_plat_pmu(struct arm_pmu *pmu,
> +			     const struct pmu_probe_info *info,
> +			     unsigned int pmuid)
>  {
> -	int cpu = get_cpu();
> -	unsigned int cpuid = read_cpuid_id();
>  	int ret = -ENODEV;
> +	int cpu;
> +	int aff_ctr = 0;
> +	struct platform_device *pdev = pmu->plat_device;
> +	int irq = platform_get_irq(pdev, 0);
>  
> -	pr_info("probing PMU on CPU %d\n", cpu);
> +	if (irq >= 0 && !irq_is_percpu(irq)) {
> +		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
> +					    GFP_KERNEL);
> +		if (!pmu->irq_affinity)
> +			return -ENOMEM;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		unsigned int cpuid = read_specific_cpuid(cpu);
> +
> +		if (cpuid == pmuid) {
> +			cpumask_set_cpu(cpu, &pmu->supported_cpus);
> +			pr_devel("enable pmu on cpu %d\n", cpu);

Please remove the pr_devels that you've added (similarly elsewhere in
the patch).

> +			if (pmu->irq_affinity) {
> +				pmu->irq_affinity[aff_ctr] = cpu;
> +				aff_ctr++;
> +			}
> +		}
> +	}
>  
> +	pr_debug("probing PMU %X\n", pmuid);

You can also kill this now -- I don't think it's much use.

> +	/* find the type of PMU given the CPU */
>  	for (; info->init != NULL; info++) {
> -		if ((cpuid & info->mask) != info->cpuid)
> +		if ((pmuid & info->mask) != info->cpuid)
>  			continue;
> +		pr_devel("Found PMU\n");
>  		ret = info->init(pmu);
> +		if (!info->cpuid) {
> +			pmu->name = kasprintf(GFP_KERNEL, "%s_0x%x",
> +					    pmu->name, ARM_PARTNUM(pmuid));

Hmm, I'm not so keen on this. I think we should name the first PMU
"armv8_pmuv3" (i.e. pmu->name) and then any subsequent PMUs should inherit
an index, e.g. "armv8_pmuv3_1". That follows a similar style to uncore
PMUs and also keeps this backwards compatible with what's currently done
with devicetree.

You can create a 'cpumask' file in the sysfs directory that identifies
the cores for the PMU (again, there is precedent for this elsewhere).

Will
