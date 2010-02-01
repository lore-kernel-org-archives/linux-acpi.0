From: "Matthew W. S. Bell" <matthew@bells23.org.uk>
Subject: [PATCH 2/2] Whitespace cleanups in ACPI modules.
Date: Mon, 01 Feb 2010 21:16:29 +0000
Message-ID: <1265058989.3824.11.camel@ibis.bells>
Reply-To: matthew@bells23.org.uk, linux-acpi@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+ZnqFMLiA/qXzD92pEle"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from garuda.bells23.org.uk ([85.13.250.28]:59523 "EHLO
	garuda.bells23.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab0BAVyV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 16:54:21 -0500
Received: from localhost ([127.0.0.1] helo=garuda.bells23.org.uk)
	by garuda.bells23.org.uk with esmtp (Exim 4.69)
	(envelope-from <matthew@bells23.org.uk>)
	id 1Nc3fV-0003UX-Jw
	for linux-acpi@vger.kernel.org; Mon, 01 Feb 2010 21:18:49 +0000
Received: from [80.65.240.47] (port=56941 helo=[192.168.1.230])
	by garuda.bells23.org.uk with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <matthew@bells23.org.uk>)
	id 1Nc3fU-0003UT-4s
	for linux-acpi@vger.kernel.org; Mon, 01 Feb 2010 21:18:49 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-+ZnqFMLiA/qXzD92pEle
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---
 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/acpi/pci_slot.c        |    4 ++--
 drivers/acpi/processor_core.c  |    2 +-
 drivers/acpi/video.c           |   30 +++++++++++++++---------------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c
b/drivers/acpi/acpi_memhotplug.c
index 1477243..7fbaa50 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -39,7 +39,7 @@
 #define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
=20
 #undef PREFIX
-#define 	PREFIX		"ACPI:memory_hp:"
+#define		PREFIX		"ACPI:memory_hp:"
=20
 ACPI_MODULE_NAME("acpi_memhotplug");
 MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 91de70f..2bfba7b 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -7,7 +7,7 @@
  *  review and fixes.
  *
  *  Copyright (C) 2007-2008 Hewlett-Packard Development Company, L.P.
- *  	Alex Chiang <achiang@hp.com>
+ *	Alex Chiang <achiang@hp.com>
  *
  *  This program is free software; you can redistribute it and/or
modify it
  *  under the terms and conditions of the GNU General Public License,
@@ -36,7 +36,7 @@
 static int debug;
 static int check_sta_before_sun;
=20
-#define DRIVER_VERSION 	"0.1"
+#define DRIVER_VERSION	"0.1"
 #define DRIVER_AUTHOR	"Alex Chiang <achiang@hp.com>"
 #define DRIVER_DESC	"ACPI PCI Slot Detection Driver"
 MODULE_AUTHOR(DRIVER_AUTHOR);
diff --git a/drivers/acpi/processor_core.c
b/drivers/acpi/processor_core.c
index ec742a4..b657307 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -922,7 +922,7 @@ free:
=20
 #ifdef CONFIG_ACPI_HOTPLUG_CPU

/*********************************************************************
*******
- * 	Acpi processor hotplug support 				       	    *
+ *	Acpi processor hotplug support					    *
=20
**********************************************************************
******/
=20
 static int is_processor_present(acpi_handle handle)
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 045e634..dd7845a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -730,7 +730,7 @@ acpi_video_bus_POST_options(struct acpi_video_bus
*video,
=20
 /*
  *  Arg:
- *  	video		: video bus device pointer
+ *	video		: video bus device pointer
  *	bios_flag	:=20
  *		0.	The system BIOS should NOT automatically switch(toggle)
  *			the active display output.
@@ -743,10 +743,10 @@ acpi_video_bus_POST_options(struct
acpi_video_bus *video,
  *	lcd_flag	:
  *		0.	The system BIOS should automatically control the brightness
level
  *			of the LCD when the power changes from AC to DC
- *		1. 	The system BIOS should NOT automatically control the
brightness=20
+ *		1.	The system BIOS should NOT automatically control the
brightness=20
  *			level of the LCD when the power changes from AC to DC.
  * Return Value:
- * 		-1	wrong arg.
+ *		-1	wrong arg.
  */
=20
 static int
@@ -781,7 +781,7 @@ acpi_video_cmp_level(const void *a, const void *b)
=20
 /*
  *  Arg:=09
- *  	device	: video output device (LCD, CRT, ..)
+ *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
  *	Maximum brightness level
@@ -944,7 +944,7 @@ out:
  *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
- *  	None
+ *	None
  *
  *  Find out all required AML methods defined under the output
  *  device.
@@ -1054,10 +1054,10 @@ static void acpi_video_device_find_cap(struct
acpi_video_device *device)
=20
 /*
  *  Arg:=09
- *  	device	: video output device (VGA)
+ *	device	: video output device (VGA)
  *
  *  Return Value:
- *  	None
+ *	None
  *
  *  Find out all required AML methods defined under the video bus
device.
  */
@@ -1805,10 +1805,10 @@ acpi_video_bus_get_one_device(struct
acpi_device *device,
=20
 /*
  *  Arg:
- *  	video	: video bus device=20
+ *	video	: video bus device=20
  *
  *  Return:
- *  	none
+ *	none
  * =20
  *  Enumerate the video device list of the video bus,=20
  *  bind the ids with the corresponding video devices
@@ -1829,12 +1829,12 @@ static void acpi_video_device_rebind(struct
acpi_video_bus *video)
=20
 /*
  *  Arg:
- *  	video	: video bus device=20
- *  	device	: video output device under the video=20
- *  		bus
+ *	video	: video bus device=20
+ *	device	: video output device under the video=20
+ *		bus
  *
  *  Return:
- *  	none
+ *	none
  * =20
  *  Bind the ids with the corresponding video devices
  *  under the video bus.
@@ -1858,10 +1858,10 @@ acpi_video_device_bind(struct acpi_video_bus
*video,
=20
 /*
  *  Arg:
- *  	video	: video bus device=20
+ *	video	: video bus device=20
  *
  *  Return:
- *  	< 0	: error
+ *	< 0	: error
  * =20
  *  Call _DOD to enumerate all devices attached to display adapter
  *
--=20
1.6.5


--=-+ZnqFMLiA/qXzD92pEle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJLZ0SqAAoJEDyn+gO8EoIoNp0H/2+JdMC+Y3pATP5O1H3bzpmu
HtMCmF19566TyKV3iQFOzH0HyVib21wIjDKKg9fbd+mG98ht99e1ndPNpg6IX9LB
YaYlxFQVHTj+3MkP6gLZWulrKKqbHhabhp/WQSh9FgVzEPwpe8bQOYjALRGU0pP4
8wOWUR6zbPYIwCE0d7NOqjPqsxVuzWBwWJNb6zY6mGp7NEVWkjikN//BXPuyV1s9
oWNIFalvhXTKvNM54IHb5ZYYuQcjH2/kYZYuYYFiQZcZQuHsYu8+HuBblVGIj9zm
KiQE3Fz0bGdS7BY0IVBaML0RFg0Q1ivKsAR0ADHHc3L98B0BtYk69nO0zNGKlIE=
=QU3g
-----END PGP SIGNATURE-----

--=-+ZnqFMLiA/qXzD92pEle--

