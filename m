From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: How to sleep with 2.4.x
Date: Mon, 6 Oct 2003 17:37:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031006153717.GA24961@enigma.daemon.sh>
References: <E1A6T1j-0007uU-00@sc8-sf-list2.sourceforge.net> <3F816ADF.6010209@clients.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F816ADF.6010209-2wWnE64kTEeyZ7Fz/ZYYxQ@public.gmane.org>
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


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi sergey..

* "Sergey V. Oudaltsov" <sergey.oudaltsov-2wWnE64kTEeyZ7Fz/ZYYxQ@public.gmane.org> [2003-10-06 16:46 +02=
00]:
>=20
> What is the best way to organize "sleep" with ACPI and kernel  2.4.20=20
> (sure, with the acpi patches)? My Acer 800 supports S0,S3-S5. It seems=20
> all these sleep modes are unsupported by the kernel  2.4.x. How do=20
> people sleep with 2.4.x?

they hibernate (S4) with swsusp:

http://swsusp.sf.net

hth,
 sebastian

--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gYwtreHfL3pi+bQRAvXLAJ4ojjdxyLTYouXSPe8ZV1hrsC7mHACglEHs
ohbK315d5TXwUns35II3PEI=
=TtGC
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
