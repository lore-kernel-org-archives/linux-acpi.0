From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/4] ACPI: video: prevent ACPI video actions upon display
	switch notifications
Date: Fri, 25 Jan 2008 14:47:57 +0800
Message-ID: <1201243677.4663.18.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26233 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbYAYGrw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2008 01:47:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com

From: Zhang Rui <rui.zhang@intel.com>

Display switching via ACPI control methods are known to work on none
platform AFAIK.
And graphics people want to control the display switching all by themselves.
Prevent ACPI from handling display switch hotkey events in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   63 ---------------------------------------------------
 1 file changed, 63 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -276,7 +276,6 @@ static void acpi_video_device_rebind(str
 static void acpi_video_device_bind(struct acpi_video_bus *video,
 				   struct acpi_video_device *device);
 static int acpi_video_device_enumerate(struct acpi_video_bus *video);
-static int acpi_video_switch_output(struct acpi_video_bus *video, int event);
 static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
 			int level);
 static int acpi_video_device_lcd_get_level_current(
@@ -1583,64 +1582,6 @@ static int acpi_video_device_enumerate(s
 	return status;
 }
 
-/*
- *  Arg:
- *  	video	: video bus device 
- *  	event	: notify event
- *
- *  Return:
- *  	< 0	: error
- *  
- *	1. Find out the current active output device.
- *	2. Identify the next output device to switch to.
- *	3. call _DSS to do actual switch.
- */
-
-static int acpi_video_switch_output(struct acpi_video_bus *video, int event)
-{
-	struct list_head *node;
-	struct acpi_video_device *dev = NULL;
-	struct acpi_video_device *dev_next = NULL;
-	struct acpi_video_device *dev_prev = NULL;
-	unsigned long state;
-	int status = 0;
-
-	mutex_lock(&video->device_list_lock);
-
-	list_for_each(node, &video->video_device_list) {
-		dev = container_of(node, struct acpi_video_device, entry);
-		status = acpi_video_device_get_state(dev, &state);
-		if (state & 0x2) {
-			dev_next = container_of(node->next,
-					struct acpi_video_device, entry);
-			dev_prev = container_of(node->prev,
-					struct acpi_video_device, entry);
-			goto out;
-		}
-	}
-
-	dev_next = container_of(node->next, struct acpi_video_device, entry);
-	dev_prev = container_of(node->prev, struct acpi_video_device, entry);
-
- out:
-	mutex_unlock(&video->device_list_lock);
-
-	switch (event) {
-	case ACPI_VIDEO_NOTIFY_CYCLE:
-	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
-		acpi_video_device_set_state(dev, 0);
-		acpi_video_device_set_state(dev_next, 0x80000001);
-		break;
-	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:
-		acpi_video_device_set_state(dev, 0);
-		acpi_video_device_set_state(dev_prev, 0x80000001);
-	default:
-		break;
-	}
-
-	return status;
-}
-
 static int
 acpi_video_get_next_level(struct acpi_video_device *device,
 			  u32 level_current, u32 event)
@@ -1800,23 +1741,19 @@ static void acpi_video_bus_notify(acpi_h
 					 * connector. */
 		acpi_video_device_enumerate(video);
 		acpi_video_device_rebind(video);
-		acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
-		acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
-		acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_VIDEO_NEXT;
 		break;
 	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output hotkey pressed. */
-		acpi_video_switch_output(video, event);
 		acpi_bus_generate_proc_event(device, event, 0);
 		keycode = KEY_VIDEO_PREV;
 		break;


