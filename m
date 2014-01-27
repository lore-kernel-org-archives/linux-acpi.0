From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power
 supplies to regulator API
Date: Mon, 27 Jan 2014 00:44:34 +0000
Message-ID: <20140127004434.GT11727@sirena.org.uk>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org>
 <2348079.FWLATJ4QDO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QgvTbcZPsSS/HkXe"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59853 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0Aol (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Jan 2014 19:44:41 -0500
Content-Disposition: inline
In-Reply-To: <2348079.FWLATJ4QDO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>


--QgvTbcZPsSS/HkXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 01:54:49AM +0100, Rafael J. Wysocki wrote:
> On Monday, January 27, 2014 12:32:14 AM Mark Brown wrote:

> > @@ -509,6 +510,14 @@ void __init acpi_early_init(void)
> >  		goto error0;
> >  	}
> > =20
> > +	/*
> > +	 * If the system is using ACPI then we can be reasonably
> > +	 * confident that any regulators are managed by the firmware
> > +	 * so tell the regulator core it has everything it needs to
> > +	 * know.
> > +	 */
> > +	regulator_has_full_constraints();
> > +

> That's going to be called earlier than it use to be in 3.13 and before.

> No problems with that?

All that function does is to set a flag - so long as we can assign to a
static variable it should be OK.

--QgvTbcZPsSS/HkXe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5avvAAoJELSic+t+oim90CEP/1A1wuAzkRFuRvdY1mKD+2uz
CNcryAMla4s/2O1Y4fq8zrx3i72h26VgvBcOH+YvupLCdPo79OWosRoLcOt+Zdw8
or8C4/LVc09lKJOn0gxQPjHeFzVuBeiCR3KU+3wIOGYI4AMlVukMmpv6ZMCWgbGv
XxX3SZQqBgGroKikzn0Q2h3F09c5XbxndcgDB7nBnnN4d6mOw9eKO7FfNOySGJph
Qn6U+mn2F7rPgTVHOQuxkwSb5KBhLik3ZhI2CsSzh/rXOx2n4S9Upevo873CM1Ix
ezc3IPpvoGhbiUBxD5QWcxD2o/DfDNXVF0Jx0QxstZLOvYK793/wP8Wi6b7jPnio
ucMdi0tnHNtZ/xY1NWzgyYGVurOcz42oNydMe4vmWYasMFlJkIHAFqq0D/lY8dsB
xQi9TM8H3L1c4bvUQ6vwdGWlTGFl05ByxnIOI3gIsc68jeIOKdg2VC9klWGysHU3
vyxu4znc0lUY/5R2rlXnDABTP7TlQCifCeLWLyJSbDuFqF0qiGJ/FUzNv4CLkpFw
tPELLMn2iO4SKuvsyCIUXcoyPfg/a8fvKkQzqwlHjSP9xoHV+5m+aQkP+OHhMuo9
17azyxQ1QY9vcLJMQvx0ayZcPrTJYx8ZeWzwvFJI9DosaH3C29SMC+Xv4jor67Fn
BCmmEEAQdu++Mom4yrwe
=0OQt
-----END PGP SIGNATURE-----

--QgvTbcZPsSS/HkXe--
