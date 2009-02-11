From: Klaus Lichtenwalder <k.lichtenwalder@computer.org>
Subject: Temperature ridicuously high
Date: Wed, 11 Feb 2009 17:34:20 +0100
Message-ID: <1234370060.4341.9.camel@nepomuk.localdomain>
Reply-To: k.lichtenwalder@computer.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ECW7EKH4kmdXvbOivg+Q"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:43189 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850AbZBKQeb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Feb 2009 11:34:31 -0500
Received: by fxm13 with SMTP id 13so799615fxm.13
        for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2009 08:34:28 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-ECW7EKH4kmdXvbOivg+Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a bit of a loss, I can't find anything about that on google or in
the archive. I do have to machines with a foxconn G31MX motherboard.
Everything is working fine, except the thermal_zone temperature is
ridicuously high. I get a continous reading of about 200=C2=B0... Sometimes=
 a
machine shuts down because of too high values. In the same time, the
cores (Intel 5200 DualCore) have a temperature of ca. 52=C2=B0. If I shut
down the machine and check the bios reading, the temperature is at about
50=C2=B0... There's been a discussion with broken bioses on foxconn (mine
have an award bios), but the problem there was suspend.

I'm on Fedora 10. I activated the debug kernel and got the following log
from acpi:

Feb 11 16:13:21 nepomuk kernel: Execute Method: [\_TZ_.THRM._TMP] (Node
ffff8800ceea8ea0)
Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
ex_system_memory_space: System-Memory (width 16) R/W 0
Address=3D00000000000FF81A
Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
ex_system_memory_space: System-Memory (width 8) R/W 0
Address=3D00000000000FF81C
Feb 11 16:13:21 nepomuk kernel: exregion-0289 [00]
ex_system_io_space_han: System-IO (width 8) R/W 1
Address=3D0000000000000295
Feb 11 16:13:21 nepomuk kernel: exregion-0289 [00]
ex_system_io_space_han: System-IO (width 8) R/W 0
Address=3D0000000000000296
Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
ex_system_memory_space: System-Memory (width 8) R/W 0
Address=3D00000000000FF81C
Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
ex_system_memory_space: System-Memory (width 8) R/W 0
Address=3D00000000000FF840
Feb 11 16:13:21 nepomuk kernel:   utils-0291 [00]
evaluate_integer      : Return value [4772]
Feb 11 16:13:21 nepomuk kernel: thermal-0262 [00]
thermal_get_temperatur: Temperature is 4772 dK

If somebody could help besides manipulating the kernel routine, this
would be greatly appreciated.

thanks,
Klaus
--=20
------------------------------------------------------------------------=20
 Klaus Lichtenwalder, Dipl. Inform.,  http://lklaus.homelinux.org/Klaus/
 PGP Key fingerprint: A5C0 F73A 2C83 96EE 766B  9C62 DB6D 1258 0E9B B6D1


--=-ECW7EKH4kmdXvbOivg+Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmS/gcACgkQ220SWA6bttGdAgCfXy73IbkqtojnXt1XAguXjnr9
MlkAnRchyfWjYT4aOIv86fH4CIQLoVJ9
=yWcp
-----END PGP SIGNATURE-----

--=-ECW7EKH4kmdXvbOivg+Q--

