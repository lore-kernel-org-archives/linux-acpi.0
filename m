From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 2/5] asus-laptop clean write_status
Date: Sun, 11 Mar 2007 10:26:12 +0100
Message-ID: <200703111026.12665.corentincj@iksaif.net>
References: <200703111023.04437.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:48097 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbXCKJ0O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 05:26:14 -0400
In-Reply-To: <200703111023.04437.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

Clean the write_status function, and implement special case with
a switch inside write_status. It also make sure bt and wl status
are right when booting with the hardware switch off.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |   48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

--- a/drivers/misc/asus-laptop.c	2007-03-10 16:26:02.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-03-10 16:25:08.000000000 +0100
@@ -272,19 +272,25 @@
 	return (hotk->status & mask) ? 1 : 0;
 }
 
-static void write_status(acpi_handle handle, int out, int mask, int invert)
+static void write_status(acpi_handle handle, int out, int mask)
 {
 	hotk->status = (out) ? (hotk->status | mask) : (hotk->status & ~mask);
 
-	if (invert)		/* invert target value */
+	switch (mask) {
+	case MLED_ON:
 		out = !out & 0x1;
+		break;
+	default:
+		out &= 0x1;
+		break;
+	}
 
 	if (handle && !write_acpi_int(handle, NULL, out, NULL))
-		printk(ASUS_WARNING " write failed\n");
+		printk(ASUS_WARNING " write failed %x\n", mask);
 }
 
 /* /sys/class/led handlers */
-#define ASUS_LED_HANDLER(object, mask, invert)				\
+#define ASUS_LED_HANDLER(object, mask)					\
 	static void object##_led_set(struct led_classdev *led_cdev,	\
 				     enum led_brightness value)		\
 	{								\
@@ -294,13 +300,13 @@
 	static void object##_led_update(struct work_struct *ignored)	\
 	{								\
 		int value = object##_led_wk;				\
-		write_status(object##_set_handle, value, (mask), (invert)); \
+		write_status(object##_set_handle, value, (mask));	\
 	}
 
-ASUS_LED_HANDLER(mled, MLED_ON, 1);
-ASUS_LED_HANDLER(pled, PLED_ON, 0);
-ASUS_LED_HANDLER(rled, RLED_ON, 0);
-ASUS_LED_HANDLER(tled, TLED_ON, 0);
+ASUS_LED_HANDLER(mled, MLED_ON);
+ASUS_LED_HANDLER(pled, PLED_ON);
+ASUS_LED_HANDLER(rled, RLED_ON);
+ASUS_LED_HANDLER(tled, TLED_ON);
 
 static int get_lcd_state(void)
 {
@@ -325,7 +331,7 @@
 			printk(ASUS_WARNING "Error switching LCD\n");
 	}
 
-	write_status(NULL, lcd, LCD_ON, 0);
+	write_status(NULL, lcd, LCD_ON);
 	return 0;
 }
 
@@ -458,7 +464,7 @@
 }
 
 static ssize_t store_status(const char *buf, size_t count,
-			    acpi_handle handle, int mask, int invert)
+			    acpi_handle handle, int mask)
 {
 	int rv, value;
 	int out = 0;
@@ -467,7 +473,7 @@
 	if (rv > 0)
 		out = value ? 1 : 0;
 
-	write_status(handle, out, mask, invert);
+	write_status(handle, out, mask);
 
 	return rv;
 }
@@ -508,7 +514,7 @@
 static ssize_t store_wlan(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	return store_status(buf, count, wl_switch_handle, WL_ON, 0);
+	return store_status(buf, count, wl_switch_handle, WL_ON);
 }
 
 /*
@@ -524,7 +530,7 @@
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	return store_status(buf, count, bt_switch_handle, BT_ON, 0);
+	return store_status(buf, count, bt_switch_handle, BT_ON);
 }
 
 /*
@@ -652,10 +658,10 @@
 	 * switched
 	 */
 	if (event == ATKD_LCD_ON) {
-		write_status(NULL, 1, LCD_ON, 0);
+		write_status(NULL, 1, LCD_ON);
 		lcd_blank(FB_BLANK_UNBLANK);
 	} else if (event == ATKD_LCD_OFF) {
-		write_status(NULL, 0, LCD_ON, 0);
+		write_status(NULL, 0, LCD_ON);
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
 
@@ -928,11 +934,15 @@
 	asus_hotk_found = 1;
 
 	/* WLED and BLED are on by default */
-	write_status(bt_switch_handle, 1, BT_ON, 0);
-	write_status(wl_switch_handle, 1, WL_ON, 0);
+	write_status(bt_switch_handle, 1, BT_ON);
+	write_status(wl_switch_handle, 1, WL_ON);
+
+	/* If the h/w switch is off, we need to check the real status */
+	write_status(NULL, read_status(BT_ON), BT_ON);
+	write_status(NULL, read_status(WL_ON), WL_ON);
 
 	/* LCD Backlight is on by default */
-	write_status(NULL, 1, LCD_ON, 0);
+	write_status(NULL, 1, LCD_ON);
 
 	/* LED display is off by default */
 	hotk->ledd_status = 0xFFF;
