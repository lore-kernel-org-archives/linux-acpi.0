From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH -next] panasonic-laptop: depends on ACPI
Date: Sat, 18 Oct 2008 09:04:30 +0200
Message-ID: <20081018070430.GO1048@prithivi.gnumonks.org>
References: <48F8F990.1060807@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:46526 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYJRHJ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Oct 2008 03:09:27 -0400
Content-Disposition: inline
In-Reply-To: <48F8F990.1060807@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, akpm <akpm@osdl.org>


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2008 at 01:46:08PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>=20
> panasonic-laptop uses many acpi_*() functions so it should
> depend on ACPI; otherwise there are approximately 70
> warnings/errors generated.
>=20
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Harald Welte <laforge@gnumonks.org>

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFI+Yp+XaXGVTD0i/8RAnaZAJ9Czo0jqotwPOoEVGulW7EMyvCfUQCgq/o+
+PA5sWsNFuPCocY89oMRZoo=
=Lsun
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
