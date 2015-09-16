From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
Date: Wed, 16 Sep 2015 20:35:19 +0100
Message-ID: <20150916193519.GO12027@sirena.org.uk>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
 <20150911120824.GP12027@sirena.org.uk>
 <CAAObsKBihtEeNN_NyTmB+U9NAJV6UmJ5LJrqBbO7h9KZPPh8LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uY8YgZGU3bP1woQT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38454 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbIPTfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2015 15:35:37 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKBihtEeNN_NyTmB+U9NAJV6UmJ5LJrqBbO7h9KZPPh8LQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Alan Stern <stern@rowland.harvard.edu>


--uY8YgZGU3bP1woQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2015 at 10:17:43AM +0200, Tomeu Vizoso wrote:

> AFAICS, this is a must currently for correct operation in simple-bus
> and simple-mfd situations, because probing order is currently very
> unpredictable and it's totally possible for the probing of a child to
> start before the probing of its parent has finished (if async probing
> is enabled or if a module is loaded that registers a child's driver at
> the wrong time).

Hrm.  That's worrying for devices that rely on peering into their parent
device for things...

> I would prefer if the core would take care of making sure that parents
> are always probed before their children, but the unconditional locking
> of the parent device stands in the way.

In the MFD case this is another reason for not putting the device
structure into the DT - if it isn't then the ordering is controlled by
the device being instantiated.

--uY8YgZGU3bP1woQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+cR3AAoJECTWi3JdVIfQ3FgH/RRb3FhR1metJYjPPQDfRL02
H9JOtVyczyi+ftL3oJQ/h99c0ZUPRSOKUOfwLU8To+QHgSL/d2dtwGOcmt4Yg58c
HdIcuxgqHA9tfK1oia7Aku+K31xVS6pGardmR0YRLJIbgSiCTr4Kdtg5c0R4Tq7c
OlBbDJGIvVRi1VJXMO0KPWEGsVMIuLKfzcd/JwTYACg5KEnGA/mBNrmotJHEZEzc
GhOzPJ6JpdE+INr+XFHZaS3IbbzV+vvW+hPB+HthHMrvXrTXfb8M8N9bqai2vQn/
hle0PZ8GQ0z/rEcD1daGcsilIJrAngHYj6Hu2t+epqjsftb4lWG2vvKfd5nKpr4=
=7Wtf
-----END PGP SIGNATURE-----

--uY8YgZGU3bP1woQT--
