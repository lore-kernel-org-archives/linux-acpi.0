From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/4] i2c: i801: Do not create iTCO watchdog when WDAT
 table exists
Date: Thu, 22 Sep 2016 19:48:46 +0200
Message-ID: <20160922174846.GC1861@katana>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
 <20160920123054.195021-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920123054.195021-4-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 03:30:53PM +0300, Mika Westerberg wrote:
> ACPI WDAT table is the preferred way to use hardware watchdog over the
> native iTCO_wdt. Windows only uses this table for its hardware watchdog
> implementation so we should be relatively safe to trust it has been
> validated by OEMs
>=20
> Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

BTW I assume this patch does not go via the i2c tree. Please tell me if
you think otherwise.


--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5Bl+AAoJEBQN5MwUoCm2ttEP/jk3pyBXzxJhezLvKzyQfOdc
DNpj1aQRd5QtJ2mQbvok+gxclBm238kkLkbn/kiuxrqdGx4jcumhv26WHIcxWNMY
Fz8/UFzGrwjGHKxLt1bqdkdN6LvMYVFWK37kcU2rQrlM8BwADXxmw9vuy/qnqMVx
fTBbD+6yJzIUnNh1k6Xz9dz9xyC0gwdh3zqodlGr/xzfX28aNfXRZqiG/Gsao8jy
fq7DREFRHdBI4RS338Xyk5mXatLb2Jj93GXvLNjrhFvZDP4pMfnkHBVeKvKrEC7P
snIluIwT7mPrUWSckQInPqMUNFCaOp7wvzVqrUNswvCEafy/q/ruAafrSaBPWZcQ
cJLhe+gYnxhUt3/Qfmlq0tXbX5vRih84deQyx8tc9MBtQ0HYVA+MwB9A8QYdk+Ko
i4ts+UKYlSBHOGj8A/TrKZR67lZKA6R++q/iwUV8Fti7AnlLq6OIhGLESe3MCaRH
XxZXTc0PrXYjYQM+PGVC++RLu8gH/te2AGeBEufst1nuMrdqjolK04LI57W76XmT
uekezJrIRZqE9KDteyFeKTqyf1h4T/1hn38DM0dNTeNmPuMy04uSDsAI99tFzH5n
zsY8F+Hgv/GBlxjlhuRZJeZBplunxpw9sPsfTjfVDNRDt+P6J3xgCKtpD1qAFmYL
1986gXQMariP+NivPmQn
=ZZI9
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
