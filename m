From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Subject: Re: [PATCH v3 2/2] acpi, gicv3-its, numa: Adding numa node mapping
 for gic-its units
Date: Wed, 21 Jun 2017 15:26:08 +0530
Message-ID: <CAFpQJXV-HfVK1GoOb7_svAK7NLoJvYgUmjV36DhgqhfDoafFaQ@mail.gmail.com>
References: <1498025743-6340-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498025743-6340-3-git-send-email-ganapatrao.kulkarni@cavium.com> <89b8b97d-1f4c-4938-9932-b2d637797e14@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36851 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdFUJ4K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2017 05:56:10 -0400
In-Reply-To: <89b8b97d-1f4c-4938-9932-b2d637797e14@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, linux-acpi@vger.kernel.org, devel@acpica.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Jayachandran C <jnair@caviumnetworks.com>

On Wed, Jun 21, 2017 at 2:28 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 21/06/17 07:15, Ganapatrao Kulkarni wrote:
>> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2
>> Later in per device probe, ITS devices are mapped to
>> numa node using ITS id to proximity domain mapping.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 80 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 79 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 45ea1933..88cfb32 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1833,6 +1833,82 @@ static int __init its_of_probe(struct device_node *node)
>>
>>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
>>
>> +#ifdef CONFIG_ACPI_NUMA
>> +struct its_srat_map {
>> +     u32     numa_node;  /* numa node id */
>> +     u32     its_id;  /* GIC ITS ID */
>> +};
>> +
>> +static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata = {
>> +     [0 ... MAX_NUMNODES - 1] = {NUMA_NO_NODE, UINT_MAX} };
>> +
>> +static int its_in_srat __initdata;
>> +
>> +static int __init
>> +acpi_get_its_numa_node(u32 its_id)
>
> Please keep these on the same line.

sure.
>
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < its_in_srat; i++) {
>> +             if (its_id == its_srat_maps[i].its_id)
>> +                     return its_srat_maps[i].numa_node;
>> +     }
>> +     return NUMA_NO_NODE;
>> +}
>> +
>> +static int __init
>> +gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
>> +                      const unsigned long end)
>
> Same remark.

ok
>
>> +{
>> +     int pxm, node;
>> +     struct acpi_srat_its_affinity *its_affinity;
>> +
>> +     its_affinity = (struct acpi_srat_its_affinity *)header;
>> +     if (!its_affinity)
>> +             return -EINVAL;
>> +
>> +     if (its_affinity->header.length <
>> +                     sizeof(struct acpi_srat_its_affinity)) {
>
> Same thing.

ok
>
>> +             pr_err("SRAT:ITS: Invalid SRAT header length: %d\n",
>> +                     its_affinity->header.length);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (its_in_srat >= MAX_NUMNODES) {
>> +             pr_err("SRAT:ITS: ITS devices exceeding max count[%d]\n",
>> +                             MAX_NUMNODES);
>> +             return -EINVAL;
>> +     }
>> +
>> +     pxm = its_affinity->proximity_domain;
>> +     node = acpi_map_pxm_to_node(pxm);
>> +
>> +     if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>> +             pr_err("SRAT:ITS: Invalid numa node %d\n", node);
>> +             return -EINVAL;
>> +     }
>
> So if you find an entry that doesn't match the current kernel
> configuration, you drop all the subsequent entries? That doesn't feel right.

thanks, it is reasonable to print warning to notify that
mapping is broken for some tables and continue.
anyway device which does not have mapping gets mapped default to NUMA_NO_NODE.

>
>> +
>> +     its_srat_maps[its_in_srat].numa_node = node;
>> +     its_srat_maps[its_in_srat].its_id = its_affinity->its_id;
>> +     its_in_srat++;
>> +     pr_info("ACPI: NUMA: SRAT: ITS: PXM %d -> ITS_ID %d -> NODE %d\n",
>> +             pxm, its_affinity->its_id, node);
>> +
>> +     return 0;
>> +}
>> +
>> +static int __init acpi_table_parse_srat_its(void)
>> +{
>> +     return acpi_table_parse_entries(ACPI_SIG_SRAT,
>> +                                     sizeof(struct acpi_table_srat),
>> +                                     ACPI_SRAT_TYPE_GIC_ITS_AFFINITY,
>> +                                     gic_acpi_parse_srat_its, 0);
>
> If you don't check the return value, there is no point returning it.

 thanks, return value is don't care, i will change accordingly.
>
>> +}
>> +#else
>> +#define acpi_table_parse_srat_its()  do { } while (0)
>> +#define acpi_get_its_numa_node(its_id)       NUMA_NO_NODE
>> +#endif
>> +
>>  static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>>                                         const unsigned long end)
>>  {
>> @@ -1861,7 +1937,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>>               goto dom_err;
>>       }
>>
>> -     err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
>> +     err = its_probe_one(&res, dom_handle,
>> +                     acpi_get_its_numa_node(its_entry->translation_id));
>>       if (!err)
>>               return 0;
>>
>> @@ -1873,6 +1950,7 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>>
>>  static void __init its_acpi_probe(void)
>>  {
>> +     acpi_table_parse_srat_its();
>>       acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
>>                             gic_acpi_parse_madt_its, 0);
>>  }
>>
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

thanks
Ganapat
