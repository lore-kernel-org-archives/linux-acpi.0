From: Len Brown <len.brown@intel.com>
Subject: [PATCH 015/105] asus-laptop: add GLED
Date: Sun, 29 Apr 2007 00:50:15 -0400
Message-ID: <11778223183783-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599AbXD2Ev7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:59 -0400
In-Reply-To: <11778223173663-git-send-email-len.brown@intel.com>
Message-Id: <fdd8d08084663242b42e27f7d71739f3f9009286.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Add support for "gaming" led.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 3ba5798..475709b 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -81,7 +81,8 @@
 #define TLED_ON     0x08	//touchpad LED
 #define RLED_ON     0x10	//Record LED
 #define PLED_ON     0x20	//Phone LED
-#define LCD_ON      0x40	//LCD backlight
+#define GLED_ON     0x40	//Gaming LED
+#define LCD_ON      0x80	//LCD backlight
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -103,6 +104,7 @@ ASUS_HANDLE(mled_set, ASUS_HOTK_PREFIX "MLED");
 ASUS_HANDLE(tled_set, ASUS_HOTK_PREFIX "TLED");
 ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED");	/* W1JC */
 ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED");	/* A7J */
+ASUS_HANDLE(gled_set, ASUS_HOTK_PREFIX "GLED");	/* G1, G2 (probably) */
 
 /* LEDD */
 ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
@@ -221,6 +223,7 @@ ASUS_LED(mled, "mail");
 ASUS_LED(tled, "touchpad");
 ASUS_LED(rled, "record");
 ASUS_LED(pled, "phone");
+ASUS_LED(gled, "gaming");
 
 /*
  * This function evaluates an ACPI method, given an int as parameter, the
@@ -280,6 +283,9 @@ static void write_status(acpi_handle handle, int out, int mask)
 	case MLED_ON:
 		out = !out & 0x1;
 		break;
+	case GLED_ON:
+		out = (out & 0x1) + 1;
+		break;
 	default:
 		out &= 0x1;
 		break;
@@ -307,6 +313,7 @@ ASUS_LED_HANDLER(mled, MLED_ON);
 ASUS_LED_HANDLER(pled, PLED_ON);
 ASUS_LED_HANDLER(rled, RLED_ON);
 ASUS_LED_HANDLER(tled, TLED_ON);
+ASUS_LED_HANDLER(gled, GLED_ON);
 
 static int get_lcd_state(void)
 {
@@ -835,6 +842,7 @@ static int asus_hotk_get_info(void)
 	ASUS_HANDLE_INIT(tled_set);
 	ASUS_HANDLE_INIT(rled_set);
 	ASUS_HANDLE_INIT(pled_set);
+	ASUS_HANDLE_INIT(gled_set);
 
 	ASUS_HANDLE_INIT(ledd_set);
 
@@ -1001,6 +1009,7 @@ static void asus_led_exit(void)
 	ASUS_LED_UNREGISTER(tled);
 	ASUS_LED_UNREGISTER(pled);
 	ASUS_LED_UNREGISTER(rled);
+	ASUS_LED_UNREGISTER(gled);
 
 	destroy_workqueue(led_workqueue);
 }
@@ -1072,6 +1081,10 @@ static int asus_led_init(struct device *dev)
 	if (rv)
 		return rv;
 
+	rv = ASUS_LED_REGISTER(gled, dev);
+	if (rv)
+		return rv;
+
 	led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!led_workqueue)
 		return -ENOMEM;
-- 
1.5.2.rc0.34.gda94
