From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 1/22] Version Bump
Date: Tue, 19 Dec 2006 22:18:30 +0100
Message-ID: <200612192218.30515.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50120 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933004AbWLSVZg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Dec 2006 16:25:36 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Change the version, and the maintainers.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-13 20:59:36.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 10:23:25.000000000 +0100
@@ -3,6 +3,7 @@
  *
  *
  *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
+ *  Copyright (C) 2006 Corentin Chary
  *
  *  This program is free software; you can redistribute it and/or modi=
fy
  *  it under the terms of the GNU General Public License as published =
by
@@ -26,7 +27,7 @@
  *  Pontus Fuchs   - Helper functions, cleanup
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting =
point.
- *  =C9ric Burghard  - LED display support for W1N
+ *  Eric Burghard  - LED display support for W1N
  *
  */

@@ -39,7 +40,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>

-#define ASUS_ACPI_VERSION "0.30"
+#define ASUS_ACPI_VERSION "0.31"

 #define PROC_ASUS       "asus" //the directory
 #define PROC_MLED       "mled"
@@ -71,7 +72,7 @@
 #define TLED_ON     0x04       //touchpad LED
 #define BT_ON       0x08       //internal Bluetooth

-MODULE_AUTHOR("Julien Lerouge, Karol Kozimor");
+MODULE_AUTHOR("Julien Lerouge, Karol Kozimor, Corentin Chary");
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");


--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
