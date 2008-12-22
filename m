From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: 2.6.28-rc9 regression: system fails to suspend
Date: Mon, 22 Dec 2008 09:04:25 +0300
Message-ID: <200812220904.28780.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3049585.7jj1lR5UgK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from flock1.newmail.ru ([82.204.219.207]:50569 "HELO
	flock1.newmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751244AbYLVGEc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Dec 2008 01:04:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart3049585.7jj1lR5UgK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I will bisect as time permits, but may be it rings the bell for someone.=20
2.6.28-rc7 is OK; rc9 switches console off and never goes in suspend.=20
Power remains on, keyboard is non-functional and the only way out is=20
power button. I have not tried rc8.

If somebody has soggestions what to (try to) revert, it would be great=20
and save quite a bit of time for bisecting.

--nextPart3049585.7jj1lR5UgK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklPLewACgkQR6LMutpd94wEjgCgzL3Bp3CP7DVf1ZdDmqcKqqzE
/1sAni0Lgy45AHAobPdxGlVF+Mtieddk
=whw5
-----END PGP SIGNATURE-----

--nextPart3049585.7jj1lR5UgK--
