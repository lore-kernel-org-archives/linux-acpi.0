From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: Sleep Button Debounce
Date: 10 Jul 2003 15:49:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1057848566.1533.6.camel@darkstar.portugal>
References: <3F0AAEA3.9080902@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F0AAEA3.9080902-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

For example:

/etc/acpi/actions/powerchange
#!/bin/sh
status=3D`sed "s/state: *//" /proc/acpi/ac_adapter/AC/state`
case $status in
        "on-line"       )       /usr/bin/spicctrl -b 255
                                exit 0
                                ;;
        "off-line"      )       /usr/bin/spicctrl -b 100
                                exit 0
                                ;;
        esac
echo "Something bad happened!"
exit 1

On Tue, 2003-07-08 at 12:44, Matthew Tippett wrote:
> Hello,
>=20
> I have set up a script to put my system i8500 into sleep mode 1.
>=20
> The main problem is that there is no way to find out if the button is=20
> being released or pressed within ACPI (aka closed/open on lid).
>=20
> So as a result, when I suspend, and resume, I drop back into suspend as=20
> the SBTN event fires on release.
>=20
> Any thoughts on doing this pure ACPI? (apart from a userland counting=20
> script).
>=20
> Regards,
>=20
> Matthew
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgio Basto
Technology Project Manager
onevision design studios
TECMAIA - Parque de Ci=EAncia e Tecnologia da Maia
Rua Frederico Ulrich, 2650
4470-605 MOREIRA DA MAIA
tel. + 351 22 091 5410
fax. + 351 22 091 5419
email: sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org
web: http://www.onevision-design.com



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
