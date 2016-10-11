From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 14:44:29 +0200
Message-ID: <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk>
References: <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
 <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
 <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6tqi4lxp3i7vsnhm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47366 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbcJKMqB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2016 08:46:01 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--6tqi4lxp3i7vsnhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2016 at 01:44:46AM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 11:37 PM, Mark Brown <broonie@kernel.org> wrote:

> > Personally I don't have that big a concern around per device
> > properties other than the need to go through yet another round of
> > churn for them (though it is just mechanical which will make it less
> > painful).  I do worry when it goes to generic things and inter-device
> > relationships.

> Well, that was my first reaction to this series, but then I thought
> "Let's see what can go wrong with this specifically" and then I
> couldn't find anything.

> If you see something like that, please let me know, because I may be
> overlooking it, but otherwise I would prefer to focus on the technical
> side of things instead of wast^Hspending time on theoretical worries.

My primary concern is the addition of what appear to be phandles
introduced as part of this patch set.  The previous discussion had been
that we'd enable simple DT bindings which don't need inter-device
references and that those needed more careful study.  This appears to
be changing that.

> >> And it is not an option for those boards to use DT in the firmware.

> > There's nothing stopping these systems defining a DSD that contains a
> > DTB which overrides some or all of the ACPI if the system supports it
> > (or otherwise providing both system descriptions).  The two can coexist
> > happily enough as arm64 has shown

> I'm not sure to what extent it has shown that and even so, it doesn't
> mean this is a good idea.

People seem reasonably happy with it so far, YMMV.

> > and it seems like it ought to save a
> > whole lot of work especially around the bits that need inter device
> > links and are hence need some new ACPI bindings defining.

> There is at least one major problem with this approach.  If the ACPI
> part needs to point to anything in the DTB or if the DTB part needs to
> point to the ACPI part outside of it, there's no clean way that could
> be done.  I actually am not aware of any way whatever, but if there
> are some, I kind of don't expect them to be pretty.

The way ARM implements this is that you don't get the DT and ACPI
simultaneously, they're both present in the firmware and the OS picks
which one it wants to use at runtime.

--6tqi4lxp3i7vsnhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/N6pAAoJECTWi3JdVIfQ9pYH/jwN42N2ZK8mTZ8s4DvYwvPt
P0iez/vq4CE9Pme8FAT9IjOTm3fJc/aLl8zDbLnRyLpPZVKnbjWe49C2PEGwLA+y
BwekHq5cnljdbuiM3jg7sKfOtp0wur1hDoIcDubrQYHQGS7+yyurDGU8EW5GqNRZ
gDAXsRndfG4/uP76r2s2GRAbTfU0Dlfrbg6ytrU0aNBeTIN/eN+ukT8Xn383Klf6
+X/yqAWK+iMmEmg20quZQcBMYeHgz0Cvg+hQdD2ilj1UMp2RSjPZvX4uw7zdWof1
SSghRyO9nQMyU3EEA0PE/z5D7vFgZ78VtSNhV2nZJFvhdkELloKU3m+5kWBEPbk=
=/0QB
-----END PGP SIGNATURE-----

--6tqi4lxp3i7vsnhm--
