From: valvo <valvoline-FEXhGYRT/JJAfugRpC6u6w@public.gmane.org>
Subject: Re: patch: acpi-20020821 fix?
Date: Thu, 29 Aug 2002 16:44:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020829144434.GB246@lilyth.vrlteam>
References: <15723.8797.507913.189282@marple.lmc.cs.sunysb.edu>
Reply-To: valvoline-FEXhGYRT/JJAfugRpC6u6w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15723.8797.507913.189282-KT8MnZFsUJrzAs+eN625g9BFLwJMpSEX@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2002 at 02:55:25AM -0400, Giridhar Pemmasani wrote:

> It seems that the following patch against drivers/acpi/system.c
> is needed to get 'echo -n 5 > /proc/acpi/sleep' to work as
> expected.=20
>=20
> --- system.c.orig   Tue Aug 27 02:42:17 2002
> +++ system.c    Tue Aug 27 02:43:42 2002
> @@ -110,7 +110,7 @@
>     acpi_status status;
> =20
>     /* only support S1 and S5 on kernel 2.4 */
> -   if (state !=3D ACPI_STATE_S1 || state !=3D ACPI_STATE_S5)
> +   if (state !=3D ACPI_STATE_S1 && state !=3D ACPI_STATE_S5)
>         return AE_ERROR;
> =20
>     acpi_enter_sleep_state_prep(state);
>=20

i don't understand the purpouses of this patch...can you be more explicit, =
plz ?

--=20
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available=
  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4D=
D ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :=
: ]

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9bjNRB2olYR1ntN0RAvZpAJ93KkZSQclPExN38m5Qdvi4oiFtEQCg4ZNJ
BlhlizwoDAaHzFULyTUBl54=
=ie5T
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
