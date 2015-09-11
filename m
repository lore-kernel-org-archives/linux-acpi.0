From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 07/22] regulator: core: Reduce critical area in
 _regulator_get
Date: Fri, 11 Sep 2015 13:10:24 +0100
Message-ID: <20150911121024.GQ12027@sirena.org.uk>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-8-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="93OMjyVt/yVb0YPi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441628627-5143-8-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-acpi@vger.kernel.org


--93OMjyVt/yVb0YPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2015 at 02:23:32PM +0200, Tomeu Vizoso wrote:
> By moving the locking of regulator_list_mutex into regulator_dev_lookup,
> where it is iterated over. The reference count of the regulator's device
> is increased in case it's unregistered while in use.
>=20
> In _regulator_get() the regulator_list_mutex mutex was held for most of
> the function, but that is only strictly needed to protect the list
> lookups.
>=20
> This change would be useful if for example regulator devices could be
> registered on demand when a driver requests them. regulator_register()
> could end up being called from within _regulator_get while the lock on
> regulator_list_mutex is being held, causing a deadlock.

The fix for this is to convert the code to use the list maintained by
the driver core for regulator class to iterate the regulators rather
than fiddle about with the locking.  I'm pretty sure the current locking
has problems and I'm worried that this may make those problems worse.

--93OMjyVt/yVb0YPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sSvAAoJECTWi3JdVIfQnV8H/iRVB2kQ6Jx5kQMzWxYUWQdP
Xs+UHjz0ZA9Ybydnw/AiF+aG3zFYOuwpog9vlutHHtz6rHgylnr+cnJNGReSiMFo
EUUhDNy/H2NFdoymNGez11W0i1IgJGGgUjq9OjAJyRCn/U6Jc1CSlw3gl2GQIdBB
n+TFiXRcn7BJe5PhNUQtDTFftGTlNVV3lUz9ed06Zar4kV1igPXX8xpbLkRstlWM
H4xWVEZGeG+lHnXw5n666VoZ5tWEOQ5dAgJTLlcKKSt8iLCOib5kfdWdaiuH9H2N
5RWlW+cEy95jp92oLhaPMqVpE2uOE5ocldqkAT2+DX+80n2tgA5uLllIE70pM50=
=zaXc
-----END PGP SIGNATURE-----

--93OMjyVt/yVb0YPi--
