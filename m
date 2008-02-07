From: Len Brown <lenb@kernel.org>
Subject: [PATCH 097/112] ACPI: video: create "brightness_switch_enabled" modparam
Date: Thu,  7 Feb 2008 04:34:59 -0500
Message-ID: <8a681a4dee07ea09aedaadc6a2da28d2131dc414.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755883AbYBGJgz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:55 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bd77e81..b1a56bf 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -72,6 +72,9 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
+static int brightness_switch_enabled = 1;
+module_param(brightness_switch_enabled, bool, 0644);
+
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 
@@ -1850,27 +1853,32 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 
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
-- 
1.5.4.23.gef5b9

