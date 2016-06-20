From: Jeremy Linton <Jeremy.Linton@arm.com>
Subject: RE: [PATCH 5/8] arm: arm64: pmu: Assign platform PMU CPU affinity
Date: Mon, 20 Jun 2016 16:49:11 +0000
Message-ID: <DB5PR08MB12227A8B98AD708F7C780324F72A0@DB5PR08MB1222.eurprd08.prod.outlook.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
	<1465511013-10742-6-git-send-email-jeremy.linton@arm.com>
 <87fus76cff.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:29059 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755231AbcFTQto convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2016 12:49:44 -0400
In-Reply-To: <87fus76cff.fsf@e105922-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <Punit.Agrawal@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <Mark.Rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mlangsdorf@redhat.com" <mlangsdorf@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "acme@kernel.org" <acme@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>



|-----Original Message-----
|From: Punit Agrawal [mailto:punit.agrawal@arm.com]
|Sent: Monday, June 20, 2016 11:41 AM
|To: Jeremy Linton
|Cc: linux-arm-kernel@lists.infradead.org; Mark Rutland; Lorenzo Pieralisi;
|mlangsdorf@redhat.com; peterz@infradead.org; Catalin Marinas; Will
|Deacon; acme@kernel.org; linux-acpi@vger.kernel.org;
|alexander.shishkin@linux.intel.com; mingo@redhat.com
|Subject: Re: [PATCH 5/8] arm: arm64: pmu: Assign platform PMU CPU affinity
|
|Jeremy Linton <jeremy.linton@arm.com> writes:
|
|> On systems with multiple PMU types the PMU to CPU affinity needs to be
|> detected and set. The CPU to interrupt affinity should also be set.
|>
|
|One comment below.
|
|> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
|> ---
|>  drivers/perf/arm_pmu.c | 52
|++++++++++++++++++++++++++++++++++++++++----------
|>  1 file changed, 42 insertions(+), 10 deletions(-)
|>
|> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
|> index fee4be0e8..865a9db 100644
|> --- a/drivers/perf/arm_pmu.c
|> +++ b/drivers/perf/arm_pmu.c
|
|[...]
|
|> @@ -872,25 +874,56 @@ static void cpu_pmu_destroy(struct arm_pmu
|*cpu_pmu)
|>  }
|>
|>  /*
|> - * CPU PMU identification and probing.
|> + * CPU PMU identification and probing. Its possible to have
|> + * multiple CPU types in an ARM machine. Assure that we are
|> + * picking the right PMU types based on the CPU in question
|>   */
|> -static int probe_current_pmu(struct arm_pmu *pmu,
|> -     const struct pmu_probe_info *info)
|> +static int probe_plat_pmu(struct arm_pmu *pmu,
|> +     const struct pmu_probe_info *info,
|> +     unsigned int pmuid)
|>  {
|> -int cpu = get_cpu();
|> -unsigned int cpuid = read_cpuid_id();
|>  int ret = -ENODEV;
|> +int cpu;
|> +int aff_ctr = 0;
|> +struct platform_device *pdev = pmu->plat_device;
|> +int irq = platform_get_irq(pdev, 0);
|>
|> -pr_info("probing PMU on CPU %d\n", cpu);
|> +if (irq >= 0 && !irq_is_percpu(irq)) {
|> +pmu->irq_affinity = kcalloc(pdev->num_resources,
|sizeof(int),
|> +    GFP_KERNEL);
|> +if (!pmu->irq_affinity)
|> +return -ENOMEM;
|> +}
|> +
|> +for_each_possible_cpu(cpu) {
|> +unsigned int cpuid = read_specific_cpuid(cpu);
|> +
|> +if (cpuid == pmuid) {
|> +cpumask_set_cpu(cpu, &pmu->supported_cpus);
|> +pr_devel("enable pmu on cpu %d\n", cpu);
|> +if (pmu->irq_affinity) {
|
|The check for irq_affinity can be dropped as you already do that earlier.

There isn't an irq_affinity structure for machines with PMU's using PPI's, that is why the check is there...

Thanks,

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

