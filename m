From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 05/18] regulator: core: Reduce critical area in
 _regulator_get
Date: Fri, 7 Aug 2015 13:07:52 +0100
Message-ID: <20150807120752.GQ20873@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-6-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GBlkOKZ0utbUai18"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:32792 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHGMIX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2015 08:08:23 -0400
Content-Disposition: inline
In-Reply-To: <1438870315-18689-6-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--GBlkOKZ0utbUai18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 04:11:42PM +0200, Tomeu Vizoso wrote:

> This backtrace illustrates the situation described above:
>=20
> (regulator_register) from [<c05efe64>]
> (devm_regulator_register+0x48/0x84)

Please don't paste entire backtraces into commit messages, they are
enormous and contain very little useful content - they just obscure
actual information in the commit message.  If you feel there's useful
information in there just include edited highlights with only that.

> +static int _regulator_enable(struct regulator *regulator, bool do_lock)
>  {
> -	int ret;
> +	struct regulator_dev *rdev =3D regulator->rdev;
> +	int ret =3D 0;
> =20
> -	lockdep_assert_held_once(&rdev->mutex);
> +	if (regulator->always_on)
> +		return 0;
> +
> +	if (rdev->supply) {
> +		ret =3D regulator_enable(rdev->supply);
> +		if (ret !=3D 0)
> +			return ret;
> +	}
> +
> +	if (do_lock)
> +		mutex_lock(&rdev->mutex);
> +	else
> +		lockdep_assert_held_once(&rdev->mutex);

Eew.  This do_lock stuff is *not* nice and going to be fragile.  I'm not
a fan, we need something better.

--GBlkOKZ0utbUai18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxJ+YAAoJECTWi3JdVIfQK6IH/iukEMdagu+2QgXlAd03ptk8
x81imRrjhtmJCQYoavTErC1M5CbBBkNxfNvUuC70gSvt9IkTeJN1fJD9pJkfjFpR
y9XI93sIIYc5wBlJTlNToxIRakd8Z3530WVgxZ7RV3V5UDmhDRAdv0PTygZmeYcO
X9gyvR5E/dqQwCuDZXZEwYB3hHCy2lA40fdNEQEOvLpX58GL7VSfeaYxla+ZCw/5
bUC9GBYvt8YGl293uKIgsuYAb8RQm0o3ZK5DNKYZq1DmbatvBBAGlnvqYf3YQLZI
q+IE7W0zb+B/5wR2SgSEibx7y1+eKuTIBjKdg6BT/fGCMRA5sOxiE1qI+vYR8fQ=
=l3NK
-----END PGP SIGNATURE-----

--GBlkOKZ0utbUai18--
