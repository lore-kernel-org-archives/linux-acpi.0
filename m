From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 02/18] of/platform: add of_platform_probe
Date: Fri, 11 Sep 2015 16:35:30 +0100
Message-ID: <20150911153530.GM20922@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150807121913.GS20873@sirena.org.uk>
 <CAAObsKCrakupiZMQ9AoiWo6fDYT6Cfi_khdssUS6pv61zYS1Zg@mail.gmail.com>
 <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
 <20150911095748.GC12027@sirena.org.uk>
 <CAAObsKAaxBJUH=u-2VSDGUQ6CsqpATpF-48LHEtvd3FD3_prsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60247 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbIKPfx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 11:35:53 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKAaxBJUH=u-2VSDGUQ6CsqpATpF-48LHEtvd3FD3_prsQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2015 at 04:06:07PM +0200, Tomeu Vizoso wrote:

> Once a platform device (with the platform bus as its parent) is
> retrieved from the deferred queue, both the parent and the device in
> question are locked (because of the USB stuff mentioned below). If
> that device depends on another device whose parent is the platform bus
> and we try to probe it (useless, but I don't see a good way of
> avoiding it) then we'll deadlock when device_attach locks that device.

Ugh, that's nasty.  Trying to fix this would most likely devolve into
trying to shove things onto the deferred list in the right order but
that's definitely a very different solution with problems.

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8vTBAAoJECTWi3JdVIfQmHYH/1w26xjIUDlT4O8IxqvkyoGh
BhTIIQWoiEWZXfJ96aNqM8l5Du35u0pac3Q12yRJr08EyTnFQmA7TQXb7yWlldoA
1Gkd4wkWQ8/R8Kcx+wbVXUKODgEcRcoV17bOoqA8Nfyd5nVUY2xW10jMf/AwpXXR
lm4MU0Wafx+1YnvfqcX0ZIIsSnQEcKKh5iLRsrdhjAnjXCI3qn0ZAs1abNRi+0BR
GRa3dx0DU+eVYl1VyddlYz2LIda2SnfxSfj/E7BVDXyEuSSLd6j+TUdzZdabjjWA
wvPtKKs7Ei7LaagpYS6JaMYyfNu2r8/uaOOcDZXjI89g2QmflY0RhyhaPpuSMgA=
=QJVT
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--
