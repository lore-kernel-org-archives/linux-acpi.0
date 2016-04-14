From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Thu, 14 Apr 2016 19:56:08 +0100
Message-ID: <20160414185608.GB8663@sirena.org.uk>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
 <CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
 <20160414182520.GA8663@sirena.org.uk>
 <CAOesGMiqpm1TjiOpCv+kYp60FrhRhs3Leomv5KyySk8k15YFNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42172 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbcDNS4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Apr 2016 14:56:23 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMiqpm1TjiOpCv+kYp60FrhRhs3Leomv5KyySk8k15YFNw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2016 at 11:49:11AM -0700, Olof Johansson wrote:

> So, to clarify: a follow-up patch (to arm@kernel.org) to turn on ACPI
> in arm64 defconfig, and a respin of this patch to change the default.

Yes.  Well, I actually had and additional patch to change the default to
be y only for x86 and IA-64 separately to this one remove the EXPERT
dependency but that's just bikeshedding.  Will send tomorrow unless
there's other comments.

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXD+fGAAoJECTWi3JdVIfQzdQH/jCXSUbG1cSQOPTwo5n+Sw/z
+c+BnrLrvi9W3IMqgJurkmukFrWS+OYNBTtZc/qx1LQudNLMiWqyHTHQh7qAVF/Z
mv/pbEUfH6wjx5uZRqGE7RTcXhxSlKj8E6DLV0qpnlIHu+/a86n4IU9N4OFoZBLE
0RT0c6N+Bkqne2kaDc+wonibX01ea4ahB+8nhXvdxAobXPo5ceFFoGX2u5s5+k+9
FStC/7JmaBI9LWE7nWYuo76uh43uhE6D1F/iAsSHH0dFFVb59pBAxwE/VoCfMI7V
HrZqKuc7FTySGYIwNI3COyHyWw2zs60Zcd3alWxjQBtQFlujsICl06VUM6X5n/Q=
=fL1D
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
