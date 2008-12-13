From: Tony Vroon <tony@linx.net>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Sat, 13 Dec 2008 20:55:13 +0000
Message-ID: <1229201713.26333.3.camel@localhost>
References: <1228957506.4045.11.camel@localhost>
	 <20081211165247.GA4844@khazad-dum.debian.net>
	 <1229016827.6446.6.camel@localhost>
	 <20081211194734.GA18132@khazad-dum.debian.net>
	 <1229046602.4030.13.camel@localhost>
	 <20081212195331.GA12679@khazad-dum.debian.net>
	 <alpine.LFD.2.00.0812121532580.4064@localhost.localdomain>
	 <1229172465.4010.11.camel@localhost>
	 <20081213132857.GA11428@khazad-dum.debian.net>
	 <20081213175745.GA6825@srcf.ucam.org>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gscMO4jifkd6Uy60jCQ1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:37365 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbYLMUz4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Dec 2008 15:55:56 -0500
In-Reply-To: <20081213175745.GA6825@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au, Peter Gruber <nokos@gmx.net>, linux-wireless@vger.kernel.org


--=-gscMO4jifkd6Uy60jCQ1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-12-13 at 17:57 +0000, Matthew Garrett wrote:
> If there's no software control at all then I agree that providing an
> rfkill class here isn't appropriate.

Okay, thanks Matthew. For now that's where things stand, no software
control over the radios.

There is actually a beautiful radio control device advertised in the
DSDT as HID FUJ02E1 (internal name CMBT). Unfortunately this device does
not actually appear to be present in the ACPI device list (while FUJ02B1
and FUJ02E3 are, even without a driver loaded).

I can get you the DSDT if it interests you.

Regards,
Tony V.

--=-gscMO4jifkd6Uy60jCQ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklEITEACgkQp5vW4rUFj5qxuACfZs0guAGWgYqq7XqNWPhSp8+k
gPkAoKlB/FxPPYuY1RDAUwIj5UQ6LXj5
=Uy9V
-----END PGP SIGNATURE-----

--=-gscMO4jifkd6Uy60jCQ1--

