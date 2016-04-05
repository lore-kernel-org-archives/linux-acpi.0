From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 15:44:52 -0700
Message-ID: <20160405224452.GM1924@sirena.org.uk>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <CACRpkdb=Ef1-g-r9NW-4_xeKdke0FFhnN+JYPjVKog3L4At8Lg@mail.gmail.com>
 <20160405165935.GA5456@sirena.org.uk>
 <CAE1zot+-=JQkMqRPpNtCk1MksRf9kOQ1G216kSXszDjn2z4d=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HVCoas+krw6dou6l"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:46170 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759995AbcDEWpN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 18:45:13 -0400
Content-Disposition: inline
In-Reply-To: <CAE1zot+-=JQkMqRPpNtCk1MksRf9kOQ1G216kSXszDjn2z4d=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>


--HVCoas+krw6dou6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 10:37:14PM +0300, Octavian Purdila wrote:
> On Tue, Apr 5, 2016 at 7:59 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Apr 05, 2016 at 10:43:11AM +0200, Linus Walleij wrote:

> >> And these products are only update-able
> >> with hairy BIOS patches that need to be applied
> >> using $SPECIAL_TOOL  that "normal users" do not want to
> >> concern themselves with, as this is not an "apt-get upgrade"
> >> kind of thing.

> > This bit has been addressed in UEFI - there's now a mechanism for the OS
> > to supply firmware updates to the BIOS via runtime sevices calls without
> > needing to go to the hairy tools.

> AFAIK there is still no standard way of updating just the ACPI tables.
> You need various tools to "stitch" a full firmware image that can be
> consumed by the update mechanism.

Right, but in terms of end users that doesn't matter - the users that
Linus is concerned with here aren't going to know what ACPI is.

> > There's also been facilities for some
> > time which allow ACPI fragments to be loaded at runtime without patching
> > the firmware (though they're not used so often at present).

> And I just sent a separate patch series for "ACPI overlays", similar
> with the dynamic DT, with the primary goal of supporting open-ended
> hardware configurations.

> But to be able to effectively use this we need a way to change pinmux settings.

I'll need to find that series I guess...

Note that we currently don't have any actual mechanism to load a DT
overlay in mainline.  One of the issues there is making sure that the
external interfaces we're offering are actually stable, another is
making sure (for safety) that the overlays are only updating bits of the
device tree that corrspond to the bit of the hardware that the overlay
is for.

> > Given the rush to shoehorn existing DT into ACPI at some point it's
> > looking like it would be much more sensible for x86 to just do what
> > arm64 has done and support both DT and ACPI in parallel and let people
> > (either system integrators or end users) choose the most appropriate
> > interface for their application.

> Lets look at this from a different perspective. The proposal is not
> about importing the DT model into ACPI but importing the Linux pinctrl

It's not like this is the only change that has been sent to reuse some
DT element rather directly in ACPI recently...

> model into ACPI. That will allow us to use the Linux pinctrl drivers
> to their full potential.

> That doesn't stop the development of other, more OS independent, ACPI
> models for pinmuxing. Which we can also support.

That's not really a great answer.  Regardless of how good a solution
this is for handling pinmuxing ACPI it needs to be joined up with the
rest of ACPI, we need some clear instructions for both firmware and OS
authors about how this works in a wider ACPI context and interacts with
other features, preferably in the ACPI specs where people can find them.

It could be something really simple like just saying that if we've got
these pinctrl definitions then the firmware is not allowed to do any pin
management, or it could be something more involved like saying that the
OS has to notify the OS before using them.

> I know that there are some discussions for pinmux configuration in the
> ASWG, but it does not match the Linux pinctrl model. So we will end up
> with a pinctrl driver that offers groups, functions and pin names and
> a totally different ACPI description that we can't map to the pinctrl
> driver.

If there's an ASWG spec in progress that explicitly overlaps it seems
even more important that this is joined up - I'm not aware of what's
going on there.

--HVCoas+krw6dou6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBD/hAAoJECTWi3JdVIfQEWIH/2CGEKbuqUhslfAtMtzaiNag
VyOrKCf/rh/vb78pBx9TbL//StHLlDvdXuwzw2NguN6OXPq9lkRcaz7pPC9i+g0J
SCjlAGdF6ZaTWxXqRKSOezO2miACvPvkmWIfNKuedi6LzNnuTxON0RqEKNTuPQ7/
B3QnXklsi8cVUvxJ55mHedXViv7HBiz6J68aO5hFziyp6QVoAyc2K9w6ocPpXlcP
X2fR+JdUx9VHoYUvdzlKv3nxKDTI8uCDijAh9VP6T7G76memsfjbZwyp3vJlLJIe
oewRemPCdOjZW4N0/QpmPgQGGOVjTYFgjDtPUAVFKvBpV78z9hehQPlGnzc2I84=
=0EB1
-----END PGP SIGNATURE-----

--HVCoas+krw6dou6l--
