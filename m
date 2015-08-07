From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 02/18] of/platform: add of_platform_probe
Date: Fri, 7 Aug 2015 13:19:13 +0100
Message-ID: <20150807121913.GS20873@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Eyt/adkQmNUuLj+l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org


--Eyt/adkQmNUuLj+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 04:11:39PM +0200, Tomeu Vizoso wrote:

> Walks the OF tree up and finds the closest ancestor that has a platform
> device associated with it, probing it if isn't bound to a driver yet.

> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a platform device should cause its
> descendants to be probed as well.

This sounds like it's going to break in the case where we have MFDs that
represent their functions in DT (not a pattern I'm a fan of but it's a
thing people do).  We'll walk back to the platform device for the MFD
function, try to probe it and then give up.  Perhaps that's good enough
anyway but it's not clear to me why we don't just try every parent we
find?

I'm also not a fan of the fact that the interface here is explicitly
saying that we want to probe a platform device, that's an implementation
detail that callers shouldn't need to know about.  From the point of
view of the callers what they're trying to do is kick any dependencies
into being instantiated, the fact that we currently try to accomplish it
with platform devices isn't something they care about.

--Eyt/adkQmNUuLj+l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxKJAAAoJECTWi3JdVIfQgzMH+wRH8m35h1fgololbPQJ40+Z
03tYcjBBpwQUa8upmWcOlkzA8pFDUYQpMh4ewr3cAQsjybStngo8x+chJ3kqpswc
C5LG1d/BonT2OJOANArLNfQdNoi0GQ77gBkpKVzWu3fzQaURHBfOwH3kB4b50TLY
p6FlDJrPQt1ThWV/riNrRx/Cbem2BDPjrrzDRoK5ujAppc/otK4OLHZKiBtkQG1f
RipxHP3QFpoV3bhI05E1ZP+BYVCU2wumJ2x3rlLzLj9E59DSN/YoyvTVFh9DZHdO
hRZFhf2O0unK3zsDK9h1iebu2JrYJ3KHQFuAqf1C44C8Lbpo1/7qShhJjoaA0Uk=
=gfpn
-----END PGP SIGNATURE-----

--Eyt/adkQmNUuLj+l--
