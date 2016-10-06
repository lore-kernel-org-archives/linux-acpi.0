From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 18:14:52 +0200
Message-ID: <20161006161452.ubltgnviyswk6qsw@sirena.org.uk>
References: <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006095739.GA22984@red-moon>
 <20161006111922.GI30800@lahna.fi.intel.com>
 <20161006153129.x6fosp725slgapjk@sirena.org.uk>
 <CAJZ5v0izHFuZbW84arDnZvht=jigstD1F9m6GLSe=K0gOGmYfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gq4vaz4judmmu2su"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54664 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942231AbcJFQPM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 12:15:12 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0izHFuZbW84arDnZvht=jigstD1F9m6GLSe=K0gOGmYfQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--gq4vaz4judmmu2su
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 06:00:39PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 5:31 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 06, 2016 at 02:19:22PM +0300, Mika Westerberg wrote:

> >> I don't need a DT, I need that my existing firmware (in this case BIOS)
> >> can describe camera device(s) and the OS can take advantage of this,
> >> preferably with minimal changes to the drivers.

> >> Currently there is no way in ACPI specification to do that.

> > That's not exactly true - the way Windows handles audio devices (which
> > follow a similar pattern) is to register the control interfaces of the
> > individual components of the system using existing bindings and then
> > bind them together with a driver that matches the board level
> > identification.  This isn't super awesome but it's definitely a thing
> > you can do.

> But that would mean writing new Linux code to support hardware that
> already is supported by the Linux kernel.

> That would be a bit like saying "We have a driver for this, but you
> are not allowed to use it, because your platform is not a DT one".
> That doesn't sound good to me, honestly.

Well, no - it just means that you need a bit of translation code to glue
things together.  There's no need to replace the entire driver.

--gq4vaz4judmmu2su
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9nh5AAoJECTWi3JdVIfQTq4H/jBHjxbN45X9RFadVnn1uADI
2RDDjGtNbTHK8Mljh85RmRr7omKNm5oDeqFb0xki7ul6bC9LsbsIGmbIurzMeksx
g6hAdk9ZOg1b2zZi2xvVgyV/ULTKG4g1DkVHz7RiWxVJtMmTVO1P2OUabOqr0fN3
Ju9haAn3KSsXlEW34jBo3oD4I7UVhMYlyqy6Hxe8bXC+hooXQpl4F0h1puu3Mcg4
lFg29PDiyrsaF/LZ6url8jbx1j+O99Nsd2g30h2Lgzr3Fq8oZ7LEhruiEVW3DLCo
BICFEO6aac7mCk0fkgIt38bVQ3imZsWY28vnIK0Np9FjPMOnAFgg17vz3qWd+G0=
=0Ag6
-----END PGP SIGNATURE-----

--gq4vaz4judmmu2su--
