From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 14:05:18 +0200
Message-ID: <20161012120518.4f3j67ndba2fipro@sirena.org.uk>
References: <20161005092215.GA20248@red-moon>
 <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
 <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk>
 <2933991.PYcZctIsx9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4c7p3c4p5x2vhpg"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56936 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbcJLM2F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 08:28:05 -0400
Content-Disposition: inline
In-Reply-To: <2933991.PYcZctIsx9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--h4c7p3c4p5x2vhpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 12, 2016 at 02:32:04AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, October 11, 2016 02:44:29 PM Mark Brown wrote:
> > On Tue, Oct 11, 2016 at 01:44:46AM +0200, Rafael J. Wysocki wrote:

> > My primary concern is the addition of what appear to be phandles
> > introduced as part of this patch set.  The previous discussion had been
> > that we'd enable simple DT bindings which don't need inter-device
> > references and that those needed more careful study.  This appears to
> > be changing that.

> Yes, it does, but why exactly do you think this is wrong?

> Is there any specific problem it creates that you can point to?

It means there's now nothing in the code that says that we shouldn't
just map a DT binding with inter-device references into ACPI and that
any future conversions just look like API usage cleanups.

> > The way ARM implements this is that you don't get the DT and ACPI
> > simultaneously, they're both present in the firmware and the OS picks
> > which one it wants to use at runtime.

> So for the boards I'm talking about ACPI is the only realistic choice.

There shouldn't be any technical limiation here.

--h4c7p3c4p5x2vhpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/ibzAAoJECTWi3JdVIfQCVwH/RcBrM5j4ggaPvuyrSg24qau
7HYF97JBEKy5FyyxKwl1Z/HGYHOR/MUJFAvoEKG60n8UafhNT8IMSi9Ljzb8m2Uv
+xOlPxOJ37pelMu7Mj9ikCG3/Vs9yxr2aVsqCpWbUVvsvfo3HnE7D6XgB+HVUl+w
G50QaS6tT6bpiz0ysTMHatTD0EwDjXAGFszKCwR7Y7hyzVuu4lRMFFUNNg1XsOsd
FjfCGE5N2fvK1U5li7tBbh99CKHTaHTYse0gCxl5Ipx/LOetc1s2Qye7OA85aPsO
GUMb7nQqJn44lQhryQiIsbsLxr7Rnpikbc0boDxShFo+s7GoYbdl6NgTaCNZUGc=
=7E6d
-----END PGP SIGNATURE-----

--h4c7p3c4p5x2vhpg--
