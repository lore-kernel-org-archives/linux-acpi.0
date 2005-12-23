From: Christian Aichinger <Greek0@gmx.net>
Subject: Re: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and the like due to the ACPI implicit return
Date: Fri, 23 Dec 2005 12:33:47 +0100
Message-ID: <20051223113347.GA20475@orest.greek0.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com> <20051222174226.GB20051@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030495AbVLWLdd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051222174226.GB20051@hell.org.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, Hanno B??ck <mail@hboeck.de>, Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2005 at 06:42:26PM +0100, Karol Kozimor wrote:
> Thus wrote Brown, Len:
> > Karol,
> > Do you have an update of your asus driver in the pipeline
> > that addresses this?
>=20
> Here it goes. Rediffed, also plugs a leak my previous patch introduced. I
> believe it addresses Linus' comments. It's still not a proper fix (see
> below), but I believe it's better than none.
> Best regards,

This will break other hardware as the P30/P35 as well, since there
are some buggy DSDT's out there that return an ACPI_TYPE_BUFFER.
That's the whole reason why I was testing exactly for
ACPI_TYPE_INTEGER in my patch.

My first version was pretty simmilar to yours, until I was told on
acpi-devel that this breaks someone elses hardware (causing it to be
considered as P30/P35, while it isn't). I can dig up the mails if
you want.

Cheers,
Christian

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDq+CbxsP1RlTwJHsRAl73AJ9xWYcwWJtcZyPRVB4ZIoLR5ms84QCfVExj
Tiz4lbngeX171YEyVUEtSOE=
=rhsM
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
