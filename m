From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] PCC-test: Test driver to trigger PCC commands
Date: Wed, 27 Aug 2014 11:30:15 +0100
Message-ID: <20140827103015.GY17528@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <1409081738-5602-4-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pn6edh7DhurTm1ia"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35785 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbaH0Ka3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 06:30:29 -0400
Content-Disposition: inline
In-Reply-To: <1409081738-5602-4-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: arnd@arndb.de, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net


--Pn6edh7DhurTm1ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 03:35:38PM -0400, Ashwin Chaugule wrote:

> echo 2 > /proc/pcc_test [ to get channel base address ]
>=20
> echo 1 > /proc/pcc_test [ to trigger a PCC write ]
>=20
> echo 0 > /proc/pcc_test [ to trigger a PCC read ]

You shouldn't be adding new files to /proc - debugfs is a better home
for something like this.

--Pn6edh7DhurTm1ia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/bM0AAoJELSic+t+oim90V8P+wXCajmRwAxCUn0lV5MFTmfi
iZ9C9awGnUzJzt0KzBEqY3+hfaAOj8eTSjZkiJWi2QlOh4NHmyYd3TFlzcGzvjSb
gx104TfNcwyz1k0K5/TddVrhDgwXk3jaj+dY8SkCU0kExO+KDmP48uidx7wcnW+5
CUHKYHpj+ScsIJCl9tqXyX6NayoavkIg9iJPKDeVS7lPCAIjSLGDXNhC5CmJrMOK
MRN9m6kucpmAqum12xr3YWX5/fbRqW12OgBTTQi/vqW96NKch+xowWFau8l6JUeY
UvV6/83kmaOUIy0dBXwkeVZ+JyImJOlppF3nRvyvz9e2vK0pMcgp++rPoVYW0djC
V9gnGX6AxSv0gt9ZyWZBO7u/9ovsrRE55Gy/dC5LhxyYGYEuLllzxssa4c1bk4nZ
i3a7elNz7jVp5S0VC9m+1VQcF1HUbJA3AtdXm/nI+r4l/BUdlcFftTzbhwqTkhUi
27wz8Zun79o/yi0GXfnF3ujC/wuNjDUAJ6FrdMlhep7Y5CKR4poXGUpuB9zBJ0GD
yg70gqkmu0NsYYAQKmKedjsuuhuPOvnz8KoQXae1zGviEHyJikz2kf3BFvftMeCm
yE8A/ALLrsV4CWg7osK0U4z5zMSAgaUlyDq7gxfyD70FYBgL670QkZREyjTsydlV
IfSCVjuGvBWMsKvwIC8o
=a5JJ
-----END PGP SIGNATURE-----

--Pn6edh7DhurTm1ia--
