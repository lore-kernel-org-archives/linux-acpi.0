From: Len Brown <lenb@kernel.org>
Subject: [PATCH 052/112] ACPI: video: Rationalise ACPI backlight implementation
Date: Thu,  7 Feb 2008 04:34:14 -0500
Message-ID: <38531e6fe51ad5c7dfe72e0e066b5f54bc1921cd.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754908AbYBGJg1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:27 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The sysfs backlight class provides no mechanism for querying the
acceptable brightness for a backlight. The ACPI spec states that values
are only valid if they are reported as available by the firmware. Since
we can't provide that information to userspace, instead collapse the
range to the number of actual values that can be set.

http://bugzilla.kernel.org/show_bug.cgi?id=9277

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bd77e81..59639c9 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -292,18 +292,26 @@ static int acpi_video_device_set_state(struct acpi_video_device *device, int sta
 static int acpi_video_get_brightness(struct backlight_device *bd)
 {
 	unsigned long cur_level;
+	int i;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
 	acpi_video_device_lcd_get_level_current(vd, &cur_level);
-	return (int) cur_level;
+	for (i = 2; i < vd->brightness->count; i++) {
+		if (vd->brightness->levels[i] == cur_level)
+			/* The first two entries are special - see page 575
+			   of the ACPI spec 3.0 */
+			return i-2;
+	}
+	return 0;
 }
 
 static int acpi_video_set_brightness(struct backlight_device *bd)
 {
-	int request_level = bd->props.brightness;
+	int request_level = bd->props.brightness+2;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
-	acpi_video_device_lcd_set_level(vd, request_level);
+	acpi_video_device_lcd_set_level(vd,
+					vd->brightness->levels[request_level]);
 	return 0;
 }
 
@@ -652,7 +660,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 	kfree(obj);
 
 	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
-		unsigned long tmp;
 		static int count = 0;
 		char *name;
 		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
@@ -660,11 +667,10 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 			return;
 
 		sprintf(name, "acpi_video%d", count++);
-		acpi_video_device_lcd_get_level_current(device, &tmp);
 		device->backlight = backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
-		device->backlight->props.max_brightness = max_level;
-		device->backlight->props.brightness = (int)tmp;
+		device->backlight->props.max_brightness = device->brightness->count-3;
+		device->backlight->props.brightness = acpi_video_get_brightness(device->backlight);
 		backlight_update_status(device->backlight);
 
 		kfree(name);
-- 
1.5.4.23.gef5b9

