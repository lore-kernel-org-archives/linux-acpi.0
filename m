From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Wed, 8 Mar 2017 16:34:10 -0600
Message-ID: <20170308223410.GA12086@bhelgaas-glaptop.roam.corp.google.com>
References: <20170210114517.14812-1-sassmann@kpanic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbdCHWmK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Mar 2017 17:42:10 -0500
Content-Disposition: inline
In-Reply-To: <20170210114517.14812-1-sassmann@kpanic.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@kpanic.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net

Hi Stefan,

On Fri, Feb 10, 2017 at 12:45:17PM +0100, Stefan Assmann wrote:
> When checking for boot interrupts and PRT index is zero avoid doing
> any interrupt rerouting since the code currently does not handle
> determining the IRQ via _CRS method.

I don't understand this at all.  Can you educate me a little?

This bug occurs on the M2N-LR system.  I think that board contains an
Intel 6702PXH PCIe-to-PCI-X bridge to support its PCI-X slots.  A
PCI-X 3ware 9550SX is plugged in below the 6702PXH, and the problem is
with the wired INTx interrupts from the 9550SX.

Can we tell where those PCI-X INTx wires are connected?  There's an
IOAPIC in the 6702PXH; if they're connected there, the Intel 6700PXH
64-bit PCI Hub datasheet [1], sec 2.15.2, says it should generate
upstream PCIe INTx messages ("boot interrupts") if the PCI-X INTx
interrupt is masked in the APIC.

If the PCI-X INTx wires are connected elsewhere, e.g., to some other
IOAPIC, the 6702PXH should never see its IOAPIC inputs wiggle and it
should never generate a boot interrupt.

The fact that the 6702PXH IOAPIC doesn't appear in the lspci output
and that "pci=noioapicquirk" is a workaround makes me think that we
aren't using the 6702PXH IOAPIC and therefore we don't see boot
interrupts on this system.

So my guess is that we should not use the IRQ reroute feature on this
system, and I think that's what your patch accomplishes.  But I don't
understand the way you figure it out.  Looking for "entry->index == 0"
doesn't seem like an obvious connection.

[1] http://www.intel.com/content/dam/doc/datasheet/6700pxh-64-bit-pci-hub-datasheet.pdf

> Fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=43074
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/acpi/pci_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index c576a6f..6ecbde0 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -280,7 +280,7 @@ static int bridge_has_boot_interrupt_variant(struct pci_bus *bus)
>  static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
>  				       struct acpi_prt_entry *entry)
>  {
> -	if (noioapicquirk || noioapicreroute) {
> +	if (noioapicquirk || noioapicreroute || entry->index == 0) {
>  		return 0;
>  	} else {
>  		switch (bridge_has_boot_interrupt_variant(dev->bus)) {
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
