From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 8 Nov 2008 16:37:44 +0300
Message-ID: <200811081637.45099.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart33144156.kHMv5hMG2y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx71.mail.ru ([194.67.23.4]:56737 "EHLO mx71.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbYKHNhu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 08:37:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

--nextPart33144156.kHMv5hMG2y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Subject: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving=
 this functionality
=46rom: Andrey Borzenkov <arvidjaar@mail.ru>

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

=2D--

This completes backlight series; toshiba_acpi was missing.

 drivers/acpi/toshiba_acpi.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)


diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index a7db0c2..c140709 100644
=2D-- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -780,19 +780,20 @@ static int __init toshiba_acpi_init(void)
 		}
 	}
=20
=2D	toshiba_backlight_device =3D backlight_device_register("toshiba",
+	if (!acpi_video_backlight_support()) {
+		toshiba_backlight_device =3D backlight_device_register("toshiba",
 						&toshiba_acpi.p_dev->dev,
 						NULL,
 						&toshiba_backlight_data);
=2D        if (IS_ERR(toshiba_backlight_device)) {
=2D		ret =3D PTR_ERR(toshiba_backlight_device);
=2D
=2D		printk(KERN_ERR "Could not register toshiba backlight device\n");
=2D		toshiba_backlight_device =3D NULL;
=2D		toshiba_acpi_exit();
=2D		return ret;
+		if (IS_ERR(toshiba_backlight_device)) {
+			ret =3D PTR_ERR(toshiba_backlight_device);
+			printk(KERN_ERR "Could not register toshiba backlight device\n");
+			toshiba_backlight_device =3D NULL;
+			toshiba_acpi_exit();
+			return ret;
+		}
+		toshiba_backlight_device->props.max_brightness =3D HCI_LCD_BRIGHTNESS_LE=
VELS - 1;
 	}
=2D        toshiba_backlight_device->props.max_brightness =3D HCI_LCD_BRIGH=
TNESS_LEVELS - 1;
=20
 	/* Register rfkill switch for Bluetooth */
 	if (hci_get_bt_present(&bt_present) =3D=3D HCI_SUCCESS && bt_present) {

--nextPart33144156.kHMv5hMG2y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVlikACgkQR6LMutpd94xdEACaA79OYSgncln8j2LbZpgnm39V
gBwAoJdjw9SRbsB+mV3lrnHRIU8rPj4+
=Jyhk
-----END PGP SIGNATURE-----

--nextPart33144156.kHMv5hMG2y--
