From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: BUG: scheduling while atomic: swapper/0/0x10000002
Date: Tue, 10 Aug 2010 18:35:38 +0300
Message-ID: <20100810153538.GB5466@swordfish.minsk.epam.com>
References: <20100810142951.GA7156@arch.tripp.de>
 <4C616DF9.1070309@example.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62810 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572Ab0HJPbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Aug 2010 11:31:08 -0400
Content-Disposition: inline
In-Reply-To: <4C616DF9.1070309@example.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Piotr Hosowicz <piotr@hosowicz.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Heinz Diehl <htd@fancy-poultry.org>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-acpi@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (08/10/10 17:19), Piotr Hosowicz wrote:
> None of them works for me. I do:
>=20
> cat patch.txt | patch -p1
>=20
> And get:
>=20
> aapi205:/usr/src/linux# cat ../smp-bug.txt | patch -p1
> patching file include/acpi/platform/aclinux.h
> Hunk #1 FAILED at 152.
> 1 out of 1 hunk FAILED -- saving rejects to file
> include/acpi/platform/aclinux.h.rej
>=20
> Help me please.
>=20

Can we see your:
include/acpi/platform/aclinux.h(.rej)

?

(did you `git pull`?)


	Sergey

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkxhccoACgkQfKHnntdSXjQ3twP/Y1d+NREvt0x0zZA0JJsZ5B/V
P37MRvxW7H5hBhGulPrS3VY6mvFc4h4XkIfyLNmVDT5DDhFLkixtcOssKuVhNF80
NtTCfqJ358kUNmoBS6UsdPtgCcRWQXK0eb/7JHxK6LP3GNFoTKdtJhIUHDVV2Xbc
Z4RzArahZR9zncFkysM=
=bFdp
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
