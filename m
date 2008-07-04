From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.93
Date: Fri, 4 Jul 2008 09:31:21 +0800
Message-ID: <20080704013121.GB4381@prithivi.gnumonks.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080703173542.GA5118@prithivi.gnumonks.org> <20080703192303.GA32260@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:57978 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbYGDBkK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 21:40:10 -0400
Content-Disposition: inline
In-Reply-To: <20080703192303.GA32260@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Thu, Jul 03, 2008 at 08:23:03PM +0100, Matthew Garrett wrote:
> On Fri, Jul 04, 2008 at 01:35:42AM +0800, Harald Welte wrote:
> > +
> > +static int pcc_setkeycode(struct input_dev *dev, int scancode, int key=
code)
> > [...]
>=20
> You probably want to set_bit the input device here, and also clean up=20
> any now-unused keycodes from there. I'd also suggest sending KEY_PROG1=20
> by default on the CPU throttle button - some users will find it easier=20
> if it already generates a keycode. Other than that, looks good.

Ok, I've added this.  Thanks for noticing.  I'm waiting on your feedback
with regard to the /proc events vs. input event device and acpid
handling.  Once I am clear on this, I'll submit the hopefully final
version that can be merged.

Cheers,
--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIbX1pXaXGVTD0i/8RAovTAJ4vTbEXUZJ+LyOY1ydQHHAk+8wDGwCeKmZM
npQWBVH6mLGyDHcQGX5BFuo=
=bPSb
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
