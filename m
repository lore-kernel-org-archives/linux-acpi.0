From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Thu, 31 Mar 2016 09:39:19 -0700
Message-ID: <20160331163919.GC2350@sirena.org.uk>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <56FC9D1D.6090808@huawei.com>
 <CAJZ5v0gv-MJ+Ss8gtc80z2_sOq-3qfBYbspRU8MWRNvn+UVbUg@mail.gmail.com>
 <20160331123649.GE18910@arm.com>
 <CAKv+Gu_i8q_xKQgJ1mJ5hE_gcdJgHkh_QZhUNwQchsyH9r-pJQ@mail.gmail.com>
 <20160331133848.GH18910@arm.com>
 <CAKv+Gu_TfX8aOXig63gWH535he-dPiMr14ig7bUL+LJC_n3=9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iaYIJ+kOC8t17Zqq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60582 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbcCaQjg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2016 12:39:36 -0400
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_TfX8aOXig63gWH535he-dPiMr14ig7bUL+LJC_n3=9Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>


--iaYIJ+kOC8t17Zqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 04:48:44PM +0200, Ard Biesheuvel wrote:
> On 31 March 2016 at 15:38, Will Deacon <will.deacon@arm.com> wrote:

> > I'd really like to get away from the concept of ACPI-only systems. Would
> > we reject a .dtb contribution for such a machine?

> Absolutely not, and I expect such contributions will appear sooner
> rather than later.

> But the point of ACPI is the abstraction, and the ridiculous churn in
> DTB's carried in mainline clearly shows the need for that*. So there
> will be ACPI-only systems because the drivers are coded against the
> abstracted interface, and DT is simply not a drop-in replacement in
> that case.

It's also worth remembering that just because we have a DT in tree that
doesn't mean that people running actual systems are going to use it.
For some systems there will be a user community that wants to do that
but that won't be universal, there are going to be people who just use
the default firmware.

> > I understand that, but I still think that removing the dependency on
> > EXPERT is indicative of saying "this stuff is good to be used by the
> > masses", irrespective of a cmdline option. Maybe that's true, but it's
> > not immediately obvious to me, with all the patches in flight.

> Well, we are not cc'ing to stable, are we? Or do you think the current
> stuff is so broken that we should even protect users of the upstream
> HEAD branch against it?

Like I said in the other mail I'm also just not sure that this is
something that people deciding what firmware to ship on their systems
are paying much attention to.  People are coming to their own assessment
based on their own testing and other factors.  Where I see this having
an impact is more on having the rest of the upstream community keeping
an eye on what the ACPI people are doing.

--iaYIJ+kOC8t17Zqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/VK2AAoJECTWi3JdVIfQUesH/jJ5FrxOGwlTFMFIjM/E/hLp
JxjSYV24+Z0b9TU3qcH7/NvH2nYFMTWwJlybrn/GL7E8m9Pn0jKD/q4OWb9eub/C
e2awRcusf23x2PTuv6yE1FqSYQ6+KRsaEIVUW1SuUWqcwm123fcQY/KtyQWxVS8K
0wUQxy1jmMXFX+Yd0XtM+c3Pdw9sfqJldij7IhwclQAV657fb5c9NR3+UsUpfDtB
USm3oV7CCoq2y89iN1AAWMouEY0luRwtA/RCIoUtYid0BXenfQdAV/+flsncZE7T
aouQMIOg8TgmDnWVzFCUlHeCQt9vkedCx0+C02YEdRd9cFvrZbIYk5anjKNQbRU=
=RUbQ
-----END PGP SIGNATURE-----

--iaYIJ+kOC8t17Zqq--
