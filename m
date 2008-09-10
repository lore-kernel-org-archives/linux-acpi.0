From: Yves-Alexis Perez <corsac@debian.org>
Subject: linux-acpi-2.6/test on Thinkpad T61: Battery Absent
Date: Wed, 10 Sep 2008 08:22:49 +0200
Message-ID: <1221027769.3958.1.camel@hidalgo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-n0auBFXzBu+Yt0xjJDe8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:42869 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbYIJGWj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 02:22:39 -0400
Received: from hidalgo.corsac.net (hidalgo.corsac.net [IPv6:2002:5139:30db:0:213:e8ff:fedc:ffab])
	by molly.corsac.net (Postfix) with ESMTP id 7661882CF4
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2008 08:22:37 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI mailing list <linux-acpi@vger.kernel.org>


--=-n0auBFXzBu+Yt0xjJDe8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I just pulled linux-acpi-2.6/test on my git tree, and rebuild the
kernel, and now it doesn't detect any battery:

ACPI: Battery Slot [BAT0] (battery absent)

My tree is at faca89759dd7d4d87309f56cd09ae885a296fb4c and I'll try to
bisect.

Cheers,
--=20
Yves-Alexis

--=-n0auBFXzBu+Yt0xjJDe8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjHZ7MACgkQTUTAIMXAW66TKQCfQL8yuuBNxG4/b+dxjvM7BC2e
9PIAn2K6uTMkw9KohhVyZWKmcXYfaSqE
=nn2M
-----END PGP SIGNATURE-----

--=-n0auBFXzBu+Yt0xjJDe8--
