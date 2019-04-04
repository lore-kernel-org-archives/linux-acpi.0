From: Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH 7/7] irqchip/al-msi: Add ACPI support
Date: Thu, 4 Apr 2019 17:45:59 +0300
Message-ID: <cc40b029-b06e-1367-2411-1ec325d3b97b@amazon.com>
References: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
 <1554035733-11827-3-git-send-email-hhhawa@amazon.com>
 <86pnq65v48.wl-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86pnq65v48.wl-marc.zyngier@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Hanna Hawa <hhhawa@amazon.com>
Cc: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, alisaidi@amazon.com, talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Marc,

We have considered exposing our interrupt controller both via MADT 
OEM-specific entry and via DSDT.
We've chosen MADT OEM-specific entry, because it seemed like a 
reasonable placeholder for custom interrupt controller, but we can move 
to DSDT, if this seems like a better way to represent it.

Either way we chose, we'll need to solve the ordering issue of the 
drivers probing.
The desired order of driver probing in the system, because of the 
dependencies, is:
GIC -> AL MSIX controller driver -> PCI
If we keep using MADT, we can't just use IRQCHIP_DECLARE, because there 
is no way we found to control ordering of MADT probing. So, GIC might be 
probed after our driver in this case.
The reason we used early_initcall, is that the early_initcalls are 
invoked after MADT probing in the system (and before DSDT probing).

