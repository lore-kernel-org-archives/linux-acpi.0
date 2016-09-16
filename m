From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v9 07/10] arm: arm64: pmu: Assign platform PMU CPU affinity
Date: Fri, 16 Sep 2016 17:37:41 +0100
Message-ID: <87h99fu7fu.fsf@e105922-lin.cambridge.arm.com>
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
        <1473892358-22574-8-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59663 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935667AbcIPQiN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Sep 2016 12:38:13 -0400
In-Reply-To: <1473892358-22574-8-git-send-email-jeremy.linton@arm.com> (Jeremy
        Linton's message of "Wed, 14 Sep 2016 17:32:35 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, will.deacon@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

Hi Jeremy,

One comment below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 53 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 58117d7..63f16a5 100644
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
> @@ -876,25 +878,67 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
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
> +	static int duplicate_pmus;
> +	struct platform_device *pdev = pmu->plat_device;
> +	int irq = platform_get_irq(pdev, 0);
>  
> -	pr_info("probing PMU on CPU %d\n", cpu);
> +	if (irq >= 0 && !irq_is_percpu(irq)) {

Marc's got a patch[0] changing all instances of "irq >= 0" in this file to
"irq > 0" on the basis that irq 0 is an error.

If this version doesn't get merged, please drop the "=" for the next
version.

[0] http://marc.info/?l=linux-arm-kernel&m=147318284923863


[...]

