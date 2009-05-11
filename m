From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/7] x86/pci: add 4 more return param in
	IO_APIC_get_PCI_irq_vector
Date: Mon, 11 May 2009 23:37:55 +0200
Message-ID: <20090511213755.GB21232@elte.hu>
References: <4A01C35C.7060207@kernel.org> <4A01C406.2040303@kernel.org> <20090511082834.GD5636@elte.hu> <4A087F35.2000903@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A087F35.2000903@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> @@ -1198,6 +1198,7 @@ int mp_register_gsi(struct device *dev,
>  {
>  	int ioapic;
>  	int ioapic_pin;
> +	struct io_apic_irq_attr io_apic_irq;

please call the variable name 'irq_attr' or so.

> +	io_apic_irq.ioapic = ioapic;
> +	io_apic_irq.ioapic_pin = ioapic_pin;
> +	io_apic_irq.trigger = (triggering == ACPI_EDGE_SENSITIVE ? 0 : 1);
> +	io_apic_irq.polarity = (polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
> +	io_apic_set_pci_routing(dev, gsi, &io_apic_irq);

I think we've been through this before :-/ Doesnt this:

	io_apic_irq.ioapic	= ioapic;
	io_apic_irq.ioapic_pin	= ioapic_pin;
	io_apic_irq.trigger	= (triggering == ACPI_EDGE_SENSITIVE ? 0 : 1);
	io_apic_irq.polarity	= (polarity == ACPI_ACTIVE_HIGH ? 0 : 1);

Look nicer?

Also, please do s/triggering/trigger

Thanks,

	Ingo
