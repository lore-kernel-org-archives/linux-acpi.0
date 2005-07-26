From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Problem patching pci.c
Date: Tue, 26 Jul 2005 09:27:18 +0000
Message-ID: <20050726092718.GA4339@fingerbrecher>
References: <42E57D67.1020800@arcoscom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42E57D67.1020800-guaFs41aBRpWk0Htik3J/w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello Samuel...

* Samuel D=EDaz Garc=EDa <samueldg-guaFs41aBRpWk0Htik3J/w@public.gmane.org> [2005-07-26 09:18 +0000]:
> Encountered a patch fail the vanilla kernel 2.6.12.3 in pci.c source file.
>=20
> The patch command used is:
>=20
> patch -p1 -t -f -i ..\patches\acpi-20050408-2.6.12.diff
>=20
> When compiling, fails in pci.c source with a non found symbol.
>=20
> Any suggestion?

try the latest patch:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6=
=2E12/acpi-20050708-2.6.12.patch.bz2

hth,
 Sebastian
--=20
Oo................................................................
Der naechste Satz ist eine Luege. Der vorhergehende Satz ist wahr.
OpenPGP key ID: 0x7A62F9B4  Geekcode: GCSd-s:a-C++ULB+++W++M+PS+++
=2E...............................................................oO

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC5gH2reHfL3pi+bQRAnQiAJ9x3mNXn4lf5VjDKpQVqy2E/R3vXgCfRffX
uuAx08fIS6GI1sD8jiID9m4=
=X+4x
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