If we move to using DSDT we need to solve the ordering problem from 
another direction - make sure that MSIX driver is probed before PCI.
In the patches that were posted for xgene interrupt controller (and 
weren't accepted) we saw that they proposed to solve the same issue
by modifying ACPI subsystem code by defining a new type for msi drivers 
and probing them before PCI drivers 
(https://patchwork.ozlabs.org/patch/818771/).
 From the feedback on that patch 
(https://patchwork.ozlabs.org/cover/818767/#1788415) it seemed that 
alternative solution is in the works,
but we didn't manage to find any followup on this.

We would be glad to hear what you propose for fixing the ordering issue 
and rework the patches accordingly.

Thanks,
Ze'ev

On 4/1/19 05:15, Marc Zyngier wrote:
> On Sun, 31 Mar 2019 13:35:33 +0100,
> Hanna Hawa <hhhawa@amazon.com> wrote:
>>
>> This patch adds ACPI support for AL-MSIx driver.
>>
>> The AL-MSIx controller is not standard, is not included in the UEFI
>> specification, and will not be added. The driver ACPI binding is
>> performed when the following conditions are true:
>> - OEM ID is AMAZON
>> - MADT table type is 0x80 (part of the OEM reserved range).
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
>> Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
>> ---
>>   drivers/irqchip/irq-al-msi.c | 118 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 111 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-al-msi.c b/drivers/irqchip/irq-al-msi.c
>> index ec27455..cb80c1e 100644
>> --- a/drivers/irqchip/irq-al-msi.c
>> +++ b/drivers/irqchip/irq-al-msi.c
>> @@ -9,6 +9,7 @@
>>   
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/dma-iommu.h>
>>   #include <linux/irqchip.h>
>>   #include <linux/irqchip/arm-gic.h>
>> @@ -126,14 +127,20 @@ static int al_msix_gic_domain_alloc(struct irq_domain *domain,
>>   	struct irq_data *d;
>>   	int ret;
>>   
>> -	if (!is_of_node(domain->parent->fwnode))
>> +	if (is_of_node(domain->parent->fwnode)) {
>> +		fwspec.fwnode = domain->parent->fwnode;
>> +		fwspec.param_count = 3;
>> +		fwspec.param[0] = 0;
>> +		fwspec.param[1] = spi;
>> +		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
>> +	} else if (is_fwnode_irqchip(domain->parent->fwnode)) {
>> +		fwspec.fwnode = domain->parent->fwnode;
>> +		fwspec.param_count = 2;
>> +		fwspec.param[0] = spi + 32;
>> +		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
>> +	} else {
>>   		return -EINVAL;
>> -
>> -	fwspec.fwnode = domain->parent->fwnode;
>> -	fwspec.param_count = 3;
>> -	fwspec.param[0] = 0;
>> -	fwspec.param[1] = spi;
>> -	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
>> +	}
>>   
>>   	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>>   	if (ret)
>> @@ -304,3 +311,100 @@ static int al_msix_init(struct device_node *node, struct device_node *parent)
>>   }
>>   IRQCHIP_DECLARE(alpine_msix, "al,alpine-msix", al_msix_init);
>>   IRQCHIP_DECLARE(al_msix, "amazon,al-msix", al_msix_init);
>> +
>> +#ifdef CONFIG_ACPI
>> +static struct al_msix_data *priv;
>> +
>> +#define ACPI_AMZN_MADT_OEM_TYPE		0x80
>> +#define ACPI_AMZN_OEM_ID		"AMAZON"
>> +
>> +struct acpi_madt_msix_oem_frame {
>> +	struct acpi_subtable_header header;
>> +	u64 base_address;
>> +	u32 base_address_len;
>> +	u16 spi_count;
>> +	u16 spi_base;
>> +};
>> +
>> +static struct fwnode_handle *al_msi_get_fwnode(struct device *dev)
>> +{
>> +	return priv->msi_domain_handle;
>> +}
>> +
>> +static int __init al_msix_acpi_probe(struct acpi_subtable_header *header,
>> +				     const unsigned long end)
>> +{
>> +	struct irq_domain *gic_domain;
>> +	struct fwnode_handle *gic_domain_handle;
>> +	struct acpi_madt_msix_oem_frame *m;
>> +	int ret;
>> +
>> +	m = container_of(header, struct acpi_madt_msix_oem_frame, header);
>> +	if (BAD_MADT_ENTRY(m, end))
>> +		return -EINVAL;
>> +
>> +	gic_domain_handle = acpi_get_gsi_domain_id();
>> +	if (!gic_domain_handle) {
>> +		pr_err("Failed to find the GIC domain handle\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	gic_domain = irq_find_matching_fwnode(gic_domain_handle,
>> +					      DOMAIN_BUS_ANY);
>> +	if (!gic_domain) {
>> +		pr_err("Failed to find the GIC domain\n");
>> +		return -ENXIO;
>> +	}
> 
> Why do you do this in the iterator? It won't change over time, right?
> 
>> +
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->spi_first = m->spi_base;
>> +	priv->num_spis = m->spi_count;
>> +
>> +	priv->msi_domain_handle = irq_domain_alloc_fwnode((void *)
>> +							  m->base_address);
>> +	if (!priv->msi_domain_handle) {
>> +		pr_err("Unable to allocate msi domain token\n");
>> +		ret = -EINVAL;
>> +		goto err_acpi_priv;
>> +	}
>> +
>> +	ret = al_msix_init_common(priv, m->base_address);
>> +	if (ret)
>> +		goto err_acpi_priv;
>> +
>> +	ret = al_msix_init_domains(priv, gic_domain);
>> +	if (ret)
>> +		goto err_acpi_map;
>> +
>> +	pci_msi_register_fwnode_provider(&al_msi_get_fwnode);
>> +
>> +	return 0;
>> +
>> +err_acpi_map:
>> +	kfree(priv->msi_map);
>> +err_acpi_priv:
>> +	kfree(priv);
>> +	return ret;
>> +}
>> +
>> +static int __init al_msix_acpi_init(void)
>> +{
>> +	static struct acpi_table_madt *madt;
>> +	acpi_status status;
>> +
>> +	/* if ACPI MADT table is not Amazon defined return */
>> +	status = acpi_get_table(ACPI_SIG_MADT, 0,
>> +				(struct acpi_table_header **)&madt);
>> +	if (ACPI_FAILURE(status) || (madt && memcmp(madt->header.oem_id,
>> +						    ACPI_AMZN_OEM_ID,
>> +						    ACPI_OEM_ID_SIZE)))
>> +		return -ENODEV;
>> +
>> +	return acpi_table_parse_madt(ACPI_AMZN_MADT_OEM_TYPE,
>> +				     al_msix_acpi_probe, 0);
>> +}
>> +early_initcall(al_msix_acpi_init);
> 
> These initcalls are not maintainable in the long run. Either this is
> part of the core ACPI discovery (IRQCHIP_ACPI_DECLARE), or it should
> use another probing method. If you need to express dependencies, make
> it an actual device driver (I suspect you're in complete control of
> the FW anyway), which would make a lot more sense.
> 
> Thanks,
> 
> 	M.
> 
