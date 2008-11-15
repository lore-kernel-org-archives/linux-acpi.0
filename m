From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 21:42:17 +0300
Message-ID: <200811152142.18890.arvidjaar@mail.ru>
References: <200811081637.45099.arvidjaar@mail.ru> <200811152017.56926.arvidjaar@mail.ru> <20081115172052.GA9537@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1317268.pcLKvS7Rfn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx71.mail.ru ([194.67.23.4]:65461 "EHLO mx71.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbYKOSmZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Nov 2008 13:42:25 -0500
In-Reply-To: <20081115172052.GA9537@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

--nextPart1317268.pcLKvS7Rfn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 15 November 2008, Matthew Garrett wrote:
> On Sat, Nov 15, 2008 at 08:17:52PM +0300, Andrey Borzenkov wrote:
> > On Saturday 15 November 2008, Matthew Garrett wrote:
> > > > If you think exposing both knobs is non-issue, why are all those pa=
tches
> > > > for other vendor drivers included in the kernel in the first place?
> > >=20
> > > Because in some of those cases, the ACPI and vendor function are=20
> > > implemented in different ways that can then get out of sync with each=
=20
> > > other. As a result, you can get garbage information. If the values in=
=20
> > > your two backlight interfaces are always sane, then there's no inhere=
nt=20
> > > need to hide one of them.
> >=20
> > THE VALUE IN MY TWO BACKLIGHT INTERFACES ARE NOT THE SAME. I said this =
many
> > times already. What exactly is not clear in this sentence?
>=20
> Where did I say that they were? You never answered the question I asked=20
> - if you set the value in the toshiba specific backlight control to a=20
> value that isn't supported via the generic acpi one, what value does the=
=20
> generic acpi one claim to have?
>=20

sh-3.2# cat /sys/class/backlight/acpi_video0/brightness
2
sh-3.2# cat /sys/class/backlight/acpi_video0/actual_brightness
2
sh-3.2# cat /sys/class/backlight/acpi_video0/max_brightness
2
sh-3.2# cat /sys/class/backlight/toshiba/brightness
7
sh-3.2# cat /sys/class/backlight/toshiba/actual_brightness
7
sh-3.2# cat /sys/class/backlight/toshiba/max_brightness
7
sh-3.2# echo 5 > /sys/class/backlight/toshiba/brightnes
sh-3.2# cat /sys/class/backlight/acpi_video0/brightness
2
sh-3.2# cat /sys/class/backlight/acpi_video0/actual_brightness
2
sh-3.2# echo 5 > /sys/class/backlight/acpi_video0/brightness
sh: echo: write error: Invalid argument
sh-3.2# echo 1 > /sys/class/backlight/acpi_video0/brightness
sh-3.2# cat /sys/class/backlight/toshiba/brightness
5
sh-3.2# cat /sys/class/backlight/toshiba/actual_brightness
3
sh-3.2# echo 7 > /sys/class/backlight/toshiba/brightness
sh-3.2# cat /sys/class/backlight/acpi_video0/brightness
1
sh-3.2# cat /sys/class/backlight/acpi_video0/actual_brightness
1


--nextPart1317268.pcLKvS7Rfn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkfGAoACgkQR6LMutpd94wq7wCgkpl5diTQHLR4EKqaYDn+lG1n
5psAnROcMa3C+sye8fdCyh8vWMvJ258F
=7uXM
-----END PGP SIGNATURE-----

--nextPart1317268.pcLKvS7Rfn--
