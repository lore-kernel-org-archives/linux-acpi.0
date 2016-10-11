From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 15:05:06 +0200
Message-ID: <20161011130506.hojitrt3nsloehq6@sirena.org.uk>
References: <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
 <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
 <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
 <CAJZ5v0iFsj8WuiEwToRwbpXX8amWmPAn2WmRMWFagva48JFWbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34jorsqhb336ulq7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48610 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbcJKP3H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2016 11:29:07 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iFsj8WuiEwToRwbpXX8amWmPAn2WmRMWFagva48JFWbw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--34jorsqhb336ulq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2016 at 02:11:06PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 11, 2016 at 1:44 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Oct 6, 2016 at 11:37 PM, Mark Brown <broonie@kernel.org> wrote:

> >> I can see that removing ACPI entirely would present serious difficulties
> >> but it's less clear to me how much is really gained by having an
> >> embedded Linux specific ACPI variant over having some Linux specific
> >> data in ACPI that happens to be parsable as DT.  The circumstances that
> >> the two platforms face appear to be very similar.

> > I'm not really sure what you mean here.

> > _DSD properties can convey the same information as DT in the same
> > layout.  The only difference is that DT uses phandles to point to
> > things and _DSD properties use ACPI namespace paths for this purpose.
> > That actually is where code changes need to be made, the rest is
> > already there.

ACPI *can* be used in this way but it's not clear that this is a
mainstream usage of ACPI.

> In fact, from the utility perspective, _DSD properties are just like
> an "embedded DTB" you talked about, except that they are represented
> in ASL (which makes them easier to handle in a couple of ways) and use
> namespace paths instead of phandles to point to things.

It does require an awful lot of code churn to implement and it does
seem like it's going to be ending up with a lot of non-standard ACPI
bindings available to system integrators targeting Linux that perhaps
lack broad buy in.  This would be a bit annoying if we end up with bad
bindings that way but it'd also be sad if we were getting good bindings
that weren't getting broad adoption for whatever reason.

--34jorsqhb336ulq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/OOBAAoJECTWi3JdVIfQlEUIAIBqX48HdHk3GJwcXJd1thu7
vUYTKX9Mw/IzV7tchHByrwOBqe7f+S6EEOskz3m3w40cePosBP79DfET6K5nM5yI
UfVJu7F/pVBECl1NAfdnJgFnHlE+lnshzIw+X2UFEZtcGpLWk6iNxpFCo2+RLPDP
2+PKmwi/EnknD66IfCas3s7bncJv64Xuuh5Cj8+P5IdY/+qHtQhDUwwgJjf/STGv
WpKtpQ8JvDoWvi4JGu3ZEVxwlhqt8isNg4ZzfLLP20cxWGg2FcuzY+/7L6y/EQet
BFdOpFgYu9tnE1NHpfxA+14mkObsNdqqsoNSyAholLCIMWhnRK01Tjgcb4omIyM=
=srpq
-----END PGP SIGNATURE-----

--34jorsqhb336ulq7--
