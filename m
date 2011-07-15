From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Brightness on HP EliteBook 8460p
Date: Fri, 15 Jul 2011 14:15:45 +0200
Message-ID: <3123346.jTQFjj4kVk@pali-elitebook>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2334819.vQ1E17oejO"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55273 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1GOMPu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2011 08:15:50 -0400
Received: by ewy4 with SMTP id 4so614679ewy.19
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2011 05:15:49 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--nextPart2334819.vQ1E17oejO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello,

on my HP EliteBook 8460p is not possible to set display brightness when=
 ACPI=20
is enabled in kernel. Entries in sysfs is properly created without erro=
rs. But=20
when I try write any value to /sys/class/backlight/acpi_video0/brightne=
ss=20
nothing happened (and no error is in dmesg). When I press Fn key for ch=
aining=20
display brightness kernel send correct key event (tested with xev) but =
nothing=20
happened too.

When I disabled ACPI (acpi=3Doff in kernel command line) all Fn keys ar=
e broken=20
and not working (no events in xev). But brightness keys working (I thin=
k on HW=20
level, because xev does not see it) - increase and decrease display=20
brightness.

So what can I do with my notebook? I think that there is error/bug in B=
IOS or=20
ACPI because with disabled ACPI brightness working. But with disabled A=
CPI is=20
notebook unuseable (no battery info, no Fn keys, no WIFI rfkill, ...). =
Can=20
somebody help me with this problem?

--=20
Pali Roh=E1r
pali.rohar@gmail.com
--nextPart2334819.vQ1E17oejO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4gL3EACgkQi/DJPQPkQ1IL9QCfUZ7Z8GSiv2d7FlpuwDApKV4p
HXUAn3pl83o/b/5aoiQF7nAtcYrxSec4
=beJd
-----END PGP SIGNATURE-----

--nextPart2334819.vQ1E17oejO--

