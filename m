From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: ACPI with duff _PRT entries.. which solution to choose?
Date: Tue, 29 Jul 2003 17:10:25 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD1066108C5@cceexc19.americas.cpqcorp.net>
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
Cc: Daniel Jacobowitz <dan-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

That would be too much of a hack, considering it's an obvious BIOS bug.

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org]=20
> Sent: Tuesday, July 29, 2003 5:07 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Daniel Jacobowitz
> Subject: [ACPI] ACPI with duff _PRT entries.. which solution=20
> to choose?
>=20
>=20
>=20
> Hi, this board (dual-Pentium3 using an Abit motherboard) has=20
> duff entries in=20
> the _PRT for APIC mode. They are as follows:
>=20
>             Package(0x4) {
>                 0x0007ffff,
>                 0x0,
>                 0x0,
>                 \_SB_.PCI0.LNKA,
>             },
>=20
> Whereas they should be:
>=20
>             Package(0x4) {
>                 0x0007ffff,
>                 0x0,
>                 \_SB_.PCI0.LNKA,
>                 0x0,
>             },
>=20
> This could obviously be sorted by a workaround in the _PRT=20
> parsing code. What=20
> are peoples' opinions on this? Too much of a hack?
>=20
> Alternatively, this would be handled by my=20
> drop-back-to-PIC-mode code as the=20
> PIC _PRT entries are all fine.
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet
> _072303_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
