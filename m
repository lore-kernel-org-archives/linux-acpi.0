From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: How to determine ACPI SF patch version from running kernel?
Date: Mon, 4 Aug 2003 23:42:10 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEBE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Bas Mevissen [mailto:ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org]=20
>   (ACPI_CA_VERSION)
> > It changes every release, except for the most recent one. I=20
> should've
> > updated it but I was in a hurry to go on vacation and didn't.
> >=20
>=20
>  From acpi-20030730-2.4.22-pre8.diff.gz:
> -#define ACPI_CA_VERSION                 0x20030619
> +#define ACPI_CA_VERSION                 0x20030714
>=20
> The ACPI_CA_VERSION did change, but not to the number of the=20
> patch. My=20
> question was how to determine the _patch_ version and not just the=20
> version of the ACPI_CA stuff.
>=20
> (Maybe I see it wrong, but I guess that ACPI_CA is just one=20
> part of the=20
> whole patch.)

Technically you're right but except for the most recent patch (which was
a mistake like I mentioned) ACPI_CA_VERSION gets incremented in every
patch on sf.net so the easiest thing is to just use this to
differentiate between sf.net patches.

-- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
