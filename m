From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 22:14:22 +0200
Message-ID: <20161006201422.q566ckb4qzbbt7s2@sirena.org.uk>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
 <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
 <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com>
 <CAJZ5v0hy8V_WUuzOtT4oPt_hPRDUMHR5UYxVD0X3bVQe5AJf9Q@mail.gmail.com>
 <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
 <590ed0a0-544d-a320-e6e0-ce1ab89d485e@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fgzgdnaagk5n74ho"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57114 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbcJFUOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 16:14:39 -0400
Content-Disposition: inline
In-Reply-To: <590ed0a0-544d-a320-e6e0-ce1ab89d485e@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>


--fgzgdnaagk5n74ho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 11:20:49AM -0600, Al Stone wrote:

> So where does this leave us?  What I take away from the discussion is this:

>    a) each use of _DSD device properties in the kernel is to be evaluated on a
>       case-by-case basis.  Therefore, Rafael and/or driver maintainers have the
>       final say on acceptance in the Linux kernel.

Are we talking about pure _DSD here or are we not talking about
something definitely ACPI specific?  I was under the impression from the
thread title that there's something involving inter-node links going on
here since I thought it wasn't possible to represent that in _DSD alone.
I might be missing something here, I was copied in part way through the
thread.

>    e) Windows and Linux are already diverging in their use of _DSD.

I'm concerned we're seeing this outside of just _DSD.

> If I didn't, then it seems a mechanism external to the Linux kernel to document
> device properties is completely redundant, especially given item (e) -- they
> will either be documented in DT, or documented by the driver.  And if that's the
> case, then the dsd@acpica.org mailing list is irrelevant, or what's worse, makes
> for duplicated work, and should just go away.

> I'm fine with that, if that's what we're saying (it's less for me to do :), but
> let's say it explicitly instead of re-hashing it every time _DSD is used.  The
> above list is nice and simple and personally I'd rather have simple than a full
> blown registration process.

Like I've said before having some effort to try to pull the ACPI
community together so they're talking to each other and trying to come
up with best practices seems like a good idea.

--fgzgdnaagk5n74ho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9rCdAAoJECTWi3JdVIfQeGkH/j8l1gfxjV3FKPuczKnrIV7n
efaU8J7bTBXsxkm1jbaUNIN1XdGJxC3ExAjYpZlsXDyAJHVgfg0TZ+BNEMWNbXBA
XQrpm80eTU1eKBCE42quUrf/7xonZRXjseg1g7DWjLKSwsXaYtn4dY3YQtynUt+E
qtroD9xj+WSFjdTq5Lv5lp5JSRm6dLl3CM/dzRDw50u/LpY1HWY/raHLMCeaHbkR
iHGos+cFJqDTAwqDEVTay21aSm/RaO20ceki3+Wv9eKkXZskgQBj9acpAYkHLoep
5AGAIqe3PTIm4EvLybkTjuAQ0TJEizVKeO2cPkG9wQKB69KixmRwnXVRQIQuBnY=
=N/BN
-----END PGP SIGNATURE-----

--fgzgdnaagk5n74ho--
