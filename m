From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [BUGFIX] ACPI, APEI, Avoid too much error reporting in runtime
Date: Mon, 11 Jun 2012 14:25:27 +0100
Message-ID: <1339421127.4942.8.camel@deadeye.wl.decadent.org.uk>
References: <1339395822-12032-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0THBtN9EShDtvkUH+b7o"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47372 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab2FKNZo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2012 09:25:44 -0400
In-Reply-To: <1339395822-12032-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org


--=-0THBtN9EShDtvkUH+b7o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-11 at 14:23 +0800, Huang Ying wrote:
> This patch fixed the following bug.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D43282
>=20
> This is caused by a firmware bug checking (checking generic address
> register provided by firmware) in runtime.  The checking should be
> done in address mapping time instead of runtime to avoid too much
> error reporting in runtime.
>=20
> Reported-by: Pawel Sikora <pluto@agmk.net>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Tested-by: Jean Delvare <khali@linux-fr.org>
[...]

This is not the correct way to submit a patch for stable.  See
Documentation/stable_kernel_rules.txt.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.

--=-0THBtN9EShDtvkUH+b7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT9Xxx+e/yOyVhhEJAQoglA//Yf/gBsgodWbs9DkH7+zPwPpZWtOzQBaD
O88QIvkcp0tuFgbiAfhEp08mGhfi3NRTRoINO1+9C8jPrdXoiug/P2dvc7bEycCS
U5zVSW1nJdyweiYag4hwMl1N/3t0VpaohiL0H3EbhQOmXoYDrB9MhbkdL342I7m8
NwwmLJLw9mDZUJ8oyJKt6xdWebOvcl73p9chCFMdw2bcSaUkFdbaXIxLXSulJ4Wl
whzRXEQxBq/3sqsnQvWxs4Kvv2NEDAU+C0SGscivhBPXCRjw25Qngp1RUGtcU24q
fZa4ax+4f9GOApnsxeTPgHfJd4nU/vOjktYXX10MZQEXfUc4QNozg2aiPnbCAOSj
hsXlsg8YETUhWZtHhgskzelYQx0mmdfSJESJ4jifD+CoDILdRyj9pKCgtJW4Ua3z
RaMG6BzkcCW13pP+tjv4qFh4iD5DHUu5wMD/YWKovCtfXIIXewqBaW3t51epW0S+
odMv+SFVzbCHXeuzk3IADsusQ+2JWB0novDhl7IACZ2WIKPbJaiQGlaEeMdR/wWs
1n71ctI/ETtl9HplkCfxwS96CGbsZB+E6hXxmKNV8eZxYmokwQsvExRZpJWe8prH
fkILuhZd0urbozK/FzNf2q5Lr7eGZn2eSS5chm2fDUvMArTfzzYasD5zonLBXwew
KWQEqZE2Urg=
=UNnm
-----END PGP SIGNATURE-----

--=-0THBtN9EShDtvkUH+b7o--
