From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: Some RAS bug fix patches
Date: Sat, 19 Jul 2014 04:05:34 -0400
Message-ID: <20140719080534.GA32421@gchen.bj.intel.com>
References: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2014 at 10:34:39PM -0400, Chen, Gong wrote:
> Date: Tue, 15 Jul 2014 22:34:39 -0400
> From: "Chen, Gong" <gong.chen@linux.intel.com>
> To: tony.luck@intel.com, bp@alien8.de
> Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
> Subject: Some RAS bug fix patches
> X-Mailer: git-send-email 2.0.0.rc2
>=20
> [PATCH 1/3] APEI, GHES: Cleanup unnecessary function for lock-less
> [RFC PATCH 2/3] x86, MCE: Avoid potential deadlock in MCE context
> [PATCH 3/3] RAS, HWPOISON: Fix wrong error recovery status
>=20
> The patch 1/3 & 3/3 are minor fixes which are irrelevant with patch
> 2/3. I send them together just to avoid fragments.
>=20
> The patch 2/3 is a RFC patch depending on the following thread:
> https://lkml.org/lkml/2014/6/27/26
>=20
> Comments and suggestions are welcome.
>=20
Hi, Boris

Any comments?

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyibNAAoJEI01n1+kOSLHrVgP/i4+Wd+DhgRSVSfxMIBTSKAE
ZHOhdEf9YziB24RJBSAdxpr8RgztP27YH7hO2I4qOVezYpx7iTMYoHpOgjty62T2
uov2vUAleFG4eZdHAkss1rVtGhdw6KxznFQEq8PR5bworlmGzEM9L/+Nwy+XD+Nw
jyTgubkOE25Q1gArQipDlAZIuMxX/+yXXBns/zsA99lKADyiPGPdzYBF7crkKCdc
YyMTh9m8vz2XE9bgGfImYSAxcd+Slo+Nu6KYpjLxtpQKkFQ27khwInJ4WzUs6+zc
DsyI4aRv+ZfZsfgffJP8y+M58FNWhBQ/fCUyzuFR8RtRq09czTh9l368r9CfegPr
tJtWbhGcuMLEOW/BK7lYp6TjPlbLAbcKqvziQFiiQxEXpVB3X5oyOfPi1NQ4pG+9
nZBjEj4vpkFjyTsTndwd7wwEfdpFWXuzz4gZUHg/Nm9r6q41IGbUceru96P9i4gP
JojF213Pc0Yv/qHwhpwUbj1+Jx+U+EzFk5lJr3SdyY1hu8YAvFibXrWfuTBjYAYl
JID4sgcQfnXM5oWCuE13FNuJQ/zMixw20WhbM2pYyS4Vj4hAKrcHfb1e/3vYTgS7
dQJGOJ5BTrKpKOK/rKAOkWd2F284zonI1qzJ2iu8USuBsiZT/9xsQ6TjvRkL2Rnu
8jL6DjWK9t84YYoR2yGH
=9DCN
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
