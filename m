From: Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: Untangling the sleep hotkey mess
Date: Sat, 7 Jan 2006 22:01:03 +0100
Message-ID: <20060107210103.GA5961@osgiliath.brixandersen.dk>
References: <20060107172446.GA3092@srcf.ucam.org> <20060107192444.GA21915@osgiliath.brixandersen.dk> <20060107205232.GA6445@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060107205232.GA6445-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2006 at 08:52:32PM +0000, Matthew Garrett wrote:
> On Sat, Jan 07, 2006 at 08:24:44PM +0100, Henrik Brix Andersen wrote:
> > Having ACPI hotkey events delivered as normal keyboard input makes it
> > difficult to run system scripts as root:root.
>=20
> But that does nothing to help systems which only expose sleep keys via=20
> the keyboard controller. It's not practical to get them to generate ACPI=
=20
> events - however, it /is/ practical to get ACPI events to generate input=
=20
> events. At that point there's nothing to stop a hotkey daemon running as=
=20
> root.

So what you really propose is to abstract the handling of ACPI events
by yet another layer, a hotkey daemon?

=2E/Brix
--=20
Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Gentoo Metadistribution | Mobile computing herd

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: GnuPG signed

iD8DBQFDwCwPv+Q4flTiePgRAohWAKCt2eyd6thOVptS0GFE5csh6sczdgCeL+XZ
khTfGCdzQsrchoxbp2QEink=
=+fCx
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
