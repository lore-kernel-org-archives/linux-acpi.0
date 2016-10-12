From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 14:32:05 +0200
Message-ID: <20161012123205.rcq6bsl4ujihg6tt@sirena.org.uk>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade>
 <20161012090003.GR2774@lahna.fi.intel.com>
 <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
 <CAJZ5v0gPNF9sm9ya6yG-kNi6F3EF01ra=O0NegbEu4+eB1itHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ih2tkjntvpsq4de"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56988 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbcJLMcU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 08:32:20 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gPNF9sm9ya6yG-kNi6F3EF01ra=O0NegbEu4+eB1itHg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--4ih2tkjntvpsq4de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 12, 2016 at 01:14:18PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 12, 2016 at 12:28 PM, Mark Brown <broonie@kernel.org> wrote:

> > We appear to not even be trying to set a better standard for how to do
> > things here.

> Sorry, who's "we"?

Linux.

> In one case, alternative OSes can handle devices on them through
> drivers that contain code dependent on specific device IDs in their
> ACPI tables.

Right, this is currently the idiomatic way to handle these things in
ACPI unfortunately and it's what Windows (which I'm assuming is the
alternative OSs you're referencing here!) does.  Are people working on
trying to move this forwards?

>               Linux has drivers for those devices too, but they are
> based on the of_* interface and expect information from DT that is not

If the drivers have DT code that's not well partitioned in the
initialization code that sounds like a general problem :(

> available from the ACPI tables (and it is not available, because the
> drivers working with the alternative OS simply don't need it, as for
> them the device ID is sufficient to convey all of the information on
> the given device).

What we've been doing up until now to support these systems in Linux is
to have platform data in the driver that's matched via DMI information.
The Windows systems don't appear to be in the slightest bit interested
in using the Linux bindings or updating their firmware to accomodate us
so the sensible thing is to work in the same way as they do.

--4ih2tkjntvpsq4de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/i1EAAoJECTWi3JdVIfQCJgH/ijQ0pkAo2GfYicthL88BkG2
qBEgNmepGH4+pv6/o+3Qvo3NKpxc5AoNwf5/WQkacNi9HC2EEb2kvoX0Mk2q+wOO
wGFSqQvf2ZpOJZknRQ5znEOoteuN7JjXpkikE5yZHXGRXEh8ducXV4XZO6G8ASrQ
9FvGrBUlTm9besCHeE+KObj0kZmknl4FuiU2RB87tnfQ9lBKq2qFohX0hXa12TPZ
MCpPRE78Q0V9hszS/2X1JYlCAKuapFDfDbcYFrf/6t6N3hqMyaHzjRfzUngB1S/X
Kr8x+92nVkkJY98jTst2RhBR13XeqJfwloCKdU5E86GKfSwISfG0GhD5dRw83cc=
=T0CN
-----END PGP SIGNATURE-----

--4ih2tkjntvpsq4de--
