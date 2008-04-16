From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: [PATCH -mm 2/3] misc,acpi,backlight: Compal Laptop Extras - use
 bitmask, not hex
Date: Wed, 16 Apr 2008 22:53:04 +0200
Message-ID: <20080416225304.3dc5b9d2@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932297AbYDPUxe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>

Clean up code. Use bitmask for operations.

Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
---
diff -Nuar a/drivers/misc/compal-laptop.c b/drivers/misc/compal-laptop.c
--- a/drivers/misc/compal-laptop.c	2008-04-16 19:42:45.000000000 +0200
+++ b/drivers/misc/compal-laptop.c	2008-04-16 20:19:09.000000000 +0200
@@ -1,7 +1,7 @@
 /*-*-linux-c-*-*/
 
 /*
-  Copyright (C) 2008 Cezary Jackiewicz <cezary.Jackiewicz (at) gmail.com>
+  Copyright (C) 2008 Cezary Jackiewicz <cezary.jackiewicz (at) gmail.com>
 
   based on MSI driver
 
@@ -56,13 +56,17 @@
 #include <linux/platform_device.h>
 #include <linux/autoconf.h>
 
-#define COMPAL_DRIVER_VERSION "0.2.2"
+#define COMPAL_DRIVER_VERSION "0.2.5"
 
 #define COMPAL_LCD_LEVEL_MAX 8
 
 #define COMPAL_EC_COMMAND_WIRELESS 0xBB
 #define COMPAL_EC_COMMAND_LCD_LEVEL 0xB9
 
+#define KILLSWITCH_MASK	0x10
+#define WLAN_MASK	0x01
+#define BT_MASK		0x02
+
 static int force;
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Force driver load, ignore DMI data");
@@ -94,13 +98,13 @@
 
 	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
 
-	if ((result & 0x10) == 0)
+	if ((result & KILLSWITCH_MASK) == 0)
 		return -EINVAL;
 	else {
 		if (state)
-			value = (u8) (result | 0x01);
+			value = (u8) (result | WLAN_MASK);
 		else
-			value = (u8) (result & 0xFE);
+			value = (u8) (result & ~WLAN_MASK);
 		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
 	}
 
@@ -113,13 +117,13 @@
 
 	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
 
-	if ((result & 0x10) == 0)
+	if ((result & KILLSWITCH_MASK) == 0)
 		return -EINVAL;
 	else {
 		if (state)
-			value = (u8) (result | 0x02);
+			value = (u8) (result | BT_MASK);
 		else
-			value = (u8) (result & 0xFD);
+			value = (u8) (result & ~BT_MASK);
 		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
 	}
 
@@ -133,17 +137,17 @@
 	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
 
 	if (wlan) {
-		if ((result & 0x10) == 0)
+		if ((result & KILLSWITCH_MASK) == 0)
 			*wlan = 0;
 		else
-			*wlan = result & 0x01;
+			*wlan = result & WLAN_MASK;
 	}
 
 	if (bluetooth) {
-		if ((result & 0x10) == 0)
+		if ((result & KILLSWITCH_MASK) == 0)
 			*bluetooth = 0;
 		else
-			*bluetooth = (result >> 1) & 0x01;
+			*bluetooth = (result & BT_MASK) >> 1;
 	}
 
 	return 0;
