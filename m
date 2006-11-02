From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 1/6] video sysfs support: Add dev argument for backlight_device_register.
Date: Thu, 2 Nov 2006 13:09:20 +0000 (UTC)
Message-ID: <200611042107.53145.luming.yu__1060.61121118746$1162472960$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752572AbWKBNI2@vger.kernel.org>
Date: Sat, 4 Nov 2006 21:07:52 +0800
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>
List-Id: linux-acpi@vger.kernel.org


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
