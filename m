From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: dsdt patch
Date: Thu, 5 Feb 2004 10:39:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205093914.GB2047@fuchi>
References: <401CCB50.6010003@ihug.com.au> <20040202084457.GC8164@fuchi> <401FB726.1080105@ihug.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <401FB726.1080105-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

re alimin..

* Alimin Bijosono Oei <alimin-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org> [2004-02-03 16:46 +0100]:
> Sebastian Henschel wrote:
> >
> >* Alimin Bijosono Oei <alimin-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org> [2004-02-02 09:12 +0100]:
> >
> >>Just want to ask where can I find a patch that will allow me to use my=
=20
> >>own dsdt for kernel 2.4.24? Is there such a patch flying around or is=
=20
> >>the kernel itself patched to allow implementation of custom dsdt table?
> >>I am sorry if this is the wrong place to ask such a question but I coul=
d=20
> >>not find a mailing list for dsdt itself. I would very much appreciate i=
f=20
> >>someone can point me to the right direction.
> >
> >
> >you might try this:
> >
> >http://gaugusch.at/kernel.shtml
> >
> >also dino klein has announced a more generic patch last week or so,
> >check the archives for that version.
>=20
> Thanks Sebastian. I feel a bit lost after consulting the more generic=20
> patch you suggested before. Yes, at the moment I have two choices, one=20
> is to use the initrd patch as you pointed out and the other one is to=20
> patch osl.c and compile the custom dsdt into the kernel. I just want to=
=20
> know if there is a patch to osl.c for kernel 2.4.24 made available? If=20
> there isn't one, then I can always use the initrd patch which I am using=
=20
> at the moment. I am not sure which method is the best though.

well, the initrd patch is quite flexible. there is no need to recompile
your kernel if you change the DSDT.
dunno about osl.c patch for 2.4.24 (or 2.6).

bye,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIg9CreHfL3pi+bQRAvbfAJ4yfPdQUbsx53exmAq+QbvA0M26ywCgjj//
SbX9LgHudOavCuWlna7Gf1E=
=RU3T
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
