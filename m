From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix IRQ / GPEs restore on wake
Date: Tue, 20 Apr 2004 14:07:53 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05571657B@orsmsx403.amr.corp.intel.com>
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
To: eric.valette-GANU6spQydw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The next version of ACPI CA will better manage wake vs. run vs. wake/run
GPEs and may handle this correctly without the change below.

Bob


> -----Original Message-----
> From: Eric Valette [mailto:eric.valette-GANU6spQydw@public.gmane.org]
> Sent: Tuesday, April 20, 2004 1:53 PM
> To: Moore, Robert
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew; Brown, Len;
Karol
> Kozimor; a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org
> Subject: Re: [ACPI] [PATCH] fix IRQ / GPEs restore on wake
>=20
> Moore, Robert wrote:
> > Please explain the reasoning behind this change.
> >
> > It looks as though you want to enable the runtime GPEs before
executing
> > _SST, _BFS, and _WAK.  Is this correct?  Why?
> >
> > Bob
>=20
> First sorry for the message : I did not intend to post it to the list.
I
> was editing (mozilla edit as new) original Karol Kozimor message to
this
> list containing this exact patch to apply it on my ASUS L3800C
(because
> mailer though the diff was a signature) and hit sent button by error.
>=20
> But anyway, this patch enables to get ACPI interrupts after resuming
> from S3. Without this patch, after _sucessfully_ resuming from S3, I
get
> no more events for ACPI buttons (except power button).
>=20
> Get more info at <http://bugme.osdl.org/show_bug.cgi?id=3D2321>
>=20
> This patch is not from me but from Alexander Malysh
> <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org> so maybe he could explain it better than me.
>=20
> I just can say it _indeed_ works...
>=20
> -- eric


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
