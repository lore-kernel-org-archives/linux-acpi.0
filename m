From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!
Date: Thu, 26 May 2005 15:46:31 -0600
Message-ID: <200505261546.31915.bjorn.helgaas@hp.com>
References: <20050525224328.734adc03.akpm@osdl.org> <20050526141021.61e3ca19.akpm@osdl.org> <20050526141605.53975890.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050526141605.53975890.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 26 May 2005 3:16 pm, Andrew Morton wrote:
> Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org> wrote:
> >
> > randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org> wrote:
> > >
> > >  On Thu, 26 May 2005 10:07:40 -0600 Bjorn Helgaas wrote:
> > > 
> > >  | On Wednesday 25 May 2005 11:43 pm, Andrew Morton wrote:
> > >  | > This IRQ routing bug appears to be an ACPI thing.  Could someone
> > >  | > please reassign it?
> > > 
> > >  I can do that, but Bjorn's patch makes it appear to be a PCI bug
> > >  rather than an ACPI bug.  Any clarification on that?
> > 
> > OK, let's leave it as-is.  Hopefulls Hannes can test that patch soon.
> 
> Uh, Bjorn has been playing games with email headers.  I meant this patch.

I did?  I'm bewildered.

> Hannes, if you could test this with 2.6.12-rc5-mm1, that would be really
> good.

There are three patches in the air:

    1) http://linux-acpi.bkbits.net:8080/26-latest-test/cset%404244603cD6KfNrnIjyYDqv0xzdI8cQ
       This replaces quirk_via_bridge() with quirk_via_irqpic().
       quirk_via_irqpic() does nothing unless we're in PIC mode.
       This has been in -mm for quite a while (as part of
       bk-acpi.patch).  It is not in 2.6.12-rc5, but Len
       promised to email it to Linus today.

    2) pci-do-via-irq-fixup-always-not-just-in-pic-mode.patch
       This makes quirk_via_irqpic() do its thing always, even
       in IOAPIC mode, and changes its name to quirk_via_irq().
       This was added to -mm just minutes ago (it's not in
       2.6.12-rc5-mm1).

    3) "quirk_via_irqpic() must not be __devinit for S1"
       This is from Alexander Nyberg on LKML today and removes
       __devinit from quirk_via_irqpic().  This should go
       into -mm as well, although it won't apply cleanly
       on top of 2) because of the rename.

So Hannes should test with 2.6.12-rc5-mm1.  If he is running in
IOAPIC mode, he may need patch 2) as well.  Patch 3 should be
irrelevant for his test.

> Bjorn, do you think we should generate a versus-2.6.12-rc5 version of this?

Assuming you're referring to the patch below, it depends on part 1)
above, which isn't in 2.6.12-rc5, so we can't.

> From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> At least some VIA chipsets require the fixup even in IO-APIC mode.
> 
> This was found and debugged with the patient assistance of Stian
> Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org> on an Asus CUV266-DLS motherboard.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  drivers/pci/quirks.c |   35 +++++++++++++----------------------
>  1 files changed, 13 insertions(+), 22 deletions(-)
> 
> diff -puN drivers/pci/quirks.c~pci-do-via-irq-fixup-always-not-just-in-pic-mode drivers/pci/quirks.c
> --- 25/drivers/pci/quirks.c~pci-do-via-irq-fixup-always-not-just-in-pic-mode	2005-05-26 14:14:15.000000000 -0700
> +++ 25-akpm/drivers/pci/quirks.c	2005-05-26 14:14:15.000000000 -0700
> @@ -467,17 +467,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SE
>  
>  
>  /*
> - * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
> - * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
> - * when written, it makes an internal connection to the PIC.
> - * For these devices, this register is defined to be 4 bits wide.
> - * Normally this is fine.  However for IO-APIC motherboards, or
> - * non-x86 architectures (yes Via exists on PPC among other places),
> - * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> - * interrupts delivered properly.
> - */
> -
> -/*
>   * FIXME: it is questionable that quirk_via_acpi
>   * is needed.  It shows up as an ISA bridge, and does not
>   * support the PCI_INTERRUPT_LINE register at all.  Therefore
> @@ -499,28 +488,30 @@ static void __devinit quirk_via_acpi(str
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
>  
> -static void __devinit quirk_via_irqpic(struct pci_dev *dev)
> +/*
> + * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
> + * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
> + * when written, it makes an internal connection to the PIC.
> + * For these devices, this register is defined to be 4 bits wide.
> + * Normally this is fine.  However for IO-APIC motherboards, or
> + * non-x86 architectures (yes Via exists on PPC among other places),
> + * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> + * interrupts delivered properly.
> + */
> +static void __devinit quirk_via_irq(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
>  
> -#ifdef CONFIG_X86_IO_APIC
> -	if (nr_ioapics && !skip_ioapic_setup)
> -		return;
> -#endif
> -#ifdef CONFIG_ACPI
> -	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
> -		return;
> -#endif
>  	new_irq = dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {
> -		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
> +		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
>  			pci_name(dev), irq, new_irq);
>  		udelay(15);	/* unknown if delay really needed */
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
>  
>  /*
>   * PIIX3 USB: We have to disable USB interrupts that are
> _
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
