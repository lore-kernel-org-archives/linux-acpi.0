From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/4] ACPI: video: introduce new flag for enabling/disabling
	ACPI video actions upon brightness switch notifications
Date: Fri, 25 Jan 2008 14:47:49 +0800
Message-ID: <1201243669.4663.17.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32866 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYAYGrl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2008 01:47:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com

From: Zhang Rui <rui.zhang@intel.com>

Introduce new module parameter for brightness control.
"brightness_switch_enabled" is set by default which means
nothing changes upon brightness switch events.
When "brightness_switch_enabled" is cleared via
"echo 0 > /sys/module/video/parameters/brightness_switch_enabled",
ACPI will not try to change the brightness level any more.
Either X will take charge of this or users can change the brightness level
by poking /sys/class/backlight/acpi_videoX/...

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -72,6 +72,9 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
+static int brightness_switch_enabled = 1;
+module_param(brightness_switch_enabled, bool, 0644);
+
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 
@@ -1850,27 +1853,32 @@ static void acpi_video_device_notify(acp
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
-		acpi_video_switch_brightness(video_device, event);
+		if (brightness_switch_enabled)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESS_CYCLE;
 		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
-		acpi_video_switch_brightness(video_device, event);
+		if (brightness_switch_enabled)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESSUP;
 		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
-		acpi_video_switch_brightness(video_device, event);
+		if (brightness_switch_enabled)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESSDOWN;
 		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
-		acpi_video_switch_brightness(video_device, event);
+		if (brightness_switch_enabled)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESS_ZERO;
 		break;
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
-		acpi_video_switch_brightness(video_device, event);
+		if (brightness_switch_enabled)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_DISPLAY_OFF;
 		break;


