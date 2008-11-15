From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 20:17:52 +0300
Message-ID: <200811152017.56926.arvidjaar@mail.ru>
References: <200811081637.45099.arvidjaar@mail.ru> <200811152005.05031.arvidjaar@mail.ru> <20081115171110.GA9332@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart43818431.34Hm8aq9LJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx5.mail.ru ([194.67.23.25]:3976 "EHLO mx5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639AbYKORSC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Nov 2008 12:18:02 -0500
In-Reply-To: <20081115171110.GA9332@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

--nextPart43818431.34Hm8aq9LJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 15 November 2008, Matthew Garrett wrote:
> On Sat, Nov 15, 2008 at 08:05:04PM +0300, Andrey Borzenkov wrote:
> > On Saturday 15 November 2008, Matthew Garrett wrote:
> > > Right. But that doesn't mean they're competing, as such. If you set t=
he=20
> > > brightness via toshiba_acpi
> >=20
> > I probably have problems with expressing myself as non-native English
> > speaker.
> >=20
> > I am not interested in setting values via echoing into sysfs file. I
> > am interested in my desktop brightness control working out of the box.
> > And desktop driver control has no way to select, which of two sysfs
> > files to use. Nor do I understand why I have to create this problem
> > of selecting right driver when I already have possibility to avoid it.
> >=20
> > If you think exposing both knobs is non-issue, why are all those patches
> > for other vendor drivers included in the kernel in the first place?
>=20
> Because in some of those cases, the ACPI and vendor function are=20
> implemented in different ways that can then get out of sync with each=20
> other. As a result, you can get garbage information. If the values in=20
> your two backlight interfaces are always sane, then there's no inherent=20
> need to hide one of them.

THE VALUE IN MY TWO BACKLIGHT INTERFACES ARE NOT THE SAME. I said this many
times already. What exactly is not clear in this sentence?

> The kernel exposes the available functionality =20
> and userland then determines the policy used to choose one over the=20
> other.
>=20



--nextPart43818431.34Hm8aq9LJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkfBEAACgkQR6LMutpd94yiHgCeOK26ghZLB4f3OOmXLkXTNCcw
+VMAni4HJdCQp2baFfWHvKHxHLSOg7tV
=Esl/
-----END PGP SIGNATURE-----

--nextPart43818431.34Hm8aq9LJ--
