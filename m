From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/12] ACPI: Don't send KEY_UNKNOWN for random video
 notifications
Date: Tue, 06 Apr 2010 03:06:19 -0400
Message-ID: <17c452f99cf5e073b219a069a419b7b8ab3cfa97.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:48943 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366Ab0DFHGq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:46 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G0094Y12T52U5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:34 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

I have a machine here that's sending 0xD1 notifications on the video
device once every second or so. I have no idea why (it's a prototype,
it may be broken), but sending KEY_UNKNOWN is unhelpful and results in
the console becoming unusable. Let's not report keys unless we have
something useful to say about them.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index cbe6f39..2c7ca7a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2122,7 +2122,7 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_video_bus *video = acpi_driver_data(device);
 	struct input_dev *input;
-	int keycode;
+	int keycode = 0;
 
 	if (!video)
 		return;
@@ -2158,17 +2158,19 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 		break;
 
 	default:
-		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
 	acpi_notifier_call_chain(device, event, 0);
-	input_report_key(input, keycode, 1);
-	input_sync(input);
-	input_report_key(input, keycode, 0);
-	input_sync(input);
+
+	if (keycode) {
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+	}
 
 	return;
 }
@@ -2179,7 +2181,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_device *device = NULL;
 	struct acpi_video_bus *bus;
 	struct input_dev *input;
-	int keycode;
+	int keycode = 0;
 
 	if (!video_device)
 		return;
@@ -2220,17 +2222,19 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 		keycode = KEY_DISPLAY_OFF;
 		break;
 	default:
-		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
 	acpi_notifier_call_chain(device, event, 0);
-	input_report_key(input, keycode, 1);
-	input_sync(input);
-	input_report_key(input, keycode, 0);
-	input_sync(input);
+
+	if (keycode) {
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+	}
 
 	return;
 }
@@ -2357,7 +2361,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	set_bit(KEY_BRIGHTNESSDOWN, input->keybit);
 	set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
 	set_bit(KEY_DISPLAY_OFF, input->keybit);
-	set_bit(KEY_UNKNOWN, input->keybit);
 
 	error = input_register_device(input);
 	if (error)
-- 
1.6.0.6

