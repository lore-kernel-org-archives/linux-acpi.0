From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] platform: x86: dell-laptop: Add support for keyboard backlight
Date: Sun, 23 Nov 2014 15:48:53 +0100
Message-ID: <201411231548.53919@pali>
References: <1415967813-7223-1-git-send-email-pali.rohar@gmail.com> <201411221946.25314@pali> <20141121220939.GA24951@vmdeb7>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2077679.S7jRcjS5jk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:50831 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaKWOs5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Nov 2014 09:48:57 -0500
In-Reply-To: <20141121220939.GA24951@vmdeb7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, libsmbios-devel@lists.us.dell.com, Srinivas_G_Gowda@dell.com, Michael_E_Brown@dell.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>

--nextPart2077679.S7jRcjS5jk
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 21 November 2014 23:09:40 Darren Hart wrote:
> On Sat, Nov 22, 2014 at 07:46:25PM +0100, Pali Roh=C3=A1r wrote:
> > > > 0   Completed successfully
> > > > -1  Completed with error
> > > > -2  Function not supported
> > > >=20
> > > > So we can return something other too (not always
> > > > -EINVAL). Do you have any idea which errno should we
> > > > return for -1 and -2?
> > >=20
> > > For -1, I should think  -EIO (I/O Error)
> > > For -2, I'd expect -ENXIO (No such device or address)
> >=20
> > What about -ENOSYS for -2?
>=20
> No. This specific topic came up at kernel summit this year.
> ENOSYS is specifically for not implemented system calls.
>=20

Ok, I will use -ENXIO.

> > > > > > +	if (convert) {
> > > > > > +		/* NOTE: this switch fall down */
> > > > >=20
> > > > > "fall down" ? As in, it intentionally doesn't have
> > > > > breaks?
> > > >=20
> > > > This code convert "value" in "units" to new value in
> > > > minutes units. So for unit =3D=3D days it is: 24*60*60...
> > > > So no breaks.
> > >=20
> > > Right, so the language of the comment just wasn't clear,
> > > try:
> > >=20
> > > /* Convert value from seconds to minutes */
> >=20
> > Err... to seconds :-) But OK, I will change comment.
>=20
> Oops, duh.
>=20
> /* Convert value from current units to seconds. */
>=20
> > > > > > +		switch (unit) {
> > > > > > +		case KBD_TIMEOUT_DAYS:
> > > > > > +			value *=3D 24;
> > > > > > +		case KBD_TIMEOUT_HOURS:
> > > > > > +			value *=3D 60;
> > > > > > +		case KBD_TIMEOUT_MINUTES:
> > > > > > +			value *=3D 60;
> > > > > > +			unit =3D KBD_TIMEOUT_SECONDS;
> > > > > > +	 	}

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2077679.S7jRcjS5jk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRx89UACgkQi/DJPQPkQ1IMdACffl0VR6eNFKFZohMUHkObYeWL
EXcAnRaxHoA9UualAZA4VNkftf7u6Zib
=nya8
-----END PGP SIGNATURE-----

--nextPart2077679.S7jRcjS5jk--
