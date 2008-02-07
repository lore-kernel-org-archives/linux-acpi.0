From: Len Brown <lenb@kernel.org>
Subject: [PATCH 098/112] ACPI: video: delete unused display switch on hotkey event code
Date: Thu,  7 Feb 2008 04:35:00 -0500
Message-ID: <ba5e1223422368fd2f4dbb0745f5fbb5fe9a65f1.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758442AbYBGJgz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:55 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Display switching via ACPI control methods are
not known to work on any platforms.

Further, the X community wants to control the display
switching all by themselves without BIOS/AML involvement.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   63 --------------------------------------------------
 1 files changed, 0 insertions(+), 63 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b1a56bf..d4b4b52 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -276,7 +276,6 @@ static void acpi_video_device_rebind(struct acpi_video_bus *video);
 static void acpi_video_device_bind(struct acpi_video_bus *video,
 				   struct acpi_video_device *device);
 static int acpi_video_device_enumerate(struct acpi_video_bus *video);
-static int acpi_video_switch_output(struct acpi_video_bus *video, int event);
 static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
 			int level);
 static int acpi_video_device_lcd_get_level_current(
@@ -1583,64 +1582,6 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
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
@@ -1800,23 +1741,19 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
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
-- 
1.5.4.23.gef5b9

