From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: [PATCH -mm 3/3] misc,acpi,backlight: Compal Laptop Extras - add
 support for new laptops
Date: Wed, 16 Apr 2008 22:53:54 +0200
Message-ID: <20080416225354.528207fc@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932495AbYDPUyi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>

Compal-laptop: add support for new laptops:

FL91/IFL91
FL92/JFL92
FT00/IFT00

Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
---
diff -Nuar a/drivers/misc/compal-laptop.c b/drivers/misc/compal-laptop.c
--- a/drivers/misc/compal-laptop.c	2008-04-16 20:19:09.000000000 +0200
+++ b/drivers/misc/compal-laptop.c	2008-04-16 18:11:05.000000000 +0200
@@ -24,7 +24,7 @@
  */
 
 /*
- * comapl-laptop.c - Compal FL90/IFL90 laptop support.
+ * comapl-laptop.c - Compal laptop support.
  *
  * This driver exports a few files in /sys/devices/platform/compal-laptop/:
  *
@@ -320,6 +320,30 @@
 		},
 		.callback = dmi_check_cb
 	},
+	{
+		.ident = "FL91/IFL91",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "IFL91"),
+			DMI_MATCH(DMI_BOARD_VERSION, "IFT00"),
+		},
+		.callback = dmi_check_cb
+	},
+	{
+		.ident = "FL92/JFL92",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "JFL92"),
+			DMI_MATCH(DMI_BOARD_VERSION, "IFT00"),
+		},
+		.callback = dmi_check_cb
+	},
+	{
+		.ident = "FT00/IFT00",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "IFT00"),
+			DMI_MATCH(DMI_BOARD_VERSION, "IFT00"),
+		},
+		.callback = dmi_check_cb
+	},
 	{ }
 };
 
@@ -408,3 +432,6 @@
 
 MODULE_ALIAS("dmi:*:rnIFL90:rvrIFT00:*");
 MODULE_ALIAS("dmi:*:rnIFL90:rvrREFERENCE:*");
+MODULE_ALIAS("dmi:*:rnIFL91:rvrIFT00:*");
+MODULE_ALIAS("dmi:*:rnJFL92:rvrIFT00:*");
+MODULE_ALIAS("dmi:*:rnIFT00:rvrIFT00:*");
diff -Nuar a/drivers/misc/Kconfig b/drivers/misc/Kconfig
--- a/drivers/misc/Kconfig	2008-04-16 19:42:45.000000000 +0200
+++ b/drivers/misc/Kconfig	2008-04-16 20:17:37.000000000 +0200
@@ -226,10 +226,13 @@
 	  This is a driver for laptops built by Compal:
 
 	  Compal FL90/IFL90
+	  Compal FL91/IFL91
+	  Compal FL92/JFL92
+	  Compal FT00/IFT00
 
 	  It adds support for Bluetooth, WLAN and LCD brightness control.
 
-	  If you have an Compal FL90/IFL90 laptop, say Y or M here.
+	  If you have an Compal FL9x/IFL9x/FT00 laptop, say Y or M here.
 
 config SONY_LAPTOP
 	tristate "Sony Laptop Extras"
