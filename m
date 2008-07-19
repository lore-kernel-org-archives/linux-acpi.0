From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
	drivers - version 2
Date: Sat, 19 Jul 2008 08:01:19 +0200
Message-ID: <1216447279.3935.1.camel@hidalgo>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OEr17OValGAC0T8HWHz5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:44228 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbYGSGC0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jul 2008 02:02:26 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 29B355FD59
	for <linux-acpi@vger.kernel.org>; Sat, 19 Jul 2008 08:02:25 +0200 (CEST)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 0C2B15FD3A
	for <linux-acpi@vger.kernel.org>; Sat, 19 Jul 2008 08:02:25 +0200 (CEST)
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it


--=-OEr17OValGAC0T8HWHz5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mer, 2008-07-16 at 12:52 +0200, Thomas Renninger wrote:
> It is highly recommended that these patches are tried out together
> with
> Matthew's/Hong's IGD driver changes.
> I do not know whether they are already in the dri tree or in
> linux-next,
> whether they will be accepted for .27 etc. I hope Matthew will answer
> on
> this mail and tell us.

Ok, I tried to apply them to linux-next/stable (which should be 2.6.26,
I guess) and it didn't work. Patches apply fine, but the kernel is
unbootable (I guess it's the same error than previously, but didn't yet
rebuild with ACPI_DEBUG). Patch doesn't apply to linux-next/master.
--=20
Yves-Alexis

--=-OEr17OValGAC0T8HWHz5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiBgysACgkQTUTAIMXAW65tzACfe4a3ejJoWopHvBWG7rK/ifVa
hHoAn0wz7MiKHIMZG5zcoKOTl098hif/
=XZHO
-----END PGP SIGNATURE-----

--=-OEr17OValGAC0T8HWHz5--
