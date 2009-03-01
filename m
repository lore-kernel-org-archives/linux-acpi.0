From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: experimental patch for toshiba_acpi
Date: Sun, 1 Mar 2009 10:00:15 +0300
Message-ID: <200903011000.23872.arvidjaar@mail.ru>
References: <200902280015.17286.arvidjaar@mail.ru> <200902280913.45040.arvidjaar@mail.ru> <E1LdTUB-0007ck-1n@oaf.wireless>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1464919.Our2kIx8aZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx40.mail.ru ([94.100.176.54]:57044 "EHLO mx40.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbZCAHAa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Mar 2009 02:00:30 -0500
In-Reply-To: <E1LdTUB-0007ck-1n@oaf.wireless>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles@schwieters.org
Cc: linux-acpi@vger.kernel.org

--nextPart1464919.Our2kIx8aZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 28 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2009 21:00:26 Charles@schw=
ieters.org wrote:
>
> > But then I do not understand why you need this in toshiba_acpi in
> > the first place. We already have in-kernel module (toshiba) that
> > provides raw user space HCI access to those who need it. Why is it
> > necessary to duplicate this functionality in toshiba_acpi in the
> > first place?
>
> I did have reports of some machines like yours. This is the result on
> a portege r100 (with unpatched toshiba_acpi:
>
> % lsmod | grep tosh
> toshiba_acpi            5336  0
> toshiba                 4152  0
> % fan
> fan: laptop does not have cooling fan or kernel module not installed.
>
> Behavior on most machines (and all three of mine) seems to be the
> same.
>

Sorry for dumb question but are you doing it as root?

--nextPart1464919.Our2kIx8aZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmqMoEACgkQR6LMutpd94zkJgCfdIyndJpdfzF1o4SYRj6KClYv
VAEAoIky7gD31qVImJDcO6Q9nBK1+jOM
=niN4
-----END PGP SIGNATURE-----

--nextPart1464919.Our2kIx8aZ--
