From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH V6] acpi: add support for extended IRQ to PCI link
Date: Mon, 30 Nov 2015 14:38:23 -0600
Message-ID: <20151130203823.GC29242@localhost>
References: <1448477558-12310-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57962 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbbK3Ui1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 15:38:27 -0500
Content-Disposition: inline
In-Reply-To: <1448477558-12310-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Wed, Nov 25, 2015 at 01:52:38PM -0500, Sinan Kaya wrote:
> The ACPI compiler uses the extended format when used interrupt numbers
> are greater than 256. The extended IRQ numbers use 32 bits for storing
> interrupts. The code already supports parsing extended IRQ type but is
> limited by 256 due to used data structure type (u8). This patch changes
> the interrupt number type to 32 bits and places an upper limit of 1020
> as possible interrupt id. 1020 is the maximum interrupt ID that can be
> assigned to an ARM SPI interrupt according to ARM architecture.
> 
> Additional checks have been placed to return an error when ACPI_MAX_IRQS
> is exceeded.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

I don't think the description is quite accurate -- I think the
extended IRQ descriptor is required for IRQs of *16* and greater, not
IRQs greater than 256.  Here's how I understand it:

  The ACPI IRQ Descriptor contains a 16-bit mask with a bit for each
  IRQ, so it can describe interrupt numbers in the range [0-15].
  Interrupt numbers greater than 15 must be described with an Extended
  IRQ Descriptor, which contains a table of 32-bit interrupt numbers
  and can describe interrupt numbers in the range [0-(2^32-1)].  See
  ACPI 5.0, sections 6.4.2.1 and 6.4.3.6.

> ---
>  drivers/acpi/pci_link.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 7c8408b..5ab83dc 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -4,6 +4,7 @@
>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>   *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
> + *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *
> @@ -47,6 +48,14 @@ ACPI_MODULE_NAME("pci_link");
>  #define ACPI_PCI_LINK_FILE_STATUS	"state"
>  #define ACPI_PCI_LINK_MAX_POSSIBLE	16
>  
> +/*
> + * 1020 is the maximum interrupt ID that can be assigned to
> + * an ARM SPI interrupt according to ARM architecture.
> + */
> +#define ACPI_MAX_IRQS		1020
> +#define ACPI_MAX_ISA_IRQ	16

ACPI_MAX_IRQS is only used to size the acpi_irq_penalty[] table (and
after your patch, to validate IRQ numbers from ACPI).  But I think the
acpi_irq_penalty[] table is a design we've outgrown.  I *think* we
only care about penalties for IRQs 0-15, so even a 256-entry table is
more than we need.

If we could make acpi_irq_penalty[] a fixed size of 16 entries or
replace it with a linked list, I think we could get rid of
ACPI_MAX_IRQS completely.  Then the validation checks you add below
would be unnecessary and we could handle any interrupt number supplied
from ACPI.

Bjorn

> +
> +
>  static int acpi_pci_link_add(struct acpi_device *device,
>  			     const struct acpi_device_id *not_used);
>  static void acpi_pci_link_remove(struct acpi_device *device);
> @@ -67,12 +76,12 @@ static struct acpi_scan_handler pci_link_handler = {
>   * later even the link is disable. Instead, we just repick the active irq
>   */
>  struct acpi_pci_link_irq {
> -	u8 active;		/* Current IRQ */
> +	u32 active;		/* Current IRQ */
>  	u8 triggering;		/* All IRQs */
>  	u8 polarity;		/* All IRQs */
>  	u8 resource_type;
>  	u8 possible_count;
> -	u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
> +	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>  	u8 initialized:1;
>  	u8 reserved:7;
>  };
> @@ -147,6 +156,13 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
>  					       p->interrupts[i]);
>  					continue;
>  				}
> +				if (p->interrupts[i] >= ACPI_MAX_IRQS) {
> +					dev_warn(&link->device->dev,
> +						"Ignoring IRQ(%d) as it exceeds max(%d)\n",
> +						p->interrupts[i],
> +						ACPI_MAX_IRQS - 1);
> +					continue;
> +				}
>  				link->irq.possible[i] = p->interrupts[i];
>  				link->irq.possible_count++;
>  			}
> @@ -279,6 +295,12 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
>  		result = -ENODEV;
>  	}
>  
> +	if (irq >= ACPI_MAX_IRQS) {
> +		dev_err(&link->device->dev,
> +			"Ignoring IRQ(%d) as it exceeds max(%d)\n",
> +			irq,  ACPI_MAX_IRQS - 1);
> +		result = -ENODEV;
> +	}
>  	link->irq.active = irq;
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
> @@ -437,9 +459,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>   * enabled system.
>   */
>  
> -#define ACPI_MAX_IRQS		256
> -#define ACPI_MAX_ISA_IRQ	16
> -
>  #define PIRQ_PENALTY_PCI_AVAILABLE	(0)
>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
>  #define PIRQ_PENALTY_PCI_USING		(16*16*16)
> -- 
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
