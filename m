From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: introduce module parameter auto_handle
Date: Wed, 29 Aug 2007 17:39:30 +0800
Message-ID: <1188380370.3082.121.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38399 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160AbXH2Jfa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Aug 2007 05:35:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, arjan@vger.kernel.org, "." <van.de.ven@intel.com>

Introduce a new module parameter "auto_handle" to enable/disable
handling hotkey events in ACPI video driver.

Now X can get the hotkey events via input layer and handle them
all by itself, e.g brightness up/down, video output switch, etc.

With this patch applied,
ACPI video driver can either handle the events itself or
do nothing but export them to userspace.
eg. the X people surely want to
"echo 0 > /sys/module/video/parameters/auto_handle" so that
they can take full charge of the video switch thing. :P

Note: auto_handle is disabled by default.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -71,6 +71,9 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
+static unsigned int auto_handle;
+module_param(auto_handle, uint, 0644);
+
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 
@@ -1781,31 +1784,39 @@ static void acpi_video_bus_notify(acpi_h
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
+		if (auto_handle)
+			acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
 					 * connector. */
-		acpi_video_device_enumerate(video);
-		acpi_video_device_rebind(video);
-		acpi_video_switch_output(video, event);
+
+		if (auto_handle) {
+			acpi_video_device_enumerate(video);
+			acpi_video_device_rebind(video);
+			acpi_video_switch_output(video, event);
+		}
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
-		acpi_video_switch_output(video, event);
+		if (auto_handle)
+			acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
-		acpi_video_switch_output(video, event);
+		if (auto_handle)
+			acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_VIDEO_NEXT;
 		break;
 	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output hotkey pressed. */
-		acpi_video_switch_output(video, event);
+		if (auto_handle)
+			acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_VIDEO_PREV;
 		break;
@@ -1842,22 +1853,26 @@ static void acpi_video_device_notify(acp
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
-		acpi_video_switch_brightness(video_device, event);
+		if (auto_handle)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESS_CYCLE;
 		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
-		acpi_video_switch_brightness(video_device, event);
+		if (auto_handle)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESSUP;
 		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
-		acpi_video_switch_brightness(video_device, event);
+		if (auto_handle)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESSDOWN;
 		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
-		acpi_video_switch_brightness(video_device, event);
+		if (auto_handle)
+			acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_BRIGHTNESS_ZERO;
 		break;
