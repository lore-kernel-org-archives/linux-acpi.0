From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 21/21] arm64: ACPI: additions of ACPI documentation
 for arm64
Date: Thu, 5 Feb 2015 02:02:18 +0000
Message-ID: <20150205020218.GR21293@sirena.org.uk>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-22-git-send-email-hanjun.guo@linaro.org>
 <54D16A74.3030206@linaro.org>
 <20150204181229.GB21293@sirena.org.uk>
 <54D26DA6.9000700@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/RVwTwS0WdRS2jHV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51294 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbBECDL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 21:03:11 -0500
Content-Disposition: inline
In-Reply-To: <54D26DA6.9000700@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com


--/RVwTwS0WdRS2jHV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 12:06:14PM -0700, Al Stone wrote:

> I guess what I'm trying to figure out is: how specific does this need to be?
> Does it need to be a step-by-step description, something like
> Documentation/bindings/submitting-patches.txt, or something far more detailed
> than that, with templates to fill out, and circles and arrows and a paragraph
> on the back explaining each one [0] :)?

I'd say it should have a reference to where someone can learn how to do
the right thing; explicitly going through every single thing here sounds
like overkill and duplication but it's also bad if nobody can tell how
they're supposed to diligently follow the instructions.

--/RVwTwS0WdRS2jHV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0s8pAAoJECTWi3JdVIfQCtsH/2taDJKxACNIemvXE2aoHZsb
3w3BVORx8MkDIa2o6L+ZKeRc9dtSQMK0IqiuoIGisIM7A1kq2qH9ep8qT6q7I54s
zqm+Jew5tmlzHdelMmq+bBd05AnhMGz8GXsfmeAakoDw5bLIghKJMjwam8l0GPTV
wRMNRg1B8Zlrt9+I024BAymt0N0K7rpq7OCvuI+mDngxtbaZYL/+wh58Guqw4ZNJ
SH8PH4UqSv0MaLpjGJnIwPQrrI7ZDv0Ax/rTjH8PO/6VmG7AbyxeDvHldP4oZh16
EY8hetnciFYjqJeBQGMpEFs2e/DYOQlk0PCdnNMcJDiVFsgHRV/h/4JynbcWUrs=
=MAP9
-----END PGP SIGNATURE-----

--/RVwTwS0WdRS2jHV--
