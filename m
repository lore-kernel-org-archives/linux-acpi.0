From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Thu, 14 Apr 2016 19:25:20 +0100
Message-ID: <20160414182520.GA8663@sirena.org.uk>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
 <CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42106 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbcDNSZh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Apr 2016 14:25:37 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2016 at 11:02:15AM -0700, Olof Johansson wrote:

> Switch the default from y to n on ARM64 (or default !ARM64) and I'll
> be happy to ack it.

> Mostly because it doesn't make sense for people building their own
> configs for embedded systems to get it turned on by default. Anyone
> running on a server is likely to clone an existing distro config in
> the first place.

I can send a followup patch for that (I actually already wrote that
after the discussion with Will), but I do think we should enable it in
defconfig for the testing.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXD+CPAAoJECTWi3JdVIfQUEwH/jxMHLGMSfxwbWn9zOuQlm6v
h+pMrfEz/ElCTby2D9nBw+4jLLF70kMli1p82ZJQRd8eGi8HT04jdSM4WJWFKExE
e1nsiCADUqwwf4wdvzKSzX2EgqbKGEulswIYHfGSIJUkcjIlEQgFcDSRq5e/LgZ2
PJPjBl6w9KfZ3XuLFJ0P1E4DnhY1cn8GPc+RQ2H27nB4igIrJHE9nvc1vU5c6KLh
QP//rVX9koqcxfsfMWhv+yNwYHp6QGmxEWGqi6UIYCcHNHoXiaO0BZ1ZG40x0NVo
1Z95NvqrEu5N1jlNdyE8jGQIb+otyzy3WL/ch9DCtxiKOVQsL1TsmUCmGvTa8BU=
=9WRY
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
