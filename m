From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 02/18] of/platform: add of_platform_probe
Date: Fri, 11 Sep 2015 10:57:48 +0100
Message-ID: <20150911095748.GC12027@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150807121913.GS20873@sirena.org.uk>
 <CAAObsKCrakupiZMQ9AoiWo6fDYT6Cfi_khdssUS6pv61zYS1Zg@mail.gmail.com>
 <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4bvUAv41pAMZZO4U"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59759 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbIKJ6V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 05:58:21 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--4bvUAv41pAMZZO4U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2015 at 02:31:06PM +0200, Tomeu Vizoso wrote:
> On 11 August 2015 at 11:37, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> > On 7 August 2015 at 14:19, Mark Brown <broonie@kernel.org> wrote:

> >> This sounds like it's going to break in the case where we have MFDs that
> >> represent their functions in DT (not a pattern I'm a fan of but it's a
> >> thing people do).  We'll walk back to the platform device for the MFD
> >> function, try to probe it and then give up.  Perhaps that's good enough
> >> anyway but it's not clear to me why we don't just try every parent we
> >> find?

> > Agreed. In the attempt at probing dependencies before a device is
> > probed, I considered that a device's parent is also a dependency and

> Actually I'm not sure how we could probe the ascendants on demand, as
> currently the parent's device lock is taken when probing so trying to
> probe a sibling from within a probe callback will cause a deadlock.

How do silbilings come into this?  There is an issue there but it's
going to happen anyway.

> AFAICS this is only needed for USB interface devices and this
> behaviour could be limited to them, but I don't like much assuming
> that no USB device will ever have a dependency on a sibling (though
> that probably won't happen ever).

I don't see the connection with USB here, sorry - my initial thought was
about MFDs?

--4bvUAv41pAMZZO4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8qWbAAoJECTWi3JdVIfQtRAIAIKSMpgbcRgxWdpNouUsNPIA
hJ8YYMUQ3lNONrAxmnbe2ShJquLWAyDclJxktCTF5O0bUR/YBRtSsCw/VNs1QVHa
gkef87/G3//3dKHJiKSFuBNtDoyY6sbCMTCINoJbnhIj3I9HEkdOu5jJE8jv0XwT
Vah+s1XtZw5FxG91HPA4OlTFIFa6QUUc5PnvcfTPcazQpg6UNIf2FxjKdK5rYHcd
obHUqJp27OFhSqs5ThH1kfvqVmwCyZ6IMyIgyyMhUW6cwmzTjbkxh64Gam4fvylP
Ys/FqyFAz6+5YZkwsIyhq8BsDcR8Y/Kjqs1e/AnVoYzKVSzjizCUuURPBjorEt0=
=Dg+/
-----END PGP SIGNATURE-----

--4bvUAv41pAMZZO4U--
