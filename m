From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Fri, 4 Jul 2008 12:43:17 +0800
Message-ID: <20080704044317.GH4381@prithivi.gnumonks.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org> <20080703165219.GE4172@prithivi.gnumonks.org> <20080703170857.GA30135@srcf.ucam.org> <20080704031404.GC31908@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:53357 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYGDEuP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 00:50:15 -0400
Content-Disposition: inline
In-Reply-To: <20080704031404.GC31908@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2008 at 12:14:04AM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 03 Jul 2008, Matthew Garrett wrote:
> > On Fri, Jul 04, 2008 at 12:52:19AM +0800, Harald Welte wrote:
> > > So I vote for keeping those events in the driver - just as long as th=
ere
> > > is no new standard mechanism for signalling brightness up/down button
> > > events to userspace.
> >=20
> > There is - they should just be sent as KEY_BRIGHTNESSUP and=20
> > KEY_BRIGHTNESSDOWN.
>=20
> Once bitten, twice shy.  I understand these buttons in the Panasonic Let's
> Note do NOTHING in firmware/hardware (i.e. if you don't hook something to
> them, brightness is NOT changed)?

no, they don't do anything in firmware/hardware.  They just generate
events, and the OS/driver need to take care of any action to perform.

> Because if they DO anything else than just staying there prettly and tell=
ing
> you they have been pressed, then you are **NOT** to issue
> KEY_BRIGHTNESSUP/DOWN.

thanks for making this clear.  However, this doesn't apply to the
panasonic laptop hotkeys.  They really don't do anything unless the
os/driver takes care of it.

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIbaplXaXGVTD0i/8RAuS5AJ99daeXw3kcVrl8X/X5ouNosJk+3gCfSNmv
6FK5UIMAa2lR/0lfOkT07EM=
=Esm3
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
