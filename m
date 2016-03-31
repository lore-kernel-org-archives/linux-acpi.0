From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Thu, 31 Mar 2016 08:28:54 -0700
Message-ID: <20160331152854.GA2350@sirena.org.uk>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <56FC9D1D.6090808@huawei.com>
 <CAJZ5v0gv-MJ+Ss8gtc80z2_sOq-3qfBYbspRU8MWRNvn+UVbUg@mail.gmail.com>
 <20160331123649.GE18910@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kD5A6s5fH5u0LDZc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60370 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbcCaP3U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2016 11:29:20 -0400
Content-Disposition: inline
In-Reply-To: <20160331123649.GE18910@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--kD5A6s5fH5u0LDZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 01:36:50PM +0100, Will Deacon wrote:

> I'm unsure about whether or not we want 'default y' here, but I'd like

I can easily do followup patches which change that to be "default y if
!ARM64" (or default y if $OTHER_ARCHES) and adding CONFIG_ACPI to
defconfig (for the test coverage) if that helps?  I think that's
perfectly reasonable.  As Ard says if both DT and ACPI are built in then
the kernel will continue to prefer DT if it finds one.

> to wait for Catalin to come back from his 2-week holiday before going
> anywhere with this patch. It's only fair that his opinion should be
> taken into account, and there's not a huge rush for this. I do consider

It definitely makes sense to get Catalin's input.  I do think that this
is something we don't want to defer indefinitely though, I think we're
hurting ourselves more than we're helping.

> "ACPI-only platforms" as simply "platforms without a .dtb" (modulo
> any significant AML code) and therefore don't view this as a blocking
> issue.

I think people with a system with no DT provided might disagree on that
one, and that this isn't really about end users or even distros but
rather about the people working upstream and especially doing test and
QA work upstream.

> We should also take into account the large amount of ongoing ACPI work
> (e.g. the DSD and PRP0001 saga, PCI and IORT support, virtualisation work,
> etc), and decide whether or not that's currently in a state where we want
> to encourage people to start using this in their arm64 kernels.

My perception is that the EXPERT dependency is not having a meaningful
impact on people who want to use ACPI, they're just going ahead and
doing it anyway and expecting that distros will ship kernels which
enable ACPI (which realistically the ones that don't currently are going
to do as they start encountering these platforms).  There doesn't seem
to be much sign that decisions about shipping systems are being guided
by this and the work that's happening on ACPI is going on regardless,
some of it x86 focused.

The kernel will still continue to prefer DT on arm64 systems so it's
still the default upstream.

--kD5A6s5fH5u0LDZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/UIzAAoJECTWi3JdVIfQp5QH/3dJH6IkjIVh6nemPuQvhC+T
yKUcH5JHxUmGVSfXFAv3n4mQUKeT3o7uBsoC3ckr5YrClCGHS3FBhlzd8yw06WsL
+TDLlGZWIZWkK9t3BPrjtcBEDEELn9gErxDgSS4CFmFnkVfdKCK6+GeRuCLhR1v1
b1IfW+KyfkcYQ6f6gg0fAelCLHd8LIrJ/a/GsLIVGV1o8lv29MZ4TETWouoRONPL
6vXJSewZlE84IbTCes+38q562fXnZUqrzoYavNKmm33xlV0iJTm1PIGs1ehQ2ULU
IckUcL3jVKDmwTH4flB1azoei8p4k9iOsiIuGiY3OL1OG/8v/WPfRDwhtrAtftc=
=07Pc
-----END PGP SIGNATURE-----

--kD5A6s5fH5u0LDZc--
