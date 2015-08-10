From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
Date: Mon, 10 Aug 2015 11:25:15 +0100
Message-ID: <20150810102515.GA1965@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
 <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
 <55C4E597.1010701@ti.com>
 <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37176 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934670AbbHJKZi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Aug 2015 06:25:38 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Rob Herring <robherring2@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 09, 2015 at 03:03:14PM +0200, Tomeu Vizoso wrote:

> There was some recent thread about how the disabling of unused clocks
> and regulators isn't really safe because after late_initcall_sync more
> drivers can be registered from modules. Furthermore, there's async
> device probes.

What recent thread and why would that be unsafe?  Any driver using a
clock or regulator ought to be making sure that the clock or regulator
is enabled before it tries to use it.  The worst that should happen is
that something gets the power bounced during boot which isn't the end of
the world.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyHwIAAoJECTWi3JdVIfQQ2kH/2CXryctZQKKgrOBprylvRft
nvGYcjSHlDneB5K1SXy3M8Rwl+Yf2W6lc1D0pUnr2HJwa/VIvR7U93lKlK1YkEkL
E8GCOVGRey1sXKS+opZHI9m1bDsJQHr+H+RhcseHnm2I/uK5xLj3fJ8NgWI+ZVP+
7NfgAvMD0hNkKYaaOxAoo/yWKd1uk1FQaosaxkswzZ0YqzG5v1g2LtouG1zKN63z
xjn7LFy2A5TGVjPJC+JWrA+L76mdYvtxueWnLwFJM5S+ke2dK4FX42YuQ8JsOJCi
IFzNEhlhjEGrwh1unTIKTBKim58+ypq62qgG0Elf4XSMpYX7hRlnR+aNTsN/Oq4=
=LVVD
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
