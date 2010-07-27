From: Pierre <pinaraf@pinaraf.info>
Subject: Patch for toshiba_acpi driver : add illumination support
Date: Wed, 28 Jul 2010 01:49:54 +0200
Message-ID: <201007280149.54905.pinaraf@pinaraf.info>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2880663.yiHRO03Lff";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50887 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab0G0Xt5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jul 2010 19:49:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart2880663.yiHRO03Lff
Content-Type: multipart/mixed;
  boundary="Boundary-01=_iC3TMqZeB9zL0hn"
Content-Transfer-Encoding: 7bit


--Boundary-01=_iC3TMqZeB9zL0hn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

A friend of mine owns a Toshiba Qosmio G55, which include some LEDs illumin=
ating=20
the keyboard. Toshiba calls that technology "illumination", and doesn't pro=
vide=20
any Linux driver nor documentation.
After reverse engineering the Windows driver, I got a patch for the toshiba=
_acpi=20
driver that adds support for this hardware.
Is this the right mailing list to send this patch ?
I attached it to this mail. Do not hesitate to comment it.
I know the hardcoded hexadecimal values are stranges, but I didn't find the=
ir=20
meaning, I only know that they have to be used in that order, and that any=
=20
missing call will make it fail.
Of course, if this is not the right procedure or the right place, please co=
rrect=20
me.

Thanks
 Pierre Ducroquet.

--Boundary-01=_iC3TMqZeB9zL0hn
Content-Type: text/x-patch;
  charset="UTF-8";
  name="toshiba_illumination.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="toshiba_illumination.patch"

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/tos=
hiba_acpi.c
index 37aa147..f3a0d95 100644
=2D-- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2002-2004 John Belmonte
  *  Copyright (C) 2008 Philip Langdale
+ *  Copyright (C) 2010 Pierre Ducroquet
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -47,6 +48,7 @@
 #include <linux/platform_device.h>
 #include <linux/rfkill.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <linux/slab.h>
=20
 #include <asm/uaccess.h>
