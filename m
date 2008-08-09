From: Yves-Alexis Perez <corsac@debian.org>
Subject: disk problem at resume on 2.6.27-rc
Date: Sat, 09 Aug 2008 12:18:19 +0200
Message-ID: <1218277099.5571.4.camel@hidalgo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j+zrh68g5VUc3ar7JM/c"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:44356 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbYHIKST (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 9 Aug 2008 06:18:19 -0400
Received: from hidalgo.corsac.net (hidalgo.corsac.net [IPv6:2002:5139:30db:0:213:e8ff:fedc:ffab])
	by molly.corsac.net (Postfix) with ESMTP id 08A4382B9D
	for <linux-acpi@vger.kernel.org>; Sat,  9 Aug 2008 12:18:17 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-j+zrh68g5VUc3ar7JM/c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have resume problems with 2.6.27. I tried first with my git (mix of
linux-acpi-2.6 and drm-2.6 + patches for brightness keys), but I can
reproduce with =E2=80=9Cpure=E2=80=9D 2.6.27-rc2, vanilla.

X isn't running, hal, dbus and acpid are. I suspend using:
echo mem > /sys/power/state

But the same happens when using s2ram or pm-suspend.

At resume, first it takes some time before anything appears on the
screen, then I guess some scary errors about sda. I can't save the logs
because hard drive isn't writeable at that moment, but I took a picture
of the screen.

http://molly.corsac.net/~corsac/2.6.27-resume.jpg

I don't really have the initial resume state in dmesg, but can try to
take a picture of that too.

If you need any additional info, please ask.

Cheers,
--=20
Yves-Alexis

--=-j+zrh68g5VUc3ar7JM/c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkidbucACgkQTUTAIMXAW67qnQCfURf2PpH/tbZpPZ/+YK3ab0sy
tSIAnieMr0ibfW5PJDugKdL2/NOmcZ6C
=I2R9
-----END PGP SIGNATURE-----

--=-j+zrh68g5VUc3ar7JM/c--
