From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power
 supplies to regulator API
Date: Tue, 28 Jan 2014 12:21:06 +0000
Message-ID: <20140128122106.GA11949@sirena.org.uk>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org>
 <3051988.Sav3BEhI94@vostro.rjw.lan>
 <20140127132106.GY11727@sirena.org.uk>
 <15814871.c5vzFttNXX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60588 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbaA1MVT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2014 07:21:19 -0500
Content-Disposition: inline
In-Reply-To: <15814871.c5vzFttNXX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2014 at 01:06:45AM +0100, Rafael J. Wysocki wrote:
> On Monday, January 27, 2014 01:21:06 PM Mark Brown wrote:

> > I'd like someone to take it :) .  I'd expected the default thing would
> > be for it to go via the ACPI tree but I can apply it to the regulator
> > tree if you'd prefer, either way is fine by me.

> I've queued it up for my next pull request, thanks!

Excellent, thanks!  Could you tag it for stable please as Jean
requested?  In v3.13 it fixes regressions in lm90 on PCs if the
regulator API is enabled (which unfortunately Ubuntu did so it's
a real scenario) and it should be safe in older kernels though I'm
not aware of any actual systems that are affected.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS56CvAAoJELSic+t+oim97qIP/RTtZiqHnyiFU7f2xkov8glU
QGygSSCW5n2a1hfWfkgJGyxR6xQ4XUfyVwGnvFpmXjyCexgxtIxbU8z8afnlSS/X
V31SYqoDmx2WFTugbKGPgZiHvyprLQLfHbVljTgImzM2+U/88NOPPDkVyWFSstMb
hVYpduHQbgGBBFQBRiWpvs/sfCmhu5rWDoDn2Cu3hREeybQUbHwgEwc8g11zMgyT
aFY/M24070JbbC7gTilnK0HTaUTlwLhPIBBlJCXJ/7JkGk7Ir69YgyLU/z2DtKFu
retgbtrXwzHiTpieDiTS13caRcK+cyUba5p0RVj9uS9tqFJVvyGigxYD9vlwzHRw
awx9Jm39Vg1F0PV86a1ZNQ/DDZgbc5jj1jyhPYzBKK7oJDSeMaIjd/uJu9zFVoLl
vQzz9QE+Nle0g4L1fpZGJIdjT/t+5ue0jF2FKI6awy0cjT9G7mvGS+fVdhOW8WY9
PPDseVpjLtOpf6yEuXNGdiqvioTitOEMhTLhe6Nt0dM9x5qY1AmEID55z53Oy9Cc
b3PNL8ibvn01KTjvjKwvyiE2ATCF/hljzXgx5qYbv48e3fMs4MQU4ICT8azV8o74
GkQdbd6NLaXwIFaMwmhtB5gSXmQ0uEB8Q7BFfkWjArZNTguru16TMA+SFZUBibly
PHRYJQIxSIw168HfOjCx
=/Pbu
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
