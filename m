From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: 2.6.28-rc3: acpi_tb_create_local_fadt: array subscript is above array bounds
Date: Mon, 3 Nov 2008 11:14:22 +0300
Message-ID: <200811031114.23559.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1941612.lOi2OpQDiG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx39.mail.ru ([194.67.23.35]:59878 "EHLO mx39.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbYKCIO1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:14:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

--nextPart1941612.lOi2OpQDiG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  CC      drivers/acpi/tables/tbfadt.o
/home/bor/src/linux-git/drivers/acpi/tables/tbfadt.c: In function =E2=80=98=
acpi_tb_create_local_fadt=E2=80=99:
/home/bor/src/linux-git/arch/x86/include/asm/string_32.h:75: warning: array=
 subscript is above array bounds                                           =
  =20

--nextPart1941612.lOi2OpQDiG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOst8ACgkQR6LMutpd94wZOwCfXjBa/Xn0ZdxdtJnfQVhpZqNA
/tYAniDi49aPLksohsp/5OksGdB7zV5r
=eB49
-----END PGP SIGNATURE-----

--nextPart1941612.lOi2OpQDiG--
