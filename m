From: Nir Tzachar <tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org>
Subject: Re: ACPI and PRREMPT bug
Date: Tue, 08 Nov 2005 10:17:22 +0200
Message-ID: <1131437843.8476.2.camel@nexus.cs.bgu.ac.il>
References: <971FCB6690CD0E4898387DBF7552B90E0356B628@orsmsx403.amr.corp.int el.com>
	 <20051107231524.GW7991@shell0.pdx.osdl.net>
Reply-To: tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YrnbwH0Id88eYmHVP81+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051107231524.GW7991-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-YrnbwH0Id88eYmHVP81+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>   Booting with
> acpi_serialize (which sets that flag to true) does seem to fix the
> problem. =20

this partially solves the problem. im still getting this:

Nov  8 10:08:15 lapnir osl-0965 [3164] os_wait_semaphore     : Failed to
acquire semaphore[c193c820|1|0], AE_TIME
Nov  8 10:08:17 lapnir osl-0965 [4647] os_wait_semaphore     : Failed to
acquire semaphore[c193c820|1|0], AE_TIME

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nir Tzachar.

--=-YrnbwH0Id88eYmHVP81+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDcF8SIHR+zI+Dam4RAo27AJ9goDwh1vn9t/l/dvoACJi5A/r7/gCgrzQ5
2WPhTcZwmyiwOebwHsIxuBM=
=iyVs
-----END PGP SIGNATURE-----

--=-YrnbwH0Id88eYmHVP81+--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
