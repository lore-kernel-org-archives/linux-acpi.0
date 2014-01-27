From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power
 supplies to regulator API
Date: Mon, 27 Jan 2014 13:21:06 +0000
Message-ID: <20140127132106.GY11727@sirena.org.uk>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org>
 <2348079.FWLATJ4QDO@vostro.rjw.lan>
 <20140127004434.GT11727@sirena.org.uk>
 <3051988.Sav3BEhI94@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fzoBs0edN2XpEQF6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59992 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbaA0NVQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 08:21:16 -0500
Content-Disposition: inline
In-Reply-To: <3051988.Sav3BEhI94@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>


--fzoBs0edN2XpEQF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 01:54:48PM +0100, Rafael J. Wysocki wrote:
> On Monday, January 27, 2014 12:44:34 AM Mark Brown wrote:

> > > That's going to be called earlier than it use to be in 3.13 and before.

> > > No problems with that?

> > All that function does is to set a flag - so long as we can assign to a
> > static variable it should be OK.

> OK, do you want me to take it?

I'd like someone to take it :) .  I'd expected the default thing would
be for it to go via the ACPI tree but I can apply it to the regulator
tree if you'd prefer, either way is fine by me.

--fzoBs0edN2XpEQF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5l0/AAoJELSic+t+oim9YycP/RSTyNfeQQ0RZKgnD9BOt9nM
qhbPrfv3easSoQZoXUTy8KE1ZqdU0syl0fj5afU5jHAQKuldSHQZP0uWd5DWff+y
KRqbBB8lM65FKbgdyNlczeEBP/FOjj2FgbieoyaN42cWSD0cGwZ85kraOIK8uy7D
M58Zs/K9SMSk7Ekn2AuOnEBVt81mqDvqCXKCgZ56ymcy27yb7ecjyHl86USbLOQ5
gA3DqXI/gKBrmeLWhBu16VDkTW+owYSkISDd2506QskNHNO6c2iTo+tswRABsCF+
HO8kqvBAKkaDK9jzEX2Uvd1S+zgr+opr7eGdiiH8sK5uQAeXswt/mTDSmaockepY
6V69qQ1Mb83HuXSpZXe8IixCnEAL+gLcNC0ohzs2OFYE3KYcqKP8331QjsVYrMD0
G7X3fLr4Hs6wZVcZIxrPIA1kpcHVJGL9pyKclqWG5nK95iucP4uVxsvueXVeUZZm
/+ZUJrWw63/FiWPnrJypCm5kXmh2xZ/iopWt6W3wEnmalZDVVzW7ZWpw0G68t9CI
05pNxZhOM7QDfl4WOqLmfrGuY1pBGNb5xIkPfj1eyWDzqtBONH8RWh3cAGDwDnGW
pwAH5XWJ9KvbVP9qw9tY1PazchtQbsCHQBtUyQpRo9ipEMZbKiLVxQqdgdwTDLAh
CuZArAB4BdDegIiKZVTl
=R2gK
-----END PGP SIGNATURE-----

--fzoBs0edN2XpEQF6--
