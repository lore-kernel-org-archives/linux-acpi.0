From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 1/6] video sysfs support: Add dev argument for backlight_device_register.
Date: Thu, 2 Nov 2006 13:08:49 +0000 (UTC)
Message-ID: <200611042107.53145.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:53139 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752572AbWKBNI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Nov 2006 08:08:27 -0500
Received: by wx-out-0506.google.com with SMTP id s14so115371wxc
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2006 05:08:26 -0800 (PST)
Date: Sat, 4 Nov 2006 21:07:52 +0800
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>


Video sysfs support: add dev argument for backlight_device_register.

signed-off-by   Luming.yu@gmail.com
---

[patch 1/6] video sysfs support: add dev argument for backlight_device_register.
 drivers/video/backlight/backlight.c |    7 +++++--
 include/linux/backlight.h           |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..1d97cdf 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -190,8 +190,10 @@ static int fb_notifier_callback(struct n
  * Creates and registers new backlight class_device. Returns either an
  * ERR_PTR() or a pointer to the newly allocated device.
  */
-struct backlight_device *backlight_device_register(const char *name, void *devdata,
-						   struct backlight_properties *bp)
+struct backlight_device *backlight_device_register(const char *name,
+	struct device *dev,
+	void *devdata,
+	struct backlight_properties *bp)
 {
 	int i, rc;
 	struct backlight_device *new_bd;
@@ -206,6 +208,7 @@ struct backlight_device *backlight_devic
 	new_bd->props = bp;
 	memset(&new_bd->class_dev, 0, sizeof(new_bd->class_dev));
 	new_bd->class_dev.class = &backlight_class;
+	new_bd->class_dev.dev = dev;
 	strlcpy(new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
 	class_set_devdata(&new_bd->class_dev, devdata);
 
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 75e91f5..a5cf1be 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -54,7 +54,7 @@ struct backlight_device {
 };
 
 extern struct backlight_device *backlight_device_register(const char *name,
-	void *devdata, struct backlight_properties *bp);
+	struct device *dev,void *devdata,struct backlight_properties *bp);
 extern void backlight_device_unregister(struct backlight_device *bd);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, class_dev)
