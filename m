From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: [Bug 8136] 2.6.21-rc2-mm2 won't boot
Date: Wed, 07 Mar 2007 08:36:09 +0100
Message-ID: <1173252969.20978.4.camel@rousalka.dyndns.org>
References: <200703062336.l26NaTZA026385@fire-2.osdl.org>
	 <20070306161559.e0c7ee71.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IhBZ6vCGP/XoOUv3fvok"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:29023 "EHLO mx.laposte.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161281AbXCGHhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 02:37:13 -0500
In-Reply-To: <20070306161559.e0c7ee71.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>


--=-IhBZ6vCGP/XoOUv3fvok
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le mardi 06 mars 2007 =C3=A0 16:15 -0800, Andrew Morton a =C3=A9crit :

> So rc2-mm2 panics due to "MP-BIOS bug: 8254 timer not connected to IO-API=
C" and
> rc2-mm1 does not.
>=20
> Could be ACPI, could be x86_64 timer changes, could be something else.
>=20
> Would you have time to bisect it?=20
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> explains how.
>=20
> If so, I'd suggest you drill in on the patches between
> x86_64-mm-defconfig-update.patch and
> optimize-and-simplify-get_cycles_sync.patch: the x86 changes.

I may have some more debug time this evening (CET), probably not enough
for a full bisection. I'd really love to have timer/clock problems
nailed once and for all on this box (MP BIOS, RTC, HPET, whatever)

--=20
Nicolas Mailhot

--=-IhBZ6vCGP/XoOUv3fvok
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iEYEABECAAYFAkXua2IACgkQI2bVKDsp8g0kBQCg3HJHDiPIGByPvAXtyVwz9cXM
3/IAnRIt2/eRKGWZum0yDVF4gLK6Q3zi
=aCWz
-----END PGP SIGNATURE-----

--=-IhBZ6vCGP/XoOUv3fvok--
