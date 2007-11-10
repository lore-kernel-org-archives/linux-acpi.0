From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] 2.6.24-rc: fix ACPI battery technology reporting
Date: Sat, 10 Nov 2007 20:02:49 +0300
Message-ID: <200711102002.56951.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1507032.5ndqm5vjuy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx6.mail.ru ([194.67.23.26]:14280 "EHLO mx6.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbXKJRDB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Nov 2007 12:03:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Alexey Starikovskiy <aystarik@gmail.com>

--nextPart1507032.5ndqm5vjuy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Subject: [PATCH] 2.6.24-rc: fix ACPI battery technology reporting
=46rom: Andrey Borzenkov <arvidjaar@mail.ru>

At least some systems report technology information with trailing spaces:

{pts/1}% cat -E /var/tmp/bat/2.6.23 | grep type
battery type:            Li-ION  $

Use strncasecmp to compare model string to skip trailing part

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

=2D--

 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c2ce0ad..1905b88 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -125,7 +125,7 @@ static int acpi_battery_technology(struct acpi_battery=
=20
*battery)
 		return POWER_SUPPLY_TECHNOLOGY_NiMH;
 	if (!strcasecmp("LION", battery->type))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
=2D	if (!strcasecmp("LI-ION", battery->type))
+	if (!strncasecmp("LI-ION", battery->type, 6))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
 	if (!strcasecmp("LiP", battery->type))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;

--nextPart1507032.5ndqm5vjuy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHNeQ7R6LMutpd94wRAnk3AJ0VN6zIfwNd46gEbgGJgxcUZDuyZACdERqe
SKxbEFqVuGVDqo+TUM/0DKI=
=Ym//
-----END PGP SIGNATURE-----

--nextPart1507032.5ndqm5vjuy--
