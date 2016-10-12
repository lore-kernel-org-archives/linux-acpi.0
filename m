From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 12:28:36 +0200
Message-ID: <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade>
 <20161012090003.GR2774@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i2q2e5ptte4o4j7l"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56140 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbcJLK24 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 06:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20161012090003.GR2774@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, robh@kernel.org, ahs3@redhat.com


--i2q2e5ptte4o4j7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2016 at 12:00:03PM +0300, Mika Westerberg wrote:

> The _DEP method should be used for Operation Region dependencies but
> here it is used for functional dependencies so that the audio machine
> driver can find the corresponding codec. Why Microsoft used it like this
> and not pushed it to ASWG to be added to the ACPI spec? Should we now
> refuse to support it in Linux on the basis that it has not been
> discussed with ASWG and it abuses _DEP?

The fact that the ACPI community hasn't been doing a good job of working
together is essentially the issue that people are pushing back on here. =20
We appear to not even be trying to set a better standard for how to do
things here.

Sitting externally to the group at Intel doing this it really looks like
there's been a decision to mirror DT into ACPI en masse.  If we really
want to do that we should actually take that decision, preferrably with
at least buy in from other ACPI users on Linux and with some review of
existing ACPI standardization efforts to make sure we're not duplicating
work there.  Ideally we'd also be pushing anything we do towards ASWG
even if just as a fiat accomplait.

> > By copying DT, but changing a few things, we're in effect creating a new
> > ill-defined Linux-specific standard. If we're going to create a new sta=
ndard,
> > we should go through the ASWG, and make an actual standard. If we're no=
t going
> > to create a new standard, we should use DT directly, rather than trying=
 to
> > force DT into ACPI.

> These boards we are talking about ship with ACPI based firmware. We
> should not expect users of those boards to be cabable of replacing the
> existing firmware with DT one.

Since we're still at the point of defining bindings hopefully we're not
shipping yet...

--i2q2e5ptte4o4j7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/hBQAAoJECTWi3JdVIfQCToH/RW8KVTaXCP2xSGvMXopo9MH
9oDMmk78RxL+EJXVmwsXfWSzj9VIaAImAmDhssUsoovWTfjUW0fbImd/9d3ITC66
3oUOIONX48p7puykA9CM8e+SYtEqJG+OggorvALZ+cJoeu0P4v4BUZJVsflSaEgP
revMNKNxeJjuhfzJGOrGt4JWsK84khpYue6DKToynDNHPeAXnNotRXymexG0AbDr
Rt4A17gy4JON53Vp/sk1Zy+7aCA2k0HGSadOCypIRaKbn+JLnwWQn9mmGdBAHVtb
Pf45D30lCcIHT2YW5FegNtfuatU95Nu8CHZ0iaLg8CpSUkO9TSpvUWvwRxyak0Y=
=rLid
-----END PGP SIGNATURE-----

--i2q2e5ptte4o4j7l--
