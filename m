From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/7] x86/pci: add 4 more return param in
	IO_APIC_get_PCI_irq_vector
Date: Mon, 11 May 2009 10:28:34 +0200
Message-ID: <20090511082834.GD5636@elte.hu>
References: <4A01C35C.7060207@kernel.org> <4A01C406.2040303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A01C406.2040303@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> +int IO_APIC_get_PCI_irq_vector(int bus, int slot, int pin,
> +				int *ioapic, int *ioapic_pin,
> +				int *trigger, int *polarity)

>  		if (io_apic_assign_pci_irqs) {
>  			int irq;
> +			int ioapic = -1, ioapic_pin = -1;
> +			int triggering, polarity;

please put this into a helper function/inline.

>  
> -			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin - 1);
> +			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
> +						PCI_SLOT(dev->devfn),
> +						pin - 1,
> +						&ioapic, &ioapic_pin,
> +						&triggering, &polarity);
>  			/*
>  			 * Busses behind bridges are typically not listed in the MP-table.
>  			 * In this case we have to look up the IRQ based on the parent bus,
> @@ -1235,7 +1248,10 @@ static int pirq_enable_irq(struct pci_de
>  
>  				pin = pci_swizzle_interrupt_pin(dev, pin);
>  				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number,
> -						PCI_SLOT(bridge->devfn), pin - 1);
> +						PCI_SLOT(bridge->devfn),
> +						pin - 1,
> +						&ioapic, &ioapic_pin,
> +						&triggering, &polarity);
>  				if (irq >= 0)
>  					dev_warn(&dev->dev, "using bridge %s "
>  						 "INT %c to get IRQ %d\n",

That function has way too many parameters. Please introduce a helper 
structure (struct io_apic_irq_attr) where the parameters can be 
passed along in a clean and short fashion. We update them by 
reference anyway.

I've applied the patch, but we need these cleanups too, the code has 
become too ugly.

	Ingo
