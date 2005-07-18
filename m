From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
Date: Mon, 18 Jul 2005 09:15:52 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E021CB55A@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jared Jones <jared.jones-2fML+01oaiNBDgjK7y7TUQ@public.gmane.org>, Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

MLEN is probably in another table (an SSDT)

An external declaration for MLEN will allow the file to compile:

External (MLEN)


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Jared Jones
> Sent: Friday, July 15, 2005 11:39 PM
> To: Pavel Troller
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
>=20
> Hi,
>=20
>   MLEN is never defined in my DSDT.  It is only used once in the line
of
> the compile error.
>=20
> What does this line and section of code do?
> What bogus value can be used to define MLEN?
> Could this have anything to do with WOL?
>=20
> Thanks,
> Jared
>=20
>=20
> >> I am trying to debug two issues on my machine:
> >> 1) WOL not working in Linux; maybe ACPI screws it up
> >> 2) Poweroff only occurs when acpi=3Dforce in Linux kernel option
> >>
> >> So I wanted to check the machine's DSDT, which, go figure, was
compiled
> >> using the Microsoft compiler and fails with the Intel compiler.
Can
> >> anyone please assist me in editing the DSDT?  I have never done
this
> >> before.  Thanks!
> >>
> >>
> >> deskpro_en_dsdt.dsl   263:                 Add (MLEN, 0x00100000,
RAMT)
> >> Error    1022 -              Object does not exist ^  (MLEN)
> > Hi!
> >   Try to find the MLEN name using Your text editor. Does it occur
also
> at
> > another place than in the snippet below ? If yes, post it also
here...
> > There should be sometihng like Name (MLEN, 0x100) or whatever what
> defines
> > MLEN. If there isn't such a thing, I'm curious how the M$ compiler
can
> > compile this (maybe some internal symbol ?)
> >                                         With regards, Pavel Troller
> >>
> >>
> >> This line of code is from the following snippet of the DSDT:
> >>
> >>     Scope (\_SB)
> >>     {
> >>         Device (PCI0)
> >>         {
> >>             Name (_HID, EisaId ("PNP0A03"))
> >>             Name (_ADR, 0x00)
> >>             Name (CRES, ResourceTemplate ()
> >>             {
> >>
> >>             ... a bunch of other code regarding addresses ...
> >>
> >>             Method (_CRS, 0, NotSerialized)
> >>             {
> >>                 CreateDWordField (CRES, 0x76, RAMT)
> >>                 CreateDWordField (CRES, 0x82, PCIT)
> >>                 Add (MLEN, 0x00100000, RAMT)
> >>                 Subtract (0xFFE00000, RAMT, PCIT)
> >>                 Return (CRES)
> >>             }
> >>
> >
> >
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. =
http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
