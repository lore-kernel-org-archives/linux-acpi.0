From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH V2 6/6] gicv2m: acpi: Introducing GICv2m ACPI support
Date: Thu, 15 Oct 2015 09:30:15 -0500
Message-ID: <561FB877.4020106@amd.com>
References: <1444865156-9870-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1444865156-9870-7-git-send-email-Suravee.Suthikulpanit@amd.com>
 <561F449E.2050803@semihalf.com> <561FB238.10509@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0081.outbound.protection.outlook.com ([207.46.100.81]:2198
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751684AbbJOOab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Oct 2015 10:30:31 -0400
In-Reply-To: <561FB238.10509@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Tomasz,

On 10/15/2015 9:03 AM, Suravee Suthikulanit wrote:
>>> +    if (!data)
>>> +        return NULL;
>>> +
>>> +    return data->fwnode;
>>> +}
>>> +
>>> +static int __init
>>> +acpi_parse_madt_msi(struct acpi_subtable_header *header,
>>> +            const unsigned long end)
>>> +{
>>> +    int ret;
>>> +    struct resource res;
>>> +    u32 spi_start = 0, nr_spis = 0;
>>> +    struct acpi_madt_generic_msi_frame *m;
>>> +    struct fwnode_handle *fwnode = NULL;
>>> +
>>> +    m = (struct acpi_madt_generic_msi_frame *)header;
>>> +    if (BAD_MADT_ENTRY(m, end))
>>> +        return -EINVAL;
>>> +
>>> +    res.start = m->base_address;
>>> +    res.end = m->base_address + 0x1000;
>>> +
>>> +    if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
>>> +        spi_start = m->spi_base;
>>> +        nr_spis = m->spi_count;
>>> +
>>> +        pr_info("ACPI overriding V2M MSI_TYPER (base:%u, num:%u)\n",
>>> +            spi_start, nr_spis);
>>> +    }
>>> +
>>> +    fwnode = irq_domain_alloc_fwnode((void *)m->base_address);
>>> +    if (!fwnode) {
>>> +        pr_err("Unable to allocate GICv2m domain token\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
>> I case of error, we should call here:
>> irq_domain_free_fwnode(fwnode);
>
> This should have already been handled when returning from the
> acpi_parse_madt_msi() in gicv2m_teardown() since we would need to
> iterate through all existing MSI frame to clean up.

Actually, you are correct since the fwnode allocated here might not get 
assigned to the v2m_data.fwnode and added to the v2m_nodes list yet. So, 
we would need to call irq_domain_alloc_fwnode() here in case of error.

Thanks,
Suravee

