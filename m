From: Yves-Alexis Perez <corsac@debian.org>
Subject: [intel/acpi] backlight
Date: Fri, 28 Nov 2008 07:47:04 +0100
Message-ID: <1227854824.3477.9.camel@hidalgo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LefRNLEqLCXADtYXsmfc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp8-g19.free.fr ([212.27.42.65]:51284 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbYK1Gs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Nov 2008 01:48:27 -0500
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id B630432A6F0
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2008 07:48:25 +0100 (CET)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 9CF7932A6E6
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2008 07:48:25 +0100 (CET)
Received: from hidalgo.corsac.net (hidalgo.corsac.net [IPv6:2002:5139:30db:0:213:e8ff:fedc:ffab])
	by molly.corsac.net (Postfix) with ESMTP id 7BB3482DA9
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2008 07:46:52 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-LefRNLEqLCXADtYXsmfc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
Intel GM965. Under X, brightness keys work fine most of the time, but in
some case it fails (for example after a dpms force off, but not always).
Switching to console and back to X fix the problem for a time.

Another weird stuff is that, in single user, I have no way to control
the backlight. Using brightness key doesn't work,
and /sys/class/backlight/acpi_video0 doesn't do anything.

I know there was a lot of enhancements with OpRegion stuff for 2.6.27
and 2.6.28, and it's maybe not finished, but are those problems known?

Cheers, and many thanks for the good work :)
--=20
Yves-Alexis

--=-LefRNLEqLCXADtYXsmfc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkvk+QACgkQTUTAIMXAW65RMQCeJi27BshBH8IKa1PnvrgXzq7a
GQ8AmgMY9/sFDWzX5+SX5IH3FgX7aOtz
=7cCR
-----END PGP SIGNATURE-----

--=-LefRNLEqLCXADtYXsmfc--
