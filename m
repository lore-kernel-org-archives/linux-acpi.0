From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: Parameter check for EINJ error injection - V3
Date: Sat, 29 Jun 2013 04:58:46 -0400
Message-ID: <20130629085846.GA4426@gchen.bj.intel.com>
References: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21250 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab3F2JJw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jun 2013 05:09:52 -0400
Content-Disposition: inline
In-Reply-To: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 10:32:01PM -0400, Chen Gong wrote:
> Date:	Wed, 22 May 2013 22:32:01 -0400
> From: Chen Gong <gong.chen@linux.intel.com>
> To: tony.luck@intel.com, bp@alien8.de
> Cc: linux-acpi@vger.kernel.org
> Subject: Parameter check for EINJ error injection - V3
> X-Mailer: git-send-email 1.7.10.4
>=20
> [PATCH 1/2 V3] ACPI/APEI: Add parameter check before error injection
> [PATCH 2/2 V3] ACPI/APEI: Update einj documentation for param1/param2
>=20
> These two patches are employed to enhance the check for param1/param2
> when einj is used. Param1/param2 are very subtle for the guy
> who lacks of experience. These two patches add some extra checks to
> avoid happening further errors to confuse users.
>=20
> V3: only update the 1st patch based on Tony and Boris' suggestion.
> V2: only update the 1st patch based on Boris' suggestion.
> --

So Tony/Boris

Have you picked this patch series into some RAS branch? I just don't
find them.


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRzqHGAAoJEI01n1+kOSLH6mcP/iB+AL/OEqR0Ly7cqc12OIPC
+MuICKB9C6XNOwPVbac59qN2AvLEL6GWMmmMaCv9uQjEWPYHOqbGUgmltUt823vB
KslPJflsvNiHv1ZLqzJ1wPthnRH0ptSW3uUEHfTVxugKPQQELMxlKstKQa/MExhU
je9z2mIQ1tmPNruIBrGSFxAG8zeGwZHG0j4GMx+9lG+Adl6+rXfOxoR+RCXGbpeQ
rUWVbfjtHqSKHqiXX2oBWbktk9mFujvnYFh0TInLnhgnKDv6wJK/yQugx5xR9Yhu
enT2WpwrPvsBFnpyw1uAJ4tWRDHB3t8MYgoITTdSrFJTlnC0ydHwGLZ3JmSGCVq9
5FRhbvsc/xkLYk7+sMGHLEmtMO6sfRRtZlcBE5lzxs//HZld1ckyiH7c8T8I5ScB
HvMVuTzpWtXItLGLKzrCclSvwHmXyR5DvoxaRBLTDnbQSAmSeN39wLjjY462qBBn
XlH+9tbAXwXYlmOuLXHfkuxRmmb0OAummtjm2OarjYnM2bnV3VpwYvtUwg6Ir/YG
YWn9nurSYGxTIXf+74A95zP9kU0T089vz6SORqlVRpKe7Tr990GiGd50TVwpgA7t
XDbXBrXZCqo3yb4CifSJ66qBTvWB8fjqbjBcKRJ7S+vqhWAwILkG6Ifcu8aJpkGP
CzcylQ0VmhlHTpy4xiIr
=r2ku
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
