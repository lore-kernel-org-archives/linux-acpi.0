From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3 v5] battery: Add the ThinkPad "Not Charging" quirk
Date: Mon, 18 Dec 2017 15:47:15 +0100
Message-ID: <20171218144715.GB2431@amd>
References: <20171210180529.GA2016@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171210180529.GA2016@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-12-10 19:05:29, Ognjen Galic wrote:
> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> of "Unknown" when the battery is between the charge start and
> charge stop thresholds. On Windows, it reports "Not Charging"
> so the quirk has been added to also report correctly.
>=20
> Now the "status" attribute returns "Not Charging" when the
> battery on ThinkPads is not physicaly charging.
>=20
> Tested-by: Kevin Locke <kevin@kevinlocke.name>
> Tested-by: Christoph B=F6hmwalder <christoph@boehmwalder.at>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>

As mentioned before, it would be nice to add a state "not charging for
battery lifetime reasons" and use it here.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlo31PMACgkQMOfwapXb+vJWAwCgnslbv4pIghc2CUsbjEb0tXMb
XZIAn1iVRWyeRl5s0gSNZY3BTYDZv6Aj
=8T5I
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
