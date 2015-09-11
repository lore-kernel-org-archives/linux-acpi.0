From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 21/22] driver core: Start processing deferred probes
 earlier
Date: Fri, 11 Sep 2015 13:24:23 +0100
Message-ID: <20150911122423.GS12027@sirena.org.uk>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-22-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VP5QyDw/Nx1A2h9y"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60049 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbIKMYo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 08:24:44 -0400
Content-Disposition: inline
In-Reply-To: <1441628627-5143-22-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--VP5QyDw/Nx1A2h9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2015 at 02:23:46PM +0200, Tomeu Vizoso wrote:
> Some initcalls in the late level assume that some devices will have
> already probed without explicitly checking for that.
>=20
> After the recent move to defer most device probes when they are
> registered, pressure increased in the late initcall level.
>=20
> By starting the processing of the deferred queue in device_initcall_sync
> we increase the chances that the initcalls mentioned before will find
> the devices they depend on to have already probed.

Which cases do we have that are outside the driver model and thus
affected by this?  USB gadgets are one case I'm aware of, and cpufreq is
still problematic.  I'm wondering if it might be tractable to address
the actual problems with the remaining reliance on init ordering here.

I'm also wondering if we might end up running into situations where this
makes the problem with havinng to defer probes more of an issue on some
systems - since we start trying earlier while we are still doing our
first pass initialisation we could end up deferring some device then
retrying it a bunch of times while going through the earlier phases of
init as we continue to register more devices.

--VP5QyDw/Nx1A2h9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sf3AAoJECTWi3JdVIfQgrkH/1pUEr4SDBM77gU9koOCBWi6
ltw8MMtiBchWI8mRM1H+eikB2MQfuoKqGux+4/VKTef34K9zuMFNyGAl5KMyNhcc
wKU4wAMEi8KCgn5exQWQE7G1/pviyvnxGFSuHF9CLB0fSyqU7DUFLaaF86kz7RSA
JqZJAVHgDXeDXa/gbooODSnq5atV+hQ75JtfGoYxOA8V+680BkfT4SB2tJ7l3kVi
lBh0D35eRNaGMu2JSz+KpdlfGAO7C89oB+19LhOcXaVn03VsxUp/OfDt8HBnkvqa
8k5+aXnlCq9Xjq8QRGtUGYuoBppJ0w7kQJWXRPirXbBxRpDpfphvv21j3wukonU=
=vXhR
-----END PGP SIGNATURE-----

--VP5QyDw/Nx1A2h9y--
