From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 19:30:57 +0300
Message-ID: <200811151930.58898.arvidjaar@mail.ru>
References: <200811081637.45099.arvidjaar@mail.ru> <200811130758.13420.arvidjaar@mail.ru> <20081113111157.GA30587@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1431708.EXrti5RfbD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx40.mail.ru ([194.67.23.36]:61710 "EHLO mx40.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYKOQbG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Nov 2008 11:31:06 -0500
In-Reply-To: <20081113111157.GA30587@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

--nextPart1431708.EXrti5RfbD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 13 November 2008, Matthew Garrett wrote:
> On Thu, Nov 13, 2008 at 07:58:09AM +0300, Andrey Borzenkov wrote:
>=20
> > - exposing two knobs for the *same* thing confuses user level tools; yo=
u never
> > know which one is used and they compete behind your back
>=20
> How do they compete?

In my case user level program (kpowersave) decided to use video.ko for
brightness control (or, may be, it used them both). Which gave me 2 levels
instead of 8. And there is no way to control it, at least known to me.

Have you looked at link I posted in previous message?

> As I said, the implementations appear to be =20
> implemented on top of the same underlying functionality.

I have no idea and do not care how it is implemented internally. The fact
is, going via ACPI _BCM gives me 2 levels (three if zero counts). Going
via proprietary HCI gives 8.

> The problem =20
> with providing both vendor and ACPI functionality comes when both use=20
> different mechanisms for changing the backlight and so can get out of=20
> sync with each other. Are there any machines supported by toshiba_acpi=20
> where this is the case?
>=20

Yes. Mine and Len's at least :)

--nextPart1431708.EXrti5RfbD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkke+UIACgkQR6LMutpd94xNygCcDn5DNbIGmhh0BcMqUqfyZPGM
XssAoLT2IL2R7gfosblp7ja6vuKt1HiN
=X9g9
-----END PGP SIGNATURE-----

--nextPart1431708.EXrti5RfbD--
