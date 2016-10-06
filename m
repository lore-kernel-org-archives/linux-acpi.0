From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 17:23:07 +0200
Message-ID: <20161006152307.pqmmkazctqwlxsmy@sirena.org.uk>
References: <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
 <CAJZ5v0htdbUpqZNPi00ieNJ5WWiAczK+LbKLYobNGAr3Sr+HWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="swtipvpy4ukmnetz"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54432 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942075AbcJFPoq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 11:44:46 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0htdbUpqZNPi00ieNJ5WWiAczK+LbKLYobNGAr3Sr+HWw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--swtipvpy4ukmnetz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 03:15:36PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 12:40 PM, Mark Brown <broonie@kernel.org> wrote:

> > One of my biggest concerns with this approach is that I'm really not
> > clear to me that that this has broad buy in from the x86/ACPI community
> > and therefore that we might end up needing to support several different
> > styles of ACPI bindings.  Reuse would be great but it can be confusing
> > if there's multiple different styles of bindings in use at the same
> > time.

> My view on that is a bit different.

> Even if there's more than one style in use, they all can be supported
> at the same time.  Avoiding confusion is only a matter of prioritizing
> them, then.

> It should be clear which style is the default one, which is going to
> be taken into consideration next and so on.  If that is made clear, I
> don't see a big problem here, at least in principle.

My concern isn't just people using multiple styles, it's also people
trying to mix and match.  Sometimes that will work well enough and it's
fine but it can go wrong.

> The pinctrl thing is being dealt with (and not in a way of adding
> pinctrl _DSD properties support to the kernel FWIW).  Other things
> potentially conflicting with ACPI-defined HW control should be dealt
> with analogously.

Right, I was mentioning it mainly as an example of the general pattern
of ACPI bindings springing up without coordination rather than as a
specific problem that needs resolution.

> The point here is that some things just don't conflict with
> ACPI-defined HW control even potentially and they can be handled with
> the help of _DSD properties just fine.  Thus, there are no technical
> obstacles to do that, at least not in principle.

It feels like we should be aiming for a higher bar with defining things
like this than simple technical possibility - my fear is that we end up
with a mess down the line with people being far too gung ho about
defining new bindings without trying to work on standards.  Perhaps I'm
just worrying too much here but I'm not sure there's enough
communication going on.  The private nature of ACPI standardization
discussion doesn't help here of course.

--swtipvpy4ukmnetz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9mxaAAoJECTWi3JdVIfQFloIAIUCYq77Os41cLovc8xcHNcr
EVoqKpqpWlXIDYFFia1aDhljMSa3boYlTMTTKjAFkyr5AY5FBQ8rEpxm1KLPLz9Y
o3tZOzIZo5FwqqqMiFQbNDeNu8R5x5GNaE8OFhRZ4KY+aYeR6E532nI1zpv+sSUC
kkEbvorS49UAgzPY+LhYk9MzVCPhcbZct5O0wZQGUR7rosp4UAsb2OR6KlNl8D1p
/25ik0zNcHiakbV573spj/PLww+lNUl+COx3/dedB8NLaocywdxJaKacnWP4V71b
gfJxSgAdMhwJKvAZzNtX07Ojao5YOcRl6jV4zMeX34butsktxAgf1EqtnX30cUs=
=HihO
-----END PGP SIGNATURE-----

--swtipvpy4ukmnetz--
