From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Compaq Presario 2100 (2133AC)
Date: Thu, 3 Jul 2003 12:53:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030703105319.GA832@enigma.daemon.sh>
References: <3F0306B3.4070803@aes-pl.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F0306B3.4070803-Pm7dQxmfFcgpAS55Wn97og@public.gmane.org>
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


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi andrew...

* Andrew Eager <andrew.eager-Pm7dQxmfFcgpAS55Wn97og@public.gmane.org> [2003-07-03 09:35 +0200]:
>=20
> I have just got a Compaq Presario 2100 (2133AC or DF975A) and found that=
=20
> the 2.4.21 kernel just hung when booting.
> After a day of reading howtos and learning how to use the iasl compiler=
=20
> (& language... yuk), I have managed to get the machine to work by:
> - Getting original DSL, debug & recompile
> - Removing  the "PTLTD" from blacklist.c (not sure if this is right or no=
t)
> - Loading the AML code from initrd.
>=20
> I now have everything working **except** that running hwclock will cause=
=20
> the kernel to crash.
> (I have to comment hwclock out of rc.sysinit in order for it to boot)
>=20
> Any ideas where to look?
> Assuming I get this thing to work, any use providing the new dsl code to=
=20
> the list?

you might have a look at http://acpi.sourceforge.net/dsdt/view.php?id=3D76
and compare your DSDTs and perhaps update that one or upload your own.

cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BAsfreHfL3pi+bQRAspRAJ9yLvf/cDBFP+wRSBSeSuOv8Xx6pwCdGxQ3
ES7gL74IEgjyPGbgbgpIr2w=
=m5Kk
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
