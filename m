From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: [Solved] Re: power-off (Acer TM632)
Date: Mon, 31 May 2004 23:37:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040531213726.GA3298@zimen.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

salut

  :) Yes !

  now, it works wery well for me.

  I played with kernel configuration, i found this:
 =20
  I guess, Problem was in "Enhanced RTC driver". If i have this driver
  inside a kernel (or like module), my laptop will never poweroff().
  last message was like this:
  		...
		call_power_off()  =20
		...HANG...
	=09
	=09

 =20
  (also i have inserted HPET timer inside kernel, not like module)


  Is this some unresolved dependency with RTC ?
  Can i have both timers ? (RTC, HPET )
 =20

  Thanks a lot.


  				mizu

 =20
On Fri, May 28, 2004 at 09:44:18PM +0200, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut Mizu,
> I forward you a mail, that I sent Emma, with my settings.
>=20
> please give them a try.
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - --=20
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
>=20
> - ---------- Forwarded message ----------
> Date: Thu, 27 May 2004 17:27:58 +0200 (CEST)
> From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
> To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
> Subject: power-off
>=20
> Salut Emma,
> as I asked you in the mail on the list, do you have the latest BIOS R01-C=
0O?
>=20
> I attached you my .config file. As I also recently patched my kernel with=
=20
> swsusp2, pwcx and packet-cdvdrw you will want to run
>  make oldconfig
> on an vanilla 2.6.6 kernel. If it does not let you shutdown your notebook=
,=20
> than it will be a problem with your software, but not the kernel, or acpi.
>=20
> Just let me know, how you story continues...
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - - -- 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> - -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQFAtgkG9bBoTzOf1pMRArl2AKDYY/QD7sKsspJTLA0j7bMcx0Eb/wCeLe2R
> Ixw4Q+QT+LhtZWlHqPGksWA=3D
> =3D6d1v
> - -----END PGP SIGNATURE-----
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQFAt5aX9bBoTzOf1pMRAi3AAKCOHCR0Yived3OfMVhdoFP8wpOg8gCghppJ
> 6XeMFlU7QEWJbAuhW5uMvo0=3D
> =3DMatN
> -----END PGP SIGNATURE-----

--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu6WW9kFXwDL4DRkRArnPAJ9K5pP8ibes0Z9IpCEmpyA8F6Y6NQCgsvkr
a/in6JsnEEXZYHb8iYXeMAM=
=buwX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
