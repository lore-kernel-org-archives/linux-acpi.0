From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Mon, 14 Apr 2003 17:31:40 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A264@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "Zink, Dan" <Dan.Zink-VXdhtT5mjnY@public.gmane.org>, "Mathiasen, Torben" <Torben.Mathiasen-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

John,

Take a look at pci_irq.c acpi_pci_irq_enable(). We should be calling
this for all PCI devices, when they are enabled. We appear to be doing
the right thing in the PIC case (calling eisa_set_level_irq) but not in
the IO APIC case. I would think something like:

	/* 
	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
	 */
	if (acpi_ioapic)
	{
		int ioapic = mp_find_ioapic(irq);
		int ioapic_pin = irq -
mp_ioapic_routing[ioapic].irq_start;
		io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
	}
#ifdef CONFIG_X86
	else if ((dev->irq < 16) &&  !((1 << dev->irq) & irq_mask)) {
		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d as
level-triggered\n", dev->irq));
		irq_mask |= (1 << dev->irq);
		eisa_set_level_irq(dev->irq);
	}
#endif

Totally untested. Thoughts? Do you have a system that we can verify a
fix on?

Regards -- Andy


> From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org] 
> What we have found is that the Linux ACPI code (from 
> bitkeeper) is not properly configuring all PCI interrupts:
> 
> In particular, mp_parse_prt() only calls 
> io_apic_set_pci_routing() for *static* entries in the PRT.  
> It doesn't do anything for dynamic entries in the PRT.  To be 
> correct, mp_parse_prt() needs to call 
> io_apic_set_pci_routing() for dynamic entries as well.
> 
> For example, a PCI-USB interrupt which is routed to IRQ 7 by 
> the BIOS, and which has a dynamic entry in the PRT would be 
> left as edge-triggered by default (since IRQ 7 is one of the 
> "legacy" interrupts).  This breaks USB interrupt handling 
> (since it needs to be level triggered).
> 
> ACPI Gurus -- Does this make sense, and is there some reason 
> that dynamic PRT entries aren't being handled?
> 
> Thanks,
> John
> --------------------------------
> John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> Principal Member Technical Staff
>    Industry Standard Servers
>     Hewlett-Packard Company
>     http://www.hp.com/linux
> 
> > -----Original Message-----
> > From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > Sent: Tuesday, March 04, 2003 12:21 PM
> > To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org; 
> > acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> > 
> > 
> > > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > > > In theory, ACPI comes through later and changes the 
> irqs < 15 with 
> > > > possible PCI devices by calling io_apic_set_pci_routing.
> > > >
> > > > So *in theory* it should work ok. Obviously something is
> > not right.
> > > 
> > > How does ACPI, when it comes through later, know which
> > irq's < 15 are
> > > for PCI devices?
> > 
> > The device's driver calls pci_enable_device, which calls:
> > pci_enable_device_bars, which calls: pcibios_enable_device, 
> > which calls: pcibios_enable_irq, which is a function pointer 
> > we set to acpi_pci_irq_enable, which does an 
> > eisa_set_level_irq(), thus setting the interrupt (if less 
> > than 16) to level-triggered.
> > 
> > So why isn't it working? Hmm.
> > 
> > Regards -- Andy
> > 
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
