From: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/25] ACPI video hotkey: export ACPI video hotkey events via input layer
Date: Fri, 24 Aug 2007 03:20:59 -0400
Message-ID: <11879400882727-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5825 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762791AbXHXHVa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:30 -0400
In-Reply-To: <11879400872911-git-send-email-len.brown@intel.com>
Message-Id: <745ce81328d09b1a5ebddacd1fffc20905d1cce3.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luming Yu <luming.yu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Luming Yu <luming.yu@intel.com>

Export ACPI video hotkey events via input layer.

Signed-off-by: Yu Luming <luming.yu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 88 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8efdea5..d727d2c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -31,7 +31,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-
+#include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/video_output.h>
 #include <asm/uaccess.h>
@@ -138,6 +138,8 @@ struct acpi_video_bus {
 	struct semaphore sem;
 	struct list_head video_device_list;
 	struct proc_dir_entry *dir;
+	struct input_dev *input;
+	char phys[32];	/* for input device */
 };
 
 struct acpi_video_device_flags {
@@ -1764,6 +1766,9 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_bus *video = data;
 	struct acpi_device *device = NULL;
+	struct input_dev *input;
+	int keycode;
+
 
 	printk("video bus notify\n");
 
@@ -1771,11 +1776,13 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 		return;
 
 	device = video->device;
+	input = video->input;
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
@@ -1784,21 +1791,37 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 		acpi_video_device_rebind(video);
 		acpi_video_switch_output(video, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_SWITCHVIDEOMODE;
+		break;
 	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_VIDEO_NEXT;
+		break;
 	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output hotkey pressed. */
 		acpi_video_switch_output(video, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_VIDEO_PREV;
 		break;
 
 	default:
+		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
 	return;
 }
 
@@ -1806,26 +1829,55 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_device *video_device = data;
 	struct acpi_device *device = NULL;
+	struct acpi_video_bus *bus;
+	struct input_dev *input;
+	int keycode;
 
 	if (!video_device)
 		return;
 
 	device = video_device->dev;
+	bus = video_device->video;
+	input = bus->input;
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_CYCLE;
+		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESSUP;
+		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESSDOWN;
+		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_ZERO;
+		break;
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
 		acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_DISPLAY_OFF;
 		break;
 	default:
+		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
+
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
 	return;
 }
 
@@ -1834,6 +1886,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
+	struct input_dev *input;
 
 
 	if (!device)
@@ -1877,6 +1930,39 @@ static int acpi_video_bus_add(struct acpi_device *device)
 		goto end;
 	}
 
+
+	video->input = input = input_allocate_device();
+
+	snprintf(video->phys, sizeof(video->phys),
+		"%s/video/input0", acpi_device_hid(video->device));
+
+	input->name = acpi_device_name(video->device);
+	input->phys = video->phys;
+	input->id.bustype = BUS_HOST;
+	input->id.product = 0x06;
+	input->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
+	set_bit(KEY_VIDEO_NEXT, input->keybit);
+	set_bit(KEY_VIDEO_PREV, input->keybit);
+	set_bit(KEY_BRIGHTNESS_CYCLE, input->keybit);
+	set_bit(KEY_BRIGHTNESSUP, input->keybit);
+	set_bit(KEY_BRIGHTNESSDOWN, input->keybit);
+	set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
+	set_bit(KEY_DISPLAY_OFF, input->keybit);
+	set_bit(KEY_UNKNOWN, input->keybit);
+	result = input_register_device(input);
+	if (result) {
+		acpi_remove_notify_handler(video->device->handle,
+						ACPI_DEVICE_NOTIFY,
+						acpi_video_bus_notify);
+		acpi_video_bus_stop_devices(video);
+		acpi_video_bus_put_devices(video);
+		kfree(video->attached_array);
+		acpi_video_bus_remove_fs(device);
+		goto end;
+        }
+
+
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
@@ -1910,6 +1996,7 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
 
+	input_unregister_device(video->input);
 	kfree(video->attached_array);
 	kfree(video);
 
-- 
1.5.3.rc6.17.g1911
