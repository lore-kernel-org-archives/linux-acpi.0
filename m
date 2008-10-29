From: Forest Bond <forest@alittletooquiet.net>
Subject: Jetway J2F2WE-1G5: S1 leaves video on
Date: Wed, 29 Oct 2008 14:25:44 -0400
Message-ID: <20081029182544.GA14582@storm.local.network>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail3.webfaction.com ([70.85.44.146]:34869 "EHLO
	mail3.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYJ2TrP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 15:47:15 -0400
Received: from storm (pool-64-223-124-145.burl.east.verizon.net [64.223.124.145])
	(authenticated bits=0)
	by mail3.webfaction.com (8.13.1/8.13.3) with ESMTP id m9TIPnga025590
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2008 13:25:49 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using vanilla 2.6.27.4.  I `echo standby >/sys/power/state` and the mac=
hine
switches to a console and acts like it is about to go into some sort of low=
er
power mode, but the video stays on.  Is this normal?

I've not used S1 before, mostly S3.  S3 doesn't seem to be supported by this
board (but I'd actually prefer S3, so if you have any advice as to how I mi=
ght
enable it, please let me know).

What information might be helpful for troubleshooting this issue (if it is,=
 in
fact, an issue)?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJCKqoRO4fQQdv5AwRAvLeAJ0ZOQYFnjN7+s2+K1Ho5Sbi5JLAdgCeKvcC
8C3+47uiOSuOOP/k+zUINaE=
=w/hk
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
