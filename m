From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Reset ACPI backlight on resume
Date: Mon, 14 Jan 2008 03:13:05 +0000
Message-ID: <20080114031305.GA3111@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:46724 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYANDNM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2008 22:13:12 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

Some machines seem to need the backlight brightness to be reset on 
resume. Add support for doing so to the video module.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

---

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b8ce6dc..09a85eb 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -74,6 +74,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
+static int acpi_video_resume(struct acpi_device *device);
 
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
@@ -88,6 +89,7 @@ static struct acpi_driver acpi_video_bus = {
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
+		.resume = acpi_video_resume,
 		},
 };
 
@@ -1896,6 +1900,25 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
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
+	for (i=0; i<video->attached_count; i++) {
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

-- 
Matthew Garrett | mjg59@srcf.ucam.org
