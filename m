From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: can i try a merge of two dsdt?
Date: Mon, 5 Apr 2004 12:37:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040405103757.GA6844@fuchi>
References: <1080930033.752.5.camel@dagon.lovecraft.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1080930033.752.5.camel-XQD7E+J2gHDpvm5p2avrnqicDR3qMxSs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi devel mlist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

bon giorno alessandro..

* Alessandro <alessandro-qt5M+3XYwT4sV2N9l4h3zg@public.gmane.org> [2004-04-05 10:31 +0200]:

> i have a problem (a problem? many problems.. =3D\) with my acer aspire
> 1703SM on freeBSD with ACPI.
> If I don't overwrite the DSDT with the one i found for acer aspire
> 1703SC i get the floppy and the temperature indicator to work but the
> batery status is always at zero.=20
> If I overwrite my real DSDT whit the DSDT for aspire 1703SC I found that
> the batery method work properly.. but the system cannot recognize the
> floppy and the temperature indicator is always at 0.0=B0C.=20
> My idea is: can i merge my DSDT and the aspire 1703SC DSDT and then
> recompile the resultant DSDT?

yes, it should be possible.

> If it is possible.. where can i get more documentation about it?

take a look at http://acpi.sf.net/dsdt/index.php

and tell me which links are missing. :)

ciao,
 sebastian

--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcTcFreHfL3pi+bQRAqGPAKCLwkvI4SWKYL+MAj6etOSvmBBV+gCfZgAk
hssoaOpHB9mVbP/3DqSh5ac=
=6dfZ
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
