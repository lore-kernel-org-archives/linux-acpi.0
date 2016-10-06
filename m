From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 23:37:04 +0200
Message-ID: <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ztbw27nczzgejpdv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58070 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935318AbcJFVhU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 17:37:20 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--ztbw27nczzgejpdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 02:26:50PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 10:57 AM, Lorenzo Pieralisi

> > I am trying to understand why x86 wants to do this, please understand
> > our point of view too, we do not want to block progress we want to
> > prevent a mess.

> It is not "x86" who wants to do that.

> It is people who work on support for boards with ACPI firmware and
> containing devices that in Linux are handled by DT-centric code.

Yes, it's important to remember that there's a whole world of other
people using ACPI on x86 who are doing different things.  I have to say
I'm not sure how DT centric we really are, there's a lot of things that
have been around since before DT.

> Of course, the reason why that code is DT-centric is because it was
> developed on systems using DT and there were no uses on ACPI-based
> systems for it back then.  Still, it is DT-centric as a matter of fact
> and *something* has to be done in order to make it work with ACPI.

Personally I don't have that big a concern around per device
properties other than the need to go through yet another round of
churn for them (though it is just mechanical which will make it less
painful).  I do worry when it goes to generic things and inter-device
relationships.

> And it is not an option for those boards to use DT in the firmware.

There's nothing stopping these systems defining a DSD that contains a
DTB which overrides some or all of the ACPI if the system supports it
(or otherwise providing both system descriptions).  The two can coexist
happily enough as arm64 has shown and it seems like it ought to save a
whole lot of work especially around the bits that need inter device
links and are hence need some new ACPI bindings defining.

I can see that removing ACPI entirely would present serious difficulties
but it's less clear to me how much is really gained by having an
embedded Linux specific ACPI variant over having some Linux specific
data in ACPI that happens to be parsable as DT.  The circumstances that
the two platforms face appear to be very similar.

--ztbw27nczzgejpdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9sP/AAoJECTWi3JdVIfQ4j8H/27X3ewbqBQvuvvxe8SOGoQF
WyIMZAEHoZT/D+zZTq7bwUv+yP7AFm2p2wvdQN/GBti2Il3xiZMRyFGZc5RAKadk
VgY6j/TAtyVM7hs4xj1E9oblHk5NmCb25J6uYGA6LyDY6GyubVyU1rOBA13OQEg0
SY1W12WkWS0KQeuYsdmiB4dK7/tWrJ/6lq3pxHN7PutfCH73Cdag5m8yWvG6bbmU
55zAM0yyKmfbnisQcDqWYWjGNpkHuBlgNUTcATUJfOi6y3yROxgcP2r3bMNMeDpG
Sfo7J+svtDYQRNeyWmJllGf68jtKLm5gKSWFWyu8pwnClZAYb4qrPCiLszPdcCw=
=EwkY
-----END PGP SIGNATURE-----

--ztbw27nczzgejpdv--
