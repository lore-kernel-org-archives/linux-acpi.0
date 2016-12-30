From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 07/14] irqchip: gicv3-its: platform-msi: scan MADT to
 create platform msi domain
Date: Fri, 30 Dec 2016 16:57:48 +0800
Message-ID: <5866218C.2050901@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-8-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:31255 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbcL3I7F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2016 03:59:05 -0500
In-Reply-To: <1482384922-21507-8-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> With the introduction of its_pmsi_init_one(), we can add some code
> on top for ACPI support of platform MSI.
>
> We are scanning the MADT table to get the ITS entry(ies), then use
> the information to create the platform msi domain for devices connect
> to it, just like the PCI MSI for ITS did.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/irqchip/irq-gic-v3-its-platform-msi.c | 36 +++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index ff72704..0be0437 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -105,6 +105,41 @@ static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_ACPI
> +static int __init
> +its_pmsi_parse_madt(struct acpi_subtable_header *header,
> +			const unsigned long end)
> +{
> +	struct acpi_madt_generic_translator *its_entry;
> +	struct fwnode_handle *domain_handle;
> +	const char *node_name;
> +	int err = -ENXIO;
> +
> +	its_entry = (struct acpi_madt_generic_translator *)header;
> +	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
> +			      (long)its_entry->base_address);
> +	domain_handle = iort_find_domain_token(its_entry->translation_id);
> +	if (!domain_handle) {
> +		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
> +		goto out;
> +	}
> +
> +	err = its_pmsi_init_one(domain_handle, node_name);
> +
> +out:
> +	kfree(node_name);
> +	return err;
> +}
> +
> +static void __init its_acpi_pmsi_init(void)
> +{
> +	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
> +			      its_pmsi_parse_madt, 0);
> +}
> +#else
> +static inline void its_acpi_pmsi_init(void) { }
> +#endif
> +
>   static void __init its_pmsi_of_init(void)
>   {
>   	struct device_node *np;
> @@ -121,6 +156,7 @@ static void __init its_pmsi_of_init(void)
>   static int __init its_pmsi_init(void)
>   {
>   	its_pmsi_of_init();
> +	its_acpi_pmsi_init();
>   	return 0;
>   }
>   early_initcall(its_pmsi_init);
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>

