From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 4/4] i2c: allow specify device properties in
 i2c_board_info
Date: Tue, 7 Feb 2017 14:25:06 +0100
Message-ID: <20170207132506.jdpcyvlqgonkaitb@ninjato>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
 <20170203014128.317-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3vnrjln5x4tnacdi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40738 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753378AbdBGNZL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Feb 2017 08:25:11 -0500
Content-Disposition: inline
In-Reply-To: <20170203014128.317-5-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>


--3vnrjln5x4tnacdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 05:41:28PM -0800, Dmitry Torokhov wrote:
> With many drivers converting to using generic device properties, it is
> useful to provide array of device properties when instantiating new i2c
> client via i2c_board_info and have them automatically added to the device
> in question.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--3vnrjln5x4tnacdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliZyqwACgkQFA3kzBSg
Kba0SA/+LkB0tknAs51DSZKdkdsg6TCLbyED4uujvSESDQIIDbWo6vLgUzUFvaYZ
rV3+vX11wkgw70QVZfyEDMmKZt7lVzIqD2KWHRDGWuj4UBSSaxPbsCDqBpQZLdk5
TuTByKTkvJ1hUpVWXDuAsfFVo513K4dNpgECVEIgbla2pseWXUWVFZb6Immlbsmy
6IfWVJEMMsux25ao8RbGMKYEnskvpeu/YyKmM29esmV2kFmng62kq3jIrRY+GG43
3Wds2AIs2NY7qOY1U6ydi7m4WeILkoqqZjm80VWkdo4K6GZNzZzZuC1MUjO4ezWx
/7GgsbvnGyJyClfchKSqwjLXHA4RvURy1vYC4o4K1n0qRaOJ8tNdDEtUudVwm0QP
lx2B6KfGUg0p62rGaUt1OJuazLFere9QAEr6qAbk/NtsD/7KUx2PmmyGfgmGUE+g
UYIunLh7eGV0slVhKtuFjHXFqgnaW1BFxDy38I/e/FXL3J3VcyTwPZ4QdFLvHjYy
0gIj0P33c72uy5MAZOFhYBsSTjuZPlDEx8Rgfd59UZ9KPiHBSreQL6hin4jGPgqD
JV7fFUEJ7MScEvnG8qCPY4tB8/yVrbbnVrguZWtw+ah+48KAqm7ZZZzgHkOeJ4t5
U2sk20B/dkd1VphbKsRHjE9xLpv8T9t+i3skrwgkU1mz4uEL/6k=
=ahbf
-----END PGP SIGNATURE-----

--3vnrjln5x4tnacdi--
