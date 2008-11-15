From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 20:05:04 +0300
Message-ID: <200811152005.05031.arvidjaar@mail.ru>
References: <200811081637.45099.arvidjaar@mail.ru> <200811151930.58898.arvidjaar@mail.ru> <20081115165415.GA9117@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1534872.EOPz5dCv4L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx6.mail.ru ([194.67.23.26]:26775 "EHLO mx6.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbYKORFK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Nov 2008 12:05:10 -0500
In-Reply-To: <20081115165415.GA9117@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

--nextPart1534872.EOPz5dCv4L
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 15 November 2008, Matthew Garrett wrote:
> On Sat, Nov 15, 2008 at 07:30:57PM +0300, Andrey Borzenkov wrote:
> > On Thursday 13 November 2008, Matthew Garrett wrote:
> > > On Thu, Nov 13, 2008 at 07:58:09AM +0300, Andrey Borzenkov wrote:
> > >=20
> > > > - exposing two knobs for the *same* thing confuses user level tools=
; you never
> > > > know which one is used and they compete behind your back
> > >=20
> > > How do they compete?
> >=20
> > In my case user level program (kpowersave) decided to use video.ko for
> > brightness control (or, may be, it used them both). Which gave me 2 lev=
els
> > instead of 8. And there is no way to control it, at least known to me.
>=20
> Right. But that doesn't mean they're competing, as such. If you set the=20
> brightness via toshiba_acpi

I probably have problems with expressing myself as non-native English
speaker.

I am not interested in setting values via echoing into sysfs file. I
am interested in my desktop brightness control working out of the box.
And desktop driver control has no way to select, which of two sysfs
files to use. Nor do I understand why I have to create this problem
of selecting right driver when I already have possibility to avoid it.

If you think exposing both knobs is non-issue, why are all those patches
for other vendor drivers included in the kernel in the first place?

> to a value that isn't supported via the =20
> acpi driver, what value does the acpi backlight claim to be at?
>=20



--nextPart1534872.EOPz5dCv4L
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkfAUAACgkQR6LMutpd94xMjgCfaLViMDNVv8MEb50q3y/cBU6X
ZaAAnRwEJ8W9vCvd6szOykpVpl3O6A1V
=MhrB
-----END PGP SIGNATURE-----

--nextPart1534872.EOPz5dCv4L--
