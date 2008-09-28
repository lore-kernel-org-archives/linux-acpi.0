From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] Fix acpi_power_get_state debug print
Date: Sun, 28 Sep 2008 11:08:46 +0400
Message-ID: <200809281108.46982.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4078290.6tOXnp5Mxe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pusher.mail.ru ([194.67.23.231]:14276 "EHLO mx48.mail.ru"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbYI1HIv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Sep 2008 03:08:51 -0400
Received: from [91.77.193.35] (port=18547 helo=cooker.net)
	by mx48.mail.ru with asmtp
	id 1KjqOe-0001Bz-00
	for linux-acpi@vger.kernel.org; Sun, 28 Sep 2008 11:08:48 +0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart4078290.6tOXnp5Mxe
Content-Type: multipart/mixed;
  boundary="Boundary-01=_+1y3IFicDtJ3tgH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_+1y3IFicDtJ3tgH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Trivial patch to fix debugging output.

-andrey

--Boundary-01=_+1y3IFicDtJ3tgH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix_acpi_power_gwt_status_debug_print"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_acpi_power_gwt_status_debug_print"

Subject: [PATCH] Fix acpi_power_get_state debug print
=46rom: Andrey Borzenkov < arvidjaar@mail.ru>

acpi_power_get_state always printed power state as "on".

Signed-off-by: Andrey Borzenkov < arvidjaar@mail.ru>

=2D--

 drivers/acpi/power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4ab21cb..e05b2f6 100644
=2D-- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -145,7 +145,7 @@ static int acpi_power_get_state(struct acpi_power_resou=
rce *resource, int *state
 			      ACPI_POWER_RESOURCE_STATE_OFF;
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
=2D			  resource->name, state ? "on" : "off"));
+			  resource->name, *state ? "on" : "off"));
=20
 	return 0;
 }

--Boundary-01=_+1y3IFicDtJ3tgH--

--nextPart4078290.6tOXnp5Mxe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjfLX4ACgkQR6LMutpd94xz9QCfQeQdSOOKUb+HcAWiVU039Wfn
T44AoKZTTT1sT3FI190rA4zvQeBrzSUL
=qtqv
-----END PGP SIGNATURE-----

--nextPart4078290.6tOXnp5Mxe--
