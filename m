From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [2.6.24-rc1 regression] AC adapter state does not change after resume
Date: Tue, 30 Oct 2007 23:24:51 +0300
Message-ID: <200710302324.52822.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1546644.vGhVvDxAE7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx38.mail.ru ([194.67.23.16]:64884 "EHLO mx38.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759232AbXJ3UY7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 16:24:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

--nextPart1546644.vGhVvDxAE7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I suspect new ACPI AC adapter code but have to add some printk's to be sure.

To reproduce - plug in AC cord, suspend, unplug, resume - kpowersave and sy=
sfs=20
still show AC adapter online. Or other way round.

=2Dandrey

--nextPart1546644.vGhVvDxAE7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHJ5MUR6LMutpd94wRAueKAJ9LKmBPLr7UYvtE47hvS5EYnOBQ/gCgicmI
AoS/lPf2FWK0/mPq6rXacnc=
=DKAX
-----END PGP SIGNATURE-----

--nextPart1546644.vGhVvDxAE7--
