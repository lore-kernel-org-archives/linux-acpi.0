From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Instability without ACPI and quirks
Date: 12 Jul 2003 04:25:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1057980324.1470.61.camel@darkstar.portugal>
References: <200307110022.29512.adq_dvb@lidskialf.net>
	<200307111356.22376.adq_dvb@lidskialf.net>
	<20030711140227.GF22636@poupinou.org>
	<200307111806.57883.adq_dvb@lidskialf.net>
	<20030711172639.GL22636@poupinou.org>
	<1057947446.1451.51.camel@darkstar.portugal>
	<20030711184648.GN22636@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030711184648.GN22636-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi thanks for replying=20
Results:
root@darkstar:~#/setpci -v -H1 -s 0:0.0 52
00:00.0:52 =3D eb
root@darkstar:~#setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -=
s 0:0.0 52) | 0x80)))
00:00.0:52 eb
root@darkstar:~#setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -=
s 0:0.0 52) & 0x7f)))
00:00.0:52 6b
root@darkstar:~#setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -=
s 0:0.0 52) | 0x80)))
00:00.0:52 eb

I don't resit to tell you, this doesn't do nothing !
so why 52 ?=20

I have a compaq presario 706EA
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 80)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)

Seems to be one KT133 but I am not sure,
This for me doesn't make sense every via chipset or every Athlons have a
rol of bugs, but for me the conclusion is:
Without acpi, we can put this kind of machine working correctly.=20
first because they are purely ACPI implementation ( the beginning of
implementation of ACPI in ordinary laptops? )  =20
Other thing is APIC, with someones APIC is disable by kernel, sometimes
we have to disable it and other time APIC seems to be detected but we
have problems with IRQ routing.
So many time I ask people to disable APIC no know if it work better or
if can resolve some problem, for me, is a test that I like to be
informed.
So I try to find out IRQ routing problems on my laptop (of course) and I
found one bunch of quirks, so my (not well proved) theory is that bunch
of quirks is to correct the problem of don't have ACPI.=20
Since now (happily) have ACPI in main kernel maybe we can begging
removing quirks from kernel.
I am testing (in my laptop) the first two removing quirks
quirk_via_acpi=20
quirk_vt82c686_acpi
this two applied are applied to 00:07.4 Apollo Super ACPI
after 4 days, nothing happens (everything works fine).
And now I am going for next two=20
this are applied to 00:07.5 VT82C686 AC97 Audio Controller and 00:07.2
USB Controller and is the same function in drivers/pci/quirks.c where
you can read :
 * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
 * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
 * when written, it makes an internal connection to the PIC.
 * For these devices, this register is defined to be 4 bits wide.
 * Normally this is fine.  However for IO-APIC motherboards, or
 * non-x86 architectures (yes Via exists on PPC among other places),
 * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
 * interrupts delivered properly.
 *
 * TODO: When we have device-specific interrupt routers,
 * quirk_via_irqpic will go away from quirks.


Thanks


On Fri, 2003-07-11 at 19:46, Ducrot Bruno wrote:
> On Fri, Jul 11, 2003 at 07:17:25PM +0100, S=E9rgio Monteiro Basto wrote:
> > On Fri, 2003-07-11 at 18:26, Ducrot Bruno wrote:
> > >=20
> > > You probably need acpi due to power states for the cpu.  Common probl=
em
> > > with laptop shipped with athlon in general (there is a tool called
> > > lvcool though if you do not have acpi).
> >=20
> > sounds cool
> > I have one athlon 4 on one KT133.
> > but after reading=20
> > http://cip.uni-trier.de/nofftz/linux/Athlon-Powersaving-HOWTO.html
> >=20
> > in 2.5
> > This is the only solution which does not use the ACPI system of the
> > Linux kernel.=20
>=20
> This one will do exactly what ACPI does (that is, in the main loop,
> read LVL2 register).  So the exact same issue will likely happens.
>=20
> ...
>=20
> > 2.1. The Command-line Hack
> > you can enable/disable the power-saving right from the command-line
> > without any need for rebooting.
> >=20
> > on KT133/133A, KX133, KL/KLE133, KM/KN133, ...:
> > enable: setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -s 0:=
0.0
> > 52) | 0x80)))
> > disable: setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -s
> > 0:0.0 52) & 0x7f)))=20
> >=20
> > How I know if it enable or disable ?
>=20
> setpci -H1 -s 0:0.0 52
> then look if bit 8 is set (enable) or not (disable).
>=20
> > is it safe try this commands?
>=20
> I don't know.
>=20
> --=20
> Ducrot Bruno
>=20
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps1
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
