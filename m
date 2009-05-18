From: Mario Limonciello <mario_limonciello@dell.com>
Subject: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Mon, 18 May 2009 15:12:22 -0500
Message-ID: <4A11C126.1000704@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig08D4E019BB02BAAF0F838102"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:58861 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbZERUMS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2009 16:12:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig08D4E019BB02BAAF0F838102
Content-Type: multipart/mixed;
 boundary="------------000604050903000405080809"

This is a multi-part message in MIME format.
--------------000604050903000405080809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

 Dell BT devices need to be removed from the bus and reinserted
 so that userspace udev rules can transition the devices into the
 proper mode after S3 or S4.

---
 drivers/platform/x86/dell-laptop.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)


Attaching patch so Exchange doesn't mangle it.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------000604050903000405080809
Content-Type: text/x-patch;
 name="0001-Explicitly-disable-BT-radio-using-rfkill-interface-o.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Explicitly-disable-BT-radio-using-rfkill-interface-o.pa";
 filename*1="tch"

=46rom ab8b8ad20dede82f9d13293e94e76b4dd360fcf4 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Mon, 18 May 2009 21:07:59 +0100
Subject: [PATCH] Explicitly disable BT radio using rfkill interface on su=
spend.
 Dell BT devices need to be removed from the bus and reinserted
 so that userspace udev rules can transition the devices into the
 proper mode after S3 or S4.

---
 drivers/platform/x86/dell-laptop.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
index af9f430..90a3d7c 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -186,6 +186,24 @@ static int dell_rfkill_set(int radio, enum rfkill_st=
ate state)
 	return 0;
 }
=20
+static int dell_rfkill_suspend(struct device *dev, pm_message_t state)
+{
+	struct rfkill *rfkill =3D to_rfkill(dev);
+
+	/* store state for the resume handler */
+	rfkill->state_for_resume =3D rfkill->state;
+
+	/* kill radio explicitly if it's on. it needs proper
+	 * reinitialization post suspend */
+	rfkill->toggle_radio(NULL,RFKILL_STATE_SOFT_BLOCKED);
+
+	/* mark class device as suspended */
+	if (dev->power.power_state.event !=3D state.event)
+		dev->power.power_state =3D state;
+
+	return 0;
+}
+
 static int dell_wifi_set(void *data, enum rfkill_state state)
 {
 	return dell_rfkill_set(1, state);
@@ -266,6 +284,7 @@ static int dell_setup_rfkill(void)
 		bluetooth_rfkill->name =3D "dell-bluetooth";
 		bluetooth_rfkill->toggle_radio =3D dell_bluetooth_set;
 		bluetooth_rfkill->get_state =3D dell_bluetooth_get;
+		bluetooth_rfkill->dev.class->suspend =3D dell_rfkill_suspend;
 		ret =3D rfkill_register(bluetooth_rfkill);
 		if (ret)
 			goto err_bluetooth;
--=20
1.5.4.3


--------------000604050903000405080809--

--------------enig08D4E019BB02BAAF0F838102
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoRwSYACgkQ2CrZjkA73Yu2FwCeKkqUlkw3n1aGSnrr4uJVaru8
VyYAn0UB+JvH4ivaSxduLeA1/YoYQvCL
=mF0J
-----END PGP SIGNATURE-----

--------------enig08D4E019BB02BAAF0F838102--
