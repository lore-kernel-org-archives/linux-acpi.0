From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] Fix argument type for acpi_evaluate_integer in acpi_get_physical_pci_device
Date: Mon, 3 Nov 2008 12:16:13 +0300
Message-ID: <200811031216.15690.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2580284.8bpasYynaP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx40.mail.ru ([194.67.23.36]:54705 "EHLO mx40.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbYKCJQV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 04:16:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

--nextPart2580284.8bpasYynaP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Subject: [PATCH] Fix argument type for acpi_evaluate_integer in acpi_get_ph=
ysical_pci_device
=46rom: Andrey Borzenkov <arvidjaar@mail.ru>

CC      drivers/acpi/glue.o
/home/bor/src/linux-git/drivers/acpi/glue.c: In function 'acpi_get_physical=
_pci_device':
/home/bor/src/linux-git/drivers/acpi/glue.c:157: warning: passing argument =
4 of 'acpi_evaluate_integer' from incompatible pointer type

acpi_evaluate_integer takes pointer to unsigned long long as fourth argument

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

=2D--

 drivers/acpi/glue.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 98c9c76..436c8a3 100644
=2D-- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -150,7 +150,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
 struct device *acpi_get_physical_pci_device(acpi_handle handle)
 {
 	struct device *dev;
=2D	long device_id;
+	unsigned long long device_id;
 	acpi_status status;
=20
 	status =3D

--nextPart2580284.8bpasYynaP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOwV8ACgkQR6LMutpd94yiWwCgxMdkhPNPfg50nlYC3EWwo5gu
c8cAoKm+xRainmJn5ipBLOSkl/qgF8G0
=4y5F
-----END PGP SIGNATURE-----

--nextPart2580284.8bpasYynaP--
