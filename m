From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v2 07/11] ACPI: acpi_pci_unbind should clean up properly
 after	acpi_pci_bind
Date: Thu, 04 Jun 2009 17:42:34 +0900
Message-ID: <4A2788FA.2050606@jp.fujitsu.com>
References: <20090604054504.18802.21690.stgit@bob.kio> <20090604055852.18802.22743.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090604055852.18802.22743.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Alex Chiang wrote:
> In acpi_pci_bind, we add _PRT information for non-bridge devices, but
> we never delete that information in acpi_pci_unbind.
> 
> We also set device->ops.bind and device->ops.unbind, but never clear
> them out.
> 
> Let's make acpi_pci_unbind clean up what we did in acpi_pci_bind.
> 
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Alex Chiang <achiang@hp.com>
> ---
> 
>  drivers/acpi/pci_bind.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
> index 62cb383..5fa1c5e 100644
> --- a/drivers/acpi/pci_bind.c
> +++ b/drivers/acpi/pci_bind.c
> @@ -106,14 +106,21 @@ EXPORT_SYMBOL(acpi_get_pci_id);
>  
>  static int acpi_pci_unbind(struct acpi_device *device)
>  {
> +	struct pci_bus *bus;
>  	struct pci_dev *dev;
>  
>  	dev = acpi_get_pci_dev(device->handle);
>  	if (!dev)
>  		return 0;
>  
> -	if (dev->subordinate)
> -		acpi_pci_irq_del_prt(dev->subordinate);
> +	if (dev->subordinate) {
> +		bus = dev->subordinate;
> +		device->ops.bind = NULL;
> +		device->ops.unbind = NULL;
> +	 } else
> +		bus = dev->bus;
> +
> +	acpi_pci_irq_del_prt(bus);
>  

I have a concern about this change.

The acpi_pci_irq_del_prt() against dev->bus removes not only
the _PRT entries for PCI function corresponding to specified
acpi_device, but also other _PRT entries for working PCI
devices/functions on the same bus. As a result, interrupt
initialization for those PCI functions would no longer work
properly after that.

So I think we should not call acpi_pci_irq_del_prt() against
dev->bus.

Thanks,
Kenji Kaneshige
