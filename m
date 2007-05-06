From: Matthias =?ISO-8859-1?Q?Bl=E4sing?=
	<matthias.blaesing@rwth-aachen.de>
Subject: Regression: Battery not recogniced anymore
Date: Sun, 06 May 2007 16:36:29 +0200
Message-ID: <1178462189.7872.7.camel@prometheus.glx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-TRE4y3XSj1WBRFTHSeI3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:34934 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753510AbXEFOuE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 May 2007 10:50:04 -0400
Received: from r220-1 ([134.130.3.31]) by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHM0061XJ6CXRA0@mta-2.ms.rz.RWTH-Aachen.de> for
 linux-acpi@vger.kernel.org; Sun, 06 May 2007 16:35:00 +0200 (CEST)
Received: from [137.226.29.188]
 (ip29-188.kullen.RWTH-Aachen.DE [137.226.29.188])	(authenticated bits=0)
	by relay-auth.rwth-aachen.de (8.13.8/8.13.1/1) with ESMTP id l46EYxqN021675
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sun, 06 May 2007 16:34:59 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-TRE4y3XSj1WBRFTHSeI3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hallo,

I upgraded from 2.6.20.1 to 2.6.21 and my first battery slot is not
recogniced anymore. This is an Asus M6700NE Notebook.

This is, what acpi -s -V shows:

     Battery 1: slot empty
     Thermal 1: ok, 60.0 degrees C
  AC Adapter 1: on-line

This is the output, when loading the battery module:

ACPI: Battery Slot [BAT1] (battery absent)

These two are partially correct, as is the "normal" battery, that is no
longer recogniced and the multi-bay, where currently CD-ROM is put into,
but that can be exchanged for an akku.

The 2.6.20 Kernel recogniced the first battery also.

I put an acpidump to:

http://www.doppel-helix.eu/acpi.dump

Is there anything more, that I can do?

Thanks in advance

Matthias

--=20
Matthias Bl=E4sing (GPG-Schl=FCsselkennung: A71B4BD5)
ICQ: 84617206   AIM: linuxfun81   MSN: linuxfun@hotmail.com
"Wer die Freiheit aufgibt um Sicherheit zu gewinnen, der wird am Ende beide=
s verlieren."
Benjamin Franklin


--=-TRE4y3XSj1WBRFTHSeI3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGPefswuNy6qcbS9URAuaiAJ9URAIkSANm6VXkF7D4EN0l4h0ErgCfZsvw
Vg7SG2QB3y9dHdUKBUHgH7Q=
=01CY
-----END PGP SIGNATURE-----

--=-TRE4y3XSj1WBRFTHSeI3--


