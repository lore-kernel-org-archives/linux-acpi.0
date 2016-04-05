From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 09:12:46 -0700
Message-ID: <20160405161246.GA1924@sirena.org.uk>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404214034.GL2350@sirena.org.uk>
 <CACRpkdZW83kOADo1WcYT=mc++ro3Xb7PS15zh+RkLnSxmbTZAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45290 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbcDEQNI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 12:13:08 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZW83kOADo1WcYT=mc++ro3Xb7PS15zh+RkLnSxmbTZAQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2016 at 11:00:50AM +0200, Linus Walleij wrote:
> On Mon, Apr 4, 2016 at 11:40 PM, Mark Brown <broonie@kernel.org> wrote:

> > So this is mainly targeted at modules being added to base boards?
> > Without getting into the binding at all here it seems like this is not
> > solving the problem at the right abstraction level.  It's exposing the

> I have seen the same need beyond strictly embedded (MinnowBoard)
> from the Intel camp.

> These chips with funny Atom-specific codenames (baytrail, cherryview,
> broxton, sunrisepoint etc) are not just used for these IoT use cases
> but also for e.g. laptops of the ChromeBook form factor, and the same
> pin control needs arise there, just at a different cadence related to
> product cycle.

Right, the chips are used in a broader space but in cases where they're
being used in fixed systems where we don't have to deal with repaceable
modules then the idiomatic thing for ACPI is to hide all the pinmuxing
=66rom the operating system.

> I bet they also have funny product-specific kernel trees :(

Yup, they do.

> Agree: work is needed here. It is a big confusion, the whole model is
> based around the configuration being pretty static as I recently
> realized when just wanting to add a runtime-detected LCD panel
> to a certain driver. No runtime patching of the DT or overlays or any
> of the sort deliver what is really needed.

Yes, funnily enough the CHIP people were just talking about that
specific case at ELC yesterday (they patched u-boot to parse overlays
so the kernel never sees the hotplug).

> The only thing I heard which was actually doing something sensible
> was when Matthew Garret once told that apple mice provide a
> device tree fragment to the OS on how to handle it during bus
> discovery.

That's what people are doing with the BeagleBone/RPi/CHIP/96boards case
- it's one of the primary usecases for DT overlays but currently
everyone's final integration layer is out of tree.

> > Obviously for the more general ACPI use case the idiomatic way of
> > handling this is that the OS should never see anything about the
> > pin muxing.  With DT we need to really know what's going on with the
> > pinbox because the model is that even for things built into a single
> > board the OS is responsible for managing the pins but that's really not
> > how ACPI is expected to work.

> See my previous mail for some kind of answer to this.

Yup, will reply there.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXA+P7AAoJECTWi3JdVIfQvLMH/0rYNHwSm1H69UpjjIWie//B
oICYLbI/XlJSIXDvBXLx6No5VKm9QpsxEgAWmXJ/rGyiIKNbhh8+fB01QN8STgKA
70iz2Su6c3c8quyuzV10h2Go+Uc2qWoc5Dy/dvaKOoN28dVocLuxvqnsjNFr0MXM
wwRQAUmk8Voxy9fU+F2eNR73CdgW5NjgqJ0lar15ljJa9AHoeyzNyUPAIV7T+JQZ
BV9FTWLp4j1BOROvcctryCYn/0hic6DuErhVeFt1Tc/Zpfh3qIxQHjud6hi2DvBX
/kpI2M72hIZh0e54gh1hCq+f/e2ewO0e40w+GMl/y5RplhdJZ58SrBA8rbnT/Xo=
=Iu9o
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
