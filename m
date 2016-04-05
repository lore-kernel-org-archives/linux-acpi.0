From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 09:59:35 -0700
Message-ID: <20160405165935.GA5456@sirena.org.uk>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <CACRpkdb=Ef1-g-r9NW-4_xeKdke0FFhnN+JYPjVKog3L4At8Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb=Ef1-g-r9NW-4_xeKdke0FFhnN+JYPjVKog3L4At8Lg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
List-Id: linux-acpi@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 10:43:11AM +0200, Linus Walleij wrote:

> And these products are only update-able
> with hairy BIOS patches that need to be applied
> using $SPECIAL_TOOL  that "normal users" do not want to
> concern themselves with, as this is not an "apt-get upgrade"
> kind of thing.

This bit has been addressed in UEFI - there's now a mechanism for the OS
to supply firmware updates to the BIOS via runtime sevices calls without
needing to go to the hairy tools.  There's also been facilities for some
time which allow ACPI fragments to be loaded at runtime without patching
the firmware (though they're not used so often at present).

> And I think that is what is happening, it's just that so much
> prestige is involved that no-one wants to officially admit it.

> I was once poking fun at this development model accusing
> firmware engineers of having a God complex when they claim
> to be able to engineer in these complex use cases during

That's not really a fair characterization of the situation.  The goal
that ACPI has been trying to meet is allowing new hardware to work
without needing software updates so people's installation experience
isn't miserable.  The Windows monoculture that firmware developers have
been targetting has hurt the achievement of that but it's the idea.
It's a good model for some classes of device but not for all.

> product firmware development. Now I just feel sad about this
> situation and want things to "just work" for them. I think these
> patches are good.

See Mark Rutland's reply - there's a whole model behind how ACPI
abstracts the system that needs to be taken into account, just stuffing
the existing DT in through a mechanism intended for simple vendor
specific key/value properties isn't guaranteed to give something that's
coherent and sensible.  DT design decisions will obviously not have
considered ACPI and exposing the full combination of the two system
models to system integrators seems likely to lead to unfortunate
corners, especially with things that happen to work right now but cause
problems later on.

Given the rush to shoehorn existing DT into ACPI at some point it's
looking like it would be much more sensible for x86 to just do what
arm64 has done and support both DT and ACPI in parallel and let people
(either system integrators or end users) choose the most appropriate
interface for their application.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXA+72AAoJECTWi3JdVIfQJuwH/Ajuc8sImrTIMB0Ev0PWFFXo
HAuwfErHs6AW2+6aiK4ozQJkTZi9wSiVcCEvrauGSiEtSI1Jz5RqF2gUyjeIm/if
Nqn5HOl+MYqRCvbAf3zHIOUMTNCSKmG7R3xqxunOMtBl13PsDjyxKW4fttiMpMjM
/pOYICp0XNCLjzB7JmTJyWpX1IH+7sOlGAqt0Xs4u78WrChmeE6X2rqSBoO7OPyI
PSwgc/eY1p8gc7CeUEmqOM9gSn+DS2ftEIcfobzL5l8iYoHK5FKbXqvWe5At5a6u
e1E3V81pm/RNNJYQFUW2lmaDm3NAeJXCKNAHNO9G4287rW9VtbTjyK5y+UNVuxk=
=Q+zD
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
