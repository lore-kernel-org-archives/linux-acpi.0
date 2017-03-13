From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Sun, 12 Mar 2017 21:20:40 -0500
Message-ID: <20170313022040.GB8232@bhelgaas-glaptop.roam.corp.google.com>
References: <20170210114517.14812-1-sassmann@kpanic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933124AbdCMCUq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Mar 2017 22:20:46 -0400
Content-Disposition: inline
In-Reply-To: <20170210114517.14812-1-sassmann@kpanic.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@kpanic.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net

On Fri, Feb 10, 2017 at 12:45:17PM +0100, Stefan Assmann wrote:
> When checking for boot interrupts and PRT index is zero avoid doing
> any interrupt rerouting since the code currently does not handle
> determining the IRQ via _CRS method.
> 
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

I don't understand acpi_reroute_boot_interrupt() in general.

I think I understand the chipset functionality, i.e., the Intel
6700PXH contains two IOAPICs, each with 16 interrupt inputs, and if an
interrupt is asserted while that input is masked in the IOAPIC, the
6700PXH generates an INTx ASSERT message on the PCIe bus.

What I don't understand is what the "correct" way of handling this is.
I assume the intent was *not* that the OS should have device-specific
code to deal with this.

Is it a case of the BIOS doing something wrong?  Is ACPI just not
expressive enough to describe this hardware behavior?  

Bjorn
