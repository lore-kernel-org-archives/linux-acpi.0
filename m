From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: RE: [Patch]fix EC GPE context error
Date: 06 Nov 2003 03:19:39 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068088780.1585.9.camel@darkstar.portugal>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84DBF@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8E84DBF-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
The first tests seems ok, in 2.4.23-pre9, I had problems without this
patch, my laptop had hang again, when my usb cable modem has gone down
and I turn it off.=20
Now, with this patch, don't had hang anymore.
I will test it more time, if I have a problems, I will tell you.

thanks

On Mon, 2003-11-03 at 13:29, Li, Shaohua wrote:
>=20
> Hi,
>    I have attached a patch against 2.4 in bugzilla 1171, please help test=
. Many thanks.
>=20
> Thanks,
> Shaohua
>=20
>=20
> > -----Original Message-----
> > From: S=C3=A9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> > Sent: 2003=E5=B9=B411=E6=9C=883=E6=97=A5 3:30
> > To: Li, Shaohua
> > Cc: ACPI Developers
> > Subject: Re: [ACPI] [Patch]fix EC GPE context error
> >=20
> > Hi
> > I can't apply this patch to 2.23-pre9 neither pre8 or pre7 .
> > I got one big rejected file (on osl.c I think)
> >=20
> > thanks
> >=20
> > On Fri, 2003-10-31 at 08:42, Li, Shaohua wrote:
> > > Hi,
> > >
> > >      2.6-test9 has a regression. Specifically, the EC GPE context fix
> > > has error. This new patch is to replace the old one. The patch is
> > > against 2.6-test7, and has passed under T40 and ASUS M2400. You can f=
ind
> > > detail info in osdl bugzilla 1171. Please help test.
> > >
> > >
> > >
> > > Thanks,
> > >
> > > Shaohua
> > >
> > >
> > >
> > --
> > S=C3=A9rgioMB
> > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> >=20
> > Who gives me one shell, give me everything.
>=20
--=20
S=C3=A9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
