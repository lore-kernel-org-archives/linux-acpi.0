From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 10/10] acpi, gicv3, its: Use MADT ITS subtable to do
 PCI/MSI domain initialization.
Date: Wed, 10 Feb 2016 12:02:45 +0000
Message-ID: <56BB26E5.6060703@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-11-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46603 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbcBJMCt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Feb 2016 07:02:49 -0500
In-Reply-To: <1453209083-3358-11-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 19/01/16 13:11, Tomasz Nowicki wrote:
> After refactoring DT code, we let ACPI to build ITS PCI MSI domain
> and do requester ID to device ID translation using IORT table.
> 
> We have now full PCI MSI domain stack, thus we can enable ITS initialization
> from GICv3 core driver for ACPI scenario.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c | 44 +++++++++++++++++++++++++++++++-
>  drivers/irqchip/irq-gic-v3.c             |  3 +--
>  drivers/pci/msi.c                        |  3 +++
>  3 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index 06165cb..7f0a958 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -15,6 +15,8 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/iort.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -143,10 +145,50 @@ static int __init its_pci_of_msi_init(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +
> +static int __init
> +its_pci_msi_parse_madt(struct acpi_subtable_header *header,
> +		    const unsigned long end)
> +{
> +	struct acpi_madt_generic_translator *its_entry;
> +	struct fwnode_handle *domain_handle;
> +
> +	its_entry = (struct acpi_madt_generic_translator *)header;
> +	domain_handle = iort_find_its_domain_token(its_entry->translation_id);
> +	if (!domain_handle) {
> +		pr_err("ITS@0x%lx: Unable to locate ITS domain handle\n",
> +		       (long)its_entry->base_address);
> +		return 0;
> +	}
> +
> +	if (its_pci_msi_init_one(domain_handle))
> +		return 0;
> +
> +	pci_msi_register_fwnode_provider(&iort_find_pci_domain_token);

I'm a bit worried by this. You are registering this for each and every
ITS that gets probed (useless, but why not). But also, you're using a
hook that is designed to work at the bus level, without caring for the
actual PCI devices. That's fine for something like GICv2m, which exposes
a single domain, but I can't picture how this works when you have
devices sitting behind a single RC that talk to different ITSs.

My understanding is that IORT was behaving in a similar way the msi-map
property works, so I'm a bit puzzled here.

Can you please shed some light on that?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
