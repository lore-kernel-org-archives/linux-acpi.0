From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Fri, 18 Apr 2003 11:28:09 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476C2D0@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "Zink, Dan" <Dan.Zink-VXdhtT5mjnY@public.gmane.org>, "Mathiasen, Torben" <Torben.Mathiasen-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andy,

We're glad to be able to help.  On our implementations, this problem
showed up with ServerWorks CSB5 & CSB6 chipsets that have the USB
interrupt internally routed.  That design led to the use of dynamic PRT
entries for the USB (and maybe SCI) interrupts.

Cheers,
John

> -----Original Message-----
> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Friday, April 18, 2003 10:57 AM
> To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Zink, Dan; Mathiasen, Torben
> Subject: RE: [ACPI] mpparse.c APIC/ACPI support
>=20
>=20
> Super cool, thanks to you and Dan.
>=20
> I'm too jaded to think that this will fix all the various PCI=20
> routing problems on SMP systems, but I am optimistic that it=20
> should fix a sizeable percentage.
>=20
> Regards -- Andy
>=20
> > -----Original Message-----
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > Sent: Tuesday, April 15, 2003 12:54 PM
> > To: Grover, Andrew; info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Zink, Dan; Mathiasen, Torben
> > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> >=20
> >=20
> > Andy,
> >=20
> > Attached is a small patch that fixes the problem for dynamic
> > PRT entries.
> >=20
> > We have tested this (with your 2.4 bk kernel) and it works
> > perfectly. Please consider including this in your next update=20
> > to Marcelo & Linus for 2.4 and 2.5.
> >=20
> > Credit goes to Dan Zink for this patch.
> >=20
> > Thanks,
> > John
> >=20
> > > -----Original Message-----
> > > From: Cagle, John (ISS-Houston)
> > > Sent: Tuesday, April 15, 2003 2:41 AM
> > > To: Grover, Andrew; info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;
> > acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Zink, Dan; Mathiasen, Torben
> > > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> > >=20
> > >=20
> > > Andy,
> > >=20
> > > I couldn't easily test that code snippet, since it=20
> requires a lot of=20
> > > kernel changes to export mp_find_ioapic() and=20
> mp_ioapic_routing[].=20
> > > Also, mp_find_ioapic() has the __init attribute, and that=20
> would have=20
> > > to change too.
> > >=20
> > > Wouldn't this be better fixed when parsing the PRT in=20
> mpparse.c --=20
> > > handle the dynamic irqs along with the static irqs?
> > >=20
> > > Thanks,
> > > John
> > >=20
> > > > -----Original Message-----
> > > > From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > > > Sent: Monday, April 14, 2003 7:32 PM
> > > > To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> > > > acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Zink, Dan; Mathiasen, Torben
> > > > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> > > >=20
> > > > John,
> > > >=20
> > > > Take a look at pci_irq.c acpi_pci_irq_enable(). We should
> > be calling
> > > > this for all PCI devices, when they are enabled. We appear to be
> > > > doing the right thing in the PIC case (calling
> > > > eisa_set_level_irq) but not in the IO APIC case. I would
> > > > think something like:
> > > >=20
> > > > 	/*=20
> > > > 	 * Make sure all (legacy) PCI IRQs are set as=20
> level-triggered.
> > > > 	 */
> > > > 	if (acpi_ioapic)
> > > > 	{
> > > > 		int ioapic =3D mp_find_ioapic(irq);
> > > > 		int ioapic_pin =3D irq -
> > mp_ioapic_routing[ioapic].irq_start;
> > > > 		io_apic_set_pci_routing(ioapic,=20
> ioapic_pin, irq);
> > > > 	}
> > > > #ifdef CONFIG_X86
> > > > 	else if ((dev->irq < 16) &&  !((1 << dev->irq)=20
> & irq_mask)) {
> > > > 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d
> > > > as level-triggered\n", dev->irq));
> > > > 		irq_mask |=3D (1 << dev->irq);
> > > > 		eisa_set_level_irq(dev->irq);
> > > > 	}
> > > > #endif
> > > >=20
> > > > Totally untested. Thoughts? Do you have a system that we
> > can verify
> > > > a fix on?
> > > >=20
> > > > Regards -- Andy
> > > >=20
> > > >=20
> > > > > From: Cagle, John (ISS-Houston)
> > > [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org] What we
> > > > > have found is that the Linux ACPI code (from
> > > > > bitkeeper) is not properly configuring all PCI interrupts:
> > > > >=20
> > > > > In particular, mp_parse_prt() only calls
> > > > > io_apic_set_pci_routing() for *static* entries in the PRT. It
> > > > > doesn't do anything for dynamic entries in the PRT.  To be=20
> > > > > correct, mp_parse_prt() needs to call
> > > > > io_apic_set_pci_routing() for dynamic entries as well.
> > > > >=20
> > > > > For example, a PCI-USB interrupt which is routed to=20
> IRQ 7 by the=20
> > > > > BIOS, and which has a dynamic entry in the PRT would=20
> be left as=20
> > > > > edge-triggered by default (since IRQ 7 is one of the "legacy"=20
> > > > > interrupts).  This breaks USB interrupt handling (since
> > > it needs to
> > > > > be level triggered).
> > > > >=20
> > > > > ACPI Gurus -- Does this make sense, and is there some
> > reason that
> > > > > dynamic PRT entries aren't being handled?
> > > > >=20
> > > > > Thanks,
> > > > > John
> > > > > --------------------------------
> > > > > John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> > > > > Principal Member Technical Staff
> > > > >    Industry Standard Servers
> > > > >     Hewlett-Packard Company
> > > > >     http://www.hp.com/linux
> > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > > > > > Sent: Tuesday, March 04, 2003 12:21 PM
> > > > > > To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> > > > > > acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > > > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > > > > > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> > > > > >=20
> > > > > >=20
> > > > > > > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > > > > > > > In theory, ACPI comes through later and changes the
> > > > > irqs < 15 with
> > > > > > > > possible PCI devices by calling io_apic_set_pci_routing.
> > > > > > > >
> > > > > > > > So *in theory* it should work ok. Obviously something is
> > > > > > not right.
> > > > > > >=20
> > > > > > > How does ACPI, when it comes through later, know which
> > > > > > irq's < 15 are
> > > > > > > for PCI devices?
> > > > > >=20
> > > > > > The device's driver calls pci_enable_device, which calls:
> > > > > > pci_enable_device_bars, which calls:
> > > pcibios_enable_device, which
> > > > > > calls: pcibios_enable_irq, which is a function pointer
> > > we set to
> > > > > > acpi_pci_irq_enable, which does an=20
> eisa_set_level_irq(), thus=20
> > > > > > setting the interrupt (if less than 16) to level-triggered.
> > > > > >=20
> > > > > > So why isn't it working? Hmm.
> > > > > >=20
> > > > > > Regards -- Andy
> >=20
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
