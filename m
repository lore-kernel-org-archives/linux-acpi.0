From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 4 Feb 2009 16:28:00 +0100
Message-ID: <200902041628.03675.elendil@planet.nl>
References: <4989A784.3030604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757260AbZBDP2Z@vger.kernel.org>
In-reply-To: <4989A784.3030604@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, len.brown@intel.com, shaohuhua.li@intel.com, kristen.c.accardi@intel.com, frank@f-seidel.de, fseidel@suse.de
List-Id: linux-acpi@vger.kernel.org

Frank Seidel wrote:
> +++ b/drivers/acpi/pci_link.c
> @@ -593,7 +593,7 @@ static int acpi_pci_link_allocate(struct
>                 return -ENODEV;
>         } else {
>                 acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
> -               printk(PREFIX "%s [%s] enabled at IRQ %d\n",
> +               printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>                 acpi_device_name(link->device),
>                 acpi_device_bid(link->device), link->irq.active);
>         }
> @@ -751,21 +751,21 @@ static int acpi_pci_link_add(struct acpi
>         acpi_device_bid(device));
>         for (i = 0; i < link->irq.possible_count; i++) {
>                 if (link->irq.active == link->irq.possible[i]) {
> -                       printk(" *%d", link->irq.possible[i]);
> +                       printk(KERN_INFO " *%d", link->irq.possible[i]);
>                         found = 1;
>                 } else
> -                       printk(" %d", link->irq.possible[i]);
> +                       printk(KERN_INFO " %d", link->irq.possible[i]);
>         }
> 
> -       printk(")");
> +       printk(KERN_INFO ")");
> 
>         if (!found)
> -               printk(" *%d", link->irq.active);
> +               printk(KERN_INFO " *%d", link->irq.active);
> 

This patch looks broken to me, at least for some of your changes.
For example, in the bit quoted above all printks together make up
*one single* message, which means that only the _first_ of the
printks should have the KERN_* prefix. printks that are continuations
should not have the prefix.

Cheers,
FJP
