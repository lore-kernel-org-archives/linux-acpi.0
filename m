From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 5/5] irqchip: GIC: Switch ACPI support to stacked domains
Date: Wed, 22 Jul 2015 16:35:14 +0800
Message-ID: <55AF55C2.4060807@linaro.org>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com> <1437473280-11431-6-git-send-email-marc.zyngier@arm.com> <20150721180542.GB32187@red-moon> <55AE8B8D.8050002@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34981 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbbGVIfY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jul 2015 04:35:24 -0400
Received: by pabkd10 with SMTP id kd10so62957840pab.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2015 01:35:23 -0700 (PDT)
In-Reply-To: <55AE8B8D.8050002@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>

On 07/22/2015 02:12 AM, Marc Zyngier wrote:
> On 21/07/15 19:05, Lorenzo Pieralisi wrote:
>> On Tue, Jul 21, 2015 at 11:08:00AM +0100, Marc Zyngier wrote:
>>> Now that the basic ACPI GSI code is irq domain aware, make sure
>>> that the ACPI support in the GIC doesn't pointlessly deviate from
>>> the DT path.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>   drivers/irqchip/irq-gic.c       | 17 ++++++-----------
>>>   include/linux/irqchip/arm-gic.h |  2 +-
>>>   2 files changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>> index b41ccf5..f5d365d 100644
>>> --- a/drivers/irqchip/irq-gic.c
>>> +++ b/drivers/irqchip/irq-gic.c
>>> @@ -813,8 +813,6 @@ static int gic_irq_domain_xlate(struct irq_doma=
in *d,
>>>   {
>>>   	unsigned long ret =3D 0;
>>>
>>> -	if (irq_domain_get_of_node(d) !=3D controller)
>>> -		return -EINVAL;
>>>   	if (intsize < 3)
>>>   		return -EINVAL;
>>>
>>> @@ -887,7 +885,7 @@ void gic_set_irqchip_flags(unsigned long flags)
>>>
>>>   void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>   			   void __iomem *dist_base, void __iomem *cpu_base,
>>> -			   u32 percpu_offset, struct device_node *node)
>>> +			   u32 percpu_offset, void *domain_token)
>>>   {
>>>   	irq_hw_number_t hwirq_base;
>>>   	struct gic_chip_data *gic;
>>> @@ -946,8 +944,8 @@ void __init gic_init_bases(unsigned int gic_nr,=
 int irq_start,
>>>   		gic_irqs =3D 1020;
>>>   	gic->gic_irqs =3D gic_irqs;
>>>
>>> -	if (node) {		/* DT case */
>>> -		gic->domain =3D irq_domain_add_linear(node, gic_irqs,
>>> +	if (domain_token) {		/* DT/ACPI case */
>>> +		gic->domain =3D irq_domain_add_linear(domain_token, gic_irqs,
>>>   						    &gic_irq_domain_hierarchy_ops,
>>>   						    gic);
>>>   	} else {		/* Non-DT case */
>>> @@ -973,7 +971,7 @@ void __init gic_init_bases(unsigned int gic_nr,=
 int irq_start,
>>>   			irq_base =3D irq_start;
>>>   		}
>>>
>>> -		gic->domain =3D irq_domain_add_legacy(node, gic_irqs, irq_base,
>>> +		gic->domain =3D irq_domain_add_legacy(NULL, gic_irqs, irq_base,
>>>   					hwirq_base, &gic_irq_domain_ops, gic);
>>>   	}
>>>
>>> @@ -1132,12 +1130,9 @@ gic_v2_acpi_init(struct acpi_table_header *t=
able)
>>>   	}
>>>
>>>   	/*
>>> -	 * Initialize zero GIC instance (no multi-GIC support). Also, set=
 GIC
>>> -	 * as default IRQ domain to allow for GSI registration and GSI to=
 IRQ
>>> -	 * number translation (see acpi_register_gsi() and acpi_gsi_to_ir=
q()).
>>> +	 * Initialize zero GIC instance (no multi-GIC support).
>>>   	 */
>>> -	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
>>> -	irq_set_default_host(gic_data[0].domain);
>>> +	gic_init_bases(0, -1, dist_base, cpu_base, 0, (void *)ACPI_IRQ_MO=
DEL_GIC);
>>
>> Nit: the acpi_irq_model_id enum starts from 0, I do not think we wil=
l
>> use the IRQ domain look-up for the ACPI_IRQ_MODEL_PIC but we have
>> to be careful anyway.
>
> Yeah, I noticed that one too, but couldn't imagine the PIC being
> migrated to that model just yet. It looks like it would be pretty
> harmless to set ACPI_IRQ_MODEL_PIC to 1, and introduce
> ACPI_IRQ_MODEL_ILLEGAL as zero.

I think this will be a problem, because acpi_irq_model_id enum actually
is defined by the ACPI spec, and the value is used to report to BIOS
the current interrupt model used by OS, see section 5.8.1 _PIC Method
in ACPI 6.0:

0 =96 PIC mode
1 =96 APIC mode
2 =96 SAPIC mode
Other values =96Reserved

so we can't set ACPI_IRQ_MODEL_PIC to 1 as it may break the firmware,
also _PIC method actually is not needed for ARM platform at all, we
don't need to report to firmware the interrupt model used by OS on
ARM, it only used by legacy IA platforms, actually I'm planning to
remove acpi_irq_model_id on ARM64.

So to me acpi_irq_model_id is suitable for the token, can we use
another one as the token? how about the GIC ID in the MADT table?
and this also can be used for x86 (IOAPIC IDs) too.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
