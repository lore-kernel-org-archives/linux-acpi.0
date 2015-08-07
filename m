From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH v4 09/10] PCI: ACPI: Bind GIC MSI frame to PCI host bridge
Date: Fri, 07 Aug 2015 12:03:24 +0200
Message-ID: <55C4826C.80600@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org> <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34046 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbbHGKD3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2015 06:03:29 -0400
Received: by labd1 with SMTP id d1so5468959lab.1
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2015 03:03:27 -0700 (PDT)
In-Reply-To: <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Timur Tabi <timur@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 29.07.2015 12:08, Hanjun Guo wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
> This patch introduces pci_host_bridge_acpi_msi_domain(), which queries
> a GIC MSI irq-domain token and use it to retrieve an irq_domain with
> DOMAIN_BUS_PCI_MSI bus type, and bind it to PCI host-bridge.
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>   drivers/pci/pci-acpi.c   | 18 ++++++++++++++++++
>   drivers/pci/probe.c      |  3 +++
>   include/linux/pci-acpi.h |  4 ++++
>   3 files changed, 25 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 314a625..5f11653 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -9,6 +9,7 @@
>
>   #include <linux/delay.h>
>   #include <linux/init.h>
> +#include <linux/irqdomain.h>
>   #include <linux/pci.h>
>   #include <linux/pci_hotplug.h>
>   #include <linux/module.h>
> @@ -16,6 +17,7 @@
>   #include <linux/pci-acpi.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pm_qos.h>
> +#include <acpi/acpi_gic.h>
>   #include "pci.h"
>
>   /*
> @@ -681,6 +683,22 @@ static bool pci_acpi_bus_match(struct device *dev)
>   	return dev_is_pci(dev);
>   }
>
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
> +{
> +	struct irq_domain *d = NULL;
> +	void *token = acpi_gic_get_msi_token(&bus->dev);
> +
> +	if (token)
> +		d = irq_find_matching_host(token, DOMAIN_BUS_PCI_MSI);
> +
> +	if (!d)
> +		pr_debug("Fail to find domain for MSI\n");
> +
> +	return d;
> +}
> +#endif /*CONFIG_GENERIC_MSI_IRQ_DOMAIN*/
> +
>   static struct acpi_bus_type acpi_pci_bus = {
>   	.name = "PCI",
>   	.match = pci_acpi_bus_match,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a7afeac..8c1204c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -12,6 +12,7 @@
>   #include <linux/module.h>
>   #include <linux/cpumask.h>
>   #include <linux/pci-aspm.h>
> +#include <linux/pci-acpi.h>
>   #include <asm-generic/pci-bridge.h>
>   #include "pci.h"
>
> @@ -670,6 +671,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>   	 * should be called from here.
>   	 */
>   	d = pci_host_bridge_of_msi_domain(bus);
> +	if (!d)
> +		d = pci_host_bridge_acpi_msi_domain(bus);

Please use acpi_disabled here.

BTW. This is another place where we need to know our firmware - DT vs 
ACPI. I know we can use acpi_disabled but I think more about generic 
solution. Since we already have:
struct fwnode_handle	*fwnode;
we can create macro which identify h/w description style, something like:

#define FWNODE_TYPE(dev)	dev_fwnode(dev)->type

and then:

switch (FWNODE_TYPE(&bus->dev)) {
case FWNODE_OF:
...
case FWNODE_ACPI:
...
case FWNODE_XXX:
...
}

Root bus is special case since it has no frimware type but we could 
factor out pci_set_bus_of_node(). For platform devices we have all we 
need. Just thinking aloud, let me know your thoughts.

Regards,
Tomasz





>
>   	return d;
>   }
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index a965efa..766d045 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -77,6 +77,8 @@ static inline void acpiphp_remove_slots(struct pci_bus *bus) { }
>   static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>   #endif
>
> +struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
> +
>   extern const u8 pci_acpi_dsm_uuid[];
>   #define DEVICE_LABEL_DSM	0x07
>   #define RESET_DELAY_DSM		0x08
> @@ -85,6 +87,8 @@ extern const u8 pci_acpi_dsm_uuid[];
>   #else	/* CONFIG_ACPI */
>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +static inline struct irq_domain *
> +pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>   #endif	/* CONFIG_ACPI */
>
>   #ifdef CONFIG_ACPI_APEI
>
