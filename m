From: Matthias =?ISO-8859-1?Q?Bl=E4sing?=
	<matthias.blaesing@rwth-aachen.de>
Subject: 2.6.22-rc1-git5 hangs on boot
Date: Thu, 17 May 2007 18:35:08 +0200
Message-ID: <1179419708.24672.6.camel@prometheus.glx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-7MpjJq9cUBM8keg+j5Ur"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:42819 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755705AbXEQQf0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 12:35:26 -0400
Received: from r220-1 ([134.130.3.31]) by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI700FS022POZ90@mta-2.ms.rz.RWTH-Aachen.de> for
 linux-acpi@vger.kernel.org; Thu, 17 May 2007 18:35:13 +0200 (CEST)
Received: from [137.226.29.188]
 (ip29-188.kullen.RWTH-Aachen.DE [137.226.29.188])	(authenticated bits=0)
	by relay-auth.rwth-aachen.de (8.13.8/8.13.1/1) with ESMTP id l4HGZDPb004493
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 17 May 2007 18:35:13 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-7MpjJq9cUBM8keg+j5Ur
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

there was/is a regression in ACPI (my internal battery is not recogniced
anymore: http://article.gmane.org/gmane.linux.acpi.devel/22838.

So I got the latest test version of the kernel and compiled it, to see
whether the regression still exists. I compiled the kernel and got this
after boot:

http://www.doppel-helix.eu/acpi_hang.jpg

It does not boot further. Any ideas?!

Greetings

Matthias

--=20
Matthias Bl=E4sing (GPG-Schl=FCsselkennung: A71B4BD5)
ICQ: 84617206   AIM: linuxfun81   MSN: linuxfun@hotmail.com
"Wer die Freiheit aufgibt um Sicherheit zu gewinnen, der wird am Ende beide=
s verlieren."
Benjamin Franklin


--=-7MpjJq9cUBM8keg+j5Ur
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGTIQ8wuNy6qcbS9URAkt+AJ98moq+ETi3M7kXAa8sSLTa+A11bQCfV/Re
aq6fNHSOkrbBi+wHcrnYDcg=
=Ba1/
-----END PGP SIGNATURE-----

--=-7MpjJq9cUBM8keg+j5Ur--


