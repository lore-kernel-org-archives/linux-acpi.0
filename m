From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 17:31:29 +0200
Message-ID: <20161006153129.x6fosp725slgapjk@sirena.org.uk>
References: <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006095739.GA22984@red-moon>
 <20161006111922.GI30800@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6lm4owqa6wp4ubp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54454 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942075AbcJFPou (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 11:44:50 -0400
Content-Disposition: inline
In-Reply-To: <20161006111922.GI30800@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--d6lm4owqa6wp4ubp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 02:19:22PM +0300, Mika Westerberg wrote:

> I don't need a DT, I need that my existing firmware (in this case BIOS)
> can describe camera device(s) and the OS can take advantage of this,
> preferably with minimal changes to the drivers.

> Currently there is no way in ACPI specification to do that.

That's not exactly true - the way Windows handles audio devices (which
follow a similar pattern) is to register the control interfaces of the
individual components of the system using existing bindings and then
bind them together with a driver that matches the board level
identification.  This isn't super awesome but it's definitely a thing
you can do.

--d6lm4owqa6wp4ubp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9m5QAAoJECTWi3JdVIfQIz0IAIEOQIExW4UISUdyPkHqOqGR
6JsOxpiB1kG/tyrvb+3zAmUooAO3nA012LpNuO+xpVHPBWKyFj1bJ5m9OgRYuj+0
Cq29McQ6ZMNQzCQlOxV5HREhGQCd2IhoGNnd7kjn54NlcR1qr1UQy7E3wbxokucm
Aj14dG1OhfkvDBNlz7f+Nf8WknFmDW/OAoXVcjT1GLIIO2hspIBgX3kVBlIX5/4h
dOkzCct61BGy89nhYuzZ3VeyaR6UqyXaJ2/SCFZFZAW4ZW/koovDSofI2JQhRu6g
9OEiEvt0BaXMe7QLFpEiVTdRveohmK6DX+RZu3ZQMR+coSfgP5hC9lR/3RIWha0=
=qGbH
-----END PGP SIGNATURE-----

--d6lm4owqa6wp4ubp--
