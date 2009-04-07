From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] panasonic-laptop.c: add support for optical drive
	power control
Date: Wed, 8 Apr 2009 01:07:21 +0200
Message-ID: <20090407230721.GA14972@prithivi.gnumonks.org>
References: <20090113163233.GA734@dezo.moloch.sk> <20090114060834.GN4791@prithivi.gnumonks.org> <20090114184227.GC3654@dezo.moloch.sk> <alpine.LFD.2.00.0904050051330.4821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:35102 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbZDGXKI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:10:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904050051330.4821@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Martin Lucina <mato@kotelna.sk>, linux-acpi@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2009 at 12:53:31AM -0400, Len Brown wrote:
> On Wed, 14 Jan 2009, Martin Lucina wrote:
>=20
> > Add support for power control of the built in optical drive on models
> > with the required ACPI methods present.  Tested on Panasonic CF-W4.
> >=20
> > Creates an interface in /sys/devices/platform/panasonic/cdpower, to
> > which you can write "1" to switch the drive on, "0" to switch it off
> > or read from to query the current state.
> >=20
> > Signed-off-by: Martin Lucina <mato@kotelna.sk>
> >=20
> > ---
> >=20
> > Harald, this should address all the comments in this thread.  I've
> > removed the DMI table and enable the code if _SB.{STAT,FBAY,CDDI} are
> > all present.
> >=20
> > I've not figured out how to return an actual error from the sysfs
> > show/store functions so I've at least added ACPI_DEBUG_PRINT to print an
> > error if the relevant methods fail.
> >=20
> > -mato
>=20
> Harald,
> It's your driver.  What do you what to do with this patch.
>=20
> I'd delegate http://patchwork.kernel.org/patch/2372/
> to you, but you don't seem to have a patchwork account yet.

sorry, I was offline throughout last week and am now slowly catching up with
mails.

Will create a patchwork account and get back to you asap.

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJ29ypXaXGVTD0i/8RAsvQAJwMuahGmCWLi8QsFX0Ni1cXaVDCGQCcCNSt
RDr+ZkpwjykU6ZiCgMsz3Nk=
=0bcl
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
