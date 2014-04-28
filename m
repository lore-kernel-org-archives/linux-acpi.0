From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 part1 07/11] ARM64 / ACPI: Introduce
 arch_fix_phys_package_id() for cpu topology
Date: Mon, 28 Apr 2014 09:50:29 +0100
Message-ID: <20140428085029.GB15125@sirena.org.uk>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
 <20140425145249.GP12304@sirena.org.uk>
 <535DC431.4000900@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47531 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbaD1Iu4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2014 04:50:56 -0400
Content-Disposition: inline
In-Reply-To: <535DC431.4000900@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 11:00:01AM +0800, Hanjun Guo wrote:

> Since platform software (firmware) knows the topology of the system, if
> ACPI describes a slot number for this CPU, I think we can use it
> unconditionally.

Right, the only concern with that is upsetting the scheduler but since
x86 does the same thing presumably this is safe.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTXhZSAAoJELSic+t+oim9WJkP/A1iejSvdtMK5VCpJMlvjp+c
2z9fwN70RY8p6nhOaX6IyYGRtYmZq3O+8llU2paYeEgLb/JQcIiZpemg8K/egqpQ
gnp/CymH/AHAPa/M6Yi3EzkcIaZchvIxvtRx4qZfhNLofTa4mKScvvuK4HEZMW90
w2XX4DEXL/bpnGNZeZ5dhzv/N4BGbj6pfiyCvMW+WDZ9pOQIVQZygRCeEdyG50A3
OPZHo2KMbWkGmREHkF+EOXcUDR+dk5DBUfYLGw6LUJB3n1rdPAL6h2qTuCqJZUJV
5533IiGdDCEGOQAx9fd/BXnrOYq3X1tx2TIWW9v35RZ8bP61+r+iN+oib26cgPMb
rAa+gkhNJNfj25dz+TzzsGIr8UCEwxCOS6ZMzT1SRGWSXzqOtnPfdNCZwoXyzF7P
RfAz9zC2iXTFZVUcaW1l1HqqqYxQ6Sa+/eTwqClQUnBUNCjW0ALzsnIK4YhG6tGB
el4GyuY9eNtW3VYB+ROhHdPyhcFn58RqScRiC962LmUXWh9E/rXk5p9j/hV5wM1t
+BebT+H2jCHNmq/OM4U0FanPsuAMgo7i5TiSdjCcIOOvm46+Sqe2i5++UAUywTE7
fBdWZxrlaGpwsfsA8X2ioONa1WC+5Y/ZEDj82T5tK63xlgL2vYEpBxCUSL3FeHuj
e0rqWrWaNEb21i9Y49vI
=BUkA
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
