From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 07/11] arm: arm64: pmu: Assign platform PMU CPU affinity
Date: Fri, 01 Jul 2016 15:00:57 +0100
Message-ID: <87d1mxe9uu.fsf@e105922-lin.cambridge.arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
	<1466529109-21715-8-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53161 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752443AbcGAOBx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 10:01:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, Lorenzo.Pieralisi@arm.com, mlangsdorf@redhat.com, alexander.shishkin@linux.intel.com, catalin.marinas@arm.com, will.deacon@arm.com, acme@kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, Steve.Capper@arm.com

Hi Jeremy,

One typo below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 53 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 2286cbf..28cac3a 100644
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
> @@ -872,25 +874,57 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  }
>  
>  /*
> - * CPU PMU identification and probing.
> + * CPU PMU identification and probing. Its possible to have
> + * multiple CPU types in an ARM machine. Assure that we are
                                            Assume



> + * picking the right PMU types based on the CPU in question
>   */

[...]

