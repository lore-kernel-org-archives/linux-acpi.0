From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Fix modalias for ACPI enumerated SPI devices
Date: Thu, 10 Oct 2013 19:16:37 +0100
Message-ID: <20131010181637.GT21581@sirena.org.uk>
References: <1381414757-26173-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4JYkiJ1a9n8r8Bnm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44366 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab3JJSQp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2013 14:16:45 -0400
Content-Disposition: inline
In-Reply-To: <1381414757-26173-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>


--4JYkiJ1a9n8r8Bnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2013 at 05:19:17PM +0300, Jarkko Nikula wrote:
> There is a minor fault about ACPI enumerated SPI devices with their modalias
> attribute. Now modalias is set by device instance not by hardware ID.
> For example "spi:INTABCD:00", "spi:INTABCD:01" etc.

Applied, thanks.

--4JYkiJ1a9n8r8Bnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVu8CAAoJELSic+t+oim9SV8P/iWKESX4de6B4H0UODPNimI/
W9EeO72eV1/j07F3GoVGR2ELfMYtryOupMt7Oll3+gSm7HfuedLr8yjPKQIYdiAq
9tCp9sgP1LG38xJJaizzjRXPjPWQBc+9EUxVUXXdwogP1bK7DvCHo5op3sjeawCL
4lY9JLAaXErwpcVCjziz23uT/UI6LMfgA39HbJpAmbDOWBGE4tqSLTHE9s/bwSel
6gek55G5PiCiCZcl7TkLXhmbI6/vqrD1+/HyD+k5f6MWIkvUO+mpTWQ/Bu+HnH/m
2y5VJDi61s0cUC73n/qi/7vzhUu3Qm2Xitz7wBIipyPnXzKPGvZ/yyTRACkD3yzL
XAwG3dLq+yQ29Fgxw4LdNRxbfr7Q5syBLXT+pk0AL87az79rdYK2jJBMbIGlJ1hN
DNbgTt6qncJ1ukgw6mMEbpANsNAOuomLp+aoRTwizPT+11ELQzDnRWy14JYn42lN
0ccUnBXHBVzdcpZSV69k2sO+SmY/T/GXjYiNU4uCv0GeWY4SdVTtT5UHsxT65R/2
JjammGmyxA2K6v9jogp7/Z34QeXFrTbOAO8Zr1mP81SHh9uRHakJkgwrto4bYWPg
PTte0hQwTvY713VoyKIwRO/FdqNVrtK8+7EBNqjeeztdSKPw/522ITX6OmT9zmh6
s3nQRwv6EhSE6xgix3P0
=stwq
-----END PGP SIGNATURE-----

--4JYkiJ1a9n8r8Bnm--
