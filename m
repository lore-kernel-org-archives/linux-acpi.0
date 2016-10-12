From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 16:59:36 +0200
Message-ID: <20161012145936.s3llzl26j3ziga7u@sirena.org.uk>
References: <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade>
 <20161012090003.GR2774@lahna.fi.intel.com>
 <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
 <CAJZ5v0gPNF9sm9ya6yG-kNi6F3EF01ra=O0NegbEu4+eB1itHg@mail.gmail.com>
 <20161012123205.rcq6bsl4ujihg6tt@sirena.org.uk>
 <CAJZ5v0gfJ+7=YLHtzDAG70H95Pbdx_DuhfJ0g6UbpZCbfLM3zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k74i56go3lodqf7c"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57852 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbcJLO7y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 10:59:54 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gfJ+7=YLHtzDAG70H95Pbdx_DuhfJ0g6UbpZCbfLM3zA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--k74i56go3lodqf7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 12, 2016 at 02:42:25PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 12, 2016 at 2:32 PM, Mark Brown <broonie@kernel.org> wrote:

> > Right, this is currently the idiomatic way to handle these things in
> > ACPI unfortunately and it's what Windows (which I'm assuming is the
> > alternative OSs you're referencing here!) does.  Are people working on
> > trying to move this forwards?

> "Forward" in what way?  To convince the Windows people to change their
> ecosystem?  No.

Well, at least trying to get standard ACPI able to express these ideas
better.

> > What we've been doing up until now to support these systems in Linux is
> > to have platform data in the driver that's matched via DMI information.

> That is becoming more and more problematic, though, and generally
> leads to inflated DMI tables in drivers which is not perfect to put it
> lightly.

Tell me about it - as far as I can see we're going to end up with a
kernel patch for most laptops or tablets anyone tries to run Linux on in
order to get audio working which is going to be a pretty miserable
experience for users and distros.

> > The Windows systems don't appear to be in the slightest bit interested
> > in using the Linux bindings or updating their firmware to accomodate us
> > so the sensible thing is to work in the same way as they do.

> That would mean adding static data tables to drivers based on device
> IDs somehow, but that pretty much would be what happened in the ARM
> camp before DT, wouldn't it?

Yes, that's what it means.  It's pretty much a step backwards from what
architectures doing board files have - no changes are needed in the
drivers, instead when you add a new board you add a file which describes
everything on the board including all the platform data for the device.
It at least keeps all the support for the board and the matching code in
one place rather than scattering it through drivers.

--k74i56go3lodqf7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/k/XAAoJECTWi3JdVIfQ/5gH+wbxbnBFH5t2mNstdkvHeBdf
En7yCYODZEJzT0xS0IY7jUGwFX32jUimRYGKMgQUk8V0IK8VveklumzrtXohPkSO
wwhIIQ+dc6pHoYPx9SkcQLy0MB3f7H6Nbc5so5GTyxVIFesn2mz3BPVW/QKeW1dA
u9sebyphP3447RVwDhSlAamOini649NUTlQcPL0Fi2Vmo7zU4uL2eeQSJuPSP7xn
zlhKHqX3ijBS0y1Kb3ditLNTNJ8gWb3MTw8ut89DMI4k0Sho/+sZzeAug0Nf5hxe
tLcCMn/THO4aRcM0goe0TFlGPs5aCEa1n7o0cqV+6EPt1ZXqd6/lJs9kyX0+isA=
=ztv3
-----END PGP SIGNATURE-----

--k74i56go3lodqf7c--
