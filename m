From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 20/22] driver core: Allow deferring probes until late
 init
Date: Fri, 11 Sep 2015 13:17:46 +0100
Message-ID: <20150911121746.GR12027@sirena.org.uk>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-21-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3wm5X47Ts/nUgpUh"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60037 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbbIKMSM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 08:18:12 -0400
Content-Disposition: inline
In-Reply-To: <1441628627-5143-21-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--3wm5X47Ts/nUgpUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2015 at 02:23:45PM +0200, Tomeu Vizoso wrote:
> Add a field to struct device that instructs the device-driver core to
> defer the probe of this device until the late_initcall level.
>=20
> By letting all built-in drivers to register before starting to probe, we
> can avoid any deferred probes by probing dependencies on demand.

Is this not going to resut in massive churn as we go through and set
this flag for a massive proportion of drivers?  Could we mitigate this
by having a first pass at setting this per subsystem or something so
that we get a good proportion of drivers with changes in core code?

--3wm5X47Ts/nUgpUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sZpAAoJECTWi3JdVIfQIMAH/2bbCnrLFaUxp/ZoelbqwPgs
Nsw+yuyvUJURjit/HFBbiEvJIxd801AR5d3uhTn9aOB3Wdq/r0QM6+HKdcJJpakn
d2zVjioNdCQebwCR7PD0hUzyX3QUXHm+LJ9bk5S8dRmxqN0Qwvlh5fAasrdy8G63
hEqznOBZi5LouUyCOIBZomZo5+LRTlxQbKvkkIYa9bJ1pIVBJHziFPfVnJHnUar+
KAg/wiSjpSMeyxMB0HxILsshgDu6ECbFKg/q0IwQv1uCZGFGryd5fbXfLkpCm4eZ
uRgbtYEUYuIy37X9eKWfFAw+aCp5gMlHl4xqBgZXJiEADk/iuAEGuMn4mv51gZk=
=YqJB
-----END PGP SIGNATURE-----

--3wm5X47Ts/nUgpUh--
