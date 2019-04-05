From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/4] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Fri, 5 Apr 2019 10:23:47 +0100
Message-ID: <ce3b8a98-625d-0a42-b8cf-c0c26871b3f4@huawei.com>
References: <20190326223938.5365-1-jeremy.linton@arm.com>
 <20190326223938.5365-4-jeremy.linton@arm.com>
 <2b53e957-6d36-fdfe-20e4-1664108c07ef@huawei.com>
 <b9081589-9c18-d298-e109-ca1d98627456@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9081589-9c18-d298-e109-ca1d98627456@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On 02/04/2019 20:14, Jeremy Linton wrote:
> Hi,
>
> First thanks for taking a look at this, second sorry about the delay...
>
> On 3/28/19 7:40 AM, John Garry wrote:
>> On 26/03/2019 22:39, Jeremy Linton wrote:
>>> ACPI 6.3 adds additional fields to the MADT GICC
>>> structure to describe SPE PPI's. We pick these out
>>> of the cached reference to the madt_gicc structure
>>> similarly to the core PMU code. We then create a platform
>>> device referring to the IRQ and let the user/module loader
>>> decide whether to load the SPE driver.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>  arch/arm64/include/asm/acpi.h |  3 ++
>>>  drivers/perf/arm_pmu_acpi.c   | 69 +++++++++++++++++++++++++++++++++++
>>>  2 files changed, 72 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/acpi.h
>>> b/arch/arm64/include/asm/acpi.h
>>> index 7628efbe6c12..d10399b9f998 100644
>>> --- a/arch/arm64/include/asm/acpi.h
>>> +++ b/arch/arm64/include/asm/acpi.h
>>> @@ -41,6 +41,9 @@
>>>      (!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH
>>> || \
>>>      (unsigned long)(entry) + (entry)->header.length > (end))
>>>
>>> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct
>>> acpi_madt_generic_interrupt, \
>>> +    spe_interrupt) + sizeof(u16))
>>> +
>>>  /* Basic configuration for ACPI */
>>>  #ifdef    CONFIG_ACPI
>>>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>> index 0f197516d708..a2418108eab2 100644
>>> --- a/drivers/perf/arm_pmu_acpi.c
>>> +++ b/drivers/perf/arm_pmu_acpi.c
>>> @@ -74,6 +74,73 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>>      acpi_unregister_gsi(gsi);
>>>  }
>>>
>>> +static struct resource spe_resources[] = {
>>> +    {
>>> +        /* irq */
>>> +        .flags          = IORESOURCE_IRQ,
>>> +    }
>>> +};
>>> +
>>> +static struct platform_device spe_dev = {
>>> +    .name = "arm,spe-v1",
>>> +    .id = -1,
>>> +    .resource = spe_resources,
>>> +    .num_resources = ARRAY_SIZE(spe_resources)
>>> +};
>>> +
>>> +/*
>>> + * For lack of a better place,
>>
>> It seems that the kernel Image size can now increase due to this part
>> of SPE support even if ARM_SPE_PMU config is disabled.
>
> That is true, but it should be fairly small.
>
>>
>> And I don't even think that ARM_SPE_PMU depends on ARM_PMU (which
>> ARM_PMU_ACPI depends on).
>
> Well I don't think we want the generic SPE_PMU dependent on ACPI.

Relevant code in the SPE driver could still be built under CONFIG_ACPI.

It seems that the real problem is that some necessary ACPI-related 
symbols used in arm_spe_acpi_parse_irqs() are not exported, while the 
SPE driver can be a loadable module.

  So
> this chunk of code could be wrapped in a SPE_PMU_ACPI block, and made
> dependent on PMU_ACPI. OTOH, It seems a little trivial for that, and
> maybe just tweaking the PMU_ACPI documentation to mention that it also
> enables ACPI/SPE is a better plan.
>
> Opinions?
>
>
>>
>>
>> hook the normal PMU MADT walk
>>> + * and create a SPE device if we detect a recent MADT with
>>> + * a homogeneous PPI mapping.
>>> + */
>>> +static int arm_spe_acpi_parse_irqs(void)

nit: it's doing a bit more than parsing IRQs

>>> +{
>>> +    int cpu, ret, irq;
>>> +    int hetid;
>>> +    u16 gsi = 0;
>>> +    bool first = true;


Thanks,
John

>>> +
>>> +    struct acpi_madt_generic_interrupt *gicc;
>>> +
>>> +    /*
>>> +     * sanity check all the GICC tables for the same interrupt number
>>> +     * for now we only support homogeneous ACPI/SPE machines.
>>> +     */
>>> +    for_each_possible_cpu(cpu) {
>>> +        gicc = acpi_cpu_get_madt_gicc(cpu);
>>> +
>>> +        if (gicc->header.length < ACPI_MADT_GICC_SPE)
>>> +            return -ENODEV;
>>> +        if (first) {
>>> +            gsi = gicc->spe_interrupt;
>>> +            if (!gsi)
>>> +                return -ENODEV;
>>> +            hetid = find_acpi_cpu_topology_hetero_id(cpu);
>>> +            first = false;
>>> +        } else if ((gsi != gicc->spe_interrupt) ||
>>> +               (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
>>> +            pr_warn("ACPI: SPE must be homogeneous\n");
>>> +            return -EINVAL;
>>> +        }
>>> +    }
>>> +
>>> +    irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
>>> +                ACPI_ACTIVE_HIGH);
>>> +    if (irq < 0) {
>>> +        pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
>>> +        return irq;
>>> +    }
>>> +
>>> +    spe_resources[0].start = irq;
>>> +    ret = platform_device_register(&spe_dev);
>>> +    if (ret < 0) {
>>> +        pr_warn("ACPI: SPE: Unable to register device\n");
>>> +        acpi_unregister_gsi(gsi);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>  static int arm_pmu_acpi_parse_irqs(void)
>>>  {
>>>      int irq, cpu, irq_cpu, err;
>>> @@ -279,6 +346,8 @@ static int arm_pmu_acpi_init(void)
>>>      if (acpi_disabled)
>>>          return 0;
>>>
>>> +    arm_spe_acpi_parse_irqs(); /* failures are expected */
>>> +
>>>      ret = arm_pmu_acpi_parse_irqs();
>>>      if (ret)
>>>          return ret;
>>>
>>
>>
>
>
> .
>
