From: akpm@linux-foundation.org
Subject: [patch 7/7] acpi backlight: reset brightness on resume
Date: Mon, 04 Feb 2008 23:31:24 -0800
Message-ID: <200802050731.m157V6TS009702@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46386 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752452AbYBEHcZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 02:32:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mjg59@srcf.ucam.org, rui.zhang@intel.com

From: Matthew Garrett <mjg59@srcf.ucam.org>

Some machines seem to need the backlight brightness to be reset on resume. 
Add support for doing so to the video module.

[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/video.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff -puN drivers/acpi/video.c~acpi-backlight-reset-brightness-on-resume drivers/acpi/video.c
--- a/drivers/acpi/video.c~acpi-backlight-reset-brightness-on-resume
+++ a/drivers/acpi/video.c
@@ -78,6 +78,7 @@ module_param(brightness_switch_enabled, 
 
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
+static int acpi_video_resume(struct acpi_device *device);
 
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
@@ -92,6 +93,7 @@ static struct acpi_driver acpi_video_bus
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
+		.resume = acpi_video_resume,
 		},
 };
 
@@ -1948,6 +1950,25 @@ static void acpi_video_device_notify(acp
 }
 
 static int instance;
+static int acpi_video_resume(struct acpi_device *device)
+{
+	struct acpi_video_bus *video;
+	struct acpi_video_device *video_device;
+	int i;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	video = acpi_driver_data(device);
+
+	for (i = 0; i < video->attached_count; i++) {
+		video_device = video->attached_array[i].bind_info;
+		if (video_device && video_device->backlight)
+			acpi_video_set_brightness(video_device->backlight);
+	}
+	return AE_OK;
+}
+
 static int acpi_video_bus_add(struct acpi_device *device)
 {
 	acpi_status status;
_
