From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Fri, 4 Jul 2008 00:52:19 +0800
Message-ID: <20080703165219.GE4172@prithivi.gnumonks.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:53840 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbYGCRAS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 13:00:18 -0400
Content-Disposition: inline
In-Reply-To: <20080702101919.GB699@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2008 at 11:19:19AM +0100, Matthew Garrett wrote:

> > +		if (acpi_pcc_hotkey_get_key(hotkey)) {
> > +			/* generate event like '"pcc HKEY 00000080 00000084"'
> > +			 * when Fn+F4 pressed */
>=20
> Probably better not to add further events to /proc now - we'd like to=20
> deprecate the interface.

the userspace scripts that acpid ships already support those events.  So
if the kernel driver provides events in this way, the brightness changes
will work out-of-the-box.

So I vote for keeping those events in the driver - just as long as there
is no new standard mechanism for signalling brightness up/down button
events to userspace.

I was pondering to emulate the events that the "video" acpi class
driver sends to userspace.  But that also doesn't really seems right the
correct solution.

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIbQPDXaXGVTD0i/8RArpPAJ9m4j3e8cJ4h52SVMitKaY1OFeTLgCgnyYx
i4bEa+r3hVQjEIDY2VYQIg8=
=cx8A
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
