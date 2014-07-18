From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] acpi-video: Fix backlight taking 2 steps on a brightness up/down keypress
Date: Fri, 18 Jul 2014 14:32:51 +0200
Message-ID: <1405686771-15483-2-git-send-email-hdegoede@redhat.com>
References: <1405686771-15483-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3467 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761556AbaGRMdI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2014 08:33:08 -0400
In-Reply-To: <1405686771-15483-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

=46rom: Linus Torvalds <torvalds@linux-foundation.org>

In various scenarious userspace will respond to brightness up/down keyp=
resses
by increasing/decreasing the backlight brightness itself. If the kernel=
 then
also changes the brightness this results in the brightness having chang=
ed 2
steps for a single keypress which is undesirable. See e.g. :

https://bugs.launchpad.net/gnome-settings-daemon/+bug/527157
http://askubuntu.com/questions/173921/why-does-my-thinkpad-brightness-c=
ontrol-skip-steps

This commit delays responding to brightness up/down keypresses by 100 m=
s and
if userspace in that time responds by changing the backlight itself, ca=
ncels
the kernels own handling of these keypresses, fixing the 2 steps issue.

[hdegoede@redhat.com: Move the delayed_work struct into struct
 acpi_video_device instead of having it as a global]
[hdegoede@redhat.com: Keep brightness_switch_enabled as a boolean and a=
lways
 delay the keypress handling]
Tested-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--

Changes in v2:
-Keep brightness_switch_enabled as a boolean and always delay the handl=
ing
---
 drivers/acpi/video.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1a450c9..18c0e69 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -204,6 +204,8 @@ struct acpi_video_device {
 	struct acpi_video_device_flags flags;
 	struct acpi_video_device_cap cap;
 	struct list_head entry;
+	struct delayed_work switch_brightness_work;
+	int switch_brightness_event;
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
@@ -230,8 +232,7 @@ static int acpi_video_device_lcd_get_level_current(
 			unsigned long long *level, bool raw);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
-static int acpi_video_switch_brightness(struct acpi_video_device *devi=
ce,
-					 int event);
+static void acpi_video_switch_brightness(struct work_struct *work);
=20
 static bool acpi_video_use_native_backlight(void)
 {
@@ -275,6 +276,7 @@ static int acpi_video_set_brightness(struct backlig=
ht_device *bd)
 	int request_level =3D bd->props.brightness + 2;
 	struct acpi_video_device *vd =3D bl_get_data(bd);
=20
+	cancel_delayed_work(&vd->switch_brightness_work);
 	return acpi_video_device_lcd_set_level(vd,
 				vd->brightness->levels[request_level]);
 }
@@ -1252,6 +1254,8 @@ acpi_video_bus_get_one_device(struct acpi_device =
*device,
 	data->device_id =3D device_id;
 	data->video =3D video;
 	data->dev =3D device;
+	INIT_DELAYED_WORK(&data->switch_brightness_work,
+			  acpi_video_switch_brightness);
=20
 	attribute =3D acpi_video_get_device_attr(video, device_id);
=20
@@ -1474,15 +1478,18 @@ acpi_video_get_next_level(struct acpi_video_dev=
ice *device,
 	}
 }
=20
-static int
-acpi_video_switch_brightness(struct acpi_video_device *device, int eve=
nt)
+static void
+acpi_video_switch_brightness(struct work_struct *work)
 {
+	struct acpi_video_device *device =3D container_of(to_delayed_work(wor=
k),
+			     struct acpi_video_device, switch_brightness_work);
 	unsigned long long level_current, level_next;
+	int event =3D device->switch_brightness_event;
 	int result =3D -EINVAL;
=20
 	/* no warning message if acpi_backlight=3Dvendor or a quirk is used *=
/
 	if (!acpi_video_verify_backlight_support())
-		return 0;
+		return;
=20
 	if (!device->brightness)
 		goto out;
@@ -1504,8 +1511,6 @@ acpi_video_switch_brightness(struct acpi_video_de=
vice *device, int event)
 out:
 	if (result)
 		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
-
-	return result;
 }
=20
 int acpi_video_get_edid(struct acpi_device *device, int type, int devi=
ce_id,
@@ -1673,6 +1678,16 @@ static void acpi_video_bus_notify(struct acpi_de=
vice *device, u32 event)
 	return;
 }
=20
+static void brightness_switch_event(struct acpi_video_device *video_de=
vice,
+				    u32 event)
+{
+	if (!brightness_switch_enabled)
+		return;
+
+	video_device->switch_brightness_event =3D event;
+	schedule_delayed_work(&video_device->switch_brightness_work, HZ / 10)=
;
+}
+
 static void acpi_video_device_notify(acpi_handle handle, u32 event, vo=
id *data)
 {
 	struct acpi_video_device *video_device =3D data;
@@ -1690,28 +1705,23 @@ static void acpi_video_device_notify(acpi_handl=
e handle, u32 event, void *data)
=20
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode =3D KEY_BRIGHTNESS_CYCLE;
 		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode =3D KEY_BRIGHTNESSUP;
 		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode =3D KEY_BRIGHTNESSDOWN;
 		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightness */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode =3D KEY_BRIGHTNESS_ZERO;
 		break;
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
-		if (brightness_switch_enabled)
-			acpi_video_switch_brightness(video_device, event);
+		brightness_switch_event(video_device, event);
 		keycode =3D KEY_DISPLAY_OFF;
 		break;
 	default:
--=20
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
