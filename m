From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] ACPI: PCI: use generic pci_swizzle_interrupt_pin()
Date: Thu, 12 Mar 2009 16:51:31 -0600
Message-ID: <200903121651.32140.bjorn.helgaas@hp.com>
References: <20090217204910.4213.77580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:25048 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbZCLWwx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2009 18:52:53 -0400
In-Reply-To: <20090217204910.4213.77580.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 17 February 2009 1:49:10 pm Bjorn Helgaas wrote:
> Use the generic pci_swizzle_interrupt_pin() instead of ACPI-specific code.

Did you have a reaction to this?  If you did, I missed it.

> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/pci_irq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 891bdf6..be6b909 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -319,7 +319,7 @@ static struct acpi_prt_entry
> *acpi_pci_irq_lookup(struct pci_dev *dev, int pin) */
>  	bridge = dev->bus->self;
>  	while (bridge) {
> -		pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
> +		pin = pci_swizzle_interrupt_pin(dev, pin);
>
>  		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
>  			/* PC card has the same IRQ as its cardbridge */


