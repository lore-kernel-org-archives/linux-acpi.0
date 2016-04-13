From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Wed, 13 Apr 2016 06:25:53 +0100
Message-ID: <20160413052553.GF14664@sirena.org.uk>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36578 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327AbcDMF0L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2016 01:26:11 -0400
Content-Disposition: inline
In-Reply-To: <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 06:23:15PM +0100, Catalin Marinas wrote:

> I'm fine with dropping the EXPERT dependency (of course, not a cc
> stable). While arm64 ACPI is not "done" yet (nor is DT; there are
> important ongoing developments like PCIe, IORT), I think the core arm64
> ACPI support passed the EXPERT stage. I also don't think a default y
> would imply any maintainer endorsement; vendors targeting ACPI are
> already doing this for various reasons (distro requirement, certain ACPI

So you're OK with the current patch?

> features like RAS). But, hopefully, it will encourage more vendors to
> start upstreaming their ACPI-related patches.

Yes, and also help include ACPI systems in the work we're doing testing
things upstream.

> However, building ACPI by default on arm64 doesn't mean that we can
> ignore potential misuses like PRP0001+_DSD blindly following DT
> (mis)concepts, breaking compatibility with older/newer firmware (this
> goes in both directions) or using ACPI for SoCs where it is clearly not
> suitable (e.g. non-SBSA). Such patches should be NAK'ed accordingly.

Yes, I'm very concerned about some of the activity I'm seeing there
myself - it does seem likely that we're going to have to extend ACPI for
arm64 SoCs simply because things like SBSA are so bare bones but we need
to pay attention to what's going on there to promote best practices and
try to get people producing firmwares that make well thought through
decisions regarding their ACPI usage.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDdhgAAoJECTWi3JdVIfQ4XQH/0auTfXEh/yqmc+B11PJAjNk
9co2zlQSEPr2x1cXu8RiJTUvkzRJIEfBurOTJcQIVciG7Q2xBYKLY6WX7enFm8qW
jA0+KMIK1Px8AymmyZ4ioWEclcgKEJnVQqXyjWxQ9z3IPY6D03sZqU+CPz9h9DnT
6BabsbLi01FZadizMuNoCv2QTvxgvmu1NYDW99/erd+YKDvForrdflk160y7uGU1
0Epn764F3OGqxKu5bv9WgsdJpkqh4ph2lv+JKcertPZq3z1l26yu5c2Kx+tKXymk
6GoodS6Lh0XfUVy8rg8AzAnDU70P22v8h/re6jlH9qqyB7WP9j/AMV6cPs0hWMQ=
=m/Ri
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
