From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: [PATCH -mm 1/1] misc,acpi,backlight: Compal Laptop Extras - remove
 unnecessary attribute
Date: Thu, 12 Jun 2008 22:08:59 +0200
Message-ID: <20080612220859.2540a64a@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:19540 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbYFLUJI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 16:09:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2590516fgg.17
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2008 13:09:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>

Compal-laptop: remove unnecessary attribute (lcd_level)

Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
---
diff -Nuar a/drivers/misc/compal-laptop.c b/drivers/misc/compal-laptop.c
--- a/drivers/misc/compal-laptop.c	2008-06-12 21:49:45.000000000 +0200
+++ b/drivers/misc/compal-laptop.c	2008-06-12 21:55:46.000000000 +0200
@@ -28,9 +28,6 @@
  *
  * This driver exports a few files in /sys/devices/platform/compal-laptop/:
  *
- *   lcd_level - Screen brightness: contains a single integer in the
- *   range 0..7. (rw)
- *
  *   wlan - wlan subsystem state: contains 0 or 1 (rw)
  *
  *   bluetooth - Bluetooth subsystem state: contains 0 or 1 (rw)
@@ -44,7 +41,7 @@
  * This driver might work on other laptops produced by Compal. If you
  * want to try it you can pass force=1 as argument to the module which
  * will force it to load even when the DMI data doesn't identify the
- * laptop as IFL90.
+ * laptop as FL9x.
  */
 
 #include <linux/module.h>
@@ -56,7 +53,7 @@
 #include <linux/platform_device.h>
 #include <linux/autoconf.h>
 
-#define COMPAL_DRIVER_VERSION "0.2.5"
+#define COMPAL_DRIVER_VERSION "0.2.6"
 
 #define COMPAL_LCD_LEVEL_MAX 8
 
@@ -209,34 +206,6 @@
 	return sprintf(buf, "%i\n", enabled);
 }
 
-static ssize_t show_lcd_level(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	int ret;
-
-	ret = get_lcd_level();
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%i\n", ret);
-}
-
-static ssize_t store_lcd_level(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
-{
-	int level, ret;
-
-	if (sscanf(buf, "%i", &level) != 1 ||
-		(level < 0 || level >= COMPAL_LCD_LEVEL_MAX))
-		return -EINVAL;
-
-	ret = set_lcd_level(level);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-
 static ssize_t store_wlan_state(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -267,13 +236,11 @@
 	return count;
 }
 
-static DEVICE_ATTR(lcd_level, 0644, show_lcd_level, store_lcd_level);
 static DEVICE_ATTR(bluetooth, 0644, show_bluetooth, store_bluetooth_state);
 static DEVICE_ATTR(wlan, 0644, show_wlan, store_wlan_state);
 static DEVICE_ATTR(raw, 0444, show_raw, NULL);
 
 static struct attribute *compal_attributes[] = {
-	&dev_attr_lcd_level.attr,
 	&dev_attr_bluetooth.attr,
 	&dev_attr_wlan.attr,
 	&dev_attr_raw.attr,
