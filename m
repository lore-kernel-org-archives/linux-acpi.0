From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power
 supplies to regulator API
Date: Mon, 27 Jan 2014 16:25:55 +0000
Message-ID: <20140127162555.GB11727@sirena.org.uk>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org>
 <52E6741B.2010002@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3+4H5zObBQkbFbMG"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60044 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbaA0Q0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 11:26:08 -0500
Content-Disposition: inline
In-Reply-To: <52E6741B.2010002@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>


--3+4H5zObBQkbFbMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 06:58:35AM -0800, Guenter Roeck wrote:
> On 01/26/2014 04:32 PM, Mark Brown wrote:

> >control at all. This means that if for some reason the regulator API is
> >enabled on such a system it should assume that any supplies that devices
> >need are provided by the system at all relevant times without any softwa=
re
> >intervention.

> Couple of scenarios where I don't entirely see how this is expected to wo=
rk.

Please do note the above section of the commit log and in general try to
understand what happens on systems which have full constraints.  As you
have been told you appear to have some substantial confusion in this
area which is not helping.

> - A system which uses CPU cards which sit on a carrier card. The CPU is s=
hared
>   across multiple carrier cards, and built by an OEM. It supports and use=
s ACPI,
>   but ACPI only knows about the CPU card and not the carrier cards, and t=
hus does
>   not know anything about the carrier card power or regulator requirement=
s.

Unless the support for the card says otherwise the system will assume
that all power supplies are taken care of transparently in exactly the
same way as it will for components on the motherboard.

> - A system which supports a large number of complex OIR capable cards.
>   The card connector includes GPIO pins, I2C busses, PCIe busses, and var=
ious other
>   functionality such as SERDES lines. The card functionality is determine=
d by the
>   card ID and not known by the time the system ships.

Unless the support for the card says otherwise the system will assume
that all power supplies are taken care of transparently in exactly the
same way as it will for components on the motherboard.

> - A USB-I2C or USB-SPI adapter connected to a standard PC. Any I2C or SPI=
 device
>   can be connected to the I2C or SPI ports.

Unless the support for the adaptor says otherwise the system will assume
that all power supplies are taken care of transparently in exactly the
same way as it will for components on the motherboard.

> How is the firmware expected to know about the various devices ? Is the a=
nswer
> "sorry, this scenario is not supported by the kernel" ?

The firmware for the motherboard is not expected to know anything about
the supplies for the various devices either on or off the motherboard,
you will note that this change does not add any code to parse any data
=66rom the firmware (since that data does not exist).

--3+4H5zObBQkbFbMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5oiQAAoJELSic+t+oim9pHcP/2vEeQzIIFgaDWR6EfCknWh4
79Pnn/BmBbaE5juyy1/7cCkhUizFQTQJnJdfmNJtCjcCvXJO+3K1W+xP9m30N39J
kBiMMsoKbNKalSggjkoXjM4x4INp8caT+27I/Q+PmNjss+pCOdE5Sc7NzC2XdwTn
BaaL+/EBcuiaIbhzq/t6w8AyK0YBYDHSZNIZG5/2qPICci2R7bjjaFgi5AqMdjQj
9GVQQ3Ly6sQCAFVGLBSh7LR8q7T9lNt/QeirR5zPprG3q5P/Oi9pz0/4xwNWi23D
gkFPAFFSwZ+ayuYhgxGOkjxkuYaL/azsv8FUXLTrKdLpOvCMcyX2kJRRanWYdgIs
IaAKdCujW3BRxHnLg2XgAv5R/FgKUK08au/Tsx5KDQ0BDlCiH5JUx3y9Sa5IEV9m
Sp+VJ/uKFF1hibb746s1OgzFpqr7VwllJAcirhvZjmtnao0YnmGEDkJuJKQRhbcs
g6AXdYux6tEIFQ1fCZVLE3+vgMoAUVP8C4XgO89ZFZN10hpb6fc185uGQ7UpSX4Z
0boFBx+GYtYM/pv5cttBuviIy05uk+DjIIdqTLtgOe/kBLuUOTJ/tC02PH1Y94w/
j1gWwD4qRkgAax2qBb9Er9roJARCKHwSNhBhuURc/9gfRk1CQtdGuOJfUxbN2gmG
C8/1LTjCexE3Ro/NoAWV
=dmxO
-----END PGP SIGNATURE-----

--3+4H5zObBQkbFbMG--
