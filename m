From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI vs. ISA IRQs
Date: Tue, 4 Nov 2003 23:30:22 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF8B@orsmsx401.jf.intel.com>
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Diefenbaugh, Paul S" <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Brown, Len=20
> I think the automatic fix would require ACPI to re-program the link
> device off an IRQ that is later requested by an ISA device...

Sounds good to me. I think this implies infrastructure that does not yet
exist. request_irq would have to do something like "if requested
interrupt is used but SA_SHIRQ, and the requestor is requesting it
unshared, move the current guys off it (call ACPI to reprogram links),
set it back to ISA trigger/polarity, and return success."

Ya?

Which then raises the question, can we reassign irqs under a device and
have things keep working? Or do we need to tell the driver its irq is
now different, possibly with interrupts disabled?

just rambling -- Andy

>=20
> -Len
>=20
> On Tue, 2003-11-04 at 18:28, Grover, Andrew wrote:
> > > From: Brown, Len=20
> > > Assumption: sharing interrupts is bad.
> >=20
> > It's not ideal, but it's not bad. PCI was designed to allow=20
> shared irqs.
> > IIRC we originally distributed IRQs, but we changed for exactly the
> > reason you describe below - ISA. (Paul correct me if I'm=20
> wrong.) And,
> > this is the default behavior on Windows (my T20 has 7=20
> devices on irq 11)
> > to better support docking.
> >=20
> > Sharing works OK as long as everyone doesn't take too long in their
> > ISRs, so that would be where I'd look first to make fixes,=20
> rather than
> > disturbing IRQ assignment. Plus, this problem goes away when IOAPIC
> > becomes the norm, doesn't it?
> >=20
> > my 2c -- Andy
> >=20
> > >=20
> > > Plan:
> > > ACPI should attempt to distribute interrupts across
> > > the available IRQs.
> > >=20
> > > This mostly applies to PIC mode, where PCI
> > > IRQ Link Devices are available to route PCI
> > > interrupts to open IRQs on the PIC.
> > > (In IO-APIC mode, we generally get no choice
> > >  which IO-APIC pins devices are attached to)
> > >=20
> > > We have acpi_irq_penalty[] (disabled at the moment)
> > > in pci_link.c hard-coded to tell ACPI to avoid some IRQs
> > > that are commonly used by ISA devices.
> > >=20
> > > But if,say, a sound-blaster card requests exclusive access
> > > to an IRQ that we didn't happen to reserve, and we happened
> > > to set a PCI link device to that IRQ, then sound doesn't
> > > work.
> > >=20
> > > How to fix?
> > >=20
> > > We can manually reserve IRQs to over-ride acpi_irq_penalty[],
> > > say "acpi_irq_used=3D5,10" to tell ACPI not to use IRQs that
> > > it thought by default were available.
> > >=20
> > > Conversely, we could us, say, "acpi_irq_free=3D3,15" to tell
> > > ACPI that some IRQs it assumed were reserved for ISA are
> > > actually available for PCI.
> > >=20
> > > I don't know of an automatic way to handle this.
> > > Seems that the ISA devices use Plug-and-Play methods
> > > to request IRQs, but there is no mechanism for such
> > > an event to boot a PIRQ off an IRQ if ACPI has put it there.
> > > Also, if such a mechanism existed, it wouldn't work
> > > if PNP were not available to ask for an IRQ.
> > >=20
> > > thoughts?
> > >=20
> > > thanks,
> > > -Len
> > >=20
> > > ref:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D430
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D1139
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D1391
> > >=20
> > >=20
> > >=20
> > >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?   SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
