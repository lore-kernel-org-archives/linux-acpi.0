From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Tue, 12 Dec 2006 23:15:04 +0100
Message-ID: <20061212221504.GA4104@datenfreihafen.org>
References: <20061204224037.713257809@localhost.localdomain> <20061204144958.207e58e2.kristen.c.accardi@intel.com> <20061209115957.GA5254@homac2> <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([62.75.240.18]:36370 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbWLLWNe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Dec 2006 17:13:34 -0500
Content-Disposition: inline
In-Reply-To: <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Holger Macht <hmacht@suse.de>, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, 2006-12-11 at 12:05, Kristen Carlson Accardi wrote:
> On Sat, 9 Dec 2006 12:59:58 +0100
> Holger Macht <hmacht@suse.de> wrote:
>=20
> > Well, I like to have them ;-)
>=20
> Ok - how is this?
>=20
> Send a uevent to indicate a device change whenever we dock or
> undock, so that userspace may now check the dock status via=20
> sysfs.

I would like to have two different events for dock and undock.

This way the userspace listener don't need to check the status file in
sysfs to know if there was a dock or undock after getting the event.

Anyway the status file is still usefull for programs don't react on
the events, but like to know if the laptop is docked before starting
for example.

regards
Stefan Schmidt

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: http://www.datenfreihafen.org/contact.html

iD8DBQFFfynobNSsvd31FmURAiMyAJ4oiRnvaeplmDUxGte7E8Ghs84SkwCgg9QL
c3TQCSO0kb+FH6C8jzCqNzY=
=BybV
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
