From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: APIC options 2.4.21 kernel + patch
Date: Tue, 1 Jul 2003 10:00:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030701080034.GA873@enigma.daemon.sh>
References: <20030701052006.GB2242@xtrinsic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030701052006.GB2242-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello there...

* Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org> [2003-07-01 09:16 +0200]:
>=20
> http://xtrinsic.com/geek/articles/acpi.phtml
>=20
> Here is a copy of the email I received which outlines the problem behind
> the question:
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D2668793&forum_id=
=3D7803
>=20
> My question is this: Does the CONFIG_X86_UP_APIC module need to be set to
> "Y" for the 2.4.21 kernel + latest ACPI patch to work?=20
>=20
> I've found the following APIC options in the 2.4.20 kernel:
> 	CONFIG_X86_GOOD_APIC=3Dy
> 	# CONFIG_X86_UP_APIC is not set
> 	# CONFIG_X86_UP_IOAPIC is not set
>=20
> The reader who emailed me said that he had to enable the second option in
> order to get the 2.4.21 kernel + patch to work. Will this be true for all
> hardware configurations 2.4.21?

i cannot second that, at least concerning kernel configuration. when i
disable the APIC-stuff i can still select ACPI in my configuration.
also drivers/acpi/Config.in does not seem to depend on settings for APIC
except for CPU enumeration (CONFIG_X86_LOCAL_APIC which is enabled
automatically by CONFIG_X86_UP_APIC).
grepping the kernel sources for UP_APIC does not seem to alter anything
within the ACPI codebase. though CONFIG_X86_UP_IOAPIC automatically enables
CONFIG_X86_IO_APIC which alters ACPIs behaviour (compilation) quite a bit.
this is 2.4.21 + acpi20030619 (+ swsusp-1.0pre14 + laptopmode + bootsplash +
dsdtinitrd).

though i am neither a kernel developer nor an acpi developer and i could
be damn wrong. :)

cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/AT+ireHfL3pi+bQRAvDiAJ9lq0yGLgTAgvWLwfo9RA1T2WukfACgjZto
BxvQDUGRFbkJT9DcBL8Uqo0=
=5UuC
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
