From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Wed, 11 Feb 2004 19:37:16 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB6A1@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> On Wed, Feb 11, 2004 at 10:19:22AM +0800, Yu, Luming wrote:
> > > > Some processors seems to support only C1 and C3 states, for=20
> > > instance... mine ;-)
> > > > (Pentium III Coppermine). The problem is that, in this=20
> > > case, no promotion or
> > > > demotion are linking those two states, therefore the=20
> > > preocessor never goes to C3!
> > > >=20
> > >=20
> > > There is no intel-like processors for which there is C3, but=20
> > > no C2.  So
> > > you have actually to fake a C2 (which should be at a latency=20
> > > of 30 IIRC).
> > >=20
> >=20
> > I'm not sure a faking C2 can work as expected, because
> > C2 power state is an optional ACPI clock state that needs=20
> > chipset hardware support. (ACPI spec 2.0b  8.1.3)
> >=20
>=20
> We are talking about a PIII Coppermine that need to be put in sleep
> mode (C2) before deep sleep (C3).

According to ACPI spec, entering  C2 needs chipset hardware support.
So it is possible that only C1 and C3 get supported, despite CPU=20
can support C1 , C2, and C3.=20

--Luming


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
