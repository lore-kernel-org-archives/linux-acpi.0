From: Len Brown <len.brown@intel.com>
Subject: [PATCH 014/105] asus-laptop: clean write_status
Date: Sun, 29 Apr 2007 00:50:14 -0400
Message-ID: <11778223173663-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbXD2Ev6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:58 -0400
In-Reply-To: <11778223161614-git-send-email-len.brown@intel.com>
Message-Id: <935ffeeca84fe5d48d0cc9f35c58db42b384229f.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Clean the write_status function, and implement special case with
a switch inside write_status. It also make sure bt and wl status
are right when booting with the hardware switch off.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   48 ++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index dcab778..3ba5798 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -272,19 +272,25 @@ static int read_status(int mask)
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
@@ -294,13 +300,13 @@ static void write_status(acpi_handle handle, int out, int mask, int invert)
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
@@ -325,7 +331,7 @@ static int set_lcd_state(int value)
 			printk(ASUS_WARNING "Error switching LCD\n");
 	}
 
-	write_status(NULL, lcd, LCD_ON, 0);
+	write_status(NULL, lcd, LCD_ON);
 	return 0;
 }
 
@@ -458,7 +464,7 @@ static int parse_arg(const char *buf, unsigned long count, int *val)
 }
 
 static ssize_t store_status(const char *buf, size_t count,
-			    acpi_handle handle, int mask, int invert)
+			    acpi_handle handle, int mask)
 {
 	int rv, value;
 	int out = 0;
@@ -467,7 +473,7 @@ static ssize_t store_status(const char *buf, size_t count,
 	if (rv > 0)
 		out = value ? 1 : 0;
 
-	write_status(handle, out, mask, invert);
+	write_status(handle, out, mask);
 
 	return rv;
 }
@@ -508,7 +514,7 @@ static ssize_t show_wlan(struct device *dev,
 static ssize_t store_wlan(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	return store_status(buf, count, wl_switch_handle, WL_ON, 0);
+	return store_status(buf, count, wl_switch_handle, WL_ON);
 }
 
 /*
@@ -524,7 +530,7 @@ static ssize_t store_bluetooth(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	return store_status(buf, count, bt_switch_handle, BT_ON, 0);
+	return store_status(buf, count, bt_switch_handle, BT_ON);
 }
 
 /*
@@ -652,10 +658,10 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
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
 
@@ -928,11 +934,15 @@ static int asus_hotk_add(struct acpi_device *device)
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
-- 
1.5.2.rc0.34.gda94
