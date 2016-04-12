From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 12 Apr 2016 13:15:33 +0100
Message-ID: <20160412121533.GB14664@sirena.org.uk>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <CAE1zotJ4OiQ_tMvCDm-KoF8cTJ9Z-n09FX7KR75j0DyAcsznLA@mail.gmail.com>
 <20160406103925.GA31110@svinekod>
 <2161127.3msi2j0Rxi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34896 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbcDLMPs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Apr 2016 08:15:48 -0400
Content-Disposition: inline
In-Reply-To: <2161127.3msi2j0Rxi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, "Tirdea, Irina" <irina.tirdea@intel.com>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 11:24:00PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, April 06, 2016 11:39:27 AM Mark Rutland wrote:

> > The ACPI model implies FW-driven pinctrl management, so if we're going to put
> > the OS in direct control of pinctrl, we have to make clear what expectation FW
> > and OS can have.

> Well, orthodox ACPI people from the Windows camp would definitely agree with you,
> but I'm not one of them, so let me play a devil's advocate for a while. :-)

> IMO, exposing anything in the ACPI tables without explicitly saying "but you
> should not touch that", eg by defining an operation region covering it or similar,
> is equivalent to giving the OS a license to play with that thing as it wishes.

> Therefore I would regard exposing pin control information in cases when the
> OS is not allowed to use it to its fit as a firmware bug.

This is something where it seems like it would be very easy for people
to end up relying on current OS behaviour even if that only happened
through accident rather than design.  You might assume that such
behaviour is a bug but that may not be obvious to the firmware author if
the OS behaviour makes sense to them.

There may also be some expectation on the part of firmware that the OS
will do some management of the pins even for devices that it's not
actively working with (put them in an idle mode for example).

> Now, the question in this patch series is how to expose things and not when to
> do that.  It adds support for a specific method of exposing information to the
> OS, but should it be concerned about the possible consequences of inappropriate
> use of that method by firmware?

The other issue here is that if (as Octavian mentioned) there are
ongoing discussions within ASWG on producing an actual spec for this it
doesn't seem great that we'd just go and do something completely
different rather than trying to make sure that the spec works well.  Or
if there isn't any spec work then writing one there for other OSs to
pick up if they like.  This seems like it'd make us much better
community players.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDObkAAoJECTWi3JdVIfQdqwH/32gASzKWbp4mfuKkbeT1UY0
4fYAHF5sMamIjPt7SXumZKyHULkwNfLgai2C3rNvgbg0pyD4QyEhNih8nviWbXki
+iuQQKu7ARBgG7P4YwbqTdoij1ClwdEytjRvpEpY+q47oE6BZ5B74YqOK5dO1umI
J8MeYv9ZqOakHXwaKx67gp6Ua+lwRmqKL9pHTweNvxJJc7iNiHSzcfrwV7wK8+jr
ENNMTFu9a+5bkc2DeLAcbMW6ESQ2dkcqHjlGDtS3q6CnRq5B1MBUnu0+7Iri7iOu
0XUsZIkz95SNG8SEgqyMLxD1MKEHT0iAeojHRGycOR9lTyOPd2FU8Sv35KoSy48=
=/hjS
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
