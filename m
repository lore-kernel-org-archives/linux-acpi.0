From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Thu, 16 Feb 2017 00:41:12 +0100
Message-ID: <2535666.fX06JoOfin@aspire.rjw.lan>
References: <20170210114517.14812-1-sassmann@kpanic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62880 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755390AbdBOXqP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Feb 2017 18:46:15 -0500
In-Reply-To: <20170210114517.14812-1-sassmann@kpanic.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@kpanic.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Linux PCI <linux-pci@vger.kernel.org>

[+Bjorn, linux-pci]

On Friday, February 10, 2017 12:45:17 PM Stefan Assmann wrote:
> When checking for boot interrupts and PRT index is zero avoid doing
> any interrupt rerouting since the code currently does not handle
> determining the IRQ via _CRS method.
> 
> Fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=43074
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Bjorn, what do you think?

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
> 

