From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fix wake GPE enabling
Date: Fri, 9 Apr 2004 15:12:36 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0554F231C@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Masanori Kanaoka <kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org>
Cc: kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org, linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Actually, the LID _GPE code:

            If(\_SB_.MEM_.GP71) {
                Store(0x0, \_SB_.MEM_.GP71)
                Notify(\_SB_.LID_, 0x80)

Looks similar to the example in the ACPI spec, which (in addition to the
"Control Method Power Button") seems to show the use of GPEs as both
wake and runtime events.

Something very fishy here.

I am consulting with the ACPI specification gurus.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Moore, Robert
> Sent: Friday, April 09, 2004 9:57 AM
> To: Masanori Kanaoka
> Cc: kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org; linux@dominikbrodowski.de; Brown, Len; acpi-
> devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> Subject: RE: [ACPI] Fix wake GPE enabling
>=20
> GPE 09 with _L09 looks OK, it is clearly a wake GPE (because all the
> Notify statements within it are of the form Notify(XXXX, 2) -- 2 means
> "wake".
>=20
> GPE 1A appears to be a runtime GPE, therefore the _PWR method under
_LID
> looks suspicious.
>=20
> Bob
>=20
>=20
> > -----Original Message-----
> > From: Masanori Kanaoka [mailto:kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org]
> > Sent: Friday, April 09, 2004 3:11 AM
> > To: Moore, Robert
> > Cc: kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org; linux@dominikbrodowski.de; Brown, Len; acpi-
> > devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> > Subject: Re: [ACPI] Fix wake GPE enabling
> >
> > Hi
> >
> >        From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >     Subject: RE: [ACPI] Fix wake GPE enabling
> >       Date : Thu, 08 Apr 2004 09:32:35 -0700
> >  Message-ID:
> >
<37F890616C995246BE76B3E6B2DBE0554F1A3B-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
> >
> > $ Found something in the ACPI Specification:
> >
> > $ Section 5.6.2.2.1, "Wake Events" (Under "General-Purpose Event
> Handling)
> >
> > $ "Events that wake may not be intermixed with non-wake events on
the
> same
> > $ GPE input. Also, all wake events not exclusively tied to a GPE
input
> > $ (for example, one input is shared for multiple wake events) need
to
> have
> > $ individual enable and status bits in order to properly handle the
> > $ semantics used by the system."
> >
> > $ Bob
> >
> > I found same section in ACPI-2.0a.pdf(20020331).
> >
> > On My TOSHIBA Libretto L3,
> >   - _GPE has two Methods(_L09 and _L1A).
> >   - USB1,ASND,LAN_ and CBC0 have _PWR that a first element is 0x09.
> >   - _LID has _PWR that a first element is 0x1A.
> >   - _GPE notify some devices(include _LID) via _L1A.
> >
> > Is it broken?
> > TOSHIBA Libretto L1, L2 seem same.
> >
> > You can find My LibrettoL3.asl and .dsdt file at:
> >   http://www.ann.hi-ho.ne.jp/~kanaoka/librettoL3.{asl,dsdt}
> >
> > and also find LibrettoL1/L2's file at:
> >   http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L1-
> > 060TNMM.asl?cvsroot=3Dfreebsd-jp
> >   http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L1-
> > 060TNMM.dsdt?cvsroot=3Dfreebsd-jp
> >   http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L2-
> > 060TNML.asl?cvsroot=3Dfreebsd-jp
> >   http://www.jp.freebsd.org/cgi/cvsweb.cgi/ACPI/data/Libretto-L2-
> > 060TNML.dsdt?cvsroot=3Dfreebsd-jp
> >
> > If it is broken, How can I avoid this problem ?
> > Any suggestions ?
> >
> > Best Regards
> > ---
> >  Masanori Kanaoka	kanaoka-Y4eNCM2L5QUzdwRXePBTQw@public.gmane.org
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
