From: Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: Untangling the sleep hotkey mess
Date: Sat, 7 Jan 2006 20:24:44 +0100
Message-ID: <20060107192444.GA21915@osgiliath.brixandersen.dk>
References: <20060107172446.GA3092@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060107172446.GA3092-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2006 at 05:24:46PM +0000, Matthew Garrett wrote:
> a) Hal should assume that all hardware has a sleep key, since there's no=
=20
> way to actually tell.

Why bring Hal into this equation?

> b) Events generated in cases (1) and (2) should, for now, be caught by=20
> acpid (or something similar) and then fed back into the input layer via=
=20
> uinput. This should be scancode 142, which will end up as X keycode 223.

And how would this work for users who doesn't have Hal installed?

Having ACPI hotkey events delivered as normal keyboard input makes it
difficult to run system scripts as root:root.

Regards,
Brix
--=20
Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Gentoo Metadistribution | Mobile computing herd

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: GnuPG signed

iD8DBQFDwBV8v+Q4flTiePgRAgi/AKCf004d9FxMA4KyIH3iAu/Fk4kU6wCfbERF
ITOn5/ZQyvf9+J0omGGRdCc=
=ohmR
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
