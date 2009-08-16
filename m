From: Oleksiy Protas <elfy.ua@gmail.com>
Subject: acpi_idle_enter_bm & mwait_idle
Date: Sun, 16 Aug 2009 14:52:46 +0300
Message-ID: <200908161452.53264.elfy.ua@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2131852.84mvYpj87X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51789 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbZHPLwQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Aug 2009 07:52:16 -0400
Received: by bwz22 with SMTP id 22so1840499bwz.18
        for <linux-acpi@vger.kernel.org>; Sun, 16 Aug 2009 04:52:16 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart2131852.84mvYpj87X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am sorry for bugging you guys here, but I've got a question and I think i=
t=20
best fits here. I have an Acer laptop, namely TravelMate 5320 with a Linux =
OS=20
(uname -a gives: Linux seagull 2.6.30-gentoo-r4 #4 Sat Aug 15 01:29:44 EEST=
=20
2009 i686 Intel(R) Celeron(R) CPU 550 @ 2.00GHz GenuineIntel GNU/Linux). Wh=
at=20
I'm observing are regular streak of system unreponsiveness. Performance=20
monitors show an activity of  high-nice processes during these periods.=20
OProfile gives ~24% time eaten by apci_idle_enter_bm() with ACPI enabled an=
d=20
35% time by mwait_idle() with acpi=3Doff, regardless of streak presence or =
just=20
smooth operating time. My question is how can I debug more indepth to see=20
what's happening and what the named functions do so I can or can't blame th=
em=20
for unusable system. Thanks in advance.
=2D-=20
Oleksiy Protas=20
National University =ABKyiv-Mohyla Academy=BB
Institute of Molecular Biology and Genetics, Ukraine
This message is signed. You can obtain a public key to verify it here:
http://minsky.surfnet.nl:11371/pks/lookup?op=3Dget&search=3D0x81B636D4F015B=
7EC

--nextPart2131852.84mvYpj87X
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkqH8xUACgkQgbY21PAVt+wjRgCeLWRzW7vvXJ4PYCSX/6li/DhK
bEUAoIrn3S/vDytQBrxEzicN2jr78tQy
=Bs+S
-----END PGP SIGNATURE-----

--nextPart2131852.84mvYpj87X--
