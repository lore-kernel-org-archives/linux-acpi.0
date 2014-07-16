From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Fix backlight taking 2 steps on a brightness up/down keypress
Date: Wed, 16 Jul 2014 13:25:08 +0200
Message-ID: <1405509908-12620-2-git-send-email-hdegoede@redhat.com>
References: <1405509908-12620-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13573 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445AbaGPLZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 07:25:26 -0400
In-Reply-To: <1405509908-12620-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

From: Linus Torvalds <torvalds@linux-foundation.org>

In various scenarious userspace will respond to brightness up/down keypresses
by increasing/decreasing the backlight brightness itself. If the kernel then
also changes the brightness this results in the brightness having changed 2
steps for a single keypress which is undesirable. See e.g. :

https://bugs.launchpad.net/gnome-settings-daemon/+bug/527157
http://askubuntu.com/questions/173921/why-does-my-thinkpad-brightness-control-skip-steps

This commit delays responding to brightness up/down keypresses by 100 ms and
if userspace in that time responds by changing the backlight itself, cancels
the kernels own handling of these keypresses, fixing the 2 steps issue.

[hdegoede@redhat.com: Move the delayed_work struct into struct
 acpi_video_device instead of having it as a global]
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1a450c9..3a4a3ef 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -68,8 +68,8 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
-static bool brightness_switch_enabled = 1;
-module_param(brightness_switch_enabled, bool, 0644);
+static int brightness_switch_enabled = -1;
+module_param(brightness_switch_enabled, int, 0644);
 
 /*
  * By default, we don't allow duplicate ACPI video bus devices
@@ -204,6 +204,8 @@ struct acpi_video_device {
 	struct acpi_video_device_flags flags;
 	struct acpi_video_device_cap cap;
 	struct list_head entry;
+	struct delayed_work switch_brightness_work;
+	int switch_brightness_event;
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
@@ -270,11 +272,20 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
 	return 0;
 }
 
+static void acpi_video_set_brighness_delayed(struct work_struct *work)
+{
+	struct acpi_video_device *vd = container_of(to_delayed_work(work),
+			    struct acpi_video_device, switch_brightness_work);
+
+	acpi_video_switch_brightness(vd, vd->switch_brightness_event);
+}
+
 static int acpi_video_set_brightness(struct backlight_device *bd)
 {
 	int request_level = bd->props.brightness + 2;
 	struct acpi_video_device *vd = bl_get_data(bd);
 
+	cancel_delayed_work(&vd->switch_brightness_work);
 	return acpi_video_device_lcd_set_level(vd,
 				vd->brightness->levels[request_level]);
 }
@@ -1252,6 +1263,8 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 	data->device_id = device_id;
 	data->video = video;
 	data->dev = device;
+	INIT_DELAYED_WORK(&data->switch_brightness_work,
+			  acpi_video_set_brighness_delayed);
 
 	attribute = acpi_video_get_device_attr(video, device_id);
 
@@ -1673,6 +1686,21 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 	return;
 }
 
+static void brightness_switch_event(struct acpi_video_device *video_device,
+				    u32 event)
+{
+	if (!brightness_switch_enabled)
+		return;
+
+	if (brightness_switch_enabled > 0) {
+		acpi_video_switch_brightness(video_device, event);
+		return;
+	}
+
+	video_device->switch_brightness_event = event;
+	schedule_delayed_work(&video_device->switch_brightness_work, HZ / 10);
+}
+
 static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_device *video_device = data;
@@ -1690,28 +1718,23 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode = KEY_BRIGHTNESS_CYCLE;
 		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode = KEY_BRIGHTNESSUP;
 		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode = KEY_BRIGHTNESSDOWN;
 		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode = KEY_BRIGHTNESS_ZERO;
 		break;
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode = KEY_DISPLAY_OFF;
 		break;
 	default:
-- 
2.0.0