@@ -285,6 +287,7 @@ struct toshiba_acpi_dev {
        struct platform_device *p_dev;
        struct rfkill *bt_rfk;
        struct input_dev *hotkey_dev;
+       int illumination_installed;
        acpi_handle handle;
=20
        const char *bt_name;
@@ -292,6 +295,111 @@ struct toshiba_acpi_dev {
        struct mutex mutex;
 };
=20
+/* Illumination support */
+static int toshiba_illumination_available (void)
+{
+       u32 in[HCI_WORDS] =3D { 0, 0, 0, 0, 0, 0 };
+       u32 out[HCI_WORDS];
+       acpi_status status;
+
+       in[0] =3D 0xf100;
+       status =3D hci_raw(in, out);
+       if (ACPI_FAILURE(status)) {
+               printk(MY_INFO "The illumination device available is not av=
ailable\n");
+               return 0;
+       }
+       in[0] =3D 0xf400;
+       status =3D hci_raw(in, out);
+       return 1;
+}
+
+static void toshiba_illumination_set (struct led_classdev *cdev,=20
+                                      enum led_brightness brightness)
+{
+       u32 in[HCI_WORDS] =3D { 0, 0, 0, 0, 0, 0 };
+       u32 out[HCI_WORDS];
+       acpi_status status;
+
+       // First request : initialize communication.
+       in[0] =3D 0xf100;
+       status =3D hci_raw(in, out);
+       if (ACPI_FAILURE(status)) {
+               printk(MY_INFO "The illumination device available is not av=
ailable\n");
+               return;
+       }
+
+       if (brightness) {
+               // Switch the illumination on
+               in[0] =3D 0xf400;
+               in[1] =3D 0x14e;
+               in[2] =3D 1;
+               status =3D hci_raw(in, out);
+               if (ACPI_FAILURE(status)) {
+                       printk(MY_INFO "ACPI call for illumination failed.\=
n");
+                       return;
+               }
+       } else {
+               // Switch the illumination off
+               in[0] =3D 0xf400;
+               in[1] =3D 0x14e;
+               in[2] =3D 0;
+               status =3D hci_raw(in, out);
+               if (ACPI_FAILURE(status)) {
+                       printk(MY_INFO "ACPI call for illumination failed.\=
n");
+                       return;
+               }
+       }
+
+       // Last request : close communication.
+       in[0] =3D 0xf200;
+       in[1] =3D 0;
+       in[2] =3D 0;
+       hci_raw(in, out);
+}
+
+static enum led_brightness toshiba_illumination_get(struct led_classdev *c=
dev)
+{
+       u32 in[HCI_WORDS] =3D { 0, 0, 0, 0, 0, 0 };
+       u32 out[HCI_WORDS];
+       acpi_status status;
+       enum led_brightness result;
+
+       // First request : initialize communication.
+       in[0] =3D 0xf100;
+       status =3D hci_raw(in, out);
+       if (ACPI_FAILURE(status)) {
+               printk(MY_INFO "The illumination device available is not av=
ailable\n");
+               return LED_OFF;
+       }
+
+       // Check the illumination
+       in[0] =3D 0xf300;
+       in[1] =3D 0x14e;
+       status =3D hci_raw(in, out);
+       if (ACPI_FAILURE(status)) {
+               printk(MY_INFO "ACPI call for illumination failed.\n");
+               return LED_OFF;
+       }
+
+       result =3D out[2] ? LED_FULL : LED_OFF;
+
+       // Last request : close communication.
+       in[0] =3D 0xf200;
+       in[1] =3D 0;
+       in[2] =3D 0;
+       hci_raw(in, out);
+
+       return result;
+}
+
+static struct led_classdev toshiba_led =3D {
+       .name           =3D "toshiba::illumination",
+       .max_brightness =3D 1,
+       .brightness_set =3D toshiba_illumination_set,
+       .brightness_get =3D toshiba_illumination_get,
+};
+
+
 static struct toshiba_acpi_dev toshiba_acpi =3D {
        .bt_name =3D "Toshiba Bluetooth",
 };
@@ -845,7 +953,7 @@ static int toshiba_acpi_setup_keyboard(char *device)
        acpi_handle handle;
        int result;
        const struct key_entry *key;
=2D
+
        status =3D acpi_get_handle(NULL, device, &handle);
        if (ACPI_FAILURE(status)) {
                printk(MY_INFO "Unable to get notification device\n");
@@ -853,7 +961,7 @@ static int toshiba_acpi_setup_keyboard(char *device)
        }
=20
        toshiba_acpi.handle =3D handle;
=2D
+
        status =3D acpi_evaluate_object(handle, "ENAB", NULL, NULL);
        if (ACPI_FAILURE(status)) {
                printk(MY_INFO "Unable to enable hotkeys\n");
@@ -903,6 +1011,10 @@ static void toshiba_acpi_exit(void)
                rfkill_destroy(toshiba_acpi.bt_rfk);
        }
=20
+       if (toshiba_acpi.illumination_installed) {
+               led_classdev_unregister(&toshiba_led);
+       }
+
        if (toshiba_backlight_device)
                backlight_device_unregister(toshiba_backlight_device);
=20
@@ -1012,6 +1124,12 @@ static int __init toshiba_acpi_init(void)
                        return ret;
                }
        }
+
+       toshiba_acpi.illumination_installed =3D 0;
+       if (toshiba_illumination_available()) {
+               if (!led_classdev_register(&(toshiba_acpi.p_dev->dev), &tos=
hiba_led))
+                       toshiba_acpi.illumination_installed =3D 1;
+       }
=20
        return 0;
 }

--Boundary-01=_iC3TMqZeB9zL0hn--

--nextPart2880663.yiHRO03Lff
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxPcKIACgkQZA1EFZCdHVuVagCePZARSQ8uPTNiBeU2uWSPQXNg
N1wAn002ih5BvaSQL9Y+eAJZpRMX6Wa8
=+sHy
-----END PGP SIGNATURE-----

--nextPart2880663.yiHRO03Lff--
