From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Thu, 17 Mar 2005 09:33:37 +0800
Message-ID: <1111023217.15278.7.camel@sli10-desk.sh.intel.com>
References: <1110989436.8378.19.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110989436.8378.19.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Thu, 2005-03-17 at 00:10, Bjorn Helgaas wrote:
> On Tue, 2005-03-15 at 16:02 -0700, Zwane Mwaikambo wrote:
> > On Tue, 15 Mar 2005, Bjorn Helgaas wrote:
> > > That seems awfully suspicious to me.  So the following is
> > > probably safe as far as it goes, but not sufficient for all
> > > cases.
> > 
> > VIA bridges allow for IRQ routing updates by programming 
> > PCI_INTERRUPT_LINE, so it is supposed to work even if we do it for
> all the 
> > devices, so it appears to be a board/bios specific problem.
> 
> This just feels like a sledgehammer approach, i.e., we're
> programming PCI_INTERRUPT_LINE in more cases that we actually
> need to.  I especially don't like that any Via device with
> devfn==0 triggers the quirk.  That doesn't seem like the
> right test if we're really looking for a Via bridge.
> 
> > > -static void __devinit quirk_via_bridge(struct pci_dev *pdev)
> > > +static void __devinit quirk_via_irqpic(struct pci_dev *dev)
> > >  {
> > > -   if(pdev->devfn == 0) {
> > > -           printk(KERN_INFO "PCI: Via IRQ fixup\n");
> > > -           via_interrupt_line_quirk = 1;
> > > +   u8 irq, new_irq = dev->irq & 0xf;
> > > +
> > > +   pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> > > +   if (new_irq != irq) {
> > > +           printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d
> to %d\n",
> > > +                   pci_name(dev), irq, new_irq);
> > > +           udelay(15);
> > > +           pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> new_irq);
> > >     }
> > >  }
> > > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,       
> PCI_ANY_ID,                     quirk_via_bridge );
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irqpic);
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irqpic);
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C686_6, quirk_via_irqpic);
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_8233_5,   quirk_via_irqpic);
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_8233_7,   quirk_via_irqpic);
> > 
> > This looks like it'll only affect the PCI device associated with the
> > listed south bridges, which might break systems which relied on the
> per 
> > device setting. Your 'debug' patch actually made sense to me, that
> is, 
> > moving the PCI_INTERRUPT_LINE fixup at gsi register.
> 
> Yes, that's what I meant by the above probably not being sufficient.
> 
> The main thing the debug patch did was to move the write to after
> the IOAPIC programming.  (And I think it added back the mysterious
> udelay().)  My point is that the write could just as easily be done
> in a pci_enable fixup, because that also happens after the IOAPIC
> update.
The comments in previous quirk said it's required only in PIC mode.

> 
> The quirk would have to be something like this:
> 
>         static void __devinit quirk_via_irq(struct pci_dev *dev)
>         {
>                 if  (!via_interrupt_line_quirk)
>                         return;
> 
>                 /* update PCI_INTERRUPT_LINE */
>                 ...
>         }
>         DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
> quirk_via_irq);
> 
> with a PCI_FIXUP_HEADER quirk that sets via_interrupt_line_quirk when
> we find a Via bridge.
> 
> But I'm uneasy even about this -- what if there are multiple bridges,
> with only one of them being a Via?  Why would we want to apply this
> quirk to the devices under the non-Via bridges?  Wouldn't it be better
> to search up the hierarchy of each device, looking for a Via bridge,
> and apply the quirk only if we find one?
I feel we concerned too much. Changing the interrupt line isn't harmful,
right? Linux actually ignored interrupt line. Maybe just a
PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq) is
sufficient.
and 
quirk_via_irq(..)
{
	update_interrupt_line
}

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
