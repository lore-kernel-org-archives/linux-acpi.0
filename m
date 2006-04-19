From: Henrik Brix Andersen <brix@gentoo.org>
Subject: Re: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Date: Wed, 19 Apr 2006 22:13:23 +0200
Message-ID: <20060419201323.GA26861@osgiliath>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418161100.GA31763@linux.intel.com> <20060419184909.GB23513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751232AbWDSUNd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060419184909.GB23513@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Patrick Mochel <mochel@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2006 at 07:49:09PM +0100, Matthew Garrett wrote:
> Here are some fixed-up versions of my patches to move acpi drivers=20
> towards using the standard backlight interface. I've kept the dynamic=20
> allocation of backlight_device for now, since changing that would also=20
> mean changing the backlight core code and updating other drivers.

Great stuff, I very much welcome these patches. Any plans for doing
the same for the sony_acpi.c driver found in -mm?

Regards,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: GnuPG signed

iD8DBQFERpnjv+Q4flTiePgRAv8jAKCspz80sCcQOPeb1O8W6HLL5jWvmwCfbYhP
R/IT7eJxkaJzpie9HmXvOdM=
=z1jT
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
