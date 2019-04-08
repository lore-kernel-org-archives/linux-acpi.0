From: Pavel Machek <pavel@ucw.cz>
Subject: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Date: Mon, 8 Apr 2019 19:39:14 +0200
Message-ID: <20190408173914.GA13260@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>
Cc: paolo.valente@linaro.org, axboe@kernel.dk, linux-block@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

For some reason, Thinkpad X60 now crashes during boot. I see some
weird backtraces, and it may be bfq related... or maybe ACPI idle.

Does x86-32 work for you?

Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
problems during resume, making it unusable, too). They may not have
100% same configs.=20

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrh0IACgkQMOfwapXb+vIRrACggLsDvfZVSFfbIvrcQZoIKISC
vMcAniBKjgYjIf9rFHdY2PhSUgLR82Zf
=5yXV
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
