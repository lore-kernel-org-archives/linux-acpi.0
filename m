From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: RE: 2.6.0-test9 regression: panic on Fn+F7 hotkey
Date: 28 Oct 2003 06:22:43 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067322164.8078.13.camel@darkstar.portugal>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84DA8@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8E84DA8-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi
Pressing Fn+F7 doesnt seems to be in boot time.
For me acpi_ec_gpe_query.patch in 2.4.23-pre8, hangs my laptop when I
press lid button, after boot and after login after enter in X, after all
things up. =20

On Tue, 2003-10-28 at 02:30, Li, Shaohua wrote:
> Hi,
>   Which time did the panic occur? Boot time? Yes, I made the patch to fix=
 some boot time errors.=20
> But if boot is ok, the patch should not impact anything.

but have a lot of impact.
in my case, boots without problems.=20

Please give me more info.
>=20
> Thanks,
> Shaohua
>=20
>=20
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karol Kozimor
> > Sent: 2003=E5=B9=B410=E6=9C=8828=E6=97=A5 1:08
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] 2.6.0-test9 regression: panic on Fn+F7 hotkey
> >=20
> > Hi,
> > Pressing Fn+F7 to turn the LCD on / off causes 2.6.0-test9 to panic.
> > That's
> > AFAIK the single event that causes such a behaviour, other keys work fi=
ne.
> > Reverting the acpi_ec_gpe_query.patchi[1] fixes the issue and makes the
> > kernel
> > run fine.
> >=20
> > [1]:
> > http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.=
4.2
> > 2/20031017152411-acpi_ec_gpe_query.patch
> >=20
> > Best regards,
> >=20
> > --
> > Karol 'sziwan' Kozimor
> > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: The SF.net Donation Program.
> > Do you like what SourceForge.net is doing for the Open
> > Source Community?  Make a contribution, and help us add new
> > features and functionality. Click here: http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: The SF.net Donation Program.
> Do you like what SourceForge.net is doing for the Open
> Source Community?  Make a contribution, and help us add new
> features and functionality. Click here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=C3=A9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
