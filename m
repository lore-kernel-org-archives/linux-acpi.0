From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Mon, 14 Apr 2003 18:24:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E4A0@cceexc19.americas.cpqcorp.net>
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

Sorry to revive an old thread, but it took us a while to root-cause
this.

What we have found is that the Linux ACPI code (from bitkeeper) is not
properly configuring all PCI interrupts:

In particular, mp_parse_prt() only calls io_apic_set_pci_routing() for
*static* entries in the PRT.  It doesn't do anything for dynamic entries
in the PRT.  To be correct, mp_parse_prt() needs to call
io_apic_set_pci_routing() for dynamic entries as well.

For example, a PCI-USB interrupt which is routed to IRQ 7 by the BIOS,
and which has a dynamic entry in the PRT would be left as edge-triggered
by default (since IRQ 7 is one of the "legacy" interrupts).  This breaks
USB interrupt handling (since it needs to be level triggered).

ACPI Gurus -- Does this make sense, and is there some reason that
dynamic PRT entries aren't being handled?

Thanks,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux

> -----Original Message-----
> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Tuesday, March 04, 2003 12:21 PM
> To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Subject: RE: [ACPI] mpparse.c APIC/ACPI support
>=20
>=20
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > > In theory, ACPI comes through later and changes the irqs < 15
> > > with possible PCI devices by calling io_apic_set_pci_routing.
> > >
> > > So *in theory* it should work ok. Obviously something is=20
> not right.
> >=20
> > How does ACPI, when it comes through later, know which=20
> irq's < 15 are=20
> > for PCI devices?
>=20
> The device's driver calls pci_enable_device, which calls:=20
> pci_enable_device_bars, which calls: pcibios_enable_device,=20
> which calls: pcibios_enable_irq, which is a function pointer=20
> we set to acpi_pci_irq_enable, which does an=20
> eisa_set_level_irq(), thus setting the interrupt (if less=20
> than 16) to level-triggered.
>=20
> So why isn't it working? Hmm.
>=20
> Regards -- Andy
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
