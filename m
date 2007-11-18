From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [PATCH] Fix segfault when printing battery status
Date: Sun, 18 Nov 2007 20:49:24 +0100
Message-ID: <200711182049.33355.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3278446.hSVeMvdI4x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:34185 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbXKSIhg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 03:37:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de, kernel list <linux-kernel@vger.kernel.org>

--nextPart3278446.hSVeMvdI4x
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

cat /sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:19/PNP0C0A:00/powe=
r_supply/BAT1/status

This leads to a stacktrace as acpi_battery_get_property() returns 0 for a=20
case where it does not set val->intval. These value is used as an array=20
index in drivers/power/power_supply_sysfs.c::power_supply_show_property().=
=20
I had a situation where the value was 4096 which caused a problem as the=20
array only has 5 entries.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 192c244..2e8e790 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -153,6 +153,8 @@ static int acpi_battery_get_property(struct power_suppl=
y *psy,
 			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
 		else if (battery->state =3D=3D 0)
 			val->intval =3D POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval =3D acpi_battery_present(battery);

--nextPart3278446.hSVeMvdI4x
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHQJdNXKSJPmm5/E4RAo1/AJ9yxv0bDSI2LDSPWlelGPvWX9KRBwCfaMlQ
MqWaei7Vvh/hWrCV+2PDfeM=
=tt+p
-----END PGP SIGNATURE-----

--nextPart3278446.hSVeMvdI4x--
