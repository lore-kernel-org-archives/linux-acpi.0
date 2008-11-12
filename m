From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] Fix argument type for acpi_evaluate_integer in acpi_get_physical_pci_device
Date: Wed, 12 Nov 2008 06:42:38 +0300
Message-ID: <200811120642.43193.arvidjaar@mail.ru>
References: <200811031216.15690.arvidjaar@mail.ru> <20081111142439.b804bdd6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1969958.XdEeNT6Icd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:33725 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbYKLDms (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Nov 2008 22:42:48 -0500
In-Reply-To: <20081111142439.b804bdd6.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1969958.XdEeNT6Icd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 12 November 2008, Andrew Morton wrote:
> On Mon, 3 Nov 2008 12:16:13 +0300
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>=20
> > Subject: [PATCH] Fix argument type for acpi_evaluate_integer in acpi_ge=
t_physical_pci_device
> > From: Andrey Borzenkov <arvidjaar@mail.ru>
> >=20
> > CC      drivers/acpi/glue.o
> > /home/bor/src/linux-git/drivers/acpi/glue.c: In function 'acpi_get_phys=
ical_pci_device':
> > /home/bor/src/linux-git/drivers/acpi/glue.c:157: warning: passing argum=
ent 4 of 'acpi_evaluate_integer' from incompatible pointer type
> >=20
> > acpi_evaluate_integer takes pointer to unsigned long long as fourth arg=
ument
> >=20
> > Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> >=20
> > ---
> >=20
> >  drivers/acpi/glue.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> >=20
> > diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> > index 98c9c76..436c8a3 100644
> > --- a/drivers/acpi/glue.c
> > +++ b/drivers/acpi/glue.c
> > @@ -150,7 +150,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
> >  struct device *acpi_get_physical_pci_device(acpi_handle handle)
> >  {
> >  	struct device *dev;
> > -	long device_id;
> > +	unsigned long long device_id;
> >  	acpi_status status;
> > =20
> >  	status =3D
>=20
> Someone has gone and changed this to `long long', which is still wrong
> but which (surprisingly) doesn't seem to generate a compilation
> warning.
>=20
>=20

Well, size became correct and this is probably what matters most here. I st=
ill
do not quite understand what made this function so special comparing to all
others.

--nextPart1969958.XdEeNT6Icd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkaUK8ACgkQR6LMutpd94zoTgCeN5DhguTDl+HByGCXPA/QwhjC
xvsAn0uMbdq4EYifhzllPtBzb0ctCwb3
=yh/u
-----END PGP SIGNATURE-----

--nextPart1969958.XdEeNT6Icd--
