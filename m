From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [PATCH] acpica-20030714 and "-g"
Date: 26 Jul 2003 18:38:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1059241099.1585.9.camel@darkstar.portugal>
References: <F760B14C9561B941B89469F59BA3A847E9701F@orsmsx401.jf.intel.com>
	 <200307201917.44668.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307201917.44668.hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi I test this patch and works pretty well, and option -g produced this
files :
SSDT_POWERNOW.dat
FADT_.dat
FACS_.dat
dsdt_EAGLES.dsl
DSDT_EAGLES.dat


On Sun, 2003-07-20 at 18:17, Hrvoje Habjanic wrote:
>=20
> Hi all!
>=20
> As you all noticed, "-g" isn't working in latest acpica release. I've man=
aged=20
> to fix that.
>=20
> (Andy, i know that it would be "nicer" to put everything in osunixxf.c, b=
ut=20
> use of AcpiOverrideTable is, among other things, causing circular calling=
. It=20
> becomes quite complicated to write "clean" code. I think that suggested=20
> modifications are minimal, and they make disassembler work more like some=
=20
> kernel based on this code.)
>=20
> Still, there is room for improvements, so ....
>=20
> And another note; currently SSDT tables ONLY get saved, and not disassemb=
led.=20
> It would be nice to get them disassembled (maybe someone with more knowle=
dge=20
> of this code/parsing ...)

yes

>=20
> Hrvoje
>=20
> p.s. Sorry on bad english... >:-)
sorry on bad english too :)
> ----
>=20


--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
