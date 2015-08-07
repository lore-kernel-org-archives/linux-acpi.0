From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 06/18] regulator: core: Probe regulators on demand
Date: Fri, 7 Aug 2015 13:09:06 +0100
Message-ID: <20150807120906.GR20873@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-7-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J7GF/uaw3wkgs8ao"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:32803 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbHGMJ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2015 08:09:28 -0400
Content-Disposition: inline
In-Reply-To: <1438870315-18689-7-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--J7GF/uaw3wkgs8ao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 04:11:43PM +0200, Tomeu Vizoso wrote:

> When looking up a regulator through its OF node, probe it if it hasn't
> already.
>=20
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.

Still the same problem as we had before with this stuff, why is this DT
only?

>  #include <linux/regulator/consumer.h>
> @@ -1336,6 +1337,7 @@ static struct regulator_dev *regulator_dev_lookup(s=
truct device *dev,
>  	if (dev && dev->of_node) {
>  		node =3D of_get_regulator(dev, supply);
>  		if (node) {
> +			of_platform_probe(node);

And why the assumption that this is a platform device?

--J7GF/uaw3wkgs8ao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxJ/hAAoJECTWi3JdVIfQtnMH/2QicY+4s4rT2VQd+WGdm4b5
U38AVfxOYIcvwwCRD++e2gidjIvL5yTGAIApNh8UxA71qE89ug3HNIdBeAqhWhUF
43hO1UiNgNvG0V8Uf6v6VK1tIJHHS244NqYwVx8HZuwlsZQucu6LbjDQO7cyqyOp
ruNLi3sDBGRcV7EoDD5Cjx/1W3zgABs4sBZLLiLvsVyWVC66j5gYIC1lb7ALS/GY
TphRij98/n40wpb56BGJPmUdpuOs9twJkvg+ExbT/pNuPwLxDttZSU3v81o5cXWn
UfTvw690E0TcadbI8ZM/TfgoUcnyr7Irx3pJOr4EZRX9PNboSc2J2gNR5poT3h4=
=fzvw
-----END PGP SIGNATURE-----

--J7GF/uaw3wkgs8ao--
