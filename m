From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2] dell-smo8800: Add more ACPI ids and change description of driver
Date: Fri,  5 Dec 2014 13:05:46 +0100
Message-ID: <1417781146-6261-1-git-send-email-pali.rohar@gmail.com>
References: <20141203134323.GI75099@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:45123 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbaLEMGO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Dec 2014 07:06:14 -0500
In-Reply-To: <20141203134323.GI75099@vmdeb7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch adds other ACPI ids from Windows inf driver which should be =
handled
by dell-smo8800 driver. ACPI devices have same structure -- one IRQ num=
ber.

This patch also updates description of module.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/platform/x86/Kconfig        |    4 ++--
 drivers/platform/x86/dell-smo8800.c |   10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
index 3bbcbf1..4614f35 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -128,10 +128,10 @@ config DELL_WMI_AIO
 	  be called dell-wmi-aio.
=20
 config DELL_SMO8800
-	tristate "Dell Latitude freefall driver (ACPI SMO8800/SMO8810)"
+	tristate "Dell Latitude freefall driver (ACPI SMO88XX)"
 	depends on ACPI
 	---help---
-	  Say Y here if you want to support SMO8800/SMO8810 freefall device
+	  Say Y here if you want to support SMO88XX freefall devices
 	  on Dell Latitude laptops.
=20
 	  To compile this driver as a module, choose M here: the module will
diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86=
/dell-smo8800.c
index a653716..0aec4fd 100644
--- a/drivers/platform/x86/dell-smo8800.c
+++ b/drivers/platform/x86/dell-smo8800.c
@@ -1,5 +1,5 @@
 /*
- *  dell-smo8800.c - Dell Latitude ACPI SMO8800/SMO8810 freefall senso=
r driver
+ *  dell-smo8800.c - Dell Latitude ACPI SMO88XX freefall sensor driver
  *
  *  Copyright (C) 2012 Sonal Santan <sonal.santan@gmail.com>
  *  Copyright (C) 2014 Pali Roh=C3=A1r <pali.rohar@gmail.com>
@@ -209,7 +209,13 @@ static int smo8800_remove(struct acpi_device *devi=
ce)
=20
 static const struct acpi_device_id smo8800_ids[] =3D {
 	{ "SMO8800", 0 },
+	{ "SMO8801", 0 },
 	{ "SMO8810", 0 },
+	{ "SMO8811", 0 },
+	{ "SMO8820", 0 },
+	{ "SMO8821", 0 },
+	{ "SMO8830", 0 },
+	{ "SMO8831", 0 },
 	{ "", 0 },
 };
=20
@@ -228,6 +234,6 @@ static struct acpi_driver smo8800_driver =3D {
=20
 module_acpi_driver(smo8800_driver);
=20
-MODULE_DESCRIPTION("Dell Latitude freefall driver (ACPI SMO8800/SMO881=
0)");
+MODULE_DESCRIPTION("Dell Latitude freefall driver (ACPI SMO88XX)");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sonal Santan, Pali Roh=C3=A1r");
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
