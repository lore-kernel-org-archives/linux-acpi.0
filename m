From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 10:31:25 -0700
Message-ID: <20160405173125.GF1924@sirena.org.uk>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404214034.GL2350@sirena.org.uk>
 <CAE1zotLcLFACKFaPgp2QUK=6qhWvUGu7hmbK+-XuL7+5arBXVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotLcLFACKFaPgp2QUK=6qhWvUGu7hmbK+-XuL7+5arBXVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, mark.rutland@arm.com
List-Id: linux-acpi@vger.kernel.org


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 03:51:18PM +0300, Octavian Purdila wrote:
> On Tue, Apr 5, 2016 at 12:40 AM, Mark Brown <broonie@kernel.org> wrote:

> > So this is mainly targeted at modules being added to base boards?

> That is the main use case, yes. Velocity of platform
> debugging/enabling is another one.

The speed thing sounds like someone needs to work on the tooling for
working on firmware TBH.

> >  This means that any binding of a board to an ACPI
> > using system that just uses this is going to be entirely specific to the
> > particular combination of base and expansion board even if the
> > electrical connections are standard.

> This can be solved by tools that work with high level abstractions and
> generate this specific information.

Simply stating that there are in future going to be some higher level
things which make use of this firmware interface isn't altogether
reassuring when we're still in the process of solving the issues for the
DT version of this...

> > This is something that people are currently looking at for DT, there the
> > discussion has been about defining the connectors as entities and hiding
> > the details of the muxing on the SoC behind that along with higher level
> > concepts like instantiation of buses like I2C and SPI.  It seems like if
> > we do want to try to share between DT and ACPI we should be doing it at
> > that level rather than dealing with pinmuxing at the extremely low level
> > that pinctrl does.

> At some point we still need to poke registers. We already have a
> drivers that do this (pinctrl) and a standard configuration interface
> (the pinctrl device tree bindings). It seems natural to build on top
> of this for those higher level concepts / tools.

Both DT and ACPI have a system model behind them and they're not the
stame system model.  Importing one into the other directly without
carefully thinking through how they play nicely with each other seems
likely to lead to problems further down the line, you might know exactly
how you intend this to work but how do we make sure that a firmware
author in some system integrator knows about this and is able to safely
write firmware in a few years?

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXA/ZpAAoJECTWi3JdVIfQi7IH/j5oprmSwIrvfgV9B4EC17lV
Jke/IgGvCWZ+5e2WhB8j6EGzMFQ+To/Stp8k5+iIzmmjPu/3VTQgCRGovo0XnOee
MkMRm03fbtb+9ZmEMHVjZaRVgSBP32DzMQ5D/+fNphNFszftpIk/PJy+tNDtbcZm
SiOyuRBnpOk62bgZlMwxjIyxrv5pyN3mbokDmbmeDbRmmrzuf+inqnd+sb5oH6Xu
OZdkIhuHlZzaAexDO1iZYfqFRNWhlQiW4liNK2ZS702SJvJ2jFc3oB49LuzLMjVZ
8MfqztvBx3QnBv5PIhe1e79YGZRRVgEUOmCH+rKVM2vEdl6zinZbJJlXBUK8A7U=
=jjXV
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
