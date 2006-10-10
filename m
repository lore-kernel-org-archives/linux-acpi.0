From: Matthias Hentges <oe@hentges.net>
Subject: cpufreq frequencies off for Core 2 Duo E6600 "Conroe"
Date: Tue, 10 Oct 2006 02:41:03 +0200
Message-ID: <1160440863.4575.69.camel@mhcln03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aaYvEHuJ0WPiz/DXt/0D"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hentges.net ([81.169.178.128]:17886 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1751919AbWJJAlC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Oct 2006 20:41:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by h6563.serverkompetenz.net (Postfix) with ESMTP id 9E3C53081E9
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 02:41:00 +0200 (CEST)
Received: from h6563.serverkompetenz.net ([127.0.0.1])
	by localhost (h6563 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22070-10 for <linux-acpi@vger.kernel.org>;
	Tue, 10 Oct 2006 02:40:56 +0200 (CEST)
Received: from mhcln03.hentges.priv (xdsl-213-196-220-48.netcologne.de [213.196.220.48])
	by h6563.serverkompetenz.net (Postfix) with ESMTP id B3F023081E6
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 02:40:55 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-aaYvEHuJ0WPiz/DXt/0D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm the happy user of a shiny new C2D E6600 CPU. While cpufreq works, it
only offers support for the lowest possible frequency (1596MHz)

(Linux mhcln01 2.6.19-rc1-git5-mh02 #3 SMP Tue Oct 10 01:35:05 CEST 2006
i686 GNU/Linux )

root@mhcln01:../system/cpu/cpu0/cpufreq >cat
scaling_available_frequencies=20
2394000 2394000 2394000 2394000 2394000 2394000 2394000 2394000 2394000
1596000=20

As I understand it, the command above should list all possible "steps"
for this CPU. The E6600 supports a multiplicator change between 6 and 9.
For a default FSB of 266 this would mean the valid steps for the CPU
are:

2394000 2128000 1862000 1596000=20

There is another thing bugging me with cpufreq:
+root@mhcln01:../system/cpu/cpu0/cpufreq >cat scaling_cur_freq=20
1596000
+root@mhcln01:../system/cpu/cpu0/cpufreq >cat cpuinfo_cur_freq=20
1596000

Since the machine is overclocked to FSB301 (2.7GHz), the output above is
clearly wrong (should read 6 x 301 =3D 1806MHz). I wonder if it would be
possible to replace the output with the real frequency, not some
hard-wired frequency/vcore value?

Thanks for your time.
--=20
Matthias 'CoreDump' Hentges=20

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-aaYvEHuJ0WPiz/DXt/0D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKuwfAq2P5eLUP5IRAn2/AJ9KxfX+3dZgjR2vhJ1Cff19oYzRzACfYzya
9qAqtXi6pOnjJQ8SFi0uCK0=
=d86o
-----END PGP SIGNATURE-----

--=-aaYvEHuJ0WPiz/DXt/0D--

