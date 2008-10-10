From: Hanno =?utf-8?q?B=C3=B6ck?= <hanno@hboeck.de>
Subject: Power button not working on T61
Date: Fri, 10 Oct 2008 13:19:51 +0200
Message-ID: <200810101319.52021.hanno@hboeck.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4542798.QrC8AGkryQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zucker.schokokeks.org ([78.46.69.5]:54580 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbYJJLZL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 07:25:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi@linux.intel.com
Cc: linux-acpi@vger.kernel.org

--nextPart4542798.QrC8AGkryQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have a T61 8859WFJ. thinkpad_acpi module is loaded (kernel is 2.6.27, sam=
e=20
was with 2.6.26).

When I press the power button, nothing happens and no acpi event is generat=
ed.=20

I already posted this on the ibm-acpi-devel list and they told me it's=20
probably a problem in acpi core.

My dmesg, if that helps:
http://rafb.net/p/EYOHpq12.html

=2D-=20
Hanno B=C3=B6ck		Blog:		http://www.hboeck.de/
GPG: 3DBD3B20		Jabber/Mail:	hanno@hboeck.de

http://freiheitstattangst.de/ - 11.10. Berlin gegen =C3=9Cberwachung
http://x1000malquer.de/ - ab 8.11. Atomtransporte stoppen

--nextPart4542798.QrC8AGkryQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjvOlcACgkQr2QksT29OyB+hwCaAk1y23b3LxFBKrkTWtVQHWHv
/BQAn0Le3pDbI4r5TjOMgbkExrHjwt9G
=4S1q
-----END PGP SIGNATURE-----

--nextPart4542798.QrC8AGkryQ--
