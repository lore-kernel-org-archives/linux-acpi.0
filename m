From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] ACPI / PCI: remove an extra check from acpi_pci_irq_enable()
Date: Thu, 08 Aug 2013 15:58:10 +0200
Message-ID: <2190379.Yl0SdRsOJp@vostro.rjw.lan>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com> <1375965314-24232-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1375965314-24232-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, August 08, 2013 03:35:14 PM Heikki Krogerus wrote:
> acpi_isa_irq_to_gsi() will check if the irq is within
> accepted rage so there is no need to check it separately.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Hi Bjorn,

Does this look OK to you?

Rafael


> ---
>  drivers/acpi/pci_irq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 902ed1c..e71e7fa 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -427,9 +427,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  			return -ENOENT;
>  		}
>  
> -		/* Interrupt Line values above 0xF are forbidden */
> -		if ((dev->irq <= 0xF) &&
> -		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
> +		if (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0) {
>  			dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
>  				 pin_name(pin), dev->irq);
>  			acpi_register_gsi(&dev->dev, dev_gsi,
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
