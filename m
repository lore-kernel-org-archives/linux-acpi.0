From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: ACPI with duff _PRT entries.. which solution to choose?
Date: 30 Jul 2003 00:47:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1059522478.1752.13.camel@darkstar.portugal>
References: <200307292307.06211.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307292307.06211.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Daniel Jacobowitz <dan-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-07-29 at 23:07, Andrew de Quincey wrote:
>=20
> Hi, this board (dual-Pentium3 using an Abit motherboard) has duff entries=
 in=20
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
> This could obviously be sorted by a workaround in the _PRT parsing code. =
What=20
> are peoples' opinions on this? Too much of a hack?
>=20
> Alternatively, this would be handled by my drop-back-to-PIC-mode code as =
the=20
> PIC _PRT entries are all fine.
>=20
To be honest I don't understand much, what you are talking about.
but I vote in second choice, like windows do .
Yap could be a bug in bios but windows can work with it so we have to
work with it .
We don't have to ask normal people to override bios, or to correct DSDT,
if we can deal with the problem.=20
but put a warning in DSDT parser, could be fine.


--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
