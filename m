From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 3/5] asus-laptop add GLED
Date: Sun, 11 Mar 2007 10:26:48 +0100
Message-ID: <200703111026.48681.corentincj@iksaif.net>
References: <200703111023.04437.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:48162 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbXCKJ0u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 05:26:50 -0400
In-Reply-To: <200703111023.04437.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

Add support for "gaming" led.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/misc/asus-laptop.c	2007-03-10 16:27:02.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-03-10 16:29:53.000000000 +0100
@@ -81,7 +81,8 @@
 #define TLED_ON     0x08	//touchpad LED
 #define RLED_ON     0x10	//Record LED
 #define PLED_ON     0x20	//Phone LED
-#define LCD_ON      0x40	//LCD backlight
+#define GLED_ON     0x40	//Gaming LED
+#define LCD_ON      0x80	//LCD backlight
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -103,6 +104,7 @@
 ASUS_HANDLE(tled_set, ASUS_HOTK_PREFIX "TLED");
 ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED");	/* W1JC */
 ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED");	/* A7J */
+ASUS_HANDLE(gled_set, ASUS_HOTK_PREFIX "GLED");	/* G1, G2 (probably) */
 
 /* LEDD */
 ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
@@ -221,6 +223,7 @@
 ASUS_LED(tled, "touchpad");
 ASUS_LED(rled, "record");
 ASUS_LED(pled, "phone");
+ASUS_LED(gled, "gaming");
 
 /*
  * This function evaluates an ACPI method, given an int as parameter, the
@@ -280,6 +283,9 @@
 	case MLED_ON:
 		out = !out & 0x1;
 		break;
+	case GLED_ON:
+		out = (out & 0x1) + 1;
+		break;
 	default:
 		out &= 0x1;
 		break;
@@ -307,6 +313,7 @@
 ASUS_LED_HANDLER(pled, PLED_ON);
 ASUS_LED_HANDLER(rled, RLED_ON);
 ASUS_LED_HANDLER(tled, TLED_ON);
+ASUS_LED_HANDLER(gled, GLED_ON);
 
 static int get_lcd_state(void)
 {
@@ -835,6 +842,7 @@
 	ASUS_HANDLE_INIT(tled_set);
 	ASUS_HANDLE_INIT(rled_set);
 	ASUS_HANDLE_INIT(pled_set);
+	ASUS_HANDLE_INIT(gled_set);
 
 	ASUS_HANDLE_INIT(ledd_set);
 
@@ -1001,6 +1009,7 @@
 	ASUS_LED_UNREGISTER(tled);
 	ASUS_LED_UNREGISTER(pled);
 	ASUS_LED_UNREGISTER(rled);
+	ASUS_LED_UNREGISTER(gled);
 
 	destroy_workqueue(led_workqueue);
 }
@@ -1072,6 +1081,10 @@
 	if (rv)
 		return rv;
 
+	rv = ASUS_LED_REGISTER(gled, dev);
+	if (rv)
+		return rv;
+
 	led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!led_workqueue)
 		return -ENOMEM;
