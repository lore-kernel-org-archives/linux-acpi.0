From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/84] compal-laptop: remove unnecessary lcd_level attribute
Date: Sat, 28 Jun 2008 01:43:15 -0400
Message-ID: <46c636862ee7e2f45e3369393f7c00761727e674.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50450 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbYF1Fo6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:58 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K35001LLRYH8D4I@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:46 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Len Brown <len.brown@intel.com>

From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>

Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/compal-laptop.c |   37 ++-----------------------------------
 1 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/compal-laptop.c b/drivers/misc/compal-laptop.c
index b764c55..971e59a 100644
--- a/drivers/misc/compal-laptop.c
+++ b/drivers/misc/compal-laptop.c
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
 
@@ -209,34 +206,6 @@ static ssize_t show_bluetooth(struct device *dev,
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
@@ -267,13 +236,11 @@ static ssize_t store_bluetooth_state(struct device *dev,
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
-- 
1.5.6.1.89.gd544

