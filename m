From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Mon, 4 Apr 2016 14:40:34 -0700
Message-ID: <20160404214034.GL2350@sirena.org.uk>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jZUYryPdXB7p5neD"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--jZUYryPdXB7p5neD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:

> This is a proposal for adding ACPI support for pin controller
> configuration.

> It has been developed to enable the MinnowBoard and IoT community
> by providing an easy way to specify pin multiplexing and
> pin configuration.

So this is mainly targeted at modules being added to base boards?
Without getting into the binding at all here it seems like this is not
solving the problem at the right abstraction level.  It's exposing the
pins on the SoC directly without any tie in with the functionality that
goes over those pins.  This means that any binding of a board to an ACPI
using system that just uses this is going to be entirely specific to the
particular combination of base and expansion board even if the
electrical connections are standard.

This is something that people are currently looking at for DT, there the
discussion has been about defining the connectors as entities and hiding
the details of the muxing on the SoC behind that along with higher level
concepts like instantiation of buses like I2C and SPI.  It seems like if
we do want to try to share between DT and ACPI we should be doing it at
that level rather than dealing with pinmuxing at the extremely low level
that pinctrl does.

Obviously for the more general ACPI use case the idiomatic way of
handling this is that the OS should never see anything about the
pin muxing.  With DT we need to really know what's going on with the
pinbox because the model is that even for things built into a single
board the OS is responsible for managing the pins but that's really not
how ACPI is expected to work.

--jZUYryPdXB7p5neD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXAt9KAAoJECTWi3JdVIfQd/UH/jKV4Z1HXGfpjEPvWmgn8xe3
PSAjr9/SDWG+dmpYWAdDfflPCH1CyfsczQADMRw1413mq8J8EVQSrlz6tRbwN7w3
yZPgrnbVV/d0kxiFtehr9L7sBVQjHsQkG9TotGc58hPqop5klncAMgy936dp8wx/
q+sIyzTTuSEltWUJn9fSiIV8jbt8905MbQc/dpoxVwOv7Im0LrsC+DYNpVIipeoP
QrGGHSSFNJyjP4PTAXQVH24K9V5hWEfaNBPZ8oCVZNDBZIKHToZzcBIg3TgxfYWx
6aerGv8W2cyI8Ku/aRepdJ/cf68zPOpOxOJeMEPQ7EtGDw2enA8r1b5rBPFRwU8=
=qsye
-----END PGP SIGNATURE-----

--jZUYryPdXB7p5neD--
