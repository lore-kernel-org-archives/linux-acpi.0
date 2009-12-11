From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] acpi: Don't send KEY_UNKNOWN for random video notifications
Date: Fri, 11 Dec 2009 17:40:46 -0500
Message-ID: <1260571246-24582-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56707 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761406AbZLKWk6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 17:40:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

I have a machine here that's sending 0xD1 notifications on the video
device once every second or so. I have no idea why (it's a prototype,
it may be broken), but sending KEY_UNKNOWN is unhelpful and results in
the console becoming unusable. Let's not report keys unless we have
something useful to say about them.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 05dff63..655183c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2100,7 +2100,7 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_video_bus *video = acpi_driver_data(device);
 	struct input_dev *input;
-	int keycode;
+	int keycode = 0;
 
 	if (!video)
 		return;
@@ -2136,17 +2136,19 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
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
@@ -2157,7 +2159,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_device *device = NULL;
 	struct acpi_video_bus *bus;
 	struct input_dev *input;
-	int keycode;
+	int keycode = 0;
 
 	if (!video_device)
 		return;
@@ -2198,17 +2200,19 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
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
@@ -2299,7 +2303,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	set_bit(KEY_BRIGHTNESSDOWN, input->keybit);
 	set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
 	set_bit(KEY_DISPLAY_OFF, input->keybit);
-	set_bit(KEY_UNKNOWN, input->keybit);
 
 	error = input_register_device(input);
 	if (error)
-- 
1.6.5.2

