From: Andreas Messer <andreas.messer@stud-mail.uni-wuerzburg.de>
Subject: [solved] 2.6.21 -- polling /proc/acpi/battery/*/state breaks ibm_acpi
Date: Tue, 15 May 2007 22:18:24 +0200
Message-ID: <20070515201824.GA3456@proton>
References: <20070514115354.GA16885@proton> <20070515030425.GD22949@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52537 "EHLO
	mailrelay.rz.uni-wuerzburg.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755049AbXEOUS1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2007 16:18:27 -0400
Content-Disposition: inline
In-Reply-To: <20070515030425.GD22949@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: hmh@hmh.eng.br


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2007 at 12:04:25AM -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 14 May 2007, Andreas Messer wrote:
> > Up to Kernel 2.6.20 ibm_acpi was working fine on my TP X21.
> > At least all Fn + <?> Keys worked. Now, since 2.6.21 it generally
> > works but: When some Application is polling /proc/acpi/battery/*/state,
> > the Fn - Keys (and perhaps the Lid-Button) became disfunctional until
> > the next reboot. (Terminating the App didn't help)
>=20
> Are you using the latest BIOS and EC firmware for the X21?
>=20

Thanks, that was the solution. Now everything working fine.

greetings
Andreas
--=20
gnuPG keyid: 8C2BAF51
fingerprint: 28EE 8438 E688 D992 3661 C753 90B3 BAAA 8C2B AF51

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGShWPkLO6qowrr1ERApamAKDL0YhnPCCp6K7LBb/g1OPS6EpJAQCg3Cfj
WAQMvfAdIxZ3rcx+AMjn85g=
=9wUN
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
