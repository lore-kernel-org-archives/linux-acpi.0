From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi=off & /proc entries
Date: Fri, 16 May 2003 10:49:50 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96E96@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
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
To: =?iso-8859-2?Q?Zdenek_OGAR_Skal=E1k?= <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Looks good. Thanks, Zdenek.

> -----Original Message-----
> From: Zdenek OGAR Skal=E1k [mailto:skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org]=20
> Sent: Friday, May 16, 2003 2:19 AM
> Cc: Grover, Andrew; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] acpi=3Doff & /proc entries
>=20
>=20
>=20
> Hi,
>=20
> 	here is small simple patch :-) It's against=20
> acpi-20030512-2.4.21-rc2.
>=20
> 	It prevents ACPI modules (button, ...) to register=20
> itself & create /proc
> entries, when acpi is disabled through acpi=3Doff.=20
>=20
> 	Because bus.c uses acpi_disabled variable set by=20
> acpi=3Doff, it doesn't register
> /proc/acpi directory & module later registers (in his __init)=20
> it's /proc entry
> just in /proc (/proc/button, ...).
>=20
> 	This simply returns -ENODEV if acpi_disabled & when=20
> module tries to register
> via acpi_bus_register_driver (in bus.c) & as a consequence,=20
> module removes his
> /proc entry :-)
>=20
> 	Bye
> 		Zdenek OGAR Skalak
> --=20
> Ing. Zden=ECk OGAR Skal=E1k
> Monet+ a.s.
> Z=E1meck=E1 365
> 763 14 Zl=EDn - =A9t=EDpa, CZ
> Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557
>=20


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
