From: "Matthew W. S. Bell" <matthew@bells23.org.uk>
Subject: [PATCH 1/2] Gracefully handle disabled ACPI and a lack of procfs.
Date: Mon, 01 Feb 2010 21:16:09 +0000
Message-ID: <1265058969.3824.10.camel@ibis.bells>
Reply-To: matthew@bells23.org.uk, linux-acpi@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rNdbH6yD6IO9aKaVCIGi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from garuda.bells23.org.uk ([85.13.250.28]:59524 "EHLO
	garuda.bells23.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab0BAVyX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 16:54:23 -0500
Received: from localhost ([127.0.0.1] helo=garuda.bells23.org.uk)
	by garuda.bells23.org.uk with esmtp (Exim 4.69)
	(envelope-from <matthew@bells23.org.uk>)
	id 1Nc3fB-0003UP-B7
	for linux-acpi@vger.kernel.org; Mon, 01 Feb 2010 21:18:29 +0000
Received: from [80.65.240.47] (port=56938 helo=[192.168.1.230])
	by garuda.bells23.org.uk with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <matthew@bells23.org.uk>)
	id 1Nc3fA-0003UL-6Y
	for linux-acpi@vger.kernel.org; Mon, 01 Feb 2010 21:18:29 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-rNdbH6yD6IO9aKaVCIGi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For every ACPI module, explicitly check acpi_disabled on load and
print an
appropriate error message if set.

Also, add conditional macros around procfs code in init functions.
---
 drivers/acpi/acpi_memhotplug.c |    6 ++++--
 drivers/acpi/acpi_pad.c        |    5 +++++
 drivers/acpi/button.c          |    9 +++++++++
 drivers/acpi/container.c       |    5 +++++
 drivers/acpi/fan.c             |    6 ++++++
 drivers/acpi/pci_slot.c        |    7 ++++++-
 drivers/acpi/sbshc.c           |    5 +++++
 drivers/acpi/thermal.c         |   10 ++++++++++
 drivers/acpi/video.c           |    9 +++++++++
 9 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c
b/drivers/acpi/acpi_memhotplug.c
index 28ccdbc..1477243 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -529,9 +529,12 @@ static int __init acpi_memory_device_init(void)
 	int result;
 	acpi_status status;
=20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
=20
 	result =3D acpi_bus_register_driver(&acpi_memory_device_driver);
-
 	if (result < 0)
 		return -ENODEV;
=20
@@ -539,7 +542,6 @@ static int __init acpi_memory_device_init(void)
 				     ACPI_UINT32_MAX,
 				     acpi_memory_register_notify_handler,
 				     NULL, NULL);
-
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 0d2cdb8..e53cb6b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -495,6 +495,11 @@ static struct acpi_driver acpi_pad_driver =3D {
=20
 static int __init acpi_pad_init(void)
 {
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
 	power_saving_mwait_init();
 	if (power_saving_mwait_eax =3D=3D 0)
 		return -EINVAL;
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 8a95e83..a5a6f84 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -456,13 +456,22 @@ static int __init acpi_button_init(void)
 {
 	int result;
=20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_button_dir =3D proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
 		return -ENODEV;
+#endif
=20
 	result =3D acpi_bus_register_driver(&acpi_button_driver);
 	if (result < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
+#endif
 		return -ENODEV;
 	}
=20
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 642bb30..46ae7df 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -249,6 +249,11 @@ static int __init acpi_container_init(void)
 	int result =3D 0;
 	int action =3D INSTALL_NOTIFY_HANDLER;
=20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
 	result =3D acpi_bus_register_driver(&acpi_container_driver);
 	if (result < 0) {
 		return (result);
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f419849..52f6419 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -347,6 +347,10 @@ static int __init acpi_fan_init(void)
 {
 	int result =3D 0;
=20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
=20
 #ifdef CONFIG_ACPI_PROCFS
 	acpi_fan_dir =3D proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
@@ -356,7 +360,9 @@ static int __init acpi_fan_init(void)
=20
 	result =3D acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
+#endif
 		return -ENODEV;
 	}
=20
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 45da2ba..91de70f 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -355,7 +355,12 @@ static struct dmi_system_id
acpi_pci_slot_dmi_table[] __initdata =3D {
=20
 static int __init
 acpi_pci_slot_init(void)
-{
+{ =20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
 	dmi_check_system(acpi_pci_slot_dmi_table);
 	acpi_pci_register_driver(&acpi_pci_slot_driver);
 	return 0;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index d933980..f00780e 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -312,6 +312,11 @@ static int __init acpi_smb_hc_init(void)
 {
 	int result;
=20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
 	result =3D acpi_bus_register_driver(&acpi_smb_hc_driver);
 	if (result < 0)
 		return -ENODEV;
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 65f6781..cdbb827 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1534,19 +1534,29 @@ static int __init acpi_thermal_init(void)
 {
 	int result =3D 0;
=20
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
 	dmi_check_system(thermal_dmi_table);
=20
 	if (off) {
 		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
 		return -ENODEV;
 	}
+
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_thermal_dir =3D proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
 		return -ENODEV;
+#endif
=20
 	result =3D acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
+#endif
 		return -ENODEV;
 	}
=20
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 05dff63..045e634 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2379,13 +2379,17 @@ int acpi_video_register(void)
 		return 0;
 	}
=20
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_video_dir =3D proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
 		return -ENODEV;
+#endif
=20
 	result =3D acpi_bus_register_driver(&acpi_video_bus);
 	if (result < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+#endif
 		return -ENODEV;
 	}
=20
@@ -2427,6 +2431,11 @@ EXPORT_SYMBOL(acpi_video_unregister);
=20
 static int __init acpi_video_init(void)
 {
+	if (acpi_disabled) {
+		printk(KERN_ERR AE_INFO ": ACPI is disabled.\n");
+		return -ENODEV;
+	}
+
 	dmi_check_system(video_dmi_table);
=20
 	if (intel_opregion_present())
--=20
1.6.5


--=-rNdbH6yD6IO9aKaVCIGi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJLZ0SPAAoJEDyn+gO8EoIo6wMIALZSNihM9phsCU2BB8xuDQSV
mfdL5UYXdowMa8t/lHRhoskUUGyKI/TCBCGWCh6PZg2idXEiuN/U89OoFZi6IPYA
Otf8XY1elOs+0lnk4H2kSvbsJu3REc2rCXiXRwMarhBsCHhbAnp96kDlEarIJ7dl
Orb5qujeupMLdSrogAf6K7XKksXCoKkQ4f+5zw58GgOzlGERRY4lQU1llF9X2cjc
jgzQt3S/dFBh8isc3HmUTLcVyqY3Cw+2iR1ZUIWRQQV8DnPiPAX5WWoLKaB67up8
D4SyuUBACwXk4uigX1AOxmY0sLk9cl2oUd0MAO97JxvQDdyTCd1LISdgDx9g1qU=
=J1QV
-----END PGP SIGNATURE-----

--=-rNdbH6yD6IO9aKaVCIGi--

