From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
Date: Fri, 11 Sep 2015 13:08:24 +0100
Message-ID: <20150911120824.GP12027@sirena.org.uk>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CAnSIDLNQVlNVxrl"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59998 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbbIKMIj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 08:08:39 -0400
Content-Disposition: inline
In-Reply-To: <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>


--CAnSIDLNQVlNVxrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2015 at 02:23:29PM +0200, Tomeu Vizoso wrote:
> Walks the OF tree up and finds the closest ancestor that has a struct
> device associated with it, probing it if isn't bound to a driver yet.

> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a device should cause its descendants
> to be probed as well (when they get registered).

I'm still not seeing how this works for MFDs where the MFD binding is
present directly in DT.

--CAnSIDLNQVlNVxrl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sQ3AAoJECTWi3JdVIfQDlAH/izX7ufWM1LfUwWesFd21KUS
p9SBK4ceAoDyVdEuuv2S61zrVpkU4SlbU2C8b6pcGmYT2TFZ5/+JrQ4jzsbpPDqm
kLaggEKOSHuEJuLNT4fEIVMe+rUuBPJfT6POnRMp5Wu02Pj7t7MVqgkuRMoLvQwg
D0s1DJyLWdUdZkUX7L5TVWINENQYZmVX5ik9anighz+rc8kgX3AgjklMxVvRCTfx
AK0POWClJ3GYbiVQMY6DIOqqcrhIELyRRkqhlLlyl/ku/1uKgewDUXBJ1bF8eg5a
8/MbIzKwGMgf0yRvqI5sOKK+s4pNyF/9dmO+afz1RJJ6YyrxAidGu9kpfDVlifc=
=QLxD
-----END PGP SIGNATURE-----

--CAnSIDLNQVlNVxrl--
