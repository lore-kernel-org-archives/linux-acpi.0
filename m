From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 07/23] regulator: core: Remove regulator_list
Date: Sat, 19 Sep 2015 08:01:29 -0700
Message-ID: <20150919150129.GR12027@sirena.org.uk>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="55BQxs/tzKPczcTk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org


--55BQxs/tzKPczcTk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 02:57:01PM +0200, Tomeu Vizoso wrote:
> As we are already registering a device with regulator_class for each
> regulator device, regulator_list is redundant and can be replaced with
> calls to class_find_device() and class_for_each_device().

This appears to leak references to the struct devices returned by
class_find_device() - it takes a reference before it returns so any
device found using class_find_device() needs to be released with
put_device() and I don't see any new put_device() calls in here.

> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None

This is not the case at all, this patch was newly added.  If you want
to include changelogs like this in the patch description try to ensure
that they bear some relationship to reality, if they don't they are
actively harmful as they are likely to mislead or annoy the reader.

--55BQxs/tzKPczcTk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/XjIAAoJECTWi3JdVIfQyZIH/0fiZnlocw3ABt0s1/Kpabky
QIxkNj8r1pYrYVDhQCsLEbZ2+kYufFeRoL3FcWOLbubWw/InFyMKWj7CmEJRN3CR
W2LTCLqeRy+tjScE7+xt84NA6s9aKJwBCT6NP6vwNYU6EdHwmmbfiXX4olJP30mx
nVEVZrKTI4Ix4intQspgSUsCWir2GToc44wzIVqatBF/iRk0kAjwii1S27007x1N
ScmDZ2nPsVrqpHzTZXZSaApZPxwTd4ylCSFHUv67EWtgGTqG1DvfkMd7mYqvFLw6
E79T5UqxD2+tc2FX5tMBHFT9ETFnKX3CFXqIPX55xg2ZToYLKvKiOvB7WmBOAco=
=yWQv
-----END PGP SIGNATURE-----

--55BQxs/tzKPczcTk--
