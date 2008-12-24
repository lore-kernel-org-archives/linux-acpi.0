From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] video: mark "actual_brightness" deprecated
Date: Wed, 24 Dec 2008 11:07:41 +0800
Message-ID: <1230088061.562.220.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2180 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYLXDJe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Dec 2008 22:09:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rpurdie@rpsys.net
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

/sys/class/backlight/.../brightness returns a cached value,
which confuses a lot of users.

Make the "brightness" reflect the actual backlight levels,
and mark /sys/class/backlight/.../brightness as depreacated
in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/video/backlight/Kconfig     |   17 +++++++++++++++++
 drivers/video/backlight/backlight.c |   11 ++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/video/backlight/Kconfig
===================================================================
--- linux-2.6.orig/drivers/video/backlight/Kconfig
+++ linux-2.6/drivers/video/backlight/Kconfig
@@ -98,6 +98,23 @@ config BACKLIGHT_CLASS_DEVICE
 	  To have support for your specific LCD panel you will have to
 	  select the proper drivers which depend on this option.
 
+config BACKLIGHT_CLASS_DEVICE_LEGACY_INTERFACE
+	bool "Deprecated lowlevel Backlight control legacy sysfs I/F"
+	depends on BACKLIGHT_CLASS_DEVICE
+	default y
+	help
+	  "brightness" file used to return a cached brightness level.
+	  And users need to poke the "actual_brightness" to get the
+	  correct current backlight level.
+	  Now the "brightness" file always reflects the actual
+	  brightness and "actual_brightness" is superfluous.
+
+	  Some applications including X still use this file to get the current
+	  backlight level, thus we can not remove it immediately.
+
+	  Say N here if you're sure no application depends on the
+	  "actual_brightness" file.
+
 config BACKLIGHT_ATMEL_LCDC
 	bool "Atmel LCDC Contrast-as-Backlight control"
 	depends on BACKLIGHT_CLASS_DEVICE && FB_ATMEL
Index: linux-2.6/drivers/video/backlight/backlight.c
===================================================================
--- linux-2.6.orig/drivers/video/backlight/backlight.c
+++ linux-2.6/drivers/video/backlight/backlight.c
@@ -108,9 +108,14 @@ static ssize_t backlight_store_power(str
 static ssize_t backlight_show_brightness(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
+	int rc = -ENXIO;
 	struct backlight_device *bd = to_backlight_device(dev);
 
-	return sprintf(buf, "%d\n", bd->props.brightness);
+	mutex_lock(&bd->ops_lock);
+	if (bd->ops && bd->ops->get_brightness)
+		rc = sprintf(buf, "%d\n", bd->ops->get_brightness(bd));
+	mutex_unlock(&bd->ops_lock);
+	return rc;
 }
 
 static ssize_t backlight_store_brightness(struct device *dev,
@@ -152,6 +157,7 @@ static ssize_t backlight_show_max_bright
 	return sprintf(buf, "%d\n", bd->props.max_brightness);
 }
 
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE_LEGACY_INTERFACE
 static ssize_t backlight_show_actual_brightness(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -165,6 +171,7 @@ static ssize_t backlight_show_actual_bri
 
 	return rc;
 }
+#endif
 
 static struct class *backlight_class;
 
@@ -178,8 +185,10 @@ static struct device_attribute bl_device
 	__ATTR(bl_power, 0644, backlight_show_power, backlight_store_power),
 	__ATTR(brightness, 0644, backlight_show_brightness,
 		     backlight_store_brightness),
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE_LEGACY_INTERFACE
 	__ATTR(actual_brightness, 0444, backlight_show_actual_brightness,
 		     NULL),
+#endif
 	__ATTR(max_brightness, 0444, backlight_show_max_brightness, NULL),
 	__ATTR_NULL,
 };


