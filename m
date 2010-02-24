From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: closing lid on laptop suspends it
Date: Wed, 24 Feb 2010 07:17:13 -0500
Message-ID: <1267013831.21643.199.camel@pc.interlinx.bc.ca>
References: <1265718787.2459.56.camel@pc.interlinx.bc.ca>
	 <4B76EFF8.6000108@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-FZEf1+mBnzsI5Ps8RAFQ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52177 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756449Ab0BXMRc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Feb 2010 07:17:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1NkGBF-0000M3-8v
	for linux-acpi@vger.kernel.org; Wed, 24 Feb 2010 13:17:29 +0100
Received: from d67-193-197-208.home3.cgocable.net ([67.193.197.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 24 Feb 2010 13:17:29 +0100
Received: from brian by d67-193-197-208.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 24 Feb 2010 13:17:29 +0100
In-Reply-To: <4B76EFF8.6000108@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-FZEf1+mBnzsI5Ps8RAFQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-02-13 at 12:31 -0600, Robert Hancock wrote:=20
>=20
> I suspect there's some power management task running even before login=20
> that's using some default preferences. The kernel doesn't trigger a=20
> suspend by itself.

Just to tie up loose ends, yes, indeed, it was a power manager,
gnome-power-manager, started by gdm that was at fault here.  The problem
is that the default policy for g-p-m is to suspend on lid close, even
when plugged into AC.  One has to jump through a hoop or two to change
the gdm user's policy so that it overrides the default policy.

Thanx for the help!

b.


--=-FZEf1+mBnzsI5Ps8RAFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuFGMYACgkQl3EQlGLyuXB1OACffnKv3S3OOH5qOJJQJ1y80PWx
bdsAoMC8AkIfzAD9gaVmDgAXf/UcI5ek
=ZKuf
-----END PGP SIGNATURE-----

--=-FZEf1+mBnzsI5Ps8RAFQ--


