From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI -- Workaround for broken DSDT
Date: Wed, 11 Feb 2004 14:31:54 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB695@PDSMSX403.ccr.corp.intel.com>
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
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  To AML issue, I think we should sort out interpreter bug , not just
hack DSDT.

--Luming

> We're doing something slightly different with ACPI on FreeBSD.  We add
> hacks^Wworkarounds for buggy DSDT whenever possible but they=20
> are under a
> kernel option, #ifndef ACPICA_PEDANTIC.  The default is for=20
> this option to
> give maximum compatibility with the stock DSDT, at the expense of spec
> correctness.  However, by adding that option and compiling a=20
> kernel, OEMs
> could test against ACPI-CA as a reference implementation=20
> while ordinary
> users get maximum compatibility.
>=20
> I think the ACPI-CA developers should take a similar tact. =20
> Len, who is on
> the Linux side, could suggest distribution maintainers use=20
> the option that
> gives maximum Windows compatibility when shipping a distro. =20
> Bob, who is
> on the ACPI-CA side, could encourage OEMs to test with the option
> disabled.  It might even make sense for a Linux distro maintainer to
> partner with ACPI-CA to provide a reference ISO that OEMs=20
> could boot that
> had a /sbin/init that tests the various APIs for correctness.=20
>  Both Andy
> and I thought this was a good direction to go and perhaps people are
> already making progress in that area.
>=20


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
