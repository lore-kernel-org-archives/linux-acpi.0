From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Wed, 2 Jul 2008 21:03:15 +0800
Message-ID: <20080702130315.GA4064@prithivi.gnumonks.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:34510 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbYGBNKP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 09:10:15 -0400
Content-Disposition: inline
In-Reply-To: <20080702101919.GB699@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Wed, Jul 02, 2008 at 11:19:19AM +0100, Matthew Garrett wrote:
> On Wed, Jul 02, 2008 at 05:00:44PM +0800, Harald Welte wrote:
>=20
> > * in order to fully support the backlight interface and get rid of the
> >   clumsy separation of 'ac' (with power supply) and 'dc' (battery only)=
=20
> >   brightness settings, the driver would need to receive a notification
> >   whenever the ACPI power supply status changes.  I know how to get to
> >   that notification in userspace, but in kernelspace I'm not so sure.
> >   Is there a notifier chain to which I can attach?
>=20
> I don't think so, but it ought to be easy enough to glue into the=20
> power_supply class. The easiest thing for the moment is probably just to=
=20
> write values to both the ac and dc classes and let userspace handle the=
=20
> transition. If they're both in sync, it doesn't matter which you read=20
> back from.

mh, ok, that actually makes a lot of sense.  Will do that.

> > +/* This is transitional definition */
> > +#ifndef KEY_BATT
> > +# define KEY_BATT 227
> > +#endif
>=20
> Shouldn't be needed in-tree.

true.

> > +	const int key_map[] =3D {
> > +		/*  0 */ -1,
> > +		/*  1 */ KEY_BRIGHTNESSDOWN,
> > +		/*  2 */ KEY_BRIGHTNESSUP,
> > +		/*  3 */ KEY_DISPLAYTOGGLE,
> > +		/*  4 */ KEY_MUTE,
> > +		/*  5 */ KEY_VOLUMEDOWN,
> > +		/*  6 */ KEY_VOLUMEUP,
> > +		/*  7 */ KEY_SLEEP,
> > +		/*  8 */ -1, /* Change CPU boost: do nothing */
> > +		/*  9 */ KEY_BATT,
> > +		/* 10 */ KEY_SUSPEND,
> > +	};
>=20
> Hm. Does this mean that the keymap isn't changable at runtime?

i wasn't aware that those kind of keymaps could be changeable at
runtime.  Will read up on my homework ;)

> > +		if (acpi_pcc_hotkey_get_key(hotkey)) {
> > +			/* generate event like '"pcc HKEY 00000080 00000084"'
> > +			 * when Fn+F4 pressed */
>=20
> Probably better not to add further events to /proc now - we'd like to=20
> deprecate the interface.

ok.  I just kept all the exsting interfaces of the pcc_acpi driver
(/proc based) and added the new backlight API to it.

> And shouldn't be adding any new files to /proc. Anything that can't be=20
> expressed via the existing generic sysfs classes should be an attribute=
=20
> on a sysfs platform device.

that's what I generally know from other drivers (and how I do it in
other kernel code).  But I wasn't sure what the policy with regard to
this was for ACPI.

Thanks for your quick feedback, will re-post after all issues have been
adressed.

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIa3yTXaXGVTD0i/8RAifUAKCRertxG45B/JSHmmHyB2Ws1unFqgCgnNx/
WXOCf66dUtApRmrGoExGd6U=
=gXPW
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
