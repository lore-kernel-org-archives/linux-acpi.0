From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPICA 20031002 released
Date: Fri, 10 Oct 2003 13:01:41 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC878C@hdsmsx402.hd.intel.com>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yes, this was stray copy paste error from the ACPICA release notes.
(it isn't included in the check-in comments).

I'd like to have a scheme set up to automatically track the size of
the ACPI code as built with gcc in Linux...

-Len

> -----Original Message-----
> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]=20
> Sent: Tuesday, October 07, 2003 6:57 AM
> To: Brown, Len
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPICA 20031002 released
>=20
>=20
> Hi!
>=20
> > Code and Data Size: Current and previous core subsystem=20
> library sizes
> > are shown below.  These are the code and data sizes for the=20
> acpica.lib
>=20
> They are not :-(.
>=20
> > produced by the Microsoft Visual C++ 6.0 compiler, and=20
> these values do
> > not include any ACPI driver or OSPM code.  The debug=20
> version of the code
> > includes the debug output trace mechanism and has a much=20
> larger code and
> > data size.  Note that these values will vary depending on=20
> the efficiency
> > of the compiler and the compiler options used during generation.
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
> --=20
> 				Pavel
> Written on sharp zaurus, because my Velo1 broke. If you have=20
> Velo you don't need...
>=20
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
