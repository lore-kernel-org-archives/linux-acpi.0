From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Discussion: ACPI selective IRQ blacklist
Date: Wed, 3 Sep 2003 18:19:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D3720017304AF00@scsmsx402.sc.intel.com>
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
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I think acpi-picmode is reasonable and probably it would work more
reliably compared with APIC mode, but the behavior is triggered by
"noapic" (i.e. boot parameter). It was broken for ACPI, but Len has
fixed it.=20

Which VIA motherboards should be listed in the blacklist?

Thanks,
Jun

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org]
> Sent: Wednesday, September 03, 2003 3:16 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: linux-acpi
> Subject: Discussion: ACPI selective IRQ blacklist
>=20
> Hi, I've been looking into this VIA ACPI issue some more. From various
> reports, if you disable ACPI, the standard linux PCI IRQ routing
system is
> able to correctly set up the board.
>=20
> Some VIA motherboards DO work correctly in ACPI APIC mode however.
These
> boards have the APIC IRQ settings hardwired (i.e. they do not use link
> devices).
>=20
> The problem comes when the BIOS does use link devices. These will work
> fine in
> PIC mode. However, in APIC mode, the AML code is wrong in several
respects
> in
> lots of BIOSes:
>=20
> 1) The _SRS method can only cope with IRQs <=3D 15, yet the BIOS =
returns
> IRQs >
> 15 in the _PRS method.
>=20
> 2) The _CRS method is hardcoded to return 0 ALWAYS for link devices in
> APIC
> mode.
>=20
> The above means we cannot use the AML code for setting APIC IRQ
devices on
> many VIA motherboards.
>=20
> My new patch (acpi-picmode) should mean the boards are functional...
just
> that
> they do not take advantage of any APIC/IO-APIC present.
>=20
> I looked into trying to fall back to the non-ACPI PCI IRQ routing
code.
> Its
> not really feasible: ACPI does an awful lot of setup before setting up
the
> link devices, which it is not really possible to undo without lots of
pain.
>=20
> My suggestion is I expand the current ACPI blacklist to have a field
> specifying whether ACPI PCI routing can be relied upon.
>=20
> Using the current blacklisting (which disables ACPI completely) on
masses
> of
> VIA motherboards is not really an option IMO.
>=20
> So:
> If a motherboard is dodgy and IS in the bad-routing-blacklist, ACPI
will
> not
> be used for PCI routing.
>=20
> If a motherboard is dodgy and is NOT in the bad-routing-blacklist, the
> fallback to picmode code should catch it. If the user then wants APIC
with
> ACPI, they report the issue and the board is added to the
> bad-routing-blacklist.
>=20
> What do people think? This is the best solution I can come up for this
> problem
> that would not involve a large messy error-prone change.
>=20
>=20
> I'm gonna start implementing this.. but I'd appreciate feedback on
this
> idea.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
